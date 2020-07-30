Return-Path: <SRS0=fR6Q=BJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7A7C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 02:24:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164B720FC3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 02:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fuFGtOOu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fuFGtOOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164B720FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BHDl74cpFzDqVZ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 12:24:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=205.139.110.61;
 helo=us-smtp-delivery-1.mimecast.com; envelope-from=bhe@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=fuFGtOOu; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fuFGtOOu; 
 dkim-atps=neutral
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BHDhL6NjpzDqnr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2020 12:22:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596075743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KXlCZQMZEmyQ5Mo2+6vJS9lY2Q4U/rCj7yYVDEkdTyE=;
 b=fuFGtOOugJJnOX0Em8Bjy1G3gKfETPFfqqwCHmEYAxWYQAvtJtv97ZEqtvXEnZ4ktahMUr
 MR5ZwBccYh+WaOcCbiGEon8KC4c4+EaI8OZwjEZEBXJYSW3tgnDKvupIaF69xaXn2abU59
 1fNbrI3ST9mRWujYPQuSq+8L8+d89Ac=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596075743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KXlCZQMZEmyQ5Mo2+6vJS9lY2Q4U/rCj7yYVDEkdTyE=;
 b=fuFGtOOugJJnOX0Em8Bjy1G3gKfETPFfqqwCHmEYAxWYQAvtJtv97ZEqtvXEnZ4ktahMUr
 MR5ZwBccYh+WaOcCbiGEon8KC4c4+EaI8OZwjEZEBXJYSW3tgnDKvupIaF69xaXn2abU59
 1fNbrI3ST9mRWujYPQuSq+8L8+d89Ac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-x5Uy2qT2P5q-DIcPrk6VSQ-1; Wed, 29 Jul 2020 22:22:21 -0400
X-MC-Unique: x5Uy2qT2P5q-DIcPrk6VSQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90479801504;
 Thu, 30 Jul 2020 02:22:16 +0000 (UTC)
