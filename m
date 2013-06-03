Return-Path: <Ian.Campbell@citrix.com>
Received: from SMTP.EU.CITRIX.COM (smtp.eu.citrix.com [46.33.159.39])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "Cisco Appliance Demo Certificate",
 Issuer "Cisco Appliance Demo Certificate" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5D8C02C02EC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jun 2013 21:00:44 +1000 (EST)
From: Ian Campbell <ian.campbell@citrix.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/dts/virtex440: declare address/size-cells for phy
 device
Date: Mon, 3 Jun 2013 12:00:41 +0100
Message-ID: <1370257241-23923-1-git-send-email-ian.campbell@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Ian Campbell <ian.campbell@citrix.com>, Gernot Vormayr <gvormayr@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes a warning:

  DTC     arch/powerpc/boot/virtex440-ml507.dtb
Warning (reg_format): "reg" property in /plb@0/xps-ll-temac@81c00000/ethernet@81c00000/phy@7 has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Warning (avoid_default_addr_size): Relying on default #address-cells value for /plb@0/xps-ll-temac@81c00000/ethernet@81c00000/phy@7
Warning (avoid_default_addr_size): Relying on default #size-cells value for /plb@0/xps-ll-temac@81c00000/ethernet@81c00000/phy@7

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Gernot Vormayr <gvormayr@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/boot/dts/virtex440-ml507.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/boot/dts/virtex440-ml507.dts b/arch/powerpc/boot/dts/virtex440-ml507.dts
index fc7073b..391a4e2 100644
--- a/arch/powerpc/boot/dts/virtex440-ml507.dts
+++ b/arch/powerpc/boot/dts/virtex440-ml507.dts
@@ -257,6 +257,8 @@
 			#size-cells = <1>;
 			compatible = "xlnx,compound";
 			ethernet@81c00000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
 				compatible = "xlnx,xps-ll-temac-1.01.b";
 				device_type = "network";
 				interrupt-parent = <&xps_intc_0>;
-- 
1.7.10.4
