Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE277B7B70
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 19:42:57 +1100 (EST)
Message-Id: <20091015083933.856959433@linutronix.de>
Date: Thu, 15 Oct 2009 08:42:28 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 3/7] powerpc: Use unlocked ioctl in nvram_64
References: <20091015083906.716130653@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker <fweisbec@gmail.com>,
	linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	ALan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ioctl is only used for powermac systems and reads a partition
number from an array which is initialized at boot time way before the
nvram code is initialized. So it's safe to switch to unlocked_ioctl.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
---
 arch/powerpc/kernel/nvram_64.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6-tip/arch/powerpc/kernel/nvram_64.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/kernel/nvram_64.c
+++ linux-2.6-tip/arch/powerpc/kernel/nvram_64.c
@@ -139,8 +139,8 @@ out:
 
 }
 
-static int dev_nvram_ioctl(struct inode *inode, struct file *file,
-	unsigned int cmd, unsigned long arg)
+static long dev_nvram_ioctl(struct file *file, unsigned int cmd,
+			    unsigned long arg)
 {
 	switch(cmd) {
 #ifdef CONFIG_PPC_PMAC
@@ -169,11 +169,11 @@ static int dev_nvram_ioctl(struct inode 
 }
 
 const struct file_operations nvram_fops = {
-	.owner =	THIS_MODULE,
-	.llseek =	dev_nvram_llseek,
-	.read =		dev_nvram_read,
-	.write =	dev_nvram_write,
-	.ioctl =	dev_nvram_ioctl,
+	.owner		= THIS_MODULE,
+	.llseek		= dev_nvram_llseek,
+	.read		= dev_nvram_read,
+	.write		= dev_nvram_write,
+	.unlocked_ioctl	= dev_nvram_ioctl,
 };
 
 static struct miscdevice nvram_dev = {
