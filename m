Return-Path: <linuxppc-dev+bounces-28250-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA685C9832A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 21:53:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hs4G21hcgz2yMm;
	Sat, 26 Sep 2026 07:53:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:30::e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790373210;
	cv=pass; b=ZMtJmeYrg7GyGNlDDWSmBNyMXvTNV8hUQch8zlEH6DtFTwYVya4zr7ArabBVjsdkQv3kBD181Xq/v+azc8xf6vEpeXe12fRMZsWQYdzzmsAUxkU7HPlSLfDiWwmnUdvELBRwR5LDJFDnz2uGLo74zBGAnuS85jKrgj81YuoiEzJUloA3rUe3Oh/5uPbaAESORUhJENtZuE/TraqB1a4IYKYsgfZ1b88qse4AzHTPhBtllaVVVjKRw2A8swg9d5NeKbx7x1dOM+PcPrFXjxsWyWItIILB/SNN4cxuxgCYXXATqHflyYjsdb0QXDBh5B4cW/wZwTQ7INb/9VKtFDVRXQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790373210; c=relaxed/relaxed;
	bh=dVV1KtWyTLSLHpIl6BWB4AgM90d4cWInAt7fjY5duR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2p8AA1AQecx3OAn5alz9Rls5u+G8k/nXcNtykLXUQ+JrrL3gAkXyWdi6QIIwhEijm1CyDloHIKD5rsbpYN2RUoqLv5lHb9QkKZAtiHctCxCt5JzTUo/RQUYkP2r/LzbRSoJydEUDY6p6W6RMpmL1pAOVX+csFRVJhwqPrqos3NKZsokJF7DFjZtwjrSLcb9x+b4h3qwC9Wl7lFkAykoeBVzqdF7aDAL9NZCKrfGea/Qz1E7X7+4HQdlFoGSR0EqdB9ra8TQjGBXThG6894CvmnTG7rEenkaFzOSGe0oOP9smLIq68QesmpoMWwoRI/fVyJ0WEky1GxhMdChpfWy8g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QyMXvLEv; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:30::e; helo=mail-wr2-x0e.google.com; envelope-from=ndesaulniers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QyMXvLEv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:30::e; helo=mail-wr2-x0e.google.com; envelope-from=ndesaulniers@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr2-x0e.google.com (mail-wr2-x0e.google.com [IPv6:2a00:1450:4864:30::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hs4G01Hy1z2xwM
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 07:53:27 +1000 (AEST)
Received: by mail-wr2-x0e.google.com with SMTP id ffacd0b85a97d-48884b926f0so261795f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 14:53:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790373204; cv=none;
        d=google.com; s=arc-20260327;
        b=D5XvlhE3Gf7Io3blhQA2gnG35AMg6PewT2KsS0HCNPewycqEk3Z7LfGwVKEQMrK0od
         BOzargODJdL4STPRUBgTX0lzIBAI9BbYycEnBjk8rfvHL1Pf6txDUHx7oP1/ec5N10b0
         OWRafBqUZQOdI7AndIrZS5Az0S6zJNHUSdARpjBu/oWQGoS0jS//x1nVyVpwMI8AKqED
         xSmRmuVz5IjCYE1YfnpLKtUj1LiSKA0X/AmeBLqowt3sj/g1CbPnQNRDoekR4bK+Y72G
         HcGArvDh/C6+CMt2nqHv4psGLFqGKG/w30ZdbXVv4PdS68XXGLWmrCfTLCtoJpz1Sxg6
         J5Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dVV1KtWyTLSLHpIl6BWB4AgM90d4cWInAt7fjY5duR4=;
        fh=+59mrNqhSJ7+1ZG/n65tq0TSf4IFQWFU9HXSM32BLsw=;
        b=GtHubnNQyMpCXrCI4oTx6B+tbAJqtn/ntD2nN1UmlJS23sTYJIbLpdfVgBS1+dvCr+
         dBL9DjlPmrPHoaBkZoba3Xs0zwB+ZieVMLp9kJvb8C2WluTwPdr6dn2xhrHXuXc/ZfN5
         MheFGFRnNbuFgtXzEChWZeiEpE/TRws17AXnrezdlF2NOQHr3d7LJnhNGcFxPu+dEDRo
         UYGNfiGka4s5OnVkbrPhtnQQ7BsYFRZ8mFAxQ+88kdJnHW1+XzvilInRCKbhzy32ZUq8
         RGIZBofXEd0uPnfzBatUidPvFTatWnyJeMCkfItGFic8sD255x+uB6vyXguEOhtyOj4o
         NMWg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790373204; x=1790978004; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dVV1KtWyTLSLHpIl6BWB4AgM90d4cWInAt7fjY5duR4=;
        b=QyMXvLEvoInmdQBnsIPGs86Y1HJ7SPpnWUGOUtjHDh7X8PaRQ38LqQBNXVHNxTfx1d
         qwtih8yXYO0YVy7E4vi+rJKgN91SgjNgMR3972Jx1x/QAj8BUfc5n5H07JTzucT33NWA
         H8mEwWCu8RPZpA8Bvo1f9SgiTywEOkizL4df/vAUUASD/fTV5UEdBCPpZ4Yosr7BKLnD
         r2RODas+JElVBhut7QLCPJnwqF1Ah0qPTEbcJkaQ6lhI4ZUqXvn2tS8F5TC71NVcqLxs
         VedjGDHyXv29KU+5SpyFBGfLc8f+U1C2cgU10vphK5Cm4DjumJNB6piM9WQyFiNyXdfy
         Fdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790373204; x=1790978004;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dVV1KtWyTLSLHpIl6BWB4AgM90d4cWInAt7fjY5duR4=;
        b=hAbok4FDGEEP4k70SsxP0EVfaKC73F3ELDFk4NaA6E4n63vdQsCYf7zgMoj5kJ5qgd
         /MGJkHbpfUR5UXglUE1I9VySOWK7ORSh0q/Pr5fu/uFCWXXL5JJyHFg3r6wji2xraIRW
         Pcr1GVsNn2OYUtOIQsol1p98sXQRWLazXlA6+wgtlKuiIDOtfmAe6HafVaNeLkbBXbiy
         T2NO5mpQoh+ded0O7r52X2VUuaqgvh/v8Abg4KctxRhtklxwDLqoFAOiuetSeebpPuta
         GiXdQAM/QhLNUbzSnY/QvuX1/MMVFpcksy2T9NKZPiDRy1t/4lWIkS3/5P3G7stbXPgB
         ZOTA==
X-Forwarded-Encrypted: i=1; AKwUvByYHqf39fG7dQ7URW9ISLmt3pociaIHlvZVM4lGtKWBGe2fdJDLi0EALUViawdRyypCoKZkJGWWYeFi5JQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mATi9LbbROHIqyEAZmvOSxbRdE7VmrdfFWSzV16FWCegGfX293
	AudJXsH//eV9BVUsPdbBBwoApAzXDzS3zxHPLb73qDa2pvcjuH7+iPrzxIhVu/1PQE+mm/VBdkd
	/ML/26/2Sx/zAAfEPWYUEORf4ifz5zUcW16hsIVvg
X-Gm-Gg: AYBFou2qXxWlLMhtMS7gtJ3/i/nW9QH9oud3Gpkd2DnLk3s/DQnerpuDKIFNsU8pDBl
	yQhXd83NfkWZ8SkmclSXzckRasF4Hd8bvugcc3nU5o6EnLffAaRumjU/p1zT/WtcShfSE8Z8S+a
	m3JPmQvAgQdm7MrGgzyblfDfZ3BZsZNsAuhe6ujCVErGvzYDdVrLPhYWNzbew/9YrSb9cb+KCN+
	cMricemNEt8MlPOCi4qXJ0KOOlaz+0NneqEGIMNILCraNdx5orD5HQOzM6paEvFJcnt+qgoVPBf
	UMo/P93jUJw4nK5aqfKFV/hSDU3zA5WqhUyO4CPnxX52FKH3w5P2RH2Vxt+hlJjggQOBA97oaYf
	hMFHKuahzLOGFoazbA53GMuk8eKTDXBWIQJbvQ//v9Bm4EZXwb925KJMAlKrhNYsl0JL42w==
X-Received: by 2002:a5d:59c9:0:b0:488:8232:d16e with SMTP id
 ffacd0b85a97d-4888232d398mr4215448f8f.45.1790373203169; Fri, 25 Sep 2026
 14:53:23 -0700 (PDT)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
In-Reply-To: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 25 Sep 2026 14:53:11 -0700
X-Gm-Features: AclHuK_Ft21uXDV_iMRtDzCCVqU8DQdapOlwM8X7gfzinGS8ws8kiw9mFw7TZZY
Message-ID: <CAKwvOdmuvn0LZkYEsH84hnOGTYhTtzuWs3wMARtWdTeL6dD9sA@mail.gmail.com>
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 2:46=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> After a recent change in LLVM [1], builds with the random vDSO
> implementation, such as PowerPC and RISC-V, fail when checking the vDSO:
>
>   arch/powerpc/kernel/vdso/vdso32.so.dbg: dynamic relocations are not sup=
ported
>   arch/riscv/kernel/vdso/vdso.so.dbg: dynamic relocations are not support=
ed
>
> memset() is now generated when zeroing params->reserved for some builds
> because LLVM has an optimization (now run in more instances) that can
> recognize at compile time when it is assigning a static value to a
> contiguous area of memory and turn that into a call to memset(). Both
> clang and GCC assume memset() is always available [2].
>
> clang provides a builtin, __builtin_memset_inline [3][4], that can be
> used to ensure an external function call is not generated when zeroing
> this memory. Use it when it is available.
>
> While GCC has no issues with the current code, it has generated memset()
> before, as seen in commit b7bad082e113 ("random: vDSO: avoid call to out
> of line memset()"). GCC 14 provides '-finline-stringops=3Dmemset' [5][6]
> with a similar guarantee to the clang builtin, so use it and
> __builtin_memset() when available.
>
> If no option is available, provide a simple memset_inline() like the one
> from lib/string.c to avoid adding an ugly ifdef.
>
> Link: https://github.com/llvm/llvm-project/commit/90cebef1411617fc3eedd35=
9bdf00cb44b1c2439 [1]
> Link: https://gcc.gnu.org/onlinedocs/gcc-16.2.0/gcc/Standards.html#index-=
ffreestanding [2]
> Link: https://github.com/llvm/llvm-project/commit/38637ee477541370a90b37f=
149069d8e5c0c2efd [3]
> Link: https://clang.llvm.org/docs/LanguageExtensions.html#guaranteed-inli=
ned-memset [4]
> Link: https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3D1ff6d9f7428b066=
8cd8ab0b3e3ab94f1d733124d [5]
> Link: https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html#index-finl=
ine-stringops [6]
> Suggested-by: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Changes in v2:
> - Switch approach entirely (Jason, Nick)
>   - clang: use __builtin_memset_inline() to avoid external call
>   - GCC 14+: use __builtin_memset + -finline-stringops=3Dmemset (hence th=
e
>     massive CC list increase)
>   - GCC < 14: no issues currently but avoid ifdef with simple memset
>     implementation
> - Link to v1: https://patch.msgid.link/20260916-vdso-getrandom-avoid-mems=
et-llvm-24-v1-1-80a92f2e225a@kernel.org
> ---
>  arch/arm64/kernel/vdso/Makefile     |  2 +-
>  arch/loongarch/vdso/Makefile        |  1 +
>  arch/powerpc/kernel/vdso/Makefile   |  1 +
>  arch/riscv/kernel/vdso/Makefile     |  1 +
>  arch/s390/kernel/vdso/Makefile      |  1 +
>  arch/x86/entry/vdso/vdso64/Makefile |  2 +-
>  init/Kconfig                        |  7 +++++++
>  lib/vdso/getrandom.c                | 19 +++++++++++++++++--
>  8 files changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Mak=
efile
> index 7dec05dd33b7..f6619e1cb2ce 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -41,7 +41,7 @@ CC_FLAGS_REMOVE_VDSO :=3D $(CC_FLAGS_FTRACE) -Os $(CC_F=
LAGS_SCS) \
>                         $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
>                         -Wmissing-prototypes -Wmissing-declarations
>
> -CC_FLAGS_ADD_VDSO :=3D -O2 -mcmodel=3Dtiny -fasynchronous-unwind-tables
> +CC_FLAGS_ADD_VDSO :=3D -O2 -mcmodel=3Dtiny -fasynchronous-unwind-tables =
$(CONFIG_CC_OPT_INLINE_MEMSET)
>
>  CFLAGS_REMOVE_vgettimeofday.o =3D $(CC_FLAGS_REMOVE_VDSO)
>  CFLAGS_REMOVE_vgetrandom.o =3D $(CC_FLAGS_REMOVE_VDSO)
> diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
> index 9c9181bb4071..0b84892d084b 100644
> --- a/arch/loongarch/vdso/Makefile
> +++ b/arch/loongarch/vdso/Makefile
> @@ -16,6 +16,7 @@ ccflags-vdso :=3D \
>         $(filter -m64,$(KBUILD_CFLAGS)) \
>         $(filter -march=3D%,$(KBUILD_CFLAGS)) \
>         $(filter -m%-float,$(KBUILD_CFLAGS)) \
> +       $(CONFIG_CC_OPT_INLINE_MEMSET) \
>         $(CLANG_FLAGS) \
>         -D__VDSO__
>
> diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso=
/Makefile
> index 368759f81708..0d1a49529885 100644
> --- a/arch/powerpc/kernel/vdso/Makefile
> +++ b/arch/powerpc/kernel/vdso/Makefile
> @@ -43,6 +43,7 @@ ccflags-y :=3D -fno-common -fno-builtin -DBUILD_VDSO
>  ccflags-y +=3D $(DISABLE_LATENT_ENTROPY_PLUGIN)
>  ccflags-y +=3D $(call cc-option, -fno-stack-protector)
>  ccflags-y +=3D -DDISABLE_BRANCH_PROFILING
> +ccflags-y +=3D $(CONFIG_CC_OPT_INLINE_MEMSET)
>  ccflags-y +=3D -ffreestanding -fasynchronous-unwind-tables
>  ccflags-remove-y :=3D $(CC_FLAGS_FTRACE)
>  ldflags-y :=3D -Wl,--hash-style=3Dboth -nostdlib -shared -z noexecstack =
$(CLANG_FLAGS)
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Mak=
efile
> index 8dbf2532a573..c023046a3fd7 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -36,6 +36,7 @@ endif
>  ccflags-y :=3D -fno-stack-protector
>  ccflags-y +=3D -DDISABLE_BRANCH_PROFILING
>  ccflags-y +=3D -fno-builtin
> +ccflags-y +=3D $(CONFIG_CC_OPT_INLINE_MEMSET)
>  ccflags-y +=3D $(KBUILD_BASE_ISA)$(CFI_MARCH)
>  ccflags-y +=3D $(CFI_FULL)
>  asflags-y +=3D $(KBUILD_BASE_ISA)$(CFI_MARCH)
> diff --git a/arch/s390/kernel/vdso/Makefile b/arch/s390/kernel/vdso/Makef=
ile
> index 35c834b895ec..54bcf2984ca1 100644
> --- a/arch/s390/kernel/vdso/Makefile
> +++ b/arch/s390/kernel/vdso/Makefile
> @@ -29,6 +29,7 @@ KBUILD_CFLAGS_VDSO :=3D $(filter-out -munaligned-symbol=
s,$(KBUILD_CFLAGS_VDSO))
>  KBUILD_CFLAGS_VDSO :=3D $(filter-out -fno-asynchronous-unwind-tables,$(K=
BUILD_CFLAGS_VDSO))
>  KBUILD_CFLAGS_VDSO +=3D -fPIC -fno-common -fno-builtin -fasynchronous-un=
wind-tables
>  KBUILD_CFLAGS_VDSO +=3D -fno-stack-protector $(DISABLE_KSTACK_ERASE)
> +KBUILD_CFLAGS_VDSO +=3D $(CONFIG_CC_OPT_INLINE_MEMSET)
>  ldflags-y :=3D -shared -soname=3Dlinux-vdso.so.1 \
>              --hash-style=3Dboth --build-id=3Dsha1 \
>              $(call ld-option, --eh-frame-hdr) -T
> diff --git a/arch/x86/entry/vdso/vdso64/Makefile b/arch/x86/entry/vdso/vd=
so64/Makefile
> index 7c0790065b5e..c2353a065279 100644
> --- a/arch/x86/entry/vdso/vdso64/Makefile
> +++ b/arch/x86/entry/vdso/vdso64/Makefile
> @@ -14,7 +14,7 @@ vobjs-$(CONFIG_X86_SGX)                       +=3D vsgx=
.o
>  vobjs-$(CONFIG_FUTEX_ROBUST_UNLOCK)    +=3D vfutex.o
>
>  # Compilation flags
> -flags-y                                :=3D -DBUILD_VDSO64 -m64 -mcmodel=
=3Dsmall
> +flags-y                                :=3D -DBUILD_VDSO64 -m64 -mcmodel=
=3Dsmall $(CONFIG_CC_OPT_INLINE_MEMSET)
>
>  # The location of this include matters!
>  include $(src)/../common/Makefile.include
> diff --git a/init/Kconfig b/init/Kconfig
> index 8583d9f06c52..ff3f8475dd2f 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -173,6 +173,13 @@ config CC_HAS_ALLOC_TOKEN
>  config CC_HAS_MULTIDIMENSIONAL_NONSTRING
>         def_bool $(success,echo 'char tag[][4] __attribute__((__nonstring=
__)) =3D { };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
>
> +config CC_HAS_OPT_INLINE_MEMSET
> +       def_bool $(cc-option,-finline-stringops=3Dmemset)
> +
> +config CC_OPT_INLINE_MEMSET
> +       string
> +       default "-finline-stringops=3Dmemset" if CC_HAS_OPT_INLINE_MEMSET
> +
>  config LD_CAN_USE_KEEP_IN_OVERLAY
>         # ld.lld prior to 21.0.0 did not support KEEP within an overlay d=
escription
>         # https://github.com/llvm/llvm-project/pull/130661
> diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
> index 2851afa9154f..f5cad5641985 100644
> --- a/lib/vdso/getrandom.c
> +++ b/lib/vdso/getrandom.c
> @@ -29,6 +29,22 @@
>         }                                                                =
       \
>  } while (0)
>
> +#if __has_builtin(__builtin_memset_inline)
> +#define memset_inline(dst, value, size) __builtin_memset_inline(dst, val=
ue, size)
> +#elif IS_ENABLED(CONFIG_CC_HAS_OPT_INLINE_MEMSET)
> +#define memset_inline(dst, value, size) __builtin_memset(dst, value, siz=
e)
> +#else
> +static inline void *memset_inline(void *dst, int value, size_t size)
> +{
> +       char *d =3D dst;
> +
> +       while (size--)
> +               *d++ =3D value;
> +
> +       return d;
> +}
> +#endif

Does this work?
https://godbolt.org/z/Tx6EaGMfb

(Sorry, I _should_ have replied to Jason on V1. I'm not ignoring him,
just way behind on my code reviews. Sorry!)

> +
>  static void memcpy_and_zero_src(void *dst, void *src, size_t len)
>  {
>         if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
> @@ -83,8 +99,7 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_=
info, void *buffer, size_
>                 params->size_of_opaque_state =3D sizeof(*state);
>                 params->mmap_prot =3D PROT_READ | PROT_WRITE;
>                 params->mmap_flags =3D MAP_DROPPABLE | MAP_ANONYMOUS;
> -               for (size_t i =3D 0; i < ARRAY_SIZE(params->reserved); ++=
i)
> -                       params->reserved[i] =3D 0;
> +               memset_inline(params->reserved, 0, sizeof(params->reserve=
d));
>                 return 0;
>         }
>
>
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260916-vdso-getrandom-avoid-memset-llvm-24-74d45fa6031e
>
> Best regards,
> --
> Cheers,
> Nathan
>


--=20
Thanks,
~Nick Desaulniers

