Return-Path: <linuxppc-dev+bounces-28251-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F197C9832A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 21:57:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hs4L76xTsz2yQl;
	Sat, 26 Sep 2026 07:57:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:30::10" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790373423;
	cv=pass; b=ix0vdfoO1g5IgKo/O1R7ynkRacNAJtyJP33rd4mjeO8L4L4OYkbCZE/qPFu6D3hHPj9ihIgQbRjD2S5SFffOFsl70DOEe/PbnfY4PeMjdVlpZrzf+IkWzGl24ik6UZF5FbSlOiteSQ/WBn8UCDE+2dFy4FXrn9xdsh3InAiLxStMFujXPRf1Dh8QY7+CdA8SByQK5BZSWdTxv8oNq/1osehB1YUiwr9ll2j6eZ/A4y8jhoI1WKiVNVTq6tn3Tj+phwh5uRbFmLZ05ChjcRqbdDSO/Y+vG8CLnFTRSjEzwc0mDxIfq+4+hyOOIGezcpZH/z2jlAiG/SNRutuz2pqeYQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790373423; c=relaxed/relaxed;
	bh=G6NlhQyLBvAL6TKdL1Aq5LRNoXywD8yKGimzHFh9xgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ox5aiuiNXMthn2rkLE1vkdF5l6asWb8Sfen0LKMD7Bl9F1PbNFWG5A+WV6x6j3hnw5gJHgnU/t5+W5tb+MYNX1gx4PGByamnzINo2G7/JJid0YeMutpLuin0eZsJM87lfY5XnPPEPeJDQi2UeXeRiTvb1waZFzI6oLdoQ6EYiLtGRL4xxgZrto8bKfIKHzJlYAOs0DqpHjD9n3nW3WBRWxFH27Gk/VOah02rVgCkI4ZFvE2NuchC3h5EJ2H2DQnF19QWaEgJ51lbpk7jXjn3gvLnFEC8rPvZheQXNR86V0Lsd1qzH0ACQvYeoBrrX2AcuXSKVGhVxDgvj9IuFC/W/A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ehS6jdDY; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com; envelope-from=ndesaulniers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ehS6jdDY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com; envelope-from=ndesaulniers@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com [IPv6:2a00:1450:4864:30::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hs4L63cJRz2yMm
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 07:57:02 +1000 (AEST)
Received: by mail-wr2-x10.google.com with SMTP id ffacd0b85a97d-4843f22dcb8so1042918f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 14:57:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790373418; cv=none;
        d=google.com; s=arc-20260327;
        b=nf6vbDsLAJPJ4lqijnk5YqYeOdmpvm95YwW9Zg0N4s2pOB7hOzHngOX1JWJk5/V2mO
         cwlY4B9f9a9AbDim5TfM/EkU8SHUS1OEJ4ElEnb3JOqtXSOm4QOAINQ06i9zqK2AtDpo
         jD0epCa7O6KZMmHY5YM2qqD01f9Wz8YpkJIu6+2kstJ2vvxyen2Fn/R6BKGoqiGlkDKn
         1HTbnpwdAMjXif7u3pc8OatKeEH88U0KRIzkvUQ6gRdZD4HPBfWn/hEkKVOCXumsDY+6
         gpihDb5Kh1as1F97tn0uWe/HYAd+6djqxWQiTAY+QugYWQJphaAjNUgdKzhayqlciakO
         RZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G6NlhQyLBvAL6TKdL1Aq5LRNoXywD8yKGimzHFh9xgc=;
        fh=uLlgTd+EPtoiBhsREozY4PU95BybNC9esYMtUX5AELI=;
        b=mBd1vZKkdUYpeAEFFxPyzeAdaTG8urYMFPo49jd+Cc9peZfY+ylr57pghhOBUUe0Mp
         ozAkuSrPmPk6YzRbssjq7jzbCT/AYsXfXtKiVTTcPpi7Bun0FvMmRIl5LuIOtsjBbRqd
         jrUY4gtzBkfIEQWHAQxhhg04LZ7iGP8qeXm4+ijfyuX2nvXuYnAEKFuVXtXrlMf/JcBx
         sc8XX60tI6b73zQXxXdDIFfkUoyXng+ggLv/BaI8AMJX16nojojghV608BCNksIP6B3Y
         +1x97QsIOikmGMijFGJ+QYy/XkOlqWS6xlZz9OJfMSSmcm/6Pjr/r2blmQyBgFl2TmaI
         XfuA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790373418; x=1790978218; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G6NlhQyLBvAL6TKdL1Aq5LRNoXywD8yKGimzHFh9xgc=;
        b=ehS6jdDY5Twr00o/kvlYiZ3QM6Su6kxgsINZa49O65fQL4/dsOZhxIXWCr+fSs6xVb
         ZQTzgwhQdl2c6yi/UttwNN37vxCaqEO9ufUfzKKUEFOu53czdKL0vPbuUjIXjfCfD2JF
         +kGhTEcIMnwV2mtML1hF5KDoDsBoGVvwxerzMXOG2WCU8Xo4yk1ZTYBFXcDJ+GbG7ZaB
         dhFJEtOSbCot+CrHmXeHgBe7md/catACMUXbbvVrpwn5FqbPapXHxv3WUnE3aU9Xe30i
         wniTnuxB4pn+RSSqgov78/iJoIJpHx5+o31kAhF+fpncVnK27Whudk7ZtXc+vCoC2PIF
         IXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790373418; x=1790978218;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G6NlhQyLBvAL6TKdL1Aq5LRNoXywD8yKGimzHFh9xgc=;
        b=zghaE3AUrNI3AlBwTzRaJN65M7BMIXiRLg/h+pJ1GyE5Wa61WxJCRGO3UhWWc82smy
         VN9tE7SZHU3wBwaY/ZWaLEO3FXTCl0pe9eFV+Jm2J0797+EkapJC/i247/z/1BqAvGmA
         xSilh8jjJrOXAnGq3kNwx9FLcDv+jWiIqWO5Lw4ZVICGufje5/MqgdybPbr1gq3wFCmD
         vfcD/3wUz+Pnhgaa6Rjxix5rOrwV87u79m8qYEyopjVTaJg51X5Q5119PcvuOgc/DoCt
         aTQCyZUqdugF94XASI0jCCMj1yylNvhounUNxq6t265bYrgcpKX5HuZmJx8rchpIQYOF
         K1cQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6P0LJjvIA6Y0L9YrhtND2bBkjqG2xvyGIJ7ygYBAyiT66QlI8MOBjLcL24Vj1RsmA2e6d0jo+p4itx2I=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mEGCRrk6FpTTXqMharahfo5uR7pk/mmVhBdgNglVmPznHUZkeS
	0WFELueB8AMgSrZdyN+zQkkhWADWfNed+ZzO7aHo4WoOKh2QlnWaIL9l5Jo+NoeFIa2J+IJBUfe
	WmDJ3J+T+EpuEQDs3SEglbNJJ4N56PZBpAnfeXW12
X-Gm-Gg: AYBFou0yAAzs4a7nWifzqYDaHMAXsB4bJ3zDv8OeWYQ6ZX07Vs2+1Z+doqdiFiD14Wl
	v3T4/sFOYcK/hoELIKMd8nRj7Egfw5rgtxYeLN+mFrl2ndlHWMH3AIvg5dkL+4fNS3qzS0VsZAe
	VrqmhF0K6CceS8qM5VMKxpxGc2Lmw/i4PLnrMM0aC45Cz3fPs0UG3kaIdB+sN3w0WU3Cq4Zq7GD
	fMZeNGQfoP93DNLCL/l9M/oc08P/H+9pGaw73MM+qqiBB5nvP5PjwNRjfpxPe4lHfo3KNTzkcYE
	7BzJlbOWMQRtnniqsYee4dX4Lqzfv07aNywWRAh/Wq2ar1SZBdw8xdRx45CLcE6CFyEmZMSVVq2
	MSh6OxA4WjVMZYU0G8WcIIeTl2S9Ho/veJbkaSF/j74upC1mydZGR7V8bTguEZu2UryQsDKNQyk
	YIUaO6
X-Received: by 2002:a05:6000:288b:b0:485:1bcc:67f8 with SMTP id
 ffacd0b85a97d-4887171d8demr12695578f8f.13.1790373417936; Fri, 25 Sep 2026
 14:56:57 -0700 (PDT)
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
 <CAKwvOdmuvn0LZkYEsH84hnOGTYhTtzuWs3wMARtWdTeL6dD9sA@mail.gmail.com>
In-Reply-To: <CAKwvOdmuvn0LZkYEsH84hnOGTYhTtzuWs3wMARtWdTeL6dD9sA@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 25 Sep 2026 14:56:46 -0700
X-Gm-Features: AclHuK8SDWvgFgIHW9y7_70sxeUurbOgosEQfmvpDPf9DmnqXM-fPyBkhdpsidg
Message-ID: <CAKwvOdnxKVpn=nAFaqP+9PTx4PqgHsUVWv6e60Pcr29W_eZrpQ@mail.gmail.com>
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

On Fri, Sep 25, 2026 at 2:53=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Sep 25, 2026 at 2:46=E2=80=AFPM Nathan Chancellor <nathan@kernel.=
org> wrote:
> >
> > After a recent change in LLVM [1], builds with the random vDSO
> > implementation, such as PowerPC and RISC-V, fail when checking the vDSO=
:
> >
> >   arch/powerpc/kernel/vdso/vdso32.so.dbg: dynamic relocations are not s=
upported
> >   arch/riscv/kernel/vdso/vdso.so.dbg: dynamic relocations are not suppo=
rted
> >
> > memset() is now generated when zeroing params->reserved for some builds
> > because LLVM has an optimization (now run in more instances) that can
> > recognize at compile time when it is assigning a static value to a
> > contiguous area of memory and turn that into a call to memset(). Both
> > clang and GCC assume memset() is always available [2].
> >
> > clang provides a builtin, __builtin_memset_inline [3][4], that can be
> > used to ensure an external function call is not generated when zeroing
> > this memory. Use it when it is available.
> >
> > While GCC has no issues with the current code, it has generated memset(=
)
> > before, as seen in commit b7bad082e113 ("random: vDSO: avoid call to ou=
t
> > of line memset()"). GCC 14 provides '-finline-stringops=3Dmemset' [5][6=
]
> > with a similar guarantee to the clang builtin, so use it and
> > __builtin_memset() when available.
> >
> > If no option is available, provide a simple memset_inline() like the on=
e
> > from lib/string.c to avoid adding an ugly ifdef.
> >
> > Link: https://github.com/llvm/llvm-project/commit/90cebef1411617fc3eedd=
359bdf00cb44b1c2439 [1]
> > Link: https://gcc.gnu.org/onlinedocs/gcc-16.2.0/gcc/Standards.html#inde=
x-ffreestanding [2]
> > Link: https://github.com/llvm/llvm-project/commit/38637ee477541370a90b3=
7f149069d8e5c0c2efd [3]
> > Link: https://clang.llvm.org/docs/LanguageExtensions.html#guaranteed-in=
lined-memset [4]
> > Link: https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3D1ff6d9f7428b0=
668cd8ab0b3e3ab94f1d733124d [5]
> > Link: https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html#index-fi=
nline-stringops [6]
> > Suggested-by: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> > Changes in v2:
> > - Switch approach entirely (Jason, Nick)
> >   - clang: use __builtin_memset_inline() to avoid external call
> >   - GCC 14+: use __builtin_memset + -finline-stringops=3Dmemset (hence =
the
> >     massive CC list increase)
> >   - GCC < 14: no issues currently but avoid ifdef with simple memset
> >     implementation
> > - Link to v1: https://patch.msgid.link/20260916-vdso-getrandom-avoid-me=
mset-llvm-24-v1-1-80a92f2e225a@kernel.org
> > ---
> >  arch/arm64/kernel/vdso/Makefile     |  2 +-
> >  arch/loongarch/vdso/Makefile        |  1 +
> >  arch/powerpc/kernel/vdso/Makefile   |  1 +
> >  arch/riscv/kernel/vdso/Makefile     |  1 +
> >  arch/s390/kernel/vdso/Makefile      |  1 +
> >  arch/x86/entry/vdso/vdso64/Makefile |  2 +-
> >  init/Kconfig                        |  7 +++++++
> >  lib/vdso/getrandom.c                | 19 +++++++++++++++++--
> >  8 files changed, 30 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/M=
akefile
> > index 7dec05dd33b7..f6619e1cb2ce 100644
> > --- a/arch/arm64/kernel/vdso/Makefile
> > +++ b/arch/arm64/kernel/vdso/Makefile
> > @@ -41,7 +41,7 @@ CC_FLAGS_REMOVE_VDSO :=3D $(CC_FLAGS_FTRACE) -Os $(CC=
_FLAGS_SCS) \
> >                         $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
> >                         -Wmissing-prototypes -Wmissing-declarations
> >
> > -CC_FLAGS_ADD_VDSO :=3D -O2 -mcmodel=3Dtiny -fasynchronous-unwind-table=
s
> > +CC_FLAGS_ADD_VDSO :=3D -O2 -mcmodel=3Dtiny -fasynchronous-unwind-table=
s $(CONFIG_CC_OPT_INLINE_MEMSET)
> >
> >  CFLAGS_REMOVE_vgettimeofday.o =3D $(CC_FLAGS_REMOVE_VDSO)
> >  CFLAGS_REMOVE_vgetrandom.o =3D $(CC_FLAGS_REMOVE_VDSO)
> > diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefil=
e
> > index 9c9181bb4071..0b84892d084b 100644
> > --- a/arch/loongarch/vdso/Makefile
> > +++ b/arch/loongarch/vdso/Makefile
> > @@ -16,6 +16,7 @@ ccflags-vdso :=3D \
> >         $(filter -m64,$(KBUILD_CFLAGS)) \
> >         $(filter -march=3D%,$(KBUILD_CFLAGS)) \
> >         $(filter -m%-float,$(KBUILD_CFLAGS)) \
> > +       $(CONFIG_CC_OPT_INLINE_MEMSET) \
> >         $(CLANG_FLAGS) \
> >         -D__VDSO__
> >
> > diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vd=
so/Makefile
> > index 368759f81708..0d1a49529885 100644
> > --- a/arch/powerpc/kernel/vdso/Makefile
> > +++ b/arch/powerpc/kernel/vdso/Makefile
> > @@ -43,6 +43,7 @@ ccflags-y :=3D -fno-common -fno-builtin -DBUILD_VDSO
> >  ccflags-y +=3D $(DISABLE_LATENT_ENTROPY_PLUGIN)
> >  ccflags-y +=3D $(call cc-option, -fno-stack-protector)
> >  ccflags-y +=3D -DDISABLE_BRANCH_PROFILING
> > +ccflags-y +=3D $(CONFIG_CC_OPT_INLINE_MEMSET)
> >  ccflags-y +=3D -ffreestanding -fasynchronous-unwind-tables
> >  ccflags-remove-y :=3D $(CC_FLAGS_FTRACE)
> >  ldflags-y :=3D -Wl,--hash-style=3Dboth -nostdlib -shared -z noexecstac=
k $(CLANG_FLAGS)
> > diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/M=
akefile
> > index 8dbf2532a573..c023046a3fd7 100644
> > --- a/arch/riscv/kernel/vdso/Makefile
> > +++ b/arch/riscv/kernel/vdso/Makefile
> > @@ -36,6 +36,7 @@ endif
> >  ccflags-y :=3D -fno-stack-protector
> >  ccflags-y +=3D -DDISABLE_BRANCH_PROFILING
> >  ccflags-y +=3D -fno-builtin
> > +ccflags-y +=3D $(CONFIG_CC_OPT_INLINE_MEMSET)
> >  ccflags-y +=3D $(KBUILD_BASE_ISA)$(CFI_MARCH)
> >  ccflags-y +=3D $(CFI_FULL)
> >  asflags-y +=3D $(KBUILD_BASE_ISA)$(CFI_MARCH)
> > diff --git a/arch/s390/kernel/vdso/Makefile b/arch/s390/kernel/vdso/Mak=
efile
> > index 35c834b895ec..54bcf2984ca1 100644
> > --- a/arch/s390/kernel/vdso/Makefile
> > +++ b/arch/s390/kernel/vdso/Makefile
> > @@ -29,6 +29,7 @@ KBUILD_CFLAGS_VDSO :=3D $(filter-out -munaligned-symb=
ols,$(KBUILD_CFLAGS_VDSO))
> >  KBUILD_CFLAGS_VDSO :=3D $(filter-out -fno-asynchronous-unwind-tables,$=
(KBUILD_CFLAGS_VDSO))
> >  KBUILD_CFLAGS_VDSO +=3D -fPIC -fno-common -fno-builtin -fasynchronous-=
unwind-tables
> >  KBUILD_CFLAGS_VDSO +=3D -fno-stack-protector $(DISABLE_KSTACK_ERASE)
> > +KBUILD_CFLAGS_VDSO +=3D $(CONFIG_CC_OPT_INLINE_MEMSET)
> >  ldflags-y :=3D -shared -soname=3Dlinux-vdso.so.1 \
> >              --hash-style=3Dboth --build-id=3Dsha1 \
> >              $(call ld-option, --eh-frame-hdr) -T
> > diff --git a/arch/x86/entry/vdso/vdso64/Makefile b/arch/x86/entry/vdso/=
vdso64/Makefile
> > index 7c0790065b5e..c2353a065279 100644
> > --- a/arch/x86/entry/vdso/vdso64/Makefile
> > +++ b/arch/x86/entry/vdso/vdso64/Makefile
> > @@ -14,7 +14,7 @@ vobjs-$(CONFIG_X86_SGX)                       +=3D vs=
gx.o
> >  vobjs-$(CONFIG_FUTEX_ROBUST_UNLOCK)    +=3D vfutex.o
> >
> >  # Compilation flags
> > -flags-y                                :=3D -DBUILD_VDSO64 -m64 -mcmod=
el=3Dsmall
> > +flags-y                                :=3D -DBUILD_VDSO64 -m64 -mcmod=
el=3Dsmall $(CONFIG_CC_OPT_INLINE_MEMSET)
> >
> >  # The location of this include matters!
> >  include $(src)/../common/Makefile.include
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 8583d9f06c52..ff3f8475dd2f 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -173,6 +173,13 @@ config CC_HAS_ALLOC_TOKEN
> >  config CC_HAS_MULTIDIMENSIONAL_NONSTRING
> >         def_bool $(success,echo 'char tag[][4] __attribute__((__nonstri=
ng__)) =3D { };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
> >
> > +config CC_HAS_OPT_INLINE_MEMSET
> > +       def_bool $(cc-option,-finline-stringops=3Dmemset)
> > +
> > +config CC_OPT_INLINE_MEMSET
> > +       string
> > +       default "-finline-stringops=3Dmemset" if CC_HAS_OPT_INLINE_MEMS=
ET
> > +
> >  config LD_CAN_USE_KEEP_IN_OVERLAY
> >         # ld.lld prior to 21.0.0 did not support KEEP within an overlay=
 description
