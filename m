Return-Path: <venkatram867@gmail.com>
From: Venkatram Tummala <venkatram867@gmail.com>
To: geoff@infradead.org
Subject: [PATCH] PS3: Fixed Coding Style Issues in ps3av.c
Date: Fri, 12 Aug 2011 01:52:53 -0700
Message-Id: <1313139173-25049-1-git-send-email-venkatram867@gmail.com>
Cc: cbe-oss-dev@lists.ozlabs.org, Venkatram Tummala <venkatram867@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixed a coding style issue

Signed-off-by: Venkatram Tummala <venkatram867@gmail.com>
---
 drivers/ps3/ps3av.c |   21 ++++++++-------------
 1 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/ps3/ps3av.c b/drivers/ps3/ps3av.c
index a409fa0..e6d1a3d 100644
--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -26,7 +26,7 @@
 #include <linux/fb.h>
 #include <linux/slab.h>
 
-#include <asm/firmware.h>
+#include <linux/firmware.h>
 #include <asm/ps3av.h>
 #include <asm/ps3.h>
 
@@ -338,7 +338,7 @@ int ps3av_do_pkt(u32 cid, u16 send_len, size_t usr_buf_size,
 	mutex_unlock(&ps3av->mutex);
 	return 0;
 
-      err:
+err:
 	mutex_unlock(&ps3av->mutex);
 	printk(KERN_ERR "%s: failed cid:%x res:%d\n", __func__, cid, res);
 	return res;
@@ -477,7 +477,6 @@ int ps3av_set_audio_mode(u32 ch, u32 fs, u32 word_bits, u32 format, u32 source)
 
 	return 0;
 }
-
 EXPORT_SYMBOL_GPL(ps3av_set_audio_mode);
 
 static int ps3av_set_videomode(void)
@@ -501,7 +500,8 @@ static void ps3av_set_videomode_packet(u32 id)
 
 	video_mode = &video_mode_table[id & PS3AV_MODE_MASK];
 
-	avb_param.num_of_video_pkt = PS3AV_AVB_NUM_VIDEO;	/* num of head */
+	/* num of head */
+	avb_param.num_of_video_pkt = PS3AV_AVB_NUM_VIDEO;
 	avb_param.num_of_audio_pkt = 0;
 	avb_param.num_of_av_video_pkt = ps3av->av_hw_conf.num_of_hdmi +
 					ps3av->av_hw_conf.num_of_avmulti;
@@ -590,8 +590,8 @@ static void ps3avd(struct work_struct *work)
 #define SHIFT_VESA	8
 
 static const struct {
-	unsigned mask : 19;
-	unsigned id :  4;
+	unsigned mask:19;
+	unsigned id:4;
 } ps3av_preferred_modes[] = {
 	{ PS3AV_RESBIT_WUXGA      << SHIFT_VESA, PS3AV_MODE_WUXGA   },
 	{ PS3AV_RESBIT_1920x1080P << SHIFT_60,   PS3AV_MODE_1080P60 },
@@ -667,7 +667,8 @@ static enum ps3av_mode_num ps3av_hdmi_get_id(struct ps3av_info_monitor *info)
 	return id;
 }
 
-static void ps3av_monitor_info_dump(const struct ps3av_pkt_av_get_monitor_info *monitor_info)
+static void ps3av_monitor_info_dump(const struct ps3av_pkt_av_get_monitor_info *
+		monitor_info)
 {
 	const struct ps3av_info_monitor *info = &monitor_info->info;
 	const struct ps3av_info_audio *audio = info->audio;
@@ -870,21 +871,18 @@ int ps3av_set_video_mode(int id)
 
 	return 0;
 }
-
 EXPORT_SYMBOL_GPL(ps3av_set_video_mode);
 
 int ps3av_get_auto_mode(void)
 {
 	return ps3av_auto_videomode(&ps3av->av_hw_conf);
 }
-
 EXPORT_SYMBOL_GPL(ps3av_get_auto_mode);
 
 int ps3av_get_mode(void)
 {
 	return ps3av ? ps3av->ps3av_mode : 0;
 }
-
 EXPORT_SYMBOL_GPL(ps3av_get_mode);
 
 /* get resolution by video_mode */
@@ -902,7 +900,6 @@ int ps3av_video_mode2res(u32 id, u32 *xres, u32 *yres)
 	*yres = video_mode_table[id].y;
 	return 0;
 }
-
 EXPORT_SYMBOL_GPL(ps3av_video_mode2res);
 
 /* mute */
@@ -911,7 +908,6 @@ int ps3av_video_mute(int mute)
 	return ps3av_set_av_video_mute(mute ? PS3AV_CMD_MUTE_ON
 					    : PS3AV_CMD_MUTE_OFF);
 }
-
 EXPORT_SYMBOL_GPL(ps3av_video_mute);
 
 /* mute analog output only */
@@ -935,7 +931,6 @@ int ps3av_audio_mute(int mute)
 	return ps3av_set_audio_mute(mute ? PS3AV_CMD_MUTE_ON
 					 : PS3AV_CMD_MUTE_OFF);
 }
-
 EXPORT_SYMBOL_GPL(ps3av_audio_mute);
 
 static int __devinit ps3av_probe(struct ps3_system_bus_device *dev)
-- 
1.7.0.4
