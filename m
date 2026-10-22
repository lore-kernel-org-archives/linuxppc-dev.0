Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFFC606A31A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2026 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XVuBmyz9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9fYN6Dw6z2xlZ;
	Fri, 23 Oct 2026 08:34:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792704856;
	cv=none; b=YbFbjjGAZTF8uOe+L1JPEa2WRdiTgR7JCL1Ay8faH7alaZkRSCaQZxEVEGSTlxZuwsrrNY7E3YBuE/swMwGMT6/jbLnOCG8s15Q5AetcyWDd5Zks1w6blUTifkjQSFuxAhGJEHfVbSTG2KP+Eut3Q+7p4vC/Qx2mLbphmucV9d4bKWM+WsKXitk52KVIWq8azncRvi3CQ8iO4wXFvBz8/OHb4oWJXyvzCVC9nQtpNbrx1ufgsMTxHKqZYOGTFd5CPFtINj2s942HItMDuqAG4lqZtZtIQustVr9D269rq631skshWQEs2GPzk4remcLouNzjg4Atmela53PJuASuqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792704856; c=relaxed/relaxed;
	bh=cn/ldllbPOccKT21c7wYmV4T2wO/b1MXRFJD8m7a2a8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Aw8hoKa7bEbLqmFGGHS6RNmZ0ltpxyjxNJGhoO4nE8F47GBk3f/F3KQ3ceI5/OwXjukoBcj8jV93GPdfITKzsQYA5Tdu2+9nvnsG823eK1IysA7pN7gCGZscMdUfrgUkvBi7D7xt9oqKQER1v6D+mirJupma22WrLSve0IL6M0IzsCc0WIGPGPi7u6lI1SRwP3JCt70wsD4PwMb5hfzFALy/OD94vb7x1olygsL7yTMHpZzpUXmG6Fwvic6RtjtuK1gD06LtYn8NdXb9kBmj+A8O6RwfvbG2U87g1oKrObNdFcK1/CMFstHzeucpwJ16/yM8eprJcMwdD7hCLphbtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XVuBmyz9; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XVuBmyz9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9fYM1wJYz2xf8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 08:34:15 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 64430417B6;
	Thu, 22 Oct 2026 21:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470391F01825;
	Thu, 22 Oct 2026 21:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792704852;
	bh=cn/ldllbPOccKT21c7wYmV4T2wO/b1MXRFJD8m7a2a8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XVuBmyz9FPf6yo7k98oYXwvQ2CrUnSJeao5n2AE3SOVv2l8FnxqKfufmW9zVdl1ZU
	 7/jjD7DxhQpzVSSzHcskY8OGVIszVl5rWYnpntfdjYicc8x0Z6/FYO+Wzbi2T5kazo
	 L8wyFIJNbwU+07rXhxkK8jIdHdZ6tDaDdk9OEGeX5P0F2vbBvHawTeck8SVK7xJ13l
	 bLCTcobXnjYr+eT5lvnBYy6PAblfW6x3KhaSIJ+hc3UMxyUpT6D2mZRMwE0YVSvFIV
	 kiuB3v9mM2Wpy9nJrXroSIigc+RYm5nfye7Fnp+zdBjGDGKIQfa7LtzprWk3IcxwgI
	 p4Zzqpbf/Yjeg==
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
In-Reply-To: <87fqxx1r80.ffs@fw13>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.493733289@kernel.org>
 <20261022142425.3Wx-RrU5@linutronix.de> <87fqxx1r80.ffs@fw13>
Date: Thu, 22 Oct 2026 23:34:08 +0200
Message-ID: <87cxt11ktr.ffs@fw13>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22 2026 at 21:15, Thomas Gleixner wrote:
> On Thu, Oct 22 2026 at 16:24, Sebastian Andrzej Siewior wrote:
>> On 2026-07-07 21:07:01 [+0200], Thomas Gleixner wrote:
>> |[RUN]           Checking out of range system calls
>> |[FAIL]                  x32 syscall 1:-64 returned -9999, but it should=
 have returned -ENOSYS
>> |[FAIL]              x32 syscalls 1:-64..-2 had 63 failure
>> |[OK]                x32 syscall 1:-1 returned MODIFIED_BY_PTRACE as exp=
ected
>> |[FAIL]                  x64 syscall 1:1073741760 returned -9999, but it=
 should have returned -ENOSYS
>> =E2=80=A6
>>
>> and so on=E2=80=A6 The test has
>>
>> | #define MODIFIED_BY_PTRACE      -9999
>>
>> and the ptracer modifies the return code. However not always. Not sure
>> if this was indeed a pointless exercise or not.
>
> Hrmm. That's weird. Let me have a look.

