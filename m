Message-Id: <200206080845.g588jvX11858@fachschaft.cup.uni-muenchen.de>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Roland Dreier <roland@topspin.com>,
	linuxppc-embedded@lists.linuxppc.org,
	linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] USB on PPC440GP (cache incoherent)
Date: Sat, 8 Jun 2002 10:47:27 +0200
References: <52hekebq2a.fsf@topspin.com>
In-Reply-To: <52hekebq2a.fsf@topspin.com>
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

the basic idea is sound, but ...

> # This is a BitKeeper generated patch for the following project:
> # Project Name: Linux 2.4 for PowerPC development tree
> # This patch format is intended for GNU patch command version 2.5 or
> higher. # This patch includes the following deltas:
> #	           ChangeSet	1.1077  -> 1.1078
> #	   drivers/usb/usb.c	1.19    -> 1.20
> #	   drivers/usb/hub.c	1.14    -> 1.15
> #	   drivers/usb/hub.h	1.7     -> 1.8
> #	drivers/usb/storage/transport.c	1.10    -> 1.11
> #
> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 02/06/07	roland@gold.topspincom.com	1.1078
> # Fix problems in USB when running on cache-incoherent cpus like PPC440GP
> # (Don't do DMAs into memory allocated on stack)
> # --------------------------------------------
> #


