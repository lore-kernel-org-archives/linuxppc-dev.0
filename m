Return-Path: <linuxppc-dev+bounces-23945-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D17BC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 16:27:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx0jX71VZz3c9x;
	Fri, 10 Jul 2026 02:27:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783614432;
	cv=none; b=XaCbm6bgD0BxUwP6LY2lp6rEUHN8f8qN6EgDXrtzUpKv1hIiISvOBggnav5STiQPSJzrOWKElpHy2zF57c2XlYa3RAwEhApkflom9xh+tEuoQW9oehpn6wRAo7fTYSkkvtuYiQIF0ZHI8CTZj7fsjt0K7K78poBC5BGHzjVogh1ht/ThrmruScqJkjblSvFZn/mGO8G1DkpoKProcs+wBnskGcpaebJUU4RgcsAIWWhcVC+05fHcs2CuhhlgLmEYAes5+LZ3pNAJAhwdZDXpCVQOT5ZvxzJNHb4p0IMHvF9FFfG28e1yyZI6VwCGpXRPcAgTSscEGOz+WjbkbaOpPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783614432; c=relaxed/relaxed;
	bh=GEOL8DOWD1Msvjz7k5cAG0xDAOqwGsu0BnpwMff10wU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CAk/Bl2TOi5WlEfAVfdQSYqxMU34ZdAUgpqc3LVWqliLujlS43qB9XxVdG/AwcHBC2GqB7Ldwpdx0WHFvc+u4O+1SZBAGgxrGVPmkYEWTXws79ZO9VFr8tUbn6RAPoFM31uNLUumEfU1ojxVJiOhHsvEETHxFyfdWC1dCrZynJOHU2NAabH2XlPJHzdbVYVgwcOhOnDttGTyzF+Z4604ryt1r8QAQaiRXB+a0PzMmUqCrbhWWRvT1es0hMbo3RS/FrHcP3ENC2aIjY7doOLDgH71lvijWq7wEhqWQ5ed72dnU+6IRi5b3T15qRSUygB8bxK4ojI6KIEhlUVKIV+zHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GYI8muMQ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GYI8muMQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx0jW6LkHz3c9k
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 02:27:11 +1000 (AEST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-493b1710405so12634845e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 09:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783614423; x=1784219223; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GEOL8DOWD1Msvjz7k5cAG0xDAOqwGsu0BnpwMff10wU=;
        b=GYI8muMQZG7SXzXE/JfTIa4vWabbmNMb/KZukeW4gBjIEfK+qOlgfX9obdhezYs3fl
         KEbnMEnR1nBJ2CvmOARXJOFmLuCYwfhW5Veh1Un9UAwOWUv8GBKkMp2qFeISORGqrTke
         9zIyF3hfE7kjvyK9fkNyzigXxgAW/EtZm+lXpsBahF5iPujDOZu0of+kbeswAFs9sBdP
         kOvj5RiOZvqUUhU7FwR4IKkZFz+RXBcC2Np/vgcrWr6cQLPjtzJZ21bnBqTTCuwCN584
         wuDHkpQpfv1kI/dLv4hkTkiW2qkJwxHVBE5tXIdNHBbpwCjMpKPdNH2KKMUCLQzrmyfP
         l47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783614423; x=1784219223;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GEOL8DOWD1Msvjz7k5cAG0xDAOqwGsu0BnpwMff10wU=;
        b=IQ12ytt/tyZ4/NVNfJSwlV2ygze8C1k9q0mr45IXVNiJ8pmQlENRxoyK6g+PI+fG7o
         bMUcIz/+RRlySr9EzDrNVbOuMZ0mIP2XDdt3bxyxhJYjooXVT0J4VXKNVdbHuISE4Vza
         cZBywQvUcUmqGMyzg0wLGfsWLSSQs0jDI8FabHtKqsiI+ssu95/tR+/Jo7N6iSj0yn0e
         deGH3Ol3D469+tH7wuntI9k49tQQDgkLQkpQOPN0x/cInxju6aT2KiligDp0d2iig1uO
         XDEmDNpYv9qfWDfgffuLE09zkA2hxKxjLBbLkfI7PthDX5JVW+ixV8R8IHmAiewjYNGd
         XEhA==
X-Forwarded-Encrypted: i=1; AHgh+RoJfkc5+wdchKFZfzGaC0Jrq8g5l+50JYBBIbCfvUVOFz5IaRlvfT3OMzRVdMaqpr5yHBoG31yO8CCez8Y=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyIsGZMYLmUQlhasy6RSYgF/ePx6oAVJrDMtJmoNelHJWnn23A5
	F7DNYhMSh6XXcHd72BNp9bSAzpGLqX7ZIg3L/DNU3IfPPGnQdYcdSkxK
X-Gm-Gg: AfdE7cmojFuQcEHxzC+brrKoh8H/YDAM3Mi9ioMm9eJWLnJPN2rDCtPPO/QVSXyM/Hp
	BaL5OgafaYNrKTDUm3i/KM23jK4Ldp1H1VglZ+qEE0R+Fmy1H8gUEQFEg/ScfGSa3HdIcXOorX2
	1V/jKun/7W3vqbIqzRsRg8C9QeixXwESdvReblr5sxvapkGDULQXJu2p66LWDJbmzlEXXczmILq
	v3mGopiWacaQNkth4w83JFWoi630ty1FN6wqyaN5eIA7y6G0jrU1+fnMHxTA6oPpBwaSZFy32YA
	L4jZ+tmm4Bil2qPyOeSbDNeE7HeM9GJ2n0iGqvl+fdyMLc1hGU0vS1MwVptoGR2evtqHDyu2kIy
	PiBmBX7chAPE9n2Y3IDJzUXHWh+RT3pWZGai9i5VB9nLyzSfknC/Goj1VmKx5DGgrOpbcd9rtDP
	tpGIP+ZeTtQb+aEyb6ERgaNaX4gxe0i3kWyrVLwj5+TmCQUA==
X-Received: by 2002:a05:600d:6405:10b0:493:eec0:2b8c with SMTP id 5b1f17b1804b1-493eec02c80mr19641245e9.12.1783614423204;
        Thu, 09 Jul 2026 09:27:03 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb670a41sm70023415e9.0.2026.07.09.09.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:27:02 -0700 (PDT)
Date: Thu, 9 Jul 2026 17:26:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, LKML
 <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde
 <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook
 <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Guo Ren
 <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
 <richard@nod.at>, Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann
 <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>, Brian Cain <bcain@kernel.org>, Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Subject: Re: [patch 13/18] entry: Make trace_syscall_enter() return type
 bool
Message-ID: <20260709172659.7040db33@pumpkin>
In-Reply-To: <87ik6pqdkf.ffs@fw13>
References: <20260707181957.433213175@kernel.org>
	<20260707190254.338083894@kernel.org>
	<ak5ySpil83TNWxeq@kunlun.suse.cz>
	<87se5tqkyp.ffs@fw13>
	<87ik6pqdkf.ffs@fw13>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 09 Jul 2026 01:14:24 +0200
Thomas Gleixner <tglx@kernel.org> wrote:

> On Wed, Jul 08 2026 at 22:34, Thomas Gleixner wrote:
> > On Wed, Jul 08 2026 at 17:52, Michal Such=C3=A1nek wrote:
> > Q: Is it perfect?
> > A: No
> >
> > Q: Can it be made perfect?
> > A: No, because you can't change history and established practice.
> >
> > Just for illustration. Changing the logic in trace_syscall_enter() to:
> >
> > --- a/kernel/entry/syscall-common.c
> > +++ b/kernel/entry/syscall-common.c
> > @@ -9,13 +9,15 @@
> > =20
> >  bool trace_syscall_enter(struct pt_regs *regs, long *syscall)
> >  {
> > +	long orig_syscall =3D *syscall;
> > +
> >  	trace_sys_enter(regs, *syscall);
> >  	/*
> >  	 * Probes or BPF hooks in the tracepoint may have changed the
> >  	 * system call number. Reread it.
> >  	 */
> >  	*syscall =3D syscall_get_nr(current, regs);
> > -	return *syscall !=3D -1L;
> > +	return *syscall =3D=3D orig_syscall || *syscall !=3D -1L;
> >  }
> > =20
> >  void trace_syscall_exit(struct pt_regs *regs, long ret)
> >
> > does not make #2 magically go away. It's still the same problem whether
> > you like it or not. =20
>=20
> And just to be entirely clear, the syscall() interface has to be correct
> in the first place, but then it's all about performance.
>=20
> So the sequence of:
>=20
>    pt_regs =3D PUSH_REGS();
>    syscall =3D pt_regs->syscall_reg;
>    pt_regs->result =3D -ENOSYS;
>=20
>    arch_syscall(pt_regs, syscall) {
>       if (likely(syscall_enter_from_user_mode(pt_regs, &syscall) {

I guess most architectures inline that to avoid the &syscall.
Otherwise you'd want:
	syscall =3D syscall_enter_from_user_mode(pt_regs, syscall);
with the 'error' return being selected to fail the test below
(which -1L converted to ~0UL will do nicely).

	David

>          if (syscall < SYSCALL_max)
>             pt_regs->result =3D invoke_syscall(pt_regs, syscall);
>       }
>       ,,,,
>    }
>    pt_regs->($RETURN_VALUE) =3D pt_regs->result;
>    POP_REGS();
>    return;
>=20
> is the correct and obviuosly most efficient way idependent of the -1L
> return value overload in the original implementation, which this series
> gets rid of for clarity.
>=20
> If an architecture decide[sd] to do otherwise and makes up it's own rules
> which only cover parts of the problem then it _is_ an architecture
> problem and not something which has to be solved by claiming that every
> architecture has to implement the same nonsense as you falsely claimed
> in your RFC^WPOC^Whack thread:
>=20
>   "However, the API should be specified in a way that does not require
>    everyone implementing such flag."
>=20
> There is _ZERO_ requirement for any architecture to implement that
> flag. Just because S390 decided it's a brilliant idea to do so does not
> make it a requirement for everyone.
>=20
> No. Every other architecture got it right because they looked at the
> historical patterns despite having correct documentation at hand.
>=20
> Feel free to prove me wrong with actual facts.
>=20
> Thanks,
>=20
>         tglx
>=20


