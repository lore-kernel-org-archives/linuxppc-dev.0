Message-ID: <38340F9F.E7A9CC63@iname.com>
Date: Thu, 18 Nov 1999 14:39:27 +0000
From: Jim Chapman <jim.chapman@iname.com>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: configuring swap on a diskless mpc860 embedded target
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Is anyone using an NFS-mounted swap file on an mpc860 diskless system?

I created a swap file on the embedded target using

dd if=/dev/zero of=/SWAPFILE bs=1k count=8192
mkswap /SWAPFILE

But when I try to enable swapping using "swapon /SWAPFILE", linux
complains that it can't find a swap signature in the file. I've looked
at the file using a hex dump and it seems to be in the right place (10
characters at offset 4096-10). Adding some debug printk's, I can see
that sys_swapon() reads in random data (usually NULLs, but not always)
into a swap_header struct. I get the same result with v0 and v1 swap
file formats.

I tried creating the swap file on my PowerMac G3 (running linux-2.2.10)
but that yielded the same result.

My kernel is the embedded 2.2.13 running on a custom mpc860 board. The
system's NFS root is served from a cheapie x86 system running
linux-2.2.13.

Any thoughts?

-Jim


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