> @@ -995,7 +1023,7 @@
>  int usb_reset_device(struct usb_device *dev)
>  {
>  	struct usb_device *parent = dev->parent;
> -	struct usb_device_descriptor descriptor;
> +	struct usb_device_descriptor *descriptor;
>  	int i, ret, port = -1;
>
>  	if (!parent) {
> @@ -1044,17 +1072,19 @@
>  	 * If nothing changed, we reprogram the configuration and then
>  	 * the alternate settings.
>  	 */
> -	ret = usb_get_descriptor(dev, USB_DT_DEVICE, 0, &descriptor,
> -			sizeof(descriptor));
> +        descriptor = kmalloc(sizeof *descriptor, GFP_KERNEL);

This can be used in error handling by storage devices. You must use GFP_NOIO.
And you should check for a failure due to OOM.

> +	ret = usb_get_descriptor(dev, USB_DT_DEVICE, 0, descriptor,
> +                                 sizeof *descriptor);
>  	if (ret < 0)
>  		return ret;
>
> -	le16_to_cpus(&descriptor.bcdUSB);
> -	le16_to_cpus(&descriptor.idVendor);
> -	le16_to_cpus(&descriptor.idProduct);
> -	le16_to_cpus(&descriptor.bcdDevice);
> +	le16_to_cpus(&descriptor->bcdUSB);
> +	le16_to_cpus(&descriptor->idVendor);
> +	le16_to_cpus(&descriptor->idProduct);
> +	le16_to_cpus(&descriptor->bcdDevice);
>
> -	if (memcmp(&dev->descriptor, &descriptor, sizeof(descriptor))) {
> +	if (memcmp(&dev->descriptor, descriptor, sizeof *descriptor)) {
> +                kfree(descriptor);
>  		usb_destroy_configuration(dev);
>
>  		ret = usb_get_device_descriptor(dev);


> diff -Nru a/drivers/usb/storage/transport.c
> b/drivers/usb/storage/transport.c --- a/drivers/usb/storage/transport.c	Fri
> Jun  7 16:35:31 2002
> +++ b/drivers/usb/storage/transport.c	Fri Jun  7 16:35:31 2002
> @@ -723,7 +723,7 @@
>
>  		/* use the new buffer we have */
>  		old_request_buffer = srb->request_buffer;
> -		srb->request_buffer = srb->sense_buffer;
> +		srb->request_buffer = kmalloc(18, in_interrupt() ? GFP_ATOMIC :
> GFP_KERNEL);

Must be "? GFP_ATOMIC : GFP_NOIO" or you could deadlock.
However, why do you do this ? The srb is kmalloced.

>  		/* set the buffer length for transfer */
>  		old_request_bufflen = srb->request_bufflen;


> @@ -1077,41 +1088,54 @@
>
>  int usb_stor_Bulk_transport(Scsi_Cmnd *srb, struct us_data *us)
>  {
> -	struct bulk_cb_wrap bcb;
> -	struct bulk_cs_wrap bcs;
> +	struct bulk_cb_wrap *bcb;
> +	struct bulk_cs_wrap *bcs;
>  	int result;
>  	int pipe;
>  	int partial;
> +        int ret = USB_STOR_TRANSPORT_ERROR;
> +
> +        bcb = kmalloc(sizeof *bcb, in_interrupt() ? GFP_ATOMIC :
> GFP_KERNEL); +        if (!bcb) {
> +                return USB_STOR_TRANSPORT_ERROR;
> +        }
> +        bcs = kmalloc(sizeof *bcs, in_interrupt() ? GFP_ATOMIC :
> GFP_KERNEL); +        if (!bcs) {

Here again you cannot use GFP_KERNEL. It must be GFP_NOIO instead.

> +                kfree(bcb);
> +                return USB_STOR_TRANSPORT_ERROR;
> +        }
>
>  	/* set up the command wrapper */
> -	bcb.Signature = cpu_to_le32(US_BULK_CB_SIGN);
> -	bcb.DataTransferLength = cpu_to_le32(usb_stor_transfer_length(srb));
> -	bcb.Flags = srb->sc_data_direction == SCSI_DATA_READ ? 1 << 7 : 0;
> -	bcb.Tag = srb->serial_number;
> -	bcb.Lun = srb->cmnd[1] >> 5;
> +	bcb->Signature = cpu_to_le32(US_BULK_CB_SIGN);
> +	bcb->DataTransferLength = cpu_to_le32(usb_stor_transfer_length(srb));
> +	bcb->Flags = srb->sc_data_direction == SCSI_DATA_READ ? 1 << 7 : 0;
> +	bcb->Tag = srb->serial_number;
> +	bcb->Lun = srb->cmnd[1] >> 5;
>  	if (us->flags & US_FL_SCM_MULT_TARG)
> -		bcb.Lun |= srb->target << 4;
> -	bcb.Length = srb->cmd_len;
> +		bcb->Lun |= srb->target << 4;
> +	bcb->Length = srb->cmd_len;
>
>  	/* construct the pipe handle */
>  	pipe = usb_sndbulkpipe(us->pusb_dev, us->ep_out);
>
>  	/* copy the command payload */
> -	memset(bcb.CDB, 0, sizeof(bcb.CDB));
> -	memcpy(bcb.CDB, srb->cmnd, bcb.Length);
> +	memset(bcb->CDB, 0, sizeof(bcb->CDB));
> +	memcpy(bcb->CDB, srb->cmnd, bcb->Length);
>
>  	/* send it to out endpoint */
>  	US_DEBUGP("Bulk command S 0x%x T 0x%x Trg %d LUN %d L %d F %d CL %d\n",
> -		  le32_to_cpu(bcb.Signature), bcb.Tag,
> -		  (bcb.Lun >> 4), (bcb.Lun & 0x0F),
> -		  bcb.DataTransferLength, bcb.Flags, bcb.Length);
> -	result = usb_stor_bulk_msg(us, &bcb, pipe, US_BULK_CB_WRAP_LEN,
> +		  le32_to_cpu(bcb->Signature), bcb->Tag,
> +		  (bcb->Lun >> 4), (bcb->Lun & 0x0F),
> +		  bcb->DataTransferLength, bcb->Flags, bcb->Length);
> +	result = usb_stor_bulk_msg(us, bcb, pipe, US_BULK_CB_WRAP_LEN,
>  				   &partial);
>  	US_DEBUGP("Bulk command transfer result=%d\n", result);
>
>  	/* if the command was aborted, indicate that */
> -	if (result == -ENOENT)
> -		return USB_STOR_TRANSPORT_ABORTED;
> +	if (result == -ENOENT) {
> +                ret = USB_STOR_TRANSPORT_ABORTED;
> +                goto out;
> +        }
>
>  	/* if we stall, we need to clear it before we go on */
>  	if (result == -EPIPE) {


> diff -Nru a/drivers/usb/usb.c b/drivers/usb/usb.c
> --- a/drivers/usb/usb.c	Fri Jun  7 16:35:31 2002
> +++ b/drivers/usb/usb.c	Fri Jun  7 16:35:31 2002
> @@ -1787,16 +1787,23 @@
>  {
>  	int i = 5;
>  	int result;
> +        void *tmp_buf;
>
> -	memset(buf,0,size);	// Make sure we parse really received data
> +        tmp_buf = kmalloc(size, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);

usb_control_msg is used. This cannot be called in interrupt.

> +        if (!tmp_buf) {
> +          return -ENOMEM;
> +        }
> +	memset(tmp_buf,0,size);	// Make sure we parse really received data
>
>  	while (i--) {
>  		if ((result = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
>  			USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
> -			(type << 8) + index, 0, buf, size, HZ * GET_TIMEOUT)) > 0 ||
> +			(type << 8) + index, 0, tmp_buf, size, HZ * GET_TIMEOUT)) > 0 ||
>  		     result == -EPIPE)
>  			break;	/* retry if the returned length was 0; flaky device */
>  	}
> +        memcpy(buf, tmp_buf, size);
> +        kfree(tmp_buf);
>  	return result;
>  }

	HTH
		Oliver

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
