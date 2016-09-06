Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sT7c83wjCzDsLx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 00:03:36 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u86E30DU009194
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 10:03:34 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 259x0qcuk3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Sep 2016 10:03:32 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Wed, 7 Sep 2016 00:03:28 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7EBBA2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 00:03:25 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u86E3PZZ3932606
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Sep 2016 00:03:25 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u86E3OU7027774
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Sep 2016 00:03:25 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 3/9] ima: maintain memory size needed for serializing the
 measurement list
Date: Tue,  6 Sep 2016 10:02:58 -0400
In-Reply-To: <1473170584-15094-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1473170584-15094-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1473170584-15094-4-git-send-email-zohar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation for serializing the binary_runtime_measurements, this patch
maintains the amount of memory required.

Changelog v3:
- include the ima_kexec_hdr size in the binary_runtime_measurement size.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/Kconfig     | 12 +++++++++
 security/integrity/ima/ima.h       |  1 +
 security/integrity/ima/ima_queue.c | 53 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 5487827..1c5a1c2 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -27,6 +27,18 @@ config IMA
 	  to learn more about IMA.
 	  If unsure, say N.
 
+config IMA_KEXEC
+	bool "Enable carrying the IMA measurement list across a soft boot"
+	depends on IMA && TCG_TPM && KEXEC_FILE
+	default n
+	help
+	   TPM PCRs are only reset on a hard reboot.  In order to validate
+	   a TPM's quote after a soft boot, the IMA measurement list of the
+	   running kernel must be saved and restored on boot.
+
+	   Depending on the IMA policy, the measurement list can grow to
+	   be very large.
+
 config IMA_MEASURE_PCR_IDX
 	int
 	depends on IMA
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e7b3755..f9cd08e 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -133,6 +133,7 @@ void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
 struct ima_template_desc *ima_template_desc_current(void);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
+unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
 
 #ifdef CONFIG_KEXEC_FILE
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 12d1b04..3a3cc2a 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -29,6 +29,11 @@
 #define AUDIT_CAUSE_LEN_MAX 32
 
 LIST_HEAD(ima_measurements);	/* list of all measurements */
+#ifdef CONFIG_IMA_KEXEC
+static unsigned long binary_runtime_size;
+#else
+static unsigned long binary_runtime_size = ULONG_MAX;
+#endif
 
 /* key: inode (before secure-hashing a file) */
 struct ima_h_table ima_htable = {
@@ -64,6 +69,24 @@ static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 	return ret;
 }
 
+/*
+ * Calculate the memory required for serializing a single
+ * binary_runtime_measurement list entry, which contains a
+ * couple of variable length fields (e.g template name and data).
+ */
+static int get_binary_runtime_size(struct ima_template_entry *entry)
+{
+	int size = 0;
+
+	size += sizeof(u32);	/* pcr */
+	size += sizeof(entry->digest);
+	size += sizeof(int);	/* template name size field */
+	size += strlen(entry->template_desc->name);
+	size += sizeof(entry->template_data_len);
+	size += entry->template_data_len;
+	return size;
+}
+
 /* ima_add_template_entry helper function:
  * - Add template entry to the measurement list and hash table, for
  *   all entries except those carried across kexec.
@@ -90,9 +113,30 @@ static int ima_add_digest_entry(struct ima_template_entry *entry, int flags)
 		key = ima_hash_key(entry->digest);
 		hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
 	}
+
+	if (binary_runtime_size != ULONG_MAX) {
+		int size;
+
+		size = get_binary_runtime_size(entry);
+		binary_runtime_size = (binary_runtime_size < ULONG_MAX - size) ?
+		     binary_runtime_size + size : ULONG_MAX;
+	}
 	return 0;
 }
 
+/*
+ * Return the amount of memory required for serializing the
+ * entire binary_runtime_measurement list, including the ima_kexec_hdr
+ * structure.
+ */
+unsigned long ima_get_binary_runtime_size(void)
+{
+	if (binary_runtime_size >= (ULONG_MAX - sizeof(struct ima_kexec_hdr)))
+		return ULONG_MAX;
+	else
+		return binary_runtime_size + sizeof(struct ima_kexec_hdr);
+};
+
 static int ima_pcr_extend(const u8 *hash, int pcr)
 {
 	int result = 0;
@@ -106,8 +150,13 @@ static int ima_pcr_extend(const u8 *hash, int pcr)
 	return result;
 }
 
-/* Add template entry to the measurement list and hash table,
- * and extend the pcr.
+/*
+ * Add template entry to the measurement list and hash table, and
+ * extend the pcr.
+ *
+ * On systems which support carrying the IMA measurement list across
+ * kexec, maintain the total memory size required for serializing the
+ * binary_runtime_measurements.
  */
 int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
-- 
2.1.0
