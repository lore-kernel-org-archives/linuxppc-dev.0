Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB20C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 07:34:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C7E20835
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 07:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C7E20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XGfl654HzF39s
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 18:34:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XGcm6r0tzF1Pw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 18:32:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42XGcm6BTtz8sWN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 18:32:24 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 42XGcm5rrtz9s7W; Sat, 13 Oct 2018 18:32:24 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42XGcl6sS7z9s4Z
 for <linuxppc-dev@ozlabs.org>; Sat, 13 Oct 2018 18:32:23 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42XGcb0Rgqz9ttFk;
 Sat, 13 Oct 2018 09:32:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ebsbFZdv0_aP; Sat, 13 Oct 2018 09:32:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42XGcZ6tCcz9ttFY;
 Sat, 13 Oct 2018 09:32:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 263E28B781;
 Sat, 13 Oct 2018 09:32:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id BC6alJhzjQg0; Sat, 13 Oct 2018 09:32:20 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D40B48B74B;
 Sat, 13 Oct 2018 09:32:19 +0200 (CEST)
Subject: Re: [PATCH] powerpc: Fix stackprotector detection for non-glibc
 toolchains
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20181012225832.13827-1-mpe@ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7e1acec1-c840-321b-0a93-99679fce6cb3@c-s.fr>
Date: Sat, 13 Oct 2018 09:32:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012225832.13827-1-mpe@ellerman.id.au>
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



Le 13/10/2018 à 00:58, Michael Ellerman a écrit :
> If GCC is not built with glibc support then we must explicitly tell it
> which register to use for TLS mode stack protector, otherwise it will
> error out and the cc-option check will fail.

Oh ? I didn't encounter such a problem with the nolibc GCC from 
https://mirrors.edge.kernel.org/pub/tools/crosstool/

I did all my tests with powerpc64-linux-gcc 8.1 on x86_64

Christophe

> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   arch/powerpc/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 1888636c9eb6..3d008115fe18 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -180,7 +180,8 @@ config PPC
>   	select HAVE_ARCH_SECCOMP_FILTER
>   	select HAVE_ARCH_TRACEHOOK
>   	select HAVE_CBPF_JIT			if !PPC64
> -	select HAVE_STACKPROTECTOR		if $(cc-option,-mstack-protector-guard=tls)
> +	select HAVE_STACKPROTECTOR		if PPC64 && $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=r13)
> +	select HAVE_STACKPROTECTOR		if PPC32 && $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=r2)
>   	select HAVE_CONTEXT_TRACKING		if PPC64
>   	select HAVE_DEBUG_KMEMLEAK
>   	select HAVE_DEBUG_STACKOVERFLOW
> 
