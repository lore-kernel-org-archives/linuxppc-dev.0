Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMGhl64tYzF0YQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 06:03:51 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0HIxtXe108108
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 14:03:49 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fj9mtyy2h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 14:03:48 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 17 Jan 2018 19:03:47 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/kernel: Fix L1D_SIZE to a non-zero value on missing
 cache nodes
Date: Thu, 18 Jan 2018 00:33:36 +0530
Message-Id: <1516215816-14710-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

parse_cache_info() parse device tree to detect various [i/d] cache properties.
But if no cache nodes found in device tree, these properties are set to zero
as default in init_cache_info().

Having a zero value could cause a infinite loop in rfi_flush_callback() since
l1d_size is used to determine the lid_flush_set parameter which is used as
the upper bounce in L1D cache flush loop. So default the l1d_size to 64K if
it is zero.

Fixes: aa8a5e0062ac9 ('powerpc/64s: Add support for RFI flush of L1-D cache')
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/setup.h |  2 ++
 arch/powerpc/kernel/setup_64.c   | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 469b7fdc9be4..12954bf2d3fe 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -41,6 +41,8 @@ static inline void pseries_little_endian_exceptions(void) {}
 
 void rfi_flush_enable(bool enable);
 
+#define DEFAULT_L1D_SIZE	(1024 * 64)
+
 /* These are bit flags */
 enum l1d_flush_type {
 	L1D_FLUSH_NONE		= 0x1,
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 491be4179ddd..7a3077a2cd5c 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -856,6 +856,22 @@ static void init_fallback_flush(void)
 	int cpu;
 
 	l1d_size = ppc64_caches.l1d.size;
+
+	/*
+	 * If there is no cache node in cpus/ device tree,
+	 * l1d_size could be zero. This in turn make l1d_flush_sets as
+	 * zero, which will be an issue in RFI_FLUSH_CALLBACK.
+	 *
+	 * RFI_FLUSH_CALLBACK use the l1d_flush_sets value as upper bounce
+	 * (loaded in CTR) and loop with a `bdnz` instruction. If the CTR
+	 * happen to zero, instruction (as per definition) will decrement
+	 * CTR first and then compare. So we end up in a really big
+	 * loop (becos of negative value in CTR). Avoid this by defaulting
+	 * to a sane value (64kb).
+	 */
+	if (!l1d_size)
+		l1d_size = DEFAULT_L1D_SIZE;
+
 	limit = min(safe_stack_limit(), ppc64_rma_size);
 
 	/*
-- 
2.7.4
