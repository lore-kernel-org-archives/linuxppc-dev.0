Return-Path: <keescook@chromium.org>
Received: from mail-pg0-x235.google.com (mail-pg0-x235.google.com
 [IPv6:2607:f8b0:400e:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcYWP5Fn8zDqXx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 08:55:45 +1100 (AEDT)
Received: by mail-pg0-x235.google.com with SMTP id b129so70803296pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Mar 2017 13:55:45 -0800 (PST)
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
Subject: [PATCH 17/18] pstore: Replace arguments for write_buf_user() API
Date: Mon,  6 Mar 2017 13:55:31 -0800
Message-Id: <1488837332-71582-18-git-send-email-keescook@chromium.org>
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

Removes argument list in favor of pstore record, though the user buffer
remains passed separately since it must carry the __user annotation.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c   | 35 ++++++++++++-----------------------
 fs/pstore/pmsg.c       |  9 ++++++---
 fs/pstore/ram.c        | 14 +++++---------
 include/linux/pstore.h | 23 +++++++----------------
 4 files changed, 30 insertions(+), 51 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 5eecf9012459..1e6642a2063e 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -639,47 +639,36 @@ static int pstore_write_compat(struct pstore_record *record)
 	return record->psi->write_buf(record);
 }
 
-static int pstore_write_buf_user_compat(enum pstore_type_id type,
-			       enum kmsg_dump_reason reason,
-			       u64 *id, unsigned int part,
-			       const char __user *buf,
-			       bool compressed, size_t size,
-			       struct pstore_info *psi)
+static int pstore_write_buf_user_compat(struct pstore_record *record,
+					const char __user *buf)
 {
 	unsigned long flags = 0;
-	size_t i, bufsize = size;
+	size_t i, bufsize, total_size = record->size;
 	long ret = 0;
 
-	if (unlikely(!access_ok(VERIFY_READ, buf, size)))
+	if (unlikely(!access_ok(VERIFY_READ, buf, total_size)))
 		return -EFAULT;
+	bufsize = total_size;
 	if (bufsize > psinfo->bufsize)
 		bufsize = psinfo->bufsize;
+	record->buf = psinfo->buf;
 	spin_lock_irqsave(&psinfo->buf_lock, flags);
-	for (i = 0; i < size; ) {
-		struct pstore_record record = {
-			.type = type,
-			.reason = reason,
-			.id = id,
-			.part = part,
-			.buf = psinfo->buf,
-			.compressed = compressed,
-			.psi = psi,
-		};
-		size_t c = min(size - i, bufsize);
+	for (i = 0; i < total_size; ) {
+		size_t c = min(total_size - i, bufsize);
 
-		ret = __copy_from_user(psinfo->buf, buf + i, c);
+		ret = __copy_from_user(record->buf, buf + i, c);
 		if (unlikely(ret != 0)) {
 			ret = -EFAULT;
 			break;
 		}
-		record.size = c;
-		ret = psi->write_buf(&record);
+		record->size = c;
+		ret = record->psi->write_buf(record);
 		if (unlikely(ret < 0))
 			break;
 		i += c;
 	}
 	spin_unlock_irqrestore(&psinfo->buf_lock, flags);
-	return unlikely(ret < 0) ? ret : size;
+	return unlikely(ret < 0) ? ret : total_size;
 }
 
 /*
diff --git a/fs/pstore/pmsg.c b/fs/pstore/pmsg.c
index 78f6176c020f..ce35907602de 100644
--- a/fs/pstore/pmsg.c
+++ b/fs/pstore/pmsg.c
@@ -23,7 +23,11 @@ static DEFINE_MUTEX(pmsg_lock);
 static ssize_t write_pmsg(struct file *file, const char __user *buf,
 			  size_t count, loff_t *ppos)
 {
-	u64 id;
+	struct pstore_record record = {
+		.type = PSTORE_TYPE_PMSG,
+		.size = count,
+		.psi = psinfo,
+	};
 	int ret;
 
 	if (!count)
@@ -34,8 +38,7 @@ static ssize_t write_pmsg(struct file *file, const char __user *buf,
 		return -EFAULT;
 
 	mutex_lock(&pmsg_lock);
-	ret = psinfo->write_buf_user(PSTORE_TYPE_PMSG, 0, &id, 0, buf, 0, count,
-				     psinfo);
+	ret = psinfo->write_buf_user(&record, buf);
 	mutex_unlock(&pmsg_lock);
 	return ret ? ret : count;
 }
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index a7cdde60b1f9..d85e1adae1b6 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -451,19 +451,15 @@ static int notrace ramoops_pstore_write_buf(struct pstore_record *record)
 	return 0;
 }
 
-static int notrace ramoops_pstore_write_buf_user(enum pstore_type_id type,
-						 enum kmsg_dump_reason reason,
-						 u64 *id, unsigned int part,
-						 const char __user *buf,
-						 bool compressed, size_t size,
-						 struct pstore_info *psi)
+static int notrace ramoops_pstore_write_buf_user(struct pstore_record *record,
+						 const char __user *buf)
 {
-	if (type == PSTORE_TYPE_PMSG) {
-		struct ramoops_context *cxt = psi->data;
+	if (record->type == PSTORE_TYPE_PMSG) {
+		struct ramoops_context *cxt = record->psi->data;
 
 		if (!cxt->mprz)
 			return -ENOMEM;
-		return persistent_ram_write_user(cxt->mprz, buf, size);
+		return persistent_ram_write_user(cxt->mprz, buf, record->size);
 	}
 
 	return -EINVAL;
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 351a22242518..7f6eaa71504e 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -152,18 +152,11 @@ struct pstore_record {
  *
  * @write_buf_user:
  *	Perform a frontend write to a backend record, using a specified
- *	buffer that is coming directly from userspace.
- *
- *	@type:	in: pstore record type to write
- *	@reason:
- *		in: pstore write reason
- *	@id:	out: unique identifier for the record
- *	@part:	in: position in a multipart write
- *	@buf:	in: pointer to userspace contents to write to backend record
- *	@compressed:
- *		in: if the record is compressed
- *	@size:	in: size of the write
- *	@psi:	in: pointer to the struct pstore_info for the backend
+ *	buffer that is coming directly from userspace, instead of the
+ *	@record @buf.
+ *
+ *	@record:	pointer to record metadata.
+ *	@buf:		pointer to userspace contents to write to backend
  *
  *	Returns 0 on success, and non-zero on error.
  *
@@ -196,10 +189,8 @@ struct pstore_info {
 	ssize_t		(*read)(struct pstore_record *record);
 	int		(*write)(struct pstore_record *record);
 	int		(*write_buf)(struct pstore_record *record);
-	int		(*write_buf_user)(enum pstore_type_id type,
-			enum kmsg_dump_reason reason, u64 *id,
-			unsigned int part, const char __user *buf,
-			bool compressed, size_t size, struct pstore_info *psi);
+	int		(*write_buf_user)(struct pstore_record *record,
+					  const char __user *buf);
 	int		(*erase)(struct pstore_record *record);
 };
 
-- 
2.7.4
