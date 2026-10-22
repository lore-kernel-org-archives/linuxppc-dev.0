Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9236606A33A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2026 19:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5BvSZtD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9bV02qJRz2y2J;
	Fri, 23 Oct 2026 06:16:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792696568;
	cv=none; b=M63cm+jYkDTXwXA80Aspqc95aFA1qLFyO/D0FPEg+VJNZY8eGvdY+BaQ2nf1MtLKhSIsQYCEPZk8bPBwqUSbiSy6mTSbV+w0g8M1Pp8NidElhDfLh0LkZdfqqjF4hisOTFD8qE2Q8U4De/FIUqgbrCIGwrmduciXfmJDbMRJPd/giHZ1C5BbaJaOYh4Ts41y0v+7P4BO5tVzz+4ckbgdCpirC7dZ2aNcDVZQc4L6qwif6a2suj2bBCBP6YudWs8pFL0AwtwBhrD6WYAMNvs2BrO6JqnqbXeEFQNzy/dIcDseZIkYtu+GL2CL3j01d3YIIBuVCAZLX9CRqEFG1QQ7cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792696568; c=relaxed/relaxed;
	bh=zfF/h5yN+JN0JXoERjM1UOmD6YL51qlegqbjQ5IjJaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LEcLk+jIc4pJQvcJa58IsWE4nyNJwdp3J3KjjE+1z1KKtnOmVSXzWIxYsmHvPhADSw4+ABbGViKa6FaPTvQYRPx983jpcSvbowIq8307LQj8oDr1Hr92L4urvwTBDIqKjb4T60u/KjNkocJS2+2rEpQjpAtyQKqf1uFbdJBuTQOJrURSCt37tmGI+Ldeu1v5d04tyMy+xSlKsFFKsbdlu03HlZKBBxn+jFk0MLP6EQAOw+Hsx6/ShI3Cu/sShMaB/NyD5qEOaRJxsfHOGKX1HGuvhSTdXneWV1bCVKBWsNjqh6GFGjQti/m5CfNAaQyK9T4w7vsm6VaagpNW7l2hXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5BvSZtD; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5BvSZtD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9bTz10Dnz2xK7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 06:16:07 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 68628601F8;
	Thu, 22 Oct 2026 19:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE1F1F01825;
	Thu, 22 Oct 2026 19:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792696563;
	bh=zfF/h5yN+JN0JXoERjM1UOmD6YL51qlegqbjQ5IjJaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=N5BvSZtDsOnevI6N7z+hpnuDFwgb+Za20bBfcyPl1zdZ/RUM/vhVGgooCl8EukmyB
	 v951DfxEQIGKmPlqDa47vEV9oOJpjd3jTdFHzFJ8cGbv5Ec+77S428dvBazQLk752d
	 8oijRTx04uvdE5t0WJ3hFRzAydPhPUU1uC5jEb9/jBb3UCG/5+2vXEPMQ0qv3aaJy/
	 fDrmEd5ydsQk2Juig/QI4K6qM7Xm060UN2bTZPYYJFIjTdDkBvnz/aEeUGpDN6dDMG
	 QYnQUY/lk7t3H2ZOK5q9Ex67PolYwOb50JpOTpWf5Zn6NIH8OuYBLaiHmJRlGX+jMg
	 L4eC2BtuFHQ4g==
From: Thomas Gleixner <tglx@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Shrikanth
 Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook
 <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas
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
 linux-arch@vger.kernel.org, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>
Subject: Re: [patch 16/18] x86/entry: Get rid of the sys_ni_syscall()
 indirection
In-Reply-To: <20261022142425.3Wx-RrU5@linutronix.de>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.493733289@kernel.org>
 <20261022142425.3Wx-RrU5@linutronix.de>
Date: Thu, 22 Oct 2026 21:15:59 +0200
Message-ID: <87fqxx1r80.ffs@fw13>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22 2026 at 16:24, Sebastian Andrzej Siewior wrote:
> On 2026-07-07 21:07:01 [+0200], Thomas Gleixner wrote:
>> Invoking sys_ni_syscall() from a code path, which already knows that the
>> syscall number is invalid just to assign -ENOSYS to regs->ax is a pointl=
ess
>> exercise. It's even redundant as the low level entry code already has set
>> regs->ax to -ENOSYS on entry.
>>=20
>> Remove the extra conditionals and the function calls.
>
> Since this patch, tools/testing/selftests/x86/syscall_numbering_64
> throws in this:
> |[RUN]   Running tests under ptrace: modifying the default return
> |[RUN]       Checking system calls with msb =3D 0 (0x0)
> |[RUN]           Checking some common syscalls as 64 bit
> |[OK]                x64 syscall 0:0 returned 0 as expected
> |[OK]                x64 syscall 0:1 returned 0 as expected
> |[RUN]           Checking some 64-bit only syscalls as 64 bit
> |[OK]                x64 syscall 0:19 returned 0 as expected
> |[OK]                x64 syscall 0:20 returned 0 as expected
> |[RUN]           Checking out of range system calls
> |[FAIL]                  x32 syscall 0:-64 returned -9999, but it should =
have returned -ENOSYS
> =E2=80=A6
> |[FAIL]                  x32 syscall 0:-2 returned -9999, but it should h=
ave returned -ENOSYS
> |[FAIL]              x32 syscalls 0:-64..-2 had 63 failure
> |[OK]                x32 syscall 0:-1 returned MODIFIED_BY_PTRACE as expe=
cted
> |[FAIL]                  x64 syscall 0:1073741760 returned -9999, but it =
should have returned -ENOSYS
> =E2=80=A6
> |[FAIL]                  x64 syscall 0:1073741823 returned -9999, but it =
should have returned -ENOSYS
> |[FAIL]              x64 syscalls 0:1073741760..1073741823 had 64 failure
> |[FAIL]                  x64 syscall 0:-64 returned -9999, but it should =
have returned -ENOSYS
> =E2=80=A6
> |[FAIL]                  x64 syscall 0:547 returned -9999, but it should =
have returned -ENOSYS
> |[FAIL]              x64 syscalls 0:512..547 had 36 failure
> |[RUN]           Checking some common syscalls as x32
> |[OK]                x32 syscall 0:0 returned 0 as expected
> =E2=80=A6
> |[RUN]           Checking out of range system calls
> |[FAIL]                  x32 syscall 1:-64 returned -9999, but it should =
have returned -ENOSYS
> |[FAIL]              x32 syscalls 1:-64..-2 had 63 failure
> |[OK]                x32 syscall 1:-1 returned MODIFIED_BY_PTRACE as expe=
cted
> |[FAIL]                  x64 syscall 1:1073741760 returned -9999, but it =
should have returned -ENOSYS
> =E2=80=A6
>
> and so on=E2=80=A6 The test has
>
> | #define MODIFIED_BY_PTRACE      -9999
>
> and the ptracer modifies the return code. However not always. Not sure
> if this was indeed a pointless exercise or not.

Hrmm. That's weird. Let me have a look.

