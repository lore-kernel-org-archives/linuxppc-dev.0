Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B25C282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 10:29:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067022080A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 10:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067022080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v16M1D6MzDqLJ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 21:29:47 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v14d74mtzDqD7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 21:28:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43v14d3yB0z9sMl;
 Tue,  5 Feb 2019 21:28:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/prom_init: add __init markers to all functions
In-Reply-To: <1548903199-32695-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548903199-32695-1-git-send-email-yamada.masahiro@socionext.com>
Date: Tue, 05 Feb 2019 21:28:16 +1100
Message-ID: <87k1iemsvz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Mathieu Malaterre <malat@debian.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> It is fragile to rely on the compiler's optimization to avoid the
> section mismatch. Some functions may not be necessarily inlined
> when the compiler's inlining heuristic changes.
>
> Add __init markers consistently.
>
> As for prom_getprop() and prom_getproplen(), they are marked as
> 'inline', so inlining is guaranteed because PowerPC never enables
> CONFIG_OPTIMIZE_INLINING. However, it would be better to leave the
> inlining decision to the compiler. I replaced 'inline' with __init.

I'm going to drop that part because it breaks the build in some
configurations (as reported by the build robot).

> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index f33ff41..85b0719 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -501,19 +501,19 @@ static int __init prom_next_node(phandle *nodep)
>  	}
>  }
>  
> -static inline int prom_getprop(phandle node, const char *pname,
> +static int __init prom_getprop(phandle node, const char *pname,
>  			       void *value, size_t valuelen)
>  {
>  	return call_prom("getprop", 4, 1, node, ADDR(pname),
>  			 (u32)(unsigned long) value, (u32) valuelen);
>  }
>  
> -static inline int prom_getproplen(phandle node, const char *pname)
> +static int __init prom_getproplen(phandle node, const char *pname)
>  {
>  	return call_prom("getproplen", 2, 1, node, ADDR(pname));
>  }
>  
> -static void add_string(char **str, const char *q)
> +static void __init add_string(char **str, const char *q)
>  {
>  	char *p = *str;
>  
> @@ -523,7 +523,7 @@ static void add_string(char **str, const char *q)
>  	*str = p;
>  }
>  
> -static char *tohex(unsigned int x)
> +static char __init *tohex(unsigned int x)
>  {
>  	static const char digits[] __initconst = "0123456789abcdef";
>  	static char result[9] __prombss;
> @@ -570,7 +570,7 @@ static int __init prom_setprop(phandle node, const char *nodename,
>  #define islower(c)	('a' <= (c) && (c) <= 'z')
>  #define toupper(c)	(islower(c) ? ((c) - 'a' + 'A') : (c))
>  
> -static unsigned long prom_strtoul(const char *cp, const char **endp)
> +static unsigned long __init prom_strtoul(const char *cp, const char **endp)
>  {
>  	unsigned long result = 0, base = 10, value;
>  
> @@ -595,7 +595,7 @@ static unsigned long prom_strtoul(const char *cp, const char **endp)
>  	return result;
>  }
>  
> -static unsigned long prom_memparse(const char *ptr, const char **retptr)
> +static unsigned long __init prom_memparse(const char *ptr, const char **retptr)
>  {
>  	unsigned long ret = prom_strtoul(ptr, retptr);
>  	int shift = 0;
> @@ -2924,7 +2924,7 @@ static void __init fixup_device_tree_pasemi(void)
>  	prom_setprop(iob, name, "device_type", "isa", sizeof("isa"));
>  }
>  #else	/* !CONFIG_PPC_PASEMI_NEMO */
> -static inline void fixup_device_tree_pasemi(void) { }
> +static inline void __init fixup_device_tree_pasemi(void) { }

I don't think we need __init for an empty static inline.

>  #endif
>  
>  static void __init fixup_device_tree(void)
> @@ -2986,15 +2986,15 @@ static void __init prom_check_initrd(unsigned long r3, unsigned long r4)
>  
>  #ifdef CONFIG_PPC64
>  #ifdef CONFIG_RELOCATABLE
> -static void reloc_toc(void)
> +static void __init reloc_toc(void)
>  {
>  }
>  
> -static void unreloc_toc(void)
> +static void __init unreloc_toc(void)
>  {
>  }

Those should be empty static inlines, I'll fix them up.

>  #else
> -static void __reloc_toc(unsigned long offset, unsigned long nr_entries)
> +static void __init __reloc_toc(unsigned long offset, unsigned long nr_entries)
>  {
>  	unsigned long i;
>  	unsigned long *toc_entry;
> @@ -3008,7 +3008,7 @@ static void __reloc_toc(unsigned long offset, unsigned long nr_entries)
>  	}
>  }
>  
> -static void reloc_toc(void)
> +static void __init reloc_toc(void)
>  {
>  	unsigned long offset = reloc_offset();
>  	unsigned long nr_entries =
> @@ -3019,7 +3019,7 @@ static void reloc_toc(void)
>  	mb();
>  }
>  
> -static void unreloc_toc(void)
> +static void __init unreloc_toc(void)
>  {
>  	unsigned long offset = reloc_offset();
>  	unsigned long nr_entries =


cheers
