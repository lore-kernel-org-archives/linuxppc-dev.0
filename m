Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E27D61007D1
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Dec 2010 05:08:48 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oB3HtBii011137
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Dec 2010 10:55:11 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	oB3I8dBx227670
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Dec 2010 11:08:39 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oB3I8cqv003896
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Dec 2010 11:08:39 -0700
Date: Fri, 3 Dec 2010 13:07:51 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] watchdog: add CONFIG_WATCHDOG_NOWAYOUT support to
	PowerPC Book-E watchdog driver
Message-ID: <20101203180751.GA1903@zod.rchland.ibm.com>
References: <1291395103-12394-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291395103-12394-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 03, 2010 at 10:51:43AM -0600, Timur Tabi wrote:
>Normally, the watchdog is disabled when dev/watchdog is closed, but if
>CONFIG_WATCHDOG_NOWAYOUT is defined, then it means that the watchdog should
>remain enabled.  So we should disable it only if CONFIG_WATCHDOG_NOWAYOUT is
>not defined.
>
>Also ensure that /dev/watchdog is only opened by one process at a time.  That
>way, a second process can't accidentally disable the watchdog while the first
>process has it open.  There shouldn't be any need for more than one process to
>open /dev/watchdog anyway.
>
>Signed-off-by: Timur Tabi <timur@freescale.com>
>---
>
>Kumar, please pick up this patch for 2.6.37.
>
> drivers/watchdog/booke_wdt.c |   16 ++++++++++++++++
> 1 files changed, 16 insertions(+), 0 deletions(-)
>
>diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
>index d11ffb0..636e013 100644
>--- a/drivers/watchdog/booke_wdt.c
>+++ b/drivers/watchdog/booke_wdt.c
>@@ -193,8 +193,15 @@ static long booke_wdt_ioctl(struct file *file,
> 	return 0;
> }
>
>+/* wdt_is_active stores wether or not the /dev/watchdog device is opened */
>+static unsigned long wdt_is_active;
>+
> static int booke_wdt_open(struct inode *inode, struct file *file)
> {
>+	/* /dev/watchdog can only be opened once */
>+	if (test_and_set_bit(0, &wdt_is_active))
>+		return -EBUSY;
>+
> 	spin_lock(&booke_wdt_lock);
> 	if (booke_wdt_enabled == 0) {
> 		booke_wdt_enabled = 1;

I'm confused why you can't use booke_wdt_enabled for the purposes of the
device having been opened.  It seems the use of the wdt_is_active
basically duplicates this functionalit (and oddly with the bit
manipulation instead of just atomic_inc/dec).

>@@ -210,8 +217,17 @@ static int booke_wdt_open(struct inode *inode, struct file *file)
>
> static int booke_wdt_release(struct inode *inode, struct file *file)
> {
>+#ifndef CONFIG_WATCHDOG_NOWAYOUT
>+	/* Normally, the watchdog is disabled when /dev/watchdog is closed, but
>+	 * if CONFIG_WATCHDOG_NOWAYOUT is defined, then it means that the
>+	 * watchdog should remain enabled.  So we disable it only if
>+	 * CONFIG_WATCHDOG_NOWAYOUT is not defined.
>+	 */
> 	on_each_cpu(__booke_wdt_disable, NULL, 0);
> 	booke_wdt_enabled = 0;
>+#endif
>+
>+	clear_bit(0, &wdt_is_active);

If you were to keep this variable instead of just using
booke_wdt_enabled, wouldn't it be more correct to have the clear_bit
only done inside the #ifndef?  The timer is very much still active if
NOWAYOUT is set...

josh
