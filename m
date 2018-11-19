Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0D3C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 02:31:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 829F02080F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 02:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="f4052Q5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829F02080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ytBj26f0zF3WD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 13:31:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="f4052Q5X";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="f4052Q5X"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42yt7y1X0wzF3Qr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 13:29:16 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id d72so9668958pga.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Nov 2018 18:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nSlgI1RQt8UaxFkRy43VQAvFviOSKe0qmp9R3hm2RTM=;
 b=f4052Q5XVNm7CIwa3LInAN3LHo8JV7PR9/5NJkZXfZzBP80Yt4Vb3b6ouDkhD1RfGG
 wq7LXLcPwhrm6K2xbCfoc67mmZk77e1o4rDDbGP9lHIWPGZaQnOZdbzaVhHSMwkbEXHH
 k074g5zVIAalGmX1suK8jpgW+Mx4DeFwWnp55wBixWM3sXvbYZOkGPnE0DRMwx8SmBDj
 qK1mifBNWnwV18I0UNu+TfLjWmFXLT5/C9qgsIvk53rr1Ni0fFjrFU+S/NWgwYkJZc/2
 mpK7ckRHFPpK9UZYmr7/RajaAXx2gq4QFYsaOuV5EyQwYmQ+pE0mBsKRlFPbszyjOLlO
 UPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=nSlgI1RQt8UaxFkRy43VQAvFviOSKe0qmp9R3hm2RTM=;
 b=Nq/2jxcmrxM7zN9tu3UFOzjE6EJjNC1IeTtJZN7dkjKYLn4wHnjuSMEXn8gQ+udNEB
 xIWaKhXrS9SGElli/9CFURviOZcBnTJM8SSycUHhjnr6rUGlzFrWWGNRDSi1RQQfxhVR
 e6iXMRM3sA6K3U/O3KG2PlpmiEPmvxymfIsgn9LairmnkNmVvrZfo8/fUBObu5FfyYpF
 cP80aslETc1VwjXKPPlz/WDp1kAlim3xRcLMtNWbiT9DxlSu+tnppPAN4TgzjH/uh56n
 Glh4h+Uo/XTt2BKNdoPcOZdEZmrlsJQ8Dq+09iU1U5EX/3+uuxZ8F/PBJmys0nSPYd9i
 Ypfg==
X-Gm-Message-State: AGRZ1gI5qLkYAg12cxru78B/GFI+I9rOwgl2U26tCF1vagrF+IdDDyQ/
 AXljXY8AEWSc8mOyw+19bZqEkg==
X-Google-Smtp-Source: AJdET5ed0PnlX09U5k5BmcES5KKAt29TWohfA4iWyh/giElN4ANzpaqjxSBWnVLGdzUx89/wgaBRpA==
X-Received: by 2002:a63:cd17:: with SMTP id i23mr18325608pgg.13.1542594554580; 
 Sun, 18 Nov 2018 18:29:14 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id j64-v6sm10257114pfc.43.2018.11.18.18.29.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Nov 2018 18:29:13 -0800 (PST)
Subject: Re: [PATCH kernel v3 18/22] powerpc/powernv/npu: Add compound IOMMU
 groups
To: David Gibson <david@gibson.dropbear.id.au>
References: <20181113082823.2440-1-aik@ozlabs.ru>
 <20181113082823.2440-19-aik@ozlabs.ru> <20181119011242.GB23503@umbus>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <269f52ee-e0b6-5adc-fd81-4befd98b0d0c@ozlabs.ru>
