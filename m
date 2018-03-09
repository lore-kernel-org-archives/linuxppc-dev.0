Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zyKrK4pwczF1sJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2018 19:13:05 +1100 (AEDT)
Received: by mail-qt0-x242.google.com with SMTP id y6so9830457qtm.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Mar 2018 00:13:05 -0800 (PST)
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
 Ulrich.Weigand@de.ibm.com
Subject: [PATCH] x86, powerpc : pkey-mprotect must allow pkey-0
Date: Fri,  9 Mar 2018 00:12:41 -0800
Message-Id: <1520583161-11741-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once an address range is associated with an allocated pkey, it cannot be
reverted back to key-0. There is no valid reason for the above behavior.  On
the contrary applications need the ability to do so.

The patch relaxes the restriction.

Tested on powerpc and x86_64.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Michael Ellermen <mpe@ellerman.id.au>
cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/pkeys.h | 19 ++++++++++++++-----
 arch/x86/include/asm/pkeys.h     |  5 +++--
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 0409c80..3e8abe4 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -101,10 +101,18 @@ static inline u16 pte_to_pkey_bits(u64 pteflags)
 
 static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
 {
-	/* A reserved key is never considered as 'explicitly allocated' */
-	return ((pkey < arch_max_pkey()) &&
-		!__mm_pkey_is_reserved(pkey) &&
-		__mm_pkey_is_allocated(mm, pkey));
+	/* pkey 0 is allocated by default. */
+	if (!pkey)
+	       return true;
+
+	if (pkey < 0 || pkey >= arch_max_pkey())
+	       return false;
+
+	/* reserved keys are never allocated. */
+	if (__mm_pkey_is_reserved(pkey))
+	       return false;
+
+	return(__mm_pkey_is_allocated(mm, pkey));
 }
 
 extern void __arch_activate_pkey(int pkey);
@@ -150,7 +158,8 @@ static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
 	if (static_branch_likely(&pkey_disabled))
 		return -1;
 
-	if (!mm_pkey_is_allocated(mm, pkey))
+	/* pkey 0 cannot be freed */
+	if (!pkey || !mm_pkey_is_allocated(mm, pkey))
 		return -EINVAL;
 
 	/*
diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index a0ba1ff..6ea7486 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -52,7 +52,7 @@ bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
 	 * from pkey_alloc().  pkey 0 is special, and never
 	 * returned from pkey_alloc().
 	 */
-	if (pkey <= 0)
+	if (pkey < 0)
 		return false;
 	if (pkey >= arch_max_pkey())
 		return false;
@@ -92,7 +92,8 @@ int mm_pkey_alloc(struct mm_struct *mm)
 static inline
 int mm_pkey_free(struct mm_struct *mm, int pkey)
 {
-	if (!mm_pkey_is_allocated(mm, pkey))
+	/* pkey 0 is special and can never be freed */
+	if (!pkey || !mm_pkey_is_allocated(mm, pkey))
 		return -EINVAL;
 
 	mm_set_pkey_free(mm, pkey);
-- 
1.8.3.1
