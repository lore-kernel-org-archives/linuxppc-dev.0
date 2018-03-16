Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402hdd1fRczDr3n
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 21:33:56 +1100 (AEDT)
Received: by mail-qk0-x244.google.com with SMTP id h14so4968005qkj.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 03:33:56 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au,
	mingo@redhat.com,
	akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com,
 corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com,
 tglx@linutronix.de, Ulrich.Weigand@de.ibm.com, ram.n.pai@gmail.com
Subject: [PATCH v4] mm, pkey: treat pkey-0 special
Date: Fri, 16 Mar 2018 03:33:36 -0700
Message-Id: <1521196416-18157-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Applications need the ability to associate an address-range with some
key and latter revert to its initial default key. Pkey-0 comes close to
providing this function but falls short, because the current
implementation disallows applications to explicitly associate pkey-0 to
the address range.

Clarify the semantics of pkey-0 and provide the corresponding
implementation.

Pkey-0 is special with the following semantics.
(a) it is implicitly allocated and can never be freed. It always exists.
(b) it is the default key assigned to any address-range.
(c) it can be explicitly associated with any address-range.

Tested on powerpc only. Could not test on x86.

cc: Thomas Gleixner <tglx@linutronix.de>
cc: Dave Hansen <dave.hansen@intel.com>
cc: Michael Ellermen <mpe@ellerman.id.au>
cc: Ingo Molnar <mingo@kernel.org>
cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 History:
     v4 : (1) moved the code entirely in arch-independent location.
     	  (2) fixed comments -- suggested by Thomas Gliexner
     v3 : added clarification of the semantics of pkey0.
               -- suggested by Dave Hansen
     v2 : split the patch into two, one for x86 and one for powerpc
               -- suggested by Michael Ellermen

 Documentation/x86/protection-keys.txt |    8 ++++++++
 mm/mprotect.c                         |   25 ++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/x86/protection-keys.txt b/Documentation/x86/protection-keys.txt
index ecb0d2d..92802c4 100644
--- a/Documentation/x86/protection-keys.txt
+++ b/Documentation/x86/protection-keys.txt
@@ -88,3 +88,11 @@ with a read():
 The kernel will send a SIGSEGV in both cases, but si_code will be set
 to SEGV_PKERR when violating protection keys versus SEGV_ACCERR when
 the plain mprotect() permissions are violated.
+
+====================== pkey 0 ==================================
+
+Pkey-0 is special. It is implicitly allocated. Applications cannot allocate or
+free that key. This key is the default key that gets associated with a
+addres-space. It can be explicitly associated with any address-space.
+
+================================================================
diff --git a/mm/mprotect.c b/mm/mprotect.c
index e3309fc..2c779fa 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -430,7 +430,13 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 	 * them use it here.
 	 */
 	error = -EINVAL;
-	if ((pkey != -1) && !mm_pkey_is_allocated(current->mm, pkey))
+
+	/*
+	 * pkey-0 is special. It always exists. No need to check if it is
+	 * allocated. Check allocation status of all other keys. pkey=-1
+	 * is not realy a key, it means; use any available key.
+	 */
+	if (pkey && pkey != -1 && !mm_pkey_is_allocated(current->mm, pkey))
 		goto out;
 
 	vma = find_vma(current->mm, start);
@@ -549,6 +555,12 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 	if (pkey == -1)
 		goto out;
 
+	if (!pkey) {
+		mm_pkey_free(current->mm, pkey);
+		printk("Internal error, cannot explicitly allocate key-0");
+		goto out;
+	}
+
 	ret = arch_set_user_pkey_access(current, pkey, init_val);
 	if (ret) {
 		mm_pkey_free(current->mm, pkey);
@@ -564,13 +576,20 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 {
 	int ret;
 
+	/*
+	 * pkey-0 is special. Userspace can never allocate or free it. It is
+	 * allocated by default. It always exists.
+	 */
+	if (!pkey)
+		return -EINVAL;
+
 	down_write(&current->mm->mmap_sem);
 	ret = mm_pkey_free(current->mm, pkey);
 	up_write(&current->mm->mmap_sem);
 
 	/*
-	 * We could provie warnings or errors if any VMA still
-	 * has the pkey set here.
+	 * We could provide warnings or errors if any VMA still has the pkey
+	 * set here.
 	 */
 	return ret;
 }
-- 
1.7.1
