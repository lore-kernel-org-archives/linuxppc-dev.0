Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 93C58DDE32
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 06:44:45 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [patch 1/9] move 82xx/83xx/86xx Kconfig options to platform
	selection
Date: Wed, 11 Jul 2007 22:33:51 +0200
References: <20070616000511.712667424@arndb.de>
	<20070616000618.183462070@arndb.de>
	<20070711153542.GB11516@mag.az.mvista.com>
In-Reply-To: <20070711153542.GB11516@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707112233.51899.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 11 July 2007, Mark A. Greer wrote:

> > +config CLASSIC32
> > +	def_bool y
> > +	depends on 6xx && PPC_MULTIPLATFORM
> 		       ^^^^^^^^^^^^^^^^^^^^
> Arnd, is this really what you wanted?  With it, none of the embedded
> classics have CLASSIC32 defined which means they don't get TAU or
> ALTIVEC defined which isn't good.

Sorry, this was the result of a wrong patch reordering. In my initial
patch set I ended up with 6xx == CLASSIC32 and PPC_MULTIPLATFORM=y,
but then I backed out a few patches in the middle.

I guess the best is to do another patch that moves PPC_EMBEDDED6xx into
PPC_MULTIPLATFORM again and leaves this one as it is.
Alternatively, we could kill CONFIG_CLASSIC32 entirely as it is used
only in a few places. Especially after I resubmit my CPU type selection
patch again, which allows you do it in a more fine grained way.

Which systems in particular should allow CONFIG_TAU? Is there a more
specific dependency than (6xx && !(82xx || 83xx || 86xx || 52xx))?

	Arnd <><
