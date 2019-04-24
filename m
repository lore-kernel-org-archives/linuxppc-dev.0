Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F096C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:17:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9524120835
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="M1tdwgwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9524120835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ps7t1DRYzDqTP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 17:16:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="M1tdwgwj"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ps5Z0YgFzDqRr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 17:14:55 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44ps5R3zSmz9v10h;
 Wed, 24 Apr 2019 09:14:51 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=M1tdwgwj; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 7bcD5UtHitT5; Wed, 24 Apr 2019 09:14:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44ps5R2mljz9v10g;
 Wed, 24 Apr 2019 09:14:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556090091; bh=4KNl/Lib2mZ6PbQYm0kmmtGURLN3TatY1c1J9aM+jtk=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=M1tdwgwjltcCijkxcCcpI4kvCVMME7uyHfVZcPmA5HCFOwvNISBpa8bRIMod9f+GL
 0Byzs4av2HLU6gz2EO8q9VyWj+yAQfyfCbB8ONjvbHFZXAhSeuplDxeNKV1o1DAn5Q
 7eLBdcerEu9I9Yd1vS0rv6IbeeAsmOZKC+S3LlLM=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 57DC88B8ED;
 Wed, 24 Apr 2019 09:14:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id hZRFJAXdMEyL; Wed, 24 Apr 2019 09:14:52 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2FEFC8B7CB;
 Wed, 24 Apr 2019 09:14:52 +0200 (CEST)
Subject: Re: [PATCH 2/2] powerpc/mm: Warn if W+X pages found on boot
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
References: <20190424063958.24559-1-ruscur@russell.cc>
 <20190424063958.24559-2-ruscur@russell.cc>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8e659a8f-af3f-e889-3f7a-560178c1f7b1@c-s.fr>
Date: Wed, 24 Apr 2019 09:14:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424063958.24559-2-ruscur@russell.cc>
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
Cc: Julia.Lawall@lip6.fr, rashmica.g@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 24/04/2019 à 08:39, Russell Currey a écrit :
> Implement code to walk all pages and warn if any are found to be both
> writable and executable.  Depends on STRICT_KERNEL_RWX enabled, and is
> behind the DEBUG_WX config option.
> 
> This only runs on boot and has no runtime performance implications.
> 
> Very heavily influenced (and in some cases copied verbatim) from the
> ARM64 code written by Laura Abbott (thanks!), since our ptdump
> infrastructure is similar.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
>   arch/powerpc/Kconfig.debug         | 19 +++++++++++++++
>   arch/powerpc/include/asm/pgtable.h |  5 ++++
>   arch/powerpc/mm/pgtable_32.c       |  5 ++++
>   arch/powerpc/mm/pgtable_64.c       |  5 ++++
>   arch/powerpc/mm/ptdump/ptdump.c    | 38 ++++++++++++++++++++++++++++++
>   5 files changed, 72 insertions(+)
> 
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index 4e00cb0a5464..a4160ff02ed4 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -361,6 +361,25 @@ config PPC_PTDUMP
>   
>   	  If you are unsure, say N.
>   
> +config DEBUG_WX

I would call it PPC_DEBUG_WX to avoid confusion.

> +	bool "Warn on W+X mappings at boot"
> +	select PPC_PTDUMP
> +	---help---
> +	  Generate a warning if any W+X mappings are found at boot.
> +
> +	  This is useful for discovering cases where the kernel is leaving
> +	  W+X mappings after applying NX, as such mappings are a security risk.
> +
> +	  Note that even if the check fails, your kernel is possibly
> +	  still fine, as W+X mappings are not a security hole in
> +	  themselves, what they do is that they make the exploitation
> +	  of other unfixed kernel bugs easier.
> +
> +	  There is no runtime or memory usage effect of this option
> +	  once the kernel has booted up - it's a one time check.
> +
> +	  If in doubt, say "Y".
> +
>   config PPC_FAST_ENDIAN_SWITCH
>   	bool "Deprecated fast endian-switch syscall"
>           depends on DEBUG_KERNEL && PPC_BOOK3S_64
> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> index 505550fb2935..be785f221e56 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -104,6 +104,11 @@ void pgtable_cache_init(void);
>   
>   #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_PPC32)
>   void mark_initmem_nx(void);
> +
> +#ifdef CONFIG_DEBUG_WX

I don't think this #ifdef is necessary at all when there is no matching 
#else. You could leave the declaration of the function all the time.

