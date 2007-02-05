Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 90ED8DDE24
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 02:33:23 +1100 (EST)
Date: Mon, 5 Feb 2007 16:33:21 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 0/10] ps3av/fb drivers for 2.6.21
In-Reply-To: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0702051624410.18405@pademelon.sonytel.be>
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

On Tue, 30 Jan 2007, Geert Uytterhoeven wrote:
> This is the second submission of the PS3 AV Settings Driver Library and the PS3
> Virtual Frame Buffer Driver. I incorporated most (all?) of the very valuable
> feedback I received, except for the removal of the long delays (msleep()) in
> ps3av, which is still on my todo-list.

I tried removing the msleep() from the video mode setting path, cfr. the patch
at the bottom of this email:
  - Use schedule_delayed_work() and a simple state machine instead of long
    msleep() calls in the video mode setting path,
  - Add a semaphore to protect against starting a new mode setting while the
    previous one hasn't finished yet.

Unfortunately I ran into a new problem: fb_flashcursor() is also called from
workqueue context. fb_flashcursor() wants to acquire the console semaphore,
which may be held by the next mode setting request. Hence my delayed work
routine is no longer called, and ps3av.mode_sem() is never kicked => deadlock.

This simple patch works around the problem, but I'm afraid that's not a good
solution:
--- ps3-linux-2.6.20.orig/drivers/video/console/fbcon.c
+++ ps3-linux-2.6.20/drivers/video/console/fbcon.c
@@ -392,7 +392,10 @@ static void fb_flashcursor(struct work_s
 	int c;
 	int mode;
 
-	acquire_console_sem();
+if (try_acquire_console_sem()) {
+	printk("fb_flashcursor: cannot acquire console sem\n");
+	return;
+}
 	if (ops && ops->currcon != -1)
 		vc = vc_cons[ops->currcon].d;
 
Anyone with a suggestion?

--- ps3-linux-2.6.20.orig/drivers/ps3/ps3av.c
+++ ps3-linux-2.6.20/drivers/ps3/ps3av.c
@@ -257,7 +257,7 @@ int ps3av_do_pkt(u32 cid, u16 send_len, 
 
 	BUG_ON(!ps3av.available);
 
-	if (down_interruptible(&ps3av.sem))
+	if (down_interruptible(&ps3av.pkt_sem))
 		return -ERESTARTSYS;
 
 	table = ps3av_search_cmd_table(cid, PS3AV_CID_MASK);
@@ -288,11 +288,11 @@ int ps3av_do_pkt(u32 cid, u16 send_len, 
 		goto err;
 	}
 
-	up(&ps3av.sem);
+	up(&ps3av.pkt_sem);
 	return 0;
 
       err:
-	up(&ps3av.sem);
+	up(&ps3av.pkt_sem);
 	printk(KERN_ERR "%s: failed cid:%x res:%d\n", __FUNCTION__, cid, res);
 	return res;
 }
@@ -313,13 +313,10 @@ static int ps3av_set_av_video_mute(u32 m
 	return 0;
 }
 
-static int ps3av_set_video_disable_sig(void)
+static int ps3av_set_video_disable_sig_tv(void)
 {
-	int i, num_of_hdmi_port, num_of_av_port, res;
-
-	num_of_hdmi_port = ps3av.av_hw_conf.num_of_hdmi;
-	num_of_av_port = ps3av.av_hw_conf.num_of_hdmi +
-	    ps3av.av_hw_conf.num_of_avmulti;
+	int num_of_hdmi_port = ps3av.av_hw_conf.num_of_hdmi;
+	int i, res;
 
 	/* tv mute */
 	for (i = 0; i < num_of_hdmi_port; i++) {
@@ -328,7 +325,15 @@ static int ps3av_set_video_disable_sig(v
 		if (res < 0)
 			return -1;
 	}
-	msleep(100);
+	return 0;
+}
+
+static int ps3av_set_video_disable_sig_video(void)
+{
+	int num_of_hdmi_port = ps3av.av_hw_conf.num_of_hdmi;
+	int num_of_av_port = ps3av.av_hw_conf.num_of_hdmi +
+			     ps3av.av_hw_conf.num_of_avmulti;
+	int i, res;
 
 	/* video mute on */
 	for (i = 0; i < num_of_av_port; i++) {
@@ -342,8 +347,6 @@ static int ps3av_set_video_disable_sig(v
 				return -1;
 		}
 	}
-	msleep(300);
-
 	return 0;
 }
 
@@ -431,35 +435,20 @@ int ps3av_set_audio_mode(u32 ch, u32 fs,
 
 EXPORT_SYMBOL_GPL(ps3av_set_audio_mode);
 
-static int ps3av_set_videomode(u32 id, u32 old_id)
+static void ps3av_do_mode_change(u32 id, u32 old_id)
 {
-	struct ps3av_pkt_avb_param avb_param;
-	int i;
-	u32 len = 0, av_video_cs = 0;
+	struct ps3av_pkt_avb_param *avb_param = &ps3av.avb_param;
+	int res, i;
+	u32 len = 0, av_video_cs;
 	const struct avset_video_mode *video_mode;
-	int res, event = 0;
 
 	video_mode = &video_mode_table[id & PS3AV_MODE_MASK];
 
-	avb_param.num_of_video_pkt = PS3AV_AVB_NUM_VIDEO;	/* num of head */
-	avb_param.num_of_audio_pkt = 0;
-	avb_param.num_of_av_video_pkt = ps3av.av_hw_conf.num_of_hdmi +
-					ps3av.av_hw_conf.num_of_avmulti;
-	avb_param.num_of_av_audio_pkt = 0;
-
-	/* send command packet */
-	if (event) {
-		/* event enable */
-		res = ps3av_cmd_enable_event();
-		if (res < 0)
-			dev_dbg(&ps3av_dev.core,
-				"ps3av_cmd_enable_event failed \n");
-	}
-
-	/* av video mute */
-	ps3av_set_av_video_mute(PS3AV_CMD_MUTE_ON);
-	/* video signal off */
-	ps3av_set_video_disable_sig();
+	avb_param->num_of_video_pkt = PS3AV_AVB_NUM_VIDEO;	/* num of head */
+	avb_param->num_of_audio_pkt = 0;
+	avb_param->num_of_av_video_pkt = ps3av.av_hw_conf.num_of_hdmi +
+					 ps3av.av_hw_conf.num_of_avmulti;
+	avb_param->num_of_av_audio_pkt = 0;
 
 	/* Retail PS3 product doesn't support this */
 	if (id & PS3AV_MODE_HDCP_OFF) {
@@ -477,12 +466,12 @@ static int ps3av_set_videomode(u32 id, u
 	}
 
 	/* video_pkt */
-	for (i = 0; i < avb_param.num_of_video_pkt; i++)
-		len += ps3av_cmd_set_video_mode(&avb_param.buf[len],
+	for (i = 0; i < avb_param->num_of_video_pkt; i++)
+		len += ps3av_cmd_set_video_mode(&avb_param->buf[len],
 						ps3av.head[i], video_mode->vid,
 						video_mode->fmt, id);
 	/* av_video_pkt */
-	for (i = 0; i < avb_param.num_of_av_video_pkt; i++) {
+	for (i = 0; i < avb_param->num_of_av_video_pkt; i++) {
 		if (id & PS3AV_MODE_DVI || id & PS3AV_MODE_RGB)
 			av_video_cs = RGB8;
 		else
@@ -492,24 +481,70 @@ static int ps3av_set_videomode(u32 id, u
 		    ps3av.av_port[i] == PS3AV_CMD_AVPORT_HDMI_1)
 			av_video_cs = RGB8;	/* use RGB for HDMI */
 #endif
-		len += ps3av_cmd_set_av_video_cs(&avb_param.buf[len],
+		len += ps3av_cmd_set_av_video_cs(&avb_param->buf[len],
 						 ps3av.av_port[i],
 						 video_mode->vid, av_video_cs,
 						 video_mode->aspect, id);
 	}
 	/* send command using avb pkt */
 	len += offsetof(struct ps3av_pkt_avb_param, buf);
-	res = ps3av_cmd_avb_param(&avb_param, len);
+	res = ps3av_cmd_avb_param(avb_param, len);
 	if (res == PS3AV_STATUS_NO_SYNC_HEAD)
 		printk(KERN_WARNING
 		       "%s: Command failed. Please try your request again. \n",
 		       __FUNCTION__);
 	else if (res)
 		dev_dbg(&ps3av_dev.core, "ps3av_cmd_avb_param failed\n");
+}
+
+static void ps3av_next_videomode_state(int state, unsigned int ms)
+{
+	ps3av.mode_set_state = state;
+	schedule_delayed_work(&ps3av.work, ms*HZ/1000);
+}
+
+static void ps3av_delayed_set_videomode(struct work_struct *work)
+{
+	int res;
+
+	dev_dbg(&ps3av_dev.core, "%s state %d\n", __FUNCTION__,
+		ps3av.mode_set_state);
+
+	switch (ps3av.mode_set_state) {
+	    case 1:
+		res = ps3av_set_video_disable_sig_video();
+		ps3av_next_videomode_state(2, res ? 0 : 300);
+		break;
+
+	    case 2:
+		ps3av_do_mode_change(ps3av.ps3av_mode, ps3av.ps3av_mode_old);
+		ps3av_next_videomode_state(3, 1500);
+		break;
+
+	    case 3:
+		/* av video mute */
+		ps3av_set_av_video_mute(PS3AV_CMD_MUTE_OFF);
+		/* kick semaphore */
+		up(&ps3av.mode_sem);
+		break;
+	}
+}
+
+static int ps3av_set_videomode(u32 id, u32 old_id)
+{
+	int res;
 
-	msleep(1500);
 	/* av video mute */
-	ps3av_set_av_video_mute(PS3AV_CMD_MUTE_OFF);
+	ps3av_set_av_video_mute(PS3AV_CMD_MUTE_ON);
+
+	/* video signal off */
+	/* tv mute */
+	res = ps3av_set_video_disable_sig_tv();
+	if (res) {
+		/* if mute failed, proceed immediately with the mode change */
+		ps3av_next_videomode_state(2, 0);
+	} else
+		ps3av_next_videomode_state(1, 100);
 
 	return 0;
 }
@@ -688,7 +723,7 @@ static int ps3av_get_hw_conf(struct ps3a
 int ps3av_set_video_mode(u32 id, int boot)
 {
 	int size;
-	u32 option, old_id;
+	u32 option;
 
 	size = ARRAY_SIZE(video_mode_table);
 	if ((id & PS3AV_MODE_MASK) > size - 1 || id < 0) {
@@ -710,12 +745,11 @@ int ps3av_set_video_mode(u32 id, int boo
 	}
 
 	/* set videomode */
-	mutex_lock(&ps3av.mutex);
-	old_id = ps3av.ps3av_mode;
+	down(&ps3av.mode_sem);
+	ps3av.ps3av_mode_old = ps3av.ps3av_mode;
 	ps3av.ps3av_mode = id;
-	if (ps3av_set_videomode(id, old_id))
-		ps3av.ps3av_mode = old_id;
-	mutex_unlock(&ps3av.mutex);
+	if (ps3av_set_videomode(id, ps3av.ps3av_mode_old))
+		ps3av.ps3av_mode = ps3av.ps3av_mode_old;
 
 	return 0;
 }
@@ -866,10 +900,12 @@ static int ps3av_probe(struct ps3_vuart_
 
 	memset(&ps3av, 0, sizeof(ps3av));
 
-	init_MUTEX(&ps3av.sem);
+	init_MUTEX(&ps3av.pkt_sem);
+	init_MUTEX(&ps3av.mode_sem);
 	mutex_init(&ps3av.mutex);
 	ps3av.ps3av_mode = 0;
 	ps3av.dev = dev;
+	INIT_DELAYED_WORK(&ps3av.work, ps3av_delayed_set_videomode);
 
 	ps3av.available = 1;
 	switch (ps3_os_area_get_av_multi_out()) {
--- ps3-linux-2.6.20.orig/include/asm-powerpc/ps3av.h
+++ ps3-linux-2.6.20/include/asm-powerpc/ps3av.h
@@ -19,6 +19,7 @@
 #define _ASM_POWERPC_PS3AV_H_
 
 #include <linux/mutex.h>
+#include <linux/workqueue.h>
 
 /** command for ioctl() **/
 #define PS3AV_VERSION 0x205	/* version of ps3av command */
@@ -645,10 +646,12 @@ struct ps3av_pkt_avb_param {
 
 struct ps3av {
 	int available;
-	struct semaphore sem;
+	struct semaphore pkt_sem;
+	struct semaphore mode_sem;
 	struct mutex mutex;
 	int open_count;
 	struct ps3_vuart_port_device *dev;
+	struct delayed_work work;
 
 	int region;
 	struct ps3av_pkt_av_get_hw_conf av_hw_conf;
@@ -657,6 +660,10 @@ struct ps3av {
 	u32 head[PS3AV_HEAD_MAX];
 	u32 audio_port;
 	int ps3av_mode;
+
+	int ps3av_mode_old;
+	struct ps3av_pkt_avb_param avb_param;
+	int mode_set_state;
 };
 
 /** command status **/

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
