Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A8A602C008D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 15:50:06 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 15 Nov 2012 14:47:53 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAF4o0Y255509172
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 15:50:00 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAF4nxXn009817
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 15:49:59 +1100
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/7] powerpc: Select either privileged or hypervisor doorbell
 when sending
Date: Thu, 15 Nov 2012 15:49:47 +1100
Message-Id: <1352954990-2858-5-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1352954990-2858-1-git-send-email-imunsie@au1.ibm.com>
References: <1352954990-2858-1-git-send-email-imunsie@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

On book3s we have two msgsnd instructions with differing privilege
levels. This patch selects the appropriate instruction to use whenever
we send a doorbell interrupt.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Tested-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/dbell.h |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
index 3b33856..5fa6b20 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -37,12 +37,25 @@ enum ppc_dbell {
 #define SPRN_DOORBELL_CPUTAG		SPRN_TIR
 #define PPC_DBELL_TAG_MASK		0x7f
 
+static inline void _ppc_msgsnd(u32 msg)
+{
+	if (cpu_has_feature(CPU_FTR_HVMODE))
+		__asm__ __volatile__ (PPC_MSGSND(%0) : : "r" (msg));
+	else
+		__asm__ __volatile__ (PPC_MSGSNDP(%0) : : "r" (msg));
+}
+
 #else /* CONFIG_PPC_BOOK3S */
 
 #define PPC_DBELL_MSGTYPE		PPC_DBELL
 #define SPRN_DOORBELL_CPUTAG		SPRN_PIR
 #define PPC_DBELL_TAG_MASK		0x3fff
 
+static inline void _ppc_msgsnd(u32 msg)
+{
+	__asm__ __volatile__ (PPC_MSGSND(%0) : : "r" (msg));
+}
+
 #endif /* CONFIG_PPC_BOOK3S */
 
 extern void doorbell_cause_ipi(int cpu, unsigned long data);
@@ -54,7 +67,7 @@ static inline void ppc_msgsnd(enum ppc_dbell type, u32 flags, u32 tag)
 	u32 msg = PPC_DBELL_TYPE(type) | (flags & PPC_DBELL_MSG_BRDCAST) |
 			(tag & 0x07ffffff);
 
-	__asm__ __volatile__ (PPC_MSGSND(%0) : : "r" (msg));
+	_ppc_msgsnd(msg);
 }
 
 #endif /* _ASM_POWERPC_DBELL_H */
-- 
1.7.10.4
