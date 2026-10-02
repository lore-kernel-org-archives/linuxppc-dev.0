Return-Path: <linuxppc-dev+bounces-28746-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B72CA5FC4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 10:59:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx5Pq44f6z2yTQ;
	Fri, 02 Oct 2026 20:59:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790938751;
	cv=none; b=ouaVvZaGxlX+LgW7PLCsBhh/j/zUp3XVcgu9Q+l0TWGaQv7TwfrCNg+uhxhtwToRv8pMN+g7MGx66l9GxoOaYu2QWK1834Gsn13qmUkZYM6o4+U4zyERgCFn2mL5l/Pl/oGYS3Tq2GMbNMP4PbjX6Rnvw/JN4A18u+gy+ReDeI/PyPF4CWOPmCgSxwpvJzNSuX6/aZOXPOSdCwb5bk9+M/Cihinra+QR5d53E6NED4w60D0bGqNl5sVad013Tk6jzYurECmO8CY7fHWQEDgbpGxZ1BBwksGfmmrAlQboza7tap9B7xzq/QjkNJ93J2ckMbX2ZjOJ1b21XJXTwdl69w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790938751; c=relaxed/relaxed;
	bh=Pxei7jjMKgKYiJq7FPMIUgor4y30+Z660JBwkmAeSIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3A+ciynsFmuBmbZ2Ebk8Ru76wnwIp723e4K3tb0GSam+t1BGX+Xo1jXJW5bkAd1F3FfJYDsYY+zU73tXgXHCxPz2lz7YuL2Fgu0Dvel2lK4TT82Q9wdJUW9/VGd/fsVqOMy+lnlQTPiWrm5Nkl6/5/lMOqp2TdrHYSrHmJU3o9ztW9ZrgSwjo/T5IHBwnlEAiuwM8HZiPLpS5OquxmDBoxmQt3umXnZ6hdG3F5xhPkpz2tf0IQRqDDy+ejHai7aM5AsfrYDYNVen9VcOD4LdoXdQH/q42waoY+cM2i7gIy5MHqwTTEZnrpQOVFGcRFtYSc5ZCzCrOl8A4lpiDL7bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com; dkim=pass (1024-bit key; unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=GFcq79Kf; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=ixz0=hy=zx2c4.com=jason@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=GFcq79Kf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=ixz0=hy=zx2c4.com=jason@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx5Pm4SdDz2yPG
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 20:59:08 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8152960A70
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2026 10:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028681F00893
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2026 10:59:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=GFcq79Kf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1790938741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pxei7jjMKgKYiJq7FPMIUgor4y30+Z660JBwkmAeSIU=;
	b=GFcq79KfRexVqilVjQe3T/gap32hK9qtzApE0XFvXwM/oaDLzOd7whYw4Kh6lglo15H2aR
	RtzjZBAdP97mxck7aFDAqWM8j3nNia5mfzweaufHZr5e1ofSYjFOWnoVXzgIvlsUtgQbv5
	8kteJa0XF5H880jzodM0MYuQAKRXNY8=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id d175b6a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 2 Oct 2026 10:59:01 +0000 (UTC)
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2e0f2c945eso426660566b.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 03:59:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwm02WT8KcNDbDSisffr9x5YWFmxjPiCqemW3PK3OVgezJLyWVR4F75m7KCZt0CV2fIVg7G9Rtc/ZRuOrA=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lOw7H9rfUoTAF7kydp+TBesgarr+abZCZpVMj6qlP/vSbIySq6
	tsX7A9+fiB0RvcqeY5vJ9xL0hfhxC3fizGc+Onhc/Il9CrjsKCVjcZJppIXJ+w0vEYZCY7XiOoq
	5ZXxEih5RxeWiOityyymRnXPredIMTSI=
X-Received: by 2002:a17:906:ba87:b0:c2e:3acb:34df with SMTP id
 a640c23a62f3a-c2e4b3ffd07mr185815666b.39.1790938736158; Fri, 02 Oct 2026
 03:58:56 -0700 (PDT)
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
 <179093852073.149722.832232613857480812.b4-ty@kernel.org>
In-Reply-To: <179093852073.149722.832232613857480812.b4-ty@kernel.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 2 Oct 2026 12:58:44 +0200
X-Gmail-Original-Message-ID: <CAHmME9pDcYh5OVSqnju8VfgEXt3YBToDBbFNz_OguKA23r6stg@mail.gmail.com>
X-Gm-Features: AclHuK806shnKBNqNgOvgQVyH7F2xaT6wyW4EoVyeu-ArFe_UTxaLC7DpGRwXbE
Message-ID: <CAHmME9pDcYh5OVSqnju8VfgEXt3YBToDBbFNz_OguKA23r6stg@mail.gmail.com>
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Nathan Chancellor <nathan@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
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

On Fri, Oct 2, 2026 at 12:57=E2=80=AFPM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
>
> On Fri, 25 Sep 2026 22:46:32 +0100, Nathan Chancellor wrote:
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
> > [...]
>
> Applied, thanks!
>
> [1/1] random: vDSO: Avoid call to memset() when zeroing reserved in __cvd=
so_getrandom_data()
>       (no commit info)

That's not for you to apply. I'm sending this through my random tree,
along with a handful of other things I need to fix. But I wanted to
let this cook a bit more. I can add your reviewed-by line, though.

Jason

