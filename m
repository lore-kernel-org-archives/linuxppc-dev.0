Date: Thu, 16 Sep 1999 10:16:22 +0200 (MET DST)
From: Geert Uytterhoeven <geert@sonycom.com>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: New booter 
In-Reply-To: <199909152310.BAA15260@denx.local.net>
Message-ID: <Pine.GSO.4.10.9909160957530.21133-100000@ivy.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 16 Sep 1999, Wolfgang Denk wrote:
> [about LILO]:
> > it boots very cleanly on x86, booting linux instead of windows is 
> > complete non issue there.
> > 
> > BIOS loads the bootblock from boot disk or if one does not exist it 
> > looks for a partition marked bootable in the partition table and 
> > loads the bootblock from that.  the BIOS knows NOTHING about ANY 
> > filesystem not ext2 not FAT, NTFS, DOSfs, not HFS.  lilo works 
> > wonderfully, and does not require its very own partition in a 
> > specific filesystem format to work. *I* think this is a very clean 
> > way to boot it allows the replacement of the filesystem without 
> > anything more then a update to lilo at most.  not a whole new machine 
> 
> Furthermore, LILO provides with a lot of interesting  options  rarely
> used  but  very  powerful  (and  *very* useful for embedded systems):
> password protection,  selection  of  alternate  boot  arguments  with
> automatic fallback if booting fails etc.

If you want a LILO for PPC, please don't start from the PC LILO sources, but
from the m68boot packages. Amiga-Lilo (which I wrote, BTW :-) uses the same
principles as the PC LILO, but it is cleaner, has a simpler to understand
configuration file and a small boot monitor (which can be extended) that can be
protected with a password.

BTW, the main trouble with LILO is that you're hosed if you update your kernel
without rerunning LILO since LILO keeps track of the physical blocks. I
circumvent that problem by having (on my Amiga):

    /boot/vmlinuz -> /boot/vmlinuz-2.2.6
    /boot/test -> /boot/vmlinuz-2.3.16a

After compiling a new kernel, I copy it to /boot (using a new name, of course),
update the symlinks and rerun LILO. If I forget (one of) the last two steps,
nothing bad happens.

IMHO the best thing would be something like MILO on the Alpha. MILO is a
small binary that contains device drivers and filesystems taken from the
standard Linux kernel sources. Hence MILO knows about e.g. your ext2fs
partition and fancy U2W-SCSI adapter. On Alpha the MILO binary is put on a
MSDOS formatted partition. On PPC, you could store it on either a HFS or MSDOS
formatted partition, or use a LILO-alike scheme (raw-blocks). Even BootX could
load MILO under MacOS, if you want that.

Combined, you would have a shared `high-level' booter, which is called by
different `low-level' booters (FS (HFS/MSDOS), raw-blocks, BootX), depending on
your taste and architecture:

 +-----------------+
 | FS (HFS/MSDOS)  +----+
 +-----------------+    |
                        |     +------+
 +-----------------+    +---->|      |
 | raw-blocks LILO +--------->| MILO |----> /etc/milo/config
 +-----------------+    +---->|      |      <kernel anywhere on FS>
                        |     +------+
 +-----------------+    |
 | BootX           +----+
 +-----------------+

Doing it this way, even the raw-blocks LILO stuff can get rid of its main
disadvantage: since the LILO/MILO part is `static', you don't have to rerun
LILO when upgrading your kernel, only after installing/upgrading MILO. So
chances that you screw up are smaller, since MILO knows your FS and can boot
any old kernel on your disks in an emergency.

Comments?

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint Stevens Woluwestraat 55
Phone +32-2-7248620 Fax +32-2-7242686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
