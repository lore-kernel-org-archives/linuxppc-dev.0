Return-Path: <mla@apm.com>
Received: from exprod5og116.obsmtp.com (exprod5og116.obsmtp.com [64.18.0.147])
 by ozlabs.org (Postfix) with SMTP id CECCEB6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 14:30:49 +1100 (EST)
Received: by pbcwy12 with SMTP id wy12so2148172pbc.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2012 19:30:47 -0800 (PST)
MIME-Version: 1.0
From: Mai La <mla@apm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>,
 Matt Porter <mporter@kernel.crashing.org>,
 Tirumala R Marri <tmarri@apm.com>,
 Grant Likely <grant.likely@secretlab.ca>,
 Michael Neuling <mikey@neuling.org>,
 Kumar Gala <galak@kernel.crashing.org>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc/44x: Add PCI MSI node for APM821xx SoC and
 Bluestone board in DTS
Date: Tue,  6 Mar 2012 10:30:54 +0700
Message-Id: <1331004654-23888-1-git-send-email-mla@apm.com>
Cc: open-source-review@apm.com, Mai La <mla@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Signed-off-by: Mai La <mla@apm.com>
---
 arch/powerpc/boot/dts/bluestone.dts |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/bluestone.dts b/arch/powerpc/boot/dts/bluestone.dts
index 2a56a0d..8ea6325 100644
--- a/arch/powerpc/boot/dts/bluestone.dts
+++ b/arch/powerpc/boot/dts/bluestone.dts
@@ -250,5 +250,29 @@
 			};
 		};
 
+		MSI: ppc4xx-msi@C10000000 {
+			compatible = "amcc,ppc4xx-msi", "ppc4xx-msi";
+			reg = < 0xC 0x10000000 0x100
+				0xC 0x10000000 0x100>;
+			sdr-base = <0x36C>;
+			msi-data = <0x00004440>;
+			msi-mask = <0x0000ffe0>;
+			interrupts =<0 1 2 3 4 5 6 7>;
+			interrupt-parent = <&MSI>;
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			msi-available-ranges = <0x0 0x100>;
+			interrupt-map = <
+				0 &UIC3 0x18 1
+				1 &UIC3 0x19 1
+				2 &UIC3 0x1A 1
+				3 &UIC3 0x1B 1
+				4 &UIC3 0x1C 1
+				5 &UIC3 0x1D 1
+				6 &UIC3 0x1E 1
+				7 &UIC3 0x1F 1
+			>;
+		};
 	};
 };
-- 
1.7.3.4
