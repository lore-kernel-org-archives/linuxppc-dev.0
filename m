Message-ID: <3ACBA866.50404@amberdata.demon.co.uk>
Date: Thu, 05 Apr 2001 00:04:06 +0100
From: David Monro <davidm@amberdata.demon.co.uk>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: asm-ppc/ide.h and the evil insw hack.
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

first a couple of caveats: I'm using a vanilla kernel.org tree and I
don't normally follow linuxppc-dev, so I may be saying something stupid,
but here goes...

Can we possibly get rid of the really evil hac in asm-ppc/ide.h where
insw and outsw get redefined?

Reasons for wanting to do this:

1) any unsuspecting soul who includes <asm/ide.h> into some random file
suddenly gets these redefined underneath them

2) because we only hack the "w" versions, setting the interface to 32
bit transfers (hdparm -c1) breaks horribly.

3) its an evil hack.

In fact I have an ulterior motive; the only easy way for me to get ide
working properly on my IBM 850 (PReP architecture) is to remove the hack
and set ppc_ide_md.fix_driveid to be ppc_generiv_ide_fix_driveid() at
which point the interface works absolutely perfectly (including 32 bit
transfers and IDE cdroms which always break if the hack is in place at
least for me).

The problem is I am sure including these changes will break somebody
else. I'm guessing that the chrp systems are probably broken in the same
way as the PReP ones are at the moment (most of the chrp systems I know
about seem to use SCSI so maybe noone has tested it). I'm really much
more worried about the macs.

Anyone care to comment?

btw if you do some experiments and find that you end up in a state where
the interface seems to work but your partition table isn't recognized
you may need the hdx=swapdata option.

Cheers,

	David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
