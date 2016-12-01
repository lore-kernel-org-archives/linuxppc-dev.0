Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTfHh06rwzDw0l
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 12:06:23 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB1143DR035855
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 20:06:21 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2728pj34mm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 20:06:21 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 1 Dec 2016 06:36:17 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 6208C3940061
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 06:36:15 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB115fVd27394242
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2016 06:35:41 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB116EDm014351
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2016 06:36:15 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCH v8 03/10] ima: permit duplicate measurement list entries
Date: Wed, 30 Nov 2016 20:05:39 -0500
In-Reply-To: <1480554346-29071-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1480554346-29071-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1480554346-29071-4-git-send-email-zohar@linux.vnet.ibm.com>
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

Changelog v7:
- use boolean for indicating hash should be added to hash table.
(Reported by Dmitry Kasatkin)

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Acked-by: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
---
 security/integrity/ima/ima_queue.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 4b1bb7787839..e180de598a92 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -65,11 +65,13 @@ static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 }
 
 /* ima_add_template_entry helper function:
- * - Add template entry to measurement list and hash table.
+ * - Add template entry to the measurement list and hash table, for
+ *   all entries except those carried across kexec.
  *
  * (Called with ima_extend_list_mutex held.)
  */
-static int ima_add_digest_entry(struct ima_template_entry *entry)
+static int ima_add_digest_entry(struct ima_template_entry *entry,
+				bool update_htable)
 {
 	struct ima_queue_entry *qe;
 	unsigned int key;
@@ -85,8 +87,10 @@ static int ima_add_digest_entry(struct ima_template_entry *entry)
 	list_add_tail_rcu(&qe->later, &ima_measurements);
 
 	atomic_long_inc(&ima_htable.len);
-	key = ima_hash_key(entry->digest);
-	hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
+	if (update_htable) {
+		key = ima_hash_key(entry->digest);
+		hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
+	}
 	return 0;
 }
 
@@ -126,7 +130,7 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 		}
 	}
 
-	result = ima_add_digest_entry(entry);
+	result = ima_add_digest_entry(entry, 1);
 	if (result < 0) {
 		audit_cause = "ENOMEM";
 		audit_info = 0;
@@ -155,7 +159,7 @@ int ima_restore_measurement_entry(struct ima_template_entry *entry)
 	int result = 0;
 
 	mutex_lock(&ima_extend_list_mutex);
-	result = ima_add_digest_entry(entry);
+	result = ima_add_digest_entry(entry, 0);
 	mutex_unlock(&ima_extend_list_mutex);
 	return result;
 }
-- 
2.1.0
