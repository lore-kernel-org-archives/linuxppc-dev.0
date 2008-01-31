Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 2A141DE000
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 06:58:34 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so203639anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 11:58:33 -0800 (PST)
Message-ID: <fa686aa40801311158u470981e9o6862767dea881f4b@mail.gmail.com>
Date: Thu, 31 Jan 2008 12:58:32 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [POWERPC] Xilinx: hwicap driver
In-Reply-To: <20080131184722.B5E1C1A600C4@mail138-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <871wa1xrhc.fsf@macbook.be.48ers.dk>
	<20080131184722.B5E1C1A600C4@mail138-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/31/08, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
> This includes code for new fifo-based xps_hwicap in addition to the
> older opb_hwicap, which has a significantly different interface.  The
> common code between the two drivers is largely shared.
>
> Significant differences exists between this driver and what is
> supported in the EDK drivers.  In particular, most of the
> architecture-specific code for reconfiguring individual FPGA resources
> has been removed.  This functionality is likely better provided in a
> user-space support library.  In addition, read and write access is
> supported.  In addition, although the xps_hwicap cores support
> interrupt-driver mode, this driver only supports polled operation, in
> order to make the code simpler, and since the interrupt processing
> overhead is likely to slow down the throughput under Linux.
>
> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Comments below...

Also, I'm not sure if drivers/char/xilinx_hwicap is the best place for
this driver.  drivers/misc/ might be better (but I'm not sure; poll
other people on this)

Finally, buffer_icap and fifo_icap are not huge blocks of code.  Will
they be used by any other drivers?  Can they be rolled into the
xilinx_hwicap.c file?

