Date: Fri, 21 Mar 2003 12:48:41 +0900
From: "Q-ha Park" <qhpark@jchyun.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: kernel oops when trying to read/write the ioremapped GPIO address.
Message-ID: <dz3lcmje/linuxppc-embedded@lists.linuxppc.org/qhpark@jchyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I have a 405 based custom board (STB04xxxx), and I've been using the 2.4.17-mvl21 kernel that came with mvista
preview kit.

I wrote a gpio driver that gives userland apps to control gpio ports. (no, i didn't use the IBM OCP gpio driver) It
simply ioremaps the gpio's physical address and read and write registers by calling in_be32, out_be32. is this
something i shouldn't do? anyways, it worked well with 2.4.17 kernel.

however, with the kernel version 2.4.21-pre4, it oops on calling in_be32 or out_be32. the same once happened with
the kernel 2.4.2 that also came with the monta vista preview kit.

right before the kernel oops, it gives a message, "Data machine check in kernel mode", which i didn't see before.
and NIP is at ">>NIP; c300a0a4 <[gpio_driver-dbg]__module_license+38/13c>" after examining the output of ksymoops. i
don't know why it's at "__module_license"

not only that this driver doens't work, also a couple of other drivers (not all) don't work (causing oops) anymore
after the kernel is upgraded to 2.4.21-pre4 from 2.4.17. it's funny that other drivers that failed to be insmoded
are  failed at __module_license..

hmmm, i'm clueless as to why this happens.. can someone help me with this?

your help would be greatly appreciated.

thanks in advance.


Q-ha Park


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
