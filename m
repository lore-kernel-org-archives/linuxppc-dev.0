Return-Path: <linuxppc-dev+bounces-28252-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DC4C9830E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 22:01:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hs4Qm0ktdz2yD8;
	Sat, 26 Sep 2026 08:01:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:30::10" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790373664;
	cv=pass; b=O/zac7wiTO1kdWNkEBQbEmU9EZ3vkbSM3T6/UBjFe94vws9H69x3F8eXPU1EAqic5MgMrUubcJdMTQe7lWBaOfSsQBjQAM3kLtZ3hIk7IXGDCuNZATMi7fN41E0wwS4e7cjzSjmBJ7KQGnCMbz5wiT0eU0YpRnwhGV3wPgKcgKl+YyXgTV7VqGcXZFQAcP8UcQWTxbqVRkQ3a+EKi3Pq9q4/u4TTE1RE5Jn3bZxfJhl1np0GgBW+gmnrnM9ZxHglw8sLICX8qmrMsZUhGXBRa40UjjQA4QnJH66hQ5s/HviH96IzcE1Ne2yDtEU+4BjeG+P0i1eQKq/pF746Yr2jTw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790373664; c=relaxed/relaxed;
	bh=QlMEQu1qsaTBww97rVbchh8pOSM1CexDa8zo36TMiIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnH3eBO3GsuhsWG8SFHyaQisTkzeadEycBaIFJC1ZR71y4pDqAUgnW80I9+Az7vH2fLRDaW8vJcsS/7rrAQ/GFJDeG+O/kOKoIpJozz4Le0ejXw0+bDHRs6WszJJBULJIRzXl9MF62o1k2SFgczo0V+/AqZOJjxtzC5wSnRqw41LI/1rZOxITZUqQju+mohNlj+eEDLdsaGZHL5wni8/ZI7DKeE51XcaFoepFLk8gedRa0FJTZidyvhVSUPWsI4uGTfc0/s2MTf4JdijX33kdmlzHu6QSTXmbNLWJANtwwB34fZ4SHYdAZv4SGAiaENdpiojnlTL84ionIq+zu8yVg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tJcNa5X1; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com; envelope-from=ndesaulniers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tJcNa5X1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com; envelope-from=ndesaulniers@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com [IPv6:2a00:1450:4864:30::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hs4Qk3WSWz2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 08:01:02 +1000 (AEST)
Received: by mail-wr2-x10.google.com with SMTP id ffacd0b85a97d-4834977ae75so791032f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 15:01:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790373659; cv=none;
        d=google.com; s=arc-20260327;
        b=aIe1SsFXmi2R2cdQ60GiMgdsVczegPdiHD8SC4RqsTYE43Ao55NW5twbUTPwvc8LTg
         ZVpKq/n+ypLegQJ3h6PSHRWaAR/GFSD7RQQsDUvcfyHx0RE80EP4GUufVeMPj/eHVEQ2
         ttJf3uEllW4sZQ34I53bN3vlpq9wlA6VHWirTS8UUi8hdSbJrM5qO8O/PbDH00/r8sZD
         2mKEBkHofuwmEalM7B+MTy2Zd+zKowybARt9exjBJzimUsAkCWFJqoYM8qAfSyIGmou3
         RRkH3lmncEsw2cYHjBJVq9f60/D9f5M0pNmZ4WG1wnsiQ1n2WrzalXSveTgfdYzg14Au
         Jkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QlMEQu1qsaTBww97rVbchh8pOSM1CexDa8zo36TMiIs=;
        fh=aXbts93duwRJ3HBeLbUmYMlcD606T7d6925Ozk7q/YA=;
        b=Gh0LX0GH5zPCMjxlxdHz6W9HulV1OxxTI7vLXGjLOVKEcOPblPFeQfuDbRfELcqRrI
         hj3SJ9xiewN+QAWT5ci1p1fKDoEcp5z9od8O/W8iaS1pj5I6kP5K36j01RkuE3oIYKYE
         7ykl+bDJR/Opej2xT/aFTKDIBN6sfeeKme97wAahko3zwWsYEW+jJzBNe3YMmy2+RsVH
         aRmfBw5o7PHlMHAx+iQmx19ezNSSiCjvij8gx9wMklq0yieyrhBxa9ckdjTxnr2cRoy9
         O0lUDINNWi9epyEColFd7ZU4hc9S9sfWV1ZTuYiWlf17Bo6ixcLVv/mR8ebf5fGwrpPF
         TG+g==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790373659; x=1790978459; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QlMEQu1qsaTBww97rVbchh8pOSM1CexDa8zo36TMiIs=;
        b=tJcNa5X1PhTHidf/MEqmym+F2At3KBY9f/MTmzq6/0KF/9H2rXI98LNDWaUi9jmeJg
         hwbKaq/40EAa9Yz2KHz0sCG+63lVG6ZjeZpAmA4nSo2SXGI6xv0FwNGz50Y8vBfKDfjP
         z9V6lKXBa2Pn3u5ylJiDLdGwRfZPoOU5lC+s0ANB+AlDZ5hTC6PnR5WdcEwqN5QDEbAU
         uQRzUV+lNog34kU6VoqpOt9zIBKnGYuoVLGE9WHCS9/aj4UQ/ItkJ9TGZmPSlOS+4vwm
         3atI/PK+CuYW3rb9TVJAxG8XrfvaIws1HGwSAUk/6F9ci8mJQW4PA43fxI3wDJneUnqT
         snEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790373659; x=1790978459;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QlMEQu1qsaTBww97rVbchh8pOSM1CexDa8zo36TMiIs=;
        b=Ocov3KIs9xHW+te/1CY9hzKb5QdB/vrfymQRyb0b1sorZYzJ7HNu8ZCs92BNv3uAKg
         64rwm4gan8kEP+KP0lioc9OqoxpEZhV0wMVPb0n3rd0x3e3waz/0qqZiG7UrXTVO9eOw
         2dHzJ9JZL7m8h9MVOnZeVi4UzLrOMEfAmYpCVXjHB26Vcxy3sx4lNnF8UO7vd/LS41/a
         vSDeMuHm3DnpwRCkpAzWUWCNMv9NxPk6pUAPevtAl9vHxTnGnsfdsJLopcLghOIMUkF3
         /zFCbd5/lkjLAlrBlB8ELEhJjnELaiEgdS8AufVfZKtF1EANWAY9yjQQaB4r5WtTw+pJ
         1MeA==
X-Forwarded-Encrypted: i=1; AKwUvByboA+JAoY+e0IF8h1H9hz4Z6HyqXKDXou3Mf+oxuzxQSXu4IamIyj9k/RBX6DOVbZselD/Cxj8DMjM+7o=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n/FeguRXa3Yo1XKcbKJM4XNPLEu4dXhZB9YWd1RKsFWEQ0EtP9
	00750k4Cb9q3ksAA5jJ9WItdq/MDODjsAX8YzMNUk9FOS4LGQe/FR1/KuN7qzQjLYm9rsuV0ycO
	8a6fWBD+cWbZsNb2pGvc8A+vinMtxZiGuKDA+8I6x
X-Gm-Gg: AYBFou16dK1Qz8BtA6UHbL9znk1+VwDehO6xQM7c51cNCqBAQZhzVR8CBVnqo2JB9LD
	5a1PpMciDE8zQOKhfqfUiFvrYej8sSdjHyX6mM6P+vMOgmyBCWhYHPO/5Ic9g0/ul8gmTj4f50O
	T0d3KoYEk6UEgVfjPu5stjFlLqDjRMA8UNZ9AVTFvxu9ZgFIH0odTDHDQiA144Q8i4TN2yzx1I3
	ZheywhgafQeDxmSjN6RoKoKGFkFoBk0iDQMIBXDT2Zrpfya5zMOGS+3KaTzvaoNFimdXISLgylO
	Yvc0PJCEhlOXMI/6aWmrhEPLlDAimmzkrZRg7az46BJBUi2nSJ8V8tOWtMYyfBekEFX591wM/zB
	rsSDuPKvvL6WMr9Buvy+P8G5AJ73Jyw2fl9pWGLL8oprXCaCnvNSEjigI/CHYVKgoV72IFw==
X-Received: by 2002:a05:6000:41f7:b0:487:27f6:a4d6 with SMTP id
 ffacd0b85a97d-488716b00eemr13403982f8f.38.1790373658191; Fri, 25 Sep 2026
 15:00:58 -0700 (PDT)
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
 <CAKwvOdmuvn0LZkYEsH84hnOGTYhTtzuWs3wMARtWdTeL6dD9sA@mail.gmail.com> <CAKwvOdnxKVpn=nAFaqP+9PTx4PqgHsUVWv6e60Pcr29W_eZrpQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnxKVpn=nAFaqP+9PTx4PqgHsUVWv6e60Pcr29W_eZrpQ@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 25 Sep 2026 15:00:46 -0700
X-Gm-Features: AclHuK_Ut9cdmWvtWXJ4TZyUvK9Gsy2XhR4mB0KeYmSzL3PaZLLknagb6ZhED0Y
Message-ID: <CAKwvOdmNZL3eFvV3v77GXDzL+XLgz+BT9TA=my0yTnbsHqVeSg@mail.gmail.com>
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

On Fri, Sep 25, 2026 at 2:56=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Sep 25, 2026 at 2:53=E2=80=AFPM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Fri, Sep 25, 2026 at 2:46=E2=80=AFPM Nathan Chancellor <nathan@kerne=
l.org> wrote:
> > >
> > > After a recent change in LLVM [1], builds with the random vDSO
> > > implementation, such as PowerPC and RISC-V, fail when checking the vD=
SO:
> > >
> > >   arch/powerpc/kernel/vdso/vdso32.so.dbg: dynamic relocations are not=
 supported
> > >   arch/riscv/kernel/vdso/vdso.so.dbg: dynamic relocations are not sup=
ported
> > >
> > > memset() is now generated when zeroing params->reserved for some buil=
ds
> > > because LLVM has an optimization (now run in more instances) that can
> > > recognize at compile time when it is assigning a static value to a
> > > contiguous area of memory and turn that into a call to memset(). Both
> > > clang and GCC assume memset() is always available [2].
> > >
> > > clang provides a builtin, __builtin_memset_inline [3][4], that can be
> > > used to ensure an external function call is not generated when zeroin=
g
> > > this memory. Use it when it is available.
> > >
> > > While GCC has no issues with the current code, it has generated memse=
t()
> > > before, as seen in commit b7bad082e113 ("random: vDSO: avoid call to =
out
> > > of line memset()"). GCC 14 provides '-finline-stringops=3Dmemset' [5]=
[6]
> > > with a similar guarantee to the clang builtin, so use it and
> > > __builtin_memset() when available.
> > >
> > > If no option is available, provide a simple memset_inline() like the =
one
> > > from lib/string.c to avoid adding an ugly ifdef.
> > >
> > > Link: https://github.com/llvm/llvm-project/commit/90cebef1411617fc3ee=
dd359bdf00cb44b1c2439 [1]
> > > Link: https://gcc.gnu.org/onlinedocs/gcc-16.2.0/gcc/Standards.html#in=
dex-ffreestanding [2]
> > > Link: https://github.com/llvm/llvm-project/commit/38637ee477541370a90=
b37f149069d8e5c0c2efd [3]
> > > Link: https://clang.llvm.org/docs/LanguageExtensions.html#guaranteed-=
inlined-memset [4]
> > > Link: https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3D1ff6d9f7428=
b0668cd8ab0b3e3ab94f1d733124d [5]
> > > Link: https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html#index-=
finline-stringops [6]
> > > Suggested-by: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > ---
> > > Changes in v2:
> > > - Switch approach entirely (Jason, Nick)
> > >   - clang: use __builtin_memset_inline() to avoid external call
> > >   - GCC 14+: use __builtin_memset + -finline-stringops=3Dmemset (henc=
e the
> > >     massive CC list increase)
> > >   - GCC < 14: no issues currently but avoid ifdef with simple memset
> > >     implementation
> > > - Link to v1: https://patch.msgid.link/20260916-vdso-getrandom-avoid-=
memset-llvm-24-v1-1-80a92f2e225a@kernel.org
> > > ---
> > >  arch/arm64/kernel/vdso/Makefile     |  2 +-
> > >  arch/loongarch/vdso/Makefile        |  1 +
> > >  arch/powerpc/kernel/vdso/Makefile   |  1 +
> > >  arch/riscv/kernel/vdso/Makefile     |  1 +
> > >  arch/s390/kernel/vdso/Makefile      |  1 +
> > >  arch/x86/entry/vdso/vdso64/Makefile |  2 +-
> > >  init/Kconfig                        |  7 +++++++
> > >  lib/vdso/getrandom.c                | 19 +++++++++++++++++--
> > >  8 files changed, 30 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso=
/Makefile
> > > index 7dec05dd33b7..f6619e1cb2ce 100644
> > > --- a/arch/arm64/kernel/vdso/Makefile
> > > +++ b/arch/arm64/kernel/vdso/Makefile
> > > @@ -41,7 +41,7 @@ CC_FLAGS_REMOVE_VDSO :=3D $(CC_FLAGS_FTRACE) -Os $(=
CC_FLAGS_SCS) \
> > >                         $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
> > >                         -Wmissing-prototypes -Wmissing-declarations
> > >
> > > -CC_FLAGS_ADD_VDSO :=3D -O2 -mcmodel=3Dtiny -fasynchronous-unwind-tab=
les
> > > +CC_FLAGS_ADD_VDSO :=3D -O2 -mcmodel=3Dtiny -fasynchronous-unwind-tab=
les $(CONFIG_CC_OPT_INLINE_MEMSET)
> > >
> > >  CFLAGS_REMOVE_vgettimeofday.o =3D $(CC_FLAGS_REMOVE_VDSO)
> > >  CFLAGS_REMOVE_vgetrandom.o =3D $(CC_FLAGS_REMOVE_VDSO)
> > > diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makef=
ile
> > > index 9c9181bb4071..0b84892d084b 100644
> > > --- a/arch/loongarch/vdso/Makefile
> > > +++ b/arch/loongarch/vdso/Makefile
> > > @@ -16,6 +16,7 @@ ccflags-vdso :=3D \
> > >         $(filter -m64,$(KBUILD_CFLAGS)) \
> > >         $(filter -march=3D%,$(KBUILD_CFLAGS)) \
> > >         $(filter -m%-float,$(KBUILD_CFLAGS)) \
> > > +       $(CONFIG_CC_OPT_INLINE_MEMSET) \
> > >         $(CLANG_FLAGS) \
> > >         -D__VDSO__
> > >
> > > diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/=
vdso/Makefile
> > > index 368759f81708..0d1a49529885 100644
> > > --- a/arch/powerpc/kernel/vdso/Makefile
> > > +++ b/arch/powerpc/kernel/vdso/Makefile
> > > @@ -43,6 +43,7 @@ ccflags-y :=3D -fno-common -fno-builtin -DBUILD_VDS=
O
> > >  ccflags-y +=3D $(DISABLE_LATENT_ENTROPY_PLUGIN)
> > >  ccflags-y +=3D $(call cc-option, -fno-stack-protector)
> > >  ccflags-y +=3D -DDISABLE_BRANCH_PROFILING
> > > +ccflags-y +=3D $(CONFIG_CC_OPT_INLINE_MEMSET)
> > >  ccflags-y +=3D -ffreestanding -fasynchronous-unwind-tables
> > >  ccflags-remove-y :=3D $(CC_FLAGS_FTRACE)
> > >  ldflags-y :=3D -Wl,--hash-style=3Dboth -nostdlib -shared -z noexecst=
ack $(CLANG_FLAGS)
> > > diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso=
/Makefile
> > > index 8dbf2532a573..c023046a3fd7 100644
> > > --- a/arch/riscv/kernel/vdso/Makefile
> > > +++ b/arch/riscv/kernel/vdso/Makefile
> > > @@ -36,6 +36,7 @@ endif
> > >  ccflags-y :=3D -fno-stack-protector
> > >  ccflags-y +=3D -DDISABLE_BRANCH_PROFILING
> > >  ccflags-y +=3D -fno-builtin
> > > +ccflags-y +=3D $(CONFIG_CC_OPT_INLINE_MEMSET)
> > >  ccflags-y +=3D $(KBUILD_BASE_ISA)$(CFI_MARCH)
> > >  ccflags-y +=3D $(CFI_FULL)
> > >  asflags-y +=3D $(KBUILD_BASE_ISA)$(CFI_MARCH)
> > > diff --git a/arch/s390/kernel/vdso/Makefile b/arch/s390/kernel/vdso/M=
akefile
> > > index 35c834b895ec..54bcf2984ca1 100644
> > > --- a/arch/s390/kernel/vdso/Makefile
> > > +++ b/arch/s390/kernel/vdso/Makefile
> > > @@ -29,6 +29,7 @@ KBUILD_CFLAGS_VDSO :=3D $(filter-out -munaligned-sy=
mbols,$(KBUILD_CFLAGS_VDSO))
> > >  KBUILD_CFLAGS_VDSO :=3D $(filter-out -fno-asynchronous-unwind-tables=
,$(KBUILD_CFLAGS_VDSO))
> > >  KBUILD_CFLAGS_VDSO +=3D -fPIC -fno-common -fno-builtin -fasynchronou=
s-unwind-tables
> > >  KBUILD_CFLAGS_VDSO +=3D -fno-stack-protector $(DISABLE_KSTACK_ERASE)
> > > +KBUILD_CFLAGS_VDSO +=3D $(CONFIG_CC_OPT_INLINE_MEMSET)
> > >  ldflags-y :=3D -shared -soname=3Dlinux-vdso.so.1 \
> > >              --hash-style=3Dboth --build-id=3Dsha1 \
> > >              $(call ld-option, --eh-frame-hdr) -T
> > > diff --git a/arch/x86/entry/vdso/vdso64/Makefile b/arch/x86/entry/vds=
o/vdso64/Makefile
> > > index 7c0790065b5e..c2353a065279 100644
> > > --- a/arch/x86/entry/vdso/vdso64/Makefile
> > > +++ b/arch/x86/entry/vdso/vdso64/Makefile
> > > @@ -14,7 +14,7 @@ vobjs-$(CONFIG_X86_SGX)                       +=3D =
vsgx.o
> > >  vobjs-$(CONFIG_FUTEX_ROBUST_UNLOCK)    +=3D vfutex.o
> > >
> > >  # Compilation flags
> > > -flags-y                                :=3D -DBUILD_VDSO64 -m64 -mcm=
odel=3Dsmall
> > > +flags-y                                :=3D -DBUILD_VDSO64 -m64 -mcm=
odel=3Dsmall $(CONFIG_CC_OPT_INLINE_MEMSET)
> > >
> > >  # The location of this include matters!
> > >  include $(src)/../common/Makefile.include
> > > diff --git a/init/Kconfig b/init/Kconfig
> > > index 8583d9f06c52..ff3f8475dd2f 100644
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -173,6 +173,13 @@ config CC_HAS_ALLOC_TOKEN
> > >  config CC_HAS_MULTIDIMENSIONAL_NONSTRING
> > >         def_bool $(success,echo 'char tag[][4] __attribute__((__nonst=
ring__)) =3D { };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
> > >
> > > +config CC_HAS_OPT_INLINE_MEMSET
> > > +       def_bool $(cc-option,-finline-stringops=3Dmemset)
> > > +
> > > +config CC_OPT_INLINE_MEMSET
> > > +       string
> > > +       default "-finline-stringops=3Dmemset" if CC_HAS_OPT_INLINE_ME=
MSET
> > > +
> > >  config LD_CAN_USE_KEEP_IN_OVERLAY
> > >         # ld.lld prior to 21.0.0 did not support KEEP within an overl=
ay description
> > >         # https://github.com/llvm/llvm-project/pull/130661
> > > diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
> > > index 2851afa9154f..f5cad5641985 100644
> > > --- a/lib/vdso/getrandom.c
> > > +++ b/lib/vdso/getrandom.c
> > > @@ -29,6 +29,22 @@
> > >         }                                                            =
           \
