Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ACD692C04EE
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 20:19:21 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 25 Apr 2013 20:09:51 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CC598357804E
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 20:19:18 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3PA5Was54591510
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 20:05:33 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3PAJGCl029080
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 20:19:17 +1000
Subject: [PATCH v3 8/8] powerpc/pseries: Read common partition via pstore
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Thu, 25 Apr 2013 15:49:08 +0530
Message-ID: <20130425101908.21017.32553.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130425100952.21017.51799.stgit@aruna-ThinkPad-T420>
References: <20130425100952.21017.51799.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: jkenisto@linux.vnet.ibm.com, tony.luck@intel.com, mahesh@linux.vnet.ibm.com,
 cbouatmailru@gmail.com, anton@samba.org, ccross@android.com,
 keescook@chromium.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch exploits pstore subsystem to read details of common partition
in NVRAM to a separate file in /dev/pstore. For instance, common partition
details will be stored in a file named [common-nvram-6].

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Reviewed-by: Jim Keniston <jkenisto@us.ibm.com>
---
 arch/powerpc/platforms/pseries/nvram.c |   17 ++++++++++++++++-
 fs/pstore/inode.c                      |    3 +++
 include/linux/pstore.h                 |    1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index f7392f6..14cc486 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -138,10 +138,17 @@ static struct nvram_os_partition of_config_partition = {
 	.os_partition = false
 };
 
+static struct nvram_os_partition common_partition = {
+	.name = "common",
+	.index = -1,
+	.os_partition = false
+};
+
 static enum pstore_type_id nvram_type_ids[] = {
 	PSTORE_TYPE_DMESG,
 	PSTORE_TYPE_PPC_RTAS,
 	PSTORE_TYPE_PPC_OF,
+	PSTORE_TYPE_PPC_COMMON,
 	-1
 };
 static int read_type;
@@ -530,7 +537,7 @@ static int nvram_pstore_write(enum pstore_type_id type,
 }
 
 /*
- * Reads the oops/panic report, rtas and of-config partition.
+ * Reads the oops/panic report, rtas, of-config and common partition.
  * Returns the length of the data we read from each partition.
  * Returns 0 if we've been called before.
  */
@@ -566,6 +573,14 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
 		time->tv_sec = 0;
 		time->tv_nsec = 0;
 		break;
+	case PSTORE_TYPE_PPC_COMMON:
+		sig = NVRAM_SIG_SYS;
+		part = &common_partition;
+		*type = PSTORE_TYPE_PPC_COMMON;
+		*id = PSTORE_TYPE_PPC_COMMON;
+		time->tv_sec = 0;
+		time->tv_nsec = 0;
+		break;
 	default:
 		return 0;
 	}
diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 8d4fb65..88cc050 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -330,6 +330,9 @@ int pstore_mkfile(enum pstore_type_id type, char *psname, u64 id, int count,
 	case PSTORE_TYPE_PPC_OF:
 		sprintf(name, "of-%s-%lld", psname, id);
 		break;
+	case PSTORE_TYPE_PPC_COMMON:
+		sprintf(name, "common-%s-%lld", psname, id);
+		break;
 	case PSTORE_TYPE_UNKNOWN:
 		sprintf(name, "unknown-%s-%lld", psname, id);
 		break;
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 615dc18..656699f 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -38,6 +38,7 @@ enum pstore_type_id {
 	/* PPC64 partition types */
 	PSTORE_TYPE_PPC_RTAS	= 4,
 	PSTORE_TYPE_PPC_OF	= 5,
+	PSTORE_TYPE_PPC_COMMON	= 6,
 	PSTORE_TYPE_UNKNOWN	= 255
 };
 
