Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp6.wanadoo.fr (smtp6.wanadoo.fr [193.252.22.25])
	by ozlabs.org (Postfix) with ESMTP id A0CAB67A7D
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Mar 2005 06:22:19 +1100 (EST)
Date: Sun, 6 Mar 2005 20:10:34 +0100
To: Dale Farnsworth <dale@farnsworth.org>
Message-ID: <20050306191034.GA10975@pegasos>
References: <41F6E0E1.6000803@mvista.com> <20050224082508.GA30005@pegasos>
	<421DF2B8.6040007@mvista.com> <20050224160411.GA11197@pegasos>
	<20050224172420.GA6932@xyzzy> <20050305192752.GA28491@pegasos>
	<20050305203254.GB30151@pegasos> <20050305225128.GC16904@xyzzy>
	<20050306070248.GA6673@pegasos> <20050306102924.GA32386@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20050306102924.GA32386@xyzzy>
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

On Sun, Mar 06, 2005 at 03:29:24AM -0700, Dale Farnsworth wrote:
> On Sun, Mar 06, 2005 at 08:02:48AM +0100, Sven Luther wrote:
> > On Sat, Mar 05, 2005 at 03:51:28PM -0700, Dale Farnsworth wrote:
> > > By all means, try it.  Several people are using it without complaints, but
> > > I'd appreciate your feedback.  There isn't anything dangerous in there.
> > > Gigabit works for me.  I'm not sure what Kconfig parts would be needed
> > > specifically for gigabit support.
> > 
> > I added just a PPC_CHRP dependency on the MV64XXX_ETH entry, and i was able to
> > build it, and even insmod it, but the module doesn't do a thing, and not even
> > a single line shows up in dmesg. I guess i am either missing a part of the
> > patch or there is something wrong with the probe code.
> > 
> > I have gotten the diff against : 
> > 
> > include/linux/mv643xx.h drivers/net/mv643xx_eth.[ch] and drivers/net/Kconfig,
> > adding :
> > 
> >  config MV643XX_ETH
> >         tristate "MV-643XX Ethernet support"
> > -       depends on MOMENCO_OCELOT_C || MOMENCO_JAGUAR_ATX
> > +       depends on MOMENCO_OCELOT_C || MOMENCO_JAGUAR_ATX || MV64360 || PPC_CHRP
> >         help
> >           This driver supports the gigabit Ethernet on the Marvell MV643XX
> > -         chipset which is used in the Momenco Ocelot C and Jaguar ATX.
> > +         chipset which is used in the Momenco Ocelot C and Jaguar ATX and
> > +         Pegasos II, amongst other PPC and MIPS boards.
> > 
> > I have no idea where your MV64360 comes from, it seems to be not existent in
> > any other Kconfig, ... oh well, maybe i am wrong, i wasn't able to do a
> > recursive bk co, so maybe i missed a bunch of Kconfig files with my grep/find
> > combo :/ Will have to look more.
> 
> MV64360 is in arch/ppc/Kconfig, and is currently defined for KATANA and
> CHESTNUT.  If I understand correctly, it should be defined for any
> board using the MV64360.  I don't think we want the PPC_CHRP dependency.

Ah, i guess that was the missing bit. Basically i need to set MV64360 for my
board, but since it is a generic PPC_CHRP, how is that supposed to work ? 

Could you send me maybe a list of files which need merging yet, compared to
2.6.11 ? I guess it just doesn't work because i am missing pieces.

> > Anyway, how do you probe for the chip ? On the pegasos we used to map on the
> > marvell pci id :
> > 
> >   0000:00:00.0 Host bridge: Marvell Technology Group Ltd. MV64360/64361/64362
> >   System Controller (rev 03)
> > 
> > too bad Marvell didn't do the logical thing and made the ethernet port appear
> > as separated devices on a third internal pci bus.
> 
> The mv643xx_eth probe is dependent on having the appropriate
> platform device entry.  See eth0_device and mv64x60_add_pds() in
> arch/ppc/syslib/mv643x60.c .

The pegasos has the mv64360 registers mapped at 0xf1000000, and the ports
(only port1 is wired though) mapped at interrupt 9, shared with other devices.
I guess that would be the only real difference with the other currently
supported hardware, right ? 

Will look at the above mentioned files and function and try to enable it.

Friendly,

Sven Luther
