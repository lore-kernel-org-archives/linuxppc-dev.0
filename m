Message-Id: <199909161848.UAA00320@piglet.cpu.lu>
Date: Thu, 16 Sep 1999 20:48:37 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: New booter 
To: geert@sonycom.com
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.GSO.4.10.9909160957530.21133-100000@ivy.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  16 Sep, this message from Geert Uytterhoeven echoed through cyberspace:
> IMHO the best thing would be something like MILO on the Alpha. MILO is a
> small binary that contains device drivers and filesystems taken from the
> standard Linux kernel sources. Hence MILO knows about e.g. your ext2fs
> partition and fancy U2W-SCSI adapter. On Alpha the MILO binary is put on a
> MSDOS formatted partition. On PPC, you could store it on either a HFS or MSDOS
> formatted partition, or use a LILO-alike scheme (raw-blocks). Even BootX could
> load MILO under MacOS, if you want that.
> 
> Combined, you would have a shared `high-level' booter, which is called by
> different `low-level' booters (FS (HFS/MSDOS), raw-blocks, BootX), depending on
> your taste and architecture:
> 
>  +-----------------+
>  | FS (HFS/MSDOS)  +----+
>  +-----------------+    |
>                         |     +------+
>  +-----------------+    +---->|      |
>  | raw-blocks LILO +--------->| MILO |----> /etc/milo/config
>  +-----------------+    +---->|      |      <kernel anywhere on FS>
>                         |     +------+
>  +-----------------+    |
>  | BootX           +----+
>  +-----------------+
> 
> Doing it this way, even the raw-blocks LILO stuff can get rid of its main
> disadvantage: since the LILO/MILO part is `static', you don't have to rerun
> LILO when upgrading your kernel, only after installing/upgrading MILO. So
> chances that you screw up are smaller, since MILO knows your FS and can boot
> any old kernel on your disks in an emergency.

This is very close to what quik does: a two-stage bootup, where the
first-stage does nothing else than load the second-stage from fixed
blocks on disk. The second-stage can then be of any complexity you want.

Quik might need some work on the second-stage to make it more like what
Geert describes abvove; but the principal is there.

Anyway, as long as you want to be able to boot an OldWorld OF machine,
there is not much choice other than the boot block or a HFS partition
in order to boot.....

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
