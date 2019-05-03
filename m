Return-Path: <SRS0=37tr=TD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC4FC43219
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 14:19:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FBBC2075E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 14:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="oyEBpwZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBBC2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44wZ4v4CGhzDqnx
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 May 2019 00:19:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="oyEBpwZn"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44wYzc5Zn8zDqnl
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2019 00:14:36 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44wYzX0GDHz9v0Qq;
 Fri,  3 May 2019 16:14:32 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=oyEBpwZn; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id gFTAIGcYYqpx; Fri,  3 May 2019 16:14:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44wYzW6LSSz9v0Qp;
 Fri,  3 May 2019 16:14:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556892871; bh=4FP3jlxhOw7MO/z0jPsJssg5WmxNf+WleLB2wfm43OM=;
 h=From:Subject:Cc:References:To:Date:In-Reply-To:From;
 b=oyEBpwZnmvO22aGAGTnwP0mfPeRC10r3u63RuhVW9bnRhTaz0xqD2Inl4FWx8TmOP
 7BQbpHUSunw6z1z95HIxTfz7pg4s0t+63gGf2IL7LGmXZB/KLl+FGpWiNznF3UsCt5
 ZA5EUE7ZnUvwPH6QhsRrlvKP2UTpfIng8B1LKWnk=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 59C1A8B91F;
 Fri,  3 May 2019 16:14:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id bUUrU_B9bv25; Fri,  3 May 2019 16:14:33 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 36AA58B906;
 Fri,  3 May 2019 16:14:33 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc/32: Remove memory clobber asm constraint on
 dcbX() functions
References: <20180109065759.4E54B6C73D@localhost.localdomain>
To: Segher Boessenkool <segher@kernel.crashing.org>
Message-ID: <392ac8d7-c848-9661-706b-0fbb5b9e54bc@c-s.fr>
Date: Fri, 3 May 2019 16:14:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20180109065759.4E54B6C73D@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
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
Cc: linux-kernel@vger.kernel.org, Scott Wood <oss@buserror.net>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Segher,

A while ago I proposed the following patch, and didn't get any comment 
back on it.

Do you have any opinion on it ? Is it good and worth it ?

Thanks
Christophe

Le 09/01/2018 à 07:57, Christophe Leroy a écrit :
> Instead of just telling GCC that dcbz(), dcbi(), dcbf() and dcbst()
> clobber memory, tell it what it clobbers:
> * dcbz(), dcbi() and dcbf() clobbers one cacheline as output
> * dcbf() and dcbst() clobbers one cacheline as input
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> arch/powerpc/include/asm/cache.h | 17 +++++++++++++----
> 1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/cache.h 
> b/arch/powerpc/include/asm/cache.h
> index c1d257aa4c2d..fc8fe18acf8c 100644
> --- a/arch/powerpc/include/asm/cache.h
> +++ b/arch/powerpc/include/asm/cache.h
> @@ -82,22 +82,31 @@ extern void _set_L3CR(unsigned long);
> static inline void dcbz(void *addr)
> {
> - __asm__ __volatile__ ("dcbz 0, %0" : : "r"(addr) : "memory");
> + __asm__ __volatile__ ("dcbz 0, %1" :
> + "=m"(*(char (*)[L1_CACHE_BYTES])addr) :
> + "r"(addr) :);
> }
> static inline void dcbi(void *addr)
> {
> - __asm__ __volatile__ ("dcbi 0, %0" : : "r"(addr) : "memory");
> + __asm__ __volatile__ ("dcbi 0, %1" :
> + "=m"(*(char (*)[L1_CACHE_BYTES])addr) :
> + "r"(addr) :);
> }
> static inline void dcbf(void *addr)
> {
> - __asm__ __volatile__ ("dcbf 0, %0" : : "r"(addr) : "memory");
> + __asm__ __volatile__ ("dcbf 0, %1" :
> + "=m"(*(char (*)[L1_CACHE_BYTES])addr) :
> + "r"(addr), "m"(*(char (*)[L1_CACHE_BYTES])addr) :
> + );
> }
> static inline void dcbst(void *addr)
> {
> - __asm__ __volatile__ ("dcbst 0, %0" : : "r"(addr) : "memory");
> + __asm__ __volatile__ ("dcbst 0, %0" : :
> + "r"(addr), "m"(*(char (*)[L1_CACHE_BYTES])addr) :
> + );
> }
> #endif /* !__ASSEMBLY__ */
> #endif /* __KERNEL__ */
>
