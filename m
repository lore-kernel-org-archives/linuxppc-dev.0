Return-Path: <keescook@chromium.org>
Received: from mail-pf0-x236.google.com (mail-pf0-x236.google.com
 [IPv6:2607:f8b0:400e:c00::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcYWJ1Dj0zDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 08:55:40 +1100 (AEDT)
Received: by mail-pf0-x236.google.com with SMTP id v190so28747548pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Mar 2017 13:55:40 -0800 (PST)
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
Subject: [PATCH 06/18] pstore: Extract common arguments into structure
Date: Mon,  6 Mar 2017 13:55:20 -0800
Message-Id: <1488837332-71582-7-git-send-email-keescook@chromium.org>
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

The read/mkfile pair pass the same arguments and should be cleared
between calls. Move to a structure and wipe it after every loop.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c   | 55 +++++++++++++++++++++++++++-----------------------
 include/linux/pstore.h | 28 ++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 26 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 320a673ecb5b..3fa1575a6e36 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -766,16 +766,9 @@ EXPORT_SYMBOL_GPL(pstore_unregister);
 void pstore_get_records(int quiet)
 {
 	struct pstore_info *psi = psinfo;
-	char			*buf = NULL;
-	ssize_t			size;
-	u64			id;
-	int			count;
-	enum pstore_type_id	type;
-	struct timespec		time;
+	struct pstore_record	record = { .psi = psi, };
 	int			failed = 0, rc;
-	bool			compressed;
 	int			unzipped_len = -1;
-	ssize_t			ecc_notice_size = 0;
 
 	if (!psi)
 		return;
@@ -784,39 +777,51 @@ void pstore_get_records(int quiet)
 	if (psi->open && psi->open(psi))
 		goto out;
 
-	while ((size = psi->read(&id, &type, &count, &time, &buf, &compressed,
-				 &ecc_notice_size, psi)) > 0) {
-		if (compressed && (type == PSTORE_TYPE_DMESG)) {
+	while ((record.size = psi->read(&record.id, &record.type,
+				 &record.count, &record.time,
+				 &record.buf, &record.compressed,
+				 &record.ecc_notice_size,
+				 record.psi)) > 0) {
+		if (record.compressed &&
+		    record.type == PSTORE_TYPE_DMESG) {
 			if (big_oops_buf)
-				unzipped_len = pstore_decompress(buf,
-							big_oops_buf, size,
+				unzipped_len = pstore_decompress(
+							record.buf,
+							big_oops_buf,
+							record.size,
 							big_oops_buf_sz);
 
 			if (unzipped_len > 0) {
-				if (ecc_notice_size)
+				if (record.ecc_notice_size)
 					memcpy(big_oops_buf + unzipped_len,
-					       buf + size, ecc_notice_size);
-				kfree(buf);
-				buf = big_oops_buf;
-				size = unzipped_len;
-				compressed = false;
+					       record.buf + recorrecord.size,
+					       record.ecc_notice_size);
+				kfree(record.buf);
+				record.buf = big_oops_buf;
+				record.size = unzipped_len;
+				record.compressed = false;
 			} else {
 				pr_err("decompression failed;returned %d\n",
 				       unzipped_len);
-				compressed = true;
+				record.compressed = true;
 			}
 		}
-		rc = pstore_mkfile(type, psi->name, id, count, buf,
-				   compressed, size + ecc_notice_size,
-				   time, psi);
+		rc = pstore_mkfile(record.type, psi->name, record.id,
+				   record.count, record.buf,
+				   record.compressed,
+				   record.size + record.ecc_notice_size,
+				   record.time, record.psi);
 		if (unzipped_len < 0) {
 			/* Free buffer other than big oops */
-			kfree(buf);
-			buf = NULL;
+			kfree(record.buf);
+			record.buf = NULL;
 		} else
 			unzipped_len = -1;
 		if (rc && (rc != -EEXIST || !quiet))
 			failed++;
+
+		memset(&record, 0, sizeof(record));
+		record.psi = psi;
 	}
 	if (psi->close)
 		psi->close(psi);
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 083b10bacd4a..7b25f7f17915 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -30,6 +30,8 @@
 #include <linux/time.h>
 #include <linux/types.h>
 
+struct module;
+
 /* pstore record types (see fs/pstore/inode.c for filename templates) */
 enum pstore_type_id {
 	PSTORE_TYPE_DMESG	= 0,
@@ -45,7 +47,31 @@ enum pstore_type_id {
 	PSTORE_TYPE_UNKNOWN	= 255
 };
 
-struct module;
+struct pstore_info;
+/**
+ * struct pstore_record - details of a pstore record entry
+ * @psi:	pstore backend driver information
+ * @type:	pstore record type
+ * @id:		per-type unique identifier for record
+ * @time:	timestamp of the record
+ * @count:	for PSTORE_TYPE_DMESG, the Oops count.
+ * @compressed:	for PSTORE_TYPE_DMESG, whether the buffer is compressed
+ * @buf:	pointer to record contents
+ * @size:	size of @buf
+ * @ecc_notice_size:
+ *		ECC information for @buf
+ */
+struct pstore_record {
+	struct pstore_info	*psi;
+	enum pstore_type_id	type;
+	u64			id;
+	struct timespec		time;
+	int			count;
+	bool			compressed;
+	char			*buf;
+	ssize_t			size;
+	ssize_t			ecc_notice_size;
+};
 
 /**
  * struct pstore_info - backend pstore driver structure
-- 
2.7.4
