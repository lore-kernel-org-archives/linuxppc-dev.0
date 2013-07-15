Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 47E102C0362
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jul 2013 02:56:05 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Tue, 16 Jul 2013 02:43:51 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D83352BB0051
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jul 2013 02:56:03 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6FGtsd065732616
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jul 2013 02:55:54 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6FGu280011960
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jul 2013 02:56:03 +1000
Subject: [PATCH 05/11] pstore: Introduce new argument 'compressed' in the
 read callback
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Mon, 15 Jul 2013 22:25:55 +0530
Message-ID: <20130715165555.1520.39336.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130715164844.1520.27771.stgit@aruna-ThinkPad-T420>
References: <20130715164844.1520.27771.stgit@aruna-ThinkPad-T420>
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

Backends will set the flag 'compressed' after reading the log from
persistent store to indicate the data being returned to pstore is
compressed or not.

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/nvram.c |    2 +-
 drivers/acpi/apei/erst.c               |    4 ++--
 drivers/firmware/efi/efi-pstore.c      |    3 ++-
 fs/pstore/platform.c                   |    4 +++-
 fs/pstore/ram.c                        |    3 ++-
 include/linux/pstore.h                 |    2 +-
 6 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index c5c9d78..1ddc266 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -658,7 +658,7 @@ static int nvram_pstore_write(enum pstore_type_id type,
  */
 static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
 				int *count, struct timespec *time, char **buf,
-				struct pstore_info *psi)
+				bool *compressed, struct pstore_info *psi)
 {
 	struct oops_log_info *oops_hdr;
 	unsigned int err_type, id_no, size = 0;
diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 5e90796..b0dca8e 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -933,7 +933,7 @@ static int erst_open_pstore(struct pstore_info *psi);
 static int erst_close_pstore(struct pstore_info *psi);
 static ssize_t erst_reader(u64 *id, enum pstore_type_id *type, int *count,
 			   struct timespec *time, char **buf,
-			   struct pstore_info *psi);
+			   bool *compressed, struct pstore_info *psi);
 static int erst_writer(enum pstore_type_id type, enum kmsg_dump_reason reason,
 		       u64 *id, unsigned int part, int count, bool compressed,
 		       size_t size, struct pstore_info *psi);
@@ -989,7 +989,7 @@ static int erst_close_pstore(struct pstore_info *psi)
 
 static ssize_t erst_reader(u64 *id, enum pstore_type_id *type, int *count,
 			   struct timespec *time, char **buf,
-			   struct pstore_info *psi)
+			   bool *compressed, struct pstore_info *psi)
 {
 	int rc;
 	ssize_t len = 0;
diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index fab6892..9a5425f 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -87,7 +87,8 @@ static int efi_pstore_read_func(struct efivar_entry *entry, void *data)
 
 static ssize_t efi_pstore_read(u64 *id, enum pstore_type_id *type,
 			       int *count, struct timespec *timespec,
-			       char **buf, struct pstore_info *psi)
+			       char **buf, bool *compressed,
+			       struct pstore_info *psi)
 {
 	struct pstore_read_data data;
 
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 5b95524..b1faf25 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -404,6 +404,7 @@ void pstore_get_records(int quiet)
 	enum pstore_type_id	type;
 	struct timespec		time;
 	int			failed = 0, rc;
+	bool			compressed;
 
 	if (!psi)
 		return;
@@ -412,7 +413,8 @@ void pstore_get_records(int quiet)
 	if (psi->open && psi->open(psi))
 		goto out;
 
-	while ((size = psi->read(&id, &type, &count, &time, &buf, psi)) > 0) {
+	while ((size = psi->read(&id, &type, &count, &time, &buf, &compressed,
+				psi)) > 0) {
 		rc = pstore_mkfile(type, psi->name, id, count, buf,
 				  (size_t)size, time, psi);
 		kfree(buf);
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index fe7188f..2927223 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -133,7 +133,8 @@ ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint *c, uint max,
 
 static ssize_t ramoops_pstore_read(u64 *id, enum pstore_type_id *type,
 				   int *count, struct timespec *time,
-				   char **buf, struct pstore_info *psi)
+				   char **buf, bool *compressed,
+				   struct pstore_info *psi)
 {
 	ssize_t size;
 	ssize_t ecc_notice_size;
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index abfca4f..abd437d 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -55,7 +55,7 @@ struct pstore_info {
 	int		(*close)(struct pstore_info *psi);
 	ssize_t		(*read)(u64 *id, enum pstore_type_id *type,
 			int *count, struct timespec *time, char **buf,
-			struct pstore_info *psi);
+			bool *compressed, struct pstore_info *psi);
 	int		(*write)(enum pstore_type_id type,
 			enum kmsg_dump_reason reason, u64 *id,
 			unsigned int part, int count, bool compressed,
