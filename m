Return-Path: <SRS0=EPkL=OK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1427AC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Dec 2018 01:53:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4884F20834
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Dec 2018 01:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U54D0cjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4884F20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 436DmW0yblzDr48
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Dec 2018 12:52:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U54D0cjB";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=richard.weiyang@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="U54D0cjB"; 
 dkim-atps=neutral
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 436Djd2Z6szDrNM
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Dec 2018 12:50:28 +1100 (AEDT)
Received: by mail-ed1-x542.google.com with SMTP id o10so6296655edt.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 17:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=kA5awGLteXhWzixCBwgwKbAtZj0X5Gu4io9xhbwVwOQ=;
 b=U54D0cjBUDokEV+dwCojYNG35YnkBD796fVUezkdOwHy30VuGsQNuYPtm5cZcvFbwt
 D5sH1z2k/hCIDuZXWFNhR01WYrasooqrXs65FmhACbGxLDIOIM6hGyhoArovQxpNv8J8
 FNasmOzJiPqkwVPOVcQKfZsXIQlcuMxiyaBgJHE7eh6lQnJKGIzTtKhxuEdkhOyfsfSj
 l8KWoM7bXPgammS5rXdN/1bHKZSgx/DpVClT9TLISBQia5b1fsxj2qH9W53MP+L8RvXK
 4zz6YcZx2I/nlKJKUqQ5vaMFfkoIwdZnRW2Szl8rpV4b0KDePh7cT537mLDvfBD4Rwnp
 /dCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=kA5awGLteXhWzixCBwgwKbAtZj0X5Gu4io9xhbwVwOQ=;
 b=b6LQG+dYfS5MO1xlTrXIXgC0s7hii/qo35M20w/lGdKimzSZU6LdgtXhmYLLACPo3q
 +TeoehjoYh7sPKkiYiUu/rfG8+sc4Pde5T26Eu7QA9Aqcf+GFPpVp+xI/s0aqX58o87x
 D/X7+55QjqgVKHAYtKrDxhptgGG7jQ1FJamoj3hjgScy0vuDGA3gjlpxPKaamyN+xG+P
 m44Xd6AuTqQqVwbmGKF1tA3uLzwdy2OsnTfhegR8XV990itWFuuQbmamUEDUdDNrdTZ/
 kRHSRYutsRL7fOyXP2R7jRTKXZeQukl06E6o5LJ2GWcm/ZPVN+gZDUmdfqV484bNDs50
 GGYg==
X-Gm-Message-State: AA+aEWaL8WwvDnZyq3dSz4Kgc9PpYUTuz/w14fU6zqV73Mdb9EYIdc3k
 94efwU0wAZGE3skRBAhbG20=
X-Google-Smtp-Source: AFSGD/XTWEA1t5koymtCv6T7FqU5WChMvkylyaj1TTcOe4ZUtZy2u+U4DaaZ3F0jxL59nUOsRKabjA==
X-Received: by 2002:a50:bdc8:: with SMTP id z8mr7034602edh.46.1543629026056;
 Fri, 30 Nov 2018 17:50:26 -0800 (PST)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id z16-v6sm1052433eju.61.2018.11.30.17.50.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 17:50:25 -0800 (PST)
Date: Sat, 1 Dec 2018 01:50:24 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFCv2 2/4] mm/memory_hotplug: Replace "bool
 want_memblock" by "int type"
Message-ID: <20181201015024.3o334nk2fe5mlasj@master>
References: <20181130175922.10425-1-david@redhat.com>
 <20181130175922.10425-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130175922.10425-3-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: Oscar Salvador <osalvador@suse.com>, Rich Felker <dalias@libc.org>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Dan Williams <dan.j.williams@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-s390@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 x86@kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 xen-devel@lists.xenproject.org, Rob Herring <robh@kernel.org>,
 Fenghua Yu <fenghua.yu@intel.com>, "Jan H. Sch??nherr" <jschoenh@amazon.de>,
 Pavel Tatashin <pasha.tatashin@soleen.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 "mike.travis@hpe.com" <mike.travis@hpe.com>,
 Jonathan Neusch??fer <j.neuschaefer@gmx.net>,
 Nicholas Piggin <npiggin@gmail.com>, J??r??me Glisse <jglisse@redhat.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Arun KS <arunks@codeaurora.org>,
 Tony Luck <tony.luck@intel.com>, Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Logan Gunthorpe <logang@deltatee.com>,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, devel@linuxdriverproject.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 30, 2018 at 06:59:20PM +0100, David Hildenbrand wrote:
