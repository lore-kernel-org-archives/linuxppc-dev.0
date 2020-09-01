Return-Path: <SRS0=3GPV=CK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35989C433E2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 13:54:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A7B206EF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 13:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="GPpcXF7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A7B206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BgpTk0TSjzDqbG
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 23:54:34 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BgpQn3vwtzDqQr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2020 23:52:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=GPpcXF7G; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BgpQn0QvFz9sTN;
 Tue,  1 Sep 2020 23:52:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1598968321;
 bh=nYqvP+dw+TWX0bGiNvp1oka1bz3WEq7TaswJF5tEftU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=GPpcXF7GsgPmaYbw0Rii1WQu1TAu7F/I/vUhOMf2Rh0S4bAV8LjkkcFaiM2/f9yRX
 ij9CaL0L0Oq12GKo2VT37JTCTfsomDtCpkF2wGGSGAIKS11GzVM1U+UcL3ihILUX8s
 dqXVBv39lYt53ItgurRJH5xhd3P6vY7cXbXOF1TrzWe4w9UzzuAGWHT0E+tvZBVnrs
 +v64FSZF6Pql8Rwb+n0Do1nRkmlx6m25ZOkukRDAxdouEUDraOBthCfwVBOPBSmnvv
 FsDxh0BC/IukNZ22mvF/K5uDsRgnBQcZbpZey0gI0SPNeOz/nyAoSzMBExama2dOjO
 BQXm+RDis19Wg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv/pci: Drop pnv_phb->initialized
In-Reply-To: <20200831061500.1646445-1-oohall@gmail.com>
References: <20200831061500.1646445-1-oohall@gmail.com>
Date: Tue, 01 Sep 2020 23:52:00 +1000
Message-ID: <87h7sh1u67.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Oliver O'Halloran <oohall@gmail.com> writes:

> The pnv_phb->initialized flag is an odd beast. It was added back in 2012 in
> commit db1266c85261 ("powerpc/powernv: Skip check on PE if necessary") to
> allow devices to be enabled even if their PE assignments hadn't been
> completed yet. I can't think of any situation where we would (or should)
> have PCI devices being enabled before their PEs are assigned, so I can only
> assume it was a workaround for a bug or some other undesirable behaviour
> from the PCI core.
>
> Since commit dc3d8f85bb57 ("powerpc/powernv/pci: Re-work bus PE
> configuration") the PE setup occurs before the PCI core allows driver to
> attach to the device so the problem should no longer exist. Even it does
> allowing the device to be enabled before we have assigned the device to a
> PE is almost certainly broken and will cause spurious EEH events so we
> should probably just remove it.
>
> It's also worth pointing out that ->initialized flag is set in
> pnv_pci_ioda_create_dbgfs() which has the entire function body wrapped in
> flag.

"body wrapped in flag." ?

I guess you meant:

"wrapped in #ifdef CONFIG_DEBUG_FS" ?

> That has the fun side effect of bypassing any other checks in
> pnv_pci_enable_device_hook() which is probably not what anybody wants.

That would only be true for CONFIG_DEBUG_FS=n builds though.

cheers

> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 023a4f987bb2..6ac3c637b313 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2410,9 +2410,6 @@ static void pnv_pci_ioda_create_dbgfs(void)
>  	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
>  		phb = hose->private_data;
>  
> -		/* Notify initialization of PHB done */
> -		phb->initialized = 1;
> -
>  		sprintf(name, "PCI%04x", hose->global_number);
>  		phb->dbgfs = debugfs_create_dir(name, powerpc_debugfs_root);
>  
> @@ -2609,17 +2606,8 @@ static resource_size_t pnv_pci_default_alignment(void)
>   */
>  static bool pnv_pci_enable_device_hook(struct pci_dev *dev)
>  {
> -	struct pnv_phb *phb = pci_bus_to_pnvhb(dev->bus);
>  	struct pci_dn *pdn;
>  
> -	/* The function is probably called while the PEs have
> -	 * not be created yet. For example, resource reassignment
> -	 * during PCI probe period. We just skip the check if
> -	 * PEs isn't ready.
> -	 */
> -	if (!phb->initialized)
> -		return true;
> -
>  	pdn = pci_get_pdn(dev);
>  	if (!pdn || pdn->pe_number == IODA_INVALID_PE)
>  		return false;
> @@ -2629,14 +2617,9 @@ static bool pnv_pci_enable_device_hook(struct pci_dev *dev)
>  
>  static bool pnv_ocapi_enable_device_hook(struct pci_dev *dev)
>  {
> -	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> -	struct pnv_phb *phb = hose->private_data;
>  	struct pci_dn *pdn;
>  	struct pnv_ioda_pe *pe;
>  
> -	if (!phb->initialized)
> -		return true;
> -
>  	pdn = pci_get_pdn(dev);
>  	if (!pdn)
>  		return false;
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 739a0b3b72e1..36d22920f5a3 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -119,7 +119,6 @@ struct pnv_phb {
>  	int			flags;
>  	void __iomem		*regs;
>  	u64			regs_phys;
> -	int			initialized;
>  	spinlock_t		lock;
>  
>  #ifdef CONFIG_DEBUG_FS
> -- 
> 2.26.2
