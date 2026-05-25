Return-Path: <linuxppc-dev+bounces-21471-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24A6CD5BC9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 13:17:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPGdd13r7z2xfB;
	Mon, 25 May 2026 23:17:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779715061;
	cv=none; b=hFEVT7BY/E9FIy0uueLU4jCEmsE9dQYei/xJyrgARfNWa0GH98znnnlTlxii4vQQ62u092LZgslv3x/MY8O+5ocEpkgaIOajnIq4wSeghXfypGSdHPBuUPrhrNpLcGel7gs4JC8gMlq5MKTMjeRa3bffxuq95lxhxsTXKCqM1A67klcHPXjoTGXXnTpzfPfKEuvHK8ICABFhyHpi/C8mHny+zBpWFcG18lknlhzcbhzX2DSlLXrG0+7gQSZbBs2nLSG0z0tEhuNqTZ2qMvuQzPFrAU0Oc7gFP2dbXPYzHFyIOkqp8ZU9844IoZiF0AYq6llc5XrwGMHSsG+ogZxtcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779715061; c=relaxed/relaxed;
	bh=qV78+XoJ5yl4lw7jTkTV5DIdhzm9s8UbSBBAw5Rneo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkYf74sBA4ZfVXYJOlU1CmI/4viN1P0oU9i5fEWTUEewBZfEQEVMkKy8Q5TaMDQqDXENGI55ej+BRDwJmc6Uwz3BizA/AG4lm4rMRpFK9FaRZa3GOykvKI3bMkJrO8fCWu3JFYjwIqKwbh8bxpSro+87KPwA40JjVstL1cf8gf5h9VxHC0/LW5JKdMJ5XHwItLxkzdl7OwUN1EXuzTvjV8pEha5HF4kDFQLaasrkxRCavLKNLH4olSN+Q/NOvbotdXZDNuESCTZdN6SpUO3qGJBzYN+EsxnZbYAHe8hhw+wo5Lng3Uwy325WXJQ80MfO754tt5MyyMYZsyRzvAMNKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCpzrAvf; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chenhuacai@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCpzrAvf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chenhuacai@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPGdb5V7wz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 23:17:39 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3BE47445E1
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 13:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237ED1F00ADF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 13:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779715056;
	bh=qV78+XoJ5yl4lw7jTkTV5DIdhzm9s8UbSBBAw5Rneo4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dCpzrAvfgk9mSUU6JI5HHHez6L14UFh5dckZN5DAlujdAQMm/PYPxcKDOMc41IypU
	 NgmmttTk+nJ7gpnOe4Eg8v+8FV8RT+v5Ae+glRPhqcxzGZd/+6hgMw0F7yv/+6rQz4
	 X95gdQuJUyAKc1hWH3Gy1/l+TIZX2idKqbCpGmaVwhcsQRUGGQYoJHz3dhHrh2l/au
	 j0SXMMWwm+qgnDiXn93t6TJoPrAZ5gm82qSecFVClh3KPL2gWZzu9niNd8OSefMoGl
	 agHzEYaoQKd6HOPeiZMWEfzv0bjMM/EusAmU3Hy1nMtvCCD/Sa2YxNSMJTFxPK7Fzo
	 JaK+HMaC87z/g==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bd56d108454so1744967666b.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 06:17:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ851xzf57s+ToeyfLSk+sW0eniturv7TgdWKiAaMFKPuq1H4yC9xh+OkFLghDHi9AsrzSbDyF62YEr1gRY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxU4BfKPwxHtAl0wReP/fEfaQkS+Ozjq1cLKCdOceKwvp1MCSTZ
	sN3OVmBxFHgaOKX586PqOWCOnNyfFeWxnHrJkwL59wxd1usS/HMscRX5FKhmXb1gKaYP7ocKWQE
	AIFk4fU0ONXsytKpfP04NcyFJRMbCXEQ=
X-Received: by 2002:a17:906:5a58:b0:bd5:7c2:7622 with SMTP id
 a640c23a62f3a-bdd26fcc664mr633046266b.49.1779715053431; Mon, 25 May 2026
 06:17:33 -0700 (PDT)
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
References: <20260525084932.934910-1-ruanjinjie@huawei.com>
 <CAAhV-H4NA7vgyxKnK+N_3C6pWBnwXc2URUyLh_h1m-MO=MnsGQ@mail.gmail.com> <ahQ0WRiMsB011tym@kernel.org>