>Let's pass a memory block type instead. Pass "MEMORY_BLOCK_NONE" for device
>memory and for now "MEMORY_BLOCK_UNSPECIFIED" for anything else. No
>functional change.

I would suggest to put more words to this.

"
Function arch_add_memory()'s last parameter *want_memblock* is used to
determin whether it is necessary to create a corresponding memory block
device. After introducing the memory block type, this patch replaces the
bool type *want_memblock* with memory block type with following rules
for now:

  * Pass "MEMORY_BLOCK_NONE" for device memory
  * Pass "MEMORY_BLOCK_UNSPECIFIED" for anything else 

Since this parameter is passed deep to __add_section(), all its
descendents are effected. Below lists those descendents.

  arch_add_memory()
    add_pages()
      __add_pages()
        __add_section()

"

>
>Cc: Tony Luck <tony.luck@intel.com>
>Cc: Fenghua Yu <fenghua.yu@intel.com>
>Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>Cc: Paul Mackerras <paulus@samba.org>
>Cc: Michael Ellerman <mpe@ellerman.id.au>
>Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>Cc: Rich Felker <dalias@libc.org>
>Cc: Dave Hansen <dave.hansen@linux.intel.com>
>Cc: Andy Lutomirski <luto@kernel.org>
>Cc: Peter Zijlstra <peterz@infradead.org>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: Ingo Molnar <mingo@redhat.com>
>Cc: Borislav Petkov <bp@alien8.de>
>Cc: "H. Peter Anvin" <hpa@zytor.com>
>Cc: x86@kernel.org
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>Cc: Oscar Salvador <osalvador@suse.com>
>Cc: Nicholas Piggin <npiggin@gmail.com>
>Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>Cc: Christophe Leroy <christophe.leroy@c-s.fr>
>Cc: "Jonathan Neusch??fer" <j.neuschaefer@gmx.net>
>Cc: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
>Cc: Vasily Gorbik <gor@linux.ibm.com>
>Cc: Arun KS <arunks@codeaurora.org>
>Cc: Rob Herring <robh@kernel.org>
>Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>Cc: "mike.travis@hpe.com" <mike.travis@hpe.com>
>Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>Cc: Wei Yang <richard.weiyang@gmail.com>
>Cc: Logan Gunthorpe <logang@deltatee.com>
>Cc: "J??r??me Glisse" <jglisse@redhat.com>
>Cc: "Jan H. Sch??nherr" <jschoenh@amazon.de>
>Cc: Dave Jiang <dave.jiang@intel.com>
>Cc: Matthew Wilcox <willy@infradead.org>
>Cc: Mathieu Malaterre <malat@debian.org>
>Signed-off-by: David Hildenbrand <david@redhat.com>
>---
> arch/ia64/mm/init.c            |  4 ++--
> arch/powerpc/mm/mem.c          |  4 ++--
> arch/s390/mm/init.c            |  4 ++--
> arch/sh/mm/init.c              |  4 ++--
> arch/x86/mm/init_32.c          |  4 ++--
> arch/x86/mm/init_64.c          |  8 ++++----
> drivers/base/memory.c          | 11 +++++++----
> include/linux/memory.h         |  2 +-
> include/linux/memory_hotplug.h | 12 ++++++------
> kernel/memremap.c              |  6 ++++--
> mm/memory_hotplug.c            | 16 ++++++++--------
> 11 files changed, 40 insertions(+), 35 deletions(-)
>
>diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
>index 904fe55e10fc..408635d2902f 100644
>--- a/arch/ia64/mm/init.c
>+++ b/arch/ia64/mm/init.c
>@@ -646,13 +646,13 @@ mem_init (void)
> 
> #ifdef CONFIG_MEMORY_HOTPLUG
> int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
>-		bool want_memblock)
>+		    int type)
> {
> 	unsigned long start_pfn = start >> PAGE_SHIFT;
> 	unsigned long nr_pages = size >> PAGE_SHIFT;
> 	int ret;
> 
>-	ret = __add_pages(nid, start_pfn, nr_pages, altmap, want_memblock);
>+	ret = __add_pages(nid, start_pfn, nr_pages, altmap, type);
> 	if (ret)
> 		printk("%s: Problem encountered in __add_pages() as ret=%d\n",
> 		       __func__,  ret);
>diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
>index b3c9ee5c4f78..e394637da270 100644
>--- a/arch/powerpc/mm/mem.c
>+++ b/arch/powerpc/mm/mem.c
>@@ -118,7 +118,7 @@ int __weak remove_section_mapping(unsigned long start, unsigned long end)
> }
> 
> int __meminit arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
>-		bool want_memblock)
>+			      int type)
> {
> 	unsigned long start_pfn = start >> PAGE_SHIFT;
> 	unsigned long nr_pages = size >> PAGE_SHIFT;
>@@ -135,7 +135,7 @@ int __meminit arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *
> 	}
> 	flush_inval_dcache_range(start, start + size);
> 
>-	return __add_pages(nid, start_pfn, nr_pages, altmap, want_memblock);
>+	return __add_pages(nid, start_pfn, nr_pages, altmap, type);
> }
> 
> #ifdef CONFIG_MEMORY_HOTREMOVE
>diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
>index 3e82f66d5c61..ba2c56328e6d 100644
>--- a/arch/s390/mm/init.c
>+++ b/arch/s390/mm/init.c
>@@ -225,7 +225,7 @@ device_initcall(s390_cma_mem_init);
> #endif /* CONFIG_CMA */
> 
> int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
>-		bool want_memblock)
>+		    int type)
> {
> 	unsigned long start_pfn = PFN_DOWN(start);
> 	unsigned long size_pages = PFN_DOWN(size);
>@@ -235,7 +235,7 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
> 	if (rc)
> 		return rc;
> 
>-	rc = __add_pages(nid, start_pfn, size_pages, altmap, want_memblock);
>+	rc = __add_pages(nid, start_pfn, size_pages, altmap, type);
> 	if (rc)
> 		vmem_remove_mapping(start, size);
> 	return rc;
>diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
>index 1a483a008872..5fbb8724e0f2 100644
>--- a/arch/sh/mm/init.c
>+++ b/arch/sh/mm/init.c
>@@ -419,14 +419,14 @@ void free_initrd_mem(unsigned long start, unsigned long end)
> 
> #ifdef CONFIG_MEMORY_HOTPLUG
> int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
>-		bool want_memblock)
>+		    int type)
> {
> 	unsigned long start_pfn = PFN_DOWN(start);
> 	unsigned long nr_pages = size >> PAGE_SHIFT;
> 	int ret;
> 
> 	/* We only have ZONE_NORMAL, so this is easy.. */
>-	ret = __add_pages(nid, start_pfn, nr_pages, altmap, want_memblock);
>+	ret = __add_pages(nid, start_pfn, nr_pages, altmap, type);
> 	if (unlikely(ret))
> 		printk("%s: Failed, __add_pages() == %d\n", __func__, ret);
> 
>diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
>index 0b8c7b0033d2..41e409b29d2b 100644
>--- a/arch/x86/mm/init_32.c
>+++ b/arch/x86/mm/init_32.c
>@@ -851,12 +851,12 @@ void __init mem_init(void)
> 
> #ifdef CONFIG_MEMORY_HOTPLUG
> int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
>-		bool want_memblock)
>+		    int type)
> {
> 	unsigned long start_pfn = start >> PAGE_SHIFT;
> 	unsigned long nr_pages = size >> PAGE_SHIFT;
> 
>-	return __add_pages(nid, start_pfn, nr_pages, altmap, want_memblock);
>+	return __add_pages(nid, start_pfn, nr_pages, altmap, type);
> }
> 
> #ifdef CONFIG_MEMORY_HOTREMOVE
>diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>index f80d98381a97..5b4f3dcd44cf 100644
>--- a/arch/x86/mm/init_64.c
>+++ b/arch/x86/mm/init_64.c
>@@ -783,11 +783,11 @@ static void update_end_of_memory_vars(u64 start, u64 size)
> }
> 
> int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
>-		struct vmem_altmap *altmap, bool want_memblock)
>+	      struct vmem_altmap *altmap, int type)
> {
> 	int ret;
> 
>-	ret = __add_pages(nid, start_pfn, nr_pages, altmap, want_memblock);
>+	ret = __add_pages(nid, start_pfn, nr_pages, altmap, type);
> 	WARN_ON_ONCE(ret);
> 
> 	/* update max_pfn, max_low_pfn and high_memory */
>@@ -798,14 +798,14 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
> }
> 
> int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
>-		bool want_memblock)
>+		    int type)
> {
> 	unsigned long start_pfn = start >> PAGE_SHIFT;
> 	unsigned long nr_pages = size >> PAGE_SHIFT;
> 
> 	init_memory_mapping(start, start + size);
> 
>-	return add_pages(nid, start_pfn, nr_pages, altmap, want_memblock);
>+	return add_pages(nid, start_pfn, nr_pages, altmap, type);
> }
> 
> #define PAGE_INUSE 0xFD
>diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>index 17f2985c07c5..c42300082c88 100644
>--- a/drivers/base/memory.c
>+++ b/drivers/base/memory.c
>@@ -741,7 +741,7 @@ static int add_memory_block(int base_section_nr)
>  * need an interface for the VM to add new memory regions,
>  * but without onlining it.
>  */
>-int hotplug_memory_register(int nid, struct mem_section *section)
>+int hotplug_memory_register(int nid, struct mem_section *section, int type)
> {
> 	int ret = 0;
> 	struct memory_block *mem;
>@@ -750,11 +750,14 @@ int hotplug_memory_register(int nid, struct mem_section *section)
> 
> 	mem = find_memory_block(section);
> 	if (mem) {
>-		mem->section_count++;
>+		/* make sure the type matches */
>+		if (mem->type == type)
>+			mem->section_count++;
>+		else
>+			ret = -EINVAL;
> 		put_device(&mem->dev);
> 	} else {
>-		ret = init_memory_block(&mem, section, MEM_OFFLINE,
>-					MEMORY_BLOCK_UNSPECIFIED);
>+		ret = init_memory_block(&mem, section, MEM_OFFLINE, type);
> 		if (ret)
> 			goto out;
> 		mem->section_count++;
>diff --git a/include/linux/memory.h b/include/linux/memory.h
>index 06268e96e0da..9f39ef41e6d2 100644
>--- a/include/linux/memory.h
>+++ b/include/linux/memory.h
>@@ -138,7 +138,7 @@ extern int register_memory_notifier(struct notifier_block *nb);
> extern void unregister_memory_notifier(struct notifier_block *nb);
> extern int register_memory_isolate_notifier(struct notifier_block *nb);
> extern void unregister_memory_isolate_notifier(struct notifier_block *nb);
>-int hotplug_memory_register(int nid, struct mem_section *section);
>+int hotplug_memory_register(int nid, struct mem_section *section, int type);
> #ifdef CONFIG_MEMORY_HOTREMOVE
> extern int unregister_memory_section(int nid, struct mem_section *);
> #endif
>diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
>index 5493d3fa0c7f..667a37aa9a3c 100644
>--- a/include/linux/memory_hotplug.h
>+++ b/include/linux/memory_hotplug.h
>@@ -117,18 +117,18 @@ extern void shrink_zone(struct zone *zone, unsigned long start_pfn,
> 
> /* reasonably generic interface to expand the physical pages */
> extern int __add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
>-		struct vmem_altmap *altmap, bool want_memblock);
>+		       struct vmem_altmap *altmap, int type);
> 
> #ifndef CONFIG_ARCH_HAS_ADD_PAGES
> static inline int add_pages(int nid, unsigned long start_pfn,
>-		unsigned long nr_pages, struct vmem_altmap *altmap,
>-		bool want_memblock)
>+			    unsigned long nr_pages, struct vmem_altmap *altmap,
>+			    int type)
> {
>-	return __add_pages(nid, start_pfn, nr_pages, altmap, want_memblock);
>+	return __add_pages(nid, start_pfn, nr_pages, altmap, type);
> }
> #else /* ARCH_HAS_ADD_PAGES */
> int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
>-		struct vmem_altmap *altmap, bool want_memblock);
>+	      struct vmem_altmap *altmap, int type);
> #endif /* ARCH_HAS_ADD_PAGES */
> 
> #ifdef CONFIG_NUMA
>@@ -330,7 +330,7 @@ extern int __add_memory(int nid, u64 start, u64 size);
> extern int add_memory(int nid, u64 start, u64 size);
> extern int add_memory_resource(int nid, struct resource *resource);
> extern int arch_add_memory(int nid, u64 start, u64 size,
>-		struct vmem_altmap *altmap, bool want_memblock);
>+			   struct vmem_altmap *altmap, int type);
> extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
> 		unsigned long nr_pages, struct vmem_altmap *altmap);
> extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
>diff --git a/kernel/memremap.c b/kernel/memremap.c
>index 66cbf334203b..422e4e779208 100644
>--- a/kernel/memremap.c
>+++ b/kernel/memremap.c
>@@ -4,6 +4,7 @@
> #include <linux/io.h>
> #include <linux/kasan.h>
> #include <linux/memory_hotplug.h>
>+#include <linux/memory.h>
> #include <linux/mm.h>
> #include <linux/pfn_t.h>
> #include <linux/swap.h>
>@@ -215,7 +216,8 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
> 	 */
> 	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
> 		error = add_pages(nid, align_start >> PAGE_SHIFT,
>-				align_size >> PAGE_SHIFT, NULL, false);
>+				  align_size >> PAGE_SHIFT, NULL,
>+				  MEMORY_BLOCK_NONE);
> 	} else {
> 		error = kasan_add_zero_shadow(__va(align_start), align_size);
> 		if (error) {
>@@ -224,7 +226,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
> 		}
> 
> 		error = arch_add_memory(nid, align_start, align_size, altmap,
>-				false);
>+					MEMORY_BLOCK_NONE);

