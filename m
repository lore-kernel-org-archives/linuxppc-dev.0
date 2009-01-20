Return-Path: <roel.kluin@gmail.com>
Message-ID: <4975F455.8020004@gmail.com>
Date: Tue, 20 Jan 2009 16:57:09 +0100
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] PS3 ps3av_set_video_mode() make id signed
References: <4972456C.1050301@gmail.com>
	<alpine.LRH.2.00.0901201018440.31271@vixen.sonytel.be>
In-Reply-To: <alpine.LRH.2.00.0901201018440.31271@vixen.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>> make id signed so a negative id will get noticed
> 
> Thanks for noticing! It looks OK, except...

> 1. You forgot to update the forward declaration of ps3av_set_video_mode() in
>    arch/powerpc/include/asm/ps3av.h (did you compile this succesfully?)

fixed that (and no, sorry, I didn't compile test it, I have to focus a bit on
a biotechnology exam, maybe later).

> 2. You forgot to change `u32 id' in ps3av_probe().

ok, changed it. but I am not sure whether the last two hunks are ok. Should
we error out like this or just let the negative value be assigned to
ps3av->ps3av_mode? If not, is there more cleanup required?

> Can you please make these changes, too? Thx again!

No problem.

--------------------->8-------------------------8<------------------------
Make id signed so a negative id will get noticed. Error out if
ps3av_auto_videomode() fails.


Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 arch/powerpc/include/asm/ps3av.h |    2 +-
 drivers/ps3/ps3av.c              |   16 ++++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/ps3av.h b/arch/powerpc/include/asm/ps3av.h
index cd24ac1..0427b0b 100644
--- a/arch/powerpc/include/asm/ps3av.h
+++ b/arch/powerpc/include/asm/ps3av.h
@@ -730,7 +730,7 @@ extern int ps3av_cmd_av_get_hw_conf(struct ps3av_pkt_av_get_hw_conf *);
 extern int ps3av_cmd_video_get_monitor_info(struct ps3av_pkt_av_get_monitor_info *,
 					    u32);
 
-extern int ps3av_set_video_mode(u32);
+extern int ps3av_set_video_mode(int);
 extern int ps3av_set_audio_mode(u32, u32, u32, u32, u32);
 extern int ps3av_get_auto_mode(void);
 extern int ps3av_get_mode(void);
diff --git a/drivers/ps3/ps3av.c b/drivers/ps3/ps3av.c
index 5324978..235e87f 100644
--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -838,7 +838,7 @@ static int ps3av_get_hw_conf(struct ps3av *ps3av)
 }
 
 /* set mode using id */
-int ps3av_set_video_mode(u32 id)
+int ps3av_set_video_mode(int id)
 {
 	int size;
 	u32 option;
@@ -940,7 +940,7 @@ EXPORT_SYMBOL_GPL(ps3av_audio_mute);
 static int ps3av_probe(struct ps3_system_bus_device *dev)
 {
 	int res;
-	u32 id;
+	int id;
 
 	dev_dbg(&dev->core, " -> %s:%d\n", __func__, __LINE__);
 	dev_dbg(&dev->core, "  timeout=%d\n", timeout);
@@ -962,8 +962,10 @@ static int ps3av_probe(struct ps3_system_bus_device *dev)
 	init_completion(&ps3av->done);
 	complete(&ps3av->done);
 	ps3av->wq = create_singlethread_workqueue("ps3avd");
-	if (!ps3av->wq)
+	if (!ps3av->wq) {
+		res = -ENOMEM;
 		goto fail;
+	}
 
 	switch (ps3_os_area_get_av_multi_out()) {
 	case PS3_PARAM_AV_MULTI_OUT_NTSC:
@@ -994,6 +996,12 @@ static int ps3av_probe(struct ps3_system_bus_device *dev)
 		safe_mode = 1;
 #endif /* CONFIG_FB */
 	id = ps3av_auto_videomode(&ps3av->av_hw_conf);
+	if (id < 0) {
+		printk(KERN_ERR "%s: invalid id :%d\n", __func__, id);
+		res = -EINVAL;
+		goto fail;
+	}
+
 	safe_mode = 0;
 
 	mutex_lock(&ps3av->mutex);
@@ -1007,7 +1015,7 @@ static int ps3av_probe(struct ps3_system_bus_device *dev)
 fail:
 	kfree(ps3av);
 	ps3av = NULL;
-	return -ENOMEM;
+	return res;
 }
 
 static int ps3av_remove(struct ps3_system_bus_device *dev)
