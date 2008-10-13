Return-Path: <scottwood@freescale.com>
Date: Mon, 13 Oct 2008 10:20:28 -0500
From: Scott Wood <scottwood@freescale.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: performance: memcpy vs. __copy_tofrom_user
Message-ID: <20081013152028.GA18639@ld0162-tx32.am.freescale.net>
References: <48ECC611.3030309@mikroswiat.pl>
	<20081008154212.GA21723@secretlab.ca>
	<18669.28058.495259.72182@cargo.ozlabs.ibm.com>
	<48EDD905.6070609@mikroswiat.pl>
	<18669.58803.48011.686743@cargo.ozlabs.ibm.com>
	<48EE2553.30903@genesi-usa.com> <1223764226.8157.182.camel@pasglop>
	<48F15B7D.3060608@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48F15B7D.3060608@genesi-usa.com>
Cc: Dominik Bozek <domino@mikroswiat.pl>, linuxppc-embedded@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Oct 11, 2008 at 09:05:49PM -0500, Matt Sealey wrote:
> Benjamin Herrenschmidt wrote:
> >The reason where we require a -real-good- reason to do it is
> >simply because of the drawbacks. The cost of enabling altivec
> >in the kernel can be high (especially if the user is using it)
> >and it's not context switched for kernel code (just like the
> >FPU) for obvious performance reasons. Thus any use of altivec in the
> >kernel must be done within non-preemptible sections, which can
> >cause higher latencies in preemptible kernels.

It doesn't need to be done in non-preemptible sections, if you have a
separate per-thread save area for kernel fp/altivec use (and appropriate
flags so an FP unavailable handler knows which regs to restore), and you
can avoid using it in a preempting context.

In a realtime-configured kernel, preempting contexts should be fairly
minimal, so the loss of altivec use is not of critical performance impact
(other than one branch to determine if it can be used).

In a throughput-configured kernel, do it as you described (disable
preemption), and be able to use altivec memcpy in interrupt handlers, and
reduce the thread size.

> Would the examples (page copy, page clear) be an okay place to do it?
> These sections can't be preempted anyway (right?),

Why can't they be preempted?

-Scott
