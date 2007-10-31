Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 53B5CDDE3E
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 17:42:55 +1100 (EST)
Received: from pd3mr4so.prod.shaw.ca
	(pd3mr4so-qfe3.prod.shaw.ca [10.0.141.180]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JQR0092TJWWRDD0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 31 Oct 2007 00:41:20 -0600 (MDT)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
	by pd3mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JQR00G3UJWWAU00@pd3mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 31 Oct 2007 00:41:20 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JQR00EVRJWVUX30@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 31 Oct 2007 00:41:19 -0600 (MDT)
Date: Wed, 31 Oct 2007 00:41:20 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] [POWERPC] ppc405 Fix arithmatic rollover bug when memory size
	under 16M
To: mh@omnisys.se, jwboyer@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org
Message-id: <20071031063722.8135.97052.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

mmu_mapin_ram() loops over total_lowmem to setup page tables.  However, if
total_lowmem is less that 16M, the subtraction rolls over and results in
a number just under 4G (because total_lowmem is an unsigned value).

This patch rejigs the loop from countup to countdown to eliminate the
bug.

Special thanks to Magnus Hjorth who wrote the original patch to fix this
bug.  This patch improves on his by making the loop code simpler (which
also eliminates the possibility of another rollover at the high end)
and also applies the change to arch/powerpc.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Josh, I've tested this change on arch/ppc, but not arch/powerpc.  The
ppc and powerpc code are darn near identical so it should be correct,
but you might want to boot a kernel before you push it to Paulus
anyway.

Cheers,
g.

 arch/powerpc/mm/40x_mmu.c |   17 ++++++++---------
 arch/ppc/mm/4xx_mmu.c     |   17 ++++++++---------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/mm/40x_mmu.c b/arch/powerpc/mm/40x_mmu.c
index e067df8..3899ea9 100644
--- a/arch/powerpc/mm/40x_mmu.c
+++ b/arch/powerpc/mm/40x_mmu.c
@@ -98,13 +98,12 @@ unsigned long __init mmu_mapin_ram(void)
 
 	v = KERNELBASE;
 	p = PPC_MEMSTART;
-	s = 0;
+	s = total_lowmem;
 
-	if (__map_without_ltlbs) {
-		return s;
-	}
+	if (__map_without_ltlbs)
+		return 0;
 
-	while (s <= (total_lowmem - LARGE_PAGE_SIZE_16M)) {
+	while (s >= LARGE_PAGE_SIZE_16M) {
 		pmd_t *pmdp;
 		unsigned long val = p | _PMD_SIZE_16M | _PAGE_HWEXEC | _PAGE_HWWRITE;
 
@@ -116,10 +115,10 @@ unsigned long __init mmu_mapin_ram(void)
 
 		v += LARGE_PAGE_SIZE_16M;
 		p += LARGE_PAGE_SIZE_16M;
-		s += LARGE_PAGE_SIZE_16M;
+		s -= LARGE_PAGE_SIZE_16M;
 	}
 
-	while (s <= (total_lowmem - LARGE_PAGE_SIZE_4M)) {
+	while (s >= LARGE_PAGE_SIZE_4M) {
 		pmd_t *pmdp;
 		unsigned long val = p | _PMD_SIZE_4M | _PAGE_HWEXEC | _PAGE_HWWRITE;
 
@@ -128,8 +127,8 @@ unsigned long __init mmu_mapin_ram(void)
 
 		v += LARGE_PAGE_SIZE_4M;
 		p += LARGE_PAGE_SIZE_4M;
-		s += LARGE_PAGE_SIZE_4M;
+		s -= LARGE_PAGE_SIZE_4M;
 	}
 
-	return s;
+	return total_lowmem - s;
 }
diff --git a/arch/ppc/mm/4xx_mmu.c b/arch/ppc/mm/4xx_mmu.c
index 838e09d..ea785db 100644
--- a/arch/ppc/mm/4xx_mmu.c
+++ b/arch/ppc/mm/4xx_mmu.c
@@ -99,13 +99,12 @@ unsigned long __init mmu_mapin_ram(void)
 
 	v = KERNELBASE;
 	p = PPC_MEMSTART;
-	s = 0;
+	s = total_lowmem;
 
-	if (__map_without_ltlbs) {
-		return s;
-	}
+	if (__map_without_ltlbs)
+		return 0;
 
-	while (s <= (total_lowmem - LARGE_PAGE_SIZE_16M)) {
+	while (s >= LARGE_PAGE_SIZE_16M) {
 		pmd_t *pmdp;
 		unsigned long val = p | _PMD_SIZE_16M | _PAGE_HWEXEC | _PAGE_HWWRITE;
 
@@ -117,10 +116,10 @@ unsigned long __init mmu_mapin_ram(void)
 
 		v += LARGE_PAGE_SIZE_16M;
 		p += LARGE_PAGE_SIZE_16M;
-		s += LARGE_PAGE_SIZE_16M;
+		s -= LARGE_PAGE_SIZE_16M;
 	}
 
-	while (s <= (total_lowmem - LARGE_PAGE_SIZE_4M)) {
+	while (s >= LARGE_PAGE_SIZE_4M) {
 		pmd_t *pmdp;
 		unsigned long val = p | _PMD_SIZE_4M | _PAGE_HWEXEC | _PAGE_HWWRITE;
 
@@ -129,8 +128,8 @@ unsigned long __init mmu_mapin_ram(void)
 
 		v += LARGE_PAGE_SIZE_4M;
 		p += LARGE_PAGE_SIZE_4M;
-		s += LARGE_PAGE_SIZE_4M;
+		s -= LARGE_PAGE_SIZE_4M;
 	}
 
-	return s;
+	return total_lowmem - s;
 }
