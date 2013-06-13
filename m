Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0784C2C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jun 2013 14:25:14 +1000 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 12 Jun 2013 22:14:35 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 466A93E40026
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 22:14:14 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5D4EWWg129732
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 22:14:32 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5D4ESxm015716
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 22:14:31 -0600
Date: Thu, 13 Jun 2013 12:14:17 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 21/27] powerpc/eeh: Process interrupts caused by EEH
Message-ID: <20130613041417.GA31299@shangw.(null)>
References: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1370417668-16832-22-git-send-email-shangw@linux.vnet.ibm.com>
 <1370938435.8250.116.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370938435.8250.116.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 11, 2013 at 06:13:55PM +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2013-06-05 at 15:34 +0800, Gavin Shan wrote:
>
>> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>> index d1fd5d4..68ac408 100644
>> --- a/arch/powerpc/include/asm/eeh.h
>> +++ b/arch/powerpc/include/asm/eeh.h
>> @@ -209,6 +209,12 @@ void eeh_add_device_tree_late(struct pci_bus *);
>>  void eeh_add_sysfs_files(struct pci_bus *);
>>  void eeh_remove_bus_device(struct pci_dev *, int);
>>  
>> +#ifdef CONFIG_PPC_POWERNV
>> +void pci_err_release(void);
>> +#else
>> +static inline void pci_err_release(void) { }
>> +#endif
>
>That business of the EEH core calling back into the powernv code
>directly is gross. We don't do that...
>
>See below for a discussion...
>
>.../...
>

Thanks for the review and comments, Ben.

>> +static void pci_err_take(void)
>> +{
>> +	down(&pci_err_seq_sem);
>> +}
>> +
>> +/**
>> + * pci_err_release - Enable error report for sending events
>> + *
>> + * We're hanlding the EEH event one by one. Each time, there only has
>> + * one EEH event caused by error IRQ. The function is called to enable
>> + * error report in order to send more EEH events.
>> + */
>> +void pci_err_release(void)
>> +{
>> +	up(&pci_err_seq_sem);
>> +}
>
>So it's generally bad to keep a semaphore held like that for a long
>time, taken in one corner of the kernel and released in another.
>
>I think you need to do something else. I'm not 100% certain what but
>that doesn't seem right to me.
>
>Also you have two problems I see here:
>
> - A given error will come potentially as both an interrupt and
>a return of ffff's from MMIO. You don't know which one will get it first
>and you end up going through two fairly different code path maybe. IE.
>What happens if interrupts are off for a while on the CPU that is
>targetted by the PHB interrupt and you "detect" a PHB fence as a result
>of an MMIO on another CPU ? Will the normal EEH process clear the fence
>and your interrupt completely miss logging any of those fancy messages
>you added to this file ?
>

Yes, we don't know which one (interrupt and 0xff's from MMIO/PCI-CFG)
comes in first. And no, the normal EEH process will call eeh_ops::get_log()
to collect the log and we won't lose the log.

> - You create another kthread ... we already have one in eeh_event.c,
>why another ?
>

What I thought is to prevent EEH core calling opal_pci_next_error() since
the EEH core is the shared part by multiple platforms. That's to say,
I expected opal_pci_next_error() to be part of powernv platform, and we
need some mechanism to inject EEH event to EEH core so that it can handle
them in sequence. That's why I created a new kthread.

>I think you need to rethink that part. My idea is that the EEH
>interrupts coming from the OPAL notifier would cause you to queue up
>EEH events just like the current ones.
>
>IE. Everything (including get_next_error) should be done by the one EEH
>thread. This also avoids the needs for those extra semaphores.
>
>One option is to create an event without a PE pointer at all. When
>eeh_event_handler() gets that, it would iterate a new hook,
>eeh_ops->next_error() which returns the PE.
>
>That way you can do your printing for fences etc... and return the
>top-level PE for anything PHB-wide. You may also want to add a flag
>maybe to return non-recoverable events and essentially make EEH just
>remove the offending devices from the system instead of panic'ing (panic
>is never a good idea, for all I know, the dead PHB or dead IOC wasn't
>critical to the system operating normally and you may have killed my
>ability to even recover the logs by panic'ing).
>
>Think a bit about it. I know the RTAS model is fairly different than our
>model here, but I like the idea that on powernv, even if we detect an
>MMIO freeze, we don't directly tell the EEH core to process *that* PE
>but instead do the whole next_error thing as well. If the freeze was the
>result of a fence, there's no point trying to process that specific PE.
>
>Something like a fence would thus look like that:
>
> - [ Case 1 -> fence interrupt -> queue eeh_event with no PE ]
>   [ Case 2 -> MMIO freeze detected -> queue eeh event with no PE ]
>
> - eeh_event_handler() sees no PE, loops around eeh_ops->get_next_error,
>since we are single threaded in the EEH thread, it's ok for the IODA
>backend to "cache" the current error data so that subsequent calls into
>the backend know what we are doing.
>
> - get_next_error sees the fence, returns the top-level PE and starts
>the reset (don't wait)
>
> - eeh_event_handler() calls the drivers for all devices on that PE
>(including children) to notify them something's wrong (TODO: Add passing
>by the upper level that this is a fatal error and don't attempt to
>recover).
>
> - It then calls wait_state() which knows it's waiting on a fence, and
>do the appropriate waiting etc...
>
> - Back to normal process...
>
>Don't you think that might be cleaner ? Or do you see a gaping hole in
>my description ?
>

