From: "dong in kang" <dkang@east.isi.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: zImage.initrd: when the compressed RAM file system is decompressed and installed?
Date: Wed, 23 Jul 2003 11:41:04 -0400
Message-ID: <002101c35130$d43e2b30$45a97241@Minjoo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <20030723090317.C192EC6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hello,

 I'm using MV Linux 2.1 with Linux kernel version 2.4.17.
I compiled the kernel with initrd to make zImage.initrd.
I configured RAM file system is used.
I loaded the kernel at 0x800000 and run the code.
Kernel decompression and start_kernel routine works fine (with a little
problem).
pciauto_bus_scan() causes problem when I do not use gdb.
At early_read_config_byte (), machine check exception occurs.
Howerver, when I use gdb and step through the early_read_config_byte()
routine, it goes well beyond that.
When I use gdb and step through "pciauto_bus_scan()", it runs remaining
routines such as
init_IRQ(), sched_init(), ..., rest_init() --> idled() --> schedule().
When it tries to switch to new thread by calling "_switch(old_thread,
new_thread)", it dies.
Gdb "step" function doesn't work. And when I stop the process, the PC is in
0xFFF033CC.

 I don't know why the kernel cannot go more.
However, I'm curious that before it dies it doesn't decompress initrd nor
install the RAM file system.
Is RAM file system installation done after that?

 I'll appreciate you help.

 Dong-In


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
