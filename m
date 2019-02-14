Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3686C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 08:27:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD96C2229F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 08:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="VhubYzw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD96C2229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440TzY63VRzDqN9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 19:27:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="VhubYzw9"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440Txr6XMqzDqLx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 19:26:24 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 440Txl2cQsz9tykV;
 Thu, 14 Feb 2019 09:26:19 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=VhubYzw9; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Qw9cU7uYJVyD; Thu, 14 Feb 2019 09:26:19 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 440Txl1TDkz9tykT;
 Thu, 14 Feb 2019 09:26:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550132779; bh=UGOe1QWxBfW7ndQ+5pJ1730NUq1Y6MJhDOUpYpQMxe0=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=VhubYzw92naM79UL/+0hi+1+NEcvnnU3bQRHgsGDBfIqBacAR7/iK9YAL6AcenuJf
 YEkGq9lsGySsSDJasFWezq6po3hyapKUbVThJHkW8IFFpesSPbZsm1lzhHw1avf6wq
 MI0quGZdL2izttXopZLDeuWbOD0y9bNCjy7DyziQ=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 173748B87D;
 Thu, 14 Feb 2019 09:26:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 590FFlPJ2vnd; Thu, 14 Feb 2019 09:26:20 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 79F0F8B756;
 Thu, 14 Feb 2019 09:26:19 +0100 (CET)
Subject: Re: [PATCH 01/11] powerpc: remove dead ifdefs in <asm/checksum.h>
To: Christoph Hellwig <hch@lst.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
References: <20190213174005.28785-1-hch@lst.de>
 <20190213174005.28785-2-hch@lst.de>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <e7a2efe3-f56c-7dfd-6613-dc9229556673@c-s.fr>
Date: Thu, 14 Feb 2019 09:26:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190213174005.28785-2-hch@lst.de>
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
Cc: linux-xtensa@linux-xtensa.org, linux-kbuild@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 13/02/2019 à 18:39, Christoph Hellwig a écrit :
> __KERNEL__ is never not defined for non-uapi headers, and GENERIC_CSUM
> isn't ever set for powerpc either.

GENERIC_CSUM was abandonned by commit d4fde568a34a ("powerpc/64: Use 
optimized checksum routines on little-endian")

Could you also remove the 'config GENERIC_CSUM' item in 
arch/powerpc/Kconfig ?

Christophe

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/powerpc/include/asm/checksum.h | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
> index a78a57e5058d..37c309500260 100644
> --- a/arch/powerpc/include/asm/checksum.h
> +++ b/arch/powerpc/include/asm/checksum.h
> @@ -1,6 +1,5 @@
>   #ifndef _ASM_POWERPC_CHECKSUM_H
>   #define _ASM_POWERPC_CHECKSUM_H
> -#ifdef __KERNEL__
>   
>   /*
>    * This program is free software; you can redistribute it and/or
> @@ -9,9 +8,6 @@
>    * 2 of the License, or (at your option) any later version.
>    */
>   
> -#ifdef CONFIG_GENERIC_CSUM
> -#include <asm-generic/checksum.h>
> -#else
>   #include <linux/bitops.h>
>   #include <linux/in6.h>
>   /*
> @@ -217,6 +213,4 @@ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
>   			const struct in6_addr *daddr,
>   			__u32 len, __u8 proto, __wsum sum);
>   
> -#endif
> -#endif /* __KERNEL__ */
> -#endif
> +#endif /* _ASM_POWERPC_CHECKSUM_H */
> 
