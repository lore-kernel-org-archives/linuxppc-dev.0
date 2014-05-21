Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 484A51A081F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 16:32:45 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Wed, 21 May 2014 16:32:44 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 79C332BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 16:32:40 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4L6WOSk61079722
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 16:32:25 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4L6WdJe001011
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 16:32:39 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: benh@au1.ibm.com
Subject: [PATCH 1/3] powerpc: Split __SYSFS_SPRSETUP macro
Date: Wed, 21 May 2014 16:32:37 +1000
Message-Id: <c0db1b210405db5ff579a2d7432dde2c73bd47bb.1400652868.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1400652868.git.sam.bobroff@au1.ibm.com>
References: <cover.1400652868.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1400652868.git.sam.bobroff@au1.ibm.com>
References: <cover.1400652868.git.sam.bobroff@au1.ibm.com>
Cc: aik@ozlabs.ru, mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Split the __SYSFS_SPRSETUP macro into two parts so that registers requiring
custom read and write functions can use common code for their show and store
functions.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 arch/powerpc/kernel/sysfs.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index d90d4b7..e2a1d6f 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -404,7 +404,7 @@ void ppc_enable_pmcs(void)
 }
 EXPORT_SYMBOL(ppc_enable_pmcs);
 
-#define __SYSFS_SPRSETUP(NAME, ADDRESS, EXTRA) \
+#define __SYSFS_SPRSETUP_READ_WRITE(NAME, ADDRESS, EXTRA) \
 static void read_##NAME(void *val) \
 { \
 	*(unsigned long *)val = mfspr(ADDRESS);	\
@@ -413,7 +413,9 @@ static void write_##NAME(void *val) \
 { \
 	EXTRA; \
 	mtspr(ADDRESS, *(unsigned long *)val);	\
-} \
+}
+
+#define __SYSFS_SPRSETUP_SHOW_STORE(NAME) \
 static ssize_t show_##NAME(struct device *dev, \
 			struct device_attribute *attr, \
 			char *buf) \
@@ -436,10 +438,15 @@ static ssize_t __used \
 	return count; \
 }
 
-#define SYSFS_PMCSETUP(NAME, ADDRESS)	\
-	__SYSFS_SPRSETUP(NAME, ADDRESS, ppc_enable_pmcs())
-#define SYSFS_SPRSETUP(NAME, ADDRESS)	\
-	__SYSFS_SPRSETUP(NAME, ADDRESS, )
+#define SYSFS_PMCSETUP(NAME, ADDRESS) \
+	__SYSFS_SPRSETUP_READ_WRITE(NAME, ADDRESS, ppc_enable_pmcs()) \
+	__SYSFS_SPRSETUP_SHOW_STORE(NAME)
+#define SYSFS_SPRSETUP(NAME, ADDRESS) \
+	__SYSFS_SPRSETUP_READ_WRITE(NAME, ADDRESS, ) \
+	__SYSFS_SPRSETUP_SHOW_STORE(NAME)
+
+#define SYSFS_SPRSETUP_SHOW_STORE(NAME) \
+	__SYSFS_SPRSETUP_SHOW_STORE(NAME)
 
 /* Let's define all possible registers, we'll only hook up the ones
  * that are implemented on the current processor
-- 
1.7.10.4