Ok, it is used here.

> 	}
> 
> 	if (!error) {
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index 16c600771298..7246faa44488 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -246,7 +246,7 @@ void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
> #endif /* CONFIG_HAVE_BOOTMEM_INFO_NODE */
> 
> static int __meminit __add_section(int nid, unsigned long phys_start_pfn,
>-		struct vmem_altmap *altmap, bool want_memblock)
>+				   struct vmem_altmap *altmap, int type)
> {
> 	int ret;
> 
>@@ -257,10 +257,11 @@ static int __meminit __add_section(int nid, unsigned long phys_start_pfn,
> 	if (ret < 0)
> 		return ret;
> 
>-	if (!want_memblock)
>+	if (type == MEMORY_BLOCK_NONE)
> 		return 0;
> 
>-	return hotplug_memory_register(nid, __pfn_to_section(phys_start_pfn));
>+	return hotplug_memory_register(nid, __pfn_to_section(phys_start_pfn),
>+				       type);
> }
> 
> /*
>@@ -270,8 +271,8 @@ static int __meminit __add_section(int nid, unsigned long phys_start_pfn,
>  * add the new pages.
>  */
> int __ref __add_pages(int nid, unsigned long phys_start_pfn,
>-		unsigned long nr_pages, struct vmem_altmap *altmap,
>-		bool want_memblock)
>+		      unsigned long nr_pages, struct vmem_altmap *altmap,
>+		      int type)
> {
> 	unsigned long i;
> 	int err = 0;
>@@ -295,8 +296,7 @@ int __ref __add_pages(int nid, unsigned long phys_start_pfn,
> 	}
> 
> 	for (i = start_sec; i <= end_sec; i++) {
>-		err = __add_section(nid, section_nr_to_pfn(i), altmap,
>-				want_memblock);
>+		err = __add_section(nid, section_nr_to_pfn(i), altmap, type);
> 
> 		/*
> 		 * EEXIST is finally dealt with by ioresource collision
>@@ -1100,7 +1100,7 @@ int __ref add_memory_resource(int nid, struct resource *res)
> 	new_node = ret;
> 
> 	/* call arch's memory hotadd */
>-	ret = arch_add_memory(nid, start, size, NULL, true);
>+	ret = arch_add_memory(nid, start, size, NULL, MEMORY_TYPE_UNSPECIFIED);
> 	if (ret < 0)
> 		goto error;
> 
>-- 
>2.17.2

-- 
Wei Yang
Help you, Help me
