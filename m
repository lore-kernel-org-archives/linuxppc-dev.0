Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id AD2EC67BEA
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 18:18:52 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k8S9cmij015682
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 03:38:48 -0600 (MDT)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k8S8IHra009860
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 03:18:49 -0500 (CDT)
Message-ID: <451B858A.4050105@freescale.com>
Date: Thu, 28 Sep 2006 16:19:22 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: paulus@samba.org, galak@kernel.crashing.org
Subject: [PATCH 9/12] Add ucc_geth driver data structure
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Shlomi Gridish <gridish@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

---
 include/linux/fsl_devices.h |   39 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index 16fbe59..a16d82f 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -83,7 +83,6 @@ struct fsl_i2c_platform_data {
 #define FSL_I2C_DEV_SEPARATE_DFSRR	0x00000001
 #define FSL_I2C_DEV_CLOCK_5200		0x00000002
 
-
 enum fsl_usb2_operating_modes {
 	FSL_USB2_MPH_HOST,
 	FSL_USB2_DR_HOST,
@@ -121,5 +120,43 @@ struct fsl_spi_platform_data {
 	u32	sysclk;
 };
 
+/* Ethernet interface (phy management and speed)
+*/
+typedef enum enet_interface {
+	ENET_10_MII,		/* 10 Base T,   MII interface */
+	ENET_10_RMII,		/* 10 Base T,  RMII interface */
+	ENET_10_RGMII,		/* 10 Base T, RGMII interface */
+	ENET_100_MII,		/* 100 Base T,   MII interface */
+	ENET_100_RMII,		/* 100 Base T,  RMII interface */
+	ENET_100_RGMII,		/* 100 Base T, RGMII interface */
+	ENET_1000_GMII,		/* 1000 Base T,  GMII interface */
+	ENET_1000_RGMII,	/* 1000 Base T, RGMII interface */
+	ENET_1000_TBI,		/* 1000 Base T,   TBI interface */
+	ENET_1000_RTBI		/* 1000 Base T,  RTBI interface */
+} enet_interface_e;
+
+struct ucc_geth_platform_data {
+	/* device specific information */
+	u32 device_flags;
+	u32 phy_reg_addr;
+
+	/* board specific information */
+	u32 board_flags;
+	u8 rx_clock;
+	u8 tx_clock;
+	u32 phy_id;
+	enet_interface_e phy_interface;
+	u32 phy_interrupt;
+	u8 mac_addr[6];
+};
+
+/* Flags related to UCC Gigabit Ethernet device features */
+#define FSL_UGETH_DEV_HAS_GIGABIT		0x00000001
+#define FSL_UGETH_DEV_HAS_COALESCE		0x00000002
+#define FSL_UGETH_DEV_HAS_RMON			0x00000004
+
+/* Flags in ucc_geth_platform_data */
+#define FSL_UGETH_BRD_HAS_PHY_INTR		0x00000001	/* if not set use a timer */
+
 #endif				/* _FSL_DEVICE_H_ */
 #endif				/* __KERNEL__ */
