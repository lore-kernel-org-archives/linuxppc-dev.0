Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 57BE7DDF10
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 00:51:03 +1000 (EST)
Date: Mon, 28 Jul 2008 00:51:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>
Subject: [PATCH] powerpc/cmo: fix sysdev attribute API change fallout
Message-Id: <20080728005102.164705e0.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Brian King <brking@linux.vnet.ibm.com>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Noticed due to these wanings:

arch/powerpc/platforms/pseries/cmm.c:298: warning: initialization from incompatible pointer type
arch/powerpc/platforms/pseries/cmm.c:299: warning: initialization from incompatible pointer type
arch/powerpc/platforms/pseries/cmm.c:320: warning: initialization from incompatible pointer type
arch/powerpc/platforms/pseries/cmm.c:320: warning: initialization from incompatible pointer type

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/pseries/cmm.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

Only build tested with ppc64_defconfig.

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index c6b3be0..38fe32a 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -289,7 +289,9 @@ static int cmm_thread(void *dummy)
 }
 
 #define CMM_SHOW(name, format, args...)			\
-	static ssize_t show_##name(struct sys_device *dev, char *buf)	\
+	static ssize_t show_##name(struct sys_device *dev,	\
+				   struct sysdev_attribute *attr,	\
+				   char *buf)			\
 	{							\
 		return sprintf(buf, format, ##args);		\
 	}							\
@@ -298,12 +300,14 @@ static int cmm_thread(void *dummy)
 CMM_SHOW(loaned_kb, "%lu\n", PAGES2KB(loaned_pages));
 CMM_SHOW(loaned_target_kb, "%lu\n", PAGES2KB(loaned_pages_target));
 
-static ssize_t show_oom_pages(struct sys_device *dev, char *buf)
+static ssize_t show_oom_pages(struct sys_device *dev,
+			      struct sysdev_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%lu\n", PAGES2KB(oom_freed_pages));
 }
 
 static ssize_t store_oom_pages(struct sys_device *dev,
+			       struct sysdev_attribute *attr,
 			       const char *buf, size_t count)
 {
 	unsigned long val = simple_strtoul (buf, NULL, 10);
-- 
1.5.6.3



-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
