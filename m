Return-Path: <key@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E6DE5B7070
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2012 01:10:12 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <key@linux.vnet.ibm.com>;
 Tue, 10 Apr 2012 09:10:10 -0600
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 0108AC9005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 11:08:06 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3AF862W219540
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 11:08:06 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3AF7w7g031207
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 09:07:58 -0600
Message-ID: <1334070539.16827.11.camel@key-ThinkPad-W510>
Subject: [PATCH v2 05/17] pseries: Enabled the PFO-based RNG accelerator
From: Kent Yoder <key@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 10 Apr 2012 10:08:59 -0500
In-Reply-To: <1334070249.16827.1.camel@key-ThinkPad-W510>
References: <1334070249.16827.1.camel@key-ThinkPad-W510>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: key@linux.vnet.ibm.com, rcj@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the cas bits to advertise support for the Platform
Facilities Option (PFO) based random number generator accerator.
The pseries-rng driver provides support for this hardware feature.

Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
Signed-off-by: Kent Yoder <key@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom_init.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 9986027..26f6317 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -701,6 +701,7 @@ static void __init early_cmdline_parse(void)
 #define OV5_XCMO			0x00
 #endif
 #define OV5_TYPE1_AFFINITY	0x80	/* Type 1 NUMA affinity */
+#define OV5_PFO_HW_RNG		0x80	/* PFO Random Number Generator */
 
 /* Option Vector 6: IBM PAPR hints */
 #define OV6_LINUX		0x02	/* Linux is our OS */
@@ -748,7 +749,7 @@ static unsigned char ibm_architecture_vec[] = {
 	0,				/* don't halt */
 
 	/* option vector 5: PAPR/OF options */
-	13 - 2,				/* length */
+	18 - 2,				/* length */
 	0,				/* don't ignore, don't halt */
 	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES | OV5_DRCONF_MEMORY |
 	OV5_DONATE_DEDICATE_CPU | OV5_MSI,
@@ -764,6 +765,11 @@ static unsigned char ibm_architecture_vec[] = {
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
