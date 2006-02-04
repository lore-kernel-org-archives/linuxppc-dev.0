Return-Path: <jesper.juhl@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.199])
	by ozlabs.org (Postfix) with ESMTP id C495268A44
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Feb 2006 06:35:53 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id i2so1080560wra
	for <linuxppc-dev@ozlabs.org>; Sat, 04 Feb 2006 11:35:51 -0800 (PST)
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Don't check pointer for NULL before passing it to kfree
	[arch/powerpc/kernel/rtas_flash.c]
Date: Sat, 4 Feb 2006 20:35:59 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200602042035.59216.jesper.juhl@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Checking a pointer for NULL before passing it to kfree is pointless, kfree
does its own NULL checking of input.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 arch/powerpc/kernel/rtas_flash.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.16-rc2-git1-orig/arch/powerpc/kernel/rtas_flash.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc2-git1/arch/powerpc/kernel/rtas_flash.c	2006-02-04 20:30:21.000000000 +0100
@@ -672,8 +672,7 @@ static void rtas_flash_firmware(int rebo
 static void remove_flash_pde(struct proc_dir_entry *dp)
 {
 	if (dp) {
-		if (dp->data != NULL)
-			kfree(dp->data);
+		kfree(dp->data);
 		dp->owner = NULL;
 		remove_proc_entry(dp->name, dp->parent);
 	}
