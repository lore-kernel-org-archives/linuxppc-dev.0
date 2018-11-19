Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85521C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 07:46:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0122B20684
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 07:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="bq8lPqkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0122B20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42z19S543yzF1KD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 18:46:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="bq8lPqkX";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="bq8lPqkX"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42z16p4CNyzF3MM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 18:43:45 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id b85so7603767pfc.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Nov 2018 23:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+B4KfKqL7IWHD169FfPLbVrvTqwfsAYSk37J69imvTU=;
 b=bq8lPqkXmrDjQh8YUCUOwG6VqkxtPoHLHFncLaieXUeaE6fmBB5YdhtTjTIZAiPrDK
 7YXhHMsjPfG516hbERBSYY4IWu+AfOPf3MgtMjpZgCTmQdk6ccuVxHMsaKqK1qmIxO61
 IvDOVCT8BEwqPGGZTz1B/dpY5rNnmV4e7/zlcFAQu0zMU6zoA5Zi3O6uenLfYmuhn3KR
 +yBGd3N6rSWwuwM8WsFukKBxCa9v1xP8zdcs20cb8RrifjD8yCvKkm1pRlI7EGPvEAE+
 R8kkdlAFsd8CAzZIW9zjzUyocBgIUWtMS9+qnl+pGrk8N61gwnmnpXb2hRModDHgckeN
 wicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=+B4KfKqL7IWHD169FfPLbVrvTqwfsAYSk37J69imvTU=;
 b=RooTsEoosJ4RYNHMf7l9zSSSWw8fg65Kxtmm1b2TcCbnq/YVM0r9xf3vVIBIIj4/c3
 BKOSqPnccbgUm99dc7DWh+5MqprA1FJkNBhCJTaWIabkltwESk0IX2ctgsb//T1yeKQw
 jq5jW8FygESHsLmDLdM1WLeLgyW9BqEwXX7mWgXH22swZxff7JBpu0g2iGqwM9ooFJvB
 YaQ9zkr6V8QYWM6/N1RgfAnnI0ic7JBFLZgZXOgdlhjXryRg2lcn/L1Z0ecPWqEWTb+o
 x0Sb8EOcIRBrvxDpQchy0Jqw2Zon//yiwUCrRmY3eMDsomFqpkUbpvNydDT6w7sGH3xO
 rsVg==
X-Gm-Message-State: AGRZ1gJ7XQuIt5kRi6mByzvkZunO+mvYZngMZKysUNliAMN1YFBChJY8
 q2F+QhVKkF2frp1jmKt6NrmZAQ==
X-Google-Smtp-Source: AJdET5e4owfxUV+8CUAePR4mK57ujHpYP+vCYv5EIIlU1xg3ZMuL/cU6s7ZYip3rPtS3GuziMuqPtw==
X-Received: by 2002:a63:a064:: with SMTP id u36mr19300139pgn.145.1542613424009; 
 Sun, 18 Nov 2018 23:43:44 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id b2sm50034858pfm.3.2018.11.18.23.43.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Nov 2018 23:43:43 -0800 (PST)
Subject: Re: [PATCH kernel v3 10/22] powerpc/pseries/iommu: Use memory@ nodes
 in max RAM address calculation
To: David Gibson <david@gibson.dropbear.id.au>
References: <20181113082823.2440-1-aik@ozlabs.ru>
 <20181113082823.2440-11-aik@ozlabs.ru> <20181116052351.GC23632@umbus>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <41aaf5c0-4f30-0e87-a58b-31cde2f9b86c@ozlabs.ru>
Date: Mon, 19 Nov 2018 18:43:36 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181116052351.GC23632@umbus>
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



