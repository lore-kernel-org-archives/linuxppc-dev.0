Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424A3606A31A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=O8Iixtg2
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jB6d3048jz2yDr;
	Sat, 24 Oct 2026 02:39:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792769942;
	cv=none; b=XWwTgZ9FZ3t06lK3+gM96m1mREDf2oHir2gdVBovna0I7pFSA2o6srVK7imOspuG57/rqgABaFfKneuTOgMVH5mTOJNTOUEE0grfQbu1rdGPDliJc/rLDFmOsQzA01dX4IsBPfZVl6pqicG/UbqIWPrZuCXEfua5YpLb49DfkR38EjE7zf4a78k4KBSIX5b52xpOFg0modEX+NBPy/LqtqCIfjCj3WTPGh6qwzfkxFBukH7Xg7JELGgImyzK3lwM5YecBgHWHvShhEuWhnxdOvqWuz/Y+lJRYy05FWd+t64sAmL8dcn/1nS9T4BhSQyc9k51GgSI3o/Tkxl27Zn9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792769942; c=relaxed/relaxed;
	bh=z2qBUDb/HEVpnZ0AdLrT9xxIZXcyNTPm5i0euSKeI8A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=f/9EsCMoVGPJ7w+Dkkw+J2daF4Jeura0vD8njsxycBGfpvyogiBatIQlRFjq0Cy2bxgpxILLKWvJBghHYnTUUhFH1cT5vEFpHZS1xOIlMRSyzAT2duAfOZ4rA/N27hVxRbFwG3g9Dxy3hUAyjHNQJwzL6IYXSqpuHeX70U9ttTvA8yqwvv6PGZ6e8zUI/fs9dbAVZ/EDGBCibNTApLZgDwo34ava+yNbSOLAS/VTHbueEsj2oZOhIX0WSiCEdV8Rkxz9O9y5pC1DBTLzKm6DnNi00vlZSvuQvNw1DxBOvj9gGBhp3EkFV2hgvmms5z6qy25ZrWfo9ktgnL9/LWFLTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com; dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=O8Iixtg2; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org) smtp.mailfrom=zytor.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=O8Iixtg2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zytor.com (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org)
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3::136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jB6d20Wfhz2xKN
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 02:39:01 +1100 (AEDT)
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 69NFc9VP3102952
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 23 Oct 2026 08:38:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 69NFc9VP3102952
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026092801; t=1792769891;
	bh=z2qBUDb/HEVpnZ0AdLrT9xxIZXcyNTPm5i0euSKeI8A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=O8Iixtg27nerxz4pv3MPQ79Qbkly3Qzdhjb7iI4+o56x6i8BSeIR1xQGCwnY7KKaQ
	 QA0Qg7pDBg5vVmC4UggSsNd6S8W3qav0zjBwEGselkJ0VJy5I7ZrNewKIutUb7AfVm
	 MdkVett81Uf9k7w/9M6Vs9Qyoxeec92PLSHDc6Cl9fwDnysLHD8N+1Ef2Jj1dB1Bez
	 Q/DmdOARJu1F614hVTT4HTy48AJ8iHcZSQvZDYXV0Cb5RUaF6zX8Iqu24NZ3rB/QHw
	 a/FnYpSSLXQYPrCSxXHH5/8CUI5QKVmOH3JXCGBKbQtNNmTk/ivswwNpvRE42ECOtx
	 l5XmL1xVvuk2g==
Date: Fri, 23 Oct 2026 08:38:03 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Thomas Gleixner <tglx@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
        Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        =?ISO-8859-1?Q?Michal_Such=E1nek?= <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Bpatch_16/18=5D_x86/entry=3A_Get_rid?=
 =?US-ASCII?Q?_of_the_sys=5Fni=5Fsyscall=28=29_indirection?=
User-Agent: K-9 Mail for Android
In-Reply-To: <87y0boze95.ffs@fw13>
References: <20260707181957.433213175@kernel.org> <20260707190254.493733289@kernel.org> <20261022142425.3Wx-RrU5@linutronix.de> <87fqxx1r80.ffs@fw13> <87cxt11ktr.ffs@fw13> <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com> <871p9g1s3w.ffs@fw13> <87y0boze95.ffs@fw13>
Message-ID: <C6D7BF04-4CF7-48D1-93B5-E80D52C2617D@zytor.com>
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
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On October 23, 2026 7:24:22 AM PDT, Thomas Gleixner <tglx@kernel=2Eorg> wro=
te:
>On Fri, Oct 23 2026 at 15:09, Thomas Gleixner wrote:
>> On Thu, Oct 22 2026 at 17:22, H=2E Peter Anvin wrote:
>> Tired brain misread the test output:
>>
>> [RUN]   Running tests under ptrace: modifying the default return
>> [RUN]       Checking system calls with msb =3D 0 (0x0)
>> [OK]                x32 syscalls 0:-64=2E=2E-2 returned -ENOSYS as expe=
cted
>> [OK]                x32 syscall 0:-1 returned MODIFIED_BY_PTRACE as exp=
ected
>> [OK]                x64 syscalls 0:-64=2E=2E-1 returned -ENOSYS as expe=
cted
>>
>> But that's because the "-1" on x32 is actually 0xFFFFFFFF while on x64
>> it's 0x7FFFFFFF=2E
>>
>> The whole mess comes from using -1 as indicator for syscall abort which
>> is undistinguishable from a syscall(nr=3D-1)=2E
>>
>> Bah=2E Let me restore this nonsense=2E
>
>The real question is how we ended up there=2E By design or as an
>implementation detail which got later set in stone and the selftest was
>written to test the implementation instead of testing against a
>specification=2E
>
>I went back in history and in 2=2E6=2E12 the behavior was for both i386 a=
nd
>x86_64:
>
>  regs->ax =3D -ENOSYS;
>  syscall_trace_enter();
>  if (syscall_nr < MAX)
>  	do_syscall();
>  =2E=2E=2E=2E
>
>IOW, a tracer modification of regs->ax is not overwritten when the
>syscall number is out of range=2E
>
>Between 2=2E6=2E19-rc2 and -rc3 x86_64 was changed to _always_ overwrite
>regs->ax when the syscall number is out of range=2E
>
>In the 3=2E8 merge window seccomp introduced the -1 =3D=3D skip bogosity =
which
>got fixed up and made "consistent" in several changes afterwards=2E Just
>that it never reached a state of consistency due to the overloading=2E
>
>So are we stuck with this behavior or do we sit down and define what the
>correct behavior should be?
>
>Thanks,
>
>        tglx
>
>

Going back on something from 3=2E8 that is actively used seems unwise=2E I=
 fear that that ship sailed a long time ago, even though I hate it just as =
much as you do=2E

