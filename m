Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29558C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 03:51:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD5C2081D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 03:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD5C2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pJcX65knzDrRY
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 14:50:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pJZD3y3szDrPn
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Nov 2018 14:48:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42pJZC6Tc8z9s7T;
 Mon,  5 Nov 2018 14:48:51 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org,
 Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] powerpc/32: Avoid unsupported flags with clang
In-Reply-To: <20181102043904.2808-1-joel@jms.id.au>
References: <20181102043904.2808-1-joel@jms.id.au>
Date: Mon, 05 Nov 2018 14:48:49 +1100
Message-ID: <87wopschge.fsf@concordia.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Joel Stanley <joel@jms.id.au> writes:

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
>  CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcmodel=medium,$(call cc-option,-mminimal-toc))
>  CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
>  
> -CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)
> +ifndef CONFIG_CC_IS_CLANG
> +#CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)
> +endif

I think using cc-option with a comment would be nicer, you could avoid
the ifdef and it would also future-proof it against the option either
appearing in a future clang or disappearing in a future gcc.

eg ~=:

# Clang doesn't need or support -ffixed-r2
CFLAGS-$(CONFIG_PPC32)	+= $(cc-option,-ffixed-r2)


cheers
