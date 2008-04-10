Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 51593DDF13
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 16:44:39 +1000 (EST)
Received: from ash.ozlabs.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 269D7368004
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 16:44:39 +1000 (EST)
Date: Thu, 10 Apr 2008 16:44:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/3] [POWERPC] iSeries: localise and constify some iSeries data
Message-Id: <20080410164430.ffca6dbf.sfr@canb.auug.org.au>
In-Reply-To: <20080410164347.2e3c4661.sfr@canb.auug.org.au>
References: <20080410163918.257405e7.sfr@canb.auug.org.au>
	<20080410164347.2e3c4661.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/ipl_parms.h    |    2 --
 arch/powerpc/platforms/iseries/lpardata.c     |   14 +++++++-------
 arch/powerpc/platforms/iseries/naca.h         |    2 +-
 arch/powerpc/platforms/iseries/release_data.h |    2 +-
 arch/powerpc/platforms/iseries/spcomm_area.h  |    2 --
 arch/powerpc/platforms/iseries/vpd_areas.h    |    4 ++--
 include/asm-powerpc/iseries/alpaca.h          |    2 +-
 7 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/ipl_parms.h b/arch/powerpc/platforms/iseries/ipl_parms.h
index 77c135d..83e4ca4 100644
--- a/arch/powerpc/platforms/iseries/ipl_parms.h
+++ b/arch/powerpc/platforms/iseries/ipl_parms.h
@@ -65,6 +65,4 @@ struct ItIplParmsReal {
 	u64	xRsvd13;		// Reserved			x38-x3F
 };
 
-extern struct ItIplParmsReal	xItIplParmsReal;
-
 #endif /* _ISERIES_IPL_PARMS_H */
diff --git a/arch/powerpc/platforms/iseries/lpardata.c b/arch/powerpc/platforms/iseries/lpardata.c
index 2331d97..98bd2d3 100644
--- a/arch/powerpc/platforms/iseries/lpardata.c
+++ b/arch/powerpc/platforms/iseries/lpardata.c
@@ -31,7 +31,7 @@
 /* The HvReleaseData is the root of the information shared between
  * the hypervisor and Linux.
  */
