Return-Path: <markus@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.33.17])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE73BDDF9A
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 08:08:47 +1000 (EST)
Received: from wpaz37.hot.corp.google.com (wpaz37.hot.corp.google.com
	[172.24.198.101]) by smtp-out.google.com with ESMTP id n46M8g1G011739
	for <linuxppc-dev@ozlabs.org>; Wed, 6 May 2009 23:08:43 +0100
Received: from gxk6 (gxk6.prod.google.com [10.202.11.6])
	by wpaz37.hot.corp.google.com with ESMTP id n46M8fJ8017502
	for <linuxppc-dev@ozlabs.org>; Wed, 6 May 2009 15:08:41 -0700
Received: by gxk6 with SMTP id 6so829011gxk.6
	for <linuxppc-dev@ozlabs.org>; Wed, 06 May 2009 15:08:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090506215450.GA9537@elte.hu>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	<20090228030413.5B915FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	<alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	<20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
	<904b25810905061146ged374f2se0afd24e9e3c1f06@mail.gmail.com>
	<20090506212913.GC4861@elte.hu>
	<904b25810905061446m73c42040nfff47c9b8950bcfa@mail.gmail.com>
	<20090506215450.GA9537@elte.hu>
Date: Wed, 6 May 2009 15:08:40 -0700
Message-ID: <904b25810905061508n6d9cb8dbg71de5b1e0332ede7@mail.gmail.com>
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

On Wed, May 6, 2009 at 14:54, Ingo Molnar <mingo@elte.hu> wrote:
> Which other system calls would you like to use? Futexes might be
> one, for fast synchronization primitives?

There are a large number of system calls that "normal" C/C++ code uses
quite frequently, and that are not security sensitive. A typical
example would be gettimeofday(). But there are other system calls,
where the sandbox would not really need to inspect arguments as the
call does not expose any exploitable interface.

It is currently awkward that in order to use seccomp we have to
intercept all system calls and provide alternative implementations for
them; whereas we really only care about a comparatively small number
of security critical operations that we need to restrict.

Also, any redirected system call ends up incurring at least two
context switches, which is needlessly expensive for the large number
of trivial system calls. We are quite happy that read() and write(),
which are quite important to us, do not incur this penalty.


Markus
