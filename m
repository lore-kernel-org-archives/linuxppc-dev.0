Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AFEC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 07:31:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2893F2086A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 07:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="EduDg8dl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2893F2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42z0rd5tQHzDqCK
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 18:31:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="EduDg8dl";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="EduDg8dl"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42z0nm0SGHzF3Ql
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 18:28:59 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id s9-v6so14389820pfm.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Nov 2018 23:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LPvsv3bABWlFW4r7YRPi9M1kK1fSzLABvYR+4jacz+k=;
 b=EduDg8dl45tVTCsqbN/Iol98u0o2k8u1IaZBHflTibH3ocU7kVIAQX3l3KAINdHyz0
 pfmKyPglRaQKO9KGTMnMWk/usG34yizeTbSgdhJCLvwS7QKnQ0B4VUc/mU2PSJAn4/WG
 wFOl1LTlvTMz5w3X9v8Wwx28TnaTVQACpI0Y+JrBM/rmFuC1fAetvjeTJhVVlcY9pAsK
 AgRx5E8kSjI63eeueFSK0hITYg7o/Lx/s2Vu8XbvwssVwvFXnHP5J9x3yyswBmvAaY/N
 yS2ojVCJMWdFaW1EFCp/tj0+vgNK1M1rapWKKi7i5Oa49mW2PoOZM5KpT9raesigx7ve
 k7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=LPvsv3bABWlFW4r7YRPi9M1kK1fSzLABvYR+4jacz+k=;
 b=KfK06BD0wZepIgRpjkVeQY2Aql29TvM29jU7lQ7IUW5MBdBRujwjWwblBbtK/1y/8j
 nxF1o0OXbnp2jVcrQOKRtTeW/knHvCxGzGl38MPwOpgUBbQWc6v/vlFHa8cQhlDRRoof
 JaPfswvSnF8YnC3NIutTklv7GK/b0FWWr70z6neLAO3wfvVgylIoTWfY97kVzZn5FHa8
 uhYeTeSQnfaP/0YpzGCFAExYb9cg+Gb1aoRfw0mcpJoqMhUchih1jBNrLfAxIV4veRRp
 FWN8z6t+lGKEmj+SI3VFmbgLhVExpRJrn4lmhju9hE+culS9OEacodVP6P5hv0WYHcg7
 NaJA==
X-Gm-Message-State: AGRZ1gJimmtOHqu5cKkG2+O9wgei1OX8muN+1YY8JGRVHRRB/sbgostE
 +Dj2JgyS3sBYPsKk1hKZXo0X9g==
X-Google-Smtp-Source: AJdET5eW91I/BP0+QGeTa0mGLpWWpfSU72MQIgfKNOYd1LhT5sDJVp3r/K3NS7CdzebWAO95HzvIFg==
X-Received: by 2002:a62:2c16:: with SMTP id
 s22-v6mr21668985pfs.6.1542612537792; 
 Sun, 18 Nov 2018 23:28:57 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id l62-v6sm48316266pfl.28.2018.11.18.23.28.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Nov 2018 23:28:56 -0800 (PST)
Subject: Re: [PATCH kernel v3 09/22] powerpc/pseries/iommu: Force default DMA
 window removal
To: David Gibson <david@gibson.dropbear.id.au>
References: <20181113082823.2440-1-aik@ozlabs.ru>
 <20181113082823.2440-10-aik@ozlabs.ru> <20181116045405.GB23632@umbus>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <eb939cdf-aef0-5556-9f83-a330f7d3fd95@ozlabs.ru>
Date: Mon, 19 Nov 2018 18:28:50 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181116045405.GB23632@umbus>
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



On 16/11/2018 15:54, David Gibson wrote:
> On Tue, Nov 13, 2018 at 07:28:10PM +1100, Alexey Kardashevskiy wrote:
>> It is quite common for a device to support more than 32bit but less than
>> 64bit for DMA, for example, GPUs often support 42..50bits. However
>> the pseries platform only allows huge DMA window (the one which allows
>> the use of more than 2GB of DMA space) for 64bit-capable devices mostly
>> because:
>>
>> 1. we may have 32bit and >32bit devices on the same IOMMU domain and
>> we cannot place the new big window where the 32bit one is located;
>>
>> 2. the existing hardware only supports the second window at very high
>> offset of 1<<59 == 0x0800.0000.0000.0000.
>>
>> So in order to allow 33..59bit DMA, we have to remove the default DMA
>> window and place a huge one there instead.
>>
>> The PAPR spec says that the platform may decide not to use the default
>> window and remove it using DDW RTAS calls. There are few possible ways
>> for the platform to decide:
>>
>> 1. look at the device IDs and decide in advance that such and such
>> devices are capable of more than 32bit DMA (powernv's sketchy bypass
>> does something like this - it drops the default window if all devices
>> on the PE are from the same vendor) - this is not great as involves
>> guessing because, unlike sketchy bypass, the GPU case involves 2 vendor
>> ids and does not scale;
>>
>> 2. advertise 1 available DMA window in the hypervisor via
>> ibm,query-pe-dma-window so the pseries platform could take it as a clue
>> that if more bits for DMA are needed, it has to remove the default
>> window - this is not great as it is implicit clue rather than direct
>> instruction;
>>
>> 3. removing the default DMA window at all it not really an option as
>> PAPR mandates its presense at the guest boot time;
>>
>> 4. make the hypervisor explicitly tell the guest that the default window
>> is better be removed so the guest does not have to think hard and can
>> simply do what requested and this is what this patch does.
> 
> This approach only makes sense if the hypervisor has better
> information as to what to do that the guest does.  It's not clear to
> me why that would be the case.  Isn't the DMA capabilities of the
> device something the driver should know, in which case it can decide
> based on that?

