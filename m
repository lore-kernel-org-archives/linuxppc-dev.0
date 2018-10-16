Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05F3C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 02:16:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4082089E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 02:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="gvh92Pqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4082089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YzSy1xVFzF3Nw
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:16:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="gvh92Pqw";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="gvh92Pqw"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Yz9M0jC7zF3Rw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 13:03:02 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id g21-v6so3609132pfi.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 19:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NdzLpxDvAfBobHuTATQ02239JrHCXLWsgulKICfRTsQ=;
 b=gvh92PqwsHqEUNSmvrlcUbitITb2W0Ru+alFF8i1NUGTOPyl/GSCy6l+KHdODhEvr6
 ZmWLd6OpFGWgsdFAHEAcL6Hu6DFxXCbD9t2PJPgzz6cflsvmIE0WKPpfphP/7nfWY3JG
 KbOHDvbBcypDip6DO6PLmyxgJQ3vgouuZyIuQuaq6NxPOdr+a/aHT/CtBlAjbuWAFqTH
 YBLl/9Yb7MpIk9+ZcCnyiqybVLjU4JMas7l0NUUKMTjqXd2jQfeuurk6BWxUcFYG22jw
 uwkGIcGt220ZKtQm2FhFB2l0eltjsMgtbEdwO7kXS8nGEPEMJDiQHF7JXDcMxGPG/gPg
 1zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=NdzLpxDvAfBobHuTATQ02239JrHCXLWsgulKICfRTsQ=;
 b=dM2Uuy83B2LVbqsQ3L+AoGeqUL8jOBxFEHuGTiDk8ZXMMA5iY+Dz2losTFnpWhtVFp
 53sKUrKI29vXGDwz8MmSbnBr8al1OxkzJ+vmQaJIruVwjLZj+7nKFWsbFauH64iSa1oe
 Q20SH2NKkyNH48JNVkxDQ6kTwsiJI8QfVV8tLYF26Uxc+rQMHaS/BzfjDwfXhRsoL2Nc
 Sd7q4uogIHhfzN7ralr+nQKu4YfVb2bIjg0TigPJMTkTKJ4CKOSbqBI6E6VilTnn4n1m
 yFrXmT2ualu7qJBBoDSxEReI/7cpMq/LkjwEx18lY4JfVvwj9FcCkiPgq2AoTQQg+vMA
 Hcpg==
X-Gm-Message-State: ABuFfojKbqQdUc4SoQCmkplqnU3hyT5znGZ96ZUULFHNRJPhTAgsiyA7
 mKKx47yvnEqkT3BWFz0O6r8GUy7U2T4=
X-Google-Smtp-Source: ACcGV60SLr7V2a5e0Onpln+oWzxkamu74qDBSCXeIHb+asQW6dJCX+vbhtUWCKiUrotQDu49WkxecA==
X-Received: by 2002:a65:5c81:: with SMTP id
 a1-v6mr18251797pgt.390.1539655381301; 
 Mon, 15 Oct 2018 19:03:01 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id r65-v6sm16252359pfj.5.2018.10.15.19.02.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Oct 2018 19:03:00 -0700 (PDT)
Subject: Re: [PATCH kernel v2] powerpc/ioda/npu: Call skiboot's hot reset hook
 when disabling NPU2
To: Alistair Popple <alistair@popple.id.au>
References: <20181002032021.7126-1-aik@ozlabs.ru>
 <2435624.zC36bzMth8@new-mexico>
 <c4954261-ed8f-06e9-b32b-7710c50ee9d5@ozlabs.ru>
 <1625714.Rr8qeDJm6q@new-mexico>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <6b37ac1c-d611-49b1-4a1b-dec96a58c91b@ozlabs.ru>
Date: Tue, 16 Oct 2018 13:02:57 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1625714.Rr8qeDJm6q@new-mexico>
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