On 16/11/2018 16:23, David Gibson wrote:
> On Tue, Nov 13, 2018 at 07:28:11PM +1100, Alexey Kardashevskiy wrote:
>> We might have memory@ nodes with "linux,usable-memory" set to zero
>> (for example, to replicate powernv's behaviour for GPU coherent memory)
>> which means that the memory needs an extra initialization but since
>> it can be used afterwards, the pseries platform will try mapping it
>> for DMA so the DMA window needs to cover those memory regions too.
>>
>> This walks through the memory nodes to find the highest RAM address to
>> let a huge DMA window cover that too in case this memory gets onlined
>> later.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  arch/powerpc/platforms/pseries/iommu.c | 43 +++++++++++++++++++++++++-
>>  1 file changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
>> index 78473ac..f818737 100644
>> --- a/arch/powerpc/platforms/pseries/iommu.c
>> +++ b/arch/powerpc/platforms/pseries/iommu.c
>> @@ -967,6 +967,47 @@ struct failed_ddw_pdn {
>>  
>>  static LIST_HEAD(failed_ddw_pdn_list);
>>  
>> +static unsigned long read_n_cells(int n, const __be32 **buf)
>> +{
>> +	unsigned long result = 0;
>> +
>> +	while (n--) {
>> +		result = (result << 32) | of_read_number(*buf, 1);
>> +		(*buf)++;
>> +	}
>> +	return result;
>> +}
> 
> Um.. this appears to be re-implementing of_read_number() in terms of
> of_read_number().   Wat!?


This is a cut-n-paste from arch/powerpc/mm/numa.c :) My bad, I did not
think much when I did this.


> 
>> +static phys_addr_t ddw_memory_hotplug_max(void)
>> +{
>> +	phys_addr_t max_addr = memory_hotplug_max();
>> +	struct device_node *memory;
>> +
>> +	for_each_node_by_type(memory, "memory") {
>> +		unsigned long start, size;
>> +		int ranges, n_mem_addr_cells, n_mem_size_cells, len;
>> +		const __be32 *memcell_buf;
>> +
>> +		memcell_buf = of_get_property(memory, "reg", &len);
>> +		if (!memcell_buf || len <= 0)
>> +			continue;
>> +
>> +		n_mem_addr_cells = of_n_addr_cells(memory);
>> +		n_mem_size_cells = of_n_size_cells(memory);
>> +
>> +		/* ranges in cell */
>> +		ranges = (len >> 2) / (n_mem_addr_cells + n_mem_size_cells);
>> +
>> +		/* these are order-sensitive, and modify the buffer pointer */
>> +		start = read_n_cells(n_mem_addr_cells, &memcell_buf);
>> +		size = read_n_cells(n_mem_size_cells, &memcell_buf);
>> +
>> +		max_addr = max_t(phys_addr_t, max_addr, start + size);
>> +	}
>> +
>> +	return max_addr;
>> +}
> 
> Is there really no existing place we keep track of maxmimum possible
> memory address?

There are:

1. memblocks from mm/memblock.c - populated at the boot time from
"usable" memory@ nodes and mine are not "usable";

2. drmem from mm/drmem.c - populated from ibm,dynamic-memory-v2 - these
things do not support sparse regions so when I tried these with a GPU
RAM region mapped at 0x244000000000 - the device tree became quickly
over 1 MB and then qemu crashed, I did not debug any further as this
memory is not hotpluggable anyway from the rtas/qemu prospective, in
other words it is not something the user can hotplug or unplug.

And that is it afaict.


> 
>>  /*
>>   * If the PE supports dynamic dma windows, and there is space for a table
>>   * that can map all pages in a linear offset, then setup such a table,
>> @@ -1067,7 +1108,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn,
>>  	}
>>  	/* verify the window * number of ptes will map the partition */
>>  	/* check largest block * page size > max memory hotplug addr */
>> -	max_addr = memory_hotplug_max();
>> +	max_addr = ddw_memory_hotplug_max();
>>  	if (query.largest_available_block < (max_addr >> page_shift)) {
>>  		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %u "
>>  			  "%llu-sized pages\n", max_addr,  query.largest_available_block,
> 

-- 
Alexey