> > >  } while (0)
> > >
> > > +#if __has_builtin(__builtin_memset_inline)
> > > +#define memset_inline(dst, value, size) __builtin_memset_inline(dst,=
 value, size)
> > > +#elif IS_ENABLED(CONFIG_CC_HAS_OPT_INLINE_MEMSET)
> > > +#define memset_inline(dst, value, size) __builtin_memset(dst, value,=
 size)
> > > +#else
> > > +static inline void *memset_inline(void *dst, int value, size_t size)
> > > +{
> > > +       char *d =3D dst;
> > > +
> > > +       while (size--)
> > > +               *d++ =3D value;
> > > +
> > > +       return d;
> > > +}
> > > +#endif
> >
> > Does this work?
> > https://godbolt.org/z/Tx6EaGMfb
>
> Hmmm...possibly.
> https://godbolt.org/z/ec9rzd9Yf
> I don't get it...

Just keep it under 2 pages, it will be fine:
https://godbolt.org/z/qqoMqfxev

>
> >
> > (Sorry, I _should_ have replied to Jason on V1. I'm not ignoring him,
> > just way behind on my code reviews. Sorry!)
> >
> > > +
> > >  static void memcpy_and_zero_src(void *dst, void *src, size_t len)
> > >  {
> > >         if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
> > > @@ -83,8 +99,7 @@ __cvdso_getrandom_data(const struct vdso_rng_data *=
rng_info, void *buffer, size_
> > >                 params->size_of_opaque_state =3D sizeof(*state);
> > >                 params->mmap_prot =3D PROT_READ | PROT_WRITE;
> > >                 params->mmap_flags =3D MAP_DROPPABLE | MAP_ANONYMOUS;
> > > -               for (size_t i =3D 0; i < ARRAY_SIZE(params->reserved)=
; ++i)
> > > -                       params->reserved[i] =3D 0;
> > > +               memset_inline(params->reserved, 0, sizeof(params->res=
erved));
> > >                 return 0;
> > >         }
> > >
> > >
> > > ---
> > > base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> > > change-id: 20260916-vdso-getrandom-avoid-memset-llvm-24-74d45fa6031e
> > >
> > > Best regards,
> > > --
> > > Cheers,
> > > Nathan
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers

