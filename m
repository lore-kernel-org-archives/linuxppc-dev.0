Message-ID: <D73A25AA6E54D511AD74009027B1110F5BB19F@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: anyone ever see "swap_dup: Bad swap file entry"?
Date: Thu, 22 Apr 2004 09:13:06 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am using the linuxppc_2_4_devel tree from http://ppc.bkbits.net/ and a
ramdisk which I downloaded from Wolfgang Denx's FTP site.  The compile
environment is the latest ELDK.  I have this tree and ramdisk working just
fine on an MPC8260 processor.  I took that support and changed a few lines
of code in arch/ppc/lib/string.S and arch/ppc/kernel/misc.S to get the
kernel to boot on an MPC8248 processor.  The kernel appears to boot and
mount the ramdisk but then I get the following error.

RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1431k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 56k init
swap_dup: Bad swap file entry 0e18d55c
swap_dup: Bad swap file entry 0e18d55c
swap_dup: Bad swap file entry 0e18d55c
swap_dup: Bad swap file entry 0e18d55c
swap_dup: Bad swap file entry 0e18d55c
swap_dup: Bad swap file entry 0e18d55c
swap_dup: Bad swap file entry 0e18d55c
swap_dup: Bad swap file entry 0e18d55c

This error is in mm/swapfile.c  It happens when type >= nr_swapfile in
function swap_duplicate.  The only time nr_swapfile gets changed is function
sys_swapon.  Using my BDI2000 I see that sys_swapon is never getting called.
Does anyone know when or if sys_swapon should get called?  Has anyone seen
this before?  Any advice is always appreciated.

Steve Blakeslee

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
