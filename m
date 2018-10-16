Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C21C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 01:46:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E568E208D9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 01:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E568E208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YypX5jWszF3TN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 12:46:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=popple.id.au
 (client-ip=150.101.137.129; helo=ipmail06.adl2.internode.on.net;
 envelope-from=alistair@popple.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [150.101.137.129])
 by lists.ozlabs.org (Postfix) with ESMTP id 42YymR5cC9zF3Hh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 12:44:55 +1100 (AEDT)
Received: from static-82-10.transact.net.au (HELO new-mexico.localnet)
 ([122.99.82.10])
 by ipmail06.adl2.internode.on.net with ESMTP; 16 Oct 2018 12:14:55 +1030
From: Alistair Popple <alistair@popple.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v2] powerpc/ioda/npu: Call skiboot's hot reset hook
 when disabling NPU2
Date: Tue, 16 Oct 2018 12:44:50 +1100
Message-ID: <1625714.Rr8qeDJm6q@new-mexico>
User-Agent: KMail/5.2.3 (Linux/4.17.0-0.bpo.1-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <c4954261-ed8f-06e9-b32b-7710c50ee9d5@ozlabs.ru>
References: <20181002032021.7126-1-aik@ozlabs.ru>
 <2435624.zC36bzMth8@new-mexico>
 <c4954261-ed8f-06e9-b32b-7710c50ee9d5@ozlabs.ru>
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

Hi Alexey,

On Tuesday, 16 October 2018 12:37:49 PM AEDT Alexey Kardashevskiy wrote:
> 
> On 16/10/2018 11:38, Alistair Popple wrote:
> > Hi Alexey,
> > 
> > Looking at the skiboot side I think we only fence the NVLink bricks as part of a
> > PCIe function level reset (FLR) rather than a PCI Hot or Fundamental reset which
> > I believe is what the code here does. So to fence the bricks you would need to
> > do either a FLR on the given link or alter Skiboot to fence a given link as part
> > of a hot reset.
> 
> The code here calls OPAL to execute this code:
> 
> https://github.com/open-power/skiboot/commit/fca2b2b839a673a1e52fc6b19ee6d33b2dfbc003
> 
> This resets all links on an NPU which is fine for now as we pass GPUs in
> groups only. Or I missed something?

From what I can see in
https://github.com/open-power/skiboot/commit/2947eaa14e771e572d4e84bf003318c590c1c7d4
we only fence the bricks in npu2_dev_procedure_reset()
(https://github.com/open-power/skiboot/blob/master/hw/npu2-hw-procedures.c#L937)
which itself is only called from the FLR path and not the code path you point
out above.

The code path above only resets the NTL which I don't believe is sufficient to
prevent HMIs.

- Alistair

>
> 
> 
> > 
> > - Alistair
> > 
> > On Monday, 15 October 2018 6:17:51 PM AEDT Alexey Kardashevskiy wrote:
> >> Ping?
> >>
> >>
> >> On 02/10/2018 13:20, Alexey Kardashevskiy wrote:
> >>> The skiboot firmware has a hot reset handler which fences the NVIDIA V100
> >>> GPU RAM on Witherspoons and makes accesses no-op instead of throwing HMIs:
> >>> https://github.com/open-power/skiboot/commit/fca2b2b839a67
> >>>
> >>> Now we are going to pass V100 via VFIO which most certainly involves
> >>> KVM guests which are often terminated without getting a chance to offline
> >>> GPU RAM so we end up with a running machine with misconfigured memory.
> >>> Accessing this memory produces hardware management interrupts (HMI)
> >>> which bring the host down.
> >>>
> >>> To suppress HMIs, this wires up this hot reset hook to vfio_pci_disable()
> >>> via pci_disable_device() which switches NPU2 to a safe mode and prevents
> >>> HMIs.
> >>>
> >>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>> ---
> >>> Changes:
> >>> v2:
> >>> * updated the commit log
> >>> ---
> >>>  arch/powerpc/platforms/powernv/pci-ioda.c | 10 ++++++++++
> >>>  1 file changed, 10 insertions(+)
> >>>
> >>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> >>> index cde7102..e37b9cc 100644
> >>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >>> @@ -3688,6 +3688,15 @@ static void pnv_pci_release_device(struct pci_dev *pdev)
> >>>  		pnv_ioda_release_pe(pe);
> >>>  }
> >>>  
> >>> +static void pnv_npu_disable_device(struct pci_dev *pdev)
> >>> +{
> >>> +	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
> >>> +	struct eeh_pe *eehpe = edev ? edev->pe : NULL;
> >>> +
> >>> +	if (eehpe && eeh_ops && eeh_ops->reset)
> >>> +		eeh_ops->reset(eehpe, EEH_RESET_HOT);
> >>> +}
> >>> +
> >>>  static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
> >>>  {
> >>>  	struct pnv_phb *phb = hose->private_data;
> >>> @@ -3732,6 +3741,7 @@ static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
> >>>  	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
> >>>  	.dma_set_mask		= pnv_npu_dma_set_mask,
> >>>  	.shutdown		= pnv_pci_ioda_shutdown,
> >>> +	.disable_device		= pnv_npu_disable_device,
> >>>  };
> >>>  
> >>>  static const struct pci_controller_ops pnv_npu_ocapi_ioda_controller_ops = {
> >>>
> >>
> >>
> > 
> > 
> 
> 