Date: Mon, 19 Nov 2018 13:29:07 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181119011242.GB23503@umbus>
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Sam Bobroff <sbobroff@linux.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 =?UTF-8?Q?Leonardo_Augusto_Guimar=c3=a3es_Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 19/11/2018 12:12, David Gibson wrote:
> On Tue, Nov 13, 2018 at 07:28:19PM +1100, Alexey Kardashevskiy wrote:
>> At the moment powernv registers an IOMMU group for each PE. There is
>> an exception though - NPU (an emulated PCI bridge representing an NVLink);
>> powernv attaches these bridges to the GPU IOMMU group which becomes
>> a master.
>>
>> Now we have POWER9 systems with GPUs connected to each other directly,
>> bypassing PCI. At the moment powernv does not control these links so
>> it has to put such interconnected GPUs to the same IOMMU group which
>> means that the old scheme with a GPU as a master won't work - there will
>> be up to 3 GPUs in such group.
>>
>> This introduces a npu_comp struct which represents a compound IOMMU
>> group made of multiple PEs. This converts the existing NVLink1 code to
>> use the new scheme. From now on, each PE must have a valid
>> iommu_table_group_ops which will either be called directly (a single PE
>> group) or indirectly from a compound group.
>>
>> This moves IOMMU group registration for NPU-connected GPUs to npu-dma.c.
>> For POWER8, this stores a new compound group pointer in a PE (so a GPU
>> is still a master); for POWER9 the new group pointer is stored in an NPU.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  arch/powerpc/include/asm/pci.h            |   1 +
>>  arch/powerpc/platforms/powernv/pci.h      |   7 +
>>  arch/powerpc/platforms/powernv/npu-dma.c  | 286 ++++++++++++++++++++--
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 173 +++----------
>>  4 files changed, 308 insertions(+), 159 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
>> index baf2886..0c72f18 100644
>> --- a/arch/powerpc/include/asm/pci.h
>> +++ b/arch/powerpc/include/asm/pci.h
>> @@ -132,5 +132,6 @@ extern struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index);
>>  extern int pnv_npu2_init(struct pci_controller *hose);
>>  extern int pnv_npu2_map_lpar_dev(struct pci_dev *gpdev, unsigned int lparid,
>>  		unsigned long msr);
>> +extern int pnv_npu2_unmap_lpar_dev(struct pci_dev *gpdev);
>>  
>>  #endif /* __ASM_POWERPC_PCI_H */
>> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>> index cf9f748..aef4bb5 100644
>> --- a/arch/powerpc/platforms/powernv/pci.h
>> +++ b/arch/powerpc/platforms/powernv/pci.h
>> @@ -62,6 +62,7 @@ struct pnv_ioda_pe {
>>  
>>  	/* "Base" iommu table, ie, 4K TCEs, 32-bit DMA */
>>  	struct iommu_table_group table_group;
>> +	struct npu_comp		*npucomp;
>>  
>>  	/* 64-bit TCE bypass region */
>>  	bool			tce_bypass_enabled;
>> @@ -201,6 +202,8 @@ extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
>>  extern struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev);
>>  extern void pnv_set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq);
>>  extern void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
>> +extern unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
>> +		__u64 window_size, __u32 levels);
>>  extern int pnv_eeh_post_init(void);
>>  
>>  extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
>> @@ -216,6 +219,10 @@ extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
>>  extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass);
>>  extern void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool rm);
>>  extern struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe);
>> +extern struct iommu_table_group *pnv_try_setup_npu_table_group(
>> +		struct pnv_ioda_pe *pe);
>> +extern struct iommu_table_group *pnv_npu_compound_attach(
>> +		struct pnv_ioda_pe *pe);
>>  
>>  /* pci-ioda-tce.c */
>>  #define POWERNV_IOMMU_DEFAULT_LEVELS	1
>> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
>> index 1792c7e..2231f4c 100644
>> --- a/arch/powerpc/platforms/powernv/npu-dma.c
>> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
>> @@ -317,31 +317,6 @@ static struct iommu_table_group_ops pnv_pci_npu_ops = {
>>  	.unset_window = pnv_npu_unset_window,
>>  	.take_ownership = pnv_npu_take_ownership,
>>  };
>> -
>> -struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
>> -{
>> -	struct pnv_phb *phb = npe->phb;
>> -	struct pci_bus *pbus = phb->hose->bus;
>> -	struct pci_dev *npdev, *gpdev = NULL, *gptmp;
>> -	struct pnv_ioda_pe *gpe = get_gpu_pci_dev_and_pe(npe, &gpdev);
>> -
>> -	if (!gpe || !gpdev)
>> -		return NULL;
>> -
>> -	npe->table_group.ops = &pnv_pci_npu_ops;
>> -
>> -	list_for_each_entry(npdev, &pbus->devices, bus_list) {
>> -		gptmp = pnv_pci_get_gpu_dev(npdev);
>> -
>> -		if (gptmp != gpdev)
>> -			continue;
>> -
>> -		pe_info(gpe, "Attached NPU %s\n", dev_name(&npdev->dev));
>> -		iommu_group_add_device(gpe->table_group.group, &npdev->dev);
>> -	}
>> -
>> -	return gpe;
>> -}
>>  #endif /* !CONFIG_IOMMU_API */
>>  
>>  /*
>> @@ -349,6 +324,17 @@ struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
>>   */
>>  /* Maximum possible number of ATSD MMIO registers per NPU */
>>  #define NV_NMMU_ATSD_REGS 8
>> +#define NV_NPU_MAX_PE_NUM	16
>> +
>> +/*
>> + * A compound NPU IOMMU group which might consist of 1 GPU + 2xNPUs (POWER8) or
>> + * up to 3 x (GPU + 2xNPUs) (POWER9).
>> + */
>> +struct npu_comp {
>> +	struct iommu_table_group table_group;
>> +	int pe_num;
>> +	struct pnv_ioda_pe *pe[NV_NPU_MAX_PE_NUM];
>> +};
>>  
>>  /* An NPU descriptor, valid for POWER9 only */
>>  struct npu {
>> @@ -365,6 +351,8 @@ struct npu {
>>  	struct list_head next;
>>  
>>  	struct pci_controller *hose;
>> +
>> +	struct npu_comp npucomp;
>>  };
> 
> I'm confused by this.  The comment simply there are multiple NPUs in a
> single composite-group, but the np_comp structure is embedded in the
> npu structure, implying there's a copy per-NPU.


Yeah, there is a naming confusion. NPU is a big chunk in the CPU with 6
links, and this is what the "struct npu" above describes.

And there are 6 NPU emulated bridge devices which you can see in lspci
with the "ibmnpu" driver bound to them.

I guess from now on I will refer to the big NPU as "NPU" and to the
emulated bridge device as "NVLink2" or "NVlink2 emulated device" unless
you have a better suggestion (Alistair does not though).



-- 
Alexey
