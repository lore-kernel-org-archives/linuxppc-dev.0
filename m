Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLACK autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A17C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 02:24:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C04712075B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 02:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="XHTuwFdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04712075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43KwYl64GXzDqrs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 13:24:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="XHTuwFdv";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="XHTuwFdv"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43KwTJ19W1zDqnw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 13:20:20 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id e5so116049plb.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 18:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4CiVdK3E6J++QUqcyo9VXR0HDHNJ3zBOfF7mqpnBfnQ=;
 b=XHTuwFdvuapcsGvgIAG5kcO1mKiDD51GuCFOM4PObHG8O3E5drVx+16kGjn8UTwvO0
 6rXHOpFBpL5vfqX1nap6t6JuFRp6pwkWQM9cG7ULq+3w3G9H7Sehl5G+F3VUcpwml2w0
 BtbY8hFetc0m2KAAnyIGdfV3wdjhyxhWvPgNRHDEz4GvNiav9LpdOekjdOxf9/Vhpu9c
 VjXILii1oQEpkmJTFbrZHUE8hQsKvgYntXLrAzBJgRwxi4Glvu6meG50Le6/ge+7ZbRr
 QKLqZpOMN7PZYTn+hBhuvevDmrxb4ZpDccgXnajYmPdNh7Alv7d8Dfljw0ihzSIGdrtr
 pYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4CiVdK3E6J++QUqcyo9VXR0HDHNJ3zBOfF7mqpnBfnQ=;
 b=lS6nbyevJK9X4qBXVWkYPr87ViSxW+oL1nSudNZXOAydJ7b6YEEuecQH4MYWL24KJ1
 fOBCpW0Kht1Gk5AM5aVtdW3SysvndT26veFUfyo52MjL9mQXTIcL0Kw1vOFylWAzfSs4
 GGM/Fhq/O4Q3UNKu5m/gDgZ8C8pJbStFuNXU9/HvSrdarBc+GmFGjM6ZeJ1uar3cSMJ7
 sadEi0zlAwT3qFQLu0oVFMst1TSPj3OXmGGbnSD5WAqm5w6hQQKd9vqHSw0sLiQ8BNTe
 rR88rqxW49jCO2r9fZF2rqoNDYTOeFzg3XUaUYzvI22cwYaqT7F1SPEhMnwHxucQpPC8
 ZE+Q==
X-Gm-Message-State: AA+aEWamS/F+Z8NEIfDTwdQSK3iPTKsCCeJDf7DXeLKuI616UOq0bwG7
 7I074BgCB7SgWvMPc9DU74uuvw==
X-Google-Smtp-Source: AFSGD/WakIDFcXQoOtKo0pS/UC8jcTUJ3iTdo0FNPUZymbyQa2dFBbbBlJTtkXuTUqhMOQsXJuhWqA==
X-Received: by 2002:a17:902:7e4f:: with SMTP id
 a15mr22068310pln.149.1545272417509; 
 Wed, 19 Dec 2018 18:20:17 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id d25sm29637390pfe.40.2018.12.19.18.20.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Dec 2018 18:20:16 -0800 (PST)
Subject: Re: [PATCH kernel v6 14/20] powerpc/powernv/npu: Add compound IOMMU
 groups
To: linuxppc-dev@lists.ozlabs.org
References: <20181219085232.103441-1-aik@ozlabs.ru>
 <20181219085232.103441-15-aik@ozlabs.ru>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <973430e7-7dfd-864e-7544-e601b834b25a@ozlabs.ru>
Date: Thu, 20 Dec 2018 13:20:09 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181219085232.103441-15-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
 Sam Bobroff <sbobroff@linux.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 =?UTF-8?Q?Leonardo_Augusto_Guimar=c3=a3es_Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 19/12/2018 19:52, Alexey Kardashevskiy wrote:
