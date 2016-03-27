Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqqw5BPQzDqGy
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:26:04 +1100 (AEDT)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 02:26:02 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 6703D19D803E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:13:53 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8PxxI43581682
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 01:25:59 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8Px5S027715
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:25:59 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 42/65] powerpc/mm/radix: Limit paca allocation in radix
Date: Sun, 27 Mar 2016 13:53:50 +0530
Message-Id: <1459067053-10835-42-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On return from rtas we access the paca variables and we have 64 bit
disabled. This requires us to limit paca in 32 bit range.

Note: we don't set ppc64_rma_size for radix and because of that we endup
with a limit value of 0.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/paca.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 01ea0edf0579..9c6e0d1eb61b 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -216,6 +216,11 @@ void __init allocate_pacas(void)
 	 * the first segment.
 	 */
 	limit = min(0x10000000ULL, limit);
+	/*
+	 * Fix it properly. Radix hack
+	 */
+	if (limit == 0)
+		limit = 0x10000000ULL;
 #endif
 
 	paca_size = PAGE_ALIGN(sizeof(struct paca_struct) * nr_cpu_ids);
-- 
2.5.0
