Return-Path: <sheutlin@gmx.de>
Received: from mail.gmx.net (pop.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id B68102BF0E
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Jan 2005 08:33:38 +1100 (EST)
From: Sebastian Heutling <sheutlin@gmx.de>
To: Sven Luther <sven.luther@wanadoo.fr>
In-Reply-To: <20050102093908.GA25739@pegasos>
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>
	<41CF77A9.9040405@gmx.net> <20041231095557.GA16480@pegasos>
	<1104505249.6794.5.camel@weizen.left.earth>
	<20041231222808.GB8078@pegasos>
	<1104623790.10369.14.camel@weizen.left.earth>
	<20050102093908.GA25739@pegasos>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sun, 02 Jan 2005 22:33:37 +0100
Message-Id: <1104701617.7898.12.camel@weizen.left.earth>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org,
	Marc Dietrich <Marc.Dietrich@ap.physik.uni-giessen.de>
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
Reply-To: sheutlin@gmx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2005-01-02 at 10:39 +0100, Sven Luther wrote:
> On Sun, Jan 02, 2005 at 12:56:29AM +0100, Sebastian Heutling wrote:
> > On Fri, 2004-12-31 at 23:28 +0100, Sven Luther wrote:
> > > On Fri, Dec 31, 2004 at 04:00:49PM +0100, Sebastian Heutling wrote:
> > > > On Fri, 2004-12-31 at 10:55 +0100, Sven Luther wrote:
> > > > > On Mon, Dec 27, 2004 at 03:47:05AM +0100, Christian wrote:
> > > > > > Marc Dietrich schrieb:
> > > > > > >Hi all,
> > > > > > >
> > > > > > >I read this thread about booting a PowerStack with newer kernels. 
> > > > > > >Motivated by this, I tried to compile a 2.6.10 kernel on my machine (with 
> > > > > > >sym53c825a onboard). Sadly, the scsi controller always timeouts during 
> > > > > > >initialisation. I 
> > > > > 
> > > > > I also have some strange issues with network support using the standard debian
> > > > > 2.6.8 kernel. ifconfig upping the decchip ethernet on the powerstack freezes
> > > > > the kernel, and i hear reports of problems on IBM PReP hardware too with not
> > > > > working ethernet, altough there is no freeze.
> > > > > 
> > > > > Any idea on this ? 
> > > > 
> > > > Does it contain the IRQ patch? Where does it boot from SCSI or net? What
> > > > PCI-Devices are installed?
> > > 
> > > Probably not, just the standard debian kernel, i donÃ't remember any irq
> > > patches, but there where a bunch of patches from leighbb. it is done
> > 
> > The patch is the one that is included in 2.6.10 which is mentioned above
> > and this thread already has somewhere in the beginning. I attached it
> > below.
> > I haven't had the time yet to test the 2.6.10 kernel. Maybe there is
> > another problem now ...
> 
> The one with three lines of modified irq lines from tom rini ? I found it in
> google, but i also saw another bunch of prep changes which got in 2.6.9 i

Hmmm ... I didn't realise any other prep changes in 2.6.9


> think. Since debian is still using 2.6.8 and a bunch of backports, these may
> be relevant, i think.

You mean debian/testing?


> 
> Also, i think for some reason i was unsubscribed while the list moved to
> ozlab, and lost maybe the start of the thread, thanks for the attachement.

That explains a lot ;-)


> 
> > > netbooting, and the only pci device installed is the cirruss logic graphic
> > > card.
> > 
> > If you use the standard debian kernel - ok, it doesn't work because of
> > wrong IRQs on the PowerstackII (Utah).
> 
> Which i will now fix now that i am aware of the problem. There seem to be also
> a problem on IBM prep hardware, may it be related ?

Looking at the IRQ tables in prep_pci.c it very possible. There are a
lot structures which have a lot of low numbered slots initialised to 0.
Might be that its the same problem: PCI slotnumbering has changed
resulting in wrong used entries in this tables. People should look at
this particular place if they have problems like lost interrupts, kernel
output saying that a device got IRQ 0, timeouts or something like that.

> 
> > BTW: The onboard Winbond IDE chip works as well although no connector is
> > provided. You only need a little bit of soldering and adjusting the IRQ
> > of Slot 1 from 0 to 4. :-)
> 
> Ah, wondered about that, and saw the slots are not soldered. I wonder why go
> to all the trouble including a IDE chip, but not solder the connectors. Seems
> to me like peanut savings or something.

I am not sure but I think there are two versions of this machine: One
with only IDE connectors and one with only SCSI connector.
But to be honest: I don't know as well why they didn't solder all
connectors.


Sebastian Heutling
