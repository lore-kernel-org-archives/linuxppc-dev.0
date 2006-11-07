Return-Path: <judith@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4652F67D1F
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 05:10:03 +1100 (EST)
Date: Tue, 7 Nov 2006 10:09:37 -0800
From: Judith Lebzelter <judith@osdl.org>
To: sfr@canb.auug.org.au
Subject: Re: build problems with powerpc allmodconfig
Message-ID: <20061107180937.GB1339@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>  - vioscsi linkage fails because iseries_vscsi.c and rpa_vscsi.c.
>>    This needs some trivial indirection via function vectors, but
>>    how can we find out which one to use from the driver?  Both
>>    seem to look the same in the device tree
>
> The maintainer suggested that we just don't build vioscsi for iseries
> if we are building the rpa version as it is not often used (in particular,
> it is not used for installations).  We could, however distinguish them
> by changing the "compat" field in the iSeries device tree if we wished.
>

How about just adding an 'ifndef' in the Makefile, as in the patch below?
This compiles ibmvscsic.o fine.

Judith Lebzelter

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
