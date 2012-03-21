Return-Path: <key@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0307BB6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 08:38:20 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <key@linux.vnet.ibm.com>;
 Wed, 21 Mar 2012 15:38:18 -0600
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id AAD4BC9005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 17:38:16 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2LLcGkE218584
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 17:38:16 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2LLcGc8031067
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 17:38:16 -0400
Message-ID: <1332365949.3858.32.camel@key-ThinkPad-W510>
Subject: [PATCH 05/17] pseries: Enabled the PFO-based RNG accelerator
From: Kent Yoder <key@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 21 Mar 2012 16:39:09 -0500
In-Reply-To: <1332365297.3858.5.camel@key-ThinkPad-W510>
References: <1332365297.3858.5.camel@key-ThinkPad-W510>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: rcj@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Robert Jennings <rcj@linux.vnet.ibm.com>

This patch adds the cas bits to advertise support for the Platform
Facilities Option (PFO) based random number generator accerator.
The pseries-rng driver provides support for this hardware feature.

Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
Signed-off-by: Kent Yoder <key@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom_init.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index eca626e..6691077 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -710,6 +710,12 @@ static void __init early_cmdline_parse(void)
 #define OV5_XCMO			0x00
 #endif
 #define OV5_TYPE1_AFFINITY	0x80	/* Type 1 NUMA affinity */
+#if defined(CONFIG_HW_RANDOM_PSERIES) || \
+	defined(CONFIG_HW_RANDOM_PSERIES_MODULE)
+#define OV5_PFO_HW_RNG		0x80	/* PFO Random Number Generator */
+#else
+#define OV5_PFO_HW_RNG		0x00
+#endif
 
 /* Option Vector 6: IBM PAPR hints */
 #define OV6_LINUX		0x02	/* Linux is our OS */
@@ -757,7 +763,7 @@ static unsigned char ibm_architecture_vec[] = {
 	0,				/* don't halt */
 
 	/* option vector 5: PAPR/OF options */
-	13 - 2,				/* length */
+	18 - 2,				/* length */
 	0,				/* don't ignore, don't halt */
 	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES | OV5_DRCONF_MEMORY |
 	OV5_DONATE_DEDICATE_CPU | OV5_MSI,
@@ -773,6 +779,11 @@ static unsigned char ibm_architecture_vec[] = {
 	 */
 #define IBM_ARCH_VEC_NRCORES_OFFSET	100
 	W(NR_CPUS),			/* number of cores supported */
+	0,
+	0,
+	0,
+	0,
+	OV5_PFO_HW_RNG,
 
 	/* option vector 6: IBM PAPR hints */
 	4 - 2,				/* length */
-- 
1.7.1
