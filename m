Return-Path: <qiang.zhao@nxp.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0081.outbound.protection.outlook.com [207.46.100.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE8AD1A0B57
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 18:18:49 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <robh+dt@kernel.org>
CC: <oss@buserror.net>, <leoyang.li@nxp.com>, <xiaobo.xie@nxp.com>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH v3 2/7] QE: Add ucc hdlc document to bindings
Date: Tue, 1 Mar 2016 15:09:38 +0800
Message-ID: <1456816183-22340-2-git-send-email-qiang.zhao@nxp.com>
In-Reply-To: <1456816183-22340-1-git-send-email-qiang.zhao@nxp.com>
References: <1456816183-22340-1-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add ucc hdlc document to
Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
Changes for v2
	- use ucc-hdlc instead of ucc_hdlc
	- add more information to properties.
Changes for v3
	- use fsl,tx-timeslot-mask instead of fsl,tx-timeslot 
	- use fsl,rx-timeslot-mask instead of fsl,rx-timeslot 
	- add more info

 .../bindings/powerpc/fsl/cpm_qe/network.txt        | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt
index 29b28b8..03c7416 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt
@@ -41,3 +41,84 @@ Example:
 		fsl,mdio-pin = <12>;
 		fsl,mdc-pin = <13>;
 	};
+
+* HDLC
+
+Currently defined compatibles:
+- fsl,ucc-hdlc
+
+Properties for fsl,ucc-hdlc:
+- rx-clock-name
+- tx-clock-name
+	Usage: required
+	Value type: <string>
+	Definition : Must be "brg1"-"brg16" for internal clock source,
+		     Must be "clk1"-"clk24" for external clock source.
+
+- fsl,tdm-interface
+	Usage: optional
+	Value type: <empty>
+	Definition : Specify that hdlc is based on tdm-interface
+
+The property below is dependent on fsl,tdm-interface:
+- fsl,rx-sync-clock
+	Usage: required
+	Value type: <string>
+	Definition : Must be "none", "rsync_pin", "brg9-11" and "brg13-15".
+
+- fsl,tx-sync-clock
+	Usage: required
+	Value type: <string>
+	Definition : Must be "none", "tsync_pin", "brg9-11" and "brg13-15".
+
+- fsl,tdm-framer-type
+	Usage: required for tdm interface
+	Value type: <string>
+	Definition : "e1" or "t1".Now e1 and t1 are used, other framer types
+		     are not supported.
+
+- fsl,tdm-id
+	Usage: required for tdm interface
+	Value type: <u32>
+	Definition : number of TDM ID
+
+- fsl,tx-timeslot-mask
+- fsl,rx-timeslot-mask
+	Usage: required for tdm interface
+	Value type: <u32>
+	Definition : time slot mask for TDM operation. Indicates which time
+		     slots used for transmitting and receiving.
+
+- fsl,siram-entry-id
+	Usage: required for tdm interface
+	Value type: <u32>
+	Definition : Must be 0,2,4...64. the number of TDM entry.
+
+- fsl,tdm-internal-loopback
+	usage: optional for tdm interface
+	value type: <empty>
+	Definition : Internal loopback connecting on TDM layer.
+
+Example for tdm interface:
+
+	ucc@2000 {
+		compatible = "fsl,ucc-hdlc";
+		rx-clock-name = "clk8";
+		tx-clock-name = "clk9";
+		fsl,rx-sync-clock = "rsync_pin";
+		fsl,tx-sync-clock = "tsync_pin";
+		fsl,tx-timeslot-mask = <0xfffffffe>;
+		fsl,rx-timeslot-mask = <0xfffffffe>;
+		fsl,tdm-framer-type = "e1";
+		fsl,tdm-id = <0>;
+		fsl,siram-entry-id = <0>;
+		fsl,tdm-interface;
+	};
+
+Example for hdlc without tdm interface:
+
+	ucc@2000 {
+		compatible = "fsl,ucc-hdlc";
+		rx-clock-name = "brg1";
+		tx-clock-name = "brg1";
+	};
-- 
2.1.0.27.g96db324
