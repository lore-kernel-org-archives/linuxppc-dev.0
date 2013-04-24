Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ED9EA2C058F
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 16:21:24 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 16:13:25 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C4A2E2CE8052
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 16:21:06 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3O67VVn065948
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 16:07:31 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3O6L412022002
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 16:21:05 +1000
Subject: [PATCH v2 7/8] powerpc/pseries: Read of-config partition via pstore
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2013 11:50:52 +0530
Message-ID: <20130424062052.7341.18551.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130424061807.7341.909.stgit@aruna-ThinkPad-T420>
References: <20130424061807.7341.909.stgit@aruna-ThinkPad-T420>
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

This patch set exploits the pstore subsystem to read details of
of-config partition in NVRAM to a separate file in /dev/pstore.
For instance, of-config partition details will be stored in a
file named [of-nvram-5].

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Reviewed-by: Jim Keniston <jkenisto@us.ibm.com>
---
 arch/powerpc/platforms/pseries/nvram.c |   55 +++++++++++++++++++++++++++-----
 fs/pstore/inode.c                      |    3 ++
 include/linux/pstore.h                 |    1 +
 3 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index b118382..de448af 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -132,9 +132,16 @@ static size_t oops_data_sz;
 static struct z_stream_s stream;
 
 #ifdef CONFIG_PSTORE
+static struct nvram_os_partition of_config_partition = {
+	.name = "of-config",
+	.index = -1,
+	.os_partition = false
+};
+
 static enum pstore_type_id nvram_type_ids[] = {
 	PSTORE_TYPE_DMESG,
 	PSTORE_TYPE_RTAS,
+	PSTORE_TYPE_OF,
 	-1
 };
 static int read_type;
@@ -332,10 +339,15 @@ int nvram_read_partition(struct nvram_os_partition *part, char *buff,
 
 	tmp_index = part->index;
 
-	rc = ppc_md.nvram_read((char *)&info, sizeof(struct err_log_info), &tmp_index);
-	if (rc <= 0) {
-		pr_err("%s: Failed nvram_read (%d)\n", __FUNCTION__, rc);
-		return rc;
+	if (part->os_partition) {
+		rc = ppc_md.nvram_read((char *)&info,
+					sizeof(struct err_log_info),
+					&tmp_index);
+		if (rc <= 0) {
+			pr_err("%s: Failed nvram_read (%d)\n", __FUNCTION__,
+									rc);
+			return rc;
+		}
 	}
 
 	rc = ppc_md.nvram_read(buff, length, &tmp_index);
@@ -344,8 +356,10 @@ int nvram_read_partition(struct nvram_os_partition *part, char *buff,
 		return rc;
 	}
 
-	*error_log_cnt = info.seq_num;
-	*err_type = info.error_type;
+	if (part->os_partition) {
+		*error_log_cnt = info.seq_num;
+		*err_type = info.error_type;
+	}
 
 	return 0;
 }
@@ -516,7 +530,7 @@ static int nvram_pstore_write(enum pstore_type_id type,
 }
 
 /*
- * Reads the oops/panic report and ibm,rtas-log partition.
+ * Reads the oops/panic report, rtas and of-config partition.
  * Returns the length of the data we read from each partition.
  * Returns 0 if we've been called before.
  */
@@ -525,9 +539,11 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
 				struct pstore_info *psi)
 {
 	struct oops_log_info *oops_hdr;
-	unsigned int err_type, id_no;
+	unsigned int err_type, id_no, size = 0;
 	struct nvram_os_partition *part = NULL;
 	char *buff = NULL;
+	int sig = 0;
+	loff_t p;
 
 	read_type++;
 
@@ -542,10 +558,29 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
 		time->tv_sec = last_rtas_event;
 		time->tv_nsec = 0;
 		break;
+	case PSTORE_TYPE_OF:
+		sig = NVRAM_SIG_OF;
+		part = &of_config_partition;
+		*type = PSTORE_TYPE_OF;
+		*id = PSTORE_TYPE_OF;
+		time->tv_sec = 0;
+		time->tv_nsec = 0;
+		break;
 	default:
 		return 0;
 	}
 
+	if (!part->os_partition) {
+		p = nvram_find_partition(part->name, sig, &size);
+		if (p <= 0) {
+			pr_err("nvram: Failed to find partition %s, "
+				"err %d\n", part->name, (int)p);
+			return 0;
+		}
+		part->index = p;
+		part->size = size;
+	}
+
 	buff = kmalloc(part->size, GFP_KERNEL);
 
 	if (!buff)
@@ -557,7 +592,9 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
 	}
 
 	*count = 0;
-	*id = id_no;
+
+	if (part->os_partition)
+		*id = id_no;
 
 	if (nvram_type_ids[read_type] == PSTORE_TYPE_DMESG) {
 		oops_hdr = (struct oops_log_info *)buff;
diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index ec24f9c..8d4fb65 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -327,6 +327,9 @@ int pstore_mkfile(enum pstore_type_id type, char *psname, u64 id, int count,
 	case PSTORE_TYPE_PPC_RTAS:
 		sprintf(name, "rtas-%s-%lld", psname, id);
 		break;
+	case PSTORE_TYPE_PPC_OF:
+		sprintf(name, "of-%s-%lld", psname, id);
+		break;
 	case PSTORE_TYPE_UNKNOWN:
 		sprintf(name, "unknown-%s-%lld", psname, id);
 		break;
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index d7a8fe9..615dc18 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -37,6 +37,7 @@ enum pstore_type_id {
 	PSTORE_TYPE_FTRACE	= 3,
 	/* PPC64 partition types */
 	PSTORE_TYPE_PPC_RTAS	= 4,
+	PSTORE_TYPE_PPC_OF	= 5,
 	PSTORE_TYPE_UNKNOWN	= 255
 };
 
