Message-ID: <19990728100747.B331@albireo.ucw.cz>
Date: Wed, 28 Jul 1999 10:07:47 +0200
From: Martin Mares <mj@ucw.cz>
To: "Andre M. Hedrick" <hedrick@Astro.Dyer.Vanderbilt.Edu>,
        linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org,
        mlan@cpu.lu, drow@false.org
Subject: Re: Trying a Promise Ultra/66 on powerpc
References: <19990727112137.A897@drow.res.cmu.edu> <Pine.LNX.3.96.990727160229.10158B-100000@Astro.Dyer.Vanderbilt.Edu> <19990727102627.A370@drow.res.cmu.edu> <Pine.LNX.3.96.990727093644.6993B-100000@Astro.Dyer.Vanderbilt.Edu> <19990727235430.D1046@albireo.ucw.cz> <19990727230416.A457@them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19990727230416.A457@them.org>; from Daniel Jacobowitz on Tue, Jul 27, 1999 at 11:04:16PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

> (C) I needed to add a patch to automatically try setting PCI_COMMAND_IO
> if powerpc.  Without this the card would be marked as not supporting
> native mode, and not be initialized.  On x86 bios32.c takes care of
> bioses which do not set this.  Should something in the PPC PCI
> initialization be doing the same?

   Yes. Take a look at arch/i386/kernel/bios32.c, the pcibios_fixup_devices
function.
 
> On a related note, how do I find a memory region, not yet used, for
> remapping a PCI device's memory space? There is a bug with an onboard
> device on some Macs, in that it really decodes less address bits than
> it says it does, making it overlap other devices (which then need to be
> remapped). Right now, the driver uses the same region as in MacOS,
> without checking...

   The current resource management code doesn't support searching
for free regions, but I already have some patches for it, they only
need some more work.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"How an engineer writes a program: Start by debugging an empty file..."

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
