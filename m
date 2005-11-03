Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 5E60A68662
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Nov 2005 01:27:07 +1100 (EST)
Message-ID: <436A1E39.7030206@ru.mvista.com>
Date: Thu, 03 Nov 2005 17:27:05 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Content-Type: multipart/mixed; boundary="------------090101040003000503090900"
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] fs_enet build fix
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090101040003000503090900
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Due to the recent update of the platform code, some platform device 
drivers fail to compile. This fix is for fs_enet, adding #include of a 
new header, to which a number of platform stuff has been relocated.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

-- 
Sincerely,
Vitaly

--------------090101040003000503090900
Content-Type: text/x-patch;
 name="fs_enet_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fs_enet_fix.patch"

diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -37,6 +37,7 @@
 #include <linux/ethtool.h>
 #include <linux/bitops.h>
 #include <linux/fs.h>
+#include <linux/platform_device.h>
 
 #include <linux/vmalloc.h>
 #include <asm/pgtable.h>
diff --git a/drivers/net/fs_enet/mac-fcc.c b/drivers/net/fs_enet/mac-fcc.c
--- a/drivers/net/fs_enet/mac-fcc.c
+++ b/drivers/net/fs_enet/mac-fcc.c
@@ -34,6 +34,7 @@
 #include <linux/ethtool.h>
 #include <linux/bitops.h>
 #include <linux/fs.h>
+#include <linux/platform_device.h>
 
 #include <asm/immap_cpm2.h>
 #include <asm/mpc8260.h>
diff --git a/drivers/net/fs_enet/mac-fec.c b/drivers/net/fs_enet/mac-fec.c
--- a/drivers/net/fs_enet/mac-fec.c
+++ b/drivers/net/fs_enet/mac-fec.c
@@ -34,6 +34,7 @@
 #include <linux/ethtool.h>
 #include <linux/bitops.h>
 #include <linux/fs.h>
+#include <linux/platform_device.h>
 
 #include <asm/irq.h>
 #include <asm/uaccess.h>
diff --git a/drivers/net/fs_enet/mac-scc.c b/drivers/net/fs_enet/mac-scc.c
--- a/drivers/net/fs_enet/mac-scc.c
+++ b/drivers/net/fs_enet/mac-scc.c
@@ -34,6 +34,7 @@
 #include <linux/ethtool.h>
 #include <linux/bitops.h>
 #include <linux/fs.h>
+#include <linux/platform_device.h>
 
 #include <asm/irq.h>
 #include <asm/uaccess.h>

--------------090101040003000503090900--
