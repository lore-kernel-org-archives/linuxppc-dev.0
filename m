Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 2DD15DEC7D
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 04:02:47 +1100 (EST)
Date: Tue, 30 Jan 2007 18:02:45 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 8/10] ps3: disable display flipping during mode changes
In-Reply-To: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0701301802280.29487@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If ps3fb is available, we have to disable display flipping while changing the
audio or video mode.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/ps3/ps3av_cmd.c     |    5 ++++-
 include/asm-powerpc/ps3fb.h |   10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

--- ps3-linux-2.6.20-rc6.orig/drivers/ps3/ps3av_cmd.c
+++ ps3-linux-2.6.20-rc6/drivers/ps3/ps3av_cmd.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <asm/ps3av.h>
+#include <asm/ps3fb.h>
 #include <asm/ps3.h>
 
 
@@ -850,8 +851,9 @@ int ps3av_cmd_avb_param(struct ps3av_pkt
 {
 	int res;
 
-	/* avb packet */
+	ps3fb_flip_ctl(0);	/* flip off */
 
+	/* avb packet */
 	res = ps3av_do_pkt(PS3AV_CID_AVB_PARAM, send_len, sizeof(*avb),
 			   &avb->send_hdr);
 	if (res < 0)
@@ -863,6 +865,7 @@ int ps3av_cmd_avb_param(struct ps3av_pkt
 			 res);
 
       out:
+	ps3fb_flip_ctl(1);	/* flip on */
 	return res;
 }
 
--- ps3-linux-2.6.20-rc6.orig/include/asm-powerpc/ps3fb.h
+++ ps3-linux-2.6.20-rc6/include/asm-powerpc/ps3fb.h
@@ -41,4 +41,14 @@ struct ps3fb_ioctl_res {
 	__u32 num_frames; /* num of frame buffers */
 };
 
+#ifdef __KERNEL__
+
+#ifdef CONFIG_FB_PS3
+extern void ps3fb_flip_ctl(int);
+#else
+static inline void ps3fb_flip_ctl(int) {}
+#endif
+
+#endif /* __KERNEL__ */
+
 #endif /* _ASM_POWERPC_PS3FB_H_ */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