In-Reply-To: <ahQ0WRiMsB011tym@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 25 May 2026 21:17:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5x3m08=acrUr2VOAQ8-r2PhN1xTdr3NihHocoPM5=3hQ@mail.gmail.com>
X-Gm-Features: AVHnY4KF6iz3ZOONNz4YfBuRaFyzFjWLq0_9v1vlnlGZ6xwTI_B6DWjmlURC67Q
Message-ID: <CAAhV-H5x3m08=acrUr2VOAQ8-r2PhN1xTdr3NihHocoPM5=3hQ@mail.gmail.com>
Subject: Re: [PATCH v14 00/17] arm64/riscv: Add support for crashkernel CMA reservation
To: Mike Rapoport <rppt@kernel.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, corbet@lwn.net, skhan@linuxfoundation.org, 
	catalin.marinas@arm.com, will@kernel.org, kernel@xen0n.name, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org, 
	saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com, 
	pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, 
	rdunlap@infradead.org, pmladek@suse.com, feng.tang@linux.alibaba.com, 
	dapeng1.mi@linux.intel.com, kees@kernel.org, elver@google.com, 
	kuba@kernel.org, lirongqing@baidu.com, ebiggers@kernel.org, 
	paulmck@kernel.org, thuth@redhat.com, ardb@kernel.org, masahiroy@kernel.org, 
	mark.rutland@arm.com, maz@kernel.org, james.morse@arm.com, leitao@debian.org, 
	sourabhjain@linux.ibm.com, yeoreum.yun@arm.com, coxu@redhat.com, 
	jbohac@suse.cz, ryan.roberts@arm.com, cfsworks@gmail.com, 
	tangyouling@kylinos.cn, ritesh.list@gmail.com, songshuaishuai@tinylab.org, 
	junhui.liu@pigmoral.tech, vishal.moola@gmail.com, kas@kernel.org, 
	debug@rivosinc.com, namcao@linutronix.de, liaoyuanhong@vivo.com, 
	fuqiang.wang@easystack.cn, seanjc@google.com, guoren@kernel.org, 
	chenjiahao16@huawei.com, hbathini@linux.ibm.com, bgwin@google.com, 
	takahiro.akashi@linaro.org, lizhengyu3@huawei.com, x86@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 7:37=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> Hi Huacai,
>
> On Mon, May 25, 2026 at 06:14:52PM +0800, Huacai Chen wrote:
> > On Mon, May 25, 2026 at 4:50=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.=
com> wrote:
> > >
> > > Jinjie Ruan (16):
> > >   riscv: kexec_file: Fix crashk_low_res not exclude bug
> > >   powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr(=
)
> > >   arm64: kexec: Fix image->elf_headers memory leak during retry loop
> > >   x86/kexec: Fix potential buffer overflow in prepare_elf_headers()
> > >   arm64: kexec_file: Fix potential buffer overflow in
> > >     prepare_elf_headers()
> > >   riscv: kexec_file: Fix potential buffer overflow in
> > >     prepare_elf_headers()
> > >   LoongArch: kexec: Fix potential buffer overflow in
> > >     prepare_elf_headers()
> > >   crash: Add crash_prepare_headers() to exclude crash kernel memory
> > >   arm64: kexec_file: Use crash_prepare_headers() helper to simplify c=
ode
> > >   x86/kexec: Use crash_prepare_headers() helper to simplify code
> > >   riscv: kexec_file: Use crash_prepare_headers() helper to simplify c=
ode
> > >   LoongArch: kexec: Use crash_prepare_headers() helper to simplify co=
de
> > >   crash: Use crash_exclude_core_ranges() on powerpc
> > >   arm64: kexec: Add support for crashkernel CMA reservation
> > >   riscv: kexec: Add support for crashkernel CMA reservation
> > >   arm64/crash: Add crash hotplug support
> > I have some bikesheedings about the subjects. Can we unify the prefix f=
ormats?
> > x86/kexec, arm64: kexec_file, riscv: kexec_file, LoongArch: kexec .....
>
> It might look weird in the series, but powerpc and x86 use '/' and arm64 =
and
> riscv use ':' so in the logs in arch/ this would be actually fine.
OK, but at least we can unify kexec and kexec_file.

Huacai

>
> With the only exception of arm64/crash that should have been arm64: crash=
:
>
> > Huacai
>
> --
> Sincerely yours,
> Mike.

