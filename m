Date: Wed, 26 Apr 2000 01:12:23 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: quik fail on RS/6000 B50
Message-ID: <20000426011223.A21204@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

we have a strange problem with quik. It fails to open the file system
after a cold start or a reboot in Linux. A warm reboot with "reset-all"
at the OF prompt after typing "halt" works always.

I included a lot of debug messages and it seems to fail in
./e2fsprogs-1.18/lib/ext2fs/openfs.c:55:
EXT2_CHECK_MAGIC(manager, EXT2_ET_MAGIC_IO_MANAGER);

The return value of ext2fs_open is always 2133571335 for all the 3 partitions.
linux_io_manager isn't zero, it is always 3F9E44.

After the warm reboot the return value of the first partition
(41 PReP Boot) is 2133571347 aka EXT2_ET_BAD_MAGIC.

The fdisk -l output looks like this:

Disk /dev/sda: 64 heads, 32 sectors, 8678 cylinders
Units = cylinders of 2048 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sda1   *         1         5      5104   41  PPC PReP Boot
/dev/sda2             6       133    131072   83  Linux
/dev/sda3           134      8678   8750080   83  Linux

It doesnt help if I reduce the first partition to 1 cylinder.


The machine is a RS6k model B50 with 1GB ram.

Any suggestion how to solve that?



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
