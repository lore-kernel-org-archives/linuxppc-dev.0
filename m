Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id A0ACCDDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 09:44:47 +1000 (EST)
Date: Wed, 11 Jul 2007 16:47:09 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 1/9] move 82xx/83xx/86xx Kconfig options to platform
	selection
Message-ID: <20070711234709.GB18386@mag.az.mvista.com>
References: <20070616000511.712667424@arndb.de>
	<20070616000618.183462070@arndb.de>
	<20070711153542.GB11516@mag.az.mvista.com>
	<200707112233.51899.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200707112233.51899.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 11, 2007 at 10:33:51PM +0200, Arnd Bergmann wrote:
> On Wednesday 11 July 2007, Mark A. Greer wrote:
> 
> > > +config CLASSIC32
> > > +	def_bool y
> > > +	depends on 6xx && PPC_MULTIPLATFORM
> > 		       ^^^^^^^^^^^^^^^^^^^^
> > Arnd, is this really what you wanted?  With it, none of the embedded
> > classics have CLASSIC32 defined which means they don't get TAU or
> > ALTIVEC defined which isn't good.
> 
> Sorry, this was the result of a wrong patch reordering. In my initial
> patch set I ended up with 6xx == CLASSIC32 and PPC_MULTIPLATFORM=y,
> but then I backed out a few patches in the middle.

Ah, okay.

> I guess the best is to do another patch that moves PPC_EMBEDDED6xx into
> PPC_MULTIPLATFORM again and leaves this one as it is.
> Alternatively, we could kill CONFIG_CLASSIC32 entirely as it is used
> only in a few places. Especially after I resubmit my CPU type selection
> patch again, which allows you do it in a more fine grained way.

Yes, it seems like getting rid of CLASSIC32 would be okay since it is
hardly used.

> Which systems in particular should allow CONFIG_TAU? Is there a more
> specific dependency than (6xx && !(82xx || 83xx || 86xx || 52xx))?

I think Segher pretty much answered this.  We definitely need to get
ALTIVEC back soon for 74xx--currently SIGILL's my init when booting.
Since it sounds like you're still tweaking things in Kconfig files,
I'll leave it to you to take care of it.  If not, just let me know.

Mark
