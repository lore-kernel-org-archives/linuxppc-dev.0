Return-Path: <roland@redhat.com>
Received: from QMTA05.westchester.pa.mail.comcast.net
	(qmta05.westchester.pa.mail.comcast.net [76.96.62.48])
	by ozlabs.org (Postfix) with ESMTP id E3B86DDF6B
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 10:36:12 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -mm 1/4] powerpc copy_siginfo_from_user32
In-Reply-To: Andrew Morton's message of  Thursday, 13 March 2008 14:35:10 -0700
	<20080313143510.9cfb7ab4.akpm@linux-foundation.org>
References: <20080313083107.8BDE926F992@magilla.localdomain>
	<20080313143510.9cfb7ab4.akpm@linux-foundation.org>
Message-Id: <20080313233601.E413226F9A4@magilla.localdomain>
Date: Thu, 13 Mar 2008 16:36:01 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	anton@samba.org, mingo@elte.hu, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This is advertised as a -mm patch but afacit it isn't against -mm.  And it
> doesn't seem to be against mainline either?  At least, the fourth patch
> fails to apply.

Oops, sorry for the bad labeling.  The baseline I used was actually x86/mm.
(This was originally going to be just some x86_64 cleanups destined for
post-2.6.25, before I noticed that powerpc had issues.)

> When trying to apply the fourth patch to -mm I hit a reject due to the new
> BTS support in git-x86.  I stopped there because the patch might be invalid
> because of this.

The only differences for that stuff should be to pass any new BTS requests
through to arch_ptrace as is done for e.g. PTRACE_GET_THREAD_AREA.  I'll
admit I tried not to think about that since it's disabled now and still in
so much flux.

> Even though this appears to be a signal-related patch it is actually
> ptrace-related, yes?

It is a prerequisite for ptrace cleanups/fixes, yes.  The change does not
affect any signals code behavior.  It may also be useful for other generic
signals compat code later (though I haven't looked into that yet).  I'd
call it "compat-related" really.

> This patch is a prerequisite for "ptrace: compat_ptrace_request siginfo",
> but this patch is independent from that patch (and from all others) and
> hence this patch can be merged on its own into powerpc tree if we wish to
> go that way, yes?  

Yes.

> Anwyay, please help me out with the dependencies here, and take a look at
> the x86 BTS stuff?

2/4 depends on 1/4 for powerpc64 to keep building.
3/4 depends on 2/4 for x86_64 kernel's 32-bit ptrace calls to keep working.
4/4 depends on 3/4 for same.

I've become fairly confused about the various trees and the state of the
ill-fated BTS code.  It's hard to figure out when it's coming and going
from where lately.  But resolving the actual code bits in any conflicts
with that will be trivial.


Thanks,
Roland
