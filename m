Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DBD0B67A6E
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Mar 2005 23:24:14 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jey8che16m.fsf@sykes.suse.de>
References: <jed5tuqlp1.fsf@sykes.suse.de>
	<1111377588.3835.258.camel@gaston>  <jey8che16m.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Mon, 21 Mar 2005 23:22:58 +1100
Message-Id: <1111407779.1236.272.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Wakeup broken on iBook G3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-03-21 at 11:35 +0100, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > What video chip is this ?
> 
> Radeon Mobility M7 LY
> 
> > And what CPU ?
> 
> 750FX
> 
> > Are you sure it's the radeonfb patch ?
> 
> It's hard to tell.  I tried going back to the 2.6.10 radeon driver, but
> that doesn't have the necessary hooks to tell the PM code that it can
> sleep.  If you can give a hint how to forward port that I can give it a
> try.
> 
> > There is also an old problem with AGP and sleep that is coming & going
> > lately. Can you check if it works if you never go to X ?
> 
> Did that, same problem.

Can you try playing with pmac_sleep.S and pmac_cache.S, basically
reverting those including the calls to set_L2CR in via-pmu.c ?

Ben.
