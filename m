Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp8.wanadoo.fr (smtp8.wanadoo.fr [193.252.22.23])
	by ozlabs.org (Postfix) with ESMTP id A0E2567A7C
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  6 Mar 2005 18:14:26 +1100 (EST)
Date: Sun, 6 Mar 2005 08:02:48 +0100
To: Dale Farnsworth <dale@farnsworth.org>
Message-ID: <20050306070248.GA6673@pegasos>
References: <41F6E0E1.6000803@mvista.com> <20050224082508.GA30005@pegasos>
	<421DF2B8.6040007@mvista.com> <20050224160411.GA11197@pegasos>
	<20050224172420.GA6932@xyzzy> <20050305192752.GA28491@pegasos>
	<20050305203254.GB30151@pegasos> <20050305225128.GC16904@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20050305225128.GC16904@xyzzy>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Nicolas DET <det.nicolas@free.fr>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][PPC32] mv64x60 updates
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Mar 05, 2005 at 03:51:28PM -0700, Dale Farnsworth wrote:
> On Sat, Mar 05, 2005 at 09:32:54PM +0100, Sven Luther wrote:
> > On Sat, Mar 05, 2005 at 08:27:52PM +0100, Sven Luther wrote:
> > > On Thu, Feb 24, 2005 at 10:24:20AM -0700, Dale Farnsworth wrote:
> > > > See bk://dfarnsworth.bkbits.net/linux-2.5-mv643xx-enet
> > > 
> > > I guess i need to look there, as in mainline 2.6.11, there doesn't seem to be
> > > direct related code between the ppc specific mv64x60 stuff, and the mips
> > > related ethernet one.
> > 
> > Ok, i think that did it, and i have a 200kb diff against 2.6.11 :) Many of
> > those are just 64340-> 643xx replacements though.
> 
> Yes, renames and Lindent make for big diffs.

Ah, ...

Well, maybe i will need to do a minimal patch without renaming for the debian
2.6.11 kernel, but we will see.

> > What are your plans for mainline inclusion of the rest of those, and is it ok
> 
> I've submitted it for mainline inclusion.  Jeff Garzik put it in
> netdev-2.6 (and thus in the mm patches) for testing and it's on track
> for going into mainline.  I hope it will happen in the next few days,
> but that's up to Jeff.

Ok.

> > to work directly with your stuff ? Do you have any experimental or dangerous
> > parts in the above ? And did you ever get the gigabit ethernet port working on
> > a powerpc board ? Or are there some Kconfig parts i have missed ?
> 
> By all means, try it.  Several people are using it without complaints, but
> I'd appreciate your feedback.  There isn't anything dangerous in there.
> Gigabit works for me.  I'm not sure what Kconfig parts would be needed
> specifically for gigabit support.

I added just a PPC_CHRP dependency on the MV64XXX_ETH entry, and i was able to
build it, and even insmod it, but the module doesn't do a thing, and not even
a single line shows up in dmesg. I guess i am either missing a part of the
patch or there is something wrong with the probe code.

I have gotten the diff against : 

include/linux/mv643xx.h drivers/net/mv643xx_eth.[ch] and drivers/net/Kconfig,
adding :

 config MV643XX_ETH
        tristate "MV-643XX Ethernet support"
-       depends on MOMENCO_OCELOT_C || MOMENCO_JAGUAR_ATX
+       depends on MOMENCO_OCELOT_C || MOMENCO_JAGUAR_ATX || MV64360 || PPC_CHRP
        help
          This driver supports the gigabit Ethernet on the Marvell MV643XX
-         chipset which is used in the Momenco Ocelot C and Jaguar ATX.
+         chipset which is used in the Momenco Ocelot C and Jaguar ATX and
+         Pegasos II, amongst other PPC and MIPS boards.

I have no idea where your MV64360 comes from, it seems to be not existent in
any other Kconfig, ... oh well, maybe i am wrong, i wasn't able to do a
recursive bk co, so maybe i missed a bunch of Kconfig files with my grep/find
combo :/ Will have to look more.

Anyway, how do you probe for the chip ? On the pegasos we used to map on the
marvell pci id :

  0000:00:00.0 Host bridge: Marvell Technology Group Ltd. MV64360/64361/64362
  System Controller (rev 03)

too bad Marvell didn't do the logical thing and made the ethernet port appear
as separated devices on a third internal pci bus.

> Updates are coming though.  James Chapman has sent me several patches
> that provide: use of the mii library for phy management, additional
> ethtool support, message level support, compile fix for non-NAPI, and
> much cleanup.  We're working the kinks out now and I expect to submit
> these patches in the next few days.

Ok, let's make sure it works on pegasos before then.

Friendly,

Sven Luther
