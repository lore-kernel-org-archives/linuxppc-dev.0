Date: Mon, 20 Sep 1999 10:50:22 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: miBoot 1.0d3
Message-Id: <19990920105022.031160@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Sep 20, 1999, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
wrote:

>That would indeed be nice. FYI, Amiga-Lilo can boot AmigaOS, since we
>disasembled the ca. 20 bytes of code in the boot block.

With the current miBoot mecanism, we must either manage to have MacOS ROM
try another disk, or change the way miBoot works. The current scheme
initializes the file system and opens the fake System file. Changing to a
real MacOS System file on the fly would be very complex and dangerous. We
need the ROM to be able to close it and re-open a new boot volume.

Another solution would be to stuff miBoot in the bootblocs (a kind of
primary loader, which will itself load the remaning code _before_ the
file system is initialised. The initialisation is done in the bootblock
code). That means having some kind of "map" of the physical location of
the real boot file. I know how to build this map from MacOS but the trick
I use for this is not compatible with BlueBox (this may not be a problem
after all). I don't know if it's possible under Linux but I beleive it is.

Also, I could load this secondary bootstrap using direct SCSI or ATA
calls, but this may be difficult to fit in the bootblocks. The simplest
solution is to have them on the same HFS partition as the real System
file. This way, I can use simple PBReadSync from the root volume's driver.

More hacking next week end unless I find some spare time this week
(unprobable).


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
