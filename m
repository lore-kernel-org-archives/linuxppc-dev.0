Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id B8DAC67A85
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Jan 2005 08:27:45 +1100 (EST)
Message-ID: <41FAAE4C.3060300@mvista.com>
Date: Fri, 28 Jan 2005 14:27:40 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------020707020608070004000400"
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH][PPC32] MPC8245 erratum 28 workaround
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
--------------020707020608070004000400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The 8241/8245 have an erratum where PCI reads from local memory may 
return stale data.  One of the two workarounds is to set PICR2[0].  This 
patch does that.

This patch assumes that the previous mpc10x patch has been applied.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

--------------020707020608070004000400
Content-Type: text/plain;
 name="mpc10x_2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpc10x_2.patch"

diff -Nru a/arch/ppc/syslib/mpc10x_common.c b/arch/ppc/syslib/mpc10x_common.c
--- a/arch/ppc/syslib/mpc10x_common.c	2005-01-28 14:23:25 -07:00
+++ b/arch/ppc/syslib/mpc10x_common.c	2005-01-28 14:23:25 -07:00
@@ -323,6 +323,24 @@
 			MPC10X_CFG_PICR1_REG, picr1);
 	}
 
+	/*
+	 * 8241/8245 erratum 28: PCI reads from local memory may return
+	 * stale data.  Workaround by setting PICR2[0] to disable copyback
+	 * optimization.  Oddly, the latest available user manual for the
+	 * 8245 (Rev 2., dated 10/2003) says PICR2[0] is reserverd.
+	 */
+	if (host_bridge == MPC10X_BRIDGE_8245) {
+		ulong	picr2;
+
+		early_read_config_dword(hose, 0, PCI_DEVFN(0,0),
+			MPC10X_CFG_PICR2_REG, &picr2);
+
+		picr2 |= MPC10X_CFG_PICR2_COPYBACK_OPT;
+
+		early_write_config_dword(hose, 0, PCI_DEVFN(0,0),
+			 MPC10X_CFG_PICR2_REG, picr2);
+	}
+
 	if (ppc_md.progress) ppc_md.progress("mpc10x:exit", 0x100);
 	return 0;
 }
diff -Nru a/include/asm-ppc/mpc10x.h b/include/asm-ppc/mpc10x.h
--- a/include/asm-ppc/mpc10x.h	2005-01-28 14:23:25 -07:00
+++ b/include/asm-ppc/mpc10x.h	2005-01-28 14:23:25 -07:00
@@ -108,6 +108,9 @@
 #define	MPC10X_CFG_PICR1_SPEC_PCI_RD	0x00000004
 #define	MPC10X_CFG_PICR1_ST_GATH_EN	0x00000040
 
+#define	MPC10X_CFG_PICR2_REG		0xac
+#define	MPC10X_CFG_PICR2_COPYBACK_OPT	0x00000001
+
 #define	MPC10X_CFG_MAPB_OPTIONS_REG	0xe0
 #define	MPC10X_CFG_MAPB_OPTIONS_CFAE	0x80	/* CPU_FD_ALIAS_EN */
 #define	MPC10X_CFG_MAPB_OPTIONS_PFAE	0x40	/* PCI_FD_ALIAS_EN */

--------------020707020608070004000400--
