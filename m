Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00498C67863
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 01:23:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EFFD20C0E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 01:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="F1SJHITg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFFD20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bp820xQYzF3Ss
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 12:23:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="F1SJHITg";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="F1SJHITg"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bp5R6M6hzF3Hc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 12:20:59 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id v5-v6so15095267plz.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 18:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RNZzBdrthCryzpb6ENOJShXTE69DUE6pijp7dRPdtAg=;
 b=F1SJHITgysGHLyZu1Rk0lUEWpQaIh7lNQATpC5hshs1G/u6i3kgrreuIEGiEBcEMcX
 RAeUtSuRoxMe88UHtH71I5gXFki0inDx+P1tCtA3AwiXaWYekZ3Up8c2VXtvXrBsbbUG
 UNk47l03MHlpTBOQTmdCTopSwJM09Bbk37gVviDMD940ic1+YmP0UGeAQVFx0YTAmxD6
 eHaXO0rUJOoPXt8JpSjXEh2Kh72J9+cb7SlFXKLr/gWsw1f2CaRcxJgU971RP5dN59+u
 DlPhOMNlO9LPCbDLpqrUNSSvux8ydNJmYP0OSglUNtJ+GpkBEqiUhwU0ZVtTbJS6haQt
 LWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=RNZzBdrthCryzpb6ENOJShXTE69DUE6pijp7dRPdtAg=;
 b=BqN5iCn8UIJ4C1XJH5RWp54sz7+poUAJp8tQxRa3eo45PoilqrgEP6Sfr6S25Ea6KJ
 ktQK9BkflbO6SY1P0cXOWCNS7zR6ttxvx/XflLopGeNX6PY9klEUkbhrLBUjTgUMWgAa
 gza3QyWQVxGJ99zhVM5e+Bjh9zfowkcI8pFDwNOaw2b7t1A83PKfUUpNC1FZKudS/Pvh
 0xswhh4K//ysVST832A1s8DQX35TZOXBUay3CKfobVHDDdfL+tvl3VIuRAryKVL5oMQm
 1Nbl5eoernrp3C2+jImxZ+9Dc++qCwt1DclbsonIztLMYD9umejr1OqcSefQvN0dYU5X
 34IA==
X-Gm-Message-State: ABuFfohxSLaUGkrwF5cb/h4fGi87648BxyET18C9gkJxd8OW02/qVvuX
 wsIG8qrmjFuqy+pC0Mp+k9Vh3w==
X-Google-Smtp-Source: ACcGV62sIgEtTHIkpotTCGVOhhGY02RoeOoWGTFv2ryv+5fg95dvcOFbSSYI9iw+gx0dwueX+ftOBg==
X-Received: by 2002:a17:902:bb96:: with SMTP id
 m22-v6mr31894505pls.117.1539912057453; 
 Thu, 18 Oct 2018 18:20:57 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id m7-v6sm22405237pgq.59.2018.10.18.18.20.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Oct 2018 18:20:56 -0700 (PDT)
Subject: Re: [PATCH kernel v2] powerpc/ioda/npu: Call skiboot's hot reset hook
 when disabling NPU2
To: Alistair Popple <alistair@popple.id.au>
References: <20181002032021.7126-1-aik@ozlabs.ru>
 <2086775.d8i5QI7OoB@new-mexico>
 <45098cfd-5420-f4bd-f7fe-394ce2c704d0@ozlabs.ru>
 <11968808.7zhiiyAbUF@townsend>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <87caa06c-0f67-f2f1-6bc0-215f5c672bd8@ozlabs.ru>
Date: Fri, 19 Oct 2018 12:20:52 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <11968808.7zhiiyAbUF@townsend>
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
Cc: Reza Arbab <arbab@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 18/10/2018 12:05, Alistair Popple wrote:
> Hi Alexey,
> 
>>> wouldn't you also need to do that somewhere? Unless the driver
>>> does it at startup?
>>
>> VFIO performs GPU reset so I'd expect the GPUs to flush its caches
>> without any software interactions. Am I hoping for too much here?
> 
> Sadly you are. It's not the GPU caches that need flushing, it's the CPU caches. 
> This needs to happen as part of the reset sequence, so I guess you would need 
> to add it to the VFIO driver.

Well, ok. Caches need flushing, will look into this but this fencing is
still needed, is not it?



