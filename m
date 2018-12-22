Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38EBC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 11:06:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E8A21A48
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 11:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E8A21A48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MN3v2g9tzDrBp
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 22:06:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MLT56htdzDqWq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 20:55:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43MLT46d40z9sPj; Sat, 22 Dec 2018 20:55:04 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 72e7bcc2cdf82bf03caaa5e6c9b0134c2fc2ee7d
X-Patchwork-Hint: ignore
In-Reply-To: <20181112052806.18939-1-joel@jms.id.au>
To: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2] powerpc/32: Avoid unsupported flags with clang
Message-Id: <43MLT46d40z9sPj@ozlabs.org>
Date: Sat, 22 Dec 2018 20:55:04 +1100 (AEDT)
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
Cc: Nick Desaulniers <ndesaulniers@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2018-11-12 at 05:28:06 UTC, Joel Stanley wrote:
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
> We wrap these flags in cc-option so that when Clang gains support the
> kernel will be able use these flags.
> 
> Clang 8 can then build a ppc44x_defconfig which boots in Qemu:
> 
>   make CC=clang-8 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-  ppc44x_defconfig
>   ./scripts/config -e CONFIG_DEVTMPFS -d DEVTMPFS_MOUNT
>   make CC=clang-8 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-
> 
>   qemu-system-ppc -M bamboo \
>    -kernel arch/powerpc/boot/zImage \
>    -dtb arch/powerpc/boot/dts/bamboo.dtb \
>    -initrd ~/ppc32-440-rootfs.cpio \
>    -nographic -serial stdio -monitor pty -append "console=ttyS0"
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/261
> Link: https://bugs.llvm.org/show_bug.cgi?id=39556
> Link: https://bugs.llvm.org/show_bug.cgi?id=39555
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/72e7bcc2cdf82bf03caaa5e6c9b013

cheers
