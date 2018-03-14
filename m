Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401kjS2XbMzF09c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 08:03:56 +1100 (AEDT)
Received: by mail-qt0-x244.google.com with SMTP id v90so4998989qte.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 14:03:56 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 akpm@linux-foundation.org, dave.hansen@intel.com, benh@kernel.crashing.org,
 paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com, corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com,
 msuchanek@suse.com, Ulrich.Weigand@de.ibm.com
Subject: [PATCH v3] powerpc: treat pkey-0 special
Date: Wed, 14 Mar 2018 14:01:35 -0700
Message-Id: <1521061295-22605-1-git-send-email-linuxram@us.ibm.com>
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

This patch clarifies the semantics of pkey-0 and provides the
corresponding implementation on powerpc.

Pkey-0 is special with the following semantics.
(a) it is implicitly allocated and can never be freed. It always exists.
(b) it is the default key assigned to any address-range.
(c) it can be explicitly associated with any address-range.

Tested on powerpc.

History:
    v3 : added clarification of the semantics of pkey0.
    		-- suggested by Dave Hansen
    v2 : split the patch into two, one for x86 and one for powerpc
    		-- suggested by Michael Ellermen

cc: Dave Hansen <dave.hansen@intel.com>
cc: Michael Ellermen <mpe@ellerman.id.au>
cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/pkeys.h | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 0409c80..3c1deec 100644
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
+	/* Reserved keys are never allocated. */
+	if (__mm_pkey_is_reserved(pkey))
+	       return false;
+
+	return __mm_pkey_is_allocated(mm, pkey);
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
-- 
1.8.3.1
