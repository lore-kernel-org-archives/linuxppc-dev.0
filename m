Message-ID: <20010823164256.8751.qmail@kunk.jriver.com>
Subject: 2.4.9-benh0 problems and kudos
To: linuxppc-dev@lists.linuxppc.org
Date: Thu, 23 Aug 2001 11:42:56 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On the positive side it looks like the 7500 chaos PCI bus fixes
have been incorporated as well as the planb fixes and the
controlfb enhancements.

I've run into a couple of small problems however....

planb.c has a problem in 2074.
pb->lock = 0;

pb->lock is defined as a semaphore so this gives the following
compiler error...

planb.c: In function `init_planb':
planb.c:2074: incompatible types in assignment

Next, when pppoe, ax25 or netrom are compiled as modules, trying to
insmod them gives the following...

# /sbin/insmod pppoe
Using /lib/modules/2.4.9-benh0/kernel/drivers/net/pppoe.o
/lib/modules/2.4.9-benh0/kernel/drivers/net/pppoe.o: unresolved symbol sk_run_filter
/lib/modules/2.4.9-benh0/kernel/drivers/net/pppoe.o: unresolved symbol unregister_pppox_proto_Re0ff7a18
/lib/modules/2.4.9-benh0/kernel/drivers/net/pppoe.o: unresolved symbol pppox_unbind_sock_Rdbcf0794
/lib/modules/2.4.9-benh0/kernel/drivers/net/pppoe.o: unresolved symbol register_pppox_proto_R7c123193

The problem appears to be sk_run_filter.

Finally, though controlfb works, it doesn't work in X in 24/32 bit mode
and 1024x768 resolution. It does however work in 800x600 mode at the
same color depth and my 2.4.5 kernel patched from Michels site does work.
By not working I mean it goes into X but gives a blank screen.

Here is the dmesg for controlfb...

controlfb: VRAM Total = 4MB (2MB @ bank 1, 2MB @ bank 2)
controlfb: using video mode 16 and color mode 2.
Console: switching to colour frame buffer device 128x48
fb0: control display adapter
MacOS display is /chaos/control


I'm trying to get the latest kernel working so I can do mace testing
on current code.

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
