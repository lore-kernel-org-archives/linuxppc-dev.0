Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9lgJ1BY5zDqv8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 03:14:19 +1100 (AEDT)
Received: by mail-qt0-x243.google.com with SMTP id p1so6749791qtg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Oct 2017 09:14:19 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: [PATCH] powerpc/memkey: fix compilation error caused by upstream
 changes
Date: Mon,  9 Oct 2017 11:11:46 -0500
Message-Id: <1507565506-17040-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"commit df3735c5 -- x86,mpx: make mpx depend on x86-64 to free up VMA flag"
added the same vm highmem flag we had introduced for PKEY4. That broke
some of the definitions in pkeys.h

This patch fixes the issue.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/pkeys.h |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index baac435..da0d5e6 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -15,9 +15,7 @@
  * we have to carry the hunk below. This is  needed to get
  * pkeys working on power. -- Ram
  */
-#ifndef VM_HIGH_ARCH_BIT_4
-#define VM_HIGH_ARCH_BIT_4	36
-#define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
+#ifndef VM_PKEY_BIT4
 #define VM_PKEY_SHIFT VM_HIGH_ARCH_BIT_0
 #define VM_PKEY_BIT0	VM_HIGH_ARCH_0
 #define VM_PKEY_BIT1	VM_HIGH_ARCH_1
-- 
1.7.1
