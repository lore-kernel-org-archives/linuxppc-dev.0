Return-Path: <linuxppc-dev+bounces-23455-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FDEC43327
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 21:50:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grrCH4jG1z2xlw;
	Fri, 03 Jul 2026 07:50:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783029003;
	cv=none; b=d8a0ALfReNlSk8AhlaU7JqqIasx/7j8tkNH7sCbcRytT3lgaPm4aHo8FUmT8Cnc/UjOWy6jbCV2EK6YzAU2i12tf9BlGqwdBttLo1LTjLKr1lJlJawR7fon3t3bvfghHazXK8JlKNozISBqeD1cmQ9rnA32IKr8rLmaam14cHDp6kuC042DkGKeao3/UzvKydKjh1g6ngIHTToZE6kjS1rj6XnxjSCVK7sPISxwqjsK5SJr79L8lwSsFDLpeKy+TlSGbksMTW+8R6/NC/LOLW/zs5a4rM10fNU22hHS9y6Io3X12JmGrWeXJfeDgkkoRFM+HsCcoPKcfEUCeA4QZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783029003; c=relaxed/relaxed;
	bh=OR8xOq9dAd26ujiAwVszzOHiLCszARnPiwIaNz5ESn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mgn3YC7FShJRg/qgTNbweGurMgrcnndkSaG5Q9sQuNAkBR+q86rHwAzskV96wmOIzM11ykYwihWzRunQVuRVPYz3rs3h1ibwZwNQ4/83nYjkI4EQm9H101a/jiQzVSwdYPUarHD8YPvXUlv3Y35DwOfZ9S+36+ta8hgST5YxxB8vhxgT2fcuxjB9CnssYppZpKN4RJyKIiqMTQ9QdFtpqytZ+OR07mAOvHjc7LH9/Ecl8q228gaCz7jUWnjJywUpM/Olpo+W499bXWwaS7EDDvqCM0Fh/Z+dzL02bp2uBj86EmqrOtfDZt2GPeQ/LpQhLak1iAZ33G54hmsZPEp8/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+tc+5RH; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+tc+5RH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grrCG2pWmz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 07:50:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 417C7601CA;
	Thu,  2 Jul 2026 21:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229061F000E9;
	Thu,  2 Jul 2026 21:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783028999;
	bh=OR8xOq9dAd26ujiAwVszzOHiLCszARnPiwIaNz5ESn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=B+tc+5RHqY3JoS8BHBFtIs6Ixwb3FHiZW7sw1eSjWzSZOdtdOeiX1LOBPB259SqN0
	 RNu9r3S6UrqNIzSwvlS0ScHYEXZUS4yKPvIEK6KMwjeIWpfxZumCiw9DxB+KO6MQY1
	 ZI5ulAka1rXUJeevOMYAvWilVlf7cswGz3Dxdg/7doTH+m+bgGilYGCAoBXpM2yze+
	 njTHv1m+JV3W3uth459/AznoFJO4beF/j9n/ic34ynDmKQQgBUnWNLxloBHcFS7A8E
	 ikCdHAQgPb2eYut2DcXNxvdCL/QOxh0vGXxjv4Fo+Kn0pYSvtPQluXZyAJPKTejWQ+
	 kdFdgBw5+DLDA==
From: Thomas Gleixner <tglx@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>,
 Peter Zijlstra <peterz@infradead.org>
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
 x86@kernel.org, Andrew Donnellan <andrew+kernel@donnellan.id.au>, Mark
 Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Ryan Roberts <ryan.roberts@arm.com>, Greg
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
In-Reply-To: <BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
 <BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com>
Date: Thu, 02 Jul 2026 23:49:56 +0200
Message-ID: <87h5mhnjsr.ffs@fw13>
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

On Wed, Jul 01 2026 at 11:29, H. Peter Anvin wrote:

Can you please trim your replies? Scrolling through hundred lines of
useless quoted text is just annoying.

> On July 1, 2026 10:42:08 AM PDT, "Michal Such=C3=A1nek" <msuchanek@suse.d=
e> wrote:
>>-static __always_inline long syscall_enter_from_user_mode(struct pt_regs =
*regs, long syscall)
>>+static __always_inline long syscall_enter_from_user_mode(struct pt_regs =
*regs, long *syscall)
>> {
>> 	long ret;
>>

> 1. The type for a system call is int.

That ship has sailed long ago. man syscall ...

> 2. A valid system call number is always going to be positive.

That's true today.

> 3. Bits [30:24] are available for architecture ABI use. The
>    "architecture independent" part of the system call number is therefore
>    24 bits wide.
>
> 4. The exact ABI is platform-specific, obviously, but as a general
>    guideline (especially for new platforms/ABIs) should follow the rules
>    for a platform "int" if practical. Notably, when passing a value in a
>    register larger than 32 bits, which side of the calling interface is
>    responsible for sign-extending a value passed in a register. If caller
>    side, the kernel should validate, if callee side the kernel should
>    ignore the additional bits and do the extension.

The kernel sign expands today already, i.e. for compat syscalls.

> 5. A negative system call number is guaranteed to return -ENOSYS
>    (unless intercepted by seccomp, ptrace, or another mechanism under
>    user space control.)

That's true today.

ASM entry:
       regs->eax =3D -ENOSYS;

C entry:
       nr =3D syscall_enter_from_user_mode(regs, nr);

       if ((unsigned)nr < SYSCALL_MAX)
       	    regs->eax =3D handle_syscall();
       else if (nr !=3D -1)
       	    regs->eax =3D -ENOSYS;

       ....

If seccomp overwrites regs->eax and aborts any syscall (including -1) by
returning -1, then the value seccomp wrote into regs->eax is preserved
and returned to user space.

The same applies for syscall_user_dispatch() and ptrace...() if they
decide to overwrite regs->eax _and_ abort the syscall by letting
syscall_enter_from_user_mode() return -1.

trace_syscall_enter() is not any different. If the magic BPF in there
rewrites the syscall number to -1 then either the original -ENOSYS or
the BPF induced overwrite is returned to user space.

It's less than obvious and I have no objections to clean that up and
make it more intuitive, but I still fail to see what Michal is actually
trying to solve and what the magic flag is for. If s390 requires it,
then that's an s390 problem, but definitely x86 does not.

> 6. If the platform needs to algorithmically modify the system call
>    number due to platform-specific concerns (say, the platform uses a
>    16-bit special purpose register for the syscall number, or it has
>    multiple kernel entry points with different behavior), it should if at
>    all possible transcode the system call number as necessary to match
>    this convention in APIs that are exposed to general kernel code.
>
> For example, in the future I could very much see the IA32 code in the
> x86 kernel using bit 29 internally to indicate an ia32 system call,
> simplifying the is_compat implementation on x86.

I don't see how that makes it simpler. Those are two different entry
code paths and magic bits wont make that go away.

> It should not mean that passing bit 29 to either the syscall
> instruction or int $0x80 will be accepted.

Your proposal looks even more like a solution in search of a problem
than the original one.

Thanks,

        tglx