It would incur lots of "unnecessary" EEH events. Normally, we send one
EEH event and we have specific PE (either corresponding to PHB or real
PE) for the event. Before the event is queued to the event queue, the
corresponding PE will be marked as "isolated". If the PE has been put
into "isolated" state, and we won't create another event if detecting
the PE got frozen again.

I think we can remove those pci_err_release/pci_err_take() by:

  - Export function to control "confirm_error_lock" (defined in eeh.c).
    For example, eeh_serialize_lock/unlock().
  - While detecting fenced PHB or frozen PE through interrupt or MMIO
    access, calling eeh_serialize_lock() and won't create EEH event if
    the PHB or PE has been marked "isolated". Otherwise, we will create
    an EEH event and queue it for further processing.


>> +static void pci_err_hub_diag_common(struct OpalIoP7IOCErrorData *data)
>> +{
>> +	/* GEM */
>> +	pr_info("  GEM XFIR:        %016llx\n", data->gemXfir);
>> +	pr_info("  GEM RFIR:        %016llx\n", data->gemRfir);
>> +	pr_info("  GEM RIRQFIR:     %016llx\n", data->gemRirqfir);
>> +	pr_info("  GEM Mask:        %016llx\n", data->gemMask);
>> +	pr_info("  GEM RWOF:        %016llx\n", data->gemRwof);
>> +
>> +	/* LEM */
>> +	pr_info("  LEM FIR:         %016llx\n", data->lemFir);
>> +	pr_info("  LEM Error Mask:  %016llx\n", data->lemErrMask);
>> +	pr_info("  LEM Action 0:    %016llx\n", data->lemAction0);
>> +	pr_info("  LEM Action 1:    %016llx\n", data->lemAction1);
>> +	pr_info("  LEM WOF:         %016llx\n", data->lemWof);
>> +}
>
>That's stuff is P7IOC specific. Make sure you make it clear in the
>function name and that you check the diag data "type". IE. Use a new
>diag_data2 function that returns a type. We can obsolete the old one.
>

Ok. Will update in next revision.

