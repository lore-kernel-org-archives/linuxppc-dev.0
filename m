Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655C2C282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 06:50:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D82020811
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 06:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="mANsn7sy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D82020811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43twF43rw4zDqKZ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 17:50:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="mANsn7sy"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43twCL1q6qzDqK3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 17:48:43 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43twCB2w9gz9vBmM;
 Tue,  5 Feb 2019 07:48:38 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=mANsn7sy; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id qAddBe7tN4mQ; Tue,  5 Feb 2019 07:48:38 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43twCB1Mn9z9vBmK;
 Tue,  5 Feb 2019 07:48:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1549349318; bh=GyawFv6WhYMih/eQpEtJokJIoUycv8VfgtsTI4vRueY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=mANsn7syLFi/J7VpYUq1iIQ1/Q4H4cmeZfPAmzA6IL9O04+25yoq9cx890vGFVIqN
 POaDVng8rQ37Q749vfPFEY8F6AHzWZCN8n5vc5aITgP4ZS5CtYUOPFUIzIIN7oZsID
 gQy50Y/wBAUhxgH6b9y7bYIetojC5glAUDuqI16A=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 104B48B7E9;
 Tue,  5 Feb 2019 07:48:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 2HYZNq1YKaco; Tue,  5 Feb 2019 07:48:38 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 875658B74C;
 Tue,  5 Feb 2019 07:48:38 +0100 (CET)
Subject: Re: [PATCH v2] powerpc: drop page_is_ram() and walk_system_ram_range()
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <a14aac5408f98cf8ad8723ffa874764ccb42d4d4.1548978750.git.christophe.leroy@c-s.fr>
 <875ztzonqd.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <248f8aa2-10c2-2728-6f94-a56816a989e1@c-s.fr>
Date: Tue, 5 Feb 2019 07:48:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <875ztzonqd.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 04/02/2019 à 11:24, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> Since commit c40dd2f76644 ("powerpc: Add System RAM to /proc/iomem")
>> it is possible to use the generic walk_system_ram_range() and
>> the generic page_is_ram().
>>
>> To enable the use of walk_system_ram_range() by the IBM EHEA
>> ethernet driver, the generic function has to be exported.
> 
> I'm not sure if we have a policy on that, but I suspect we'd rather not
> add a new export on all arches unless we need to. Especially seeing as
> the only user is the EHEA code which is heavily in maintenance mode.

If you take the exemple of function walk_iomem_res_desc(), that's 
similar. It is only used by x86 it seems and exported for nvdimm/e820 
driver only.

