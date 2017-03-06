Return-Path: <keescook@chromium.org>
Received: from mail-pg0-x234.google.com (mail-pg0-x234.google.com
 [IPv6:2607:f8b0:400e:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcYWL0Fc5zDqXg
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 08:55:42 +1100 (AEDT)
Received: by mail-pg0-x234.google.com with SMTP id 187so16867738pgb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Mar 2017 13:55:41 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.kw@hitachi.com>,
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
 Tony Luck <tony.luck@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
 Matt Fleming <matt@codeblueprint.co.uk>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Geliang Tang <geliangtang@163.com>, linuxppc-dev@lists.ozlabs.org,
 linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: [PATCH 10/18] pstore: Replace arguments for write() API
Date: Mon,  6 Mar 2017 13:55:24 -0800
Message-Id: <1488837332-71582-11-git-send-email-keescook@chromium.org>
In-Reply-To: <1488837332-71582-1-git-send-email-keescook@chromium.org>
References: <1488837332-71582-1-git-send-email-keescook@chromium.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Similar to the pstore_info read() callback, there were too many arguments.
This switches to the new struct pstore_record pointer instead. This adds
"reason" and "part" to the record structure as well.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/kernel/nvram_64.c    | 27 +++++------------
 drivers/acpi/apei/erst.c          | 18 +++++-------
 drivers/firmware/efi/efi-pstore.c | 18 +++++-------
 fs/pstore/platform.c              | 62 ++++++++++++++++++++++-----------------
 include/linux/pstore.h            | 36 +++++++++++------------
 5 files changed, 76 insertions(+), 85 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 7f192001d09a..caf2e1f36d6b 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -389,51 +389,40 @@ static int nvram_pstore_open(struct pstore_info *psi)
 
 /**
  * nvram_pstore_write - pstore write callback for nvram
- * @type:               Type of message logged
- * @reason:             reason behind dump (oops/panic)
- * @id:                 identifier to indicate the write performed
- * @part:               pstore writes data to registered buffer in parts,
- *                      part number will indicate the same.
- * @count:              Indicates oops count
- * @compressed:         Flag to indicate the log is compressed
- * @size:               number of bytes written to the registered buffer
- * @psi:                registered pstore_info structure
+ * @record:             pstore record to write, with @id to be set
  *
  * Called by pstore_dump() when an oops or panic report is logged in the
  * printk buffer.
  * Returns 0 on successful write.
  */
-static int nvram_pstore_write(enum pstore_type_id type,
-				enum kmsg_dump_reason reason,
-				u64 *id, unsigned int part, int count,
-				bool compressed, size_t size,
-				struct pstore_info *psi)
+static int nvram_pstore_write(struct pstore_record *record)
 {
 	int rc;
 	unsigned int err_type = ERR_TYPE_KERNEL_PANIC;
 	struct oops_log_info *oops_hdr = (struct oops_log_info *) oops_buf;
 
 	/* part 1 has the recent messages from printk buffer */
-	if (part > 1 || (type != PSTORE_TYPE_DMESG))
+	if (record->part > 1 || (record->type != PSTORE_TYPE_DMESG))
 		return -1;
 
 	if (clobbering_unread_rtas_event())
 		return -1;
 
 	oops_hdr->version = cpu_to_be16(OOPS_HDR_VERSION);
-	oops_hdr->report_length = cpu_to_be16(size);
+	oops_hdr->report_length = cpu_to_be16(record->size);
 	oops_hdr->timestamp = cpu_to_be64(ktime_get_real_seconds());
 
-	if (compressed)
+	if (record->compressed)
 		err_type = ERR_TYPE_KERNEL_PANIC_GZ;
 
 	rc = nvram_write_os_partition(&oops_log_partition, oops_buf,
-		(int) (sizeof(*oops_hdr) + size), err_type, count);
+		(int) (sizeof(*oops_hdr) + record->size), err_type,
+		record->count);
 
 	if (rc != 0)
 		return rc;
 
-	*id = part;
+	record->id = record->part;
 	return 0;
 }
 
diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index bbefb7522f80..440588d189e7 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -926,9 +926,7 @@ static int erst_check_table(struct acpi_table_erst *erst_tab)
 static int erst_open_pstore(struct pstore_info *psi);
 static int erst_close_pstore(struct pstore_info *psi);
 static ssize_t erst_reader(struct pstore_record *record);
-static int erst_writer(enum pstore_type_id type, enum kmsg_dump_reason reason,
-		       u64 *id, unsigned int part, int count, bool compressed,
-		       size_t size, struct pstore_info *psi);
+static int erst_writer(struct pstore_record *record);
 static int erst_clearer(enum pstore_type_id type, u64 id, int count,
 			struct timespec time, struct pstore_info *psi);
 
@@ -1054,9 +1052,7 @@ static ssize_t erst_reader(struct pstore_record *record)
 	return (rc < 0) ? rc : (len - sizeof(*rcd));
 }
 
