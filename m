Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 3604A67A8D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Jan 2005 12:37:34 +1100 (EST)
Message-ID: <41F99753.9080500@mvista.com>
Date: Thu, 27 Jan 2005 18:37:23 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------010404090708050107020603"
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH][PPC32] Workaround for mpc10x speculative PCI read erratum
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
--------------010404090708050107020603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

824x and 107 bridges from Freescale/Tundra have an erratum where 
speculative PCI reads may return stale data.  One of the two documented 
workarounds is to turn of speculative PCI reads.  This patch does that.

Please apply.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

--------------010404090708050107020603
Content-Type: text/plain;
 name="mpc10x.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpc10x.patch"

diff -Nru a/arch/ppc/syslib/mpc10x_common.c b/arch/ppc/syslib/mpc10x_common.c
--- a/arch/ppc/syslib/mpc10x_common.c	2005-01-27 18:31:21 -07:00
+++ b/arch/ppc/syslib/mpc10x_common.c	2005-01-27 18:31:21 -07:00
@@ -306,6 +306,23 @@
 	mpc10x_disable_store_gathering(hose);
 #endif
 
+	/*
+	 * 8240 erratum 26, 8241/8245 erratum 29, 107 erratum 23: speculative
+	 * PCI reads may return stale data so turn off.
+	 */
+	if ((host_bridge == MPC10X_BRIDGE_8240)
+		|| (host_bridge == MPC10X_BRIDGE_8245)
+		|| (host_bridge == MPC10X_BRIDGE_107)) {
+
+		early_read_config_dword(hose, 0, PCI_DEVFN(0,0),
+			MPC10X_CFG_PICR1_REG, &picr1);
+
+		picr1 &= ~MPC10X_CFG_PICR1_SPEC_PCI_RD;
+
+		early_write_config_dword(hose, 0, PCI_DEVFN(0,0),
+			MPC10X_CFG_PICR1_REG, picr1);
+	}
+
 	if (ppc_md.progress) ppc_md.progress("mpc10x:exit", 0x100);
 	return 0;
 }
diff -Nru a/include/asm-ppc/mpc10x.h b/include/asm-ppc/mpc10x.h
--- a/include/asm-ppc/mpc10x.h	2005-01-27 18:31:21 -07:00
+++ b/include/asm-ppc/mpc10x.h	2005-01-27 18:31:21 -07:00
@@ -105,6 +105,7 @@
 #define	MPC10X_CFG_PICR1_ADDR_MAP_MASK	0x00010000
 #define	MPC10X_CFG_PICR1_ADDR_MAP_A	0x00010000
 #define	MPC10X_CFG_PICR1_ADDR_MAP_B	0x00000000
+#define	MPC10X_CFG_PICR1_SPEC_PCI_RD	0x00000004
 #define	MPC10X_CFG_PICR1_ST_GATH_EN	0x00000040
 
 #define	MPC10X_CFG_MAPB_OPTIONS_REG	0xe0

--------------010404090708050107020603--
