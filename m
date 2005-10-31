Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id C6B5A68604
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Oct 2005 20:31:15 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 31 Oct 2005 11:31:09 +0200
References: <20051028203727.76C2C353E3E@atlas.denx.de>
In-Reply-To: <20051028203727.76C2C353E3E@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510311031.09522.david.jander@protonic.nl>
Subject: Re: Kernel 2.6 on MPC8xx performance trouble...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 28 October 2005 22:37, Wolfgang Denk wrote:
>[...]
> > They are just integers with fixed start values. These are in the loop, so
> > it's not an empty loop and hopefully the compiler won't out-optimize it
> > so easily (that is of course without specifying any optimization flags).
> > Please don't tell me it's a lousy benchmark, because I already know that!
> > Be it as lousy as it is, I shouldn't get _those_ results IMHO.
>
> Indeed, you should not get such results.  If  you  compare  with  the
> lmbench  results  of  our 2.4/2.6 comparison, you will notice that we
> did NOT see such behaviour. There was a  perfromnce  degradation  for
> pure  integer tests, due to increased system overhead, but far from a
> factor of 2.
> See http://www.denx.de/wiki/pub/Know/Linux24vs26/lmbench_results

I have seen them, and my conclusion is: Your kernel was working ok, while 
mine, a newer one, is broken. 
As you can see in the other e-mail I just posted (replying to Marcelo), at 
least the CPU cache seems to be disabled. Might this have something to do 
with processor model (mis-) identification?
I had to apply the "ppc_sys: do not BUG if system ID is unknown" patch from 
Marcelo Tosatti a few days back in order to be able to boot in the first 
place. I had a look at ppc_sys system identification for 8xx and it looked a 
little bit nonsensical to me, since all 8xx report the same ID. Maybe the 
intention was to set the ID "by hand" in board support and setup.
Problem is: there is still no real board-support infrastructure for mpc8xx, 
like there is for mpc82xx for example. What are the plans for 8xx? Should I 
try to emulate what others have done for some PQ2 platforms, i.e. create a 
arch/ppc/platforms/myplatform.c file and implement board_init()?

Greetings,

-- 
David Jander
Protonic Holland.