> 
> - Alistair
> 
>>
>>> - Alistair
>>>
>>>>> - Alistair
>>>>>
>>>>>>> - Alistair
>>>>>>>
>>>>>>>>> - Alistair
>>>>>>>>>
>>>>>>>>> On Monday, 15 October 2018 6:17:51 PM AEDT Alexey Kardashevskiy 
> wrote:
>>>>>>>>>> Ping?
>>>>>>>>>>
>>>>>>>>>> On 02/10/2018 13:20, Alexey Kardashevskiy wrote:
>>>>>>>>>>> The skiboot firmware has a hot reset handler which fences the
>>>>>>>>>>> NVIDIA V100
>>>>>>>>>>> GPU RAM on Witherspoons and makes accesses no-op instead of
>>>>>>>>>>> throwing HMIs:
>>>>>>>>>>> https://github.com/open-power/skiboot/commit/fca2b2b839a67
>>>>>>>>>>>
>>>>>>>>>>> Now we are going to pass V100 via VFIO which most certainly
>>>>>>>>>>> involves
>>>>>>>>>>> KVM guests which are often terminated without getting a chance to
>>>>>>>>>>> offline
>>>>>>>>>>> GPU RAM so we end up with a running machine with misconfigured
>>>>>>>>>>> memory.
>>>>>>>>>>> Accessing this memory produces hardware management interrupts
>>>>>>>>>>> (HMI)
>>>>>>>>>>> which bring the host down.
>>>>>>>>>>>
>>>>>>>>>>> To suppress HMIs, this wires up this hot reset hook to
>>>>>>>>>>> vfio_pci_disable()
>>>>>>>>>>> via pci_disable_device() which switches NPU2 to a safe mode and
>>>>>>>>>>> prevents
>>>>>>>>>>> HMIs.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>>>>>>>> ---
>>>>>>>>>>> Changes:
>>>>>>>>>>> v2:
>>>>>>>>>>> * updated the commit log
>>>>>>>>>>> ---
>>>>>>>>>>>
>>>>>>>>>>>  arch/powerpc/platforms/powernv/pci-ioda.c | 10 ++++++++++
>>>>>>>>>>>  1 file changed, 10 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>>>>>>>> b/arch/powerpc/platforms/powernv/pci-ioda.c index
>>>>>>>>>>> cde7102..e37b9cc 100644
>>>>>>>>>>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>>>>>>>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>>>>>>>> @@ -3688,6 +3688,15 @@ static void pnv_pci_release_device(struct
>>>>>>>>>>> pci_dev *pdev)>>>>>>>>> 
>>>>>>>>>>>  		pnv_ioda_release_pe(pe);
>>>>>>>>>>>  
>>>>>>>>>>>  }
>>>>>>>>>>>
>>>>>>>>>>> +static void pnv_npu_disable_device(struct pci_dev *pdev)
>>>>>>>>>>> +{
>>>>>>>>>>> +	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
>>>>>>>>>>> +	struct eeh_pe *eehpe = edev ? edev->pe : NULL;
>>>>>>>>>>> +
>>>>>>>>>>> +	if (eehpe && eeh_ops && eeh_ops->reset)
>>>>>>>>>>> +		eeh_ops->reset(eehpe, EEH_RESET_HOT);
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>>
>>>>>>>>>>>  static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
>>>>>>>>>>>  {
>>>>>>>>>>>  
>>>>>>>>>>>  	struct pnv_phb *phb = hose->private_data;
>>>>>>>>>>>
>>>>>>>>>>> @@ -3732,6 +3741,7 @@ static const struct pci_controller_ops
>>>>>>>>>>> pnv_npu_ioda_controller_ops = {>>>>>>>>> 
>>>>>>>>>>>  	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
>>>>>>>>>>>  	.dma_set_mask		= pnv_npu_dma_set_mask,
>>>>>>>>>>>  	.shutdown		= pnv_pci_ioda_shutdown,
>>>>>>>>>>>
>>>>>>>>>>> +	.disable_device		= pnv_npu_disable_device,
>>>>>>>>>>>
>>>>>>>>>>>  };
>>>>>>>>>>>  
>>>>>>>>>>>  static const struct pci_controller_ops
>>>>>>>>>>>  pnv_npu_ocapi_ioda_controller_ops = {
> 
> 

-- 
Alexey
