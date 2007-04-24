Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id DC843DDEF6
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 09:04:58 +1000 (EST)
Date: Tue, 24 Apr 2007 18:04:50 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] pasemi: Kconfig for mdio_gpio
Message-ID: <20070424230450.GA10357@lixom.net>
References: <20070424175834.GA7985@lixom.net>
	<200704242353.07286.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200704242353.07286.arnd@arndb.de>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 24, 2007 at 11:53:06PM +0200, Arnd Bergmann wrote:
> On Tuesday 24 April 2007, Olof Johansson wrote:
> > +config PPC_PASEMI_MDIO
> > +???????depends on PPC_PASEMI
> > +???????bool "MDIO support via GPIO"
> > +???????default y
> > +???????select PHYLIB
> > +???????help
> > +??????? ?Driver for MDIO via GPIO on PWRficient platforms
> > +
> 
> Looks still wrong. I stumbled over the original bug because in fedora,
> CONFIG_PHYLIB=m. When you make PPC_PASEMI_MDIO a bool, it will
> force PHYLIB=y, which is potentially undesired.
> 
> Can you make this a modular driver (tristate)?
> 
> Instead of making it select PHYLIB directly, it might be more
> straightforward to make PPC_PASEMI_MDIO depend on PHYLIB
> and have the actual network driver select both PPC_PASEMI_MDIO
> and PHYLIB.

Good points. New patch shortly.


-Olof
