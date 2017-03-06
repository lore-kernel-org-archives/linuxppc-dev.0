Return-Path: <keescook@chromium.org>
Received: from mail-pf0-x229.google.com (mail-pf0-x229.google.com
 [IPv6:2607:f8b0:400e:c00::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcYWM6JjXzDqXg
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 08:55:43 +1100 (AEDT)
Received: by mail-pf0-x229.google.com with SMTP id j5so65711183pfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Mar 2017 13:55:43 -0800 (PST)
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
Subject: [PATCH 13/18] pstore: Allocate records on heap instead of stack
Date: Mon,  6 Mar 2017 13:55:27 -0800
Message-Id: <1488837332-71582-14-git-send-email-keescook@chromium.org>
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

In preparation for handling records off to pstore_mkfile(), allocate the
record instead of reusing stack. This still always frees the record,
though, since pstore_mkfile() isn't yet keeping it.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index d897e2f11b6a..072326625629 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -818,8 +818,7 @@ static void decompress_record(struct pstore_record *record)
 void pstore_get_records(int quiet)
 {
 	struct pstore_info *psi = psinfo;
-	struct pstore_record	record = { .psi = psi, };
-	int			failed = 0, rc;
+	int failed = 0;
 
 	if (!psi)
 		return;
@@ -833,19 +832,34 @@ void pstore_get_records(int quiet)
 	 * may reallocate record.buf. On success, pstore_mkfile() will keep
 	 * the record.buf, so free it only on failure.
 	 */
-	while ((record.size = psi->read(&record)) > 0) {
-		decompress_record(&record);
-		rc = pstore_mkfile(&record);
+	for (;;) {
+		struct pstore_record *record;
+		int rc;
+
+		record = kzalloc(sizeof(*record), GFP_KERNEL);
+		if (!record) {
+			pr_err("out of memory creating record\n");
+			break;
+		}
+		record->psi = psi;
+
+		record->size = psi->read(record);
+
+		/* No more records left in backend? */
+		if (record->size <= 0)
+			break;
+
+		decompress_record(record);
+		rc = pstore_mkfile(record);
 		if (rc) {
 			/* pstore_mkfile() did not take buf, so free it. */
-			kfree(record.buf);
+			kfree(record->buf);
 			if (rc != -EEXIST || !quiet)
 				failed++;
 		}
 
 		/* Reset for next record. */
-		memset(&record, 0, sizeof(record));
-		record.psi = psi;
+		kfree(record);
 	}
 	if (psi->close)
 		psi->close(psi);
-- 
2.7.4