-static int erst_writer(enum pstore_type_id type, enum kmsg_dump_reason reason,
-		       u64 *id, unsigned int part, int count, bool compressed,
-		       size_t size, struct pstore_info *psi)
+static int erst_writer(struct pstore_record *record)
 {
 	struct cper_pstore_record *rcd = (struct cper_pstore_record *)
 					(erst_info.buf - sizeof(*rcd));
@@ -1071,21 +1067,21 @@ static int erst_writer(enum pstore_type_id type, enum kmsg_dump_reason reason,
 	/* timestamp valid. platform_id, partition_id are invalid */
 	rcd->hdr.validation_bits = CPER_VALID_TIMESTAMP;
 	rcd->hdr.timestamp = get_seconds();
-	rcd->hdr.record_length = sizeof(*rcd) + size;
+	rcd->hdr.record_length = sizeof(*rcd) + record->size;
 	rcd->hdr.creator_id = CPER_CREATOR_PSTORE;
 	rcd->hdr.notification_type = CPER_NOTIFY_MCE;
 	rcd->hdr.record_id = cper_next_record_id();
 	rcd->hdr.flags = CPER_HW_ERROR_FLAGS_PREVERR;
 
 	rcd->sec_hdr.section_offset = sizeof(*rcd);
-	rcd->sec_hdr.section_length = size;
+	rcd->sec_hdr.section_length = record->size;
 	rcd->sec_hdr.revision = CPER_SEC_REV;
 	/* fru_id and fru_text is invalid */
 	rcd->sec_hdr.validation_bits = 0;
 	rcd->sec_hdr.flags = CPER_SEC_PRIMARY;
-	switch (type) {
+	switch (record->type) {
 	case PSTORE_TYPE_DMESG:
-		if (compressed)
+		if (record->compressed)
 			rcd->sec_hdr.section_type = CPER_SECTION_TYPE_DMESG_Z;
 		else
 			rcd->sec_hdr.section_type = CPER_SECTION_TYPE_DMESG;
@@ -1099,7 +1095,7 @@ static int erst_writer(enum pstore_type_id type, enum kmsg_dump_reason reason,
 	rcd->sec_hdr.section_severity = CPER_SEV_FATAL;
 
 	ret = erst_write(&rcd->hdr);
-	*id = rcd->hdr.record_id;
+	record->id = rcd->hdr.record_id;
 
 	return ret;
 }
diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index bda24129e85b..f81e3ec6f1c0 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -240,30 +240,28 @@ static ssize_t efi_pstore_read(struct pstore_record *record)
 	return size;
 }
 
-static int efi_pstore_write(enum pstore_type_id type,
-		enum kmsg_dump_reason reason, u64 *id,
-		unsigned int part, int count, bool compressed, size_t size,
-		struct pstore_info *psi)
+static int efi_pstore_write(struct pstore_record *record)
 {
 	char name[DUMP_NAME_LEN];
 	efi_char16_t efi_name[DUMP_NAME_LEN];
 	efi_guid_t vendor = LINUX_EFI_CRASH_GUID;
 	int i, ret = 0;
 
-	sprintf(name, "dump-type%u-%u-%d-%lu-%c", type, part, count,
-		get_seconds(), compressed ? 'C' : 'D');
+	snprintf(name, sizeof(name), "dump-type%u-%u-%d-%lu-%c",
+		 record->type, record->part, record->count,
+		 get_seconds(), record->compressed ? 'C' : 'D');
 
 	for (i = 0; i < DUMP_NAME_LEN; i++)
 		efi_name[i] = name[i];
 
 	efivar_entry_set_safe(efi_name, vendor, PSTORE_EFI_ATTRIBUTES,
-			      !pstore_cannot_block_path(reason),
-			      size, psi->buf);
+			      !pstore_cannot_block_path(record->reason),
+			      record->size, record->psi->buf);
 
-	if (reason == KMSG_DUMP_OOPS)
+	if (record->reason == KMSG_DUMP_OOPS)
 		efivar_run_worker();
 
-	*id = part;
+	record->id = record->part;
 	return ret;
 };
 
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 47968c2f2d0d..879658b4c679 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -484,7 +484,6 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 {
 	unsigned long	total = 0;
 	const char	*why;
-	u64		id;
 	unsigned int	part = 1;
 	unsigned long	flags = 0;
 	int		is_locked;
@@ -506,48 +505,59 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 	oopscount++;
 	while (total < kmsg_bytes) {
 		char *dst;
-		unsigned long size;
-		int hsize;
+		size_t dst_size;
+		int header_size;
 		int zipped_len = -1;
-		size_t len;
-		bool compressed = false;
-		size_t total_len;
+		size_t dump_size;
+		struct pstore_record record = {
+			.type = PSTORE_TYPE_DMESG,
+			.count = oopscount,
+			.reason = reason,
+			.part = part,
+			.compressed = false,
+			.buf = psinfo->buf,
+			.psi = psinfo,
+		};
 
 		if (big_oops_buf && is_locked) {
 			dst = big_oops_buf;
-			size = big_oops_buf_sz;
+			dst_size = big_oops_buf_sz;
 		} else {
 			dst = psinfo->buf;
-			size = psinfo->bufsize;
+			dst_size = psinfo->bufsize;
 		}
 
-		hsize = sprintf(dst, "%s#%d Part%u\n", why, oopscount, part);
-		size -= hsize;
+		/* Write dump header. */
+		header_size = snprintf(dst, dst_size, "%s#%d Part%u\n", why,
+				 oopscount, part);
+		dst_size -= header_size;
 
-		if (!kmsg_dump_get_buffer(dumper, true, dst + hsize,
-					  size, &len))
+		/* Write dump contents. */
+		if (!kmsg_dump_get_buffer(dumper, true, dst + header_size,
+					  dst_size, &dump_size))
 			break;
 
 		if (big_oops_buf && is_locked) {
 			zipped_len = pstore_compress(dst, psinfo->buf,
-						hsize + len, psinfo->bufsize);
+						header_size + dump_size,
+						psinfo->bufsize);
 
 			if (zipped_len > 0) {
-				compressed = true;
-				total_len = zipped_len;
+				record.compressed = true;
+				record.size = zipped_len;
 			} else {
-				total_len = copy_kmsg_to_buffer(hsize, len);
+				record.size = copy_kmsg_to_buffer(header_size,
+								  dump_size);
 			}
 		} else {
-			total_len = hsize + len;
+			record.size = header_size + dump_size;
 		}
 
-		ret = psinfo->write(PSTORE_TYPE_DMESG, reason, &id, part,
-				    oopscount, compressed, total_len, psinfo);
+		ret = psinfo->write(&record);
 		if (ret == 0 && reason == KMSG_DUMP_OOPS && pstore_is_mounted())
 			pstore_new_entry = 1;
 
-		total += total_len;
+		total += record.size;
 		part++;
 	}
 	if (is_locked)
@@ -618,14 +628,12 @@ static void pstore_register_console(void) {}
 static void pstore_unregister_console(void) {}
 #endif
 
-static int pstore_write_compat(enum pstore_type_id type,
-			       enum kmsg_dump_reason reason,
-			       u64 *id, unsigned int part, int count,
-			       bool compressed, size_t size,
-			       struct pstore_info *psi)
+static int pstore_write_compat(struct pstore_record *record)
 {
-	return psi->write_buf(type, reason, id, part, psinfo->buf, compressed,
-			     size, psi);
+	return record->psi->write_buf(record->type, record->reason,
+				      &record->id, record->part,
+				      psinfo->buf, record->compressed,
+				      record->size, record->psi);
 }
 
 static int pstore_write_buf_user_compat(enum pstore_type_id type,
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 8b51c9da8d16..c672de41e9b5 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -54,23 +54,32 @@ struct pstore_info;
  * @type:	pstore record type
  * @id:		per-type unique identifier for record
  * @time:	timestamp of the record
- * @count:	for PSTORE_TYPE_DMESG, the Oops count.
- * @compressed:	for PSTORE_TYPE_DMESG, whether the buffer is compressed
  * @buf:	pointer to record contents
  * @size:	size of @buf
  * @ecc_notice_size:
  *		ECC information for @buf
+ *
+ * Valid for PSTORE_TYPE_DMESG @type:
+ *
+ * @count:	Oops count since boot
+ * @reason:	kdump reason for notification
+ * @part:	position in a multipart record
+ * @compressed:	whether the buffer is compressed
+ *
  */
 struct pstore_record {
 	struct pstore_info	*psi;
 	enum pstore_type_id	type;
 	u64			id;
 	struct timespec		time;
-	int			count;
-	bool			compressed;
 	char			*buf;
 	ssize_t			size;
 	ssize_t			ecc_notice_size;
+
+	int			count;
+	enum kmsg_dump_reason	reason;
+	unsigned int		part;
+	bool			compressed;
 };
 
 /**
@@ -125,16 +134,10 @@ struct pstore_record {
  *	data to be stored has already been written to the registered @buf
  *	of the @psi structure.
  *
- *	@type:	in: pstore record type to write
- *	@reason:
- *		in: pstore write reason
- *	@id:	out: unique identifier for the record
- *	@part:	in: position in a multipart write
- *	@count:	in: increasing from 0 since boot, the number of this Oops
- *	@compressed:
- *		in: if the record is compressed
- *	@size:	in: size of the write
- *	@psi:	in: pointer to the struct pstore_info for the backend
+ *	@record:
+ *		pointer to record metadata. Note that @buf is NULL, since
+ *		the @buf registered with @psi is what has been written. The
+ *		backend is expected to update @id.
  *
  *	Returns 0 on success, and non-zero on error.
  *
@@ -203,10 +206,7 @@ struct pstore_info {
 	int		(*open)(struct pstore_info *psi);
 	int		(*close)(struct pstore_info *psi);
 	ssize_t		(*read)(struct pstore_record *record);
-	int		(*write)(enum pstore_type_id type,
-			enum kmsg_dump_reason reason, u64 *id,
-			unsigned int part, int count, bool compressed,
-			size_t size, struct pstore_info *psi);
+	int		(*write)(struct pstore_record *record);
 	int		(*write_buf)(enum pstore_type_id type,
 			enum kmsg_dump_reason reason, u64 *id,
 			unsigned int part, const char *buf, bool compressed,
-- 
2.7.4
