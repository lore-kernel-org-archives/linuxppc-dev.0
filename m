Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLACK
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3422AC04EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 07:34:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E7FF20881
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 07:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7FF20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Z6WK30kVzF3Vm
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 18:34:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=popple.id.au
 (client-ip=150.101.137.145; helo=ipmail06.adl6.internode.on.net;
 envelope-from=alistair@popple.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from ipmail06.adl6.internode.on.net (ipmail06.adl6.internode.on.net
 [150.101.137.145])
 by lists.ozlabs.org (Postfix) with ESMTP id 42Z6TB602jzF3PJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 18:32:14 +1100 (AEDT)
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BpBQCh299Z/3oKyHleGwEBAQMBAQEJAQEBgy8uZG4nhVmJNI4+AYF1LwGWDYIELYRJSQQCAoQ+WAECAQEBAQECayiFHgEFJxMcIxALDgoJFRAPASkeBhOKHRGtTjqLPAEBAQEBBQEBAQEfBYMthUKDKoQ/KgWGCwWhRIdejX6SHpckV4EOHBYYCQgZGYVjHBmBYiw2iSKCNQEBAQ
Received: from 121-200-10-122.nbn.syd.aussiebb.net (HELO new-mexico.localnet)
 ([121.200.10.122])
 by ipmail06.adl6.internode.on.net with ESMTP; 16 Oct 2018 18:02:14 +1030
From: Alistair Popple <alistair@popple.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v2] powerpc/ioda/npu: Call skiboot's hot reset hook
 when disabling NPU2
Date: Tue, 16 Oct 2018 18:32:10 +1100
Message-ID: <2086775.d8i5QI7OoB@new-mexico>
User-Agent: KMail/5.2.3 (Linux/4.17.0-0.bpo.1-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <374a32c1-8787-2b82-af5d-163d9a496a25@ozlabs.ru>
References: <20181002032021.7126-1-aik@ozlabs.ru>
 <2184134.UzzIe8q8zq@new-mexico>
 <374a32c1-8787-2b82-af5d-163d9a496a25@ozlabs.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Reza Arbab <arbab@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tuesday, 16 October 2018 1:22:53 PM AEDT Alexey Kardashevskiy wrote:
> 
> On 16/10/2018 13:19, Alistair Popple wrote:
> >> reset_ntl() does what npu2_dev_procedure_reset() does plus more stuff,
> >> there nothing really in npu2_dev_procedure_reset() which reset_ntl()
> >> does not do already from the hardware standpoint. And it did stop HMIs
> >> for me though.
> >>
> >> but ok, what will be sufficient then if not reset_ntl()?
> > 
> > Argh, yes you are correct. Specifically both npu2_dev_procedure_reset() and
> > reset_ntl() contain:
> > 
> > 	/* NTL Reset */
> > 	val = npu2_read(ndev->npu, NPU2_NTL_MISC_CFG1(ndev));
> > 	val |= PPC_BIT(8) | PPC_BIT(9);
> > 	npu2_write(ndev->npu, NPU2_NTL_MISC_CFG1(ndev), val);
> > 
> > Which should fence the brick. However from what I recall there was more to
> > reliably preventing HMIs than merely fencing the brick. It invovled a sequence
> > of fencing and flushing the cache with dcbf instructions at the right time which
> > is why we also have the FLR. Unfortunately I don't know the precise details,
> > perhaps if we send enough coffee Balbir's way he might be able remind us?
> 
> 
> He suggested and ack'ed that skiboot patch, I can repeat beers^wcoffee
> but it won't change much ;)

Ha. Couldn't hurt ;)

I was pretty sure flushing the caches was an important part of the sequence to
avoid HMI's. I believe you are trying to deal with unexpected guest terminations
which means the driver won't have a chance to flush the caches prior to
termination so wouldn't you also need to do that somewhere? Unless the driver
does it at startup?

- Alistair

> >
> > - Alistair
> > 
> >>
> >>
> >>>
> >>> - Alistair
> >>>
> >>>>
> >>>>
> >>>>
> >>>>>
> >>>>> - Alistair
> >>>>>
> >>>>> On Monday, 15 October 2018 6:17:51 PM AEDT Alexey Kardashevskiy wrote:
> >>>>>> Ping?
> >>>>>>
> >>>>>>
> >>>>>> On 02/10/2018 13:20, Alexey Kardashevskiy wrote:
> >>>>>>> The skiboot firmware has a hot reset handler which fences the NVIDIA V100
> >>>>>>> GPU RAM on Witherspoons and makes accesses no-op instead of throwing HMIs:
> >>>>>>> https://github.com/open-power/skiboot/commit/fca2b2b839a67
> >>>>>>>
> >>>>>>> Now we are going to pass V100 via VFIO which most certainly involves
> >>>>>>> KVM guests which are often terminated without getting a chance to offline
> >>>>>>> GPU RAM so we end up with a running machine with misconfigured memory.
> >>>>>>> Accessing this memory produces hardware management interrupts (HMI)
> >>>>>>> which bring the host down.
> >>>>>>>
> >>>>>>> To suppress HMIs, this wires up this hot reset hook to vfio_pci_disable()
> >>>>>>> via pci_disable_device() which switches NPU2 to a safe mode and prevents
> >>>>>>> HMIs.
> >>>>>>>
> >>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>>>>> ---
> >>>>>>> Changes:
> >>>>>>> v2:
> >>>>>>> * updated the commit log
> >>>>>>> ---
> >>>>>>>  arch/powerpc/platforms/powernv/pci-ioda.c | 10 ++++++++++
> >>>>>>>  1 file changed, 10 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> >>>>>>> index cde7102..e37b9cc 100644
> >>>>>>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >>>>>>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >>>>>>> @@ -3688,6 +3688,15 @@ static void pnv_pci_release_device(struct pci_dev *pdev)
> >>>>>>>  		pnv_ioda_release_pe(pe);
> >>>>>>>  }
> >>>>>>>  
> >>>>>>> +static void pnv_npu_disable_device(struct pci_dev *pdev)
> >>>>>>> +{
> >>>>>>> +	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
> >>>>>>> +	struct eeh_pe *eehpe = edev ? edev->pe : NULL;
> >>>>>>> +
> >>>>>>> +	if (eehpe && eeh_ops && eeh_ops->reset)
> >>>>>>> +		eeh_ops->reset(eehpe, EEH_RESET_HOT);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>>  static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
> >>>>>>>  {
> >>>>>>>  	struct pnv_phb *phb = hose->private_data;
> >>>>>>> @@ -3732,6 +3741,7 @@ static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
> >>>>>>>  	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
> >>>>>>>  	.dma_set_mask		= pnv_npu_dma_set_mask,
> >>>>>>>  	.shutdown		= pnv_pci_ioda_shutdown,
> >>>>>>> +	.disable_device		= pnv_npu_disable_device,
> >>>>>>>  };
> >>>>>>>  
> >>>>>>>  static const struct pci_controller_ops pnv_npu_ocapi_ioda_controller_ops = {
> >>>>>>>
> >>>>>>
> >>>>>>
> >>>>>
> >>>>>
> >>>>
> >>>>
> >>>
> >>>
> >>
> >>
> > 
> > 
> 
> 


