Return-Path: <sheutlin@gmx.de>
Received: from mail.gmx.net (pop.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 2F3DE2BDB5
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Jan 2005 01:43:00 +1100 (EST)
From: Sebastian Heutling <sheutlin@gmx.de>
To: Marc Dietrich <marvin24@gmx.de>
In-Reply-To: <200501041504.57588.marvin24@gmx.de>
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>
	<200501031326.34477.marvin24@gmx.de> <41DA7E7A.3070901@gmx.de>
	<200501041504.57588.marvin24@gmx.de>
Content-Type: text/plain
Date: Tue, 04 Jan 2005 15:42:54 +0100
Message-Id: <1104849774.6164.19.camel@weizen.left.earth>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
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

On Tue, 2005-01-04 at 15:04 +0100, Marc Dietrich wrote:
> Hallo Sebastian,
> 
> Am Dienstag, 4. Januar 2005 12:31 schrieben Sie:
> > Hello Marc,
> >
> > Marc Dietrich wrote:
> > >Hi Christian,
> >
> > Erm ... I'm Sebastian ;-)
> 
> ah! - sorry Sebastian, to many confusion in the last time...

Hehe :)


> 
> > I am using a 2.6.8 (I was too lazy to patch & compile a 2.6.9 and wanted
> > to test 2.6.10 when it's (the sources) in debian/unstable).
> >
> > >Can you put a working zImage.prep somewhere on the web (<1.44 MB, so I can
> > >write it to a floppy disk)?
> >
> > I will do that and tell you later where you can download it.
> 
> This may no longer be necessary, but see below.
> 
> Acording to your log, your scsi drive also fails later, but boots from ide 
> (how did you managed to install the ide disks?).

Yep, it fails later but it doesn't boot from IDE. The SCSI disk is
recognized correctly and the system is on the SCSI drive. The IDE disks
only contain data. It fails later that is right but it still works after
failure.
Making IDE work was easy. A friend soldered the connectors and then I
passed "ide0=ide0=0x1f0,0x3f6,14" as kernel parameter to make channel 0
work. Later on after, discovering what was wrong with 2.6 kernels, I
enabled the correct interrupt in the appropriate table in prep_pci.c.

> 
> I posted a message to linux-scsi describing this problem. I guess the sym2 
> driver never worked on the PReP machines. I tried it also with 2.4 kernels. 
> 
> So to summerize it: No one has a working Powerstack with 2.6 kernel and 
> booting from SCSI. I hope there will be some input from the scsi list.

As said above, it does really work although I have to admit there is a
problem with PCI or IRQ handling in general. You can also see in my log
that one of the ethernet devices has problems every now and then. All in
all it is sort of functional.
You can also try to remove every additional PCI device except the gfx
card and see what happens. I had to remove an additional SCSI host
controller in order to avoid problems with other PCI devices (mostly it
was one of the ethernet devices which lost an interrupt).
But I share your thoughts that there is something wrong with the sym2
driver.


> 
> > >How does your boot.log looks like?
> >
> > Attached it.
> > Note that I use a Matrox MilleniumII gfx card and XFree4 runs fine
> > (without any crash) since I got a 2.6 kernel running (although I am not
> > using XFree because I use the Powerstack as a router/server which has no
> > Monitor).
> 
> Yeah - I search so many times for a Millenium card on eBay. Now I got one for 
> EUR 1.00 but  it is in Germany, while I'm in France now for holidays :-(
> I also have a P9100 here, but it is not supported (yet?) under linux...

:(


Sebastian
