Return-Path: <haren@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 667E02C0040
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Sep 2012 21:41:52 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Sun, 9 Sep 2012 07:41:49 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 8DF8138C803D
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Sep 2012 07:41:46 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q89BfkdQ32899130
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Sep 2012 07:41:46 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q89BfjIT012684
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Sep 2012 07:41:46 -0400
Subject: [PATCH 4/6] powerpc: Increase exceptions arrays in paca struct to
 save PPR
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 mikey@neuling.org
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 09 Sep 2012 04:41:44 -0700
Message-ID: <1347190904.3418.17.camel@hbabu-laptop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Using paca to save user defined PPR value in the first level exception vector.

Signed-off-by: Haren Myneni <haren@us.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h |    1 +
 arch/powerpc/include/asm/paca.h          |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 45702e0..bfd3f1f 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -47,6 +47,7 @@
 #define EX_R3		64
 #define EX_LR		72
 #define EX_CFAR		80
+#define EX_PPR		88	/* SMT thread status register (priority) */
 
 /*
  * We're short on space and time in the exception prolog, so we can't
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index daf813f..d32b1e5 100644
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
1.7.10.4
