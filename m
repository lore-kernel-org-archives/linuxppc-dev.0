Return-Path: <SRS0=pcIm=NN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AF2C32789
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 16:50:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73F2D2082D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 16:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ViFKH6LZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F2D2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42mp3z2sXtzF37t
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 03:50:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ViFKH6LZ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="ViFKH6LZ"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42mp1P4VRfzF37B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Nov 2018 03:48:41 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id f78-v6so1295791pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Nov 2018 09:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y1cYY1ocaqu2+SGIe8dA+KEBiH2Ixdqn/xcuKkFp8bo=;
 b=ViFKH6LZxW+SXUiCoSJuPXXPz2ErzhM/c+T+91Ikz5DcfV6UySQWjyBjnogpFM8uOz
 j887kycGxhE8+RhYJIEqW7085hzwJXv4coRQyDDShF9NER/KukWj46sHASygTv/ny+ta
 hjiSZRfkbCml3az7tuDnlaZ6Yy2G/CjtqFXHz9tG4vJ7jCwZM0HRIFD4C5ZqAHQGgTyG
 vCOlVFoJWMMuX7I5k52jOXQOaRAiS7vlYLMRcJK5IPwdDKRUCp7BaiwWQybYy9By1DX7
 x2cCHTDxSetVXH/j+3UyGqAcoLP3it7+5tcrklehzYrValEJuQOTSMW45ToK9VKtnfsr
 syHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y1cYY1ocaqu2+SGIe8dA+KEBiH2Ixdqn/xcuKkFp8bo=;
 b=l4Q3qQjnznbiS3T48vEZ9oG2JW5nzPYOqtbKt94UrfPRouoe/rCSHK9q+NinUtgQu5
 HWTfYWozMIROp5IMzgeBkkJ9+1LHE8mP8S5TFUOmGOwWV0rhLCoJpYeVuLi9JZ6nVd88
 VTAxYu4VYdmZBg2FzZrSSxgAwZNfGHgpd0tVref7eguiqx0D+z1QJjP1eEvTikUnMMJL
 KfN+2w9GmN5tSxKFXyjHiEjnsnSdtRp8hHRPqLBH7t5+O5osaPzL3Bmp1ICS4m/1Vikt
 JO35jhLkuzst9QeNzFGn30Ncq1AQ965Yk5gwJdhPxXFPEbqpgbso4i/46FGDpMOkGpRy
 KbEg==
X-Gm-Message-State: AGRZ1gLaxhHIB0nKKhZOCHuf/GLo0ZI0FUJZmRoYF+04VfV3ZPfTo1Xw
 hbtg3HWYW0L3KPlabTqMbacFqsjwBiIZC0RC/S6fLr24x5I=
X-Google-Smtp-Source: AJdET5cmztJvstE/Vk3IWXRaPOVltW8qn/VdY3DaPQZdtQbnD81lyr18AtTDzdO8M/5VcBJcYz1kUcRxhLgv9vN/gq8=
X-Received: by 2002:a62:5bc4:: with SMTP id
 p187-v6mr12465828pfb.94.1541177319054; 
 Fri, 02 Nov 2018 09:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181102043904.2808-1-joel@jms.id.au>
In-Reply-To: <20181102043904.2808-1-joel@jms.id.au>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 2 Nov 2018 09:48:27 -0700
Message-ID: <CAKwvOd=pZFW3m_0OzPug71t8cfusVOgn12WqA5Gch9_ZDEZeXg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/32: Avoid unsupported flags with clang
To: joel@jms.id.au
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 1, 2018 at 9:39 PM Joel Stanley <joel@jms.id.au> wrote:
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

Hi Joel, thanks for the patch!  In regards to cc-option, I guess it
might come down to whether you consider this a missing feature in
Clang that can be implemented vs is not strictly necessary.  If it's a
missing feature, then when Clang does implement this, and you try to
compile this code with the fixed version of Clang, you still won't
make use of it until at least one addition patch to this code is
submitted (at which point, maybe cc-option is the better choice).

cc-option makes it so then if something is going to be implemented,
but is not strictly required today, then it will start working without
additional effort in the future.  If there's no plans to implement
this in Clang because it's redundant/implicit/set by another flag/etc,
then the CONFIG_CC_IS_CLANG check is perfectly fine.

If you do consider it a missing feature, please take the time to file
a bug with LLVM.

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
> +endif
>  CFLAGS-$(CONFIG_PPC32) += $(call cc-option,-mno-readonly-in-sdata)
>
>  ifdef CONFIG_PPC_BOOK3S_64
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
