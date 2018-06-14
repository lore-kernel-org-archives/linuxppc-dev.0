Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415kyg24X8zF09h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 10:29:31 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id y20-v6so4243269qto.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 17:29:31 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, luto@kernel.org,
 msuchanek@suse.de
Subject: [PATCH v2 6/6] powerpc/pkeys: Deny read/write/execute by default
Date: Wed, 13 Jun 2018 17:29:04 -0700
Message-Id: <1528936144-6696-7-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
References: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
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
 arch/powerpc/mm/pkeys.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 9098605..cec990c 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -128,13 +128,11 @@ int pkey_initialize(void)
 
 	/* register mask is in BE format */
 	pkey_amr_mask = ~0x0ul;
-	pkey_iamr_mask = ~0x0ul;
+	pkey_amr_mask &= ~(0x3ul << pkeyshift(PKEY_0));
 
-	for (i = 0; i < (pkeys_total - os_reserved); i++) {
-		pkey_amr_mask &= ~(0x3ul << pkeyshift(i));
-		pkey_iamr_mask &= ~(0x1ul << pkeyshift(i));
-	}
-	pkey_amr_mask |= (AMR_RD_BIT|AMR_WR_BIT) << pkeyshift(EXECUTE_ONLY_KEY);
+	pkey_iamr_mask = ~0x0ul;
+	pkey_iamr_mask &= ~(0x3ul << pkeyshift(PKEY_0));
+	pkey_iamr_mask &= ~(0x3ul << pkeyshift(EXECUTE_ONLY_KEY));
 
 	pkey_uamor_mask = ~0x0ul;
 	pkey_uamor_mask &= ~(0x3ul << pkeyshift(PKEY_0));
-- 
1.7.1
