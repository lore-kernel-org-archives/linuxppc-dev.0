Date: Tue, 27 Jul 1999 23:04:16 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Martin Mares <mj@ucw.cz>,
        "Andre M. Hedrick" <hedrick@Astro.Dyer.Vanderbilt.Edu>
Cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Trying a Promise Ultra/66 on powerpc
Message-ID: <19990727230416.A457@them.org>
References: <19990727112137.A897@drow.res.cmu.edu> <Pine.LNX.3.96.990727160229.10158B-100000@Astro.Dyer.Vanderbilt.Edu> <19990727102627.A370@drow.res.cmu.edu> <Pine.LNX.3.96.990727093644.6993B-100000@Astro.Dyer.Vanderbilt.Edu> <19990727235430.D1046@albireo.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19990727235430.D1046@albireo.ucw.cz>; from Martin Mares on Tue, Jul 27, 1999 at 11:54:30PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jul 27, 1999 at 04:07:28PM -0500, Andre M. Hedrick wrote:
> What are we missing in ppc-pci stuff that does not register an interrupt?
> I can work around this in general by asking the card if the dev->irq is
> NULL.  However, if this is the case, logic dictates that polling the card
> will yield the same result.
> 


OK.  I have this working now.  In getting it to work, I've come across
a couple of issues.

(A) You can't compile IDE as a module and enable ide-pmac.  There will
be link errors in pmac_setup.c.

(B) Very closely tied to that, if ide-pmac is not enabled, a dummy
pmac_ide_init_hwif_ports() is compiled in pmac_setup.c.  But the real
version of this function (in ide-pmac.c) does more than just onboard
IDE specific tasks.  For PCI IDE cards it is still needed.  Enabling
ide-pmac eventually let me make use of the card.

(C) I needed to add a patch to automatically try setting PCI_COMMAND_IO
if powerpc.  Without this the card would be marked as not supporting
native mode, and not be initialized.  On x86 bios32.c takes care of
bioses which do not set this.  Should something in the PPC PCI
initialization be doing the same?




On a much less related note:
drow:~# hdparm -p /dev/hdc

/dev/hdc:
 attempting to auto-tune PIO mode
 HDIO_SET_PIO_MODE failed: Function not implemented

pdc202xx.c has no tuneproc.  Is this deliberate?

As it is I get this (off a 5400 RPM Maxtor 25.4G DiamondMax)
/dev/hdc:
  Timing buffered disk reads:  32 MB in  5.83 seconds = 5.49 MB/sec

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
