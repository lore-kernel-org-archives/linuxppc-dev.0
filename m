Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506C4C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 07:20:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C27DE2087A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 07:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="CW6miuhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27DE2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42z0cG5wzPzF3DT
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 18:20:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="CW6miuhG";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="CW6miuhG"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42z0YS4Gr1zF3Nt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 18:18:20 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id x21-v6so11412700pln.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Nov 2018 23:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PKAZ5FSo0Ad+wUPDYKJsruFfNT40+AQ7m5Wn5Ng+izw=;
 b=CW6miuhGKa8PlHLYbVG79EC2c8JHnCABWurMCzJ00oujQ836tE1BkezYHm+AfIYksa
 48gVNyEmgKpavpc/93pc4exTTRjrpVJRfWo0FQvgIfBGuxCBpITGvuSF80CXXVEyXwHG
 PbWwCFVHlMYZPjrbKgQCOrjWgYq0O4wtvE8Ed9/sc5LWs92LiRKjj32+61FN7ZZGZ5Eg
 fqWq6JpzmUhqqQ51vo/aMjm2+0a9UIrOQlNd4vgqy89+qISmhAYU9SznVqjDMFLmOJGr
 Iozw320Req0t28GbA7QjMzRqwajeGexUBYqnQEcSNjaJqF88LYNKRO1rVFV+7w1WVF8O
 xoiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=PKAZ5FSo0Ad+wUPDYKJsruFfNT40+AQ7m5Wn5Ng+izw=;
 b=WCscVaKnZCSrnuupIAnVzx9/XS+jVkpijiPSPEgPfdJQcr9RF7Vq0FV3xUUrFhC74K
 Otn4CTYR69qihGVIpv5pZk6ujh8gAWkah/Zom+nWIsjcK97AaYm6juLWlgh78HAdVuwy
 tR5RSEcszooXQBvUJHi8/bd1a4mVLo+CShSenKhcpLOuGMlcy/yR8b26uob/QuTLlx96
 l60ipeFyxAvZqnlDsxF20B3aq+JCA6Zy6ih8QLdYcdA1kecDk6Ncxv1OOpor19bl+e6Q
 7AdMD8eYURGViZsw3a677uUCT9b+1cdPdaiQMcTlNYyZvdNE8PQpTmTNlSOkXA3vmVYj
 llCA==
X-Gm-Message-State: AGRZ1gI007o6PuMA/9vWNLx0/BlFIlWxTftUWRYibg3NijO2ryrjTmKy
 3Fl9lVELdWHIhLwMCOf0wH3Duw==
X-Google-Smtp-Source: AJdET5e/fQYjbRabBTSMTsUDRES5v7wEwcrkA6uBjgqjG1pGLuI6LhBY+b+1/BPJEMHP+bfphjhg1g==
X-Received: by 2002:a17:902:b28b:: with SMTP id
 u11mr21315081plr.57.1542611898267; 
 Sun, 18 Nov 2018 23:18:18 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id f6sm10567078pfg.188.2018.11.18.23.18.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Nov 2018 23:18:17 -0800 (PST)
Subject: Re: [PATCH kernel v3 06/22] powerpc/powernv: Detach npu struct from
 pnv_phb
To: Alistair Popple <alistair@popple.id.au>
References: <20181113082823.2440-1-aik@ozlabs.ru>
 <20181113082823.2440-7-aik@ozlabs.ru> <1686227.ptHs0ZEO6U@townsend>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <3b234b11-f8b7-9225-e2ae-aae4ddbb8dfd@ozlabs.ru>
Date: Mon, 19 Nov 2018 18:18:11 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1686227.ptHs0ZEO6U@townsend>
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
 Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 =?UTF-8?Q?Leonardo_Augusto_Guimar=c3=a3es_Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 14/11/2018 15:28, Alistair Popple wrote:
