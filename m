Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F10F8DE8D0
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 04:36:58 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6NIanl4025712
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 14:36:49 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6NIanqI174320
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 12:36:49 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6NIah3C006242
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 12:36:49 -0600
Date: Wed, 23 Jul 2008 13:36:38 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH 16/16 v4] powerpc: Update arch vector to indicate support
	for CMO
Message-ID: <20080723183638.GS12905@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080723181932.GC12905@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=46rom: Nathan Fontenot <nfont@austin.ibm.com>

Update the architecture vector to indicate that Cooperative Memory
Overcommitment is supported if CONFIG_PPC_SMLPAR is set.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
This is the last patch in the series.  Committing it will signal to=20
the platform firmware is CMO enabled.

Made this dependent on CONFIG_PPC_SMLPAR so that we don't advertise
functionality when the kernel isn't supporting it.
---
 arch/powerpc/kernel/prom_init.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: b/arch/powerpc/kernel/prom_init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -643,6 +643,11 @@ static void __init early_cmdline_parse(v
 #else
 #define OV5_MSI			0x00
 #endif /* CONFIG_PCI_MSI */
+#ifdef CONFIG_PPC_SMLPAR
+#define OV5_CMO			0x80	/* Cooperative Memory Overcommitment */
+#else
+#define OV5_CMO			0x00
+#endif
=20
 /*
  * The architecture vector has an array of PVR mask/value pairs,
@@ -687,10 +692,12 @@ static unsigned char ibm_architecture_ve
 	0,				/* don't halt */
=20
 	/* option vector 5: PAPR/OF options */
-	3 - 2,				/* length */
+	5 - 2,				/* length */
 	0,				/* don't ignore, don't halt */
 	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES | OV5_DRCONF_MEMORY |
 	OV5_DONATE_DEDICATE_CPU | OV5_MSI,
+	0,
+	OV5_CMO,
 };
=20
 /* Old method - ELF header with PT_NOTE sections */