-struct HvReleaseData hvReleaseData = {
+const struct HvReleaseData hvReleaseData = {
 	.xDesc = 0xc8a5d9c4,	/* "HvRD" ebcdic */
 	.xSize = sizeof(struct HvReleaseData),
 	.xVpdAreasPtrOffset = offsetof(struct naca_struct, xItVpdAreas),
@@ -186,7 +186,7 @@ struct ItLpNaca itLpNaca = {
 };
 
 /* May be filled in by the hypervisor so cannot end up in the BSS */
-struct ItIplParmsReal xItIplParmsReal __attribute__((__section__(".data")));
+static struct ItIplParmsReal xItIplParmsReal __attribute__((__section__(".data")));
 
 /* May be filled in by the hypervisor so cannot end up in the BSS */
 struct ItExtVpdPanel xItExtVpdPanel __attribute__((__section__(".data")));
@@ -209,14 +209,14 @@ u64    xMsVpd[3400] __attribute__((__section__(".data")));
 
 /* Space for Recovery Log Buffer */
 /* May be filled in by the hypervisor so cannot end up in the BSS */
-u64    xRecoveryLogBuffer[32] __attribute__((__section__(".data")));
+static u64    xRecoveryLogBuffer[32] __attribute__((__section__(".data")));
 
-struct SpCommArea xSpCommArea = {
+static const struct SpCommArea xSpCommArea = {
 	.xDesc = 0xE2D7C3C2,
 	.xFormat = 1,
 };
 
-static struct ItLpRegSave iseries_reg_save[] = {
+static const struct ItLpRegSave iseries_reg_save[] = {
 	[0 ... (NR_CPUS-1)] = {
 		.xDesc = 0xd397d9e2,	/* "LpRS" */
 		.xSize = sizeof(struct ItLpRegSave),
@@ -229,7 +229,7 @@ static struct ItLpRegSave iseries_reg_save[] = {
 	.reg_save_ptr = &iseries_reg_save[number],			\
 }
 
-struct alpaca alpaca[] = {
+const struct alpaca alpaca[] = {
 	ALPACA_INIT( 0),
 #if NR_CPUS > 1
 	ALPACA_INIT( 1), ALPACA_INIT( 2), ALPACA_INIT( 3),
@@ -265,7 +265,7 @@ struct alpaca alpaca[] = {
  * the Naca via the HvReleaseData area.  The HvReleaseData has the
  * offset into the Naca of the pointer to the ItVpdAreas.
  */
-struct ItVpdAreas itVpdAreas = {
+const struct ItVpdAreas itVpdAreas = {
 	.xSlicDesc = 0xc9a3e5c1,		/* "ItVA" */
 	.xSlicSize = sizeof(struct ItVpdAreas),
 	.xSlicVpdEntries = ItVpdMaxEntries,	/* # VPD array entries */
diff --git a/arch/powerpc/platforms/iseries/naca.h b/arch/powerpc/platforms/iseries/naca.h
index ab2372e..f01708e 100644
--- a/arch/powerpc/platforms/iseries/naca.h
+++ b/arch/powerpc/platforms/iseries/naca.h
@@ -14,7 +14,7 @@
 
 struct naca_struct {
 	/* Kernel only data - undefined for user space */
-	void *xItVpdAreas;              /* VPD Data                  0x00 */
+	const void *xItVpdAreas;	/* VPD Data                  0x00 */
 	void *xRamDisk;                 /* iSeries ramdisk           0x08 */
 	u64   xRamDiskSize;		/* In pages                  0x10 */
 };
diff --git a/arch/powerpc/platforms/iseries/release_data.h b/arch/powerpc/platforms/iseries/release_data.h
index 66189fd..6ad7d84 100644
--- a/arch/powerpc/platforms/iseries/release_data.h
+++ b/arch/powerpc/platforms/iseries/release_data.h
@@ -58,6 +58,6 @@ struct HvReleaseData {
 	char	xRsvd3[20];	/* Reserved			x2C-x3F */
 };
 
-extern struct HvReleaseData	hvReleaseData;
+extern const struct HvReleaseData	hvReleaseData;
 
 #endif /* _ISERIES_RELEASE_DATA_H */
diff --git a/arch/powerpc/platforms/iseries/spcomm_area.h b/arch/powerpc/platforms/iseries/spcomm_area.h
index 6e3b685..598b7c1 100644
--- a/arch/powerpc/platforms/iseries/spcomm_area.h
+++ b/arch/powerpc/platforms/iseries/spcomm_area.h
@@ -31,6 +31,4 @@ struct SpCommArea {
 	u8	xRsvd2[80];		// Reserved				030-07F
 };
 
-extern struct SpCommArea xSpCommArea;
-
 #endif /* _ISERIES_SPCOMM_AREA_H */
diff --git a/arch/powerpc/platforms/iseries/vpd_areas.h b/arch/powerpc/platforms/iseries/vpd_areas.h
index 601e6dd..feb001f 100644
--- a/arch/powerpc/platforms/iseries/vpd_areas.h
+++ b/arch/powerpc/platforms/iseries/vpd_areas.h
@@ -80,9 +80,9 @@ struct ItVpdAreas {
 	u32	xPlicDmaLens[ItDmaMaxEntries];// Array of DMA lengths	080-0A7
 	u32	xPlicDmaToks[ItDmaMaxEntries];// Array of DMA tokens	0A8-0CF
 	u32	xSlicVpdLens[ItVpdMaxEntries];// Array of VPD lengths	0D0-12F
-	void	*xSlicVpdAdrs[ItVpdMaxEntries];// Array of VPD buffers	130-1EF
+	const void *xSlicVpdAdrs[ItVpdMaxEntries];// Array of VPD buffers 130-1EF
 };
 
-extern struct ItVpdAreas	itVpdAreas;
+extern const struct ItVpdAreas	itVpdAreas;
 
 #endif /* _ISERIES_VPD_AREAS_H */
diff --git a/include/asm-powerpc/iseries/alpaca.h b/include/asm-powerpc/iseries/alpaca.h
index 26fc081..c0cce67 100644
--- a/include/asm-powerpc/iseries/alpaca.h
+++ b/include/asm-powerpc/iseries/alpaca.h
@@ -25,7 +25,7 @@
  */
 struct alpaca {
 	struct lppaca *lppaca_ptr;	/* Pointer to LpPaca for PLIC */
-	void *reg_save_ptr;		/* Pointer to LpRegSave for PLIC */
+	const void *reg_save_ptr;	/* Pointer to LpRegSave for PLIC */
 };
 
 #endif /* _ASM_POWERPC_ISERIES_ALPACA_H */
-- 
1.5.4.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
