Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82E3C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 23:38:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E942184C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 23:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E942184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43KDx13ykZzDqf8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 10:38:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43KDsW2hnCzDqc3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 10:35:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43KDsW17cqz9s7W;
 Wed, 19 Dec 2018 10:35:27 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH kernel v5 10/20] powerpc/iommu_api: Move IOMMU groups
 setup to a single place
In-Reply-To: <20181213061734.16651-11-aik@ozlabs.ru>
References: <20181213061734.16651-1-aik@ozlabs.ru>
 <20181213061734.16651-11-aik@ozlabs.ru>
Date: Wed, 19 Dec 2018 10:35:27 +1100
Message-ID: <87sgyus91c.fsf@concordia.ellerman.id.au>
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
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>, kvm-ppc@vger.kernel.org,
 Sam Bobroff <sbobroff@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Leonardo Augusto =?utf-8?Q?Guimar=C3=A3es?= Garcia <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index b86a6e0..1168b185 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2735,12 +2733,68 @@ static struct iommu_table_group_ops pnv_pci_ioda2_npu_ops = {
>  	.release_ownership = pnv_ioda2_release_ownership,
>  };
>  
> +static void pnv_ioda_setup_bus_iommu_group_add_devices(struct pnv_ioda_pe *pe,
> +		struct pci_bus *bus)
> +{
> +	struct pci_dev *dev;
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		iommu_add_device(&pe->table_group, &dev->dev);
> +
> +		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
> +			pnv_ioda_setup_bus_iommu_group_add_devices(pe,
> +					dev->subordinate);
> +	}
> +}
> +
> +static void pnv_ioda_setup_bus_iommu_group(struct pnv_ioda_pe *pe)
> +{
> +	if (!pnv_pci_ioda_pe_dma_weight(pe))
> +		return;
> +
> +	iommu_register_group(&pe->table_group, pe->phb->hose->global_number,
> +			pe->pe_number);
> +
> +	/*
> +	 * set_iommu_table_base(&pe->pdev->dev, tbl) should have been called
> +	 * by now
> +	 */
> +	if (pe->flags & PNV_IODA_PE_DEV)
> +		iommu_add_device(&pe->table_group, &pe->pdev->dev);
> +	else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
> +		pnv_ioda_setup_bus_iommu_group_add_devices(pe, pe->pbus);
> +}
> +

This breaks skiroot_defconfig with:

arch/powerpc/platforms/powernv/pci-ioda.c:2731:13: error: 'pnv_ioda_setup_bus_iommu_group' defined but not used [-Werror=unused-function]

  http://kisskb.ellerman.id.au/kisskb/buildresult/13623033/

cheers
