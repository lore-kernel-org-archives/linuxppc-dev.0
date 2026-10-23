Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C898C606A31A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=bg3EdVPh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jB6ZT6NQZz2yDr;
	Sat, 24 Oct 2026 02:36:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792769809;
	cv=none; b=AZ1aTbVssKxJCeBl5e8AkMD6vbQRGxUMETned0IxKVvgrVRYZl9jeMTqach/gfK+kn3mqZH2Ie8XENMDQSXN6iDWYX2VEuUTL85UD9Rofc92GjZwsEDIaHmpw/bapL5FHHqj7f0XQwdEXpFFl9mvpTrRRhk4iiBejCSMGiV+2hSLZkctIHYTbuyT0Q0PFcJ1THGm/C7aqs1jGpuCmCMkqzFy1nMEi0T1LdhiH7biaQlmAYZgEKKrlFYtoTLIb0RhEE+7yVE7rGY451Jyg3yerX1Mc1AaKIQQkXtzxUXJY0Km5xHU/oF9r9JNPwv9Pqd/G1A/h5GnKhE8x1mKm7cYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792769809; c=relaxed/relaxed;
	bh=HSZuOyG4pKU7vS7IAE1/JM7GV7AMLK9kKAml8a9XFjg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=E/rHhK6O6E+d/IC2Rw3WDO1FvccY8WQMiHlbUaiJ6WXHBMboQV4cFZMTkvGnJ2A9qoMDkX5rVLROUpySNlz9xwTSZl8xbZtd3PT23Mei/lJ3I9zVvQ7QHZbSuzWKmCLegwcaxBZWMnF02exnXrYEyIBr21jZdtYK0KCTQYhgojnO2/ixdlP/1ObSVpgkeGQCBf9mO/3SS5TPLCnIRkoKL+1ivlcnEhn18VrXzR6w+doTOqpT5+dMuERqDxDf8Tuud8Fc8oTQo4AAoMrlNS7wSpnXUuLbmNd0cPht0VvaJHxpDVeJ/DaWvhsSOVPrGAtQX7XUoX8dT/nT9EilYTynQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com; dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=bg3EdVPh; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org) smtp.mailfrom=zytor.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=bg3EdVPh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zytor.com (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org)
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3::136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jB6ZR4fRnz2xHG
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 02:36:46 +1100 (AEDT)
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 69NFZXZ03099269
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 23 Oct 2026 08:35:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 69NFZXZ03099269
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026092801; t=1792769740;
	bh=HSZuOyG4pKU7vS7IAE1/JM7GV7AMLK9kKAml8a9XFjg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=bg3EdVPhWbIzGb2nl9Fuu7ddKA32ap1IfMZqOW5ffhrypmSKfeUyH9oyqT8VD3Ffz
	 xZsox0txpA5nJa7ukTQnYEsijMIDw9G5ZjUIZiWIb+27Pyu0RsP3R+zGiaKYe7BVy+
	 iRxHHbQf4iwE7FhJHOTs1QJ5w9pUe7E5sHjmWhEmmReaob00Q9qPt+SYyK9PjSybeL
	 +p7u2wZEoGsZue51CvFVoyMDBkPLzVTCMehBpRAesG0upThtigcmczDR9dlEcb9c41
	 ORCX4s+3pvA5/OOHfkjvkVcTf9EC4bUg2TYV5h1Rs0daKiD/q8yN03OHv7o44uTkJq
	 IP7H4102peo1g==
Date: Fri, 23 Oct 2026 08:35:29 -0700
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
In-Reply-To: <871p9g1s3w.ffs@fw13>
References: <20260707181957.433213175@kernel.org> <20260707190254.493733289@kernel.org> <20261022142425.3Wx-RrU5@linutronix.de> <87fqxx1r80.ffs@fw13> <87cxt11ktr.ffs@fw13> <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com> <871p9g1s3w.ffs@fw13>
Message-ID: <F44B99C1-297F-406C-AEAC-3CC8F4F36AED@zytor.com>
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

On October 23, 2026 6:09:07 AM PDT, Thomas Gleixner <tglx@kernel=2Eorg> wro=
te:
>On Thu, Oct 22 2026 at 17:22, H=2E Peter Anvin wrote:
>> On October 22, 2026 2:34:08 PM PDT, Thomas Gleixner <tglx@kernel=2Eorg>=
 wrote:
>>>-static __always_inline void do_syscall_x32(struct pt_regs *regs, unsig=
ned long nr)
>>>+static __always_inline bool do_syscall_x32(struct pt_regs *regs, unsig=
ned long nr)
>>> {
>>>+	if (!IS_ENABLED(CONFIG_X86_X32_ABI))
>>>+		return false;
>>>+
>>>+	/* Preserve the historic insanity of treating -1 special on x32 */
>>>+	if (nr =3D=3D ULONG_MAX)
>>>+		return true;
>>
>> It was never limited to x32=2E=2E=2E
>
>Tired brain misread the test output:
>
>[RUN]   Running tests under ptrace: modifying the default return
>[RUN]       Checking system calls with msb =3D 0 (0x0)
>[OK]                x32 syscalls 0:-64=2E=2E-2 returned -ENOSYS as expect=
ed
>[OK]                x32 syscall 0:-1 returned MODIFIED_BY_PTRACE as expec=
ted
>[OK]                x64 syscalls 0:-64=2E=2E-1 returned -ENOSYS as expect=
ed
>
>But that's because the "-1" on x32 is actually 0xFFFFFFFF while on x64
>it's 0x7FFFFFFF=2E
>
>The whole mess comes from using -1 as indicator for syscall abort which
>is undistinguishable from a syscall(nr=3D-1)=2E
>
>Bah=2E Let me restore this nonsense=2E
>
>Thanks,
>
>        tglx
>
>
>

Yeah, that was always a WTF=2E

