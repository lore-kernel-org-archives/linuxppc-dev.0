Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpsrK3cdgzDrcn
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Sep 2017 08:46:41 +1000 (AEST)
Received: by mail-qk0-x242.google.com with SMTP id c69so2308999qke.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 15:46:41 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: [PATCH 7/7] powerpc: capture the PTE format changes in the dump pte
 report
Date: Fri,  8 Sep 2017 15:44:47 -0700
Message-Id: <1504910713-7094-8-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The H_PAGE_F_SECOND,H_PAGE_F_GIX are not in the 64K main-PTE.
capture these changes in the dump pte report.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/mm/dump_linuxpagetables.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index c9282d2..0323dc4 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -213,7 +213,7 @@ struct flag_info {
 		.val	= H_PAGE_4K_PFN,
 		.set	= "4K_pfn",
 	}, {
-#endif
+#else /* CONFIG_PPC_64K_PAGES */
 		.mask	= H_PAGE_F_GIX,
 		.val	= H_PAGE_F_GIX,
 		.set	= "f_gix",
@@ -224,6 +224,7 @@ struct flag_info {
 		.val	= H_PAGE_F_SECOND,
 		.set	= "f_second",
 	}, {
+#endif /* CONFIG_PPC_64K_PAGES */
 #endif
 		.mask	= _PAGE_SPECIAL,
 		.val	= _PAGE_SPECIAL,
-- 
1.7.1
