Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EA6302C02AA
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 23:17:58 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Fri, 16 Aug 2013 18:40:06 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 5E294E0055
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 18:48:17 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7GDHn5I28573930
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 18:47:49 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7GDHosC018810
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 18:47:51 +0530
Subject: [RFC PATCH v2 02/11] pstore: Add new argument 'compressed' in
 pstore write callback
To: linuxppc-dev@ozlabs.org, tony.luck@intel.com, linux-kernel@vger.kernel.org,
 keescook@chromium.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Fri, 16 Aug 2013 18:47:47 +0530
Message-ID: <20130816131747.3338.44215.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130816131403.3338.82330.stgit@aruna-ThinkPad-T420>
References: <20130816131403.3338.82330.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: jkenisto@linux.vnet.ibm.com, cbouatmailru@gmail.com,
 mahesh@linux.vnet.ibm.com, ccross@android.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Addition of new argument 'compressed' in the write call back will
help the backend to know if the data passed from pstore is compressed
or not (In case where compression fails.). If compressed, the backend
can add a tag indicating the data is compressed while writing to
persistent store.

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/nvram.c |    4 ++--
 drivers/acpi/apei/erst.c               |    4 ++--
 drivers/firmware/efi/efi-pstore.c      |    2 +-
 fs/pstore/platform.c                   |    7 ++++---
 fs/pstore/ram.c                        |    2 +-
 include/linux/pstore.h                 |    4 ++--
 6 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index b966458..dbe5dad 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -554,7 +554,7 @@ static int nvram_pstore_open(struct pstore_info *psi)
  * @part:               pstore writes data to registered buffer in parts,
  *                      part number will indicate the same.
  * @count:              Indicates oops count
- * @hsize:              Size of header added by pstore
+ * @compressed:         Flag to indicate the log is compressed
  * @size:               number of bytes written to the registered buffer
  * @psi:                registered pstore_info structure
  *
@@ -565,7 +565,7 @@ static int nvram_pstore_open(struct pstore_info *psi)
 static int nvram_pstore_write(enum pstore_type_id type,
 				enum kmsg_dump_reason reason,
 				u64 *id, unsigned int part, int count,
-				size_t hsize, size_t size,
+				bool compressed, size_t size,
 				struct pstore_info *psi)
 {
 	int rc;
diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 88d0b0f..5e90796 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -935,7 +935,7 @@ static ssize_t erst_reader(u64 *id, enum pstore_type_id *type, int *count,
 			   struct timespec *time, char **buf,
 			   struct pstore_info *psi);
 static int erst_writer(enum pstore_type_id type, enum kmsg_dump_reason reason,
-		       u64 *id, unsigned int part, int count, size_t hsize,
+		       u64 *id, unsigned int part, int count, bool compressed,
 		       size_t size, struct pstore_info *psi);
 static int erst_clearer(enum pstore_type_id type, u64 id, int count,
 			struct timespec time, struct pstore_info *psi);
@@ -1055,7 +1055,7 @@ out:
 }
 
 static int erst_writer(enum pstore_type_id type, enum kmsg_dump_reason reason,
-		       u64 *id, unsigned int part, int count, size_t hsize,
+		       u64 *id, unsigned int part, int count, bool compressed,
 		       size_t size, struct pstore_info *psi)
 {
 	struct cper_pstore_record *rcd = (struct cper_pstore_record *)
diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index 73de5a9..fab6892 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -103,7 +103,7 @@ static ssize_t efi_pstore_read(u64 *id, enum pstore_type_id *type,
 
 static int efi_pstore_write(enum pstore_type_id type,
 		enum kmsg_dump_reason reason, u64 *id,
-		unsigned int part, int count, size_t hsize, size_t size,
+		unsigned int part, int count, bool compressed, size_t size,
 		struct pstore_info *psi)
 {
 	char name[DUMP_NAME_LEN];
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 422962a..20fa686 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -149,6 +149,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		unsigned long size;
 		int hsize;
 		size_t len;
+		bool compressed = false;
 
 		dst = psinfo->buf;
 		hsize = sprintf(dst, "%s#%d Part%d\n", why, oopscount, part);
@@ -159,7 +160,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 			break;
 
 		ret = psinfo->write(PSTORE_TYPE_DMESG, reason, &id, part,
-				    oopscount, hsize, hsize + len, psinfo);
+				    oopscount, compressed, hsize + len, psinfo);
 		if (ret == 0 && reason == KMSG_DUMP_OOPS && pstore_is_mounted())
 			pstore_new_entry = 1;
 
@@ -221,10 +222,10 @@ static void pstore_register_console(void) {}
 static int pstore_write_compat(enum pstore_type_id type,
 			       enum kmsg_dump_reason reason,
 			       u64 *id, unsigned int part, int count,
-			       size_t hsize, size_t size,
+			       bool compressed, size_t size,
 			       struct pstore_info *psi)
 {
-	return psi->write_buf(type, reason, id, part, psinfo->buf, hsize,
+	return psi->write_buf(type, reason, id, part, psinfo->buf, compressed,
 			     size, psi);
 }
 
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index a6119f9..fe7188f 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -196,7 +196,7 @@ static int notrace ramoops_pstore_write_buf(enum pstore_type_id type,
 					    enum kmsg_dump_reason reason,
 					    u64 *id, unsigned int part,
 					    const char *buf,
-					    size_t hsize, size_t size,
+					    bool compressed, size_t size,
 					    struct pstore_info *psi)
 {
 	struct ramoops_context *cxt = psi->data;
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 4aa80ba..abfca4f 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -58,11 +58,11 @@ struct pstore_info {
 			struct pstore_info *psi);
 	int		(*write)(enum pstore_type_id type,
 			enum kmsg_dump_reason reason, u64 *id,
-			unsigned int part, int count, size_t hsize,
+			unsigned int part, int count, bool compressed,
 			size_t size, struct pstore_info *psi);
 	int		(*write_buf)(enum pstore_type_id type,
 			enum kmsg_dump_reason reason, u64 *id,
-			unsigned int part, const char *buf, size_t hsize,
+			unsigned int part, const char *buf, bool compressed,
 			size_t size, struct pstore_info *psi);
 	int		(*erase)(enum pstore_type_id type, u64 id,
 			int count, struct timespec time,
