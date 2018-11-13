Return-Path: <SRS0=INWp=NY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4E7C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 06:15:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40CB421780
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 06:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="DLnB6QXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40CB421780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vHRs13FGzF3ND
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 17:15:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="DLnB6QXX";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="DLnB6QXX"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vHP002QGzF3HF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 17:13:07 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id t13so2506604ply.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 22:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Auhw86+HfCGXY6FPIRP6Zo9PYuGY65o9RaBIlgKKWOM=;
 b=DLnB6QXX/rQb75XXcWW3O8SnwwAYyxoBNZHAlRNqykvT+OxrJl4gllVDj2QRF03wgG
 dzODiqcRNLuHQ3GfRkdH6yw9Xu0EqkCehJt0s1VXGAS+lsYV4ZKS01Z95DczDVR99XUE
 c6mT1LWwOFllOigQXWcAoANeTs309cJ4TSxs9fTSonLmDjrHrB7OFsGkCgTooCLa4Tje
 b0UGBTh4RHSDdQKD3Rbf5hxs0c4WYTLqKFJ3dPxxJfCvigUtTm/BjIcgwa+EjDjyV4CG
 rmxw2stEqlRPcMJAW87Kx0aUtLcgQzPkESzFvDSrmiZgJvovM+xFf1vtubPieyECit8W
 QMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Auhw86+HfCGXY6FPIRP6Zo9PYuGY65o9RaBIlgKKWOM=;
 b=Gd/TxNcVai3D2WfhxTQ53ftdsYELc5UJLWhTlADNoTVhj3fc+Lxi5qz15E7QjVkubH
 xV2chM/3eo27haORZxr8Coim52SkLFqCl0DEOoJXGu1CjSyBcImMIEUo8rjLBd+PNORR
 1czYdXbxMy9LVN77p5hfEWxFeB+lGJWk1yIeI+sfPkctiQGhLHSnE+gZ02nYCOxxEibI
 95Ln+jTIrsnTJ6OMeyOAeMVj0Ew+GQ2RBXRezTniXG4lKEtdIZKeQhNR7Paa2io96mdn
 w66oE/9DltuY05NdPXCJdm79KPEJht5RCCoddT2QLMf8c/AUB3B1sINIHLCnToyCmBHr
 wyXg==
X-Gm-Message-State: AGRZ1gJ7g7nt9Goj4FJnNZyA+w6m9zgCDoybiaw3n7D5F9RcoBl1Jy+S
 AHg/JWBlutzZOuyi4H7KlNoJeQ==
X-Google-Smtp-Source: AJdET5cjl62lCAsJQHg/BUYbSFoKX3W/PbeAzxLmMqgEaRGorx2KQbDmeLPq89zC/M7YgIugubEsNw==
X-Received: by 2002:a17:902:148:: with SMTP id
 66-v6mr3884378plb.66.1542089585751; 
 Mon, 12 Nov 2018 22:13:05 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id d21sm8325901pgv.37.2018.11.12.22.13.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Nov 2018 22:13:05 -0800 (PST)
Subject: Re: [PATCH kernel 4/5] powerpc/powernv/npu: Factor out OPAL calls
 from context manipulation
