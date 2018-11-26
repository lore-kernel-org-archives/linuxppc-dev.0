Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E879EC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 06:57:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D9B20672
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 06:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D9B20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433HmM0VxNzDqBv
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 17:57:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433Hjz4lbkzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 17:55:34 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 433Hjq045Rz9vBnG;
 Mon, 26 Nov 2018 07:55:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id fl0u2sYs1i9N; Mon, 26 Nov 2018 07:55:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 433Hjp6KG2z9vBnC;
 Mon, 26 Nov 2018 07:55:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6DF8F8B77B;
 Mon, 26 Nov 2018 07:55:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id el9oNi336fh0; Mon, 26 Nov 2018 07:55:27 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 465498B74B;
 Mon, 26 Nov 2018 07:55:27 +0100 (CET)
Subject: Re: [PATCH] powerpc/kernel: Remove gcc 4 workaround from
 include/asm/io.h
To: Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org
References: <4ceed1989a9.364d3263@auth.smtp.1and1.co.uk>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <f728ba32-58e3-ab3c-f804-7b48e8ed7383@c-s.fr>
Date: Mon, 26 Nov 2018 07:55:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <4ceed1989a9.364d3263@auth.smtp.1and1.co.uk>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 25/11/2018 à 22:14, Darren Stevens a écrit :
> There are verions of DEF_MMIO_IN_X and DEF_MMIO_OUT_X in asm/io.h
> that contain a workaround for a limitation in gcc <=4.0, but the
> minimum supported version of gcc is now 4.6, so these can be safely
> removed.

This code is already gone, see 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v4.20-rc4&id=a0e102914aa3f619a5bc68a0d33e17d1788cdf4c

Christophe

> 
> Signed-off-by: Darren Stevens <darren@stevens-zone.net>
> 
> ---
> 
> diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
> index e0331e7..4433477 100644
> --- a/arch/powerpc/include/asm/io.h
> +++ b/arch/powerpc/include/asm/io.h
> @@ -108,25 +108,6 @@
>   #define IO_SET_SYNC_FLAG()
>   #endif
>   
> -/* gcc 4.0 and older doesn't have 'Z' constraint */
> -#if __GNUC__ < 4 || (__GNUC__ == 4 && __GNUC_MINOR__ == 0)
> -#define DEF_MMIO_IN_X(name, size, insn)                \
> -static inline u##size name(const volatile u##size __iomem *addr)   \
> -{                                  \
> -   u##size ret;                            \
> -   __asm__ __volatile__("sync;"#insn" %0,0,%1;twi 0,%0,0;isync"    \
> -       : "=r" (ret) : "r" (addr), "m" (*addr) : "memory"); \
> -   return ret;                         \
> -}
> -
> -#define DEF_MMIO_OUT_X(name, size, insn)               \
> -static inline void name(volatile u##size __iomem *addr, u##size val)   \
> -{                                  \
> -   __asm__ __volatile__("sync;"#insn" %1,0,%2"         \
> -       : "=m" (*addr) : "r" (val), "r" (addr) : "memory"); \
> -   IO_SET_SYNC_FLAG();                     \
> -}
> -#else /* newer gcc */
>   #define DEF_MMIO_IN_X(name, size, insn)                \
>   static inline u##size name(const volatile u##size __iomem *addr)   \
>   {                                  \
> @@ -143,7 +124,6 @@ static inline void name(volatile u##size __iomem *addr, u##size val)    \
>          : "=Z" (*addr) : "r" (val) : "memory");         \
>      IO_SET_SYNC_FLAG();                     \
>   }
> -#endif
>   
>   #define DEF_MMIO_IN_D(name, size, insn)                \
>   static inline u##size name(const volatile u##size __iomem *addr)   \
> 
