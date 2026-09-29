Return-Path: <linuxppc-dev+bounces-28511-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A869FCA5FA7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 18:24:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvRR06nKgz30WF;
	Wed, 30 Sep 2026 04:24:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:30::10" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790706268;
	cv=pass; b=EBNNLd/pKUhFAlc4AWqsSCUMZ2e7+uFROb3aHs6qWiO+HGqeAJjzYHBDKQYDf7bgwvEtrt0BYs7US9RF3u2ej7raq0xbU688uoJYUlwroMpTqfqL53SP6F7h2a2cDQyUAildOGiksJkuxgy3gUgHkDBhec6WSW9YPjoyGgkqVywdu7BlEa4Ce0KW7x5sSZMMze8xy5Kgbbt+TLwHPOvO+m1AXsb+BU38enu20I8u0+CQL6aZ2XFxAPu7gM1fLAfP9rxRXZB3JCS0qFvy0Pf6yrP+IVCBOzDjKJm9/xic8Q3/o+PmENOoozG+1CFz0qhlMqCBRlnEDsF463588Y04jg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790706268; c=relaxed/relaxed;
	bh=g5iqo8UY2L5mZlXboZ0sxIpBdYrZWI1CLq6z3i5raKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNAi/fN9f+7arS2ni6DaW16n3WisBZjQtM3zNQpwAd14PqgC1xtFJzFIIz90ATo8jOaT0WPGNdOxWmAVZXpyUuq+7Q9FmIJS19lU8FuzYVJp//EGl52nFTjKLYocl0KHadryyrFsZa+ek/5++w0oehQD2hjQaJTTfEEii6A1GNuTI2MDSximlDXECawtqvEmGQyqb7X7zxk8+pattIR2VG5uuglRTMl/3BWe+URXKEGegdpvE2TwkIzQ7Beqw0gMyIHBdXrZQSvq7cXe6ovuBe5MZZfYDqO3UZKfEc+aOSCfnuwVH89Mfyul3sakPDNJFe71wsfzCctoO0RNRJg+gg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BQD2nU9G; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com; envelope-from=ndesaulniers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BQD2nU9G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com; envelope-from=ndesaulniers@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com [IPv6:2a00:1450:4864:30::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvRQy5fRlz30Vs
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 04:24:26 +1000 (AEST)
Received: by mail-wr2-x10.google.com with SMTP id ffacd0b85a97d-482f6350f89so2800874f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 11:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790706263; cv=none;
        d=google.com; s=arc-20260327;
        b=Rb1jnKNkhQOOlvxD8+ciPMXQnx3x7cdt9IAhgjvNI/nVkefZfESbchKCdot+SyscPc
         gyWhygsseVZHJ2Mk5cYFAl5x4jadFeQFg2ONQ/IDlxxcKTlnjI4+dFZY0kPOLK8dFo3O
         gsKKq+MKq2pVPXwWEhY66YIZhwAkImK8B9iabbbGXxgf1EdZwkLDJhZ0DAfeKACw48Y+
         sFmXNp/DV3NK2w4jwHrwLwg++mVqgRIwnr1kFEUdbC4BowYq86yRU6z/7c/VorxawglS
         XuJJkuc1zqFBY7dvNkHVxpDaCxMalROhw64OZkcFdfAPwwhm9ZkaaB6GKHcGMdHeBek0
         Tj2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g5iqo8UY2L5mZlXboZ0sxIpBdYrZWI1CLq6z3i5raKI=;
        fh=/jmB7Nb2tSbLVGPlP3o5kzrbMGB1gz6WJf4wZSzKUFE=;
        b=m7ZfcXqYkionYWLpJ2ZHOTrNfz74stmAWO4FjEtP4hf7VWcCtfFeJFfbHmUlZdTxMo
         qYCoHE87LfP02bLpFgqFr5OUJjdP+IKkxfQq3F9WCnO7mJ1eRco53mEEKz0idebgONLM
         X11KI2ZTPKzdg/rDiflhQ2uFyEcfFhV9RnkBsZZi77p5k3G+uvvbLuHmxFk9WATzA37i
         J+BYrMz09RauEAjFZmbogiiCTZsWG1479Vdh6GSd4tJs0eG/QI7PtNXpFIbg9T3/Lvxu
         YybZYK/JB3aP8aqI8ScGY3swOf77XisrLcMq9E+Fj7Bsofl0Oegj3TVYpBpvGb95vafH
         23Jw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790706263; x=1791311063; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g5iqo8UY2L5mZlXboZ0sxIpBdYrZWI1CLq6z3i5raKI=;
        b=BQD2nU9G/Pvp/qoLuWSCql1Ea1F8NJ1qPiyWGPZ7CwXxZJXXtSxq38T8Jt1P+WDvka
         0mtgnDV+Xndmsr5nj0ql5oWBXMxH7kZ4RkZdEdoCaAMrMzC33IwshffH6ONZjzK/57xv
         mnDDsHbynmJ7Fe+CW2OEfniqZUtpTxW+0kt6eTP54NvrzmDCqpEP4i1xYaQ7++1sy8zo
         tMGMDXNpODQX0IM82AmM/cZ/sEiygZNB2qBpP/OVN03MUJNV7Y5OdIlv6mu/OWD5m1/J
         w4EzC195TPjbuUzpvCncbM+iF7m2CUJrCGYXK+6uXSzqNzSd4oOZ1Nfs8mn7S11SamzS
         Czhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790706263; x=1791311063;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g5iqo8UY2L5mZlXboZ0sxIpBdYrZWI1CLq6z3i5raKI=;
        b=WzhhJHTBEK0UQOysv4ooRMLY0emH82mUvmvJlB/4yQbjXo1TaaxDjOWZr32GwuOwv5
         bjNpep+0k8PE0PPfRiAAy4DEjeMbSDB8oRtD4sX+h9/eMyu7d4+URUwg+OyLMjuUdRVJ
         sd+S5/N5Zyrlxf8xqltWnotUijs01J+BsM3fzGUq011NKc6lVNVa2p/3kYwOvhhPGMIh
         BixyW7akpHw+COFZMIeUb1YQ7N0YRbkR7zuzopw4h0f+U3XM9UyBy9gbEv1hvSsRIAse
         AWs0txaoSSnxWWJ33uBQfCXCC5PJ7gu1glnREJrN0k43pdMxUYCZZWjzmzmnfEuiCZHn
         /UGg==
