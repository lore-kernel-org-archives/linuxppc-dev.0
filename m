Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F115CDDE19
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 07:56:27 +1000 (EST)
Date: Wed, 6 May 2009 23:54:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Markus Gutschke =?utf-8?B?KOmhp+Wtn+WLpCk=?= <markus@google.com>
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
Message-ID: <20090506215450.GA9537@elte.hu>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	<20090228030413.5B915FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	<alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	<20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
	<904b25810905061146ged374f2se0afd24e9e3c1f06@mail.gmail.com>
	<20090506212913.GC4861@elte.hu>
	<904b25810905061446m73c42040nfff47c9b8950bcfa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <904b25810905061446m73c42040nfff47c9b8950bcfa@mail.gmail.com>
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


* Markus Gutschke (顧孟勤) <markus@google.com> wrote:

> On Wed, May 6, 2009 at 14:29, Ingo Molnar <mingo@elte.hu> wrote:
> > That's a pretty interesting usage. What would be fallback mode you
> > are using if the kernel doesnt have seccomp built in? Completely
> > non-sandboxed? Or a ptrace/PTRACE_SYSCALL based sandbox?
> 
> Ptrace has performance and/or reliability problems when used to 
> sandbox threaded applications due to potential race conditions 
> when inspecting system call arguments. We hope that we can avoid 
> this problem with seccomp. It is very attractive that kernel 
> automatically terminates any application that violates the very 
> well-defined constraints of the sandbox.
> 
> In general, we are currently exploring different options based on 
> general availability, functionality, and complexity of 
> implementation. Seccomp is a good middle ground that we expect to 
> be able to use in the medium term to provide an acceptable 
> solution for a large segment of Linux users. Although the 
> restriction to just four unfiltered system calls is painful.

Which other system calls would you like to use? Futexes might be 
one, for fast synchronization primitives?

	Ingo
