Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjWrD14yGzDrLr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 03:56:59 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8QHqj1f076546
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 13:56:58 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25q5mrrh9v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 13:56:57 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Mon, 26 Sep 2016 23:26:54 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id A3B4A125805B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 23:27:12 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8QHuptE52953316
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 23:26:51 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8QHulAE002690
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 23:26:51 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 03/10] ima: permit duplicate measurement list entries
Date: Mon, 26 Sep 2016 13:30:22 -0400
In-Reply-To: <1474911029-6372-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1474911029-6372-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1474911029-6372-4-git-send-email-zohar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Measurements carried across kexec need to be added to the IMA
measurement list, but should not prevent measurements of the newly
booted kernel from being added to the measurement list. This patch
adds support for allowing duplicate measurements.

The "boot_aggregate" measurement entry is the delimiter between soft
boots.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_queue.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 4b1bb77..12d1b04 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -65,11 +65,12 @@ static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 }
 
 /* ima_add_template_entry helper function:
- * - Add template entry to measurement list and hash table.
+ * - Add template entry to the measurement list and hash table, for
+ *   all entries except those carried across kexec.
  *
  * (Called with ima_extend_list_mutex held.)
  */
-static int ima_add_digest_entry(struct ima_template_entry *entry)
+static int ima_add_digest_entry(struct ima_template_entry *entry, int flags)
 {
 	struct ima_queue_entry *qe;
 	unsigned int key;
@@ -85,8 +86,10 @@ static int ima_add_digest_entry(struct ima_template_entry *entry)
 	list_add_tail_rcu(&qe->later, &ima_measurements);
 
 	atomic_long_inc(&ima_htable.len);
-	key = ima_hash_key(entry->digest);
-	hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
+	if (flags) {
+		key = ima_hash_key(entry->digest);
+		hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
+	}
 	return 0;
 }
 
@@ -126,7 +129,7 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 		}
 	}
 
-	result = ima_add_digest_entry(entry);
+	result = ima_add_digest_entry(entry, 1);
 	if (result < 0) {
 		audit_cause = "ENOMEM";
 		audit_info = 0;
@@ -155,7 +158,7 @@ int ima_restore_measurement_entry(struct ima_template_entry *entry)
 	int result = 0;
 
 	mutex_lock(&ima_extend_list_mutex);
-	result = ima_add_digest_entry(entry);
+	result = ima_add_digest_entry(entry, 0);
 	mutex_unlock(&ima_extend_list_mutex);
 	return result;
 }
-- 
2.1.0
