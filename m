Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw5.extranet.tce.com (dmzraw5.extranet.tce.com
	[157.254.234.142]) by ozlabs.org (Postfix) with ESMTP id EC596687DE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Nov 2005 03:06:37 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 29 Nov 2005 16:37:12 +0100
Message-ID: <1CFEB358338412458B21FAA0D78FE86D042A2EF6@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "David Jander" <david.jander@protonic.nl>
Cc: linux-mtd@lists.infradead.org, linuxppc-embedded@ozlabs.org
Subject: RE: Which way to store log in flash on mpc8xx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David Jander wrote:
[..]
>After getting some advice from peoble at mtd-list, I switched to 2.6.14
for=20
>our new developments, and jffs2 seems a lot more stable now. I can only

>recommend you to consider switching. Besides consuming a little more
RAM and=20
>Flash, 2.6.14 is miles ahead in terms of almost anything else, plus
it's a=20
>bit faster on 8xx than 2.4.25!!

Strange. I heard a different song here[1], but haven't checked the fact=20
myself. From what I've seen, mtd/jffs2 is faster on 2.6.x than 2.4.x.

[1] http://www.denx.de/wiki/Know/Linux24vs26

>I have to warn you though, that it still seems not to be as rock-solid
as one=20
>might want for an embedded system: We have a stress test running for a
few=20
>weeks now simulating power-failures during writes to files on jffs2,
and mtd=20
>has some occasional hick-ups. Those hick-ups seem to be far less
serious than=20
>gc.c crashing, but we will have to take them into account in our
application.
>This is the situation: Sometimes the test application crashes giving a=20
>write-error on the mtd device, preceded by an error message from the=20
>mtd-driver (and jffs2, but the problem seems to come from mtd). The
error=20
>message is like "MTD do_write_buffer(): software timeout", which
normally=20

See the patch past my sig. It changes the timeout from couple ms to 1
second.
RTAI & Xenomai users should need it. IMHO, the WANT_SHORT_WTIMEOUT
embraced code should simply go away, or get a decent explanation.

>means a flash programming error, most probably due to sector beeing
worn out,=20
>but I don't think that is the case, since those problems began
appearing=20
>quite early and went away all by them selves. Flash doesn't magically
"fix"=20
itself over time, does it?
>Maybe it's a problem in the AMD flash driver (our device is a Spansion=20
Mirror-bit S29GL256M11)

Regards,
--=20
Stephane


--- drivers/mtd/chips/cfi_cmdset_0002.c	12 Sep 2005 09:27:29 -0000
+++ drivers/mtd/chips/cfi_cmdset_0002.c	29 Nov 2005 15:30:30 -0000
@@ -935,6 +935,12 @@
 	struct cfi_private *cfi =3D map->fldrv_priv;
 	unsigned long timeo =3D jiffies + HZ;
 	/*
+	 * Hardware errors should be infrequent,
+	 * so a short timeout is of no benefit.
+	 * And it just hurts with RTAI.
+	 */
+#ifdef WANT_SHORT_WTIMEOUT
+	/*
 	 * We use a 1ms + 1 jiffies generic timeout for writes (most
devices
 	 * have a max write time of a few hundreds usec). However, we
should
 	 * use the maximum timeout value given by the chip at probe time
@@ -944,6 +950,7 @@
 	 * timeout of 0 jiffies if HZ is smaller than 1000.
 	 */
 	unsigned long uWriteTimeout =3D ( HZ / 1000 ) + 1;
+#endif
 	int ret =3D 0;
 	map_word oldd;
 	int retry_cnt =3D 0;
@@ -987,8 +994,10 @@
 				adr, map_bankwidth(map),
 				chip->word_write_time);
=20
+#ifdef WANT_SHORT_WTIMEOUT
 	/* See comment above for timeout value. */
 	timeo =3D jiffies + uWriteTimeout;=20
+#endif
 	for (;;) {
 		if (chip->state !=3D FL_WRITING) {
 			/* Someone's suspended the write. Sleep */
@@ -1189,8 +1198,15 @@
 {
 	struct cfi_private *cfi =3D map->fldrv_priv;
 	unsigned long timeo =3D jiffies + HZ;
+	/*
+	 * Hardware errors should be infrequent,
+	 * so a short timeout is of no benefit.
+	 * And it just hurts with RTAI.
+	 */
+#ifdef WANT_SHORT_WTIMEOUT
 	/* see comments in do_write_oneword() regarding uWriteTimeo. */
 	unsigned long uWriteTimeout =3D ( HZ / 1000 ) + 1;
+#endif
 	int ret =3D -EIO;
 	unsigned long cmd_adr;
 	int z, words;
@@ -1248,7 +1264,9 @@
 				adr, map_bankwidth(map),
 				chip->word_write_time);
=20
+#ifdef WANT_SHORT_WTIMEOUT
 	timeo =3D jiffies + uWriteTimeout;=20
+#endif
 	=09
 	for (;;) {
 		if (chip->state !=3D FL_WRITING) {
