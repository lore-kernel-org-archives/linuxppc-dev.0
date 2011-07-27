Return-Path: <anton@samba.org>
Date: Wed, 27 Jul 2011 14:15:03 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mikey@neuling.org,
	miltonm@bga.com
Subject: [PATCH] powerpc: pseries: Fix kexec on machines with more than 4TB
	of RAM
Message-ID: <20110727141503.3faa93f5@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On a box with 8TB of RAM the MMU hashtable is 64GB in size. That
means we have 4G PTEs. pSeries_lpar_hptab_clear was using a signed
int to store the index which will overflow at 2G.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: <stable@kernel.org>
---

Index: linux-powerpc/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/platforms/pseries/lpar.c	2011-07-27 13:50:18.408091576 +1000
+++ linux-powerpc/arch/powerpc/platforms/pseries/lpar.c	2011-07-27 13:51:19.359196131 +1000
@@ -203,7 +203,7 @@ static void pSeries_lpar_hptab_clear(voi
 		unsigned long ptel;
 	} ptes[4];
 	long lpar_rc;
-	int i, j;
+	unsigned long i, j;
 
 	/* Read in batches of 4,
 	 * invalidate only valid entries not in the VRMA