The device knows it can do 42bits so it will request DMA mask for 42bits
and then the platform has to deal with it, the device has no control
over DMA windows.

Then the platform tries to make everything work, which sadly includes
32bit-DMA devices so the default DMA window stays there and for 42bit
devices there is no other way than to go via the smaller window as the
only other window we can create is beyond the reach of the GPU.

We have so called "sketchy bypass" hack for some other GPUs (which
Christoph is trying to get rid of) at
https://github.com/aik/linux/blob/nv2/arch/powerpc/platforms/powernv/pci-ioda.c#L1885

which is powernv and which seemed a solution there and which I am trying
to reimplement here.


> 
>>
>> This makes use of the latter approach and exploits a new
>> "qemu,dma-force-remove-default" flag in a vPHB.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  arch/powerpc/platforms/pseries/iommu.c | 28 +++++++++++++++++++++++---
>>  1 file changed, 25 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
>> index 9ece42f..78473ac 100644
>> --- a/arch/powerpc/platforms/pseries/iommu.c
>> +++ b/arch/powerpc/platforms/pseries/iommu.c
>> @@ -54,6 +54,7 @@
>>  #include "pseries.h"
>>  
>>  #define DDW_INVALID_OFFSET	((uint64_t)-1)
>> +#define DDW_INVALID_LIOBN	((uint32_t)-1)
>>  
>>  static struct iommu_table_group *iommu_pseries_alloc_group(int node)
>>  {
>> @@ -977,7 +978,8 @@ static LIST_HEAD(failed_ddw_pdn_list);
>>   *
>>   * returns the dma offset for use by dma_set_mask
>>   */
>> -static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>> +static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn,
>> +		u32 default_liobn)
>>  {
>>  	int len, ret;
>>  	struct ddw_query_response query;
>> @@ -1022,6 +1024,16 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>>  	if (ret)
>>  		goto out_failed;
>>  
>> +	/*
>> +	 * The device tree has a request to force remove the default window,
>> +	 * do this.
>> +	 */
>> +	if (default_liobn != DDW_INVALID_LIOBN && (!ddw_avail[2] ||
>> +			rtas_call(ddw_avail[2], 1, 1, NULL, default_liobn))) {
>> +		dev_dbg(&dev->dev, "Could not remove window");
>> +		goto out_failed;
>> +	}
>> +
>>         /*
>>  	 * Query if there is a second window of size to map the
>>  	 * whole partition.  Query returns number of windows, largest
>> @@ -1212,7 +1224,7 @@ static int dma_set_mask_pSeriesLP(struct device *dev, u64 dma_mask)
>>  	pdev = to_pci_dev(dev);
>>  
>>  	/* only attempt to use a new window if 64-bit DMA is requested */
>> -	if (!disable_ddw && dma_mask == DMA_BIT_MASK(64)) {
>> +	if (!disable_ddw && dma_mask > DMA_BIT_MASK(32)) {
>>  		dn = pci_device_to_OF_node(pdev);
>>  		dev_dbg(dev, "node is %pOF\n", dn);
>>  
>> @@ -1229,7 +1241,17 @@ static int dma_set_mask_pSeriesLP(struct device *dev, u64 dma_mask)
>>  				break;
>>  		}
>>  		if (pdn && PCI_DN(pdn)) {
>> -			dma_offset = enable_ddw(pdev, pdn);
>> +			u32 liobn = DDW_INVALID_LIOBN;
>> +			int ret = of_device_is_compatible(pdn, "IBM,npu-vphb");
>> +
>> +			if (ret) {
>> +				dma_window = of_get_property(pdn,
>> +						"ibm,dma-window", NULL);
>> +				if (dma_window)
>> +					liobn = be32_to_cpu(dma_window[0]);
>> +			}
>> +
>> +			dma_offset = enable_ddw(pdev, pdn, liobn);
>>  			if (dma_offset != DDW_INVALID_OFFSET) {
>>  				dev_info(dev, "Using 64-bit direct DMA at offset %llx\n", dma_offset);
>>  				set_dma_offset(dev, dma_offset);
> 

-- 
Alexey
