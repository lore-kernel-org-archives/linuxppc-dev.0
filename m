Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40d2x206PQzDr4K
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 06:02:29 +1000 (AEST)
Received: by mail-qk0-x243.google.com with SMTP id s70so17569739qks.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2018 13:02:29 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 msuchanek@suse.com, Ulrich.Weigand@de.ibm.com, dave.hansen@intel.com,
 Shakeel Butt <shakeelb@google.com>
Subject: [PATCH ] powerpc/pkeys: Detach execute_only key on !PROT_EXEC
Date: Fri,  4 May 2018 13:01:51 -0700
Message-Id: <1525464111-1096-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Disassociate the exec_key from a VMA if the VMA permission is not
PROT_EXEC anymore.  Otherwise the exec_only key continues to be
associated with the vma, causing unexpected behavior.

The problem was reported on x86 by Shakeel Butt,
which is also applicable on powerpc.

cc: Shakeel Butt <shakeelb@google.com>
Reported-by: Shakeel Butt <shakeelb@google.com>
Fixes 5586cf6 ("powerpc: introduce execute-only pkey")
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/mm/pkeys.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index e81d59e..fdeb9f5 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -425,9 +425,9 @@ int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot,
 {
 	/*
 	 * If the currently associated pkey is execute-only, but the requested
-	 * protection requires read or write, move it back to the default pkey.
+	 * protection is not execute-only, move it back to the default pkey.
 	 */
-	if (vma_is_pkey_exec_only(vma) && (prot & (PROT_READ | PROT_WRITE)))
+	if (vma_is_pkey_exec_only(vma) && (prot != PROT_EXEC))
 		return 0;
 
 	/*
-- 
1.7.1
