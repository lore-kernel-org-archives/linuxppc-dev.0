Message-ID: <3A62EC61.CF97FA4B@dspace.de>
Date: Mon, 15 Jan 2001 13:26:09 +0100
From: Andreas Schreckenberg <ASchreckenberg@dspace.de>
Reply-To: Andreas Schreckenberg <ASchreckenberg@dspace.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: serial console printf do not work
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am trying to bring up linux on my custom ppc board.
It seems that the kernel (linux 2.2.14) the ramdisk
and a static compiled sash (sash 3.4) runs.

But output with printf (userspace sash) looses
charakters on the serial console.

I modified serial.c in drivers/char and serial.h in
include/asm to my needs. (initalize port and irq
with irq = 0 -> driver in polling mode ?)

I'm a little bit surprised because printk gives
the correct output without loosing charakters.

Input is possible and the shell echo the chars
which were typed in. (type 'help' for example gives some
crypticlike output)

I use seyon with 38400,8,N,1 to /dev/ttyS0 on my x86 host.
I think I have a correct wired cable from
the board to the host.

I feel that this has something to do with incorrect
hardware handshake. But why gives printk the correct
output ?

...
ttyS00 at 0xf2000000 (irq = 0) is a 16550A
RAM disk driver initialized:  16 RAM disks of 4096K size
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 32k init 28k prep 4k pmac 12k open firmware
Sl                                    <-- the sash starts, input possible
r[-sN m u   .u
N       a emm ]i enpp
r[-sN m u   .u
N       a emm ]i enpp
sfse lla
...

Is there anyone who can help me or give me a tip where to find
the problem in the sourcecode ?

bye
Andreas
--
          Life's not fair. But the root password helps ! :-)
                   http://schrecky.home.pages.de

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
