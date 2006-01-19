Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A8163681B8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Jan 2006 18:05:25 +1100 (EST)
Date: Thu, 19 Jan 2006 00:58:21 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Andrew Morton <akpm@osdl.org>, <wim@iguana.be>
Subject: [PATCH] powerpc: remove useless spinlock from mpc83xx watchdog
Message-ID: <Pine.LNX.4.44.0601190057130.8484-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Since we can only open the watchdog once having a spinlock to protect
multiple access is pointless.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 8852c088c0624f5534b08a769b5887c42a211694
tree 04ad05af51efb90604ff86af48197b6b7b45f77a
parent 1161d00ace361999d5b98bbe3082da4c8d457ba3
author Kumar Gala <galak@kernel.crashing.org> Thu, 19 Jan 2006 01:03:09 -0600
committer Kumar Gala <galak@kernel.crashing.org> Thu, 19 Jan 2006 01:03:09 -0600

 drivers/char/watchdog/mpc83xx_wdt.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/char/watchdog/mpc83xx_wdt.c b/drivers/char/watchdog/mpc83xx_wdt.c
index 5d6f506..b310144 100644
--- a/drivers/char/watchdog/mpc83xx_wdt.c
+++ b/drivers/char/watchdog/mpc83xx_wdt.c
@@ -57,15 +57,12 @@ static int prescale = 1;
 static unsigned int timeout_sec;
 
 static unsigned long wdt_is_open;
-static spinlock_t wdt_spinlock;
 
 static void mpc83xx_wdt_keepalive(void)
 {
 	/* Ping the WDT */
-	spin_lock(&wdt_spinlock);
 	out_be16(&wd_base->swsrr, 0x556c);
 	out_be16(&wd_base->swsrr, 0xaa39);
-	spin_unlock(&wdt_spinlock);
 }
 
 static ssize_t mpc83xx_wdt_write(struct file *file, const char __user *buf,
@@ -184,8 +181,6 @@ static int __devinit mpc83xx_wdt_probe(s
 		"mode:%s timeout=%d (%d seconds)\n",
 		reset ? "reset":"interrupt", timeout, timeout_sec);
 
-	spin_lock_init(&wdt_spinlock);
-
 	return 0;
 
 err_unmap:
