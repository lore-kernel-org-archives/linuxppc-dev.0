Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9076CC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 07:12:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF455206B7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 07:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF455206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZxyX50kHzDqc6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 18:12:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Zxwn6vtpzDqXW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 18:10:48 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43Zxwg4y03z9v13h;
 Thu, 10 Jan 2019 08:10:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 4UUqa-duhMsa; Thu, 10 Jan 2019 08:10:43 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43Zxwg4NrBz9v13g;
 Thu, 10 Jan 2019 08:10:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 60C348B869;
 Thu, 10 Jan 2019 08:10:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id RE53uaKKsBhH; Thu, 10 Jan 2019 08:10:44 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E74BD8B761;
 Thu, 10 Jan 2019 08:10:43 +0100 (CET)
Subject: Re: [PATCH] powerpc/vdso32: Drop -mabi=elfv1 for 32 bit objects
To: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20190110014258.20963-1-joel@jms.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <82aeb9f8-6d25-de79-487c-a073ea33ba69@c-s.fr>
Date: Thu, 10 Jan 2019 08:10:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190110014258.20963-1-joel@jms.id.au>
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
Cc: Nick Desaulniers <ndesaulniers@google.com>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 10/01/2019 à 02:42, Joel Stanley a écrit :
> From: Daniel Axtens <dja@axtens.net>
> 
> All 64-bit objects need to specify the flag to be compiled correctly, we
> just don't need it for 32-bit objects. GCC just ignored it, but clang
> doesn't.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/240
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   arch/powerpc/kernel/vdso32/Makefile | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
> index 50112d4473bb..6bd41756e0c7 100644
> --- a/arch/powerpc/kernel/vdso32/Makefile
> +++ b/arch/powerpc/kernel/vdso32/Makefile
> @@ -34,6 +34,20 @@ obj-y += vdso32_wrapper.o
>   extra-y += vdso32.lds
>   CPPFLAGS_vdso32.lds += -P -C -Upowerpc
>   
> +# clang refuses to accept -mabi=elfv1 for when using the
> +# 64-bit target in 32-bit mode
> +ifdef CONFIG_CC_IS_CLANG

If -mabi=elfv1 is unneeded even for GCC, why depend on CLANG ?

> +ifdef CONFIG_PPC64
> +AFLAGS_REMOVE_getcpu.o += -mabi=elfv1
> +endif

Why only this one is inside the ifdef ? powerpc Makefile only set 
-mabi=elfv1 when CONFIG_PPC64 is set, so all objects should be handled 
the same way.

And would it harm just doing it all the time, regardless of CONFIG_PPC64 ?

Christophe

> +AFLAGS_REMOVE_sigtramp.o += -mabi=elfv1
> +AFLAGS_REMOVE_gettimeofday.o += -mabi=elfv1
> +AFLAGS_REMOVE_datapage.o += -mabi=elfv1
> +AFLAGS_REMOVE_cacheflush.o += -mabi=elfv1
> +AFLAGS_REMOVE_note.o += -mabi=elfv1
> +endif
> +
> +
>   # Force dependency (incbin is bad)
>   $(obj)/vdso32_wrapper.o : $(obj)/vdso32.so
>   
> 
