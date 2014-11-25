Return-Path: <dahi@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E5BEB1A0297
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 22:43:46 +1100 (AEDT)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dahi@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 11:43:43 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id E244617D8043
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 11:43:51 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAPBhaD85570846
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 11:43:36 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAPBhZCu005736
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 04:43:36 -0700
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [RFC 2/2] mm,
 sched: trigger might_sleep() in might_fault() when atomic
Date: Tue, 25 Nov 2014 12:43:26 +0100
Message-Id: <1416915806-24757-3-git-send-email-dahi@linux.vnet.ibm.com>
In-Reply-To: <1416915806-24757-1-git-send-email-dahi@linux.vnet.ibm.com>
References: <1416915806-24757-1-git-send-email-dahi@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, heiko.carstens@de.ibm.com, dahi@linux.vnet.ibm.com,
 paulus@samba.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 662bbcb2747c2422cf98d3d97619509379eee466 disabled in atomic checks
for all user access code (that uses might_fault()).

That change basically disabled CONFIG_DEBUG_ATOMIC_SLEEP for all user access
functions. However, this is a mighty debugging aid that we want.

If user memory is to be accessed while pagefault_disabled() is set, the atomic
variants of copy_(to|from)_user can be used.

This patch reverts commit 662bbcb2747c2422cf98d3d97619509379eee466 taking care
of the !MMU optimization.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
---
 include/linux/kernel.h |  8 ++++++--
 mm/memory.c            | 11 ++++-------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 3d770f55..1d3397c 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -225,9 +225,13 @@ static inline u32 reciprocal_scale(u32 val, u32 ep_ro)
 	return (u32)(((u64) val * ep_ro) >> 32);
 }
 
-#if defined(CONFIG_MMU) && \
-	(defined(CONFIG_PROVE_LOCKING) || defined(CONFIG_DEBUG_ATOMIC_SLEEP))
+#if defined(CONFIG_MMU) && defined(CONFIG_PROVE_LOCKING)
 void might_fault(void);
+#elif defined(CONFIG_MMU) && defined(CONFIG_DEBUG_ATOMIC_SLEEP)
+static inline void might_fault(void)
+{
+	__might_sleep(__FILE__, __LINE__, 0);
+}
 #else
 static inline void might_fault(void) { }
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index 3e50383..fe0c815 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3699,7 +3699,7 @@ void print_vma_addr(char *prefix, unsigned long ip)
 	up_read(&mm->mmap_sem);
 }
 
-#if defined(CONFIG_PROVE_LOCKING) || defined(CONFIG_DEBUG_ATOMIC_SLEEP)
+#ifdef CONFIG_PROVE_LOCKING
 void might_fault(void)
 {
 	/*
@@ -3711,17 +3711,14 @@ void might_fault(void)
 	if (segment_eq(get_fs(), KERNEL_DS))
 		return;
 
+	__might_sleep(__FILE__, __LINE__, 0);
+
 	/*
 	 * it would be nicer only to annotate paths which are not under
 	 * pagefault_disable, however that requires a larger audit and
 	 * providing helpers like get_user_atomic.
 	 */
-	if (in_atomic())
-		return;
-
-	__might_sleep(__FILE__, __LINE__, 0);
-
-	if (current->mm)
+	if (!in_atomic() && current->mm)
 		might_lock_read(&current->mm->mmap_sem);
 }
 EXPORT_SYMBOL(might_fault);
-- 
1.8.5.5
