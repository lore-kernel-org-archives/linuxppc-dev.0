Message-ID: <3B67E741.50A66F26@irisa.fr>
Date: Wed, 01 Aug 2001 13:25:53 +0200
From: Romain Dolbeau <dolbeau@irisa.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: `planb' doesn't compile on recent BenH kernel.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

the `planb' module won't comiple on any recent BenH kernel
(from rsync penguinppc.org::linux-2.4-benh).

2.4.6pre3 works fine. No 2.4.7* or 2.4.8* work for me.
I think some newer 2.4.6pre* didn't work either.

Apparently a locking mechanism was changed but
not all instance updated:

#####
--- linux-2.4.6pre3-benh/drivers/media/video/planb.h    Tue Jun 26
12:13:27 2001
+++ linux-2.4.8-pre3-ben0/drivers/media/video/planb.h   Wed Aug  1
12:07:03 2001
@@ -174,8 +174,7 @@
        int     user;
        unsigned int tab_size;
        int     maxlines;
-       int lock;
-       wait_queue_head_t lockq;
+       struct semaphore lock;
        unsigned int    irq;                    /* interrupt number */
        volatile unsigned int intr_mask;
#####

but planb.c still do a ## pb->lock = 0; ## (line 2074).

Here's the compile log:

#####
make[4]: Entering directory
`/usr/src/linux-2.4.8-pre3-ben0/drivers/media/video'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.8-pre3-ben0/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring
-DMODULE   -c -o planb.o planb.c
planb.c: In function `init_planb':
planb.c:2074: incompatible types in assignment
planb.c: At top level:
planb.c:85: warning: `planb_init_done' declared `static' but never
defined
#####

TIA

--
DOLBEAU Romain               | l'histoire est entierement vraie, puisque
ENS Cachan / Ker Lann        |     je l'ai imaginee d'un bout a l'autre
dolbeau@irisa.fr             |           -- Boris Vian

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
