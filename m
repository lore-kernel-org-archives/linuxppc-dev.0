Return-Path: <markus@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.33.17])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C848BDDF96
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 08:21:58 +1000 (EST)
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
	by smtp-out.google.com with ESMTP id n46MLrDa018522
	for <linuxppc-dev@ozlabs.org>; Wed, 6 May 2009 23:21:54 +0100
Received: from yw-out-2324.google.com (ywj3.prod.google.com [10.192.10.3])
	by zps37.corp.google.com with ESMTP id n46MLM86013140
	for <linuxppc-dev@ozlabs.org>; Wed, 6 May 2009 15:21:52 -0700
Received: by yw-out-2324.google.com with SMTP id 3so372225ywj.49
	for <linuxppc-dev@ozlabs.org>; Wed, 06 May 2009 15:21:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090506221319.GA11493@elte.hu>
References: <20090228030413.5B915FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	<20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
	<904b25810905061146ged374f2se0afd24e9e3c1f06@mail.gmail.com>
	<20090506212913.GC4861@elte.hu>
	<904b25810905061446m73c42040nfff47c9b8950bcfa@mail.gmail.com>
	<20090506215450.GA9537@elte.hu>
	<904b25810905061508n6d9cb8dbg71de5b1e0332ede7@mail.gmail.com>
	<20090506221319.GA11493@elte.hu>
Date: Wed, 6 May 2009 15:21:51 -0700
Message-ID: <904b25810905061521v62b3ddd6l14deb614d203385a@mail.gmail.com>
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

On Wed, May 6, 2009 at 15:13, Ingo Molnar <mingo@elte.hu> wrote:
> doing a (per arch) bitmap of harmless syscalls and replacing the
> mode1_syscalls[] check with that in kernel/seccomp.c would be a
> pretty reasonable extension. (.config controllable perhaps, for
> old-style-seccomp)
>
> It would probably be faster than the current loop over
> mode1_syscalls[] as well.

This would be a great option to improve performance of our sandbox. I
can detect the availability of the new kernel API dynamically, and
then not intercept the bulk of the system calls. This would allow the
sandbox to work both with existing and with newer kernels.

We'll post a kernel patch for discussion in the next few days,


Markus
