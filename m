Date: Wed, 12 Jul 2000 10:35:48 -0400 (EDT)
From: "TWG - pat, mark & steve" <twg@world.std.com>
To: Kwansuk Kim <kskim@neowave.co.kr>
cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel can't library file
In-Reply-To: <NEBBKFENMLEDKDHMEHPJOEPBCAAA.kskim@neowave.co.kr>
Message-ID: <Pine.SGI.3.95.1000712103124.7904A-100000@world.std.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In the MontaVista target directory, libdl.so.2 is a link to the actual
library, libdl-2.1.2.so.  Make sure that the libraries are real ones, not
just links.  (I'm a linux newbie, but I have seen that you often can't
follow links under NFS, perhaps a protection issue?)
I solved the problem brute force, by copying
opt/hardhat...../target/lib/libdl-2.1.2.so /nfsmnt/lib/libdl.so.2

(nfsmnt is the directory I mount for the target)

Hope that helps
Mark Phillips
On Wed, 12 Jul 2000, Kwansuk Kim wrote:

>
> I heard the solution for network configuration was three.
>
> 1) etc/protocols, services
> 2) /proc
> 3) same compiler version between kernel, program, and library.
>
> first 2 solution had no effect.
>
> So I searched for the program and library 2.1.2(2.1.1?)
>
> I use montavista developement kit and I found root file system in target directory.
>
> It was very huge, so I copy just few files to ramdisk.
>
> but kernel shows such a message.
>
>
> -----------
>
> ttyS00 at 0x0380 is a SMC
> ttyS01 at 0x0100 is a SCC
> ttyS02 at 0x0200 is a SCC
> pty: 256 Unix98 ptys configured
> RAM disk driver initialized:  16 RAM disks of 8192K size
> eth0: CPM ENET Version 0.2, 00:01:c4:00:00:b1
> IP-Config: Incomplete network configuration information.
> dev_close: bug eth0 still running
> RAMDISK: Compressed image found at block 0
> RAMDISK: Decompressed successfullyVFS: Mounted root (ext2 filesystem).
> Freeing unused kernel memory: 32k init
>
> ?nit: error in loading shared libraries: libdl.so.2: cannot open shared object
> file: No such file or directory
>
> ----------
>
> in lib directory there are
>
> ld.so.1 libdl.so.2 libc.so.6
>
> it's for bash program. I think bash prompt should be present.
>
> anyone had such a problem?
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
