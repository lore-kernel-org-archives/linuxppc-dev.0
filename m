Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6C6BE67B7F
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Jul 2006 06:06:58 +1000 (EST)
Date: Tue, 25 Jul 2006 22:06:50 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: powermac: More powermac backlight fixes
Message-ID: <20060725200650.GA13687@hansmi.ch>
References: <20060715130900.GA29287@hansmi.ch>
	<20060724200315.d3c80ed0.akpm@osdl.org>
	<20060725184406.GA12226@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060725184406.GA12226@hansmi.ch>
Cc: linuxppc-dev@ozlabs.org, johannes@sipsolutions.net, aris@valeta.org,
	linux-kernel@killerfox.forkbomb.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 25, 2006 at 08:44:06PM +0200, Michael Hanselmann wrote:
> On Mon, Jul 24, 2006 at 08:03:15PM -0700, Andrew Morton wrote:
> > I see schedule_work()s in there, but no flush_scheduled_work()s or anything
> > like that.  Generally, this means there are races against rmmod, close(),
> > etc.

After discussing it with Aristeu, we came to the conclusion that it's
not dangerous. The generic backlight code can not be compiled as a
module. If a framebuffer driver unloads, it'll set pmac_backlight to
NULL. The workers check for it and don't do anything if true. So, if the
worker is called after unloading the module, it won't do anything.

Here's the other patch which fixes a little error in the patch you just
added to your tree. Without the patch, pbbuttonsd and other applications
changing the backlight will fail.

---
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc2-git4.orig/arch/powerpc/platforms/powermac/backlight.c linux-2.6.18-rc2-git4/arch/powerpc/platforms/powermac/backlight.c
--- linux-2.6.18-rc2-git4.orig/arch/powerpc/platforms/powermac/backlight.c	2006-07-25 20:51:05.000000000 +0200
+++ linux-2.6.18-rc2-git4/arch/powerpc/platforms/powermac/backlight.c	2006-07-25 20:52:02.000000000 +0200
@@ -140,9 +140,6 @@ static int __pmac_backlight_set_legacy_b
 {
 	int error = -ENXIO;
 
-	if (atomic_read(&kernel_backlight_disabled))
-		return -EBUSY;
-
 	mutex_lock(&pmac_backlight_mutex);
 	if (pmac_backlight) {
 		struct backlight_properties *props;
@@ -170,11 +167,17 @@ static int __pmac_backlight_set_legacy_b
 
 static void pmac_backlight_set_legacy_worker(void *data)
 {
+	if (atomic_read(&kernel_backlight_disabled))
+		return;
+
 	__pmac_backlight_set_legacy_brightness(pmac_backlight_set_legacy_queued);
 }
 
 /* This function is called in interrupt context */
 void pmac_backlight_set_legacy_brightness_pmu(int brightness) {
+	if (atomic_read(&kernel_backlight_disabled))
+		return;
+
 	pmac_backlight_set_legacy_queued = brightness;
 	schedule_work(&pmac_backlight_set_legacy_work);
 }
