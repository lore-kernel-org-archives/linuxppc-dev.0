Return-Path: <scottwood@freescale.com>
Date: Tue, 14 Oct 2008 10:10:41 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: performance: memcpy vs. __copy_tofrom_user
Message-ID: <20081014151041.GB12934@ld0162-tx32.am.freescale.net>
References: <48EDD905.6070609@mikroswiat.pl>
	<18669.58803.48011.686743@cargo.ozlabs.ibm.com>
	<48EE2553.30903@genesi-usa.com> <1223764226.8157.182.camel@pasglop>
	<48F15B7D.3060608@genesi-usa.com>
	<20081013152028.GA18639@ld0162-tx32.am.freescale.net>
	<1223931027.8157.272.camel@pasglop>
	<48F3B7A2.3010004@freescale.com> <48F40077.5060003@genesi-usa.com>
	<1223951959.8157.318.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1223951959.8157.318.camel@pasglop>
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

On Tue, Oct 14, 2008 at 01:39:19PM +1100, Benjamin Herrenschmidt wrote:
> So again, let's start by having somebody pick up something that you
> believe is worth altivec-ifying, eat the preempt_disable/enable for now,
> and if we see that indeed, it's worth the pain, then we can look into
> adding a way to context switch altivec in a kernel thread upon explicit
> request or something like that.

Of course -- my suggestion was predicated on the outcome that the
benchmarks do justify it, and was just pointing out that there's no real
need to disable preemption.

BTW, it's actually simpler than I originally described (I had implemented
this years ago in the TimeSys kernel for x86 and some other arches that
already use FP or similar resources for memcpy, but the memory was a
little fuzzy); the FP restore code doesn't need to test anything, it
always restores from the regular spot.  The kernel code wishing to use FP
saves the user context in an alternate save area (it could even be on the
stack, allowing atomic context to use it as well, if it's not too large),
and restores it when it's done.

-Scott
