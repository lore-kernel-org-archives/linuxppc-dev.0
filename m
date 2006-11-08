Return-Path: <judith@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BBAE367C4F
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Nov 2006 04:34:47 +1100 (EST)
Date: Wed, 8 Nov 2006 09:34:29 -0800
From: Judith Lebzelter <judith@osdl.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH]  powerpc iseries link error in allmodconfig
Message-ID: <20061108173429.GB14991@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Choose rpa_vscsi.c over iseries_vscsi.c when building both
pseries and iseries.  This fixes a link error. 

Signed-off-by:  Judith Lebzelter <judith@osdl.org>
---

Index: linux/drivers/scsi/ibmvscsi/Makefile
===================================================================
--- linux.orig/drivers/scsi/ibmvscsi/Makefile	2006-11-06 16:52:09.000000000 -0800
+++ linux/drivers/scsi/ibmvscsi/Makefile	2006-11-07 09:35:34.019969437 -0800
@@ -1,7 +1,9 @@
 obj-$(CONFIG_SCSI_IBMVSCSI)	+= ibmvscsic.o
 
 ibmvscsic-y			+= ibmvscsi.o
+ifndef CONFIG_PPC_PSERIES
 ibmvscsic-$(CONFIG_PPC_ISERIES)	+= iseries_vscsi.o 
+endif
 ibmvscsic-$(CONFIG_PPC_PSERIES)	+= rpa_vscsi.o 
 
 obj-$(CONFIG_SCSI_IBMVSCSIS)	+= ibmvstgt.o
