Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Fix ibmvscsi client for multiplatform iSeries+pSeries
	kernel.
From: Michael Ellerman <michael@ellerman.id.au>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1185374509.14697.384.camel@pmac.infradead.org>
References: <1185374509.14697.384.camel@pmac.infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-7DSw57SNeoQ9+/MYmfBI"
Date: Thu, 26 Jul 2007 11:27:55 +1000
Message-Id: <1185413275.25216.2.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-7DSw57SNeoQ9+/MYmfBI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-07-25 at 15:41 +0100, David Woodhouse wrote:
> If you build a multiplatform kernel for iSeries and pSeries, with
> ibmvscsic support, the resulting client doesn't work on iSeries.
>=20
> This patch should fix that, using the appropriate low-level operations
> for the machine detected at runtime.
>=20
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>

Nice that someone finally fixed this up.

But I get:

drivers/scsi/ibmvscsi/ibmvscsi.c:1651: error: 'FW_FEATURE_ISERIES' undeclar=
ed (first use in this function)
drivers/scsi/ibmvscsi/ibmvscsi.c:1651: error: (Each undeclared identifier i=
s reported only once
drivers/scsi/ibmvscsi/ibmvscsi.c:1651: error: for each function it appears =
in.)
drivers/scsi/ibmvscsi/ibmvscsi.c:1653: error: 'FW_FEATURE_VIO' undeclared (=
first use in this function)

Missing <asm/firmware.h> ?

cheers


