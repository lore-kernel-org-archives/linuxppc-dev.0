Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 426D3DDF26
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 03:10:27 +1100 (EST)
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by fallback.mail.elte.hu with esmtp (Exim) id 1JcirA-00035q-T7
	from <mingo@elte.hu>
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 16:08:32 +0100
Date: Fri, 21 Mar 2008 16:07:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 6/8] ptrace: arch_ptrace -ENOSYS return
Message-ID: <20080321150734.GD1545@elte.hu>
References: <20080319211714.8B14226F995@magilla.localdomain>
	<20080319212024.EA03126F995@magilla.localdomain>
	<alpine.LFD.1.00.0803191935080.3020@woody.linux-foundation.org>
	<20080320081658.0B23826F995@magilla.localdomain>
	<alpine.LFD.1.00.0803210744470.3020@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.1.00.0803210744470.3020@woody.linux-foundation.org>
Cc: linux-arch@vger.kernel.org, tony.luck@intel.com, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Roland McGrath <roland@redhat.com>,
	Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > The reason I took the approach I did instead is incrementalism. I 
> > can't change that signature without breaking about 22 arch builds.
> 
> Don't worry about the arch builds. If that's your main worry and 
> reason for this, it's not worth it. Yes, ptrace changes, and yes, we 
> may have arch issues, but no, it's not that big of a deal. Just break 
> them.
> 
> Make sure x86[-64] works, and make sure that other architectures *can* 
> work (and explain it on linux-arch) when you have to fix something up, 
> but ptrace is a blip on the radar for people, it's not going to be a 
> huge issue.

for a long time all the nice but intrusive utrace improvements from 
Roland had this big adoption barrier. So Roland went around that and 
with a lot of effort he made it optional, incremental and per arch, so 
that we could try it on x86 and merge it upstream.

Now that we see how cleaner it is and that it actually was an almost 
regression-free endevour on x86 (we had 2 regressions so far, both fixed 
- which is an amazing feat for such wide changes IMO), i very much agree 
that we should just do the "rest" of this in one big step.

it's a bit of a chicken & egg problem for such changes. If it breaks 
architectures it gets dropped out of -mm - even though 90% of our 
developers, 95% of our testers and 99% of our active users are using x86 
only.

but in general, prototyping something on a single architecture in the 
first step is OK - and maybe even the first merge is OK. But once it has 
been proven on the most tested Linux platform that we have (and there's 
no blatant x86-ism in it), there's no reason not to mandate it.

	Ingo
