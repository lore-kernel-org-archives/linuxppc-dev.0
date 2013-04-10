Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D8AAC2C00B2
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Apr 2013 17:24:24 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Wed, 10 Apr 2013 12:49:38 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 48B8B1258051
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Apr 2013 12:55:45 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3A7OF5N52691104
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Apr 2013 12:54:15 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3A7OHaQ029099
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Apr 2013 07:24:18 GMT
Subject: [PATCH 8/8] Read common partition via pstore
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Wed, 10 Apr 2013 12:54:12 +0530
Message-ID: <20130410072412.20150.13002.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130410071835.20150.56489.stgit@aruna-ThinkPad-T420>
References: <20130410071835.20150.56489.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: jkenisto@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch exploits pstore infrastructure to read the details
from NVRAM's common partition.

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Reviewed-by: Jim Keniston <jkenisto@us.ibm.com>
---
 arch/powerpc/platforms/pseries/nvram.c |   17 ++++++++++++++++-
 fs/pstore/inode.c                      |    3 +++
 include/linux/pstore.h                 |    1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index b65a670..542dc7e 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -84,6 +84,12 @@ static struct nvram_os_partition of_config_partition = {
 	.index = -1,
 	.os_partition = false
 };
+
+static struct nvram_os_partition common_partition = {
+	.name = "common",
+	.index = -1,
+	.os_partition = false
+};
 #endif
 
 struct oops_log_info {
@@ -157,6 +163,7 @@ static enum pstore_type_id nvram_type_ids[] = {
 	PSTORE_TYPE_DMESG,
 	PSTORE_TYPE_RTAS,
 	PSTORE_TYPE_OF,
+	PSTORE_TYPE_COMMON,
 	-1
 };
 static int read_type;
@@ -770,7 +777,7 @@ static int nvram_pstore_write(enum pstore_type_id type,
 }
 
 /*
- * Reads the oops/panic report, rtas-log and of-config partition.
+ * Reads the oops/panic report, rtas-log, of-config and common partition.
  * Returns the length of the data we read from each partition.
  * Returns 0 if we've been called before.
  */
@@ -806,6 +813,14 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
 		time->tv_sec = 0;
 		time->tv_nsec = 0;
 		break;
+	case PSTORE_TYPE_COMMON:
+		sig = NVRAM_SIG_SYS;
+		part = &common_partition;
+		*type = PSTORE_TYPE_COMMON;
+		*id = PSTORE_TYPE_COMMON;
+		time->tv_sec = 0;
+		time->tv_nsec = 0;
+		break;
 	default:
 		return 0;
 	}
diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index c3d1846..11cae64 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -330,6 +330,9 @@ int pstore_mkfile(enum pstore_type_id type, char *psname, u64 id, int count,
 	case PSTORE_TYPE_OF:
 		sprintf(name, "of-%s-%lld", psname, id);
 		break;
+	case PSTORE_TYPE_COMMON:
+		sprintf(name, "common-%s-%lld", psname, id);
+		break;
 	case PSTORE_TYPE_UNKNOWN:
 		sprintf(name, "unknown-%s-%lld", psname, id);
 		break;
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index a23d7d2..08224c2 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -38,6 +38,7 @@ enum pstore_type_id {
 	/* PPC64 partition types */
 	PSTORE_TYPE_RTAS	= 10,
 	PSTORE_TYPE_OF		= 11,
+	PSTORE_TYPE_COMMON	= 12,
 	PSTORE_TYPE_UNKNOWN	= 255
 };
 
