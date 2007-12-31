Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 4756FDDE2A
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jan 2008 09:37:52 +1100 (EST)
Date: Mon, 31 Dec 2007 16:45:58 -0600
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH] [2.6.24] Add PPC nvram ioctls to compat_ioctl
Message-ID: <20071231224558.GA16517@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix the following console warning when running 'nvsetenv', and makes
setting of new variables work again:

ioctl32(nvsetenv:4022): Unknown cmd fd(3) cmd(20007043){t:'p';sz:0}
arg(00000003) on /dev/nvram

That's the IOC_NVRAM_SYNC call.


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index e8b7c3a..7be6765 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -113,6 +113,10 @@
 #include <asm/fbio.h>
 #endif
 
+#ifdef CONFIG_PPC
+#include <asm/nvram.h>
+#endif
+
 static int do_ioctl32_pointer(unsigned int fd, unsigned int cmd,
 			      unsigned long arg, struct file *f)
 {
@@ -2859,6 +2863,13 @@ IGNORE_IOCTL(FBIOGETCMAP32)
 IGNORE_IOCTL(FBIOSCURSOR32)
 IGNORE_IOCTL(FBIOGCURSOR32)
 #endif
+
+#ifdef CONFIG_PPC
+/* PPC-specific NVRAM IOCTLs */
+COMPATIBLE_IOCTL(OBSOLETE_PMAC_NVRAM_GET_OFFSET)
+COMPATIBLE_IOCTL(IOC_NVRAM_GET_OFFSET)
+COMPATIBLE_IOCTL(IOC_NVRAM_SYNC)
+#endif
 };
 
 #define IOCTL_HASHSIZE 256
