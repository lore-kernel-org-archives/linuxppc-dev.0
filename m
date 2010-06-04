Return-Path: <kerstin.jonsson@ericsson.com>
Received: from mailgw9.se.ericsson.net (mailgw9.se.ericsson.net
	[193.180.251.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2BCD1B7D6A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Jun 2010 21:39:48 +1000 (EST)
Message-ID: <4C08E25E.8000200@ericsson.com>
Date: Fri, 4 Jun 2010 13:24:14 +0200
From: kerstin jonsson <kerstin.jonsson@ericsson.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: fsl_rio.c build problem
Content-Type: multipart/mixed; boundary="------------070903080102030807010108"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--------------070903080102030807010108
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm using:

git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

and building for ARCH=powerpc - mpc85xx_defconfig

arch/powerpc/sysdev/fsl_rio.c will not build due to a missing
MCSR_MASK bitmask definition.

The attached patch is based on code found in

git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git

and - at the least - will fix the build problem.

BR,
Kerstin


--------------070903080102030807010108
Content-Type: text/x-patch;
	name="0001-fix-fsl_rio.c-build-problem-in-powerpc-mpc85xx_defco.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-fix-fsl_rio.c-build-problem-in-powerpc-mpc85xx_defco.pa";
	filename*1="tch"

>From 42d0a01865beda04b70549245ce1854c8f0074d3 Mon Sep 17 00:00:00 2001
From: Kerstin Jonsson <kerstin.jonsson@ericsson.com>
Date: Fri, 4 Jun 2010 12:56:02 +0200
Subject: [PATCH] fix fsl_rio.c build problem in powerpc mpc85xx_defconfig

---
 arch/powerpc/include/asm/reg_booke.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 2360317..68c3833 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -231,6 +231,12 @@
 #define MCSR_LDG	0x00002000UL /* Guarded Load */
 #define MCSR_TLBSYNC	0x00000002UL /* Multiple tlbsyncs detected */
 #define MCSR_BSL2_ERR	0x00000001UL /* Backside L2 cache error */
+
+/* e500 parts may set unused bits in MCSR; mask these off */
+#define MCSR_MASK	(MCSR_MCP | MCSR_ICPERR | MCSR_DCP_PERR | \
+			MCSR_DCPERR | MCSR_BUS_IAERR | MCSR_BUS_RAERR | \
+			MCSR_BUS_WAERR | MCSR_BUS_IBERR | MCSR_BUS_RBERR | \
+			MCSR_BUS_WBERR | MCSR_BUS_IPERR | MCSR_BUS_RPERR)
 #endif
 
 #ifdef CONFIG_E200
@@ -243,6 +249,11 @@
 #define MCSR_BUS_DRERR 	0x00000008UL /* Read Bus Error on data load */
 #define MCSR_BUS_WRERR 	0x00000004UL /* Write Bus Error on buffered
 					store or cache line push */
+
+/* e200 parts may set unused bits in MCSR; mask these off */
+#define MCSR_MASK	(MCSR_MCP | MCSR_CP_PERR | MCSR_CPERR | \
+			MCSR_EXCP_ERR | MCSR_BUS_IRERR | MCSR_BUS_DRERR | \
+			MCSR_BUS_WRERR)
 #endif
 
 /* Bit definitions for the DBSR. */
-- 
1.7.1


--------------070903080102030807010108--
