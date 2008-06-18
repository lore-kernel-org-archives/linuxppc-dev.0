Return-Path: <shaggy@linux.vnet.ibm.com>
Message-Id: <20080618223329.644300254@linux.vnet.ibm.com>
References: <20080618223254.966080905@linux.vnet.ibm.com>
Date: Wed, 18 Jun 2008 17:33:00 -0500
From: shaggy@linux.vnet.ibm.com
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 6/6] powerpc: Dont clear _PAGE_COHERENT when _PAGE_SAO is set
Cc: linux-mm@kvack.org, Paul Mackerras <paulus@au1.ibm.com>,
	Linuxppc-dev@ozlabs.org
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

Index: linux-2.6.26-rc5/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- linux-2.6.26-rc5.orig/arch/powerpc/platforms/pseries/lpar.c
+++ linux-2.6.26-rc5/arch/powerpc/platforms/pseries/lpar.c
@@ -305,7 +305,8 @@ static long pSeries_lpar_hpte_insert(uns
 	flags = 0;
 
 	/* Make pHyp happy */
-	if (rflags & (_PAGE_GUARDED|_PAGE_NO_CACHE))
+	if ((rflags & _PAGE_GUARDED) ||
+	    ((rflags & _PAGE_NO_CACHE) & !(rflags & _PAGE_WRITETHRU)))
 		hpte_r &= ~_PAGE_COHERENT;
 
 	lpar_rc = plpar_pte_enter(flags, hpte_group, hpte_v, hpte_r, &slot);

-- 
