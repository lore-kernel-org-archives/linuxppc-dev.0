Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 2EAE167A64
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  6 Mar 2005 21:29:26 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Sun, 6 Mar 2005 03:29:24 -0700
To: Sven Luther <sven.luther@wanadoo.fr>
Message-ID: <20050306102924.GA32386@xyzzy>
References: <41F6E0E1.6000803@mvista.com> <20050224082508.GA30005@pegasos>
	<421DF2B8.6040007@mvista.com> <20050224160411.GA11197@pegasos>
	<20050224172420.GA6932@xyzzy> <20050305192752.GA28491@pegasos>
	<20050305203254.GB30151@pegasos> <20050305225128.GC16904@xyzzy>
	<20050306070248.GA6673@pegasos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050306070248.GA6673@pegasos>
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

On Sun, Mar 06, 2005 at 08:02:48AM +0100, Sven Luther wrote:
> On Sat, Mar 05, 2005 at 03:51:28PM -0700, Dale Farnsworth wrote:
> > By all means, try it.  Several people are using it without complaints, but
> > I'd appreciate your feedback.  There isn't anything dangerous in there.
> > Gigabit works for me.  I'm not sure what Kconfig parts would be needed
> > specifically for gigabit support.
> 
> I added just a PPC_CHRP dependency on the MV64XXX_ETH entry, and i was able to
> build it, and even insmod it, but the module doesn't do a thing, and not even
> a single line shows up in dmesg. I guess i am either missing a part of the
> patch or there is something wrong with the probe code.
> 
> I have gotten the diff against : 
> 
> include/linux/mv643xx.h drivers/net/mv643xx_eth.[ch] and drivers/net/Kconfig,
> adding :
> 
>  config MV643XX_ETH
>         tristate "MV-643XX Ethernet support"
> -       depends on MOMENCO_OCELOT_C || MOMENCO_JAGUAR_ATX
> +       depends on MOMENCO_OCELOT_C || MOMENCO_JAGUAR_ATX || MV64360 || PPC_CHRP
>         help
>           This driver supports the gigabit Ethernet on the Marvell MV643XX
> -         chipset which is used in the Momenco Ocelot C and Jaguar ATX.
> +         chipset which is used in the Momenco Ocelot C and Jaguar ATX and
> +         Pegasos II, amongst other PPC and MIPS boards.
> 
> I have no idea where your MV64360 comes from, it seems to be not existent in
> any other Kconfig, ... oh well, maybe i am wrong, i wasn't able to do a
> recursive bk co, so maybe i missed a bunch of Kconfig files with my grep/find
> combo :/ Will have to look more.

MV64360 is in arch/ppc/Kconfig, and is currently defined for KATANA and
CHESTNUT.  If I understand correctly, it should be defined for any
board using the MV64360.  I don't think we want the PPC_CHRP dependency.

> Anyway, how do you probe for the chip ? On the pegasos we used to map on the
> marvell pci id :
> 
>   0000:00:00.0 Host bridge: Marvell Technology Group Ltd. MV64360/64361/64362
>   System Controller (rev 03)
> 
> too bad Marvell didn't do the logical thing and made the ethernet port appear
> as separated devices on a third internal pci bus.

The mv643xx_eth probe is dependent on having the appropriate
platform device entry.  See eth0_device and mv64x60_add_pds() in
arch/ppc/syslib/mv643x60.c .

-Dale