On 16/10/2018 12:44, Alistair Popple wrote:
> Hi Alexey,
> 
> On Tuesday, 16 October 2018 12:37:49 PM AEDT Alexey Kardashevskiy wrote:
>>
>> On 16/10/2018 11:38, Alistair Popple wrote:
>>> Hi Alexey,
>>>
>>> Looking at the skiboot side I think we only fence the NVLink bricks as part of a
>>> PCIe function level reset (FLR) rather than a PCI Hot or Fundamental reset which
>>> I believe is what the code here does. So to fence the bricks you would need to
>>> do either a FLR on the given link or alter Skiboot to fence a given link as part
>>> of a hot reset.
>>
>> The code here calls OPAL to execute this code:
>>
>> https://github.com/open-power/skiboot/commit/fca2b2b839a673a1e52fc6b19ee6d33b2dfbc003
>>
>> This resets all links on an NPU which is fine for now as we pass GPUs in
>> groups only. Or I missed something?
> 
> From what I can see in
> https://github.com/open-power/skiboot/commit/2947eaa14e771e572d4e84bf003318c590c1c7d4
> we only fence the bricks in npu2_dev_procedure_reset()
> (https://github.com/open-power/skiboot/blob/master/hw/npu2-hw-procedures.c#L937)
> which itself is only called from the FLR path and not the code path you point
> out above.
> 
> The code path above only resets the NTL which I don't believe is sufficient to
> prevent HMIs.

reset_ntl() does what npu2_dev_procedure_reset() does plus more stuff,
there nothing really in npu2_dev_procedure_reset() which reset_ntl()
does not do already from the hardware standpoint. And it did stop HMIs
for me though.

but ok, what will be sufficient then if not reset_ntl()?



> 
> - Alistair
> 
>>
>>
>>
>>>
>>> - Alistair
>>>
>>> On Monday, 15 October 2018 6:17:51 PM AEDT Alexey Kardashevskiy wrote:
>>>> Ping?
>>>>
>>>>
>>>> On 02/10/2018 13:20, Alexey Kardashevskiy wrote:
>>>>> The skiboot firmware has a hot reset handler which fences the NVIDIA V100
>>>>> GPU RAM on Witherspoons and makes accesses no-op instead of throwing HMIs:
>>>>> https://github.com/open-power/skiboot/commit/fca2b2b839a67
>>>>>
>>>>> Now we are going to pass V100 via VFIO which most certainly involves
>>>>> KVM guests which are often terminated without getting a chance to offline
>>>>> GPU RAM so we end up with a running machine with misconfigured memory.
>>>>> Accessing this memory produces hardware management interrupts (HMI)
>>>>> which bring the host down.
>>>>>
>>>>> To suppress HMIs, this wires up this hot reset hook to vfio_pci_disable()
>>>>> via pci_disable_device() which switches NPU2 to a safe mode and prevents
>>>>> HMIs.
>>>>>
>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>> ---
>>>>> Changes:
>>>>> v2:
>>>>> * updated the commit log
>>>>> ---
>>>>>  arch/powerpc/platforms/powernv/pci-ioda.c | 10 ++++++++++
>>>>>  1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>> index cde7102..e37b9cc 100644
>>>>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>> @@ -3688,6 +3688,15 @@ static void pnv_pci_release_device(struct pci_dev *pdev)
>>>>>  		pnv_ioda_release_pe(pe);
>>>>>  }
>>>>>  
>>>>> +static void pnv_npu_disable_device(struct pci_dev *pdev)
>>>>> +{
>>>>> +	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
>>>>> +	struct eeh_pe *eehpe = edev ? edev->pe : NULL;
>>>>> +
>>>>> +	if (eehpe && eeh_ops && eeh_ops->reset)
>>>>> +		eeh_ops->reset(eehpe, EEH_RESET_HOT);
>>>>> +}
>>>>> +
>>>>>  static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
>>>>>  {
>>>>>  	struct pnv_phb *phb = hose->private_data;
>>>>> @@ -3732,6 +3741,7 @@ static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
>>>>>  	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
>>>>>  	.dma_set_mask		= pnv_npu_dma_set_mask,
>>>>>  	.shutdown		= pnv_pci_ioda_shutdown,
>>>>> +	.disable_device		= pnv_npu_disable_device,
>>>>>  };
>>>>>  
>>>>>  static const struct pci_controller_ops pnv_npu_ocapi_ioda_controller_ops = {
>>>>>
>>>>
>>>>
>>>
>>>
>>
>>
> 
> 

-- 
Alexey
