Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (unknown [63.81.120.158])
	by ozlabs.org (Postfix) with ESMTP id 6F57B67B65
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 07:32:08 +1000 (EST)
Date: Tue, 25 Apr 2006 14:33:33 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: FT u-boot shim
Message-ID: <20060425213333.GA19145@mag.az.mvista.com>
References: <4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<265F73F8-F641-4EDD-B88F-A2B2F7FA1308@kernel.crashing.org>
	<20060425182418.GA1132@gate.ebshome.net>
	<200604251329.35584.bcook@bpointsys.com>
	<248CD1B3-A33B-47F5-AFE8-F7C9DDCD1D0B@kernel.crashing.org>
	<20060425185314.GC1132@gate.ebshome.net>
	<1448E56E-1327-40D5-BE44-0DC103AC3E8A@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448E56E-1327-40D5-BE44-0DC103AC3E8A@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 25, 2006 at 03:00:05PM -0500, Kumar Gala wrote:
> > So, don't break compatibility if you don't have time/interest to fix
> > it. We can wait till someone who "wants to move forward" can do this
> > professionally without screwing everybody else.
> 
> So, lets turn this discussion into something useful (since having us  
> going back and forth about our opinions isn't really going anywhere)
> 
> If we have a u-boot shim there are some questions that need answering:
> * where should the .dts live (hate duplicating the file both in u- 
> boot and kernel source tree)
> * how does build system find .dts
> * a Kconfig option to enable shim
> * assume done as a boot wrapper of sorts

Haven't we always had a shim like layer like this only we called it the
bootwrapper?  IOW, arch/ppc/boot/*...now called arch/powerpc/boot?

FWIW, I'm farting around with a non u-boot platform and, basically, I added
a dts directory under arch/powerpc/boot.  I use dtc to compile a dts file
into a .S file then build the .S file with the normal kernel build (you
could easily do the dtc compile w/ the build as well).  Some minor hacking
of other stuff in the boot dir and it gets the job done.  Its a total
hack right now so I'd rather not give a patch but the point is we
already have a logical place for it and its not that hard.

I know the boot dir is supposed to be moved at some point but it seems
like the logical place to put this functionality until it does move
(and even after it moves).

Mark
