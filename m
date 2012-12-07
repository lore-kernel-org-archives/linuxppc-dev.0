Return-Path: <haren@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 767752C00FB
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2012 18:48:35 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Fri, 7 Dec 2012 02:48:32 -0500
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id CCA696E803A
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2012 02:48:28 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qB77mTF2336386
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2012 02:48:29 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qB77mSwE020631
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2012 05:48:29 -0200
Subject: [PATCH 3/6] powerpc: Increase exceptions arrays in paca struct to
 save PPR
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, anton@au1.ibm.com,
 michael.neuling@au1.ibm.com, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 06 Dec 2012 23:48:26 -0800
Message-ID: <1354866506.1281.15.camel@hbabu-laptop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[PATCH 3/6] powerpc: Increase exceptions arrays in paca struct to save PPR

Using paca to save user defined PPR value in the first level exception vector.

Signed-off-by: Haren Myneni <haren@us.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h |    1 +
 arch/powerpc/include/asm/paca.h          |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 697de09..3b24ca9 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -47,6 +47,7 @@
 #define EX_R3		64
 #define EX_LR		72
 #define EX_CFAR		80
+#define EX_PPR		88	/* SMT thread status register (priority) */
 
 #ifdef CONFIG_RELOCATABLE
 #define EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index e9e7a69..c47d687 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -93,9 +93,9 @@ struct paca_struct {
 	 * Now, starting in cacheline 2, the exception save areas
 	 */
 	/* used for most interrupts/exceptions */
-	u64 exgen[11] __attribute__((aligned(0x80)));
-	u64 exmc[11];		/* used for machine checks */
-	u64 exslb[11];		/* used for SLB/segment table misses
+	u64 exgen[12] __attribute__((aligned(0x80)));
+	u64 exmc[12];		/* used for machine checks */
+	u64 exslb[12];		/* used for SLB/segment table misses
  				 * on the linear mapping */
 	/* SLB related definitions */
 	u16 vmalloc_sllp;
-- 
1.7.1