> Hi Alexey,
> 
> On Tuesday, 13 November 2018 7:28:07 PM AEDT Alexey Kardashevskiy wrote:
>>  static struct npu *npdev_to_npu(struct pci_dev *npdev)
>>  {
>> -	struct pnv_phb *nphb;
>> +	struct pci_controller *hose = pci_bus_to_host(npdev->bus);
>> +	struct npu *npu;
>>
>> -	nphb = pci_bus_to_host(npdev->bus)->private_data;
>> +	list_for_each_entry(npu, &npu2_devices, next)
> 
> This is called from the ATSD path which is (or at least has been) quite a 
> performance critical path so searching through all the NPUs in a list may be 
> problematic.
> 
> I guess currently it wont make any practical difference as we only ever have 2 
> NPUs, but in future they may get divided into more logical NPUs. Would it be 
> possible to store a back-pointer somewhere so we can avoid the lookup?


It is quite possible even now with iommu_group_get() + container_of() +
iommu_group_put(), I'll try that in respin.


> 
>> +		if (hose == npu->hose)
>> +			return npu;
>>
>> -	return &nphb->npu;
>> +	WARN_ON_ONCE(1);
>> +	return NULL;
>>  }
>>
>>  /* Maximum number of nvlinks per npu */
>> @@ -505,6 +531,9 @@ static void acquire_atsd_reg(struct npu_context
>> *npu_context, continue;
>>
>>  			npu = npdev_to_npu(npdev);
>> +			if (!npu)
>> +				continue;
>> +
>>  			mmio_atsd_reg[i].npu = npu;
>>  			mmio_atsd_reg[i].reg = get_mmio_atsd_reg(npu);
>>  			while (mmio_atsd_reg[i].reg < 0) {
>> @@ -701,6 +730,8 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev
>> *gpdev,
>>
>>  	nphb = pci_bus_to_host(npdev->bus)->private_data;
>>  	npu = npdev_to_npu(npdev);
>> +	if (!npu)
>> +		return ERR_PTR(-ENODEV);
>>
>>  	/*
>>  	 * Setup the NPU context table for a particular GPU. These need to be
>> @@ -821,6 +852,8 @@ void pnv_npu2_destroy_context(struct npu_context
>> *npu_context,
>>
>>  	nphb = pci_bus_to_host(npdev->bus)->private_data;
>>  	npu = npdev_to_npu(npdev);
>> +	if (!npu)
>> +		return;
>>  	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
>>  	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
>>  							&nvlink_index)))
>> @@ -898,9 +931,15 @@ int pnv_npu2_init(struct pnv_phb *phb)
>>  	struct pci_dev *gpdev;
>>  	static int npu_index;
>>  	uint64_t rc = 0;
>> +	struct pci_controller *hose = phb->hose;
>> +	struct npu *npu;
>> +	int ret;
>>
>> -	phb->npu.nmmu_flush =
>> -		of_property_read_bool(phb->hose->dn, "ibm,nmmu-flush");
>> +	npu = kzalloc(sizeof(*npu), GFP_KERNEL);
>> +	if (!npu)
>> +		return -ENOMEM;
>> +
>> +	npu->nmmu_flush = of_property_read_bool(hose->dn, "ibm,nmmu-flush");
>>  	for_each_child_of_node(phb->hose->dn, dn) {
>>  		gpdev = pnv_pci_get_gpu_dev(get_pci_dev(dn));
>>  		if (gpdev) {
>> @@ -914,18 +953,31 @@ int pnv_npu2_init(struct pnv_phb *phb)
>>  		}
>>  	}
>>
>> -	for (i = 0; !of_property_read_u64_index(phb->hose->dn, "ibm,mmio-atsd",
>> +	for (i = 0; !of_property_read_u64_index(hose->dn, "ibm,mmio-atsd",
>>  							i, &mmio_atsd); i++)
>> -		phb->npu.mmio_atsd_regs[i] = ioremap(mmio_atsd, 32);
>> +		npu->mmio_atsd_regs[i] = ioremap(mmio_atsd, 32);
>>
>> -	pr_info("NPU%lld: Found %d MMIO ATSD registers", phb->opal_id, i);
>> -	phb->npu.mmio_atsd_count = i;
>> -	phb->npu.mmio_atsd_usage = 0;
>> +	pr_info("NPU%d: Found %d MMIO ATSD registers", hose->global_number, i);
>> +	npu->mmio_atsd_count = i;
>> +	npu->mmio_atsd_usage = 0;
>>  	npu_index++;
>> -	if (WARN_ON(npu_index >= NV_MAX_NPUS))
>> -		return -ENOSPC;
>> +	if (WARN_ON(npu_index >= NV_MAX_NPUS)) {
>> +		ret = -ENOSPC;
>> +		goto fail_exit;
>> +	}
>>  	max_npu2_index = npu_index;
>> -	phb->npu.index = npu_index;
>> +	npu->index = npu_index;
>> +	npu->hose = hose;
>> +
>> +	list_add(&npu->next, &npu2_devices);
> 
> Guess we don't need any locking here as the list gets setup once during boot 
> long before loading the driver and is never modified right?


Correct.


> 
> - Alistair
> 
>>  	return 0;
>> +
>> +fail_exit:
>> +	for (i = 0; i < npu->mmio_atsd_count; ++i)
>> +		iounmap(npu->mmio_atsd_regs[i]);
>> +
>> +	kfree(npu);
>> +
>> +	return ret;
>>  }
> 
> 

-- 
Alexey
