Return-Path: <qiang.zhao@nxp.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0059.outbound.protection.outlook.com [207.46.100.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B271A0358
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 12:29:37 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <robh+dt@kernel.org>
CC: <oss@buserror.net>, <leoyang.li@nxp.com>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, Zhao Qiang
 <qiang.zhao@nxp.com>
Subject: [PATCH v2 2/7] QE: Add ucc hdlc document to bindings
Date: Thu, 18 Feb 2016 09:06:07 +0800
Message-ID: <1455757572-44955-2-git-send-email-qiang.zhao@nxp.com>
In-Reply-To: <1455757572-44955-1-git-send-email-qiang.zhao@nxp.com>
References: <1455757572-44955-1-git-send-email-qiang.zhao@nxp.com>
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

 .../bindings/powerpc/fsl/cpm_qe/network.txt        | 93 ++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt
index 29b28b8..936158c 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt
@@ -41,3 +41,96 @@ Example:
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
+	Definition : should be "brg1"-"brg16" for internal clock source,
+		     should be "clk1"-"clk28" for external clock source.
+
+- fsl,rx-sync-clock
+	Usage: required
+	Value type: <string>
+	Definition : should be "none" when using internal clock source,
+		     should be "rsync_pin" when using external clock source.
+
+- fsl,tx-sync-clock
+	Usage: required
+	Value type: <string>
+	Definition : should be "none" when using internal clock source,
+		     should be "tsync_pin" when using external clock source.
+
+- fsl,tx-timeslot
+- fsl,rx-timeslot
+	Usage: required
+	Value type: <u32>
+	Definition : time slot for TDM operation. Indicates which time slots
+		     used for transmitting and receiving.
+
+- fsl,tdm-framer-type
+	Usage: required
+	Value type: <string>
+	Definition : "e1" or "t1"
+
+- fsl,tdm-mode
+	Usage: required
+	Value type: <string>
+	Definition : "normal" or "internal-loopback"
+
+- fsl,tdm-id
+	Usage: required
+	Value type: <u32>
+	Definition : number of TDM ID
+
+- fsl,siram-entry-id
+	Usage: required
+	Value type: <u32>
+	Definition : should be 0,2,4...64. the number of TDM entry.
+
+- fsl,tdm-interface
+	Usage: optional
+	Value type: <empty>
+	Definition : Specify that hdlc is based on tdm-interface
+
+Example:
+
+	ucc@2000 {
+		compatible = "fsl,ucc-hdlc";
+		rx-clock-name = "clk8";
+		tx-clock-name = "clk9";
+		fsl,rx-sync-clock = "rsync_pin";
+		fsl,tx-sync-clock = "tsync_pin";
+		fsl,tx-timeslot = <0xfffffffe>;
+		fsl,rx-timeslot = <0xfffffffe>;
+		fsl,tdm-framer-type = "e1";
+		fsl,tdm-mode = "normal";
+		fsl,tdm-id = <0>;
+		fsl,siram-entry-id = <0>;
+		fsl,tdm-interface;
+	};
+fsl,siram-entry-id : SI RAM entry ID for the TDM
+fsl,tdm-interface : hdlc is based on tdm-interface
+
+Example:
+
+	ucc@2000 {
+		compatible = "fsl,ucc-hdlc";
+		rx-clock-name = "clk8";
+		tx-clock-name = "clk9";
+		fsl,rx-sync-clock = "rsync_pin";
+		fsl,tx-sync-clock = "tsync_pin";
+		fsl,tx-timeslot = <0xfffffffe>;
+		fsl,rx-timeslot = <0xfffffffe>;
+		fsl,tdm-framer-type = "e1";
+		fsl,tdm-mode = "normal";
+		fsl,tdm-id = <0>;
+		fsl,siram-entry-id = <0>;
+		fsl,tdm-interface;
+	};
-- 
2.1.0.27.g96db324