>> +static void pci_err_hub_diag_data(struct pci_controller *hose)
>> +{
>> +	struct pnv_phb *phb = hose->private_data;
>> +	struct OpalIoP7IOCErrorData *data;
>> +	long ret;
>> +
>> +	data = (struct OpalIoP7IOCErrorData *)pci_err_diag;
>> +	ret = opal_pci_get_hub_diag_data(phb->hub_id, data, PAGE_SIZE);
>> +	if (ret != OPAL_SUCCESS) {
>> +		pr_warning("%s: Failed to get HUB#%llx diag-data, ret=%ld\n",
>> +			__func__, phb->hub_id, ret);
>> +		return;
>> +	}
>> +
>> +	/* Check the error type */
>> +	if (data->type <= OPAL_P7IOC_DIAG_TYPE_NONE ||
>> +	    data->type >= OPAL_P7IOC_DIAG_TYPE_LAST) {
>> +		pr_warning("%s: Invalid type of HUB#%llx diag-data (%d)\n",
>> +			__func__, phb->hub_id, data->type);
>> +		return;
>> +	}
>> +
>> +	switch (data->type) {
>> +	case OPAL_P7IOC_DIAG_TYPE_RGC:
>> +		pr_info("P7IOC diag-data for RGC\n\n");
>> +		pci_err_hub_diag_common(data);
>> +		pr_info("  RGC Status:      %016llx\n", data->rgc.rgcStatus);
>> +		pr_info("  RGC LDCP:        %016llx\n", data->rgc.rgcLdcp);
>> +		break;
>> +	case OPAL_P7IOC_DIAG_TYPE_BI:
>> +		pr_info("P7IOC diag-data for BI %s\n\n",
>> +			data->bi.biDownbound ? "Downbound" : "Upbound");
>> +		pci_err_hub_diag_common(data);
>> +		pr_info("  BI LDCP 0:       %016llx\n", data->bi.biLdcp0);
>> +		pr_info("  BI LDCP 1:       %016llx\n", data->bi.biLdcp1);
>> +		pr_info("  BI LDCP 2:       %016llx\n", data->bi.biLdcp2);
>> +		pr_info("  BI Fence Status: %016llx\n", data->bi.biFenceStatus);
>> +		break;
>> +	case OPAL_P7IOC_DIAG_TYPE_CI:
>> +		pr_info("P7IOC diag-data for CI Port %d\\nn",
>> +			data->ci.ciPort);
>> +		pci_err_hub_diag_common(data);
>> +		pr_info("  CI Port Status:  %016llx\n", data->ci.ciPortStatus);
>> +		pr_info("  CI Port LDCP:    %016llx\n", data->ci.ciPortLdcp);
>> +		break;
>> +	case OPAL_P7IOC_DIAG_TYPE_MISC:
>> +		pr_info("P7IOC diag-data for MISC\n\n");
>> +		pci_err_hub_diag_common(data);
>> +		break;
>> +	case OPAL_P7IOC_DIAG_TYPE_I2C:
>> +		pr_info("P7IOC diag-data for I2C\n\n");
>> +		pci_err_hub_diag_common(data);
>> +		break;
>> +	}
>> +}
>> +
>> +static void pci_err_phb_diag_data(struct pci_controller *hose)
>> +{
>> +	struct pnv_phb *phb = hose->private_data;
>> +	struct OpalIoP7IOCPhbErrorData *data;
>> +	int i;
>> +	long ret;
>> +
>> +	data = (struct OpalIoP7IOCPhbErrorData *)pci_err_diag;
>> +	ret = opal_pci_get_phb_diag_data2(phb->opal_id, data, PAGE_SIZE);
>> +	if (ret != OPAL_SUCCESS) {
>> +		pr_warning("%s: Failed to get diag-data for PHB#%x, ret=%ld\n",
>> +			__func__, hose->global_number, ret);
>> +		return;
>> +	}
>> +
>> +	pr_info("PHB#%x Diag-data\n\n", hose->global_number);
>> +	pr_info("  brdgCtl:              %08x\n", data->brdgCtl);
>> +
>> +	pr_info("  portStatusReg:        %08x\n", data->portStatusReg);
>> +	pr_info("  rootCmplxStatus:      %08x\n", data->rootCmplxStatus);
>> +	pr_info("  busAgentStatus:       %08x\n", data->busAgentStatus);
>> +
>> +	pr_info("  deviceStatus:         %08x\n", data->deviceStatus);
>> +	pr_info("  slotStatus:           %08x\n", data->slotStatus);
>> +	pr_info("  linkStatus:           %08x\n", data->linkStatus);
>> +	pr_info("  devCmdStatus:         %08x\n", data->devCmdStatus);
>> +	pr_info("  devSecStatus:         %08x\n", data->devSecStatus);
>> +
>> +	pr_info("  rootErrorStatus:      %08x\n", data->rootErrorStatus);
>> +	pr_info("  uncorrErrorStatus:    %08x\n", data->uncorrErrorStatus);
>> +	pr_info("  corrErrorStatus:      %08x\n", data->corrErrorStatus);
>> +	pr_info("  tlpHdr1:              %08x\n", data->tlpHdr1);
>> +	pr_info("  tlpHdr2:              %08x\n", data->tlpHdr2);
>> +	pr_info("  tlpHdr3:              %08x\n", data->tlpHdr3);
>> +	pr_info("  tlpHdr4:              %08x\n", data->tlpHdr4);
>> +	pr_info("  sourceId:             %08x\n", data->sourceId);
>> +
>> +	pr_info("  errorClass:           %016llx\n", data->errorClass);
>> +	pr_info("  correlator:           %016llx\n", data->correlator);
>> +	pr_info("  p7iocPlssr:           %016llx\n", data->p7iocPlssr);
>> +	pr_info("  p7iocCsr:             %016llx\n", data->p7iocCsr);
>> +	pr_info("  lemFir:               %016llx\n", data->lemFir);
>> +	pr_info("  lemErrorMask:         %016llx\n", data->lemErrorMask);
>> +	pr_info("  lemWOF:               %016llx\n", data->lemWOF);
>> +	pr_info("  phbErrorStatus:       %016llx\n", data->phbErrorStatus);
>> +	pr_info("  phbFirstErrorStatus:  %016llx\n", data->phbFirstErrorStatus);
>> +	pr_info("  phbErrorLog0:         %016llx\n", data->phbErrorLog0);
>> +	pr_info("  phbErrorLog1:         %016llx\n", data->phbErrorLog1);
>> +	pr_info("  mmioErrorStatus:      %016llx\n", data->mmioErrorStatus);
>> +	pr_info("  mmioFirstErrorStatus: %016llx\n", data->mmioFirstErrorStatus);
>> +	pr_info("  mmioErrorLog0:        %016llx\n", data->mmioErrorLog0);
>> +	pr_info("  mmioErrorLog1:        %016llx\n", data->mmioErrorLog1);
>> +	pr_info("  dma0ErrorStatus:      %016llx\n", data->dma0ErrorStatus);
>> +	pr_info("  dma0FirstErrorStatus: %016llx\n", data->dma0FirstErrorStatus);
>> +	pr_info("  dma0ErrorLog0:        %016llx\n", data->dma0ErrorLog0);
>> +	pr_info("  dma0ErrorLog1:        %016llx\n", data->dma0ErrorLog1);
>> +	pr_info("  dma1ErrorStatus:      %016llx\n", data->dma1ErrorStatus);
>> +	pr_info("  dma1FirstErrorStatus: %016llx\n", data->dma1FirstErrorStatus);
>> +	pr_info("  dma1ErrorLog0:        %016llx\n", data->dma1ErrorLog0);
>> +	pr_info("  dma1ErrorLog1:        %016llx\n", data->dma1ErrorLog1);
>> +
>> +	for (i = 0; i < OPAL_P7IOC_NUM_PEST_REGS; i++) {
>> +		if ((data->pestA[i] >> 63) == 0 &&
>> +		    (data->pestB[i] >> 63) == 0)
>> +			continue;
>> +
>> +		pr_info("  PE[%3d] PESTA:        %016llx\n", i, data->pestA[i]);
>> +		pr_info("          PESTB:        %016llx\n", data->pestB[i]);
>> +	}
>> +}
>> +
>> +/*
>> + * Process PCI errors from IOC, PHB, or PE. Here's the list
>> + * of expected error types and their severities, as well as
>> + * the corresponding action.
>> + *
>> + * Type                        Severity                Action
>> + * OPAL_EEH_ERROR_IOC  OPAL_EEH_SEV_IOC_DEAD   panic
>> + * OPAL_EEH_ERROR_IOC  OPAL_EEH_SEV_INF        diag_data
>> + * OPAL_EEH_ERROR_PHB  OPAL_EEH_SEV_PHB_DEAD   panic
>> + * OPAL_EEH_ERROR_PHB  OPAL_EEH_SEV_PHB_FENCED eeh
>> + * OPAL_EEH_ERROR_PHB  OPAL_EEH_SEV_INF        diag_data
>> + * OPAL_EEH_ERROR_PE   OPAL_EEH_SEV_PE_ER      eeh
>> + */
>> +static void pci_err_process(struct pci_controller *hose,
>> +			u16 err_type, u16 severity, u16 pe_no)
>> +{
>> +	PCI_ERR_DBG("PCI_ERR: Process error (%d, %d, %d) on PHB#%x\n",
>> +		err_type, severity, pe_no, hose->global_number);
>> +
>> +	switch (err_type) {
>> +	case OPAL_EEH_IOC_ERROR:
>> +		if (severity == OPAL_EEH_SEV_IOC_DEAD)
>> +			panic("Dead IOC of PHB#%x", hose->global_number);
>> +		else if (severity == OPAL_EEH_SEV_INF) {
>> +			pci_err_hub_diag_data(hose);
>> +			pci_err_release();
>> +		}
>> +
>> +		break;
>> +	case OPAL_EEH_PHB_ERROR:
>> +		if (severity == OPAL_EEH_SEV_PHB_DEAD)
>> +			panic("Dead PHB#%x", hose->global_number);
>> +		else if (severity == OPAL_EEH_SEV_PHB_FENCED)
>> +			pci_err_check_phb(hose);
>> +		else if (severity == OPAL_EEH_SEV_INF) {
>> +			pci_err_phb_diag_data(hose);
>> +			pci_err_release();
>> +		}
>> +
>> +		break;
>> +	case OPAL_EEH_PE_ERROR:
>> +		pci_err_check_pe(hose, pe_no);
>> +		break;
>> +	}
>> +}
>> +
>> +static int pci_err_handler(void *dummy)
>> +{
>> +	struct pnv_phb *phb;
>> +	struct pci_controller *hose, *tmp;
>> +	u64 frozen_pe_no;
>> +	u16 err_type, severity;
>> +	long ret;
>> +
>> +	while (!kthread_should_stop()) {
>> +		down(&pci_err_int_sem);
>> +		PCI_ERR_DBG("PCI_ERR: Get PCI error semaphore\n");
>> +
>> +		list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
>> +			phb = hose->private_data;
>> +restart:
>> +			pci_err_take();
>> +			ret = opal_pci_next_error(phb->opal_id,
>> +					&frozen_pe_no, &err_type, &severity);
>> +
>> +			/* If OPAL API returns error, we needn't proceed */
>> +			if (ret != OPAL_SUCCESS) {
>> +				PCI_ERR_DBG("PCI_ERR: Invalid return value on "
>> +					    "PHB#%x (0x%lx) from opal_pci_next_error",
>> +					    hose->global_number, ret);
>> +				pci_err_release();
>> +				continue;
>> +			}
>> +
>> +			/* If the PHB doesn't have error, stop processing */
>> +			if (err_type == OPAL_EEH_NO_ERROR ||
>> +			    severity == OPAL_EEH_SEV_NO_ERROR) {
>> +				PCI_ERR_DBG("PCI_ERR: No error found on PHB#%x\n",
>> +					hose->global_number);
>> +				pci_err_release();
>> +				continue;
>> +			}
>> +
>> +			/*
>> +			 * Process the error until there're no pending
>> +			 * errors on the specific PHB.
>> +			 */
>> +			pci_err_process(hose, err_type, severity, frozen_pe_no);
>> +			goto restart;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * pci_err_init - Initialize PCI error handling component
>> + *
>> + * It should be done before OPAL interrupts got registered because
>> + * that depends on this.
>> + */
>> +static int __init pci_err_init(void)
>> +{
>> +	int ret = 0;
>> +
>> +	if (!firmware_has_feature(FW_FEATURE_OPALv3)) {
>> +		pr_err("%s: FW_FEATURE_OPALv3 required!\n",
>> +			__func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	pci_err_diag = (char *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
>> +	if (!pci_err_diag) {
>> +		pr_err("%s: Failed to alloc memory for diag data\n",
>> +			__func__);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	/* Initialize semaphore */
>> +	sema_init(&pci_err_int_sem, 0);
>> +	sema_init(&pci_err_seq_sem, 1);
>> +
>> +	/* Start kthread */
>> +	pci_err_thread = kthread_run(pci_err_handler, NULL, "PCI_ERR");
>> +	if (IS_ERR(pci_err_thread)) {
>> +		ret = PTR_ERR(pci_err_thread);
>> +		pr_err("%s: Failed to start kthread, ret=%d\n",
>> +			__func__, ret);
>> +	}
>> +
>> +	free_page((unsigned long)pci_err_diag);
>> +	return ret;
>> +}
>> +
>> +arch_initcall(pci_err_init);
>> diff --git a/arch/powerpc/platforms/pseries/eeh_event.c b/arch/powerpc/platforms/pseries/eeh_event.c
>> index 1f86b80..e4c636e 100644
>> --- a/arch/powerpc/platforms/pseries/eeh_event.c
>> +++ b/arch/powerpc/platforms/pseries/eeh_event.c
>> @@ -84,6 +84,14 @@ static int eeh_event_handler(void * dummy)
>>  	eeh_handle_event(pe);
>>  	eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
>>  
>> +	/*
>> +	 * If it's the event caused by error reporting IRQ,
>> +	 * we need release the module so that precedent events
>> +	 * could be fired.
>> +	 */
>> +	if (event->flag & EEH_EVENT_INT)
>> +		pci_err_release();
>> +
>>  	kfree(event);
>>  	mutex_unlock(&eeh_event_mutex);
>>  

Thanks,
Gavin
