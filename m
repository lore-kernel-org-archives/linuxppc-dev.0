Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A30F0DDF79
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 22:57:19 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m64CvGZf027132
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Jul 2008 08:57:16 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m64CvF41155980
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Jul 2008 06:57:15 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m64CvAXZ007124
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Jul 2008 06:57:15 -0600
Date: Fri, 4 Jul 2008 07:57:00 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [PATCH 16/16 v3] powerpc: Update arch vector to indicate support
	for CMO
Message-ID: <20080704125700.GS1310@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080704124449.GA1310@linux.vnet.ibm.com>
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
Overcommitment is supported.

This is the last patch in the series.  Committing it will signal to=20
the platform firmware is CMO enabled.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
 arch/powerpc/kernel/prom_init.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: b/arch/powerpc/kernel/prom_init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -642,6 +642,7 @@ static void __init early_cmdline_parse(v
 #else
 #define OV5_MSI			0x00
 #endif /* CONFIG_PCI_MSI */
+#define OV5_CMO			0x80	/* Cooperative Memory Overcommitment */
=20
 /*
  * The architecture vector has an array of PVR mask/value pairs,
@@ -684,10 +685,12 @@ static unsigned char ibm_architecture_ve
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
