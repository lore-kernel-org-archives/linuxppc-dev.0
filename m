Date: Sat, 3 Jan 2004 19:32:42 +0100
From: Samuel Rydh <samuel@ibrium.se>
To: linuxppc-dev@lists.linuxppc.org
Cc: benh@kernel.crashing.org
Subject: [PATCH] radeonfb fix
Message-ID: <20040103183242.GB1309@ibrium.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

The following patch is necessary to get the 2.6 radeonfb driver to detect
the flatpanel display. I believe the 2.4 code does exactly the same thing.


===== drivers/video/radeonfb.c 1.32 vs edited =====
--- 1.32/drivers/video/radeonfb.c	Fri Nov  7 13:07:07 2003
+++ edited/drivers/video/radeonfb.c	Sat Jan  3 17:20:25 2004
@@ -947,7 +947,7 @@
 	tmp = INREG(RADEON_BIOS_4_SCRATCH);
 	printk(KERN_DEBUG "radeon_get_moninfo: bios 4 scratch = %x\n", tmp);

-	if (rinfo->hasCRTC2) {
+	if (rinfo->hasCRTC2 && tmp ) {
 		/* primary DVI port */
 		if (tmp & 0x08)
 			rinfo->dviDisp_type = MT_DFP;


/Samuel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
