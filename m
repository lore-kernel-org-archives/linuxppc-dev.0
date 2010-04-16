Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5673FB7D41
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Apr 2010 11:58:28 +1000 (EST)
Subject: Re: linux-next: PowerPC WARN_ON_ONCE() after merge of the final
	tree (tip related)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20100414.235557.123118153.davem@davemloft.net>
References: <20100415161214.04637496.sfr@canb.auug.org.au>
	<20100415064940.GA9240@elte.hu>
	<20100414.235557.123118153.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 16 Apr 2010 11:56:56 +1000
Message-ID: <1271383016.13059.173.camel@pasglop>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, peterz@infradead.org, fweisbec@gmail.com,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	hpa@zytor.com, mingo@elte.hu, linuxppc-dev@lists.ozlabs.org,
	tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-04-14 at 23:55 -0700, David Miller wrote:
> From: Ingo Molnar <mingo@elte.hu>
> Date: Thu, 15 Apr 2010 08:49:40 +0200
> 
> > Btw., WARN_ON trapping on PowerPC is clearly a PowerPC bug - there's a good 
> > reason we have WARN_ON versus BUG_ON - it should be fixed.
> 
> I disagree, an implementation should be allowed to use the most
> efficient implementation possible for both interfaces.

Right, and I don't think the reason why we have WARN_ON vs. BUG_ON ever
had anything to do with whether it's implemented with a trap or not :-) 

It's purely related to whether it's supposed to be fatal or not. Now,
there is indeed the potential problem you mention of WARN_ON being
called in places where such a trap is unsafe, but so far, this is the
first time I can remember we hit that problem so we've been getting away
with it for quite a while :-)

Now, whether the trap is or is not more efficient than an explicit test
is something that is still being debated on powerpc. It has the
advantage of not un-leafing functions (and thus not creating stack
frames, adding register reloads, etc... when not needed), basically
putting the burden of saving/restoring registers to the (hopefully) rare
path of actually taking the WARN/BUG.

We could probably manufacture something similar with careful use of
inline asm and an out of line asm trampoline.

The benefit of the trap instruction vs. conditional branches per-se is
probably nil. It's really more about the codegen impact, register
clobber due to the added function call, etc.. at least for us.

Cheers,
Ben.

> I would be using traps for both on sparc64 if that were really
> feasible on sparc64 (and actually with gcc-4.5's "asm goto" it might
> actually be now)
> 
> The WARN and BUG macros, when implemented without traps, have serious
> implications for overall code size and register pressure.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
