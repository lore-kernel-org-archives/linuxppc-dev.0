Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp10.wanadoo.fr (smtp10.wanadoo.fr [193.252.22.21])
	by ozlabs.org (Postfix) with ESMTP id 3C1502BDB5
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Jan 2005 20:31:41 +1100 (EST)
Date: Sun, 2 Jan 2005 10:39:09 +0100
To: Sebastian Heutling <sheutlin@gmx.de>
Message-ID: <20050102093908.GA25739@pegasos>
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>
	<41CF77A9.9040405@gmx.net> <20041231095557.GA16480@pegasos>
	<1104505249.6794.5.camel@weizen.left.earth>
	<20041231222808.GB8078@pegasos>
	<1104623790.10369.14.camel@weizen.left.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1104623790.10369.14.camel@weizen.left.earth>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org,
	Marc Dietrich <Marc.Dietrich@ap.physik.uni-giessen.de>
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 02, 2005 at 12:56:29AM +0100, Sebastian Heutling wrote:
> On Fri, 2004-12-31 at 23:28 +0100, Sven Luther wrote:
> > On Fri, Dec 31, 2004 at 04:00:49PM +0100, Sebastian Heutling wrote:
> > > On Fri, 2004-12-31 at 10:55 +0100, Sven Luther wrote:
> > > > On Mon, Dec 27, 2004 at 03:47:05AM +0100, Christian wrote:
> > > > > Marc Dietrich schrieb:
> > > > > >Hi all,
> > > > > >
> > > > > >I read this thread about booting a PowerStack with newer kernels. 
> > > > > >Motivated by this, I tried to compile a 2.6.10 kernel on my machine (with 
> > > > > >sym53c825a onboard). Sadly, the scsi controller always timeouts during 
> > > > > >initialisation. I 
> > > > 
> > > > I also have some strange issues with network support using the standard debian
> > > > 2.6.8 kernel. ifconfig upping the decchip ethernet on the powerstack freezes
> > > > the kernel, and i hear reports of problems on IBM PReP hardware too with not
> > > > working ethernet, altough there is no freeze.
> > > > 
> > > > Any idea on this ? 
> > > 
> > > Does it contain the IRQ patch? Where does it boot from SCSI or net? What
> > > PCI-Devices are installed?
> > 
> > Probably not, just the standard debian kernel, i donÃ't remember any irq
> > patches, but there where a bunch of patches from leighbb. it is done
> 
> The patch is the one that is included in 2.6.10 which is mentioned above
> and this thread already has somewhere in the beginning. I attached it
> below.
> I haven't had the time yet to test the 2.6.10 kernel. Maybe there is
> another problem now ...

The one with three lines of modified irq lines from tom rini ? I found it in
google, but i also saw another bunch of prep changes which got in 2.6.9 i
think. Since debian is still using 2.6.8 and a bunch of backports, these may
be relevant, i think.

Also, i think for some reason i was unsubscribed while the list moved to
ozlab, and lost maybe the start of the thread, thanks for the attachement.

> > netbooting, and the only pci device installed is the cirruss logic graphic
> > card.
> 
> If you use the standard debian kernel - ok, it doesn't work because of
> wrong IRQs on the PowerstackII (Utah).

Which i will now fix now that i am aware of the problem. There seem to be also
a problem on IBM prep hardware, may it be related ?

> BTW: The onboard Winbond IDE chip works as well although no connector is
> provided. You only need a little bit of soldering and adjusting the IRQ
> of Slot 1 from 0 to 4. :-)

Ah, wondered about that, and saw the slots are not soldered. I wonder why go
to all the trouble including a IDE chip, but not solder the connectors. Seems
to me like peanut savings or something.

Friendly,

Sven Luther
> 
> 
> Sebastian Heutling
> 
> -- 
> diff -puN
> arch/ppc/platforms/prep_pci.c~ppc32-fix-motorola-prep-powerstackii-utah-pci-irq-map arch/ppc/platforms/prep_pci.c
> ---
> 25/arch/ppc/platforms/prep_pci.c~ppc32-fix-motorola-prep-powerstackii-utah-pci-irq-map      2004-12-07 01:01:16.000000000 -0800
> +++ 25-akpm/arch/ppc/platforms/prep_pci.c       2004-12-07
> 01:01:16.000000000 -0800
> @@ -49,10 +49,10 @@ static char Utah_pci_IRQ_map[23] __prepd
>          0,   /* Slot 1  - unused */
>          5,   /* Slot 2  - SCSI - NCR825A  */
>          0,   /* Slot 3  - unused */
> -        1,   /* Slot 4  - Ethernet - DEC2114x */
> +        3,   /* Slot 4  - Ethernet - DEC2114x */
>          0,   /* Slot 5  - unused */
> -        3,   /* Slot 6  - PCI Card slot #1 */
> -        4,   /* Slot 7  - PCI Card slot #2 */
> +        2,   /* Slot 6  - PCI Card slot #1 */
> +        3,   /* Slot 7  - PCI Card slot #2 */
>          5,   /* Slot 8  - PCI Card slot #3 */
>          5,   /* Slot 9  - PCI Bridge */
>               /* added here in case we ever support PCI bridges */
> 
> 
> 
