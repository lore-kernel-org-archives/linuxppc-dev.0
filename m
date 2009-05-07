Return-Path: <nmiell@comcast.net>
Received: from QMTA11.emeryville.ca.mail.comcast.net
	(qmta11.emeryville.ca.mail.comcast.net [76.96.27.211])
	by ozlabs.org (Postfix) with ESMTP id 06483DDF7F
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 14:32:22 +1000 (EST)
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
From: Nicholas Miell <nmiell@comcast.net>
To: Markus Gutschke =?UTF-8?Q?=28=E9=A1=A7=E5=AD=9F=E5=8B=A4=29?=
	<markus@google.com>
In-Reply-To: <904b25810905061521v62b3ddd6l14deb614d203385a@mail.gmail.com>
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
	<904b25810905061521v62b3ddd6l14deb614d203385a@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 06 May 2009 21:23:57 -0700
Message-Id: <1241670237.11500.7.camel@entropy>
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	stable@kernel.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-05-06 at 15:21 -0700, Markus Gutschke (顧孟勤) wrote:
> On Wed, May 6, 2009 at 15:13, Ingo Molnar <mingo@elte.hu> wrote:
> > doing a (per arch) bitmap of harmless syscalls and replacing the
> > mode1_syscalls[] check with that in kernel/seccomp.c would be a
> > pretty reasonable extension. (.config controllable perhaps, for
> > old-style-seccomp)
> >
> > It would probably be faster than the current loop over
> > mode1_syscalls[] as well.
> 
> This would be a great option to improve performance of our sandbox. I
> can detect the availability of the new kernel API dynamically, and
> then not intercept the bulk of the system calls. This would allow the
> sandbox to work both with existing and with newer kernels.
> 
> We'll post a kernel patch for discussion in the next few days,
> 

I suspect the correct thing to do would be to leave seccomp mode 1 alone
and introduce a mode 2 with a less restricted set of system calls -- the
interface was designed to be extended in this way, after all.

-- 
Nicholas Miell <nmiell@comcast.net>
