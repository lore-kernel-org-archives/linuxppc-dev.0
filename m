Date: Sun, 18 Jun 2000 09:11:59 -0400 (EDT)
From: "Peter R. Wood" <pwood@gordon.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Broken CDROM in 2.4.0-test1
In-Reply-To: <200006180500.AAA06295@lists.linuxppc.org>
Message-ID: <Pine.LNX.4.21.0006180859410.707-100000@dyn-133-196.gordon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I've been testing out kernel 2.4.0-test1-ac18 on my LinuxPPC
system.  Specifically I have a SuperMac J700/180, with the stock 604e
processor, 80 megs ram, and a Belkin USB card.  Everything is actually
working quite well, except it seems that support for my CDROM drive is
broken. This has happened with some earlier kernels. For example,
somewhere back in 2.2, it worked fine, then a few revisions later, it was
broken, and then it was fixed again.  My current 2.2 kernel is 2.2.16, and
my SCSI CDROM works fine in there.  However in 2.4.0-test1-ac18, when I
try to mount any CDROM (hfs, iso9660, etc), I get this error:

/dev/cdrom: Input/output error
mount: I could not determine the filesystem type, and none was specified

I have tested the same CD's under the 2.2.16 kernel, and in MacOS, and
have no problems there. It only seems to be in 2.4.0-test1... it also
happened before I put the ac18 patch on.

I get kernel messages such as these when I try to mount CDROM's:

Jun 18 08:58:20 *** kernel: MSDOS: Hardware sector size is 2048
Jun 18 08:58:20 *** kernel: fatfs: bogus cluster size
Jun 18 08:58:20 *** kernel: VFS: Can't find a valid MSDOS
filesystem on dev 0b:00.
Jun 18 08:58:20 *** kernel: MSDOS: Hardware sector size is 2048
Jun 18 08:58:20 *** kernel: fatfs: bogus cluster size
Jun 18 08:58:20 *** kernel: VFS: Can't find a valid MSDOS
filesystem on dev 0b:00.
Jun 18 08:58:20 *** kernel: sr.c:Bad 2K block number requested (2
1) I/O error: dev 0b:00, sector 2
Jun 18 08:58:20 *** kernel: hfs_fs: unable to read block
0x00000002 from dev 0b:00
Jun 18 08:58:20 *** kernel: hfs_fs: Unable to read superblock
Jun 18 08:58:20 *** kernel: sr.c:Bad 2K block number requested (0
1) I/O error: dev 0b:00, sector 0
Jun 18 08:58:20 *** kernel: hfs_fs: unable to read block
0x00000000 from dev 0b:00
Jun 18 08:58:20 *** kernel: hfs_fs: Unable to read block 0.

The Kernel detects this data about my drive at startup:

mesh: target 3 synchronous at 5.0 MB/s
  Vendor: MATSHITA  Model: CD-ROM CR-506     Rev: 8S05
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0

And reports loading the Uniform CD-ROM driver Revision: 3.11

I did compile all the necessary SCSI support into the kernel, including
SCSI CDROM with vendor-specific extensions, as well as all the possible
filesystems that I typically use.

Any ideas?

Peter

p.s. Please cc: any replies to me as I receive the list in digest mode.

--
Peter R. Wood				pwood@gordon.edu
Gordon College				http://www.cs.gordon.edu/~pwood/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
