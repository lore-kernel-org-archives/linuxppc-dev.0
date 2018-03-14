Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401msR241vzDrKN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 09:40:59 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2EMevx1016188
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 18:40:57 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gq8w6gdrj-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 18:40:57 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Wed, 14 Mar 2018 18:40:56 -0400
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, msuchanek@suse.de
Subject: [PATCH v3 2/5] rfi-flush: Make it possible to call setup_rfi_flush()
 again
Date: Wed, 14 Mar 2018 19:40:39 -0300
In-Reply-To: <1521067243-19520-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1521067243-19520-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-Id: <1521067243-19520-3-git-send-email-mauricfo@linux.vnet.ibm.com>
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
fallback flush area after memblock has gone away (i.e., boot-time only).

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/setup.h | 2 +-
 arch/powerpc/kernel/setup_64.c   | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 469b7fd..bbcdf92 100644
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
index 3efc01a..d60e2f7 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -860,6 +860,10 @@ static void init_fallback_flush(void)
 	u64 l1d_size, limit;
 	int cpu;
 
+	/* Only allocate the fallback flush area once (at boot time). */
+	if (l1d_flush_fallback_area)
+		return;
+
 	l1d_size = ppc64_caches.l1d.size;
 	limit = min(ppc64_bolted_size(), ppc64_rma_size);
 
@@ -877,7 +881,7 @@ static void init_fallback_flush(void)
 	}
 }
 
-void __init setup_rfi_flush(enum l1d_flush_type types, bool enable)
+void setup_rfi_flush(enum l1d_flush_type types, bool enable)
 {
 	if (types & L1D_FLUSH_FALLBACK) {
 		pr_info("rfi-flush: Using fallback displacement flush\n");
-- 
2.7.4