> +static int buffer_icap_device_read(struct hwicap_drvdata *drvdata,
> +               u32 offset, u32 count)
> +{
> +
> +       s32 retries = 0;
> +       void __iomem *base_address = drvdata->base_address;
> +
> +       if (buffer_icap_busy(base_address))
> +               return -EBUSY;
> +
> +       if ((offset + count) <= XHI_MAX_BUFFER_INTS) {
> +               /* setSize count*4 to get bytes. */
> +               buffer_icap_set_size(base_address, (count << 2));
> +               buffer_icap_set_offset(base_address, offset);
> +               buffer_icap_set_rnc(base_address, XHI_READBACK);
> +
> +               while (buffer_icap_busy(base_address)) {
> +                       retries++;
> +                       if (retries > XHI_MAX_RETRIES)
> +                               return -EBUSY;
> +               }
> +       } else {
> +               return -EINVAL;
> +       }

Style comment: reverse the condition and bail with return -EINVAL at
the test point.  It will simplify the code and better match with
common practice in the kernel.

> +       return 0;
> +
> +};
> +
> +/**
> + * buffer_icap_device_write: Transfer bytes from ICAP to the storage buffer.
> + * @parameter drvdata: a pointer to the drvdata.
> + * @parameter offset: The storage buffer start address.
> + * @parameter count: The number of words (32 bit) to read from the
> + *           device (ICAP).
> + **/
> +static int buffer_icap_device_write(struct hwicap_drvdata *drvdata,
> +               u32 offset, u32 count)
> +{
> +
> +       s32 retries = 0;
> +       void __iomem *base_address = drvdata->base_address;
> +
> +       if (buffer_icap_busy(base_address))
> +               return -EBUSY;
> +
> +       if ((offset + count) <= XHI_MAX_BUFFER_INTS) {
> +               /* setSize count*4 to get bytes. */
> +               buffer_icap_set_size(base_address, count << 2);
> +               buffer_icap_set_offset(base_address, offset);
> +               buffer_icap_set_rnc(base_address, XHI_CONFIGURE);
> +
> +               while (buffer_icap_busy(base_address)) {
> +                       retries++;
> +                       if (retries > XHI_MAX_RETRIES)
> +                               return -EBUSY;
> +               }
> +       } else {
> +               return -EINVAL;
> +       }

Ditto

> +/**
> + * buffer_icap_set_configuration: Load a partial bitstream from system memory.
> + * @parameter drvdata: a pointer to the drvdata.
> + * @parameter data: Kernel address of the partial bitstream.
> + * @parameter size: the size of the partial bitstream in 32 bit words.
> + **/
> +int buffer_icap_set_configuration(struct hwicap_drvdata *drvdata, u32 *data,
> +                            u32 size)
> +{
> +       int status;
> +       s32 buffer_count = 0;
> +       s32 num_writes = 0;
> +       bool dirty = 0;
> +       u32 i;
> +       void __iomem *base_address = drvdata->base_address;
> +
> +       /* Loop through all the data */
> +       for (i = 0, buffer_count = 0; i < size; i++) {
> +
> +               /* Copy data to bram */
> +               buffer_icap_set_bram(base_address, buffer_count, data[i]);
> +               dirty = 1;
> +
> +               if (buffer_count == XHI_MAX_BUFFER_INTS - 1) {
> +                       /* Write data to ICAP */
> +                       status = buffer_icap_device_write(
> +                                       drvdata,
> +                                       XHI_BUFFER_START,
> +                                       XHI_MAX_BUFFER_INTS);
> +                       if (status != 0) {
> +                               /* abort. */
> +                               buffer_icap_reset(drvdata);
> +                               return status;
> +                       }
> +
> +                       buffer_count = 0;
> +                       num_writes++;
> +                       dirty = 0;
> +               } else {
> +                       buffer_count++;
> +               }

Nit: Consider reversing the test condition and using 'buffer_count++; continue'

> +static ssize_t
> +hwicap_read(struct file *file, char *buf, size_t count, loff_t *ppos)
> +{
> +       struct hwicap_drvdata *drvdata = file->private_data;
> +       ssize_t bytes_to_read = 0;
> +       u32 *kbuf;
> +       u32 words;
> +       u32 bytes_remaining;
> +       int status;
> +
> +       if (drvdata->is_accessing)
> +               return -EBUSY;
> +
> +       drvdata->is_accessing = 1;

Race condition, you need to use a semaphore.  Otherwise it is possible
to get two processes (or even two threads of the same process) in the
read() hook.

> +static int hwicap_open(struct inode *inode, struct file *file)
> +{
> +       struct hwicap_drvdata *drvdata;
> +       int status;
> +
> +       drvdata = container_of(inode->i_cdev, struct hwicap_drvdata, cdev);
> +       if (drvdata->is_open)
> +               return -EBUSY;
> +
> +       drvdata->is_open = 1;

Also a race condition.  Use a semaphore.

Also, this isn't sufficient to prevent 2 processes from having the
device open.  If a process has already opened it and then calls
fork(), then *both* processes will have it opened even though the open
fop was only called once.  (It might not matter for this particular
driver as the use case is limited; but it is something you should be
aware of.)

> +static int __devinit hwicap_setup(struct device *dev, int id,
> +               const struct resource *regs_res,
> +               const struct hwicap_driver_config *config,
> +               const struct config_registers *config_regs)
> +{
> +       dev_t devt;
> +       struct hwicap_drvdata *drvdata = NULL;
> +       int retval = 0;
> +
> +       dev_info(dev, "Xilinx icap port driver\n");
> +
> +       if (id < 0) {
> +               for (id = 0; id < HWICAP_DEVICES; id++)
> +                       if (!probed_devices[id])
> +                               break;
> +       }
> +       if (id < 0 || id >= HWICAP_DEVICES) {
> +               dev_err(dev, "%s%i too large\n", DRIVER_NAME, id);
> +               return -EINVAL;
> +       }
> +       if (probed_devices[id]) {
> +               dev_err(dev, "cannot assign to %s%i; it is already in use\n",
> +                       DRIVER_NAME, id);
> +               return -EBUSY;
> +       }
> +
> +       probed_devices[id] = 1;

Hmmm, I'm not thrilled with the fixed array of HWICAP devices.  That
sort of thing just ends up causing headaches down the road.  Can the
driver just allocate a new structure and the next available ID at
probe time?  (I hold my nose every time I write something like the
above because I know I'm going to regret it later).  sysfs/udev can
provide details about which one is which.

> +
> +static int __devexit hwicap_remove(struct device *dev)
> +{
> +       struct hwicap_drvdata *drvdata;
> +
> +       drvdata = (struct hwicap_drvdata *)dev_get_drvdata(dev);
> +
> +       if (drvdata) {

if (!drvdata)
    return 0;

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
