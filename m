Return-Path: <dgibson@ozlabs.org>
Date: Mon, 17 Sep 2007 15:50:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] i2c: devtree-aware iic support for PPC4xx
Message-ID: <20070917055001.GB9303@localhost.localdomain>
References: <200709161352.03459.sr@denx.de>
	<20070916185330.GA32314@gate.ebshome.net>
	<200709170734.09079.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200709170734.09079.sr@denx.de>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 17, 2007 at 07:34:08AM +0200, Stefan Roese wrote:
> On Sunday 16 September 2007, Eugene Surovegin wrote:
> > Hmm, I just noticed that you basically added a copy of existing
> > driver with small changes to support OF while keeping OCP one.
> >
> > Why not just add OF support to the existing code (under some ifdef),
> > and then remove OCP support as soon as ppc -> powerpc transition is
> > finished? Why have two almost identical code in the tree?
> 
> My understanding was, that adding many #ifdef's into the code was not the 
> preferred way. I could of course change this patch to not add an additional 
> driver but extend the existing driver with a bunch of #ifdef's to support 
> both versions.

#ifdefs are yucky, but so is duplication.  I'm not sure which is the
lesser evil in this case.

> This approach of multiple drivers seems to be common in the kernel right now:
> 
> drivers/mtd/maps/physmap.c
> drivers/mtd/maps/physmap_of.c

Not a relevant example.  Despite the names, physmap and physmap_of
don't really do the same thing at all.  I've been meaning to rename
physmap_of...

> 
> or
> 
> drivers/usb/host/ohci-ppc-soc.c
> drivers/usb/host/ohci-ppc-of.c

Also ibm_emac vs. ibm_new_emac (not merged yet).

> Any other opinions on this? How should this be handled to get accepted 
> upstream? Two different drivers with removing the "old" one later when 
> arch/ppc is gone, or one driver which supports both versions and removing the 
> ocp support in this driver later?
> 
> > I also personally don't like this _iic -> _of name change (you
> > removed peripheral name and added something which has nothing to do
> > with iic, I never heard of OF peripheral in 4xx chips). Whether you
> > use OCP or OF to pass a little information is quite irrelevant to the
> > iic driver operation.
> 
> The "old" name "i2c-ibm_iic" is kind of redundant. Nearly all bus drivers are 
> named "i2c-platform". Perhaps a better name would be "i2c-ppc4xx" then. 
> This "of" name was borrowed from already existing device-tree aware drivers 
> like drivers/mtd/maps/physmap_of.c or drivers/usb/host/ohci-ppc-of.c.

'ibm' is not specific enough - it's not like it's used on even a very
large fraction of ibm platforms - and 'of' is verging on misleading
(since OF != device tree, although they're related).  'iic' isn't
arbitrary - it comes from the name used in the documentation.
Although 'i2c-ppc4xx' probably is a better name, in any case.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