> --- linux-2.6.19.ppc64/drivers/scsi/ibmvscsi/rpa_vscsi.c~	2006-11-29 21:5=
7:37.000000000 +0000
> +++ linux-2.6.19.ppc64/drivers/scsi/ibmvscsi/rpa_vscsi.c	2006-12-19 15:42=
:57.000000000 +0000
> @@ -42,14 +42,14 @@ static unsigned int partition_number =3D -
>   * Routines for managing the command/response queue
>   */
>  /**
> - * ibmvscsi_handle_event: - Interrupt handler for crq events
> + * rpavscsi_handle_event: - Interrupt handler for crq events
>   * @irq:	number of irq to handle, not used
>   * @dev_instance: ibmvscsi_host_data of host that received interrupt
>   *
>   * Disables interrupts and schedules srp_task
>   * Always returns IRQ_HANDLED
>   */
> -static irqreturn_t ibmvscsi_handle_event(int irq, void *dev_instance)
> +static irqreturn_t rpavscsi_handle_event(int irq, void *dev_instance)
>  {
>  	struct ibmvscsi_host_data *hostdata =3D
>  	    (struct ibmvscsi_host_data *)dev_instance;
> @@ -66,9 +66,9 @@ static irqreturn_t ibmvscsi_handle_event
>   * Frees irq, deallocates a page for messages, unmaps dma, and unregiste=
rs
>   * the crq with the hypervisor.
>   */
> -void ibmvscsi_release_crq_queue(struct crq_queue *queue,
> -				struct ibmvscsi_host_data *hostdata,
> -				int max_requests)
> +static void rpavscsi_release_crq_queue(struct crq_queue *queue,
> +				       struct ibmvscsi_host_data *hostdata,
> +				       int max_requests)
>  {
>  	long rc;
>  	struct vio_dev *vdev =3D to_vio_dev(hostdata->dev);
> @@ -108,12 +108,13 @@ static struct viosrp_crq *crq_queue_next
>  }
> =20
>  /**
> - * ibmvscsi_send_crq: - Send a CRQ
> + * rpavscsi_send_crq: - Send a CRQ
>   * @hostdata:	the adapter
>   * @word1:	the first 64 bits of the data
>   * @word2:	the second 64 bits of the data
>   */
> -int ibmvscsi_send_crq(struct ibmvscsi_host_data *hostdata, u64 word1, u6=
4 word2)
> +static int rpavscsi_send_crq(struct ibmvscsi_host_data *hostdata,
> +			     u64 word1, u64 word2)
>  {
>  	struct vio_dev *vdev =3D to_vio_dev(hostdata->dev);
> =20
> @@ -121,10 +122,10 @@ int ibmvscsi_send_crq(struct ibmvscsi_ho
>  }
> =20
>  /**
> - * ibmvscsi_task: - Process srps asynchronously
> + * rpavscsi_task: - Process srps asynchronously
>   * @data:	ibmvscsi_host_data of host
>   */
> -static void ibmvscsi_task(void *data)
> +static void rpavscsi_task(void *data)
>  {
>  	struct ibmvscsi_host_data *hostdata =3D (struct ibmvscsi_host_data *)da=
ta;
>  	struct vio_dev *vdev =3D to_vio_dev(hostdata->dev);
> @@ -189,6 +190,42 @@ static void set_adapter_info(struct ibmv
>  }
> =20
>  /**
> + * reset_crq_queue: - resets a crq after a failure
> + * @queue:	crq_queue to initialize and register
> + * @hostdata:	ibmvscsi_host_data of host
> + *
> + */
> +static int rpavscsi_reset_crq_queue(struct crq_queue *queue,
> +				    struct ibmvscsi_host_data *hostdata)
> +{
> +	int rc;
> +	struct vio_dev *vdev =3D to_vio_dev(hostdata->dev);
> +
> +	/* Close the CRQ */
> +	do {
> +		rc =3D plpar_hcall_norets(H_FREE_CRQ, vdev->unit_address);
> +	} while ((rc =3D=3D H_BUSY) || (H_IS_LONG_BUSY(rc)));
> +
> +	/* Clean out the queue */
> +	memset(queue->msgs, 0x00, PAGE_SIZE);
> +	queue->cur =3D 0;
> +
> +	set_adapter_info(hostdata);
> +
> +	/* And re-open it again */
> +	rc =3D plpar_hcall_norets(H_REG_CRQ,
> +				vdev->unit_address,
> +				queue->msg_token, PAGE_SIZE);
> +	if (rc =3D=3D 2) {
> +		/* Adapter is good, but other end is not ready */
> +		printk(KERN_WARNING "ibmvscsi: Partner adapter not ready\n");
> +	} else if (rc !=3D 0) {
> +		printk(KERN_WARNING
> +		       "ibmvscsi: couldn't register crq--rc 0x%x\n", rc);
> +	}
> +	return rc;
> +}
> +/**
>   * initialize_crq_queue: - Initializes and registers CRQ with hypervisor
>   * @queue:	crq_queue to initialize and register
>   * @hostdata:	ibmvscsi_host_data of host
> @@ -197,9 +234,9 @@ static void set_adapter_info(struct ibmv
>   * the crq with the hypervisor.
>   * Returns zero on success.
>   */
> -int ibmvscsi_init_crq_queue(struct crq_queue *queue,
> -			    struct ibmvscsi_host_data *hostdata,
> -			    int max_requests)
> +static int rpavscsi_init_crq_queue(struct crq_queue *queue,
> +				   struct ibmvscsi_host_data *hostdata,
> +				   int max_requests)
>  {
>  	int rc;
>  	int retrc;
> @@ -226,7 +263,7 @@ int ibmvscsi_init_crq_queue(struct crq_q
>  				queue->msg_token, PAGE_SIZE);
>  	if (rc =3D=3D H_RESOURCE)
>  		/* maybe kexecing and resource is busy. try a reset */
> -		rc =3D ibmvscsi_reset_crq_queue(queue,
> +		rc =3D rpavscsi_reset_crq_queue(queue,
>  					      hostdata);
> =20
>  	if (rc =3D=3D 2) {
> @@ -239,7 +276,7 @@ int ibmvscsi_init_crq_queue(struct crq_q
>  	}
> =20
>  	if (request_irq(vdev->irq,
> -			ibmvscsi_handle_event,
> +			rpavscsi_handle_event,
>  			0, "ibmvscsi", (void *)hostdata) !=3D 0) {
>  		printk(KERN_ERR "ibmvscsi: couldn't register irq 0x%x\n",
>  		       vdev->irq);
> @@ -256,7 +293,7 @@ int ibmvscsi_init_crq_queue(struct crq_q
>  	queue->cur =3D 0;
>  	spin_lock_init(&queue->lock);
> =20
> -	tasklet_init(&hostdata->srp_task, (void *)ibmvscsi_task,
> +	tasklet_init(&hostdata->srp_task, (void *)rpavscsi_task,
>  		     (unsigned long)hostdata);
> =20
>  	return retrc;
> @@ -281,8 +318,8 @@ int ibmvscsi_init_crq_queue(struct crq_q
>   * @hostdata:	ibmvscsi_host_data of host
>   *
>   */
> -int ibmvscsi_reenable_crq_queue(struct crq_queue *queue,
> -				 struct ibmvscsi_host_data *hostdata)
> +static int rpavscsi_reenable_crq_queue(struct crq_queue *queue,
> +				       struct ibmvscsi_host_data *hostdata)
>  {
>  	int rc;
>  	struct vio_dev *vdev =3D to_vio_dev(hostdata->dev);
> @@ -297,39 +334,10 @@ int ibmvscsi_reenable_crq_queue(struct c
>  	return rc;
>  }
> =20
> -/**
> - * reset_crq_queue: - resets a crq after a failure
> - * @queue:	crq_queue to initialize and register
> - * @hostdata:	ibmvscsi_host_data of host
> - *
> - */
> -int ibmvscsi_reset_crq_queue(struct crq_queue *queue,
> -			      struct ibmvscsi_host_data *hostdata)
> -{
> -	int rc;
> -	struct vio_dev *vdev =3D to_vio_dev(hostdata->dev);
> -
> -	/* Close the CRQ */
> -	do {
> -		rc =3D plpar_hcall_norets(H_FREE_CRQ, vdev->unit_address);
> -	} while ((rc =3D=3D H_BUSY) || (H_IS_LONG_BUSY(rc)));
> -
> -	/* Clean out the queue */
> -	memset(queue->msgs, 0x00, PAGE_SIZE);
> -	queue->cur =3D 0;
> -
> -	set_adapter_info(hostdata);
> -
> -	/* And re-open it again */
> -	rc =3D plpar_hcall_norets(H_REG_CRQ,
> -				vdev->unit_address,
> -				queue->msg_token, PAGE_SIZE);
> -	if (rc =3D=3D 2) {
> -		/* Adapter is good, but other end is not ready */
> -		printk(KERN_WARNING "ibmvscsi: Partner adapter not ready\n");
> -	} else if (rc !=3D 0) {
> -		printk(KERN_WARNING
> -		       "ibmvscsi: couldn't register crq--rc 0x%x\n", rc);
> -	}
> -	return rc;
> -}
> +struct ibmvscsi_ops rpavscsi_ops =3D {
> +	.init_crq_queue =3D rpavscsi_init_crq_queue,
> +	.release_crq_queue =3D rpavscsi_release_crq_queue,
> +	.reset_crq_queue =3D rpavscsi_reset_crq_queue,
> +	.reenable_crq_queue =3D rpavscsi_reenable_crq_queue,
> +	.send_crq =3D rpavscsi_send_crq,
> +};
> --- linux-2.6.19.ppc64/drivers/scsi/ibmvscsi/ibmvscsi.c~	2006-11-29 21:57=
:37.000000000 +0000
> +++ linux-2.6.19.ppc64/drivers/scsi/ibmvscsi/ibmvscsi.c	2006-12-19 15:53:=
59.000000000 +0000
> @@ -89,6 +89,8 @@ static int max_requests =3D 50;
> =20
>  #define IBMVSCSI_VERSION "1.5.8"
> =20
> +static struct ibmvscsi_ops *ibmvscsi_ops;
> +
>  MODULE_DESCRIPTION("IBM Virtual SCSI");
>  MODULE_AUTHOR("Dave Boutcher");
>  MODULE_LICENSE("GPL");
> @@ -567,7 +569,7 @@ static int ibmvscsi_send_srp_event(struc
>  	list_add_tail(&evt_struct->list, &hostdata->sent);
> =20
>  	if ((rc =3D
> -	     ibmvscsi_send_crq(hostdata, crq_as_u64[0], crq_as_u64[1])) !=3D 0)=
 {
> +	     ibmvscsi_ops->send_crq(hostdata, crq_as_u64[0], crq_as_u64[1])) !=
=3D 0) {
>  		list_del(&evt_struct->list);
> =20
>  		printk(KERN_ERR "ibmvscsi: send error %d\n",
> @@ -1183,8 +1185,8 @@ void ibmvscsi_handle_crq(struct viosrp_c
>  		case 0x01:	/* Initialization message */
>  			printk(KERN_INFO "ibmvscsi: partner initialized\n");
>  			/* Send back a response */
> -			if (ibmvscsi_send_crq(hostdata,
> -					      0xC002000000000000LL, 0) =3D=3D 0) {
> +			if (ibmvscsi_ops->send_crq(hostdata,
> +						   0xC002000000000000LL, 0) =3D=3D 0) {
>  				/* Now login */
>  				send_srp_login(hostdata);
>  			} else {
> @@ -1212,10 +1214,10 @@ void ibmvscsi_handle_crq(struct viosrp_c
>  			printk(KERN_INFO
>  			       "ibmvscsi: Re-enabling adapter!\n");
>  			purge_requests(hostdata, DID_REQUEUE);
> -			if ((ibmvscsi_reenable_crq_queue(&hostdata->queue,
> -							hostdata)) ||
> -			    (ibmvscsi_send_crq(hostdata,
> -					       0xC001000000000000LL, 0))) {
> +			if ((ibmvscsi_ops->reenable_crq_queue(&hostdata->queue,
> +							      hostdata)) ||
> +			    (ibmvscsi_ops->send_crq(hostdata,
> +						    0xC001000000000000LL, 0))) {
>  					atomic_set(&hostdata->request_limit,
>  						   -1);
>  					printk(KERN_ERR
> @@ -1228,10 +1230,10 @@ void ibmvscsi_handle_crq(struct viosrp_c
>  			       crq->format);
> =20
>  			purge_requests(hostdata, DID_ERROR);
> -			if ((ibmvscsi_reset_crq_queue(&hostdata->queue,
> -							hostdata)) ||
> -			    (ibmvscsi_send_crq(hostdata,
> -					       0xC001000000000000LL, 0))) {
> +			if ((ibmvscsi_ops->reset_crq_queue(&hostdata->queue,
> +							   hostdata)) ||
> +			    (ibmvscsi_ops->send_crq(hostdata,
> +						    0xC001000000000000LL, 0))) {
>  					atomic_set(&hostdata->request_limit,
>  						   -1);
>  					printk(KERN_ERR
> @@ -1517,7 +1519,7 @@ static int ibmvscsi_probe(struct vio_dev
>  	atomic_set(&hostdata->request_limit, -1);
>  	hostdata->host->max_sectors =3D 32 * 8; /* default max I/O 32 pages */
> =20
> -	rc =3D ibmvscsi_init_crq_queue(&hostdata->queue, hostdata, max_requests=
);
> +	rc =3D ibmvscsi_ops->init_crq_queue(&hostdata->queue, hostdata, max_req=
uests);
>  	if (rc !=3D 0 && rc !=3D H_RESOURCE) {
>  		printk(KERN_ERR "ibmvscsi: couldn't initialize crq\n");
>  		goto init_crq_failed;
> @@ -1538,7 +1540,7 @@ static int ibmvscsi_probe(struct vio_dev
>  	 * to fail if the other end is not acive.  In that case we don't
>  	 * want to scan
>  	 */
> -	if (ibmvscsi_send_crq(hostdata, 0xC001000000000000LL, 0) =3D=3D 0
> +	if (ibmvscsi_ops->send_crq(hostdata, 0xC001000000000000LL, 0) =3D=3D 0
>  	    || rc =3D=3D H_RESOURCE) {
>  		/*
>  		 * Wait around max init_timeout secs for the adapter to finish
> @@ -1564,7 +1566,7 @@ static int ibmvscsi_probe(struct vio_dev
>        add_host_failed:
>  	release_event_pool(&hostdata->pool, hostdata);
>        init_pool_failed:
> -	ibmvscsi_release_crq_queue(&hostdata->queue, hostdata, max_requests);
> +	ibmvscsi_ops->release_crq_queue(&hostdata->queue, hostdata, max_request=
s);
>        init_crq_failed:
>  	scsi_host_put(host);
>        scsi_host_alloc_failed:
> @@ -1575,8 +1577,8 @@ static int ibmvscsi_remove(struct vio_de
>  {
>  	struct ibmvscsi_host_data *hostdata =3D vdev->dev.driver_data;
>  	release_event_pool(&hostdata->pool, hostdata);
> -	ibmvscsi_release_crq_queue(&hostdata->queue, hostdata,
> -				   max_requests);
> +	ibmvscsi_ops->release_crq_queue(&hostdata->queue, hostdata,
> +					max_requests);
>  =09
>  	scsi_remove_host(hostdata->host);
>  	scsi_host_put(hostdata->host);
> @@ -1606,6 +1608,13 @@ static struct vio_driver ibmvscsi_driver
> =20
>  int __init ibmvscsi_module_init(void)
>  {
> +	if (firmware_has_feature(FW_FEATURE_ISERIES))
> +		ibmvscsi_ops =3D &iseriesvscsi_ops;
> +	else if (firmware_has_feature(FW_FEATURE_VIO))
> +		ibmvscsi_ops =3D &rpavscsi_ops;
> +	else
> +		return -ENODEV;
> +
>  	return vio_register_driver(&ibmvscsi_driver);
>  }
> =20
> --- linux-2.6.19.ppc64/drivers/scsi/ibmvscsi/ibmvscsi.h~	2006-11-29 21:57=
:37.000000000 +0000
> +++ linux-2.6.19.ppc64/drivers/scsi/ibmvscsi/ibmvscsi.h	2006-12-19 15:54:=
18.000000000 +0000
> @@ -94,21 +94,25 @@ struct ibmvscsi_host_data {
>  };
> =20
>  /* routines for managing a command/response queue */
> -int ibmvscsi_init_crq_queue(struct crq_queue *queue,
> -			    struct ibmvscsi_host_data *hostdata,
> -			    int max_requests);
> -void ibmvscsi_release_crq_queue(struct crq_queue *queue,
> -				struct ibmvscsi_host_data *hostdata,
> -				int max_requests);
> -int ibmvscsi_reset_crq_queue(struct crq_queue *queue,
> -			      struct ibmvscsi_host_data *hostdata);
> -
> -int ibmvscsi_reenable_crq_queue(struct crq_queue *queue,
> -				struct ibmvscsi_host_data *hostdata);
> -
>  void ibmvscsi_handle_crq(struct viosrp_crq *crq,
>  			 struct ibmvscsi_host_data *hostdata);
> -int ibmvscsi_send_crq(struct ibmvscsi_host_data *hostdata,
> -		      u64 word1, u64 word2);
> +
> +struct ibmvscsi_ops {
> +	int (*init_crq_queue)(struct crq_queue *queue,
> +			      struct ibmvscsi_host_data *hostdata,
> +			      int max_requests);
> +	void (*release_crq_queue)(struct crq_queue *queue,
> +				  struct ibmvscsi_host_data *hostdata,
> +				  int max_requests);
> +	int (*reset_crq_queue)(struct crq_queue *queue,
> +			       struct ibmvscsi_host_data *hostdata);
> +	int (*reenable_crq_queue)(struct crq_queue *queue,
> +				  struct ibmvscsi_host_data *hostdata);
> +	int (*send_crq)(struct ibmvscsi_host_data *hostdata,
> +		       u64 word1, u64 word2);
> +};
> +
> +extern struct ibmvscsi_ops iseriesvscsi_ops;
> +extern struct ibmvscsi_ops rpavscsi_ops;
> =20
>  #endif				/* IBMVSCSI_H */
> --- linux-2.6.19.ppc64/drivers/scsi/ibmvscsi/iseries_vscsi.c~	2006-11-29 =
21:57:37.000000000 +0000
> +++ linux-2.6.19.ppc64/drivers/scsi/ibmvscsi/iseries_vscsi.c	2006-12-19 1=
5:47:03.000000000 +0000
> @@ -53,7 +53,7 @@ struct srp_lp_event {
>  /**=20
>   * standard interface for handling logical partition events.
>   */
> -static void ibmvscsi_handle_event(struct HvLpEvent *lpevt)
> +static void iseriesvscsi_handle_event(struct HvLpEvent *lpevt)
>  {
>  	struct srp_lp_event *evt =3D (struct srp_lp_event *)lpevt;
> =20
> @@ -74,9 +74,9 @@ static void ibmvscsi_handle_event(struct
>  /* ------------------------------------------------------------
>   * Routines for driver initialization
>   */
> -int ibmvscsi_init_crq_queue(struct crq_queue *queue,
> -			    struct ibmvscsi_host_data *hostdata,
> -			    int max_requests)
> +static int iseriesvscsi_init_crq_queue(struct crq_queue *queue,
> +				       struct ibmvscsi_host_data *hostdata,
> +				       int max_requests)
>  {
>  	int rc;
> =20
> @@ -88,7 +88,7 @@ int ibmvscsi_init_crq_queue(struct crq_q
>  		goto viopath_open_failed;
>  	}
> =20
> -	rc =3D vio_setHandler(viomajorsubtype_scsi, ibmvscsi_handle_event);
> +	rc =3D vio_setHandler(viomajorsubtype_scsi, iseriesvscsi_handle_event);
>  	if (rc < 0) {
>  		printk("vio_setHandler failed with rc %d in open_event_path\n",
>  		       rc);
> @@ -102,9 +102,9 @@ int ibmvscsi_init_crq_queue(struct crq_q
>  	return -1;
>  }
> =20
> -void ibmvscsi_release_crq_queue(struct crq_queue *queue,
> -				struct ibmvscsi_host_data *hostdata,
> -				int max_requests)
> +static void iseriesvscsi_release_crq_queue(struct crq_queue *queue,
> +					   struct ibmvscsi_host_data *hostdata,
> +					   int max_requests)
>  {
>  	vio_clearHandler(viomajorsubtype_scsi);
>  	viopath_close(viopath_hostLp, viomajorsubtype_scsi, max_requests);
> @@ -117,8 +117,8 @@ void ibmvscsi_release_crq_queue(struct c
>   *
>   * no-op for iSeries
>   */
> -int ibmvscsi_reset_crq_queue(struct crq_queue *queue,
> -			      struct ibmvscsi_host_data *hostdata)
> +static int iseriesvscsi_reset_crq_queue(struct crq_queue *queue,
> +					struct ibmvscsi_host_data *hostdata)
>  {
>  	return 0;
>  }
> @@ -130,19 +130,20 @@ int ibmvscsi_reset_crq_queue(struct crq_
>   *
>   * no-op for iSeries
>   */
> -int ibmvscsi_reenable_crq_queue(struct crq_queue *queue,
> -				struct ibmvscsi_host_data *hostdata)
> +static int iseriesvscsi_reenable_crq_queue(struct crq_queue *queue,
> +					   struct ibmvscsi_host_data *hostdata)
>  {
>  	return 0;
>  }
> =20
>  /**
> - * ibmvscsi_send_crq: - Send a CRQ
> + * iseriesvscsi_send_crq: - Send a CRQ
>   * @hostdata:	the adapter
>   * @word1:	the first 64 bits of the data
>   * @word2:	the second 64 bits of the data
>   */
> -int ibmvscsi_send_crq(struct ibmvscsi_host_data *hostdata, u64 word1, u6=
4 word2)
> +static int iseriesvscsi_send_crq(struct ibmvscsi_host_data *hostdata,
> +				 u64 word1, u64 word2)
>  {
>  	single_host_data =3D hostdata;
>  	return HvCallEvent_signalLpEventFast(viopath_hostLp,
> @@ -156,3 +157,11 @@ int ibmvscsi_send_crq(struct ibmvscsi_ho
>  					     VIOVERSION << 16, word1, word2, 0,
>  					     0);
>  }
> +
> +struct ibmvscsi_ops iseriesvscsi_ops =3D {
> +	.init_crq_queue =3D iseriesvscsi_init_crq_queue,
> +	.release_crq_queue =3D iseriesvscsi_release_crq_queue,
> +	.reset_crq_queue =3D iseriesvscsi_reset_crq_queue,
> +	.reenable_crq_queue =3D iseriesvscsi_reenable_crq_queue,
> +	.send_crq =3D iseriesvscsi_send_crq,
> +};
> --- linux-2.6.19.ppc64/drivers/scsi/ibmvscsi/Makefile.orig	2007-01-01 20:=
06:26.000000000 +0000
> +++ linux-2.6.19.ppc64/drivers/scsi/ibmvscsi/Makefile	2007-01-01 20:06:35=
.000000000 +0000
> @@ -1,9 +1,7 @@
>  obj-$(CONFIG_SCSI_IBMVSCSI)	+=3D ibmvscsic.o
> =20
>  ibmvscsic-y			+=3D ibmvscsi.o
> -ifndef CONFIG_PPC_PSERIES
>  ibmvscsic-$(CONFIG_PPC_ISERIES)	+=3D iseries_vscsi.o=20
> -endif
>  ibmvscsic-$(CONFIG_PPC_PSERIES)	+=3D rpa_vscsi.o=20
> =20
>  obj-$(CONFIG_SCSI_IBMVSCSIS)	+=3D ibmvstgt.o
>=20
>=20
--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-7DSw57SNeoQ9+/MYmfBI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGp/ibdSjSd0sB4dIRAhQpAJ4wYQQRpOWYkC18yy5gdsxJ6HTZ0gCeIY52
ac7NwOmD9W5sZ55PesWdhhY=
=h10e
-----END PGP SIGNATURE-----

--=-7DSw57SNeoQ9+/MYmfBI--
