Return-Path: <eric@ebiederm.dsl.xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4833248280
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 04:28:51 +1100 (EST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Subject: [PATCH 56/59] sysctl: factor out sysctl_head_next from do_sysctl
Date: Tue, 16 Jan 2007 09:40:01 -0700
Message-Id: <11689657011683-git-send-email-ebiederm@xmission.com>
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Cc: linux-mips@linux-mips.org, linux-parport@lists.infradead.org,
	heiko.carstens@de.ibm.com, ak@suse.de, linuxppc-dev@ozlabs.org,
	paulus@samba.org, aharkes@cs.cmu.edu, schwidefsky@de.ibm.com,
	tim@cyberelk.net, rtc-linux@googlegroups.com,
	linux-scsi@vger.kernel.org, kurt.hackel@oracle.com,
	coda@cs.cmu.edu, vojtech@suse.cz,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	James.Bottomley@SteelEye.com, clemens@ladisch.de,
	xfs@oss.sgi.com, xfs-masters@oss.sgi.com, andrea@suse.de,
	openipmi-developer@lists.sourceforge.net,
	linux-390@vm.marist.edu, codalist@TELEMANN.coda.cs.cmu.edu,
	a.zummo@towertech.it, tony.luck@intel.com,
	linux-ntfs-dev@lists.sourceforge.net, netdev@vger.kernel.org,
	aia21@cantab.net, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, lethal@linux-sh.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	containers@lists.osdl.org, linux390@de.ibm.com, philb@gnu.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

The current logic to walk through the list of sysctl table
headers is slightly painful and implement in a way it cannot
be used by code outside sysctl.c

I am in the process of implementing a version of the sysctl
proc support that instead of using the proc generic non-caching
monster, just uses the existing sysctl data structure as
backing store for building the dcache entries and for doing
directory reads.   To use the existing data structures however
I need a way to get at them.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/sysctl.h |    4 +++
 kernel/sysctl.c        |   57 +++++++++++++++++++++++++++++++++++------------
 2 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 6113f3b..81ee9ea 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -923,6 +923,10 @@ enum
 #ifdef __KERNEL__
 #include <linux/list.h>
 
+/* For the /proc/sys support */
+extern struct ctl_table_header *sysctl_head_next(struct ctl_table_header *prev);
+extern void sysctl_head_finish(struct ctl_table_header *prev);
+
 extern void sysctl_init(void);
 
 typedef struct ctl_table ctl_table;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5beee1f..ca2831a 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1066,6 +1066,42 @@ static void start_unregistering(struct ctl_table_header *p)
 	list_del_init(&p->ctl_entry);
 }
 
+void sysctl_head_finish(struct ctl_table_header *head)
+{
+	if (!head)
+		return;
+	spin_lock(&sysctl_lock);
+	unuse_table(head);
+	spin_unlock(&sysctl_lock);
+}
+
+struct ctl_table_header *sysctl_head_next(struct ctl_table_header *prev)
+{
+	struct ctl_table_header *head;
+	struct list_head *tmp;
+	spin_lock(&sysctl_lock);
+	if (prev) {
+		tmp = &prev->ctl_entry;
+		unuse_table(prev);
+		goto next;
+	}
+	tmp = &root_table_header.ctl_entry;
+	for (;;) {
+		head = list_entry(tmp, struct ctl_table_header, ctl_entry);
+
+		if (!use_table(head))
+			goto next;
+		spin_unlock(&sysctl_lock);
+		return head;
+	next:
+		tmp = tmp->next;
+		if (tmp == &root_table_header.ctl_entry)
+			break;
+	}
+	spin_unlock(&sysctl_lock);
+	return NULL;
+}
+
 void __init sysctl_init(void)
 {
 #ifdef CONFIG_PROC_SYSCTL
@@ -1077,6 +1113,7 @@ void __init sysctl_init(void)
 int do_sysctl(int __user *name, int nlen, void __user *oldval, size_t __user *oldlenp,
 	       void __user *newval, size_t newlen)
 {
+	struct ctl_table_header *head;
 	struct list_head *tmp;
 	int error = -ENOTDIR;
 
@@ -1087,26 +1124,16 @@ int do_sysctl(int __user *name, int nlen, void __user *oldval, size_t __user *ol
 		if (!oldlenp || get_user(old_len, oldlenp))
 			return -EFAULT;
 	}
-	spin_lock(&sysctl_lock);
-	tmp = &root_table_header.ctl_entry;
-	do {
-		struct ctl_table_header *head =
-			list_entry(tmp, struct ctl_table_header, ctl_entry);
 
-		if (!use_table(head))
-			continue;
-
-		spin_unlock(&sysctl_lock);
+	for (head = sysctl_head_next(NULL); head; head = sysctl_head_next(head)) {
 
 		error = parse_table(name, nlen, oldval, oldlenp, 
 					newval, newlen, head->ctl_table);
-
-		spin_lock(&sysctl_lock);
-		unuse_table(head);
-		if (error != -ENOTDIR)
+		if (error != -ENOTDIR) {
+			sysctl_head_finish(head);
 			break;
-	} while ((tmp = tmp->next) != &root_table_header.ctl_entry);
-	spin_unlock(&sysctl_lock);
+		}
+	}
 	return error;
 }
 
-- 
1.4.4.1.g278f
