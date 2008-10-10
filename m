Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5B8B0DE00A
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 22:56:39 +1100 (EST)
Date: Fri, 10 Oct 2008 06:56:32 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org, Ben Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Message-id: <patch-xics-5@bga.com>
In-Reply-To: <patch-xics-0@bga.com>
Subject: [PATCH 5/16] xics: change arg type to remove casts
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The xirr is 32 bits in hardware, but the hypervisor requries the upper
bits of the register to be clear on the hcall.  By changing the type
from signed to unsigned int we can drop masking it back to 32 bits.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: next.git/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- next.git.orig/arch/powerpc/platforms/pseries/xics.c	2008-10-04 06:07:00.000000000 -0500
+++ next.git/arch/powerpc/platforms/pseries/xics.c	2008-10-04 06:13:40.000000000 -0500
@@ -87,7 +87,7 @@ static inline unsigned int direct_xirr_i
 	return in_be32(&xics_per_cpu[cpu]->xirr.word);
 }
 
-static inline void direct_xirr_info_set(int value)
+static inline void direct_xirr_info_set(unsigned int value)
 {
 	int cpu = smp_processor_id();
 
@@ -120,15 +120,14 @@ static inline unsigned int lpar_xirr_inf
 	return (unsigned int)return_value;
 }
 
-static inline void lpar_xirr_info_set(int value)
+static inline void lpar_xirr_info_set(unsigned int value)
 {
 	unsigned long lpar_rc;
-	unsigned long val64 = value & 0xffffffff;
 
-	lpar_rc = plpar_eoi(val64);
+	lpar_rc = plpar_eoi(value);
 	if (lpar_rc != H_SUCCESS)
-		panic("bad return code EOI - rc = %ld, value=%lx\n", lpar_rc,
-		      val64);
+		panic("bad return code EOI - rc = %ld, value=%x\n", lpar_rc,
+		      value);
 }
 
 static inline void lpar_cppr_info(u8 value)
