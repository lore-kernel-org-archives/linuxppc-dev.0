Return-Path: <jkacur@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 36307B7B72
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 08:07:48 +1100 (EST)
Date: Wed, 21 Oct 2009 23:07:18 +0200 (CEST)
From: John Kacur <jkacur@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] macintosh: Explicitly set llseek to no_llseek in ans-lcd
In-Reply-To: <20091010153349.966159859@linutronix.de>
Message-ID: <alpine.LFD.2.00.0910212305090.3526@localhost.localdomain>
References: <20091010153314.827301943@linutronix.de>
	<20091010153349.966159859@linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Arnd Bergmann <arndbergmann@googlemail.com>,
	Jonathan Corbet <corbet@lwn.net>, Frederic Weisbecker <fweisbec@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 0c2b412cdccf73bdeb19bb866bfe556942eaeca2 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Wed, 21 Oct 2009 23:01:12 +0200
Subject: [PATCH] macintosh: Explicitly set llseek to no_llseek in ans-lcd

Now that we've removed the BKL here, let's explicitly set lleek to no_llseek

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 drivers/macintosh/ans-lcd.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/macintosh/ans-lcd.c b/drivers/macintosh/ans-lcd.c
index 4ae8ec9..a1a1bde 100644
--- a/drivers/macintosh/ans-lcd.c
+++ b/drivers/macintosh/ans-lcd.c
@@ -137,6 +137,7 @@ const struct file_operations anslcd_fops = {
 	.write		= anslcd_write,
 	.unlocked_ioctl	= anslcd_ioctl,
 	.open		= anslcd_open,
+	.llseedk	= no_llseek,
 };
 
 static struct miscdevice anslcd_dev = {
-- 
1.6.0.6
