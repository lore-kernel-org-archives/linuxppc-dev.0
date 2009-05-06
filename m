Return-Path: <markus@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.33.17])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 923E7DDDF0
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 07:46:11 +1000 (EST)
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
	by smtp-out.google.com with ESMTP id n46Lk4vW025777
	for <linuxppc-dev@ozlabs.org>; Wed, 6 May 2009 22:46:05 +0100
Received: from gxk21 (gxk21.prod.google.com [10.202.11.21])
	by zps37.corp.google.com with ESMTP id n46Lju6N006282
	for <linuxppc-dev@ozlabs.org>; Wed, 6 May 2009 14:46:03 -0700
Received: by gxk21 with SMTP id 21so426278gxk.23
	for <linuxppc-dev@ozlabs.org>; Wed, 06 May 2009 14:46:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090506212913.GC4861@elte.hu>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	<20090228030413.5B915FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	<alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	<20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
	<904b25810905061146ged374f2se0afd24e9e3c1f06@mail.gmail.com>
	<20090506212913.GC4861@elte.hu>
Date: Wed, 6 May 2009 14:46:02 -0700
Message-ID: <904b25810905061446m73c42040nfff47c9b8950bcfa@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
From: =?UTF-8?B?TWFya3VzIEd1dHNjaGtlICjpoaflrZ/li6Qp?= <markus@google.com>
To: Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain; charset=UTF-8
Cc: linux-mips@linux-mips.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	stable@kernel.org, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 6, 2009 at 14:29, Ingo Molnar <mingo@elte.hu> wrote:
> That's a pretty interesting usage. What would be fallback mode you
> are using if the kernel doesnt have seccomp built in? Completely
> non-sandboxed? Or a ptrace/PTRACE_SYSCALL based sandbox?

Ptrace has performance and/or reliability problems when used to
sandbox threaded applications due to potential race conditions when
inspecting system call arguments. We hope that we can avoid this
problem with seccomp. It is very attractive that kernel automatically
terminates any application that violates the very well-defined
constraints of the sandbox.

In general, we are currently exploring different options based on
general availability, functionality, and complexity of implementation.
Seccomp is a good middle ground that we expect to be able to use in
the medium term to provide an acceptable solution for a large segment
of Linux users. Although the restriction to just four unfiltered
system calls is painful.

We are still discussing what fallback options we have, and they are
likely on different schedules.

For instance, on platforms that have AppArmor or SELinux, we might be
able to use them as part of our sandboxing solution. Although we are
still investigating whether they meet all of our needs.


Markus
