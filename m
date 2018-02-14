Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhXjC47DCzF129
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 08:34:07 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1ELX43n095010
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 16:34:05 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g4u47c6t3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 16:34:04 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Wed, 14 Feb 2018 14:34:04 -0700
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH 2/3] rfi-flush: Make it possible to call setup_rfi_flush()
 again
Date: Wed, 14 Feb 2018 19:33:40 -0200
In-Reply-To: <1518644021-17037-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1518644021-17037-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-Id: <1518644021-17037-3-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <mpe@ellerman.id.au>

For PowerVM migration we want to be able to call setup_rfi_flush()
again after we've migrated the partition.

To support that we need to check that we're not trying to allocate the
fallback flush area after memblock has gone away. If so we just fail,
we don't support migrating from a patched to an unpatched machine. Or
we do support it, but there will be no RFI flush enabled on the
destination.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/setup.h |  2 +-
 arch/powerpc/kernel/setup_64.c   | 25 +++++++++++++++++++++----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 469b7fd..bbcdf929 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -49,7 +49,7 @@ enum l1d_flush_type {
 	L1D_FLUSH_MTTRIG	= 0x8,
 };
 
-void __init setup_rfi_flush(enum l1d_flush_type, bool enable);
+void setup_rfi_flush(enum l1d_flush_type, bool enable);
 void do_rfi_flush_fixups(enum l1d_flush_type types);
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 3efc01a..d692f71 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -855,11 +855,22 @@ void rfi_flush_enable(bool enable)
 	rfi_flush = enable;
 }
 
-static void init_fallback_flush(void)
+static bool init_fallback_flush(void)
 {
 	u64 l1d_size, limit;
 	int cpu;
 
+	if (l1d_flush_fallback_area)
+		return true;
+
+	/*
+	 * Once the slab allocator is up it's too late to allocate the fallback
+	 * flush area, so return an error. This could happen if we migrated from
+	 * a patched machine to an unpatched machine.
+	 */
+	if (slab_is_available())
+		return false;
+
 	l1d_size = ppc64_caches.l1d.size;
 	limit = min(ppc64_bolted_size(), ppc64_rma_size);
 
@@ -875,13 +886,19 @@ static void init_fallback_flush(void)
 		paca[cpu].rfi_flush_fallback_area = l1d_flush_fallback_area;
 		paca[cpu].l1d_flush_size = l1d_size;
 	}
+
+	return true;
 }
 
-void __init setup_rfi_flush(enum l1d_flush_type types, bool enable)
+void setup_rfi_flush(enum l1d_flush_type types, bool enable)
 {
 	if (types & L1D_FLUSH_FALLBACK) {
-		pr_info("rfi-flush: Using fallback displacement flush\n");
-		init_fallback_flush();
+		if (init_fallback_flush())
+			pr_info("rfi-flush: Using fallback displacement flush\n");
+		else {
+			pr_warn("rfi-flush: Error unable to use fallback displacement flush!\n");
+			types &= ~L1D_FLUSH_FALLBACK;
+		}
 	}
 
 	if (types & L1D_FLUSH_ORI)
-- 
2.7.4
