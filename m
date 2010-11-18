Return-Path: <mikey@neuling.org>
Message-Id: <20101118045248.086797756@neuling.org>
Date: Thu, 18 Nov 2010 15:52:45 +1100
From: mikey@neuling.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/4] powerpc: hash_preload: avoid avoidable void
References: <20101118045241.071482503@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change pgdir from a void to real type.  Having this as a void is
stupid and has already caused 1 bug.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/mm/hash_utils_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-ozlabs/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/mm/hash_utils_64.c
+++ linux-2.6-ozlabs/arch/powerpc/mm/hash_utils_64.c
@@ -1070,7 +1070,7 @@
 		  unsigned long access, unsigned long trap)
 {
 	unsigned long vsid;
-	void *pgdir;
+	pgd_t *pgdir;
 	pte_t *ptep;
 	unsigned long flags;
 	int rc, ssize, local = 0;