To: David Gibson <david@gibson.dropbear.id.au>
References: <20181015093301.1007-1-aik@ozlabs.ru>
 <20181015093301.1007-5-aik@ozlabs.ru> <20181108050540.GM5575@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 xsFNBE+rT0sBEADFEI2UtPRsLLvnRf+tI9nA8T91+jDK3NLkqV+2DKHkTGPP5qzDZpRSH6mD
 EePO1JqpVuIow/wGud9xaPA5uvuVgRS1q7RU8otD+7VLDFzPRiRE4Jfr2CW89Ox6BF+q5ZPV
 /pS4v4G9eOrw1v09lEKHB9WtiBVhhxKK1LnUjPEH3ifkOkgW7jFfoYgTdtB3XaXVgYnNPDFo
 PTBYsJy+wr89XfyHr2Ev7BB3Xaf7qICXdBF8MEVY8t/UFsesg4wFWOuzCfqxFmKEaPDZlTuR
 tfLAeVpslNfWCi5ybPlowLx6KJqOsI9R2a9o4qRXWGP7IwiMRAC3iiPyk9cknt8ee6EUIxI6
 t847eFaVKI/6WcxhszI0R6Cj+N4y+1rHfkGWYWupCiHwj9DjILW9iEAncVgQmkNPpUsZECLT
 WQzMuVSxjuXW4nJ6f4OFHqL2dU//qR+BM/eJ0TT3OnfLcPqfucGxubhT7n/CXUxEy+mvWwnm
 s9p4uqVpTfEuzQ0/bE6t7dZdPBua7eYox1AQnk8JQDwC3Rn9kZq2O7u5KuJP5MfludMmQevm
 pHYEMF4vZuIpWcOrrSctJfIIEyhDoDmR34bCXAZfNJ4p4H6TPqPh671uMQV82CfTxTrMhGFq
 8WYU2AH86FrVQfWoH09z1WqhlOm/KZhAV5FndwVjQJs1MRXD8QARAQABzSRBbGV4ZXkgS2Fy
 ZGFzaGV2c2tpeSA8YWlrQG96bGFicy5ydT7CwXgEEwECACIFAk+rT0sCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAAAoJEIYTPdgrwSC5fAIP/0wf/oSYaCq9PhO0UP9zLSEz66SSZUf7
 AM9O1rau1lJpT8RoNa0hXFXIVbqPPKPZgorQV8SVmYRLr0oSmPnTiZC82x2dJGOR8x4E01gK
 TanY53J/Z6+CpYykqcIpOlGsytUTBA+AFOpdaFxnJ9a8p2wA586fhCZHVpV7W6EtUPH1SFTQ
 q5xvBmr3KkWGjz1FSLH4FeB70zP6uyuf/B2KPmdlPkyuoafl2UrU8LBADi/efc53PZUAREih
 sm3ch4AxaL4QIWOmlE93S+9nHZSRo9jgGXB1LzAiMRII3/2Leg7O4hBHZ9Nki8/fbDo5///+
 kD4L7UNbSUM/ACWHhd4m1zkzTbyRzvL8NAVQ3rckLOmju7Eu9whiPueGMi5sihy9VQKHmEOx
 OMEhxLRQbzj4ypRLS9a+oxk1BMMu9cd/TccNy0uwx2UUjDQw/cXw2rRWTRCxoKmUsQ+eNWEd
 iYLW6TCfl9CfHlT6A7Zmeqx2DCeFafqEd69DqR9A8W5rx6LQcl0iOlkNqJxxbbW3ddDsLU/Y
 r4cY20++WwOhSNghhtrroP+gouTOIrNE/tvG16jHs8nrYBZuc02nfX1/gd8eguNfVX/ZTHiR
 gHBWe40xBKwBEK2UeqSpeVTohYWGBkcd64naGtK9qHdo1zY1P55lHEc5Uhlk743PgAnOi27Q
 ns5zzsFNBE+rT0sBEACnV6GBSm+25ACT+XAE0t6HHAwDy+UKfPNaQBNTTt31GIk5aXb2Kl/p
 AgwZhQFEjZwDbl9D/f2GtmUHWKcCmWsYd5M/6Ljnbp0Ti5/xi6FyfqnO+G/wD2VhGcKBId1X
 Em/B5y1kZVbzcGVjgD3HiRTqE63UPld45bgK2XVbi2+x8lFvzuFq56E3ZsJZ+WrXpArQXib2
 hzNFwQleq/KLBDOqTT7H+NpjPFR09Qzfa7wIU6pMNF2uFg5ihb+KatxgRDHg70+BzQfa6PPA
 o1xioKXW1eHeRGMmULM0Eweuvpc7/STD3K7EJ5bBq8svoXKuRxoWRkAp9Ll65KTUXgfS+c0x
 gkzJAn8aTG0z/oEJCKPJ08CtYQ5j7AgWJBIqG+PpYrEkhjzSn+DZ5Yl8r+JnZ2cJlYsUHAB9
 jwBnWmLCR3gfop65q84zLXRQKWkASRhBp4JK3IS2Zz7Nd/Sqsowwh8x+3/IUxVEIMaVoUaxk
 Wt8kx40h3VrnLTFRQwQChm/TBtXqVFIuv7/Mhvvcq11xnzKjm2FCnTvCh6T2wJw3de6kYjCO
 7wsaQ2y3i1Gkad45S0hzag/AuhQJbieowKecuI7WSeV8AOFVHmgfhKti8t4Ff758Z0tw5Fpc
 BFDngh6Lty9yR/fKrbkkp6ux1gJ2QncwK1v5kFks82Cgj+DSXK6GUQARAQABwsFfBBgBAgAJ
 BQJPq09LAhsMAAoJEIYTPdgrwSC5NYEP/2DmcEa7K9A+BT2+G5GXaaiFa098DeDrnjmRvumJ
 BhA1UdZRdfqICBADmKHlJjj2xYo387sZpS6ABbhrFxM6s37g/pGPvFUFn49C47SqkoGcbeDz
 Ha7JHyYUC+Tz1dpB8EQDh5xHMXj7t59mRDgsZ2uVBKtXj2ZkbizSHlyoeCfs1gZKQgQE8Ffc
 F8eWKoqAQtn3j4nE3RXbxzTJJfExjFB53vy2wV48fUBdyoXKwE85fiPglQ8bU++0XdOr9oyy
 j1llZlB9t3tKVv401JAdX8EN0++ETiOovQdzE1m+6ioDCtKEx84ObZJM0yGSEGEanrWjiwsa
 nzeK0pJQM9EwoEYi8TBGhHC9ksaAAQipSH7F2OHSYIlYtd91QoiemgclZcSgrxKSJhyFhmLr
 QEiEILTKn/pqJfhHU/7R7UtlDAmFMUp7ByywB4JLcyD10lTmrEJ0iyRRTVfDrfVP82aMBXgF
 tKQaCxcmLCaEtrSrYGzd1sSPwJne9ssfq0SE/LM1J7VdCjm6OWV33SwKrfd6rOtvOzgadrG6
 3bgUVBw+bsXhWDd8tvuCXmdY4bnUblxF2B6GOwSY43v6suugBttIyW5Bl2tXSTwP+zQisOJo
 +dpVG2pRr39h+buHB3NY83NEPXm1kUOhduJUA17XUY6QQCAaN4sdwPqHq938S3EmtVhs
