Message-Id: <200104260559.HAA00741@piglet.grunz.lu>
Date: Thu, 26 Apr 2001 07:59:57 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: 9.1 Gbyte SCSI Drive
To: rcook@ntlug.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <01042600071402.07811@p7300>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  26 Apr, this message from Rick Cook echoed through cyberspace:
> I have a Seagate 9.1 Gbyte SCSI ST39173LC that I would like to install as a
> replacement for one of the 2 Gbyte drives. The dreaded "the 9.1 Gbyte drive
> works fine in a Pentium 120 system". However, when I install it into the
> 7300, the system crashes when I attempt to mke2fs any of the partitions (I
> have tried several partition size combinations). I don't remember if I have
> tried this since I initialized the partition map on the Pentium Machine.

Did you repartition the drive on the PowerMac before making filesystems?

I vaguely remember an issue with, IIRC, drives that had PC-style
partition maps. Not sure about the details anymore, sorry.

Anyway, the point was make sure you erase the PC partition map
_completely_, with something like this:

dd if=/dev/null of=/dev/sd<drive> bs=512 count=10

This should scratch the first few blocks on disk, some of which are not
touched by Mac-style partition maps, and make it possible to do a
_clean_ Mac partition map.

Obviously, the above commands destroys anything that was in those blocks
before, effectively erasing all partition information. So use with
caution, make sure you target the right disk, and only if you don't
weant to keep any data on the target drive.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