Received: from localhost (ovpn-13-67.pek2.redhat.com [10.72.13.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 62E1519D82;
 Thu, 30 Jul 2020 02:22:15 +0000 (UTC)
Date: Thu, 30 Jul 2020 10:22:09 +0800
From: Baoquan He <bhe@redhat.com>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 11/15] memblock: reduce number of parameters in
 for_each_mem_range()
Message-ID: <20200730022209.GK14854@MiWiFi-R3L-srv>
References: <20200728051153.1590-1-rppt@kernel.org>
 <20200728051153.1590-12-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728051153.1590-12-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, Stafford Horne <shorne@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Mike Rapoport <rppt@linux.ibm.com>, clang-built-linux@googlegroups.com,
 Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 07/28/20 at 08:11am, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Currently for_each_mem_range() iterator is the most generic way to traverse
> memblock regions. As such, it has 8 parameters and it is hardly convenient
> to users. Most users choose to utilize one of its wrappers and the only
> user that actually needs most of the parameters outside memblock is s390
> crash dump implementation.
> 
> To avoid yet another naming for memblock iterators, rename the existing
> for_each_mem_range() to __for_each_mem_range() and add a new
> for_each_mem_range() wrapper with only index, start and end parameters.
> 
> The new wrapper nicely fits into init_unavailable_mem() and will be used in
> upcoming changes to simplify memblock traversals.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  .clang-format                          |  1 +
>  arch/arm64/kernel/machine_kexec_file.c |  6 ++----
>  arch/s390/kernel/crash_dump.c          |  8 ++++----
>  include/linux/memblock.h               | 18 ++++++++++++++----
>  mm/page_alloc.c                        |  3 +--
>  5 files changed, 22 insertions(+), 14 deletions(-)

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/.clang-format b/.clang-format
> index a0a96088c74f..52ededab25ce 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -205,6 +205,7 @@ ForEachMacros:
>    - 'for_each_memblock_type'
>    - 'for_each_memcg_cache_index'
>    - 'for_each_mem_pfn_range'
> +  - '__for_each_mem_range'
>    - 'for_each_mem_range'
>    - 'for_each_mem_range_rev'
>    - 'for_each_migratetype_order'
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 361a1143e09e..5b0e67b93cdc 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -215,8 +215,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>  	phys_addr_t start, end;
>  
>  	nr_ranges = 1; /* for exclusion of crashkernel region */
> -	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
> -					MEMBLOCK_NONE, &start, &end, NULL)
> +	for_each_mem_range(i, &start, &end)
>  		nr_ranges++;
>  
>  	cmem = kmalloc(struct_size(cmem, ranges, nr_ranges), GFP_KERNEL);
> @@ -225,8 +224,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>  
>  	cmem->max_nr_ranges = nr_ranges;
>  	cmem->nr_ranges = 0;
> -	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
> -					MEMBLOCK_NONE, &start, &end, NULL) {
> +	for_each_mem_range(i, &start, &end) {
>  		cmem->ranges[cmem->nr_ranges].start = start;
>  		cmem->ranges[cmem->nr_ranges].end = end - 1;
>  		cmem->nr_ranges++;
> diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
> index f96a5857bbfd..e28085c725ff 100644
> --- a/arch/s390/kernel/crash_dump.c
> +++ b/arch/s390/kernel/crash_dump.c
> @@ -549,8 +549,8 @@ static int get_mem_chunk_cnt(void)
>  	int cnt = 0;
>  	u64 idx;
>  
> -	for_each_mem_range(idx, &memblock.physmem, &oldmem_type, NUMA_NO_NODE,
> -			   MEMBLOCK_NONE, NULL, NULL, NULL)
> +	__for_each_mem_range(idx, &memblock.physmem, &oldmem_type, NUMA_NO_NODE,
> +			     MEMBLOCK_NONE, NULL, NULL, NULL)
>  		cnt++;
>  	return cnt;
>  }
> @@ -563,8 +563,8 @@ static void loads_init(Elf64_Phdr *phdr, u64 loads_offset)
>  	phys_addr_t start, end;
>  	u64 idx;
>  
> -	for_each_mem_range(idx, &memblock.physmem, &oldmem_type, NUMA_NO_NODE,
> -			   MEMBLOCK_NONE, &start, &end, NULL) {
> +	__for_each_mem_range(idx, &memblock.physmem, &oldmem_type, NUMA_NO_NODE,
> +			     MEMBLOCK_NONE, &start, &end, NULL) {
>  		phdr->p_filesz = end - start;
>  		phdr->p_type = PT_LOAD;
>  		phdr->p_offset = start;
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index e6a23b3db696..d70c2835e913 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -142,7 +142,7 @@ void __next_reserved_mem_region(u64 *idx, phys_addr_t *out_start,
>  void __memblock_free_late(phys_addr_t base, phys_addr_t size);
>  
>  /**
> - * for_each_mem_range - iterate through memblock areas from type_a and not
> + * __for_each_mem_range - iterate through memblock areas from type_a and not
>   * included in type_b. Or just type_a if type_b is NULL.
>   * @i: u64 used as loop variable
>   * @type_a: ptr to memblock_type to iterate
> @@ -153,7 +153,7 @@ void __memblock_free_late(phys_addr_t base, phys_addr_t size);
>   * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
>   * @p_nid: ptr to int for nid of the range, can be %NULL
>   */
> -#define for_each_mem_range(i, type_a, type_b, nid, flags,		\
> +#define __for_each_mem_range(i, type_a, type_b, nid, flags,		\
>  			   p_start, p_end, p_nid)			\
>  	for (i = 0, __next_mem_range(&i, nid, flags, type_a, type_b,	\
>  				     p_start, p_end, p_nid);		\
> @@ -182,6 +182,16 @@ void __memblock_free_late(phys_addr_t base, phys_addr_t size);
>  	     __next_mem_range_rev(&i, nid, flags, type_a, type_b,	\
>  				  p_start, p_end, p_nid))
>  
> +/**
> + * for_each_mem_range - iterate through memory areas.
> + * @i: u64 used as loop variable
> + * @p_start: ptr to phys_addr_t for start address of the range, can be %NULL
> + * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
> + */
> +#define for_each_mem_range(i, p_start, p_end) \
> +	__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,	\
> +			     MEMBLOCK_NONE, p_start, p_end, NULL)
> +
>  /**
>   * for_each_reserved_mem_region - iterate over all reserved memblock areas
>   * @i: u64 used as loop variable
> @@ -287,8 +297,8 @@ int __init deferred_page_init_max_threads(const struct cpumask *node_cpumask);
>   * soon as memblock is initialized.
>   */
>  #define for_each_free_mem_range(i, nid, flags, p_start, p_end, p_nid)	\
> -	for_each_mem_range(i, &memblock.memory, &memblock.reserved,	\
> -			   nid, flags, p_start, p_end, p_nid)
> +	__for_each_mem_range(i, &memblock.memory, &memblock.reserved,	\
> +			     nid, flags, p_start, p_end, p_nid)
>  
>  /**
>   * for_each_free_mem_range_reverse - rev-iterate through free memblock areas
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e028b87ce294..95af111d69d3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6972,8 +6972,7 @@ static void __init init_unavailable_mem(void)
>  	 * Loop through unavailable ranges not covered by memblock.memory.
>  	 */
>  	pgcnt = 0;
> -	for_each_mem_range(i, &memblock.memory, NULL,
> -			NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end, NULL) {
> +	for_each_mem_range(i, &start, &end) {
>  		if (next < start)
>  			pgcnt += init_unavailable_range(PFN_DOWN(next),
>  							PFN_UP(start));
> -- 
> 2.26.2
> 
> 

