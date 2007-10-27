Return-Path: <mh@omnisys.se>
Subject: [PATCH] ppc4xx: mmu_mapin_ram bugfix for booting with mem<16 MB
From: Magnus Hjorth <mh@omnisys.se>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40710261254r105530d4u2e95d96948030ed7@mail.gmail.com>
References: <471FA48B.2020809@free.fr> <47203EF9.1070906@omnisys.se>
	<fa686aa40710261254r105530d4u2e95d96948030ed7@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 27 Oct 2007 10:35:16 +0200
Message-Id: <1193474116.5412.14.camel@magnus-desktop>
Mime-Version: 1.0
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: Magnus Hjorth <mh@omnisys.se>

This patch (for 2.6.23.1) fixes an unsigned arithmetic bug causing the
kernel to hang when booting with less than 16 MB of memory on ppc4xx.

Signed-off-by: Magnus Hjorth <mh@omnisys.se>

---

OK, trying to do this by the book now...

--- linux-2.6.23.1/arch/ppc/mm/4xx_mmu.c.orig	2007-10-27 10:14:42.000000000 +0200
+++ linux-2.6.23.1/arch/ppc/mm/4xx_mmu.c	2007-10-27 10:15:34.000000000 +0200
@@ -105,7 +105,7 @@ unsigned long __init mmu_mapin_ram(void)
 		return s;
 	}
 
-	while (s <= (total_lowmem - LARGE_PAGE_SIZE_16M)) {
+	while (s + LARGE_PAGE_SIZE_16M <= total_lowmem) {
 		pmd_t *pmdp;
 		unsigned long val = p | _PMD_SIZE_16M | _PAGE_HWEXEC | _PAGE_HWWRITE;
 
@@ -120,7 +120,7 @@ unsigned long __init mmu_mapin_ram(void)
 		s += LARGE_PAGE_SIZE_16M;
 	}
 
-	while (s <= (total_lowmem - LARGE_PAGE_SIZE_4M)) {
+	while (s + LARGE_PAGE_SIZE_4M <= total_lowmem) {
 		pmd_t *pmdp;
 		unsigned long val = p | _PMD_SIZE_4M | _PAGE_HWEXEC | _PAGE_HWWRITE;
 
