Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DC0B4DE13D
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 08:17:09 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5CMH6tm004223
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 18:17:06 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5CMH63t216220
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 18:17:06 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5CMH6mZ005705
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 18:17:06 -0400
Date: Thu, 12 Jun 2008 17:15:35 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [PATCH 10/19] powerpc: move get_longbusy_msecs out of ehca/ehea
Message-ID: <20080612221535.GQ30916@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080612215312.GF30916@linux.vnet.ibm.com>
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

=46rom: Robert Jennings <rcj@linux.vnet.ibm.com>

In support of Cooperative Memory Overcommitment (CMO) this moves
get_longbusy_msecs() out of the ehca and ehea drivers and into the=20
architecture's hvcall header as plpar_get_longbusy_msecs.  Some firmware
calls made in pSeries platform iommu code will need to share this
functionality.

Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
 drivers/infiniband/hw/ehca/hcp_if.c |   24 ++----------------------
 drivers/net/ehea/ehea_phyp.c        |    4 ++--
 drivers/net/ehea/ehea_phyp.h        |   20 --------------------
 include/asm-powerpc/hvcall.h        |   27 +++++++++++++++++++++++++++
 4 files changed, 31 insertions(+), 44 deletions(-)

Index: b/drivers/infiniband/hw/ehca/hcp_if.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/infiniband/hw/ehca/hcp_if.c
+++ b/drivers/infiniband/hw/ehca/hcp_if.c
@@ -90,26 +90,6 @@
=20
 static DEFINE_SPINLOCK(hcall_lock);
=20
-static u32 get_longbusy_msecs(int longbusy_rc)
-{
-	switch (longbusy_rc) {
-	case H_LONG_BUSY_ORDER_1_MSEC:
-		return 1;
-	case H_LONG_BUSY_ORDER_10_MSEC:
-		return 10;
-	case H_LONG_BUSY_ORDER_100_MSEC:
-		return 100;
-	case H_LONG_BUSY_ORDER_1_SEC:
-		return 1000;
-	case H_LONG_BUSY_ORDER_10_SEC:
-		return 10000;
-	case H_LONG_BUSY_ORDER_100_SEC:
-		return 100000;
-	default:
-		return 1;
-	}
-}
-
 static long ehca_plpar_hcall_norets(unsigned long opcode,
 				    unsigned long arg1,
 				    unsigned long arg2,
@@ -139,7 +119,7 @@ static long ehca_plpar_hcall_norets(unsi
 			spin_unlock_irqrestore(&hcall_lock, flags);
=20
 		if (H_IS_LONG_BUSY(ret)) {
-			sleep_msecs =3D get_longbusy_msecs(ret);
+			sleep_msecs =3D plpar_get_longbusy_msecs(ret);
 			msleep_interruptible(sleep_msecs);
 			continue;
 		}
@@ -192,7 +172,7 @@ static long ehca_plpar_hcall9(unsigned l
 			spin_unlock_irqrestore(&hcall_lock, flags);
=20
 		if (H_IS_LONG_BUSY(ret)) {
-			sleep_msecs =3D get_longbusy_msecs(ret);
+			sleep_msecs =3D plpar_get_longbusy_msecs(ret);
 			msleep_interruptible(sleep_msecs);
 			continue;
 		}
Index: b/drivers/net/ehea/ehea_phyp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/net/ehea/ehea_phyp.c
+++ b/drivers/net/ehea/ehea_phyp.c
@@ -61,7 +61,7 @@ static long ehea_plpar_hcall_norets(unsi
 					 arg5, arg6, arg7);
=20
 		if (H_IS_LONG_BUSY(ret)) {
-			sleep_msecs =3D get_longbusy_msecs(ret);
+			sleep_msecs =3D plpar_get_longbusy_msecs(ret);
 			msleep_interruptible(sleep_msecs);
 			continue;
 		}
@@ -102,7 +102,7 @@ static long ehea_plpar_hcall9(unsigned l
 				   arg6, arg7, arg8, arg9);
=20
 		if (H_IS_LONG_BUSY(ret)) {
-			sleep_msecs =3D get_longbusy_msecs(ret);
+			sleep_msecs =3D plpar_get_longbusy_msecs(ret);
 			msleep_interruptible(sleep_msecs);
 			continue;
 		}
Index: b/drivers/net/ehea/ehea_phyp.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/net/ehea/ehea_phyp.h
+++ b/drivers/net/ehea/ehea_phyp.h
@@ -40,26 +40,6 @@
  * hcp_*  - structures, variables and functions releated to Hypervisor Cal=
ls
  */
=20
-static inline u32 get_longbusy_msecs(int long_busy_ret_code)
-{
-	switch (long_busy_ret_code) {
-	case H_LONG_BUSY_ORDER_1_MSEC:
-		return 1;
-	case H_LONG_BUSY_ORDER_10_MSEC:
-		return 10;
-	case H_LONG_BUSY_ORDER_100_MSEC:
-		return 100;
-	case H_LONG_BUSY_ORDER_1_SEC:
-		return 1000;
-	case H_LONG_BUSY_ORDER_10_SEC:
-		return 10000;
-	case H_LONG_BUSY_ORDER_100_SEC:
-		return 100000;
-	default:
-		return 1;
-	}
-}
-
 /* Number of pages which can be registered at once by H_REGISTER_HEA_RPAGE=
S */
 #define EHEA_MAX_RPAGE 512
=20
Index: b/include/asm-powerpc/hvcall.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-powerpc/hvcall.h
+++ b/include/asm-powerpc/hvcall.h
@@ -222,6 +222,33 @@
 #ifndef __ASSEMBLY__
=20
 /**
+ * plpar_get_longbusy_msecs: - Return number of msecs for H_LONG_BUSY* res=
ponse
+ * @long_busy_ret_code: The H_LONG_BUSY_* constant to process
+ *
+ * This returns the number of msecs that corresponds to an H_LONG_BUSY_*
+ * response from a plpar_hcall.  If there is no match 1 is returned.
+ */
+static inline u32 plpar_get_longbusy_msecs(int long_busy_ret_code)
+{
+	switch (long_busy_ret_code) {
+	case H_LONG_BUSY_ORDER_1_MSEC:
+		return 1;
+	case H_LONG_BUSY_ORDER_10_MSEC:
+		return 10;
+	case H_LONG_BUSY_ORDER_100_MSEC:
+		return 100;
+	case H_LONG_BUSY_ORDER_1_SEC:
+		return 1000;
+	case H_LONG_BUSY_ORDER_10_SEC:
+		return 10000;
+	case H_LONG_BUSY_ORDER_100_SEC:
+		return 100000;
+	default:
+		return 1;
+	}
+}
+
+/**
  * plpar_hcall_norets: - Make a pseries hypervisor call with no return arg=
uments
  * @opcode: The hypervisor call to make.
  *
