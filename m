Return-Path: <rashmica.g@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTPG74gNTzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 17:19:27 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id z128so3451906pgb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 22:19:27 -0800 (PST)
Subject: Re: [RFC] Remove memory from nodes for memtrace.
To: Nicholas Piggin <npiggin@gmail.com>, bsingharora@gmail.com
References: <20170222213910.5628-1-rashmica.g@gmail.com>
 <20170223135635.5321dcc5@roar.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, bsingharora@gmail.com, dllehr@us.ibm.com,
 mpe@ellerman.id.au
From: RashmicaGupta <rashmica.g@gmail.com>
Message-ID: <086a2e02-5f8b-5752-7f4d-34e9f3d12feb@gmail.com>
Date: Thu, 23 Feb 2017 17:19:20 +1100
MIME-Version: 1.0
In-Reply-To: <20170223135635.5321dcc5@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 23/02/17 14:56, Nicholas Piggin wrote:
>
>> +
>> +static bool memtrace_offline_pages(u32 nid, u64 start_pfn, u64 nr_pages)
>> +{
>> +	u64 end_pfn = start_pfn + nr_pages - 1;
>> +
>> +	if (walk_memory_range(start_pfn, end_pfn, NULL,
>> +	    check_memblock_online))
>> +		return false;
>> +
>> +	walk_memory_range(start_pfn, end_pfn, (void *)MEM_GOING_OFFLINE,
>> +			  change_memblock_state);
>> +
>> +	if (offline_pages(start_pfn, nr_pages)) {
>> +		walk_memory_range(start_pfn, end_pfn, (void *)MEM_ONLINE,
>> +				  change_memblock_state);
>> +		return false;
>> +	}
>> +
>> +	walk_memory_range(start_pfn, end_pfn, (void *)MEM_OFFLINE,
>> +			  change_memblock_state);
>> +
>> +	/* RCU grace period? */
>> +	flush_memory_region((u64)__va(start_pfn << PAGE_SHIFT), nr_pages << PAGE_SHIFT);
>> +
>> +	remove_memory(nid, start_pfn << PAGE_SHIFT, nr_pages << PAGE_SHIFT);
>> +
>> +	return true;
>> +}
> This is the tricky part. Memory hotplug APIs don't seem well suited for
> what we're trying to do... Anyway, do a bit of grepping around for
> definitions of some of these calls, and how other code uses them. For
> example, remove_memory comment says caller must hold
> lock_device_hotplug() first, so we're missing that at least. I think
> that's also needed over the memblock state changes.
>
> We don't need an RCU grace period there AFAICT, because offline_pages
> should have us covered.
>
>
> I haven't looked at memory hotplug enough to know why we're open-coding
> the memblock stuff there. It would be nice to just be able to call
> memblock_remove() like the pseries hotplug code does.
remove_memory() calls memblock_remove() after confirming that
the memory is offlined. That seems sensible to me.
>
> I *think* it is because hot remove mostly comes from when we know about
> an online region of memory and we want to take it down. In this case we
> also are trying to discover if those addresses are covered by online
> memory. Still, I wonder if there are better memblock APIs to do this
> with? Balbir may have a better idea of that?
>
>
