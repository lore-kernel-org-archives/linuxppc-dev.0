Message-Id: <200006280817.BAA22010@soda.csua.Berkeley.edu>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Turn off Extra-Brightness on ATI XClaim 3D+
Date: Wed, 28 Jun 2000 01:17:24 -0700
From: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

In the 2.2.16 kernel source extra brightness is enabled for ATI XClaim
3D+ cards.  It should not be enabled as it causes the screen to appear
completely washed out even in console mode. A patch that fixes the
problem is attached to this email.

Thanks,

----ranga <ranga@soda.berkeley.edu>

--- drivers/video/atyfb.c.orig  Tue Jun 27 20:33:01 2000
+++ drivers/video/atyfb.c       Tue Jun 27 20:39:40 2000
@@ -3476,7 +3476,7 @@
     if (Gx == GT_CHIP_ID || Gx == GU_CHIP_ID || Gx == GV_CHIP_ID ||
        Gx == GW_CHIP_ID || Gx == GZ_CHIP_ID || Gx == LG_CHIP_ID ||
        Gx == GB_CHIP_ID || Gx == GD_CHIP_ID || Gx == GI_CHIP_ID ||
-       Gx == GP_CHIP_ID || Gx == GQ_CHIP_ID)
+       Gx == GP_CHIP_ID || Gx == GQ_CHIP_ID || Gx == LI_CHIP_ID)
        i |= 0x2;       /*DAC_CNTL|0x2 turns off the extra brightness for gt*/
     aty_st_8(DAC_CNTL, i, info);
     aty_st_8(DAC_MASK, 0xff, info);


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
