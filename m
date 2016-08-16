Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sCzjZ2n6zzDr45
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 14:22:42 +1000 (AEST)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sCzjY4Z6Bz9t2G
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2016 14:22:41 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id y134so4781953pfg.3
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Aug 2016 21:22:41 -0700 (PDT)
Subject: Re: [PATCH] powerpc/powernv: Initialise nest mmu
To: Alistair Popple <alistair@popple.id.au>
References: <1471243919-18362-1-git-send-email-alistair@popple.id.au>
 <20160815072240.GA21080@balbir.ozlabs.ibm.com>
 <1989530.M5axb7bib9@new-mexico>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, stewart@linux.vnet.ibm.com, mpe@ellerman.id.au
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <a405f24b-2a80-4828-cf65-a40824130f5e@gmail.com>
Date: Tue, 16 Aug 2016 14:22:33 +1000
MIME-Version: 1.0
In-Reply-To: <1989530.M5axb7bib9@new-mexico>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16/08/16 10:37, Alistair Popple wrote:
> Balbir,
> 
> <snip>
>  
>>> +	/* Update partition table control register on all Nest MMUs */
>>> +	opal_nmmu_set_ptcr(-1UL, __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
>>> +
>>
>> Just wondering if
>>
>> 1. Instead of using -1 for all cpus, we should do
>> 	for_each_online_cpu() {
>> 		opal_numm_set_ptcr(...)
>> 	}
> 
> Good question, but I don't think it makes sense to do that. The NMMU is
> per-chip/socket rather than per-cpu so it shouldn't be tied to
> onlining/offlining of individual CPUs.
> 
>> 2. In cpu hotplug path do the same when onlining and set to NULL on
>> offlining?
> 
> Again, the nmmu isn't tied to a specific CPU but rather a chip/socket. So in
> theory at least it's possible that all CPUs in a chip could be offline but
> other units on the chip could still be using the nmmu so we wouldn't want to
> disable the nmmu at that point.

Fair enough

Balbir Singh.