> At the moment the powernv platform registers an IOMMU group for each PE.
> There is an exception though: an NVLink bridge which is attached to
> the corresponding GPU's IOMMU group making it a master.
> 
> Now we have POWER9 systems with GPUs connected to each other directly
> bypassing PCI. At the moment we do not control state of these links so
> we have to put such interconnected GPUs to one IOMMU group which
> means that the old scheme with one GPU as a master won't work - there will
> be up to 3 GPUs in such group.
> 
> This introduces a npu_comp struct which represents a compound IOMMU
> group made of multiple PEs - PCI PEs (for GPUs) and NPU PEs (for NVLink
> bridges). This converts the existing NVLink1 code to use the new scheme.
> From now on, each PE must have a valid iommu_table_group_ops which will
> either be called directly (for a single PE group) or indirectly from
> a compound group handlers.
> 
> This moves IOMMU group registration for NVLink-connected GPUs to npu-dma.c.
> For POWER8, this stores a new compound group pointer in the PE (so a GPU
> is still a master); for POWER9 the new group pointer is stored in an NPU
> (which is allocated per a PCI host controller).
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v5:
> * now read page sizes from PHB NVLink to narrow down what the compoind PE
> can actually support (hint: 4K/64K only)
> ---
>  arch/powerpc/include/asm/pci.h            |   1 +
>  arch/powerpc/platforms/powernv/pci.h      |   7 +
>  arch/powerpc/platforms/powernv/npu-dma.c  | 291 ++++++++++++++++++++--
>  arch/powerpc/platforms/powernv/pci-ioda.c | 159 ++++--------
>  4 files changed, 322 insertions(+), 136 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
> index baf2886..0c72f18 100644
> --- a/arch/powerpc/include/asm/pci.h
> +++ b/arch/powerpc/include/asm/pci.h
> @@ -132,5 +132,6 @@ extern struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index);
>  extern int pnv_npu2_init(struct pci_controller *hose);
>  extern int pnv_npu2_map_lpar_dev(struct pci_dev *gpdev, unsigned int lparid,
>  		unsigned long msr);
> +extern int pnv_npu2_unmap_lpar_dev(struct pci_dev *gpdev);
>  
>  #endif /* __ASM_POWERPC_PCI_H */
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index cf9f748..aef4bb5 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -62,6 +62,7 @@ struct pnv_ioda_pe {
>  
>  	/* "Base" iommu table, ie, 4K TCEs, 32-bit DMA */
>  	struct iommu_table_group table_group;
> +	struct npu_comp		*npucomp;
>  
>  	/* 64-bit TCE bypass region */
>  	bool			tce_bypass_enabled;
> @@ -201,6 +202,8 @@ extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
>  extern struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev);
>  extern void pnv_set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq);
>  extern void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
> +extern unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
> +		__u64 window_size, __u32 levels);
>  extern int pnv_eeh_post_init(void);
>  
>  extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
> @@ -216,6 +219,10 @@ extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
>  extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass);
>  extern void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool rm);
>  extern struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe);
> +extern struct iommu_table_group *pnv_try_setup_npu_table_group(
> +		struct pnv_ioda_pe *pe);
> +extern struct iommu_table_group *pnv_npu_compound_attach(
> +		struct pnv_ioda_pe *pe);
>  
>  /* pci-ioda-tce.c */
>  #define POWERNV_IOMMU_DEFAULT_LEVELS	1
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> index dc629ee..3468eaa 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -328,31 +328,6 @@ static struct iommu_table_group_ops pnv_pci_npu_ops = {
>  	.unset_window = pnv_npu_unset_window,
>  	.take_ownership = pnv_npu_take_ownership,
>  };
> -
> -struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
> -{
> -	struct pnv_phb *phb = npe->phb;
> -	struct pci_bus *pbus = phb->hose->bus;
> -	struct pci_dev *npdev, *gpdev = NULL, *gptmp;
> -	struct pnv_ioda_pe *gpe = get_gpu_pci_dev_and_pe(npe, &gpdev);
> -
> -	if (!gpe || !gpdev)
> -		return NULL;
> -
> -	npe->table_group.ops = &pnv_pci_npu_ops;
> -
> -	list_for_each_entry(npdev, &pbus->devices, bus_list) {
> -		gptmp = pnv_pci_get_gpu_dev(npdev);
> -
> -		if (gptmp != gpdev)
> -			continue;
> -
> -		pe_info(gpe, "Attached NPU %s\n", dev_name(&npdev->dev));
> -		iommu_group_add_device(gpe->table_group.group, &npdev->dev);
> -	}
> -
> -	return gpe;
> -}
>  #endif /* !CONFIG_IOMMU_API */
>  
>  /*
> @@ -360,6 +335,17 @@ struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
>   */
>  /* Maximum possible number of ATSD MMIO registers per NPU */
>  #define NV_NMMU_ATSD_REGS 8
> +#define NV_NPU_MAX_PE_NUM	16
> +
> +/*
> + * A compound NPU IOMMU group which might consist of 1 GPU + 2xNPUs (POWER8) or
> + * up to 3 x (GPU + 2xNPUs) (POWER9).
> + */
> +struct npu_comp {
> +	struct iommu_table_group table_group;
> +	int pe_num;
> +	struct pnv_ioda_pe *pe[NV_NPU_MAX_PE_NUM];
> +};
>  
>  /* An NPU descriptor, valid for POWER9 only */
>  struct npu {
> @@ -372,8 +358,263 @@ struct npu {
>  
>  	/* Do we need to explicitly flush the nest mmu? */
>  	bool nmmu_flush;
> +
> +	struct npu_comp npucomp;
>  };
>  
> +#ifdef CONFIG_IOMMU_API
> +static long pnv_npu_peers_create_table_userspace(
> +		struct iommu_table_group *table_group,
> +		int num, __u32 page_shift, __u64 window_size, __u32 levels,
> +		struct iommu_table **ptbl)
> +{
> +	struct npu_comp *npucomp = container_of(table_group, struct npu_comp,
> +			table_group);
> +
> +	if (!npucomp->pe_num || !npucomp->pe[0] ||
> +			!npucomp->pe[0]->table_group.ops ||
> +			!npucomp->pe[0]->table_group.ops->create_table)
> +		return -EFAULT;
> +
> +	return npucomp->pe[0]->table_group.ops->create_table(
> +			&npucomp->pe[0]->table_group, num, page_shift,
> +			window_size, levels, ptbl);
> +}
> +
> +static long pnv_npu_peers_set_window(struct iommu_table_group *table_group,
> +		int num, struct iommu_table *tbl)
> +{
> +	int i, j;
> +	long ret = 0;
> +	struct npu_comp *npucomp = container_of(table_group, struct npu_comp,
> +			table_group);
> +
> +	for (i = 0; i < npucomp->pe_num; ++i) {
> +		struct pnv_ioda_pe *pe = npucomp->pe[i];
> +
> +		if (!pe->table_group.ops->set_window)
> +			continue;
> +
> +		ret = pe->table_group.ops->set_window(&pe->table_group,
> +				num, tbl);
> +		if (ret)
> +			break;
> +	}
> +
> +	if (ret) {
> +		for (j = 0; j < i; ++j) {
> +			struct pnv_ioda_pe *pe = npucomp->pe[j];
> +
> +			if (!pe->table_group.ops->unset_window)
> +				continue;
> +
> +			ret = pe->table_group.ops->unset_window(
> +					&pe->table_group, num);
> +			if (ret)
> +				break;
> +		}
> +	} else {
> +		table_group->tables[num] = iommu_tce_table_get(tbl);
> +	}
> +
> +	return ret;
> +}
> +
> +static long pnv_npu_peers_unset_window(struct iommu_table_group *table_group,
> +		int num)
> +{
> +	int i, j;
> +	long ret = 0;
> +	struct npu_comp *npucomp = container_of(table_group, struct npu_comp,
> +			table_group);
> +
> +	for (i = 0; i < npucomp->pe_num; ++i) {
> +		struct pnv_ioda_pe *pe = npucomp->pe[i];
> +
> +		WARN_ON(npucomp->table_group.tables[num] !=
> +				table_group->tables[num]);
> +		if (!npucomp->table_group.tables[num])
> +			continue;
> +
> +		if (!pe->table_group.ops->unset_window)
> +			continue;
> +
> +		ret = pe->table_group.ops->unset_window(&pe->table_group, num);
> +		if (ret)
> +			break;
> +	}
> +
> +	if (ret) {
> +		for (j = 0; j < i; ++j) {
> +			struct pnv_ioda_pe *pe = npucomp->pe[j];
> +
> +			if (!npucomp->table_group.tables[num])
> +				continue;
> +
> +			if (!pe->table_group.ops->set_window)
> +				continue;
> +
> +			ret = pe->table_group.ops->set_window(&pe->table_group,
> +					num, table_group->tables[num]);
> +			if (ret)
> +				break;
> +		}
> +	} else if (table_group->tables[num]) {
> +		iommu_tce_table_put(table_group->tables[num]);
> +		table_group->tables[num] = NULL;
> +	}
> +
> +	return ret;
> +}
> +
> +static void pnv_npu_peers_take_ownership(struct iommu_table_group *table_group)
> +{
> +	int i;
> +	struct npu_comp *npucomp = container_of(table_group, struct npu_comp,
> +			table_group);
> +
> +	for (i = 0; i < npucomp->pe_num; ++i) {
> +		struct pnv_ioda_pe *pe = npucomp->pe[i];
> +
> +		if (!pe->table_group.ops->take_ownership)
> +			continue;
> +		pe->table_group.ops->take_ownership(&pe->table_group);
> +	}
> +}
> +
> +static void pnv_npu_peers_release_ownership(
> +		struct iommu_table_group *table_group)
> +{
> +	int i;
> +	struct npu_comp *npucomp = container_of(table_group, struct npu_comp,
> +			table_group);
> +
> +	for (i = 0; i < npucomp->pe_num; ++i) {
> +		struct pnv_ioda_pe *pe = npucomp->pe[i];
> +
> +		if (!pe->table_group.ops->release_ownership)
> +			continue;
> +		pe->table_group.ops->release_ownership(&pe->table_group);
> +	}
> +}
> +
> +static struct iommu_table_group_ops pnv_npu_peers_ops = {
> +	.get_table_size = pnv_pci_ioda2_get_table_size,
> +	.create_table = pnv_npu_peers_create_table_userspace,
> +	.set_window = pnv_npu_peers_set_window,
> +	.unset_window = pnv_npu_peers_unset_window,
> +	.take_ownership = pnv_npu_peers_take_ownership,
> +	.release_ownership = pnv_npu_peers_release_ownership,
> +};
> +
> +static void pnv_comp_attach_table_group(struct npu_comp *npucomp,
> +		struct pnv_ioda_pe *pe)
> +{
> +	if (WARN_ON(npucomp->pe_num == NV_NPU_MAX_PE_NUM))
> +		return;
> +
> +	npucomp->pe[npucomp->pe_num] = pe;
> +	++npucomp->pe_num;
> +}
> +
> +struct iommu_table_group *pnv_try_setup_npu_table_group(struct pnv_ioda_pe *pe)
> +{
> +	struct iommu_table_group *table_group;
> +	struct npu_comp *npucomp;
> +	struct pci_dev *gpdev = NULL;
> +	struct pci_controller *hose;
> +	struct pci_dev *npdev;


And of course I missed this one, again, should have been npdev=NULL
above :-/




> +
> +	list_for_each_entry(gpdev, &pe->pbus->devices, bus_list) {
> +		npdev = pnv_pci_get_npu_dev(gpdev, 0);
> +		if (npdev)
> +			break;
> +	}
> +
> +	if (!npdev)
> +		/* It is not an NPU attached device, skip */
> +		return NULL;
> +
> +	hose = pci_bus_to_host(npdev->bus);
> +
> +	if (hose->npu) {
> +		table_group = &hose->npu->npucomp.table_group;
> +
> +		if (!table_group->group) {
> +			table_group->ops = &pnv_npu_peers_ops;
> +			iommu_register_group(table_group,
> +					hose->global_number,
> +					pe->pe_number);
> +		}
> +	} else {
> +		/* Create a group for 1 GPU and attached NPUs for POWER8 */
> +		pe->npucomp = kzalloc(sizeof(pe->npucomp), GFP_KERNEL);
> +		table_group = &pe->npucomp->table_group;
> +		table_group->ops = &pnv_npu_peers_ops;
> +		iommu_register_group(table_group, hose->global_number,
> +				pe->pe_number);
> +	}
> +
> +	/* Steal capabilities from a GPU PE */
> +	table_group->max_dynamic_windows_supported =
> +		pe->table_group.max_dynamic_windows_supported;
> +	table_group->tce32_start = pe->table_group.tce32_start;
> +	table_group->tce32_size = pe->table_group.tce32_size;
> +	table_group->max_levels = pe->table_group.max_levels;
> +	if (!table_group->pgsizes)
> +		table_group->pgsizes = pe->table_group.pgsizes;
> +
> +	npucomp = container_of(table_group, struct npu_comp, table_group);
> +	pnv_comp_attach_table_group(npucomp, pe);
> +
> +	return table_group;
> +}
> +
> +struct iommu_table_group *pnv_npu_compound_attach(struct pnv_ioda_pe *pe)
> +{
> +	struct iommu_table_group *table_group;
> +	struct npu_comp *npucomp;
> +	struct pci_dev *gpdev = NULL;
> +	struct pci_dev *npdev;
> +	struct pnv_ioda_pe *gpe = get_gpu_pci_dev_and_pe(pe, &gpdev);
> +
> +	WARN_ON(!(pe->flags & PNV_IODA_PE_DEV));
> +	if (!gpe)
> +		return NULL;
> +
> +	/*
> +	 * IODA2 bridges get this set up from pci_controller_ops::setup_bridge
> +	 * but NPU bridges do not have this hook defined so we do it here.
> +	 * We do not setup other table group parameters as they won't be used
> +	 * anyway - NVLink bridges are subordinate PEs.
> +	 */
> +	pe->table_group.ops = &pnv_pci_npu_ops;
> +
> +	table_group = iommu_group_get_iommudata(
> +			iommu_group_get(&gpdev->dev));
> +
> +	/*
> +	 * On P9 NPU PHB and PCI PHB support different page sizes,
> +	 * keep only matching. We expect here that NVLink bridge PE pgsizes is
> +	 * initialized by the caller.
> +	 */
> +	table_group->pgsizes &= pe->table_group.pgsizes;
> +	npucomp = container_of(table_group, struct npu_comp, table_group);
> +	pnv_comp_attach_table_group(npucomp, pe);
> +
> +	list_for_each_entry(npdev, &pe->phb->hose->bus->devices, bus_list) {
> +		struct pci_dev *gpdevtmp = pnv_pci_get_gpu_dev(npdev);
> +
> +		if (gpdevtmp != gpdev)
> +			continue;
> +
> +		iommu_add_device(table_group, &npdev->dev);
> +	}
> +
> +	return table_group;
> +}
> +#endif /* CONFIG_IOMMU_API */
> +
>  /* Maximum number of nvlinks per npu */
>  #define NV_MAX_LINKS 6
>  
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 6972054..6fe8907 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -190,7 +190,8 @@ static void pnv_ioda_free_pe(struct pnv_ioda_pe *pe)
>  	unsigned int pe_num = pe->pe_number;
>  
>  	WARN_ON(pe->pdev);
> -
> +	WARN_ON(pe->npucomp); /* NPUs are not supposed to be freed */
> +	kfree(pe->npucomp);
>  	memset(pe, 0, sizeof(struct pnv_ioda_pe));
>  	clear_bit(pe_num, phb->ioda.pe_alloc);
>  }
> @@ -1539,7 +1540,9 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
>  static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>  				       struct pnv_ioda_pe *pe);
>  #ifdef CONFIG_IOMMU_API
> -static void pnv_ioda_setup_bus_iommu_group(struct pnv_ioda_pe *pe);
> +static void pnv_ioda_setup_bus_iommu_group(struct pnv_ioda_pe *pe,
> +		struct iommu_table_group *table_group, struct pci_bus *bus);
> +
>  #endif
>  static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
>  {
> @@ -1595,7 +1598,7 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
>  
>  		pnv_pci_ioda2_setup_dma_pe(phb, pe);
>  #ifdef CONFIG_IOMMU_API
> -		pnv_ioda_setup_bus_iommu_group(pe);
> +		pnv_ioda_setup_bus_iommu_group(pe, &pe->table_group, NULL);
>  #endif
>  	}
>  }
> @@ -2557,7 +2560,7 @@ static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
>  #endif
>  
>  #ifdef CONFIG_IOMMU_API
> -static unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
> +unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
>  		__u64 window_size, __u32 levels)
>  {
>  	unsigned long bytes = 0;
> @@ -2631,127 +2634,40 @@ static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
>  	.release_ownership = pnv_ioda2_release_ownership,
>  };
>  
> -static int gpe_table_group_to_npe_cb(struct device *dev, void *opaque)
> -{
> -	struct pci_controller *hose;
> -	struct pnv_phb *phb;
> -	struct pnv_ioda_pe **ptmppe = opaque;
> -	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> -	struct pci_dn *pdn = pci_get_pdn(pdev);
> -
> -	if (!pdn || pdn->pe_number == IODA_INVALID_PE)
> -		return 0;
> -
> -	hose = pci_bus_to_host(pdev->bus);
> -	phb = hose->private_data;
> -	if (phb->type != PNV_PHB_NPU_NVLINK)
> -		return 0;
> -
> -	*ptmppe = &phb->ioda.pe_array[pdn->pe_number];
> -
> -	return 1;
> -}
> -
> -/*
> - * This returns PE of associated NPU.
> - * This assumes that NPU is in the same IOMMU group with GPU and there is
> - * no other PEs.
> - */
> -static struct pnv_ioda_pe *gpe_table_group_to_npe(
> -		struct iommu_table_group *table_group)
> -{
> -	struct pnv_ioda_pe *npe = NULL;
> -	int ret = iommu_group_for_each_dev(table_group->group, &npe,
> -			gpe_table_group_to_npe_cb);
> -
> -	BUG_ON(!ret || !npe);
> -
> -	return npe;
> -}
> -
> -static long pnv_pci_ioda2_npu_set_window(struct iommu_table_group *table_group,
> -		int num, struct iommu_table *tbl)
> -{
> -	struct pnv_ioda_pe *npe = gpe_table_group_to_npe(table_group);
> -	long ret = pnv_pci_ioda2_set_window(table_group, num, tbl);
> -
> -	if (ret)
> -		return ret;
> -
> -	ret = npe->table_group.ops->set_window(&npe->table_group, num, tbl);
> -	if (ret)
> -		pnv_pci_ioda2_unset_window(table_group, num);
> -
> -	return ret;
> -}
> -
> -static long pnv_pci_ioda2_npu_unset_window(
> -		struct iommu_table_group *table_group,
> -		int num)
> -{
> -	struct pnv_ioda_pe *npe = gpe_table_group_to_npe(table_group);
> -	long ret = pnv_pci_ioda2_unset_window(table_group, num);
> -
> -	if (ret)
> -		return ret;
> -
> -	return npe->table_group.ops->unset_window(&npe->table_group, num);
> -}
> -
> -static void pnv_ioda2_npu_take_ownership(struct iommu_table_group *table_group)
> -{
> -	struct pnv_ioda_pe *npe = gpe_table_group_to_npe(table_group);
> -
> -	npe->table_group.ops->take_ownership(&npe->table_group);
> -	pnv_ioda2_take_ownership(table_group);
> -}
> -
> -static struct iommu_table_group_ops pnv_pci_ioda2_npu_ops = {
> -	.get_table_size = pnv_pci_ioda2_get_table_size,
> -	.create_table = pnv_pci_ioda2_create_table_userspace,
> -	.set_window = pnv_pci_ioda2_npu_set_window,
> -	.unset_window = pnv_pci_ioda2_npu_unset_window,
> -	.take_ownership = pnv_ioda2_npu_take_ownership,
> -	.release_ownership = pnv_ioda2_release_ownership,
> -};
> -
>  static void pnv_ioda_setup_bus_iommu_group_add_devices(struct pnv_ioda_pe *pe,
> +		struct iommu_table_group *table_group,
>  		struct pci_bus *bus)
>  {
>  	struct pci_dev *dev;
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> -		iommu_add_device(&pe->table_group, &dev->dev);
> +		iommu_add_device(table_group, &dev->dev);
>  
>  		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
>  			pnv_ioda_setup_bus_iommu_group_add_devices(pe,
> -					dev->subordinate);
> +					table_group, dev->subordinate);
>  	}
>  }
>  
> -static void pnv_ioda_setup_bus_iommu_group(struct pnv_ioda_pe *pe)
> +static void pnv_ioda_setup_bus_iommu_group(struct pnv_ioda_pe *pe,
> +		struct iommu_table_group *table_group, struct pci_bus *bus)
>  {
> -	if (!pnv_pci_ioda_pe_dma_weight(pe))
> -		return;
>  
> -	iommu_register_group(&pe->table_group, pe->phb->hose->global_number,
> -			pe->pe_number);
> -
> -	/*
> -	 * set_iommu_table_base(&pe->pdev->dev, tbl) should have been called
> -	 * by now
> -	 */
>  	if (pe->flags & PNV_IODA_PE_DEV)
> -		iommu_add_device(&pe->table_group, &pe->pdev->dev);
> -	else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
> -		pnv_ioda_setup_bus_iommu_group_add_devices(pe, pe->pbus);
> +		iommu_add_device(table_group, &pe->pdev->dev);
> +
> +	if ((pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)) || bus)
> +		pnv_ioda_setup_bus_iommu_group_add_devices(pe, table_group,
> +				bus);
>  }
>  
> +static unsigned long pnv_ioda_parse_tce_sizes(struct pnv_phb *phb);
> +
>  static void pnv_pci_ioda_setup_iommu_api(void)
>  {
> -	struct pci_controller *hose, *tmp;
> +	struct pci_controller *hose;
>  	struct pnv_phb *phb;
> -	struct pnv_ioda_pe *pe, *gpe;
> +	struct pnv_ioda_pe *pe;
>  
>  	/*
>  	 * There are 4 types of PEs:
> @@ -2773,24 +2689,45 @@ static void pnv_pci_ioda_setup_iommu_api(void)
>  		if (phb->type == PNV_PHB_NPU_NVLINK)
>  			continue;
>  
> -		list_for_each_entry(pe, &phb->ioda.pe_list, list)
> -			pnv_ioda_setup_bus_iommu_group(pe);
> +		list_for_each_entry(pe, &phb->ioda.pe_list, list) {
> +			struct iommu_table_group *table_group;
> +
> +			table_group = pnv_try_setup_npu_table_group(pe);
> +			if (!table_group) {
> +				if (!pnv_pci_ioda_pe_dma_weight(pe))
> +					continue;
> +
> +				table_group = &pe->table_group;
> +				iommu_register_group(&pe->table_group,
> +						pe->phb->hose->global_number,
> +						pe->pe_number);
> +			}
> +			pnv_ioda_setup_bus_iommu_group(pe, table_group,
> +					pe->pbus);
> +		}
>  	}
>  
>  	/*
>  	 * Now we have all PHBs discovered, time to add NPU devices to
>  	 * the corresponding IOMMU groups.
>  	 */
> -	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
> +	list_for_each_entry(hose, &hose_list, list_node) {
> +		unsigned long  pgsizes;
> +
>  		phb = hose->private_data;
>  
>  		if (phb->type != PNV_PHB_NPU_NVLINK)
>  			continue;
>  
> +		pgsizes = pnv_ioda_parse_tce_sizes(phb);
>  		list_for_each_entry(pe, &phb->ioda.pe_list, list) {
> -			gpe = pnv_pci_npu_setup_iommu(pe);
> -			if (gpe)
> -				gpe->table_group.ops = &pnv_pci_ioda2_npu_ops;
> +			/*
> +			 * IODA2 bridges get this set up from
> +			 * pci_controller_ops::setup_bridge but NPU bridges
> +			 * do not have this hook defined so we do it here.
> +			 */
> +			pe->table_group.pgsizes = pgsizes;
> +			pnv_npu_compound_attach(pe);
>  		}
>  	}
>  }
> 

-- 
Alexey
