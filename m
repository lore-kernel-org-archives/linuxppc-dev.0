Return-Path: <vbordug@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 7EA6C6874D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Nov 2005 04:10:55 +1100 (EST)
Message-ID: <437E048B.2020605@dev.rtsoft.ru>
Date: Fri, 18 Nov 2005 19:42:51 +0300
From: Vitaly Bordug <vbordug@dev.rtsoft.ru>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Content-Type: multipart/mixed; boundary="------------000901030005010306020905"
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] 8xx PCMCIA: support for MPC885ADS and MPC866ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000901030005010306020905
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

This adds adds PCMCIA supported for  both MPC885ADS and MPC866ADS.

This is established not together with FADS, because 885 does not have 
io_block_mapping() for BCSR area.
Also, some cleanups done both for 885ADS and MBX.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

-- 
Sincerely, 
Vitaly


--------------000901030005010306020905
Content-Type: text/x-patch;
 name="mpc8xx_pcmcia_885ads1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpc8xx_pcmcia_885ads1.patch"

diff --git a/drivers/pcmcia/m8xx_pcmcia.c b/drivers/pcmcia/m8xx_pcmcia.c
index 6d9f71c..5b7a04f 100644
--- a/drivers/pcmcia/m8xx_pcmcia.c
+++ b/drivers/pcmcia/m8xx_pcmcia.c
@@ -9,6 +9,9 @@
  *     <oliver.kurth@cyclades.de>
  * Further fixes, v2.6 kernel port
  *     <marcelo.tosatti@cyclades.com>
+ * 
+ * Some fixes, additions (C) 2005 Montavista Software, Inc. 
+ *     <vbordug@ru.mvista.com>
  *
  * "The ExCA standard specifies that socket controllers should provide
  * two IO and five memory windows per socket, which can be independently
@@ -97,6 +100,11 @@ MODULE_LICENSE("Dual MPL/GPL");
 #endif
 #endif
 
+#if defined(CONFIG_MPC885ADS)
+#define CONFIG_PCMCIA_SLOT_A
+#define PCMCIA_GLITCHY_CD
+#endif
+
 /* Cyclades ACS uses both slots */
 #ifdef CONFIG_PRxK
 #define CONFIG_PCMCIA_SLOT_A
@@ -374,11 +382,80 @@ static int voltage_set(int slot, int vcc
 	}
 
 	/* first, turn off all power */
-	out_be32(&((u32 *)BCSR1), in_be32(&((u32 *)BCSR1)) & ~(BCSR1_PCCVCC_MASK | BCSR1_PCCVPP_MASK));
+	out_be32((u32 *)BCSR1, in_be32((u32 *)BCSR1) & ~(BCSR1_PCCVCC_MASK | BCSR1_PCCVPP_MASK));
+
+	/* enable new powersettings */
+	out_be32((u32 *)BCSR1, in_be32((u32 *)BCSR1) | reg);
+
+	return 0;
+}
+
+#define socket_get(_slot_) PCMCIA_SOCKET_KEY_5V
+
+static void hardware_enable(int slot)
+{
+	out_be32((u32 *)BCSR1, in_be32((u32 *)BCSR1) & ~BCSR1_PCCEN);
+}
+
+static void hardware_disable(int slot)
+{
+	out_be32((u32 *)BCSR1, in_be32((u32 *)BCSR1) |  BCSR1_PCCEN);
+}
+
+#endif
+
+/* MPC885ADS Boards */
+
+#if defined(CONFIG_MPC885ADS)
+
+#define PCMCIA_BOARD_MSG "MPC885ADS"
+
+static int voltage_set(int slot, int vcc, int vpp)
+{
+	u32 reg = 0;
+	unsigned *bcsr_io;
+
+	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
+
+	switch(vcc) {
+		case 0:
+			break;
+		case 33:
+			reg |= BCSR1_PCCVCC0;
+			break;
+		case 50:
+			reg |= BCSR1_PCCVCC1;
+			break;
+		default:
+			return 1;
+	}
+
+	switch(vpp) {
+		case 0:
+			break;
+		case 33:
+		case 50:
+			if(vcc == vpp)
+				reg |= BCSR1_PCCVPP1;
+			else
+				return 1;
+			break;
+		case 120:
+			if ((vcc == 33) || (vcc == 50))
+				reg |= BCSR1_PCCVPP0;
+			else
+				return 1;
+		default:
+			return 1;
+	}
+
+	/* first, turn off all power */
+	out_be32(bcsr_io, in_be32(bcsr_io) & ~(BCSR1_PCCVCC_MASK | BCSR1_PCCVPP_MASK));
 
 	/* enable new powersettings */
-	out_be32(&((u32 *)BCSR1), in_be32(&((u32 *)BCSR1)) | reg);
+	out_be32(bcsr_io, in_be32(bcsr_io) | reg);
 
+	iounmap(bcsr_io);
 	return 0;
 }
 
@@ -386,12 +463,20 @@ static int voltage_set(int slot, int vcc
 
 static void hardware_enable(int slot)
 {
-	out_be32(&((u32 *)BCSR1), in_be32(&((u32 *)BCSR1)) & ~BCSR1_PCCEN);
+	unsigned *bcsr_io;
+
+	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
+	out_be32(bcsr_io, in_be32(bcsr_io) & ~BCSR1_PCCEN);
+	iounmap(bcsr_io);
 }
 
 static void hardware_disable(int slot)
 {
-	out_be32(&((u32 *)BCSR1), in_be32(&((u32 *)BCSR1)) |  BCSR1_PCCEN);
+	unsigned *bcsr_io;
+
+	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
+	out_be32(bcsr_io, in_be32(bcsr_io) |  BCSR1_PCCEN);
+	iounmap(bcsr_io);
 }
 
 #endif
@@ -440,10 +525,10 @@ static int voltage_set(int slot, int vcc
 	}
 
 	/* first, turn off all power */
-	out_8(&((u8 *)MBX_CSR2_ADDR), in_8(&((u8 *)MBX_CSR2_ADDR)) & ~(CSR2_VCC_MASK | CSR2_VPP_MASK));
+	out_8((u8 *)MBX_CSR2_ADDR, in_8((u8 *)MBX_CSR2_ADDR) & ~(CSR2_VCC_MASK | CSR2_VPP_MASK));
 
 	/* enable new powersettings */
-	out_8(&((u8 *)MBX_CSR2_ADDR), in_8(&((u8 *)MBX_CSR2_ADDR)) | reg);
+	out_8((u8 *)MBX_CSR2_ADDR, in_8((u8 *)MBX_CSR2_ADDR) | reg);
 
 	return 0;
 }

--------------000901030005010306020905--