X-Forwarded-Encrypted: i=1; AKwUvBzDs7dtlEOvprhZHwglcTfyh6G3yc29nP/Qr6VNk3yQX9v8J4J1WUQ7571w/BT+AWecO23/BAJZDVKZA/s=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJkIrPaQXd9EU/ZApXMKajXIsuhro9+EPzWuTUX35ywTFcqUhpE
	yixwEX3muyv2yXer0/YqjB79NSQ4Q76532/UcnvHeUmBAPhWqRVa1kkzKvBio+Kj5xQAdNZo5UQ
	UMl84Ak1ixeKfzhqDTVc1eyKki3K65bTL4vv+5nyB
X-Gm-Gg: AYBFou3W/SOiyUTAWpOQwFXuFe+Ud1haqZOv2qi588uDQk8+0DPlapBgXCjDuU9xxZ8
	f5qhbV/xtMIFtDqFnah9/tXhdrTlGDCWRCfF/IEA4rgLSTemNXMZ97uKYKaAJqYt5klpl4wUtO0
	PTl1k4Yv3XEBZYPYZtCh+FUYoOFZjB3p0Oh7biWh7nnCQRrvzh7y7/NTGwOtIm3QFH56rM8/Sy9
	rvLv6yHmItSaUxNRO5Qil6cC1Cf+cnKtUDR8WHoNrdyKwCmqHfnPHP2vAQmOHVqgTSeuz72KgdG
	+TYQ/0qAGdYAO/LMl+c1WOwhKasL++R+WU1SsCIExJAvsHLROlsm2+v7AIDp0HMUHtj/1C+OmPg
	gTW4AilOKMdbo/KNgVOMA5n/p+Se5GwcHQtLT4zfbYgPzCCmKA48qZOq16Zzwlyo+wjM=
