Message-ID: <37D93AF2.7E716F7F@chpc.utah.edu>
Date: Fri, 10 Sep 1999 11:08:02 -0600
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: controlfb.c bug in VRAM bank2 check if bank1
References: <37D929E4.205A04B8@chpc.utah.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Someone requested a re-post of the diff I'm using to get 4MB VRAM suport
using the "-u" option to diff...

diff -u linux/drivers/video/controlfb.c.orig
linux/drivers/video/controlfb.c
--- linux/drivers/video/controlfb.c.orig Mon Aug  9 13:04:57 1999
+++ linux/drivers/video/controlfb.c Wed Sep  1 12:58:19 1999
@@ -711,18 +711,19 @@
  asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0]) : "memory"
);
  bank1 = (in_8(&p->frame_buffer[0]) == 0x5a) && (in_8(&p->frame_buffer[1])
== 0xc7);

- out_8(&p->frame_buffer[0x600000], 0xa5);
- out_8(&p->frame_buffer[0x600001], 0x38);
- asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0x600000]) :
"memory" );
- bank2 = (in_8(&p->frame_buffer[0x600000]) == 0xa5)
-  && (in_8(&p->frame_buffer[0x600001]) == 0x38);
-
+ out_8(&p->frame_buffer[0x200000], 0xa5);
+ out_8(&p->frame_buffer[0x200001], 0x38);
+ asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0x200000]) :
"memory" );
+ bank2 = (in_8(&p->frame_buffer[0x200000]) == 0xa5)
+      && (in_8(&p->frame_buffer[0x200001]) == 0x38);

  p->total_vram = (bank1 + bank2) * 0x200000;
+ printk(KERN_INFO "Total VRAM = %dMB\n", (int) (p->total_vram / 1024 /
1024));
  /* If we don't have bank 1 installed, we hope we have bank 2 :-) */
  p->control_use_bank2 = !bank1;
  if (p->control_use_bank2) {
-  p->frame_buffer += 0x600000;
-  p->frame_buffer_phys += 0x600000;
+  p->frame_buffer += 0x200000;
+  p->frame_buffer_phys += 0x200000;
  }

  init_control(p);


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