> >         # https://github.com/llvm/llvm-project/pull/130661
> > diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
> > index 2851afa9154f..f5cad5641985 100644
> > --- a/lib/vdso/getrandom.c
> > +++ b/lib/vdso/getrandom.c
> > @@ -29,6 +29,22 @@
> >         }                                                              =
         \
> >  } while (0)
> >
> > +#if __has_builtin(__builtin_memset_inline)
> > +#define memset_inline(dst, value, size) __builtin_memset_inline(dst, v=
alue, size)
> > +#elif IS_ENABLED(CONFIG_CC_HAS_OPT_INLINE_MEMSET)
> > +#define memset_inline(dst, value, size) __builtin_memset(dst, value, s=
ize)
> > +#else
> > +static inline void *memset_inline(void *dst, int value, size_t size)
> > +{
> > +       char *d =3D dst;
> > +
> > +       while (size--)
> > +               *d++ =3D value;
> > +
> > +       return d;
> > +}
> > +#endif
>
> Does this work?
> https://godbolt.org/z/Tx6EaGMfb

Hmmm...possibly.
https://godbolt.org/z/ec9rzd9Yf
I don't get it...

>
> (Sorry, I _should_ have replied to Jason on V1. I'm not ignoring him,
> just way behind on my code reviews. Sorry!)
>
> > +
> >  static void memcpy_and_zero_src(void *dst, void *src, size_t len)
> >  {
> >         if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
> > @@ -83,8 +99,7 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rn=
g_info, void *buffer, size_
> >                 params->size_of_opaque_state =3D sizeof(*state);
> >                 params->mmap_prot =3D PROT_READ | PROT_WRITE;
> >                 params->mmap_flags =3D MAP_DROPPABLE | MAP_ANONYMOUS;
> > -               for (size_t i =3D 0; i < ARRAY_SIZE(params->reserved); =
++i)
> > -                       params->reserved[i] =3D 0;
> > +               memset_inline(params->reserved, 0, sizeof(params->reser=
ved));
> >                 return 0;
> >         }
> >
> >
> > ---
> > base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> > change-id: 20260916-vdso-getrandom-avoid-memset-llvm-24-74d45fa6031e
> >
> > Best regards,
> > --
> > Cheers,
> > Nathan
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers

