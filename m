Return-Path: <benh@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DB90AB7BAD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Nov 2009 10:39:56 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id nA4Nds0n004560
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2009 10:39:54 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA4Narho1687764
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2009 10:36:53 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA4Ndr0S007340
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2009 10:39:53 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	nA4NdrTU007331
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2009 10:39:53 +1100
Received: from [10.61.2.137] (haven.au.ibm.com [9.190.164.82])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.au.ibm.com (Postfix) with ESMTP id 3B3D87371F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Nov 2009 10:39:53 +1100 (EST)
Subject: [PATCH] powerpc/mm: Remove debug context clamping from nohash code
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 Nov 2009 10:39:52 +1100
Message-ID: <1257377992.13611.77.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I inadvertently left that debug code enabled, causing the number of
contexts to be clamped to 31 which is going to slow things down on
4xx and just plain breaks 8xx

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/mmu_context_nohash.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index c2f93dc..be4f34c 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -25,8 +25,8 @@
  *     also clear mm->cpu_vm_mask bits when processes are migrated
  */
 
-#define DEBUG_MAP_CONSISTENCY
-#define DEBUG_CLAMP_LAST_CONTEXT   31
+//#define DEBUG_MAP_CONSISTENCY
+//#define DEBUG_CLAMP_LAST_CONTEXT   31
 //#define DEBUG_HARDER
 
 /* We don't use DEBUG because it tends to be compiled in always nowadays
