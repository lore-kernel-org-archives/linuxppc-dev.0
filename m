To: linuxppc-dev@lists.linuxppc.org
Subject: MATSHITADVD-ROM SR-8176
From: AMANO Kazuhiro <haa13142@jnb.odn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20020203155250172.VDPS.18601.t-mta3.odn.ne.jp@mta3.odn.ne.jp>
Date: Mon, 4 Feb 2002 00:52:50 +0900
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm in trouble with MATSHITA DVD-ROM SR-8176 drive on iBook2
 under kernel-2.4.18-pre7-ben0.

First problem is in audio CD play. I'm using xmms-cdread-0.14a, but
I cannot get track list of CD and cannot play.

To solve this problem, I made a tiny patch:
--- linux/drivers/ide/ide-cd.c-ORIG	Mon Jan 28 20:20:31 2002
+++ linux/drivers/ide/ide-cd.c	Sun Feb  3 22:03:42 2002
@@ -2644,7 +2644,8 @@
 	 * but they do support reading TOC & audio datas
 	 */
 	if (strcmp (drive->id->model, "MATSHITADVD-ROM SR-8187") == 0 ||
-	    strcmp (drive->id->model, "MATSHITADVD-ROM SR-8186") == 0)
+	    strcmp (drive->id->model, "MATSHITADVD-ROM SR-8186") == 0 ||
+	    strcmp (drive->id->model, "MATSHITADVD-ROM SR-8176") == 0)
 		CDROM_CONFIG_FLAGS (drive)->audio_play = 1;

 #if ! STANDARD_ATAPI
---

Second problem is in DVD-video play. I'm using xine-0.4.3 or
vlc(videolan)-0.2.92, but I get only low performance.

In /var/log/messages, some errors were reported:
Feb  3 23:40:17 phaser kernel: hdb: DMA disabled
Feb  3 23:40:17 phaser kernel: hdb: command error: status=0x51 { DriveReady SeekComplete Error }
Feb  3 23:40:17 phaser kernel: hdb: command error: error=0x54
Feb  3 23:40:17 phaser kernel: end_request: I/O error, dev 03:40 (hdb), sector 369232

I can pass through this problem, by "hdparm -d1 -X34 /deb/hdb" to force
Multiword DMA 2 Mode. But this hdparm command sometimes cause hung up.

Both problem do not appear with ide-scsi driver.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
