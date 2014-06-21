Return-Path: <dwalter@google.com>
Received: from mail-wi0-x236.google.com (mail-wi0-x236.google.com
 [IPv6:2a00:1450:400c:c05::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC3FF1A007B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jun 2014 22:05:47 +1000 (EST)
Received: by mail-wi0-f182.google.com with SMTP id bs8so1960327wib.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jun 2014 05:05:39 -0700 (PDT)
Date: Sat, 21 Jun 2014 13:05:36 +0100
From: Daniel Walter <dwalter@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] [arch/powerpc] replace obsolete strict_strto* calls
Message-ID: <20140621120536.GA7372@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace strict_strto calls with more appropriate kstrto calls

Signed-off-by: Daniel Walter <dwalter@google.com>
---
 arch/powerpc/kernel/setup_64.c            | 6 +++---
 arch/powerpc/kernel/vio.c                 | 2 +-
 arch/powerpc/platforms/pseries/dlpar.c    | 4 ++--
 arch/powerpc/platforms/pseries/mobility.c | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index ee082d7..5257166 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -149,13 +149,13 @@ static void check_smt_enabled(void)
 		else if (!strcmp(smt_enabled_cmdline, "off"))
 			smt_enabled_at_boot = 0;
 		else {
-			long smt;
+			int smt;
 			int rc;
 
-			rc = strict_strtol(smt_enabled_cmdline, 10, &smt);
+			rc = kstrtoint(smt_enabled_cmdline, 10, &smt);
 			if (!rc)
 				smt_enabled_at_boot =
-					min(threads_per_core, (int)smt);
+					min(threads_per_core, smt);
 		}
 	} else {
 		dn = of_find_node_by_path("/options");
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 904c661..5bfdab9 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -977,7 +977,7 @@ static ssize_t viodev_cmo_desired_set(struct device *dev,
 	size_t new_desired;
 	int ret;
 
-	ret = strict_strtoul(buf, 10, &new_desired);
+	ret = kstrtoul(buf, 10, &new_desired);
 	if (ret)
 		return ret;
 
diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 022b38e..abc6892 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -399,10 +399,10 @@ out:
 static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
 {
 	struct device_node *dn, *parent;
-	unsigned long drc_index;
+	u32 drc_index;
 	int rc;
 
-	rc = strict_strtoul(buf, 0, &drc_index);
+	rc = kstrtou32(buf, 0, &drc_index);
 	if (rc)
 		return -EINVAL;
 
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index bde7eba..0694ac6 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -319,7 +319,7 @@ static ssize_t migrate_store(struct class *class, struct class_attribute *attr,
 	u64 streamid;
 	int rc;
 
-	rc = strict_strtoull(buf, 0, &streamid);
+	rc = kstrtou64(buf, 0, &streamid);
 	if (rc)
 		return rc;
 
-- 
2.0.0.526.g5318336
