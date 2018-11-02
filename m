Return-Path: <SRS0=pcIm=NN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03A1C6786F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 04:49:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36EE32081F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 04:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="PpKMLBYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EE32081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42mV3r04T2zF379
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 15:49:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.b="PpKMLBYn";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::742; helo=mail-qk1-x742.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.b="PpKMLBYn"; 
 dkim-atps=neutral
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42mV1Q09RzzF36k
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Nov 2018 15:47:37 +1100 (AEDT)
Received: by mail-qk1-x742.google.com with SMTP id 131so1235726qkd.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Nov 2018 21:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=UcL5Ou8CZrrEl7B2yn9CDrRdobVqOkPgrZyuSxXdvD4=;
 b=PpKMLBYnP2TJRgydVT1VswkOa0XUdA6JWkyT4RPj6FSN/nCzoZz+UXFgodFvU8ra7z
 L34sIA/mhNFX9VkAOOzJf/wGT4eSpNgPmDbiSxnEfN8I/8eWPpn2eKDlbxfOOLFZ2j3D
 hQfQgu0K2POAUQV1G1KcOL0k+Gqd3t/IkCsq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=UcL5Ou8CZrrEl7B2yn9CDrRdobVqOkPgrZyuSxXdvD4=;
 b=UeKl2Wcxr2inrHLtJXU5cEAHKQAhJVRowkKnmgSasH/RkymLWvu2FR31bk3wuPwjU8
 jcAY/Ov2fv9OjcGTaBvz9P4bFhtmxtvOe9dHItzycV5AFadJ7AceUmB7V+RZqz1El/jC
 /vKIxKEpFDrPNRP9zHIJav72qUbb+q74drQ7kfIvOzjXQfKSQIB6FTr/tte7qAx45Ki3
 c8nXZFaWS5fghU8lIWh/ZmtgZPn9o52h+HjAb0TpM392S9a4N/sryoTxoLGrHzSuh3dj
 AdkbVEE0HliyT4tKBW4ELDTgcUOW2r/NE1aV9ua3s827BqbzxUDQBMiEpJVLvYjnqmr8
 VE+w==
X-Gm-Message-State: AGRZ1gJqwFX+8Qj4E+WF+yprPs5gmJ4axK4k+Z6gnAHNZd5GmMsYnuQe
 ogQ1cUuEhZ09nDE1ZB4k5lPJCoYSc8b9pHHYwAz1zg==
X-Google-Smtp-Source: AJdET5efJqLA9xuw+UlXPyr7H69cqteD6B19stkYrXWjQ5X2KWLTnKWTfkTIDJGPL9uFKYUdUNmxPYA6eAfeuquYPAI=
X-Received: by 2002:ae9:ef8a:: with SMTP id d132mr9023816qkg.11.1541134053957; 
 Thu, 01 Nov 2018 21:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181102043904.2808-1-joel@jms.id.au>
In-Reply-To: <20181102043904.2808-1-joel@jms.id.au>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 2 Nov 2018 15:17:22 +1030
Message-ID: <CACPK8Xe-te3JLk8_fQAt-FsOPHXibRUQNDKENachACeXpkG7GA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/32: Avoid unsupported flags with clang
To: linuxppc-dev@lists.ozlabs.org, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 2 Nov 2018 at 15:09, Joel Stanley <joel@jms.id.au> wrote:
>
> When building for ppc32 with clang these flags are unsupported:
>
>   -ffixed-r2 and -mmultiple
>
> llvm's lib/Target/PowerPC/PPCRegisterInfo.cpp marks r2 as reserved on
> when building for SVR4ABI and !ppc64:
>
>   // The SVR4 ABI reserves r2 and r13
>   if (Subtarget.isSVR4ABI()) {
>     // We only reserve r2 if we need to use the TOC pointer. If we have no
>     // explicit uses of the TOC pointer (meaning we're a leaf function with
>     // no constant-pool loads, etc.) and we have no potential uses inside an
>     // inline asm block, then we can treat r2 has an ordinary callee-saved
>     // register.
>     const PPCFunctionInfo *FuncInfo = MF.getInfo<PPCFunctionInfo>();
>     if (!TM.isPPC64() || FuncInfo->usesTOCBasePtr() || MF.hasInlineAsm())
>       markSuperRegs(Reserved, PPC::R2);  // System-reserved register
>     markSuperRegs(Reserved, PPC::R13); // Small Data Area pointer register
>   }
>
> This means we can safely omit -ffixed-r2 when building for 32-bit
> targets.
>
> The -mmultiple/-mno-multiple flags are not supported by clang, so
> platforms that might support multiple miss out on using multiple word
> instructions.
>
> Clang 8 can then build a ppc44x_defconfig which boots in Qemu:
>
>   make CC=clang-8 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-  ppc44x_defconfig
>   make CC=clang-8 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-
>
>   qemu-system-ppc -M bamboo \
>    -kernel arch/powerpc/boot/zImage \
>    -dtb arch/powerpc/boot/dts/bamboo.dtb \
>    -initrd ~/ppc32-440-rootfs.cpio \
>    -nographic -serial stdio -monitor pty -append "console=ttyS0"
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/261
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> I considered putting these behind a cc-option test. If someone has an
> opinion on that I'm happy to change.
>
>  arch/powerpc/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 17be664dafa2..5fa678eee747 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -152,7 +152,9 @@ endif
>  CFLAGS-$(CONFIG_PPC64) += $(call cc-option,-mcmodel=medium,$(call cc-option,-mminimal-toc))
>  CFLAGS-$(CONFIG_PPC64) += $(call cc-option,-mno-pointers-to-nested-functions)
>
> -CFLAGS-$(CONFIG_PPC32) := -ffixed-r2 $(MULTIPLEWORD)
> +ifndef CONFIG_CC_IS_CLANG
> +#CFLAGS-$(CONFIG_PPC32)        := -ffixed-r2 $(MULTIPLEWORD)

Whoops. I'll wait for any other comments before re-posting with this fixed.

> +endif
>  CFLAGS-$(CONFIG_PPC32) += $(call cc-option,-mno-readonly-in-sdata)
>
>  ifdef CONFIG_PPC_BOOK3S_64
> --
> 2.19.1
>
