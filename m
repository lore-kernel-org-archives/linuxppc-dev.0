Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D33D51A0349
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 05:12:20 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B00EF1400DD
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2014 05:12:20 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 17 Dec 2014 04:12:20 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8517F2BB0052
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2014 05:06:21 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBGI6L4K33620160
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2014 05:06:21 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBGI6Ks2022365
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2014 05:06:21 +1100
Subject: [PATCH v2 3/3] pstore: add pstore support on powernv
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Tue, 16 Dec 2014 23:36:07 +0530
Message-ID: <20141216180607.7778.21895.stgit@localhost.localdomain>
In-Reply-To: <20141216180442.7778.38272.stgit@localhost.localdomain>
References: <20141216180442.7778.38272.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch extends pstore, a generic interface to platform dependent
persistent storage, support for powernv  platform to capture certain
useful information, during dying moments. Such support is already in
place for  pseries platform.  This patch re-uses most of that code.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/nvram_64.c              |   25 +++++++++++++++++++++++--
 arch/powerpc/platforms/powernv/opal-nvram.c |   10 ++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index dbff7f0..3afbc91 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -127,6 +127,14 @@ static size_t oops_data_sz;
 static struct z_stream_s stream;
 
 #ifdef CONFIG_PSTORE
+#ifdef CONFIG_PPC_POWERNV
+static struct nvram_os_partition skiboot_partition = {
+	.name = "ibm,skiboot",
+	.index = -1,
+	.os_partition = false
+};
+#endif
+
 #ifdef CONFIG_PPC_PSERIES
 static struct nvram_os_partition of_config_partition = {
 	.name = "of-config",
@@ -479,6 +487,16 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
 		time->tv_nsec = 0;
 		break;
 #endif
+#ifdef CONFIG_PPC_POWERNV
+	case PSTORE_TYPE_PPC_OPAL:
+		sig = NVRAM_SIG_FW;
+		part = &skiboot_partition;
+		*type = PSTORE_TYPE_PPC_OPAL;
+		*id = PSTORE_TYPE_PPC_OPAL;
+		time->tv_sec = 0;
+		time->tv_nsec = 0;
+		break;
+#endif
 	default:
 		return 0;
 	}
@@ -554,8 +572,11 @@ static int nvram_pstore_init(void)
 {
 	int rc = 0;
 
-	nvram_type_ids[2] = PSTORE_TYPE_PPC_RTAS;
-	nvram_type_ids[3] = PSTORE_TYPE_PPC_OF;
+	if (machine_is(pseries)) {
+		nvram_type_ids[2] = PSTORE_TYPE_PPC_RTAS;
+		nvram_type_ids[3] = PSTORE_TYPE_PPC_OF;
+	} else
+		nvram_type_ids[2] = PSTORE_TYPE_PPC_OPAL;
 
 	nvram_pstore_info.buf = oops_data;
 	nvram_pstore_info.bufsize = oops_data_sz;
diff --git a/arch/powerpc/platforms/powernv/opal-nvram.c b/arch/powerpc/platforms/powernv/opal-nvram.c
index f9896fd..9db4398 100644
--- a/arch/powerpc/platforms/powernv/opal-nvram.c
+++ b/arch/powerpc/platforms/powernv/opal-nvram.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 
 #include <asm/opal.h>
+#include <asm/nvram.h>
 #include <asm/machdep.h>
 
 static unsigned int nvram_size;
@@ -62,6 +63,15 @@ static ssize_t opal_nvram_write(char *buf, size_t count, loff_t *index)
 	return count;
 }
 
+static int __init opal_nvram_init_log_partitions(void)
+{
+	/* Scan nvram for partitions */
+	nvram_scan_partitions();
+	nvram_init_oops_partition(0);
+	return 0;
+}
+machine_arch_initcall(powernv, opal_nvram_init_log_partitions);
+
 void __init opal_nvram_init(void)
 {
 	struct device_node *np;
