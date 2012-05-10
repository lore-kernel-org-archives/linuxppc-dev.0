Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 96C14B6FA2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2012 04:56:18 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rcjenn@linux.vnet.ibm.com>;
 Thu, 10 May 2012 12:56:15 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 286371FF0030
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2012 12:55:55 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q4AItqKo179676
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2012 12:55:55 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q4AItp0p024080
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2012 12:55:52 -0600
Date: Thu, 10 May 2012 13:55:49 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: [PATCH][v2] powerpc: Support lower minimum entitlement for virtual
 processors
Message-ID: <20120510185549.GA12304@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch changes the architecture vector to advertise support for a
lower minimum virtual processor entitled capacity.  The default
minimum without this patch is 10%, this patch specifies 1%.

Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
---
Dropped minimum to 1% and tested to ensure that pHYP handled this properly.
---
 arch/powerpc/kernel/prom_init.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index eca626e..46a3c42 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -689,6 +689,9 @@ static void __init early_cmdline_parse(void)
 #define OV3_VMX			0x40	/* VMX/Altivec */
 #define OV3_DFP			0x20	/* decimal FP */
 
+/* Option vector 4: IBM PAPR implementation */
+#define OV4_MIN_ENT_CAP		0x01	/* minimum VP entitled capacity */
+
 /* Option vector 5: PAPR/OF options supported */
 #define OV5_LPAR		0x80	/* logical partitioning supported */
 #define OV5_SPLPAR		0x40	/* shared-processor LPAR supported */
@@ -753,8 +756,9 @@ static unsigned char ibm_architecture_vec[] = {
 	OV3_FP | OV3_VMX | OV3_DFP,
 
 	/* option vector 4: IBM PAPR implementation */
-	2 - 2,				/* length */
+	3 - 2,				/* length */
 	0,				/* don't halt */
+	OV4_MIN_ENT_CAP,		/* minimum VP entitled capacity */
 
 	/* option vector 5: PAPR/OF options */
 	13 - 2,				/* length */
@@ -771,7 +775,7 @@ static unsigned char ibm_architecture_vec[] = {
 	 * must match by the macro below. Update the definition if
 	 * the structure layout changes.
 	 */
-#define IBM_ARCH_VEC_NRCORES_OFFSET	100
+#define IBM_ARCH_VEC_NRCORES_OFFSET	101
 	W(NR_CPUS),			/* number of cores supported */
 
 	/* option vector 6: IBM PAPR hints */
-- 
1.7.0.4