X-Received: by 2002:a05:6000:2381:b0:48a:fba3:d5b6 with SMTP id
 ffacd0b85a97d-48afe7ab8dbmr265943f8f.56.1790706262469; Tue, 29 Sep 2026
 11:24:22 -0700 (PDT)
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
 <CAKwvOdnxKVpn=nAFaqP+9PTx4PqgHsUVWv6e60Pcr29W_eZrpQ@mail.gmail.com>
 <CAKwvOdmNZL3eFvV3v77GXDzL+XLgz+BT9TA=my0yTnbsHqVeSg@mail.gmail.com>
 <areYMjNcaqe86ds4@zx2c4.com> <9d1c338b-368f-4ea2-a12e-c28d49adff5e@kernel.org>
 <are6s5e6On3hpD3M@zx2c4.com>
In-Reply-To: <are6s5e6On3hpD3M@zx2c4.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 29 Sep 2026 11:24:11 -0700
X-Gm-Features: AclHuK_OlHRHmRVZkjU6Ad7ygjuA5O41_jDQwI5Gzaif3nG5KjlJX6HrrO4nUUw
Message-ID: <CAKwvOd=BrMfFT88jsvBPhh383qqk5G+J07CsofNu0MVkziyhCg@mail.gmail.com>
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Nathan Chancellor <nathan@kernel.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
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

On Sat, Sep 26, 2026 at 5:29=E2=80=AFAM Jason A. Donenfeld <Jason@zx2c4.com=
> wrote:
>
> On Sat, Sep 26, 2026 at 12:55:34PM +0200, Christophe Leroy (CS GROUP) wro=
te:
> > Hi Jason,
> >
> > Le 26/09/2026 =C3=A0 12:02, Jason A. Donenfeld a =C3=A9crit :
> > > Apparently not on RISCV, which is what prompted this patch in the fir=
st
> > > place. So I suspect Nathan's v2 here is the way to go.
> >
> >
> > Don't you have -fno-builtin on RISCV like we have on powerpc ?
>
> I think Nick mentioned this led to other problems and didn't exactly
> solve the problem.

Sorry, been very busy.  Getting blasted from a fire hose of AI
generated patches to review...

arch/arm64/kvm/hyp/nvhe/Makefile has this pattern for exactly the same
problem I suspect.  Maybe that's the right tool in the toolbox?

```
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makef=
ile
index 8dbf2532a573..27fa72d8fb86 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -27,7 +27,7 @@ asflags-y +=3D -DVDSO_CFI=3D1
 endif

 # Files to link into the vdso
-obj-vdso =3D $(patsubst %, %.o, $(vdso-syms)) note.o
+obj-vdso =3D $(patsubst %, %.o, $(vdso-syms)) note.o ../../lib/memset.o

 ifdef CONFIG_VDSO_GETRANDOM
 obj-vdso +=3D vgetrandom-chacha.o
```
Fixes `make -skj"$(nproc)" ARCH=3Driscv LLVM=3D1 mrproper allmodconfig
vdso_prepare` for me, as per
https://github.com/ClangBuiltLinux/linux/issues/2183
(Nathan, don't forget to link to that in the commit message)
I'm surprised I didn't need -fno-semantic-interposition (or one of the
related flags... -fvisibility=3Dhidden)

If we want to get better, (if performance matters here and we want to
trade source+build system complexity for absolute code perf) I would
start with that, then worry about clawing back performance via things
like:
- __builtin_memset_inline
- -finline-stringops=3Dmemset
- -ffunction-sections+-Wl,--gc-sections to dead code eliminate the out
of line copy of memset, though IIRC there's potential for wasted space
due to alignment requirements (maybe the out of line copy of memset is
smaller...idk)
--=20
Thanks,
~Nick Desaulniers

