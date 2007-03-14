Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 11D60DDDE6
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 20:17:13 +1100 (EST)
To: torvalds@linux-foundation.org
Subject: [PATCH 13/13] fix ps3fb glue allowing a modular build
Message-Id: <E1HRPbU-0003Ha-Oq@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 14 Mar 2007 09:17:04 +0000
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/platforms/ps3/htab.c |    2 ++
 drivers/video/Kconfig             |    2 +-
 include/asm-powerpc/ps3fb.h       |    5 -----
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/htab.c b/arch/powerpc/platforms/ps3/htab.c
index e12e59f..67d6f58 100644
--- a/arch/powerpc/platforms/ps3/htab.c
+++ b/arch/powerpc/platforms/ps3/htab.c
@@ -235,7 +235,9 @@ static void ps3_hpte_invalidate(unsigned long slot, unsigned long va,
 static void ps3_hpte_clear(void)
 {
 	/* Make sure to clean up the frame buffer device first */
+#ifdef CONFIG_PS3_FB
 	ps3fb_cleanup();
+#endif
 
 	lv1_unmap_htab(htab_addr);
 }
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 7f5a598..ab43a32 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1615,7 +1615,7 @@ config FB_IBM_GXT4500
 	  adaptor, found on some IBM System P (pSeries) machines.
 
 config FB_PS3
-	bool "PS3 GPU framebuffer driver"
+	tristate "PS3 GPU framebuffer driver"
 	depends on FB && PS3_PS3AV
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
diff --git a/include/asm-powerpc/ps3fb.h b/include/asm-powerpc/ps3fb.h
index ad81cf4..a447387 100644
--- a/include/asm-powerpc/ps3fb.h
+++ b/include/asm-powerpc/ps3fb.h
@@ -43,13 +43,8 @@ struct ps3fb_ioctl_res {
 
 #ifdef __KERNEL__
 
-#ifdef CONFIG_FB_PS3
 extern void ps3fb_flip_ctl(int on);
 extern void ps3fb_cleanup(void);
-#else
-static inline void ps3fb_flip_ctl(int on) {}
-static inline void ps3fb_cleanup(void) {}
-#endif
 
 #endif /* __KERNEL__ */
 
-- 
1.5.0-rc2.GIT
