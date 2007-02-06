Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 2219BDDED2
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 02:01:11 +1100 (EST)
Date: Tue, 6 Feb 2007 16:01:06 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 0/10] ps3av/fb drivers for 2.6.21
In-Reply-To: <Pine.LNX.4.62.0702051624410.18405@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0702061559420.14230@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
	<Pine.LNX.4.62.0702051624410.18405@pademelon.sonytel.be>
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

On Mon, 5 Feb 2007, Geert Uytterhoeven wrote:
> On Tue, 30 Jan 2007, Geert Uytterhoeven wrote:
> > This is the second submission of the PS3 AV Settings Driver Library and the PS3
> > Virtual Frame Buffer Driver. I incorporated most (all?) of the very valuable
> > feedback I received, except for the removal of the long delays (msleep()) in
> > ps3av, which is still on my todo-list.
> 
> I tried removing the msleep() from the video mode setting path, cfr. the patch
> at the bottom of this email:
>   - Use schedule_delayed_work() and a simple state machine instead of long
>     msleep() calls in the video mode setting path,
>   - Add a semaphore to protect against starting a new mode setting while the
>     previous one hasn't finished yet.
> 
> Unfortunately I ran into a new problem: fb_flashcursor() is also called from
> workqueue context. fb_flashcursor() wants to acquire the console semaphore,
> which may be held by the next mode setting request. Hence my delayed work
> routine is no longer called, and ps3av.mode_sem() is never kicked => deadlock.

Here is an alternative approach which doesn't suffer from this problem, using
a kernel thread and 2 semaphores. Does this look OK?
Thanks for your comments!

ps3av: Use a kernel thread to handle the actual video mode setting, as this
involves some quite big delays.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/ps3/ps3av.c         |   54 +++++++++++++++++++++++++++-----------------
 include/asm-powerpc/ps3av.h |    3 ++
 2 files changed, 37 insertions(+), 20 deletions(-)

--- ps3-linux-2.6.20.orig/drivers/ps3/ps3av.c
+++ ps3-linux-2.6.20/drivers/ps3/ps3av.c
@@ -432,13 +432,24 @@ int ps3av_set_audio_mode(u32 ch, u32 fs,
 
 EXPORT_SYMBOL_GPL(ps3av_set_audio_mode);
 
-static int ps3av_set_videomode(u32 id, u32 old_id)
+static int ps3av_set_videomode(void)
+{
+	/* av video mute */
+	ps3av_set_av_video_mute(PS3AV_CMD_MUTE_ON);
+
+	/* wake up ps3avd */
+	up(&ps3av.ping);
+
+	return 0;
+}
+
+static void ps3av_set_videomode_cont(u32 id, u32 old_id)
 {
 	struct ps3av_pkt_avb_param avb_param;
 	int i;
-	u32 len = 0, av_video_cs = 0;
+	u32 len = 0, av_video_cs;
 	const struct avset_video_mode *video_mode;
-	int res, event = 0;
+	int res;
 
 	video_mode = &video_mode_table[id & PS3AV_MODE_MASK];
 
@@ -448,17 +459,6 @@ static int ps3av_set_videomode(u32 id, u
 					ps3av.av_hw_conf.num_of_avmulti;
 	avb_param.num_of_av_audio_pkt = 0;
 
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
 	/* video signal off */
 	ps3av_set_video_disable_sig();
 
@@ -511,7 +511,19 @@ static int ps3av_set_videomode(u32 id, u
 	msleep(1500);
 	/* av video mute */
 	ps3av_set_av_video_mute(PS3AV_CMD_MUTE_OFF);
+}
 
+static int ps3avd(void *p)
+{
+	struct ps3av *info = p;
+
+	daemonize("ps3avd");
+	while (1) {
+		down(&info->ping);
+		ps3av_set_videomode_cont(info->ps3av_mode,
+					 info->ps3av_mode_old);
+		up(&info->pong);
+	}
 	return 0;
 }
 
@@ -689,7 +701,7 @@ static int ps3av_get_hw_conf(struct ps3a
 int ps3av_set_video_mode(u32 id, int boot)
 {
 	int size;
-	u32 option, old_id;
+	u32 option;
 
 	size = ARRAY_SIZE(video_mode_table);
 	if ((id & PS3AV_MODE_MASK) > size - 1 || id < 0) {
@@ -711,12 +723,11 @@ int ps3av_set_video_mode(u32 id, int boo
 	}
 
 	/* set videomode */
-	mutex_lock(&ps3av.mutex);
-	old_id = ps3av.ps3av_mode;
+	down(&ps3av.pong);
+	ps3av.ps3av_mode_old = ps3av.ps3av_mode;
 	ps3av.ps3av_mode = id;
-	if (ps3av_set_videomode(id, old_id))
-		ps3av.ps3av_mode = old_id;
-	mutex_unlock(&ps3av.mutex);
+	if (ps3av_set_videomode())
+		ps3av.ps3av_mode = ps3av.ps3av_mode_old;
 
 	return 0;
 }
@@ -868,9 +879,12 @@ static int ps3av_probe(struct ps3_vuart_
 	memset(&ps3av, 0, sizeof(ps3av));
 
 	init_MUTEX(&ps3av.sem);
+	init_MUTEX_LOCKED(&ps3av.ping);
+	init_MUTEX(&ps3av.pong);
 	mutex_init(&ps3av.mutex);
 	ps3av.ps3av_mode = 0;
 	ps3av.dev = dev;
+	kernel_thread(ps3avd, &ps3av, CLONE_KERNEL);
 
 	ps3av.available = 1;
 	switch (ps3_os_area_get_av_multi_out()) {
--- ps3-linux-2.6.20.orig/include/asm-powerpc/ps3av.h
+++ ps3-linux-2.6.20/include/asm-powerpc/ps3av.h
@@ -646,6 +646,8 @@ struct ps3av_pkt_avb_param {
 struct ps3av {
 	int available;
 	struct semaphore sem;
+	struct semaphore ping;
+	struct semaphore pong;
 	struct mutex mutex;
 	int open_count;
 	struct ps3_vuart_port_device *dev;
@@ -657,6 +659,7 @@ struct ps3av {
 	u32 head[PS3AV_HEAD_MAX];
 	u32 audio_port;
 	int ps3av_mode;
+	int ps3av_mode_old;
 };
 
 /** command status **/

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
