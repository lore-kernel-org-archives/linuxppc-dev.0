To: Steve Tarr <tarr@lucent.com>
cc: LINUX-PPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Motorola MPC8260-ADS Boot hassel 
In-Reply-To: Message from Steve Tarr <tarr@lucent.com>
   of "Thu, 01 Jun 2000 08:54:05 CST." <3936790D.9BD7680E@lucent.com>
Mime-Version: 1.0
Content-Type: text/plain
Date: Fri, 02 Jun 2000 14:29:53 +1000
Message-ID: <430.959920193@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>OK, I' stumped. I'm trying to do a port to Motorola's
>MPC8260 evaluation board using 2.3.99-pre7. Aside from
>hacking the loader and the 8260_io/uart.c to handle
>the console on SCC1, I've done nothing. The following is the
>boot messages:
>
>loaded at:     00600000 0060B288
>relocated to:  00400000 0040B288
>board data at: 00407140 00407164 <= this is within range on line above
>relocated to:  00200100 00200124
>zimage at:     00606000 00675258
>initrd at:     00675258 0084C0A3
>avail ram:     0084D000 01000000

The secondary boot code is being relocated over the top of the board data
(before it is relocated). Perhaps this is your problem?

Also, check that your uncompressed kernel image size (use objdump on vmlinux
in the top level directory - only the important sections are copied) is less
than 2Mbyte (0x200000) - if it's bigger, it will overwrite the kernel boot
arguments and relocated board data.

Finally, I have found that a NULL pointer access in wakeup_process() is
usually because something early on has prevented an essential kernel task
from being started, but somewhere else wants to wake that kernel task up
(in particular bdflush, which is woken up when buffers are low). Fix the
early problem and the NULL access goes away. But to be safe, try this:

diff -u -r1.1.1.12 buffer.c
--- buffer.c	2000/05/16 01:31:41	1.1.1.12
+++ buffer.c	2000/06/02 04:26:16
@@ -2336,7 +2336,7 @@
 {
 	DECLARE_WAITQUEUE(wait, current);

-	if (current == bdflush_tsk)
+	if (bdflush_tsk == 0 || current == bdflush_tsk)
 		return;

 	if (!block) {

Hope this helps. Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
