Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1319C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 06:56:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC202147A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 06:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="kgjXfZTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC202147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4447ft5PgMzDqBK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 17:56:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="kgjXfZTr"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4447cZ0lJ1zDqFB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 17:54:06 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4447cS3j0Fz9v53Q;
 Wed, 20 Feb 2019 07:54:00 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=kgjXfZTr; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Bn2hm_V4Hql1; Wed, 20 Feb 2019 07:54:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4447cS2BDZz9v53N;
 Wed, 20 Feb 2019 07:54:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550645640; bh=vxoI0RcYtC3aywU0hjBdLsVZ9iagCn2zflhQcvueewE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=kgjXfZTriyD091KKYcaNbPDr9XjTc4I6qvOMVE4BIC2jJtWgpmUqzDO03aI6ArHdB
 +HJTYCWYN+jxTbvbv3dGFTmQEE5arWnweLyBZK6sa2kRfXyXz9DG9eNAAz8vEfZdPW
 kTQHlkIDhB0W2AlGlM2VZ3hZlEgMQ7Z0mx1kTg74=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 17B078B802;
 Wed, 20 Feb 2019 07:54:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id rrIoQFRD8MwM; Wed, 20 Feb 2019 07:54:00 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CF43B8B74F;
 Wed, 20 Feb 2019 07:54:00 +0100 (CET)
Subject: Re: [PATCH v2] powerpc/prom_init: add __init markers to all functions
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>
References: <1550641996-21937-1-git-send-email-yamada.masahiro@socionext.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <cc7ebb9b-90ac-e1ea-5057-cfcae6e772b8@c-s.fr>
Date: Wed, 20 Feb 2019 07:54:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1550641996-21937-1-git-send-email-yamada.masahiro@socionext.com>
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
Cc: Mathieu Malaterre <malat@debian.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 20/02/2019 à 06:53, Masahiro Yamada a écrit :
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
> I added __maybe_unused to prom_getproplen() because it is currently
> relying on the side-effect of 'inline'; GCC does not report
> -Wunused-function warnings for functions with 'inline' marker.

__maybe_unused is really a bad trick that should be avoided, as it hides 
unused functions.

Why is it a problem to keep prom_getproplen() as 'static inline' ? Most 
small helpers are defined that way. Usually they are in an included 
header file, but what's really the problem with having it here directly ?

Christophe

> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>    - Add __maybe_unsed to prom_getproplen()
>    - Add __init to enter_prom() as well
> 
>   arch/powerpc/kernel/prom_init.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index f33ff41..1bad0ac 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -138,9 +138,9 @@ extern void __start(unsigned long r3, unsigned long r4, unsigned long r5,
>   		    unsigned long r9);
>   
>   #ifdef CONFIG_PPC64
> -extern int enter_prom(struct prom_args *args, unsigned long entry);
> +extern int __init enter_prom(struct prom_args *args, unsigned long entry);
>   #else
> -static inline int enter_prom(struct prom_args *args, unsigned long entry)
> +static int __init enter_prom(struct prom_args *args, unsigned long entry)
>   {
>   	return ((int (*)(struct prom_args *))entry)(args);
>   }
> @@ -501,19 +501,20 @@ static int __init prom_next_node(phandle *nodep)
>   	}
>   }
>   
> -static inline int prom_getprop(phandle node, const char *pname,
> +static int __init prom_getprop(phandle node, const char *pname,
>   			       void *value, size_t valuelen)
>   {
>   	return call_prom("getprop", 4, 1, node, ADDR(pname),
>   			 (u32)(unsigned long) value, (u32) valuelen);
>   }
>   
> -static inline int prom_getproplen(phandle node, const char *pname)
> +static int __init __maybe_unused prom_getproplen(phandle node,
> +						 const char *pname)
>   {
>   	return call_prom("getproplen", 2, 1, node, ADDR(pname));
>   }
>   
> -static void add_string(char **str, const char *q)
> +static void __init add_string(char **str, const char *q)
>   {
>   	char *p = *str;
>   
> @@ -523,7 +524,7 @@ static void add_string(char **str, const char *q)
>   	*str = p;
>   }
>   
> -static char *tohex(unsigned int x)
> +static char __init *tohex(unsigned int x)
>   {
>   	static const char digits[] __initconst = "0123456789abcdef";
>   	static char result[9] __prombss;
> @@ -570,7 +571,7 @@ static int __init prom_setprop(phandle node, const char *nodename,
>   #define islower(c)	('a' <= (c) && (c) <= 'z')
>   #define toupper(c)	(islower(c) ? ((c) - 'a' + 'A') : (c))
>   
> -static unsigned long prom_strtoul(const char *cp, const char **endp)
> +static unsigned long __init prom_strtoul(const char *cp, const char **endp)
>   {
>   	unsigned long result = 0, base = 10, value;
>   
> @@ -595,7 +596,7 @@ static unsigned long prom_strtoul(const char *cp, const char **endp)
>   	return result;
>   }
>   
> -static unsigned long prom_memparse(const char *ptr, const char **retptr)
> +static unsigned long __init prom_memparse(const char *ptr, const char **retptr)
>   {
>   	unsigned long ret = prom_strtoul(ptr, retptr);
>   	int shift = 0;
> @@ -2924,7 +2925,7 @@ static void __init fixup_device_tree_pasemi(void)
>   	prom_setprop(iob, name, "device_type", "isa", sizeof("isa"));
>   }
>   #else	/* !CONFIG_PPC_PASEMI_NEMO */
> -static inline void fixup_device_tree_pasemi(void) { }
> +static void __init fixup_device_tree_pasemi(void) { }
>   #endif
>   
>   static void __init fixup_device_tree(void)
> @@ -2986,15 +2987,15 @@ static void __init prom_check_initrd(unsigned long r3, unsigned long r4)
>   
>   #ifdef CONFIG_PPC64
>   #ifdef CONFIG_RELOCATABLE
> -static void reloc_toc(void)
> +static void __init reloc_toc(void)
>   {
>   }
>   
> -static void unreloc_toc(void)
> +static void __init unreloc_toc(void)
>   {
>   }
>   #else
> -static void __reloc_toc(unsigned long offset, unsigned long nr_entries)
> +static void __init __reloc_toc(unsigned long offset, unsigned long nr_entries)
>   {
>   	unsigned long i;
>   	unsigned long *toc_entry;
> @@ -3008,7 +3009,7 @@ static void __reloc_toc(unsigned long offset, unsigned long nr_entries)
>   	}
>   }
>   
> -static void reloc_toc(void)
> +static void __init reloc_toc(void)
>   {
>   	unsigned long offset = reloc_offset();
>   	unsigned long nr_entries =
> @@ -3019,7 +3020,7 @@ static void reloc_toc(void)
>   	mb();
>   }
>   
> -static void unreloc_toc(void)
> +static void __init unreloc_toc(void)
>   {
>   	unsigned long offset = reloc_offset();
>   	unsigned long nr_entries =
> 
