Return-Path: <anton@ozlabs.org>
Date: Fri, 8 Dec 2006 18:22:09 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] dont allow pSeries_probe to succeed without initialising MMU
Message-ID: <20061208072208.GD29167@krispykreme>
References: <20061208070837.GC29167@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061208070837.GC29167@krispykreme>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


pSeries_probe can decide that we are a pseries but then fail to
initialise the MMU. If an rtas node doesnt exist, we continually fall
out of pSeries_probe_hypertas early and never get to the MMU init code.

While pseries without RTAS is an illegal combination, the way we
currently fail is a pain to track down, and can happen if your flattened
device tree code has issues (like mine did :).

With the following patch we init the MMU, come up and print some
warnings about RTAS not existing, instead of looping on 0x400 exceptions.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: kernel/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- kernel.orig/arch/powerpc/platforms/pseries/setup.c	2006-10-24 10:26:59.494464648 -0500
+++ kernel/arch/powerpc/platforms/pseries/setup.c	2006-10-24 10:27:39.714227044 -0500
@@ -492,11 +492,6 @@ static int __init pSeries_probe_hypertas
 	if (of_get_flat_dt_prop(node, "ibm,hypertas-functions", NULL) != NULL)
  		powerpc_firmware_features |= FW_FEATURE_LPAR;
 
-	if (firmware_has_feature(FW_FEATURE_LPAR))
-		hpte_init_lpar();
-	else
-		hpte_init_native();
-
  	return 1;
 }
 
@@ -522,6 +517,11 @@ static int __init pSeries_probe(void)
 	/* Now try to figure out if we are running on LPAR */
 	of_scan_flat_dt(pSeries_probe_hypertas, NULL);
 
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		hpte_init_lpar();
+	else
+		hpte_init_native();
+
 	DBG("Machine is%s LPAR !\n",
 	    (powerpc_firmware_features & FW_FEATURE_LPAR) ? "" : " not");
 