So I clearly failed to decode the overloading of the -1L return value
correctly and then failed to run the stupid test.

TBH, this whole thing was a horrid and inconsistent mess.

The logic in the original code was:

    When the entry work code returned an invalid syscall number then the
    return value in regs->ax was set to -ENOSYS, except when the
    returned syscall number was -1. Syscall number "-1" indicated that
    the syscall has to be aborted.

     regs->ax =3D -ENOSYS;
     syscall =3D enter_work(regs, syscall);
     if (syscall_in_range(syscall))
        regs->ax =3D do_syscall(syscall);
     else if (syscall !=3D -1)
        regs->ax =3D -ENOSYS;

So if the ptrace check in enter_work() overwrote regs->ax and the
syscall number (either as supplied by user space or rewritten) was out
of range and not -1 then the x86 entry code overwrote regs->ax to
-ENOSYS again. IOW, there is no distinction between a check induced
abort and a syscall with syscall number -1.

The rework changed the return value to boolean, which is true when the
syscall should be invoked and false when one of the checks requests to
abort the syscall. In that case the return code does not touch the
return value in regs->ax.

If the eventually modified syscall number is out of range then the code
relies on the fact that regs->ax was preset with -ENOSYS, i.e.:

     regs->ax =3D -ENOSYS;
     // True indicates to proceed
     if (enter_work(regs, &syscall)) {
         if (syscall_in_range(syscall))
            regs->ax =3D do_syscall(syscall);
     }

That seems to be equivalent, but it is not when ptrace() modifies
the return value in regs->ax and also rewrites the syscall number to an
invalid value or leaves the user supplied invalid value intact and does
_NOT_ abort the syscall.

So the reworked code does not overwrite the tracer modified return value
with -ENOSYS in that case and returns whatever the tracer decided to put
into it.

TBH, that makes a lot more sense than the original behavior. If the
tracer decides to fiddle with the default return value then that's what
the tracer intended.

That makes the behavior consistent vs. other abort scenarios:

    ptrace()
      regs->ax =3D MAGIC;
      return true;            // Allow syscall

    seccomp()
      return false;          // Abort syscall

So when the tracer modified the return value and seccomp aborts the
syscall then the tracer induced value is preserved. That was the case in
the original code as well because seccomp() indicated the abort by
returning -1 as the modified syscall number. Similar effects when ftrace
(BPF, kprobe) decided to overwrite the syscall number).

Bringing the original behaviour back is trivial enough, but I'm not
convinced that it makes any sense and is worth it. At least this
confines the x32 specific insanity of treating -1 special to x32...

Thanks,

        tglx
---
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -77,6 +77,8 @@ static __always_inline void do_syscall_3
 	if (likely(nr < IA32_NR_syscalls)) {
 		nr =3D array_index_nospec(nr, IA32_NR_syscalls);
 		regs->ax =3D ia32_sys_call(regs, (unsigned int)nr);
+	} else {
+		regs->ax =3D -ENOSYS;
 	}
 }
=20
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -64,15 +64,24 @@ static __always_inline bool do_syscall_x
 	return false;
 }
=20
-static __always_inline void do_syscall_x32(struct pt_regs *regs, unsigned =
long nr)
+static __always_inline bool do_syscall_x32(struct pt_regs *regs, unsigned =
long nr)
 {
+	if (!IS_ENABLED(CONFIG_X86_X32_ABI))
+		return false;
+
+	/* Preserve the historic insanity of treating -1 special on x32 */
+	if (nr =3D=3D ULONG_MAX)
+		return true;
+
 	/* Adjust the starting offset of the table */
 	nr -=3D __X32_SYSCALL_BIT;
=20
-	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(nr < X32_NR_syscalls)) {
+	if (likely(nr < X32_NR_syscalls)) {
 		nr =3D array_index_nospec(nr, X32_NR_syscalls);
 		regs->ax =3D x32_sys_call(regs, (unsigned int)nr);
+		return true;
 	}
+	return false;
 }
=20
 /* Returns true to return using SYSRET, or false to use IRET */
@@ -81,8 +90,10 @@ static __always_inline void do_syscall_x
 	if (likely(syscall_enter_from_user_mode_randomize_stack(regs, &nr))) {
 		instrumentation_begin();
=20
-		if (!do_syscall_x64(regs, nr))
-			do_syscall_x32(regs, nr);
+		if (unlikely(!do_syscall_x64(regs, nr))) {
+			if (!do_syscall_x32(regs, nr))
+				regs->ax =3D -ENOSYS;
+		}
=20
 		instrumentation_end();
 	}











