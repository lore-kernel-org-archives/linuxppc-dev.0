Date: Fri, 18 Dec 1998 11:25:44 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
Reply-To: Gabriel Paubert <paubert@iram.es>
To: Troy Benjegerdes <hozer@drgw.net>
cc: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>,
        Corey Minyard <minyard@acm.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Restructure of arch/ppc/kernel and include/asm-ppc
In-Reply-To: <Pine.LNX.4.04.9812152246120.30336-100000@narn.local.drgw.net>
Message-ID: <Pine.HPP.3.96.981218111509.12103B-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 15 Dec 1998, Troy Benjegerdes wrote:

> 
> On Sun, 13 Dec 1998, Geert Uytterhoeven wrote:
> 
> > 
> > On 12 Dec 1998, Corey Minyard wrote:
> > > This is a patch relative to 2.1.131 that significantly restructures
> > > the Linux PPC stuff.  It is the first step in making the code more
> > > modular and separating the machine-specific from the
> > > machine-independant stuff.  This currently works on my MVME2700
> > > board.
> 
> Great! I started working on something like this, but got sidetracked for
> awhile. I'll verify it works on an MTX board and make the RTC code work
> correctly (it currently doesn't set Motorola PReP boards at all)
> 
> > For PPC, we would need different MILO images for the different machine types.
> > The kernel can be ELF on all machine types, since we put an ELF loader in MILO.
> > MILO doesn't need much fancy driver stuff, just SCSI/IDE, floppy, keyboard and
> > a simple console (serial, VGA text, offb). And BootX can become some special
> > variant of MILO :-)
> 
> Please please please someone do this? Then I can remove the ugly hack I
> have in matroxfb to remap the PCI registers to something sane.

Did you try my preploader. It attempts to remap all the PCI resources to
something sane and even includes a black list for devices who lie about
their requirement (S3). For the latest version I've got success reports on
quite a lot of Motorola boards: 

	MVME230x, 2300SC, 2400, 260x, 2700, 3600, MTX and MPC750

and for now also 0 failure reports ;-). I'm expecting some however...
And I'm sure it will fail when somebody tries to use CompactPCI board with
an MPC750 since I've not yet implemented support for PCI<->PCI bridges
(I can't test it).

 	Gabriel.



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
