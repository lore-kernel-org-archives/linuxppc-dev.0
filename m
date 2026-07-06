Return-Path: <linuxppc-dev+bounces-23590-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64C9C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 08:17:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtxzP2lyBz3bps;
	Mon, 06 Jul 2026 18:17:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783325825;
	cv=none; b=myTC58yVpJ9Y47JriBQ/XeHHEk2t67Z2HCDMaxvZNIbNZCoFPQTyWbOnwML1Q0O+W5gZmwXG9xGNtD4q2xKXHnNxyZ8QnxwzzgOAKBfuwxHtMmMVdcveFJngWlOWX0EPwQEDhXVsK/aYC8NWl+BbYsM4ViD2iAo77CX6Y7keOwgvzlLAP04ExpO91fpwnlj12JRQdC9pbpwE5zbWPx1AvAe87L0bYxJZk0PsGe8PoS3k9K47eS7gKWoumeDQPT4EW+VQ4GD+HjLKapl+kp/ARKUZWPRUXnFxUUl84xRrsm/xniSt4RKC0J4IK/u935CtHCwNEr5s1Oh8L6Stk0PUhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783325825; c=relaxed/relaxed;
	bh=r7+ah1vbGAvQLsR+3yUG/Iv1avIrbLDskfWMmANIMpA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nybZiSQJz/lovnGNzmP/j2XVyOO0W/NS4poOdpyhJy8rrL6SFOr3CWaPKKxl02b8FZnJd474SdaN4422GaU1nZ6RdqA1GMn1iuAGtGUaehsrmY8X0ye2Hxd+CFeidv0ndpQtxBNFj7hkRArOUwRKgwCjzuS0+frYyzQSOZS20gdAtnQH1NS7K/eowkaFlkjgX83EdcI1zu/uBJp55B2qBIJbCxXNogVN8pTrjIzM++5A5a9TpIdKI/7cRjk272sRYKdFLaTVnsnreLwq9SowQEZwO1J/8GN5yLe630VUgt6Ghm7vnAQx51AXyuXYejVb6N4dmJ6mM9nTlyOZhi0mLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XfC9H2UV; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XfC9H2UV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtxzN3qcnz2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 18:17:04 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 08683600C3;
	Mon,  6 Jul 2026 08:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CF91F000E9;
	Mon,  6 Jul 2026 08:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783325820;
	bh=r7+ah1vbGAvQLsR+3yUG/Iv1avIrbLDskfWMmANIMpA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XfC9H2UVpNQGtHq/xKLEWuvy4dBFo+F8wnT4a3nMjIvGfHuzuoXWCWWpR3IRGACyX
	 ddDWKGu9BP+PsJvxUDK2bd/p/KeWLd0czr6A1n2oiorGfYOAORf0VSj4p8BpzPNLGs
	 Ks/289z7wkXWc1DnJ7LrjlkM5r3LLyPV2aysSVO7Va/BtZrxeY3rlf3iV2jR28XK6V
	 xvP1325V2CnieiUAnTaDerFyvnvz3so5txLMmGU2XfJvoVLUklK5D8L7xrnfvcxkuk
	 3Zu/60IEr5IZRUAZ6W1jaKJhtWOhQgEXUqGG56v4UZ08TQLLk8BNUS0lXkVaayTddt
	 u2lcP/zMPqcAw==
From: Thomas Gleixner <tglx@kernel.org>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>, Peter Zijlstra
 <peterz@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Huacai Chen <chenhuacai@kernel.org>, WANG
 Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Andy
 Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Andrew Donnellan
 <andrew+kernel@donnellan.id.au>, Mark Rutland <mark.rutland@arm.com>,
 Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>, Arnd Bergmann
 <arnd@arndb.de>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Ryan Roberts <ryan.roberts@arm.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mukesh Kumar Chaurasiya
 <mkchauras@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Zong
 Li <zong.li@sifive.com>, Nam Cao <namcao@linutronix.de>, Deepak Gupta
 <debug@rivosinc.com>, Lukas Gerlach <lukas.gerlach@cispa.de>, Rui Qi
 <qirui.001@bytedance.com>, Kees Cook <kees@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [RFC] entry: Untangle the return value of
 syscall_enter_from_user_mode from syscall NR
In-Reply-To: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
Date: Mon, 06 Jul 2026 10:16:57 +0200
Message-ID: <87ik6sjzwm.ffs@fw13>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01 2026 at 19:42, Michal Such=C3=A1nek wrote:
>=20=20
>  	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
> -		syscall =3D trace_syscall_enter(regs, syscall);
> +		*syscall =3D trace_syscall_enter(regs, *syscall);
>=20=20
> -	syscall_enter_audit(regs, syscall);
> +	syscall_enter_audit(regs, *syscall);
>=20=20
> -	return ret ? : syscall;
> +	return 0;

That breaks trace_syscall_enter() because the probes/BPF muck attached
ot that can:

     1) set the return code
     2) set syscall to -1L

That works correctly today, but with your sloppy hackery the low level
x86 code falls into sys_ni_syscall() which sets the return code to
-ENOSYS.


