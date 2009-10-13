Return-Path: <michael@ellerman.id.au>
Subject: [Patch] powerpc: Fix memory leak in axon_msi.c
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 13 Oct 2009 11:29:40 +1100
Message-Id: <1255393780.9570.3.camel@concordia>
Mime-Version: 1.0
Cc: eric.sesterhenn@lsexperts.de
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cppcheck found a memory leak in axon_msi, if dcr_base or dcr_len are zero,
we have already allocated msic, so we should free it in the error path.

Signed-off-by: Eric Sesterhenn <eric.sesterhenn@lsexperts.de>
Acked-by: Michael Ellerman <michael@ellerman.id.au>

--- linux/arch/powerpc/platforms/cell/axon_msi.c.orig	2009-10-12 14:48:26.000000000 +0200
+++ linux/arch/powerpc/platforms/cell/axon_msi.c	2009-10-12 14:48:52.000000000 +0200
@@ -365,7 +365,7 @@ static int axon_msi_probe(struct of_devi
 		printk(KERN_ERR
 		       "axon_msi: couldn't parse dcr properties on %s\n",
 			dn->full_name);
-		goto out;
+		goto out_free_msic;
 	}

 	msic->dcr_host = dcr_map(dn, dcr_base, dcr_len);
	
