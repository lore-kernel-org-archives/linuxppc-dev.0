Message-ID: <3870FE3E.4BEEF230@talknet.de>
Date: Mon, 03 Jan 2000 20:53:34 +0100
From: Alois Fertl <alois_fertl@talknet.de>
MIME-Version: 1.0
To: LinuxppcDev <linuxppc-dev@lists.linuxppc.org>
CC: Cort Dougan <cort@ppc.kernel.org>
Subject: Solution for IRQ problems on 2nd Controller
Content-Type: multipart/mixed;
 boundary="------------450455A3AC80EFBEAACDC7D8"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------450455A3AC80EFBEAACDC7D8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Some time ago there was a message on the list discussing problems
if more than one irq is pending from the second 8259. On the Blackhawk
I suffer this problem very badly, scsi, network and mouse are all via
the second controller. The problem is with 2.3.x kernels. 2.2 versions
had it fixed doing a loop until no more irqs are present on the second
controller.

The attached patch implements a workaround for the problem by disabling
all irqs from the second chip for a very short time 
(in i8259_mask_and_ack_irq()) and than re-enabling the usual ones. Doing
so seems to re-issue the required edge on the line going to the first
controller.

It is probably nor the cleanest way of handling the problem but up
to now the one which solves the problem on my Blackhawk.
The patch is relative the the 2.3.35 version from cvs.on.openprojects.net

	Alois.
--------------450455A3AC80EFBEAACDC7D8
Content-Type: text/plain; charset=us-ascii;
 name="i8259.patch"
Content-Disposition: inline;
 filename="i8259.patch"
Content-Transfer-Encoding: 7bit

--- arch/ppc/kernel/i8259.c.dist	Sat Jan  1 20:30:53 2000
+++ arch/ppc/kernel/i8259.c	Mon Jan  3 20:17:00 2000
@@ -52,9 +52,10 @@
         if (irq_nr > 7) {                                                   
                 cached_A1 |= 1 << (irq_nr-8);                                   
                 inb(0xA1);      /* DUMMY */                                     
+                outb(0xff,0xA1);                                           
                 outb(cached_A1,0xA1);                                           
-                outb(0x20,0xA0);        /* Non-specific EOI */             
-                outb(0x20,0x20);        /* Non-specific EOI to cascade */
+                outb(0x20,0xA0);        /* Non-specific EOI to cascade */
+                outb(0x20,0x20);        /* Non-specific EOI */
         } else {                                                            
                 cached_21 |= 1 << irq_nr;                                   
                 inb(0x21);      /* DUMMY */                                 

--------------450455A3AC80EFBEAACDC7D8--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