Message-ID: <2ac56bed-7cc9-11c6-85dd-fd0f841354f1@ozlabs.ru>
Date: Tue, 13 Nov 2018 17:13:01 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181108050540.GM5575@umbus.fritz.box>
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
Cc: Alistair Popple <alistair@popple.id.au>,
 Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 08/11/2018 16:05, David Gibson wrote:
> On Mon, Oct 15, 2018 at 08:33:00PM +1100, Alexey Kardashevskiy wrote:
>> At the moment the NPU context init/destroy code calls OPAL. The init
>> handler in OPAL configures the NPU to pass ATS requests to nested MMU,
>> the destroy handler does nothing besides sanity checks.
>>
>> Since the init handler programs the NPU with a wildcard for LPID/PID,
>> this can be done at the point where a GPU is mapped to an LPAR; it also
>> makes calling opal_npu_destroy_context() unnecessary in this context
>> (this will change with VFIO later though).
> 
> I think this wants a bit more explanation.  It certainly makes me
> nervous removing the destroy_context calls with nothing replacing
> them.
> 
>> Also, the pnv_npu2_init() helper does not really need to call OPAL as
>> well as it inialized an NPU structure and does not interact with GPU or
>> NPU at that moment.
>>
>> This moves OPAL calls to a separate helper. With this change, the API
>> for GPUs does not do any OPAL calls and therefore can be used by both
>> pseries and powernv platforms. The new pnv_npu2_map_lpar_phb() helper
>> should be called on powernv only as it does OPAL calls and it takes
>> an MSR mask which NPU adds to ATS requests so nested MMU knows what
>> translations are permitted; the VFIO/KVM will not set MSR_HV.
>>
>> This removes the check for FW_FEATURE_OPAL as pnv_npu2_init_context/
>> pnv_npu2_release_context/pnv_npu2_init do not call OPAL anymore.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  arch/powerpc/include/asm/pci.h            |   1 +
>>  arch/powerpc/platforms/powernv/pci.h      |   2 +-
>>  arch/powerpc/platforms/powernv/npu-dma.c  | 100 +++++++++++++++---------------
>>  arch/powerpc/platforms/powernv/pci-ioda.c |   7 ++-
>>  4 files changed, 57 insertions(+), 53 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
>> index 1a96075..f196df6 100644
>> --- a/arch/powerpc/include/asm/pci.h
>> +++ b/arch/powerpc/include/asm/pci.h
>> @@ -130,5 +130,6 @@ extern void pcibios_scan_phb(struct pci_controller *hose);
>>  extern struct pci_dev *pnv_pci_get_gpu_dev(struct pci_dev *npdev);
>>  extern struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index);
>>  extern void pnv_npu2_devices_init(void);
>> +extern int pnv_npu2_init(struct pci_controller *hose);
>>  
>>  #endif /* __ASM_POWERPC_PCI_H */
>> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>> index 3b7617d..ca2ce4b 100644
>> --- a/arch/powerpc/platforms/powernv/pci.h
>> +++ b/arch/powerpc/platforms/powernv/pci.h
>> @@ -224,7 +224,7 @@ extern long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
>>  extern long pnv_npu_unset_window(struct pnv_ioda_pe *npe, int num);
>>  extern void pnv_npu_take_ownership(struct pnv_ioda_pe *npe);
>>  extern void pnv_npu_release_ownership(struct pnv_ioda_pe *npe);
>> -extern int pnv_npu2_init(struct pnv_phb *phb);
>> +extern void pnv_npu2_map_lpar_phb(struct pnv_phb *nphb, unsigned long msr);
>>  
>>  /* pci-ioda-tce.c */
>>  #define POWERNV_IOMMU_DEFAULT_LEVELS	1
>> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
>> index cb2b4f9..677f30a 100644
>> --- a/arch/powerpc/platforms/powernv/npu-dma.c
>> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
>> @@ -762,7 +762,6 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
>>  	u32 nvlink_index;
>>  	struct device_node *nvlink_dn;
>>  	struct mm_struct *mm = current->mm;
>> -	struct pnv_phb *nphb;
>>  	struct npu *npu;
>>  	struct npu_context *npu_context;
>>  
>> @@ -772,9 +771,6 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
>>  	 */
>>  	struct pci_dev *npdev = pnv_pci_get_npu_dev(gpdev, 0);
>>  
>> -	if (!firmware_has_feature(FW_FEATURE_OPAL))
>> -		return ERR_PTR(-ENODEV);
>> -
>>  	if (!npdev)
>>  		/* No nvlink associated with this GPU device */
>>  		return ERR_PTR(-ENODEV);
>> @@ -792,22 +788,9 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
>>  		return ERR_PTR(-EINVAL);
>>  	}
>>  
>> -	nphb = pci_bus_to_host(npdev->bus)->private_data;
>>  	npu = npdev_to_npu(npdev);
>>  
>>  	/*
>> -	 * Setup the NPU context table for a particular GPU. These need to be
>> -	 * per-GPU as we need the tables to filter ATSDs when there are no
>> -	 * active contexts on a particular GPU. It is safe for these to be
>> -	 * called concurrently with destroy as the OPAL call takes appropriate
>> -	 * locks and refcounts on init/destroy.
>> -	 */
>> -	rc = opal_npu_init_context(nphb->opal_id, mm->context.id,
>> flags,
> 
> AFAICT this was the only use of 'flags' in this function, so it should
> be removed from the signature, no?


It should, however this is ABI and the vendor driver is calling this
function with the flags so I cannot just ditch the flags.


> 
>> -				PCI_DEVID(gpdev->bus->number, gpdev->devfn));
>> -	if (rc < 0)
>> -		return ERR_PTR(-ENOSPC);
>> -
>> -	/*
>>  	 * We store the npu pci device so we can more easily get at the
>>  	 * associated npus.
>>  	 */
>> @@ -817,9 +800,6 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
>>  		if (npu_context->release_cb != cb ||
>>  			npu_context->priv != priv) {
>>  			spin_unlock(&npu2_devices.context_lock);
>> -			opal_npu_destroy_context(nphb->opal_id, mm->context.id,
>> -						PCI_DEVID(gpdev->bus->number,
>> -							gpdev->devfn));
>>  			return ERR_PTR(-EINVAL);
>>  		}
>>  
>> @@ -845,9 +825,6 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
>>  
>>  		if (rc) {
>>  			kfree(npu_context);
>> -			opal_npu_destroy_context(nphb->opal_id, mm->context.id,
>> -					PCI_DEVID(gpdev->bus->number,
>> -						gpdev->devfn));
>>  			return ERR_PTR(rc);
>>  		}
>>  
>> @@ -900,7 +877,6 @@ void pnv_npu2_destroy_context(struct npu_context *npu_context,
>>  			struct pci_dev *gpdev)
>>  {
>>  	int removed;
>> -	struct pnv_phb *nphb;
>>  	struct npu *npu;
>>  	struct pci_dev *npdev = pnv_pci_get_npu_dev(gpdev, 0);
>>  	struct device_node *nvlink_dn;
>> @@ -909,18 +885,12 @@ void pnv_npu2_destroy_context(struct npu_context *npu_context,
>>  	if (WARN_ON(!npdev))
>>  		return;
>>  
>> -	if (!firmware_has_feature(FW_FEATURE_OPAL))
>> -		return;
>> -
>> -	nphb = pci_bus_to_host(npdev->bus)->private_data;
>>  	npu = npdev_to_npu(npdev);
>>  	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
>>  	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
>>  							&nvlink_index)))
>>  		return;
>>  	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], NULL);
>> -	opal_npu_destroy_context(nphb->opal_id, npu_context->mm->context.id,
>> -				PCI_DEVID(gpdev->bus->number, gpdev->devfn));
>>  	spin_lock(&npu2_devices.context_lock);
>>  	removed = kref_put(&npu_context->kref, pnv_npu2_release_context);
>>  	spin_unlock(&npu2_devices.context_lock);
>> @@ -952,9 +922,6 @@ int pnv_npu2_handle_fault(struct npu_context *context, uintptr_t *ea,
>>  	/* mmap_sem should be held so the struct_mm must be present */
>>  	struct mm_struct *mm = context->mm;
>>  
>> -	if (!firmware_has_feature(FW_FEATURE_OPAL))
>> -		return -ENODEV;
>> -
>>  	WARN_ON(!rwsem_is_locked(&mm->mmap_sem));
>>  
>>  	for (i = 0; i < count; i++) {
>> @@ -983,15 +950,11 @@ int pnv_npu2_handle_fault(struct npu_context *context, uintptr_t *ea,
>>  }
>>  EXPORT_SYMBOL(pnv_npu2_handle_fault);
>>  
>> -int pnv_npu2_init(struct pnv_phb *phb)
>> +int pnv_npu2_init(struct pci_controller *hose)
>>  {
>>  	unsigned int i;
>>  	u64 mmio_atsd;
>> -	struct device_node *dn;
>> -	struct pci_dev *gpdev;
>>  	static int npu_index;
>> -	uint64_t rc = 0;
>> -	struct pci_controller *hose = phb->hose;
>>  	struct npu *npu;
>>  	int ret;
>>  
>> @@ -1006,18 +969,6 @@ int pnv_npu2_init(struct pnv_phb *phb)
>>  	}
>>  
>>  	npu->nmmu_flush = of_property_read_bool(hose->dn, "ibm,nmmu-flush");
>> -	for_each_child_of_node(phb->hose->dn, dn) {
>> -		gpdev = pnv_pci_get_gpu_dev(get_pci_dev(dn));
>> -		if (gpdev) {
>> -			rc = opal_npu_map_lpar(phb->opal_id,
>> -				PCI_DEVID(gpdev->bus->number, gpdev->devfn),
>> -				0, 0);
>> -			if (rc)
>> -				dev_err(&gpdev->dev,
>> -					"Error %lld mapping device to LPAR\n",
>> -					rc);
>> -		}
>> -	}
>>  
>>  	for (i = 0; !of_property_read_u64_index(hose->dn, "ibm,mmio-atsd",
>>  							i, &mmio_atsd); i++)
>> @@ -1047,3 +998,52 @@ int pnv_npu2_init(struct pnv_phb *phb)
>>  
>>  	return ret;
>>  }
>> +
>> +void pnv_npu2_map_lpar_phb(struct pnv_phb *nphb, unsigned long msr)
>> +{
>> +	struct pci_dev *gpdev;
>> +	struct device_node *dn;
>> +	int ret;
>> +	struct pci_controller *hose = nphb->hose;
>> +
>> +	for_each_child_of_node(hose->dn, dn) {
>> +		gpdev = pnv_pci_get_gpu_dev(get_pci_dev(dn));
>> +		if (!gpdev)
>> +			continue;
>> +
>> +		dev_dbg(&gpdev->dev, "Map LPAR opalid=%llu\n", nphb->opal_id);
>> +		ret = opal_npu_map_lpar(nphb->opal_id,
>> +				PCI_DEVID(gpdev->bus->number, gpdev->devfn),
>> +				0, 0);
>> +		if (!ret)
>> +			continue;
>> +		dev_err(&gpdev->dev, "Error %d mapping device to LPAR\n", ret);
>> +	}
>> +
>> +	/*
>> +	 * It seems that touching NPU2_XTS_BDF_MAP in the way
>> +	 * the opal_npu_map_lpar() does somehow affects the result of
>> +	 * what opal_npu_init_context() does so let's put the latter in
>> +	 * a separate loop.
>> +	 */
>> +	for_each_child_of_node(hose->dn, dn) {
>> +		gpdev = pnv_pci_get_gpu_dev(get_pci_dev(dn));
>> +		if (!gpdev)
>> +			continue;
>> +
>> +		/*
>> +		 * Setup the NPU context table for a particular GPU. These need
>> +		 * to be per-GPU as we need the tables to filter ATSDs when
>> +		 * there are no active contexts on a particular GPU. It is safe
>> +		 * for these to be called concurrently with destroy as the OPAL
>> +		 * call takes appropriate locks and refcounts on init/destroy.
>> +		 */
>> +		dev_dbg(&gpdev->dev, "init context opalid=%llu\n",
>> +				nphb->opal_id);
>> +		ret = opal_npu_init_context(nphb->opal_id, 0/*__unused*/, msr,
>> +				PCI_DEVID(gpdev->bus->number, gpdev->devfn));
>> +		if (!ret)
>> +			continue;
>> +		dev_err(&gpdev->dev, "Failed to init context: %d\n", ret);
>> +	}
>> +}
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 0cc81c0..56a1398 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -1287,8 +1287,11 @@ static void pnv_pci_ioda_setup_PEs(void)
>>  			/* PE#0 is needed for error reporting */
>>  			pnv_ioda_reserve_pe(phb, 0);
>>  			pnv_ioda_setup_npu_PEs(hose->bus);
>> -			if (phb->model == PNV_PHB_MODEL_NPU2)
>> -				pnv_npu2_init(phb);
>> +			if (phb->model == PNV_PHB_MODEL_NPU2) {
>> +				pnv_npu2_init(hose);
>> +				pnv_npu2_map_lpar_phb(phb,
>> +						MSR_DR | MSR_PR | MSR_HV);
> 
> This is the only caller of pnv_np2_map_lpar_phb(), do we need the
> second parameter?  I take it those "flags" to the function are
> actually an MSR value; that wasn't clear from the previous code.


Correct, the flags are some MSR bits, the name was there before I
started touching this... The flags are (MSR_DR | MSR_PR) when VFIO
subdriver calls pnv_npu2_map_lpar_phb from later patches. I'll repost
the whole thing as a single patchset, splitting it in parts was a bad
idea. Thanks,




> 
>> +			}
>>  		}
>>  		if (phb->type == PNV_PHB_NPU_OCAPI) {
>>  			bus = hose->bus;
> 

-- 
Alexey
