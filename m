Return-Path: <shaggy@linux.vnet.ibm.com>
Message-Id: <20080707143011.729373219@linux.vnet.ibm.com>
References: <20080707142850.034542257@linux.vnet.ibm.com>
Date: Mon, 07 Jul 2008 09:28:55 -0500
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: [patch 5/5] powerpc: Dont clear _PAGE_COHERENT when _PAGE_SAO is set
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/platforms/pseries/lpar.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -305,7 +305,8 @@
 	flags = 0;
 
 	/* Make pHyp happy */
-	if (rflags & (_PAGE_GUARDED|_PAGE_NO_CACHE))
+	if ((rflags & _PAGE_GUARDED) ||
+	    ((rflags & _PAGE_NO_CACHE) & !(rflags & _PAGE_WRITETHRU)))
 		hpte_r &= ~_PAGE_COHERENT;
 
 	lpar_rc = plpar_pte_enter(flags, hpte_group, hpte_v, hpte_r, &slot);

-- 
Dave Kleikamp
IBM Linux Technology Center
