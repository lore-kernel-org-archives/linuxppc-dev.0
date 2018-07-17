Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VMBr3LFPzF3Hr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 23:51:32 +1000 (AEST)
Received: by mail-qt0-x243.google.com with SMTP id q12-v6so887806qtp.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 06:51:32 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, msuchanek@suse.de
Subject: [PATCH v3 2/9] powerpc/pkeys: Deny read/write/execute by default
Date: Tue, 17 Jul 2018 06:51:03 -0700
Message-Id: <1531835470-32691-3-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1531835470-32691-1-git-send-email-linuxram@us.ibm.com>
References: <1531835470-32691-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Deny all permissions on all keys, with some exceptions.  pkey-0 must
allow all permissions, or else everything comes to a screaching halt.
Execute-only key must allow execute permission.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/mm/pkeys.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 0facc0d..7dc0024 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -124,12 +124,10 @@ int pkey_initialize(void)
 
 	/* register mask is in BE format */
 	pkey_amr_mask = ~0x0ul;
-	pkey_iamr_mask = ~0x0ul;
+	pkey_amr_mask &= ~(0x3ul << pkeyshift(0));
 
-	for (i = 0; i < (pkeys_total - os_reserved); i++) {
-		pkey_amr_mask &= ~(0x3ul << pkeyshift(i));
-		pkey_iamr_mask &= ~(0x1ul << pkeyshift(i));
-	}
+	pkey_iamr_mask = ~0x0ul;
+	pkey_iamr_mask &= ~(0x3ul << pkeyshift(0));
 
 	pkey_uamor_mask = ~0x0ul;
 	pkey_uamor_mask &= ~(0x3ul << pkeyshift(0));
-- 
1.7.1
