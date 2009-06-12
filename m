Return-Path: <Yang.Shi@windriver.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BAC4CB71D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 11:26:05 +1000 (EST)
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 3BDA1DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 11:26:03 +1000 (EST)
Subject: [PATCH 1/1] EDAC: Add DDR3 memory type for MPC85xx EDAC
From: yshi <yang.shi@windriver.com>
To: dougthompson@xmission.com, "bluesmoke-devel@lists.sourceforge.net"
	<bluesmoke-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2009 09:26:10 +0800
Message-Id: <1244769970.3419.246.camel@yshi-desktop.CORP>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=EF=BB=BFSince some new MPC85xx SOCs support DDR3 memory now, so
add DDR3 memory type for MPC85xx EDAC.

Signed-off-by: Yang Shi <yang.shi@windriver.com>
---
 b/drivers/edac/edac_core.h     |    4 ++++
 b/drivers/edac/edac_mc_sysfs.c |    4 +++-
 b/drivers/edac/mpc85xx_edac.c  |    6 ++++++
 b/drivers/edac/mpc85xx_edac.h  |    1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

--- a/drivers/edac/mpc85xx_edac.h
+++ b/drivers/edac/mpc85xx_edac.h
@@ -53,6 +53,7 @@
=20
 #define DSC_SDTYPE_DDR         0x02000000
 #define DSC_SDTYPE_DDR2                0x03000000
+#define DSC_SDTYPE_DDR3                0x07000000
 #define DSC_X32_EN     0x00000020
=20
 /* Err_Int_En */
--- a/drivers/edac/edac_core.h
+++ b/drivers/edac/edac_core.h
@@ -149,6 +149,8 @@ enum mem_type {
        MEM_FB_DDR2,            /* fully buffered DDR2 */
        MEM_RDDR2,              /* Registered DDR2 RAM */
        MEM_XDR,                /* Rambus XDR */
+       MEM_DDR3,               /* DDR3 RAM */
+       MEM_RDDR3,              /* Registered DDR3 RAM */
 };
=20
 #define MEM_FLAG_EMPTY         BIT(MEM_EMPTY)
@@ -166,6 +168,8 @@ enum mem_type {
 #define MEM_FLAG_FB_DDR2        BIT(MEM_FB_DDR2)
 #define MEM_FLAG_RDDR2          BIT(MEM_RDDR2)
 #define MEM_FLAG_XDR            BIT(MEM_XDR)
+#define MEM_FLAG_DDR3           BIT(MEM_DDR3)
+#define MEM_FLAG_RDDR3          BIT(MEM_RDDR3)
=20
 /* chipset Error Detection and Correction capabilities and mode */
 enum edac_type {
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -757,6 +757,9 @@ static void __devinit mpc85xx_init_csrow
                case DSC_SDTYPE_DDR2:
                        mtype =3D MEM_RDDR2;
                        break;
+               case DSC_SDTYPE_DDR3:
+                       mtype =3D MEM_RDDR3;
+                       break;
                default:
                        mtype =3D MEM_UNKNOWN;
                        break;
@@ -769,6 +772,9 @@ static void __devinit mpc85xx_init_csrow
                case DSC_SDTYPE_DDR2:
                        mtype =3D MEM_DDR2;
                        break;
+               case DSC_SDTYPE_DDR3:
+                       mtype =3D MEM_DDR3;
+                       break;
                default:
                        mtype =3D MEM_UNKNOWN;
                        break;
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -94,7 +94,9 @@ static const char *mem_types[] =3D {
        [MEM_DDR2] =3D "Unbuffered-DDR2",
        [MEM_FB_DDR2] =3D "FullyBuffered-DDR2",
        [MEM_RDDR2] =3D "Registered-DDR2",
-       [MEM_XDR] =3D "XDR"
+       [MEM_XDR] =3D "XDR",
+       [MEM_DDR3] =3D "Unbuffered-DDR3",
+       [MEM_RDDR3] =3D "Registered-DDR3"
 };
=20
 static const char *dev_types[] =3D {
