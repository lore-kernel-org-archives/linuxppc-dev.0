From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16004.27866.270601.561756@gargle.gargle.HOWL>
Date: Fri, 28 Mar 2003 16:40:10 +0100
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.4.x swim3 performance problem on PM4400 identified
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


With 2.4 kernels, writes to floppy are about a factor of 10 slower
on my PowerMac 4400 than they are with 2.2 kernels.

The cause for this is a poll-loop in swim3.c which doesn't exist
in the 2.2 version. The patch below reverts that change, and
restores floppy write performance to 2.2 levels. I've built many
boot floppies with this modified driver w/o any problems.

/Mikael

--- linux-2.4.21-pre6/drivers/block/swim3.c.~1~	Wed Aug  7 00:52:20 2002
+++ linux-2.4.21-pre6/drivers/block/swim3.c	Fri Mar 28 16:02:17 2003
@@ -679,10 +679,14 @@
 			break;
 		dr = fs->dma;
 		cp = fs->dma_cmd;
+#if 0	/* This causes massive performance problems for my PM4400. /Mikael */
 		/* We must wait a bit for dbdma to complete */
 		for (n=0; (in_le32(&dr->status) & ACTIVE) && n < 1000; n++)
 			udelay(10);
 		DBDMA_DO_STOP(dr);
+#else	/* This is from 2.2 and it works much better for my PM4400. /Mikael */
+		st_le32(&dr->control, RUN << 16);
+#endif
 		out_8(&sw->intr_enable, 0);
 		out_8(&sw->control_bic, WRITE_SECTORS | DO_ACTION);
 		out_8(&sw->select, RELAX);

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
