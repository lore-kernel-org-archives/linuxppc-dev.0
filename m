Return-Path: <brking@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 342E9DDDF9
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 06:51:36 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l73KpX7R022445
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 16:51:33 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l73KpXRK268526
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 14:51:33 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l73KpW1H024800
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 14:51:33 -0600
Message-ID: <46B3954E.9030301@linux.vnet.ibm.com>
Date: Fri, 03 Aug 2007 15:51:26 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v3] Fix ibmvscsi client for multiplatform iSeries+pSeries
	kernel.
References: <1185374509.14697.384.camel@pmac.infradead.org>
	<1185413275.25216.2.camel@concordia.ozlabs.ibm.com>
	<1185435997.14697.432.camel@pmac.infradead.org>
	<1185436849.14697.441.camel@pmac.infradead.org>
	<1185882169.3083.93.camel@pmac.infradead.org>
In-Reply-To: <1185882169.3083.93.camel@pmac.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Acked by: Brian King <brking@linux.vnet.ibm.com>

David Woodhouse wrote:
> If you build a multiplatform kernel for iSeries and pSeries, with
> ibmvscsic support, the resulting client doesn't work on iSeries.
> 
> This patch should fix that, using the appropriate low-level operations
> for the machine detected at runtime.
> 
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> 
> ---
> This third version of the patch is updated to apply to Linus' current
> git tree following the recent ibmvscsi updates.
> 
> diff --git a/drivers/scsi/ibmvscsi/rpa_vscsi.c b/drivers/scsi/ibmvscsi/rpa_vscsi.c
> index 9c14e78..1821461 100644
> --- a/drivers/scsi/ibmvscsi/rpa_vscsi.c
> +++ b/drivers/scsi/ibmvscsi/rpa_vscsi.c
> @@ -42,14 +42,14 @@ static unsigned int partition_number = -1;
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
>  	struct ibmvscsi_host_data *hostdata =
>  	    (struct ibmvscsi_host_data *)dev_instance;
> @@ -66,9 +66,9 @@ static irqreturn_t ibmvscsi_handle_event(int irq, void *dev_instance)
>   * Frees irq, deallocates a page for messages, unmaps dma, and unregisters
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
>  	struct vio_dev *vdev = to_vio_dev(hostdata->dev);
> @@ -108,12 +108,13 @@ static struct viosrp_crq *crq_queue_next_crq(struct crq_queue *queue)
>  }
> 
>  /**
> - * ibmvscsi_send_crq: - Send a CRQ
> + * rpavscsi_send_crq: - Send a CRQ
>   * @hostdata:	the adapter
>   * @word1:	the first 64 bits of the data
>   * @word2:	the second 64 bits of the data
>   */
> -int ibmvscsi_send_crq(struct ibmvscsi_host_data *hostdata, u64 word1, u64 word2)
> +static int rpavscsi_send_crq(struct ibmvscsi_host_data *hostdata,
> +			     u64 word1, u64 word2)
>  {
>  	struct vio_dev *vdev = to_vio_dev(hostdata->dev);
> 
> @@ -121,10 +122,10 @@ int ibmvscsi_send_crq(struct ibmvscsi_host_data *hostdata, u64 word1, u64 word2)
>  }
> 
>  /**
> - * ibmvscsi_task: - Process srps asynchronously
> + * rpavscsi_task: - Process srps asynchronously
>   * @data:	ibmvscsi_host_data of host
>   */
> -static void ibmvscsi_task(void *data)
> +static void rpavscsi_task(void *data)
>  {
>  	struct ibmvscsi_host_data *hostdata = (struct ibmvscsi_host_data *)data;
>  	struct vio_dev *vdev = to_vio_dev(hostdata->dev);
> @@ -190,6 +191,42 @@ static void set_adapter_info(struct ibmvscsi_host_data *hostdata)
>  }
> 
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
> +	struct vio_dev *vdev = to_vio_dev(hostdata->dev);
> +
> +	/* Close the CRQ */
> +	do {
> +		rc = plpar_hcall_norets(H_FREE_CRQ, vdev->unit_address);
> +	} while ((rc == H_BUSY) || (H_IS_LONG_BUSY(rc)));
> +
> +	/* Clean out the queue */
> +	memset(queue->msgs, 0x00, PAGE_SIZE);
> +	queue->cur = 0;
> +
> +	set_adapter_info(hostdata);
> +
> +	/* And re-open it again */
> +	rc = plpar_hcall_norets(H_REG_CRQ,
> +				vdev->unit_address,
> +				queue->msg_token, PAGE_SIZE);
> +	if (rc == 2) {
> +		/* Adapter is good, but other end is not ready */
> +		dev_warn(hostdata->dev, "Partner adapter not ready\n");
> +	} else if (rc != 0) {
> +		dev_warn(hostdata->dev, "couldn't register crq--rc 0x%x\n", rc);
> +	}
> +	return rc;
> +}
> +
> +/**
>   * initialize_crq_queue: - Initializes and registers CRQ with hypervisor
>   * @queue:	crq_queue to initialize and register
>   * @hostdata:	ibmvscsi_host_data of host
> @@ -198,9 +235,9 @@ static void set_adapter_info(struct ibmvscsi_host_data *hostdata)
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
> @@ -227,7 +264,7 @@ int ibmvscsi_init_crq_queue(struct crq_queue *queue,
>  				queue->msg_token, PAGE_SIZE);
>  	if (rc == H_RESOURCE)
>  		/* maybe kexecing and resource is busy. try a reset */
> -		rc = ibmvscsi_reset_crq_queue(queue,
> +		rc = rpavscsi_reset_crq_queue(queue,
>  					      hostdata);
> 
>  	if (rc == 2) {
> @@ -240,7 +277,7 @@ int ibmvscsi_init_crq_queue(struct crq_queue *queue,
>  	}
> 
>  	if (request_irq(vdev->irq,
> -			ibmvscsi_handle_event,
> +			rpavscsi_handle_event,
>  			0, "ibmvscsi", (void *)hostdata) != 0) {
>  		dev_err(hostdata->dev, "couldn't register irq 0x%x\n",
>  			vdev->irq);
> @@ -256,7 +293,7 @@ int ibmvscsi_init_crq_queue(struct crq_queue *queue,
>  	queue->cur = 0;
>  	spin_lock_init(&queue->lock);
> 
> -	tasklet_init(&hostdata->srp_task, (void *)ibmvscsi_task,
> +	tasklet_init(&hostdata->srp_task, (void *)rpavscsi_task,
>  		     (unsigned long)hostdata);
> 
>  	return retrc;
> @@ -281,8 +318,8 @@ int ibmvscsi_init_crq_queue(struct crq_queue *queue,
>   * @hostdata:	ibmvscsi_host_data of host
>   *
>   */
> -int ibmvscsi_reenable_crq_queue(struct crq_queue *queue,
> -				 struct ibmvscsi_host_data *hostdata)
> +static int rpavscsi_reenable_crq_queue(struct crq_queue *queue,
> +				       struct ibmvscsi_host_data *hostdata)
>  {
>  	int rc;
>  	struct vio_dev *vdev = to_vio_dev(hostdata->dev);
> @@ -297,38 +334,10 @@ int ibmvscsi_reenable_crq_queue(struct crq_queue *queue,
>  	return rc;
>  }
> 
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
> -	struct vio_dev *vdev = to_vio_dev(hostdata->dev);
> -
> -	/* Close the CRQ */
> -	do {
> -		rc = plpar_hcall_norets(H_FREE_CRQ, vdev->unit_address);
> -	} while ((rc == H_BUSY) || (H_IS_LONG_BUSY(rc)));
> -
> -	/* Clean out the queue */
> -	memset(queue->msgs, 0x00, PAGE_SIZE);
> -	queue->cur = 0;
> -
> -	set_adapter_info(hostdata);
> -
> -	/* And re-open it again */
> -	rc = plpar_hcall_norets(H_REG_CRQ,
> -				vdev->unit_address,
> -				queue->msg_token, PAGE_SIZE);
> -	if (rc == 2) {
> -		/* Adapter is good, but other end is not ready */
> -		dev_warn(hostdata->dev, "Partner adapter not ready\n");
> -	} else if (rc != 0) {
> -		dev_warn(hostdata->dev, "couldn't register crq--rc 0x%x\n", rc);
> -	}
> -	return rc;
> -}
> +struct ibmvscsi_ops rpavscsi_ops = {
> +	.init_crq_queue = rpavscsi_init_crq_queue,
> +	.release_crq_queue = rpavscsi_release_crq_queue,
> +	.reset_crq_queue = rpavscsi_reset_crq_queue,
> +	.reenable_crq_queue = rpavscsi_reenable_crq_queue,
> +	.send_crq = rpavscsi_send_crq,
> +};
> diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
> index 5870866..ed9b675 100644
> --- a/drivers/scsi/ibmvscsi/ibmvscsi.c
> +++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
> @@ -70,6 +70,7 @@
>  #include <linux/moduleparam.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/delay.h>
> +#include <asm/firmware.h>
>  #include <asm/vio.h>
>  #include <scsi/scsi.h>
>  #include <scsi/scsi_cmnd.h>
> @@ -89,6 +90,8 @@ static int max_requests = IBMVSCSI_MAX_REQUESTS_DEFAULT;
> 
>  #define IBMVSCSI_VERSION "1.5.8"
> 
> +static struct ibmvscsi_ops *ibmvscsi_ops;
> +
>  MODULE_DESCRIPTION("IBM Virtual SCSI");
>  MODULE_AUTHOR("Dave Boutcher");
>  MODULE_LICENSE("GPL");
> @@ -512,8 +515,8 @@ static void ibmvscsi_reset_host(struct ibmvscsi_host_data *hostdata)
>  	atomic_set(&hostdata->request_limit, 0);
> 
>  	purge_requests(hostdata, DID_ERROR);
> -	if ((ibmvscsi_reset_crq_queue(&hostdata->queue, hostdata)) ||
> -	    (ibmvscsi_send_crq(hostdata, 0xC001000000000000LL, 0)) ||
> +	if ((ibmvscsi_ops->reset_crq_queue(&hostdata->queue, hostdata)) ||
> +	    (ibmvscsi_ops->send_crq(hostdata, 0xC001000000000000LL, 0)) ||
>  	    (vio_enable_interrupts(to_vio_dev(hostdata->dev)))) {
>  		atomic_set(&hostdata->request_limit, -1);
>  		dev_err(hostdata->dev, "error after reset\n");
> @@ -618,7 +621,7 @@ static int ibmvscsi_send_srp_event(struct srp_event_struct *evt_struct,
>  	}
> 
>  	if ((rc =
> -	     ibmvscsi_send_crq(hostdata, crq_as_u64[0], crq_as_u64[1])) != 0) {
> +	     ibmvscsi_ops->send_crq(hostdata, crq_as_u64[0], crq_as_u64[1])) != 0) {
>  		list_del(&evt_struct->list);
>  		del_timer(&evt_struct->timer);
> 
> @@ -1222,8 +1225,8 @@ void ibmvscsi_handle_crq(struct viosrp_crq *crq,
>  		case 0x01:	/* Initialization message */
>  			dev_info(hostdata->dev, "partner initialized\n");
>  			/* Send back a response */
> -			if ((rc = ibmvscsi_send_crq(hostdata,
> -						    0xC002000000000000LL, 0)) == 0) {
> +			if ((rc = ibmvscsi_ops->send_crq(hostdata,
> +							 0xC002000000000000LL, 0)) == 0) {
>  				/* Now login */
>  				send_srp_login(hostdata);
>  			} else {
> @@ -1248,10 +1251,10 @@ void ibmvscsi_handle_crq(struct viosrp_crq *crq,
>  			/* We need to re-setup the interpartition connection */
>  			dev_info(hostdata->dev, "Re-enabling adapter!\n");
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
>  					dev_err(hostdata->dev, "error after enable\n");
> @@ -1261,10 +1264,10 @@ void ibmvscsi_handle_crq(struct viosrp_crq *crq,
>  				crq->format);
> 
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
>  					dev_err(hostdata->dev, "error after reset\n");
> @@ -1590,7 +1593,7 @@ static int ibmvscsi_probe(struct vio_dev *vdev, const struct vio_device_id *id)
>  	atomic_set(&hostdata->request_limit, -1);
>  	hostdata->host->max_sectors = 32 * 8; /* default max I/O 32 pages */
> 
> -	rc = ibmvscsi_init_crq_queue(&hostdata->queue, hostdata, max_requests);
> +	rc = ibmvscsi_ops->init_crq_queue(&hostdata->queue, hostdata, max_requests);
>  	if (rc != 0 && rc != H_RESOURCE) {
>  		dev_err(&vdev->dev, "couldn't initialize crq. rc=%d\n", rc);
>  		goto init_crq_failed;
> @@ -1611,7 +1614,7 @@ static int ibmvscsi_probe(struct vio_dev *vdev, const struct vio_device_id *id)
>  	 * to fail if the other end is not acive.  In that case we don't
>  	 * want to scan
>  	 */
> -	if (ibmvscsi_send_crq(hostdata, 0xC001000000000000LL, 0) == 0
> +	if (ibmvscsi_ops->send_crq(hostdata, 0xC001000000000000LL, 0) == 0
>  	    || rc == H_RESOURCE) {
>  		/*
>  		 * Wait around max init_timeout secs for the adapter to finish
> @@ -1637,7 +1640,7 @@ static int ibmvscsi_probe(struct vio_dev *vdev, const struct vio_device_id *id)
>        add_host_failed:
>  	release_event_pool(&hostdata->pool, hostdata);
>        init_pool_failed:
> -	ibmvscsi_release_crq_queue(&hostdata->queue, hostdata, max_requests);
> +	ibmvscsi_ops->release_crq_queue(&hostdata->queue, hostdata, max_requests);
>        init_crq_failed:
>  	scsi_host_put(host);
>        scsi_host_alloc_failed:
> @@ -1648,8 +1651,8 @@ static int ibmvscsi_remove(struct vio_dev *vdev)
>  {
>  	struct ibmvscsi_host_data *hostdata = vdev->dev.driver_data;
>  	release_event_pool(&hostdata->pool, hostdata);
> -	ibmvscsi_release_crq_queue(&hostdata->queue, hostdata,
> -				   max_requests);
> +	ibmvscsi_ops->release_crq_queue(&hostdata->queue, hostdata,
> +					max_requests);
>  	
>  	scsi_remove_host(hostdata->host);
>  	scsi_host_put(hostdata->host);
> @@ -1679,6 +1682,13 @@ static struct vio_driver ibmvscsi_driver = {
> 
>  int __init ibmvscsi_module_init(void)
>  {
> +	if (firmware_has_feature(FW_FEATURE_ISERIES))
> +		ibmvscsi_ops = &iseriesvscsi_ops;
> +	else if (firmware_has_feature(FW_FEATURE_VIO))
> +		ibmvscsi_ops = &rpavscsi_ops;
> +	else
> +		return -ENODEV;
> +
>  	return vio_register_driver(&ibmvscsi_driver);
>  }
> 
> diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.h b/drivers/scsi/ibmvscsi/ibmvscsi.h
> index b19c2e2..46e850e 100644
> --- a/drivers/scsi/ibmvscsi/ibmvscsi.h
> +++ b/drivers/scsi/ibmvscsi/ibmvscsi.h
> @@ -98,21 +98,25 @@ struct ibmvscsi_host_data {
>  };
> 
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
> 
>  #endif				/* IBMVSCSI_H */
> diff --git a/drivers/scsi/ibmvscsi/iseries_vscsi.c b/drivers/scsi/ibmvscsi/iseries_vscsi.c
> index 6aeb5f0..0775fde 100644
> --- a/drivers/scsi/ibmvscsi/iseries_vscsi.c
> +++ b/drivers/scsi/ibmvscsi/iseries_vscsi.c
> @@ -53,7 +53,7 @@ struct srp_lp_event {
>  /** 
>   * standard interface for handling logical partition events.
>   */
> -static void ibmvscsi_handle_event(struct HvLpEvent *lpevt)
> +static void iseriesvscsi_handle_event(struct HvLpEvent *lpevt)
>  {
>  	struct srp_lp_event *evt = (struct srp_lp_event *)lpevt;
> 
> @@ -74,9 +74,9 @@ static void ibmvscsi_handle_event(struct HvLpEvent *lpevt)
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
> 
> @@ -88,7 +88,7 @@ int ibmvscsi_init_crq_queue(struct crq_queue *queue,
>  		goto viopath_open_failed;
>  	}
> 
> -	rc = vio_setHandler(viomajorsubtype_scsi, ibmvscsi_handle_event);
> +	rc = vio_setHandler(viomajorsubtype_scsi, iseriesvscsi_handle_event);
>  	if (rc < 0) {
>  		printk("vio_setHandler failed with rc %d in open_event_path\n",
>  		       rc);
> @@ -102,9 +102,9 @@ int ibmvscsi_init_crq_queue(struct crq_queue *queue,
>  	return -1;
>  }
> 
> -void ibmvscsi_release_crq_queue(struct crq_queue *queue,
> -				struct ibmvscsi_host_data *hostdata,
> -				int max_requests)
> +static void iseriesvscsi_release_crq_queue(struct crq_queue *queue,
> +					   struct ibmvscsi_host_data *hostdata,
> +					   int max_requests)
>  {
>  	vio_clearHandler(viomajorsubtype_scsi);
>  	viopath_close(viopath_hostLp, viomajorsubtype_scsi, max_requests);
> @@ -117,8 +117,8 @@ void ibmvscsi_release_crq_queue(struct crq_queue *queue,
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
> @@ -130,19 +130,20 @@ int ibmvscsi_reset_crq_queue(struct crq_queue *queue,
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
> 
>  /**
> - * ibmvscsi_send_crq: - Send a CRQ
> + * iseriesvscsi_send_crq: - Send a CRQ
>   * @hostdata:	the adapter
>   * @word1:	the first 64 bits of the data
>   * @word2:	the second 64 bits of the data
>   */
> -int ibmvscsi_send_crq(struct ibmvscsi_host_data *hostdata, u64 word1, u64 word2)
> +static int iseriesvscsi_send_crq(struct ibmvscsi_host_data *hostdata,
> +				 u64 word1, u64 word2)
>  {
>  	single_host_data = hostdata;
>  	return HvCallEvent_signalLpEventFast(viopath_hostLp,
> @@ -156,3 +157,11 @@ int ibmvscsi_send_crq(struct ibmvscsi_host_data *hostdata, u64 word1, u64 word2)
>  					     VIOVERSION << 16, word1, word2, 0,
>  					     0);
>  }
> +
> +struct ibmvscsi_ops iseriesvscsi_ops = {
> +	.init_crq_queue = iseriesvscsi_init_crq_queue,
> +	.release_crq_queue = iseriesvscsi_release_crq_queue,
> +	.reset_crq_queue = iseriesvscsi_reset_crq_queue,
> +	.reenable_crq_queue = iseriesvscsi_reenable_crq_queue,
> +	.send_crq = iseriesvscsi_send_crq,
> +};
> diff --git a/drivers/scsi/ibmvscsi/Makefile b/drivers/scsi/ibmvscsi/Makefile
> index f67d9ef..6ac0633 100644
> --- a/drivers/scsi/ibmvscsi/Makefile
> +++ b/drivers/scsi/ibmvscsi/Makefile
> @@ -1,9 +1,7 @@
>  obj-$(CONFIG_SCSI_IBMVSCSI)	+= ibmvscsic.o
> 
>  ibmvscsic-y			+= ibmvscsi.o
> -ifndef CONFIG_PPC_PSERIES
>  ibmvscsic-$(CONFIG_PPC_ISERIES)	+= iseries_vscsi.o 
> -endif
>  ibmvscsic-$(CONFIG_PPC_PSERIES)	+= rpa_vscsi.o 
> 
>  obj-$(CONFIG_SCSI_IBMVSCSIS)	+= ibmvstgt.o
> 


-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