> +extern void ptdump_check_wx(void);

'extern' keyword is superflous and checkpatch --strict will likely complain.

> +#endif /* CONFIG_DEBUG_WX */
> +
>   #else
>   static inline void mark_initmem_nx(void) { }
>   #endif
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index 6e56a6240bfa..054a6174ff7f 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -384,6 +384,11 @@ void mark_rodata_ro(void)
>   		   PFN_DOWN((unsigned long)__start_rodata);
>   
>   	change_page_attr(page, numpages, PAGE_KERNEL_RO);
> +
> +#ifdef CONFIG_DEBUG_WX
> +	// mark_initmem_nx() should have already run by now
> +	ptdump_check_wx();

Please avoid #ifdefs in .c files as much as possible.

It would be better to define ptdump_check_wx() as static inline {} in 
pgtable.h when CONFIG_DEBUG_WX is not selected.

> +#endif
>   }
>   #endif
>   
> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
> index fb1375c07e8c..48036b25a958 100644
> --- a/arch/powerpc/mm/pgtable_64.c
> +++ b/arch/powerpc/mm/pgtable_64.c
> @@ -328,6 +328,11 @@ void mark_rodata_ro(void)
>   		radix__mark_rodata_ro();
>   	else
>   		hash__mark_rodata_ro();
> +
> +#ifdef CONFIG_DEBUG_WX
> +	// mark_initmem_nx() should have already run by now
> +	ptdump_check_wx();
> +#endif

Idem

>   }
>   
>   void mark_initmem_nx(void)
> diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
> index c50cb7faa334..b4b09df839bb 100644
> --- a/arch/powerpc/mm/ptdump/ptdump.c
> +++ b/arch/powerpc/mm/ptdump/ptdump.c
> @@ -68,6 +68,8 @@ struct pg_state {
>   	unsigned long last_pa;
>   	unsigned int level;
>   	u64 current_flags;
> +	bool check_wx;
> +	unsigned long wx_pages;
>   };
>   
>   struct addr_marker {
> @@ -177,6 +179,19 @@ static void dump_addr(struct pg_state *st, unsigned long addr)
>   
>   }
>   
> +static void note_prot_wx(struct pg_state *st, unsigned long addr)
> +{
> +	if (!st->check_wx)
> +		return;
> +	if (!((st->current_flags & _PAGE_EXEC) && (st->current_flags & _PAGE_WRITE)))

The above won't work in all cases. _PAGE_WRITE is only defined in 
book3s64. Other arches have _PAGE_RW or _PAGE_RO.

Please use the helpers defined in pgtable.h to check and not flags directly.


> +		return;
> +
> +	WARN_ONCE(1, "powerpc/mm: Found insecure W+X mapping at address %p/%pS\n",
> +		  (void *)st->start_address, (void *)st->start_address);
> +
> +	st->wx_pages += (addr - st->start_address) / PAGE_SIZE;
> +}
> +
>   static void note_page(struct pg_state *st, unsigned long addr,
>   	       unsigned int level, u64 val)
>   {
> @@ -206,6 +221,7 @@ static void note_page(struct pg_state *st, unsigned long addr,
>   
>   		/* Check the PTE flags */
>   		if (st->current_flags) {
> +			note_prot_wx(st, addr);
>   			dump_addr(st, addr);
>   
>   			/* Dump all the flags */
> @@ -378,6 +394,28 @@ static void build_pgtable_complete_mask(void)
>   				pg_level[i].mask |= pg_level[i].flag[j].mask;
>   }
>   
> +void ptdump_check_wx(void)
> +{
> +	struct pg_state st = {
> +		.seq = NULL,
> +		.marker = address_markers,
> +		.check_wx = true,
> +	};
> +
> +	if (radix_enabled())
> +		st.start_address = PAGE_OFFSET;
> +	else
> +		st.start_address = KERN_VIRT_START;

KERN_VIRT_START doesn't exist on PPC32.

Christophe

> +
> +	walk_pagetables(&st);
> +
> +	if (st.wx_pages)
> +		pr_warn("Checked W+X mappings: FAILED, %lu W+X pages found\n",
> +			st.wx_pages);
> +	else
> +		pr_info("Checked W+X mappings: passed, no W+X pages found\n");
> +}
> +
>   static int ptdump_init(void)
>   {
>   	struct dentry *debugfs_file;
> 
