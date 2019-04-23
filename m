Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E0AC10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 16:14:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B0062175B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 16:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ijGLB9Dz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0062175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pT6z5CMzzDqCb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 02:14:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="ijGLB9Dz"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pT5J4VjYzDqCM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:13:23 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44pT5C09PRz9v07k;
 Tue, 23 Apr 2019 18:13:19 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=ijGLB9Dz; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id PTt_AgfKUemI; Tue, 23 Apr 2019 18:13:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44pT5B5zn7z9v07j;
 Tue, 23 Apr 2019 18:13:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556035998; bh=1AFTfzDB9IvMxny1fCOqjElP9QAgq1t7ENoaK1avYeo=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=ijGLB9DzCpnbNP6yJbut9gEIxYXWUfRrO4vdrgUGdI70HePzo9W6tj6+3Z9EjbyKR
 hkKGVUdMhoPcjZsSshnPkJW1g3W69qLRH+zwpvVFb87aYfBggEhFrn3qmOF6y9urut
 a5/+jlnxANDL45WLwXs3+Z3xQtAphu2BQnom/wlI=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7486C8B8E9;
 Tue, 23 Apr 2019 18:13:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id QwhBFByJ5pvT; Tue, 23 Apr 2019 18:13:20 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 29D408B8C4;
 Tue, 23 Apr 2019 18:13:20 +0200 (CEST)
Subject: Re: [PATCH][v2] powerpc/lib: remove memcpy_flushcache redundant return
To: Li RongQing <lirongqing@baidu.com>, linuxppc-dev@lists.ozlabs.org
References: <1555037513-22543-1-git-send-email-lirongqing@baidu.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1fef9512-20d6-a27c-b709-5b47ed72c79e@c-s.fr>
Date: Tue, 23 Apr 2019 18:13:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555037513-22543-1-git-send-email-lirongqing@baidu.com>
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



Le 12/04/2019 à 04:51, Li RongQing a écrit :
> Align it with other architectures and none of the callers has
> been interested its return
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> v1->v2: change memcpy_flushcache declaration in arch/powerpc/include/asm/string.h
> 
>   arch/powerpc/include/asm/string.h | 2 +-
>   arch/powerpc/lib/pmem.c           | 4 +---
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
> index 1647de15a31e..15e2e16272ea 100644
> --- a/arch/powerpc/include/asm/string.h
> +++ b/arch/powerpc/include/asm/string.h
> @@ -25,7 +25,7 @@ extern void * memcpy(void *,const void *,__kernel_size_t);
>   extern void * memmove(void *,const void *,__kernel_size_t);
>   extern int memcmp(const void *,const void *,__kernel_size_t);
>   extern void * memchr(const void *,int,__kernel_size_t);
> -extern void * memcpy_flushcache(void *,const void *,__kernel_size_t);
> +extern void memcpy_flushcache(void *, const void *, __kernel_size_t);

As you are modifying this line, you should make it fully iaw lastest 
rules, ie no 'extern' keyword and args should have names.

I guess, just copy it from pmem.c:

void memcpy_flushcache(void *dest, const void *src, size_t size);

Christophe

>   
>   #ifdef CONFIG_PPC64
>   #define __HAVE_ARCH_MEMSET32
> diff --git a/arch/powerpc/lib/pmem.c b/arch/powerpc/lib/pmem.c
> index 53c018762e1c..a7a1b3fc6720 100644
> --- a/arch/powerpc/lib/pmem.c
> +++ b/arch/powerpc/lib/pmem.c
> @@ -48,14 +48,12 @@ long __copy_from_user_flushcache(void *dest, const void __user *src,
>   	return copied;
>   }
>   
> -void *memcpy_flushcache(void *dest, const void *src, size_t size)
> +void memcpy_flushcache(void *dest, const void *src, size_t size)
>   {
>   	unsigned long start = (unsigned long) dest;
>   
>   	memcpy(dest, src, size);
>   	flush_inval_dcache_range(start, start + size);
> -
> -	return dest;
>   }
>   EXPORT_SYMBOL(memcpy_flushcache);
>   
> 