See commit d76401ade0bb6ab0a7 ("libnvdimm, e820: Register all pmem 
resources")

> 
> I'll put the export in powerpc code and make sure that builds.

I thought there was a rule that EXPORT_SYMBOL has to immediately follow 
the function it exports. At least checkpatch checks for that.

Christophe

> 
>> As powerpc was the only (last?) user of CONFIG_ARCH_HAS_WALK_MEMORY,
>> the #ifdef around the generic walk_system_ram_range() has become
>> useless and can be dropped.
> 
> Yes it was the only user:
> 
> a99824f327c7 ("[POWERPC] Add arch-specific walk_memory_remove() for 64-bit powerpc")
> 
> I'll update the changelog.
> 
> cheers
> 
> 
>> Fixes: c40dd2f76644 ("powerpc: Add System RAM to /proc/iomem")
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/Kconfig            |  3 ---
>>   arch/powerpc/include/asm/page.h |  1 -
>>   arch/powerpc/mm/mem.c           | 33 ---------------------------------
>>   kernel/resource.c               |  5 +----
>>   4 files changed, 1 insertion(+), 41 deletions(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 2890d36eb531..f92e6754edf1 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -478,9 +478,6 @@ config ARCH_CPU_PROBE_RELEASE
>>   config ARCH_ENABLE_MEMORY_HOTPLUG
>>   	def_bool y
>>   
>> -config ARCH_HAS_WALK_MEMORY
>> -	def_bool y
>> -
>>   config ARCH_ENABLE_MEMORY_HOTREMOVE
>>   	def_bool y
>>   
>> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
>> index 5c5ea2413413..aa4497175bd3 100644
>> --- a/arch/powerpc/include/asm/page.h
>> +++ b/arch/powerpc/include/asm/page.h
>> @@ -326,7 +326,6 @@ struct page;
>>   extern void clear_user_page(void *page, unsigned long vaddr, struct page *pg);
>>   extern void copy_user_page(void *to, void *from, unsigned long vaddr,
>>   		struct page *p);
>> -extern int page_is_ram(unsigned long pfn);
>>   extern int devmem_is_allowed(unsigned long pfn);
>>   
>>   #ifdef CONFIG_PPC_SMLPAR
>> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
>> index 33cc6f676fa6..fa9916c2c662 100644
>> --- a/arch/powerpc/mm/mem.c
>> +++ b/arch/powerpc/mm/mem.c
>> @@ -80,11 +80,6 @@ static inline pte_t *virt_to_kpte(unsigned long vaddr)
>>   #define TOP_ZONE ZONE_NORMAL
>>   #endif
>>   
>> -int page_is_ram(unsigned long pfn)
>> -{
>> -	return memblock_is_memory(__pfn_to_phys(pfn));
>> -}
>> -
>>   pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>>   			      unsigned long size, pgprot_t vma_prot)
>>   {
>> @@ -176,34 +171,6 @@ int __meminit arch_remove_memory(int nid, u64 start, u64 size,
>>   #endif
>>   #endif /* CONFIG_MEMORY_HOTPLUG */
>>   
>> -/*
>> - * walk_memory_resource() needs to make sure there is no holes in a given
>> - * memory range.  PPC64 does not maintain the memory layout in /proc/iomem.
>> - * Instead it maintains it in memblock.memory structures.  Walk through the
>> - * memory regions, find holes and callback for contiguous regions.
>> - */
>> -int
>> -walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
>> -		void *arg, int (*func)(unsigned long, unsigned long, void *))
>> -{
>> -	struct memblock_region *reg;
>> -	unsigned long end_pfn = start_pfn + nr_pages;
>> -	unsigned long tstart, tend;
>> -	int ret = -1;
>> -
>> -	for_each_memblock(memory, reg) {
>> -		tstart = max(start_pfn, memblock_region_memory_base_pfn(reg));
>> -		tend = min(end_pfn, memblock_region_memory_end_pfn(reg));
>> -		if (tstart >= tend)
>> -			continue;
>> -		ret = (*func)(tstart, tend - tstart, arg);
>> -		if (ret)
>> -			break;
>> -	}
>> -	return ret;
>> -}
>> -EXPORT_SYMBOL_GPL(walk_system_ram_range);
>> -
>>   #ifndef CONFIG_NEED_MULTIPLE_NODES
>>   void __init mem_topology_setup(void)
>>   {
>> diff --git a/kernel/resource.c b/kernel/resource.c
>> index 915c02e8e5dd..2e1636041508 100644
>> --- a/kernel/resource.c
>> +++ b/kernel/resource.c
>> @@ -448,8 +448,6 @@ int walk_mem_res(u64 start, u64 end, void *arg,
>>   				     arg, func);
>>   }
>>   
>> -#if !defined(CONFIG_ARCH_HAS_WALK_MEMORY)
>> -
>>   /*
>>    * This function calls the @func callback against all memory ranges of type
>>    * System RAM which are marked as IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY.
>> @@ -480,8 +478,7 @@ int walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
>>   	}
>>   	return ret;
>>   }
>> -
>> -#endif
>> +EXPORT_SYMBOL_GPL(walk_system_ram_range);
>>   
>>   static int __is_ram(unsigned long pfn, unsigned long nr_pages, void *arg)
>>   {
>> -- 
>> 2.13.3
