Return-Path: <lstoakes@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com
 [IPv6:2a00:1450:4010:c07::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svWbg2YvczDsxR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 11:20:47 +1100 (AEDT)
Received: by mail-lf0-x243.google.com with SMTP id x23so3968697lfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 17:20:47 -0700 (PDT)
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>,
 Hugh Dickins <hughd@google.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Rik van Riel <riel@redhat.com>, Mel Gorman <mgorman@techsingularity.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 adi-buildroot-devel@lists.sourceforge.net, ceph-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 kvm@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cris-kernel@axis.com,
 linux-fbdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mips@linux-mips.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 sparclinux@vger.kernel.org, x86@kernel.org,
 Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 09/10] mm: replace access_remote_vm() write parameter with
 gup_flags
Date: Thu, 13 Oct 2016 01:20:19 +0100
Message-Id: <20161013002020.3062-10-lstoakes@gmail.com>
In-Reply-To: <20161013002020.3062-1-lstoakes@gmail.com>
References: <20161013002020.3062-1-lstoakes@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch removes the write parameter from access_remote_vm() and replaces it
with a gup_flags parameter as use of this function previously _implied_
FOLL_FORCE, whereas after this patch callers explicitly pass this flag.

We make this explicit as use of FOLL_FORCE can result in surprising behaviour
(and hence bugs) within the mm subsystem.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 fs/proc/base.c     | 19 +++++++++++++------
 include/linux/mm.h |  2 +-
 mm/memory.c        | 11 +++--------
 mm/nommu.c         |  7 +++----
 4 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c2964d8..8e65446 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -252,7 +252,7 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 	 * Inherently racy -- command line shares address space
 	 * with code and data.
 	 */
-	rv = access_remote_vm(mm, arg_end - 1, &c, 1, 0);
+	rv = access_remote_vm(mm, arg_end - 1, &c, 1, FOLL_FORCE);
 	if (rv <= 0)
 		goto out_free_page;
 
@@ -270,7 +270,8 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 			int nr_read;
 
 			_count = min3(count, len, PAGE_SIZE);
-			nr_read = access_remote_vm(mm, p, page, _count, 0);
+			nr_read = access_remote_vm(mm, p, page, _count,
+					FOLL_FORCE);
 			if (nr_read < 0)
 				rv = nr_read;
 			if (nr_read <= 0)
@@ -305,7 +306,8 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 			bool final;
 
 			_count = min3(count, len, PAGE_SIZE);
-			nr_read = access_remote_vm(mm, p, page, _count, 0);
+			nr_read = access_remote_vm(mm, p, page, _count,
+					FOLL_FORCE);
 			if (nr_read < 0)
 				rv = nr_read;
 			if (nr_read <= 0)
@@ -354,7 +356,8 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 			bool final;
 
 			_count = min3(count, len, PAGE_SIZE);
-			nr_read = access_remote_vm(mm, p, page, _count, 0);
+			nr_read = access_remote_vm(mm, p, page, _count,
+					FOLL_FORCE);
 			if (nr_read < 0)
 				rv = nr_read;
 			if (nr_read <= 0)
@@ -832,6 +835,7 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 	unsigned long addr = *ppos;
 	ssize_t copied;
 	char *page;
+	unsigned int flags = FOLL_FORCE;
 
 	if (!mm)
 		return 0;
@@ -844,6 +848,9 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 	if (!atomic_inc_not_zero(&mm->mm_users))
 		goto free;
 
+	if (write)
+		flags |= FOLL_WRITE;
+
 	while (count > 0) {
 		int this_len = min_t(int, count, PAGE_SIZE);
 
@@ -852,7 +859,7 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 			break;
 		}
 
-		this_len = access_remote_vm(mm, addr, page, this_len, write);
+		this_len = access_remote_vm(mm, addr, page, this_len, flags);
 		if (!this_len) {
 			if (!copied)
 				copied = -EIO;
@@ -965,7 +972,7 @@ static ssize_t environ_read(struct file *file, char __user *buf,
 		this_len = min(max_len, this_len);
 
 		retval = access_remote_vm(mm, (env_start + src),
-			page, this_len, 0);
+			page, this_len, FOLL_FORCE);
 
 		if (retval <= 0) {
 			ret = retval;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2a481d3..3e5234e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1268,7 +1268,7 @@ static inline int fixup_user_fault(struct task_struct *tsk,
 
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
 extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
-		void *buf, int len, int write);
+		void *buf, int len, unsigned int gup_flags);
 
 long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		      unsigned long start, unsigned long nr_pages,
diff --git a/mm/memory.c b/mm/memory.c
index 79ebed3..bac2d99 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3935,19 +3935,14 @@ static int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
  * @addr:	start address to access
  * @buf:	source or destination buffer
  * @len:	number of bytes to transfer
- * @write:	whether the access is a write
+ * @gup_flags:	flags modifying lookup behaviour
  *
  * The caller must hold a reference on @mm.
  */
 int access_remote_vm(struct mm_struct *mm, unsigned long addr,
-		void *buf, int len, int write)
+		void *buf, int len, unsigned int gup_flags)
 {
-	unsigned int flags = FOLL_FORCE;
-
-	if (write)
-		flags |= FOLL_WRITE;
-
-	return __access_remote_vm(NULL, mm, addr, buf, len, flags);
+	return __access_remote_vm(NULL, mm, addr, buf, len, gup_flags);
 }
 
 /*
diff --git a/mm/nommu.c b/mm/nommu.c
index bde7df3..93d5bb5 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1847,15 +1847,14 @@ static int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
  * @addr:	start address to access
  * @buf:	source or destination buffer
  * @len:	number of bytes to transfer
- * @write:	whether the access is a write
+ * @gup_flags:	flags modifying lookup behaviour
  *
  * The caller must hold a reference on @mm.
  */
 int access_remote_vm(struct mm_struct *mm, unsigned long addr,
-		void *buf, int len, int write)
+		void *buf, int len, unsigned int gup_flags)
 {
-	return __access_remote_vm(NULL, mm, addr, buf, len,
-			write ? FOLL_WRITE : 0);
+	return __access_remote_vm(NULL, mm, addr, buf, len, gup_flags);
 }
 
 /*
-- 
2.10.0
