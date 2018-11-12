Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637E1C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 19:01:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FAA122419
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 19:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u/0F16JT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FAA122419
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42v0VR0C46zF3Nw
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 06:01:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="u/0F16JT";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="u/0F16JT"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42v0Rv1ZmVzDr4h
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 05:59:39 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id x21-v6so2039823pln.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 10:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Jiqkdevj6tSCiyA5Zkqswa8F3NiP16NLgpTuGPtWRB0=;
 b=u/0F16JTgHeTPnb+xLAz1SeLpXE2RIqY9XyuHwhSv0cr6b6jBlj+w0zMZ1cyshkZeJ
 I/uyia3qr8hQ3z3CeNWfzEM0PhELo8sEyd/Y6h8h9kJBxkEl78K466I0ixm3kIUAn2lW
 T87DXo5hZQUt920lTGPXlVk1B01p5aTOd8CglLxEZwxQnnQhZVebGnZLk+9rB50tbvY0
 u4RyKpV/lhr/bpIkWU6Cb6gVi8wYCAnlXjwudxmME6HcDmg9gaVoARzpgDCFGj2PCj/5
 u4tFbpUpWvU2kZShsNYEudM04upSur3f6s/X4odw0aK8vw5jh9ruZn4R9oET+nsGd2hV
 upSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jiqkdevj6tSCiyA5Zkqswa8F3NiP16NLgpTuGPtWRB0=;
 b=LHO9vCHzlvjMVTN51gPyiP34+vvBHshEeNFj+D44DY2WHVVcZDTJ9CDhSsEZjp2qde
 1OLfTuJozGoEiKZoUXgaFbtS0z/Vx2QQb++KOlJL2EpngIjyywInd/oPt7INW4B0dfcw
 ZLT2gk4+IkiixG+YX4TO27+Mk09JN/CbMJ9W673QaJHhWH4bQjIe0GCATN1uG4hRVhrZ
 MjkotPsOPGc8+E36cwVpeEXV9J2tJK0vq3sssz+9R04oN5DdMoNSGvnncqFsAnznkW6a
 fWqSrNNFjN/773WIuxgegzvViv2YJefKQlDfVGdS8n4FnfVW37qNXBiRd7XuXc4qRCMF
 0sMw==
X-Gm-Message-State: AGRZ1gInYcprQlTSCdaR09pP56Yf8NW9B4Xfd/CDMcpt65GFyDBUbeeY
 8j/rV3PSyXKxM4nv5fueztjV20k8hNCQ9XWlx4HRVBVnJ7Y=
X-Google-Smtp-Source: AJdET5etS2najVe06I+cTTSUte19dbczGgGjjNhwHaJ9dcekgj0QO0o9EfE3q9uvywK01uZZPVRJFHGkyqcaviyYhRQ=
X-Received: by 2002:a17:902:5a2:: with SMTP id
 f31-v6mr1992840plf.320.1542049177128; 
 Mon, 12 Nov 2018 10:59:37 -0800 (PST)
MIME-Version: 1.0
References: <20181112052806.18939-1-joel@jms.id.au>
In-Reply-To: <20181112052806.18939-1-joel@jms.id.au>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 12 Nov 2018 10:59:26 -0800
Message-ID: <CAKwvOdn5o8HQJpu8f8sV6P7Wq95ptotwcV7mFFMKbek4X12cHA@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/32: Avoid unsupported flags with clang
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

On Sun, Nov 11, 2018 at 9:28 PM Joel Stanley <joel@jms.id.au> wrote:
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

Hopefully we can get these fixed up soon for you, thanks Joel!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/powerpc/Makefile | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 8a2ce14d68d0..4685671dfb4f 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -152,7 +152,14 @@ endif
>  CFLAGS-$(CONFIG_PPC64) += $(call cc-option,-mcmodel=medium,$(call cc-option,-mminimal-toc))
>  CFLAGS-$(CONFIG_PPC64) += $(call cc-option,-mno-pointers-to-nested-functions)
>
> -CFLAGS-$(CONFIG_PPC32) := -ffixed-r2 $(MULTIPLEWORD)
> +# Clang unconditionally reserves r2 on ppc32 and does not support the flag
> +# https://bugs.llvm.org/show_bug.cgi?id=39555
> +CFLAGS-$(CONFIG_PPC32) := $(call cc-option, -ffixed-r2)
> +
> +# Clang doesn't support -mmultiple / -mno-multiple
> +# https://bugs.llvm.org/show_bug.cgi?id=39556
> +CFLAGS-$(CONFIG_PPC32) += $(call cc-option, $(MULTIPLEWORD))
> +
>  CFLAGS-$(CONFIG_PPC32) += $(call cc-option,-mno-readonly-in-sdata)
>
>  ifdef CONFIG_PPC_BOOK3S_64
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
