Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2B27DB6F01
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 16:17:00 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp03.au.ibm.com (8.14.4/8.13.1) with ESMTP id o696DOJg011993
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:13:24 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o696GxOV1126606
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:16:59 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o696GwMV003348
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:16:58 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/13] powerpc/book3e: mtmsr should not be mtmsrd on book3e
	64-bit
Date: Fri,  9 Jul 2010 16:16:43 +1000
Message-Id: <1278656215-24705-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/reg.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index d62fdf4..d8be016 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -890,7 +890,7 @@
 #ifndef __ASSEMBLY__
 #define mfmsr()		({unsigned long rval; \
 			asm volatile("mfmsr %0" : "=r" (rval)); rval;})
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC_BOOK3S_64
 #define __mtmsrd(v, l)	asm volatile("mtmsrd %0," __stringify(l) \
 				     : : "r" (v) : "memory")
 #define mtmsrd(v)	__mtmsrd((v), 0)
-- 
1.6.3.3
