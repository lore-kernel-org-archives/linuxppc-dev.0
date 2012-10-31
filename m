Return-Path: <haren@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e6.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3A2662C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 17:54:51 +1100 (EST)
Received: from /spool/local
 by e6.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Wed, 31 Oct 2012 02:54:48 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id A427FC90041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 02:54:25 -0400 (EDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9V6sOUm291738
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 02:54:25 -0400
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9V6u8IL016088
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 00:56:08 -0600
Subject: [PATCH 3/6] powerpc: Increase exceptions arrays in paca struct to
 save PPR
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, anton@au1.ibm.com,
 mikey@neuling.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 30 Oct 2012 23:54:22 -0700
Message-ID: <1351666462.32304.16.camel@hbabu-laptop>
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

[PATCH 3/6] powerpc: Increase exceptions arrays in paca struct to save PPR

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
