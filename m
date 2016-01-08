Return-Path: <qiang.zhao@nxp.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0072.outbound.protection.outlook.com [65.55.169.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 18F8B1A1A74
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 13:58:25 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
CC: <Priyanka.Jain@freescale.com>, <oss@buserror.net>, Zhao Qiang
 <qiang.zhao@nxp.com>
Subject: [PATCH 2/6] QE: Add ucc hdlc document to bindings
Date: Fri, 8 Jan 2016 10:18:10 +0800
Message-ID: <1452219494-31947-2-git-send-email-qiang.zhao@nxp.com>
In-Reply-To: <1452219494-31947-1-git-send-email-qiang.zhao@nxp.com>
References: <1452219494-31947-1-git-send-email-qiang.zhao@nxp.com>
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
 .../bindings/powerpc/fsl/cpm_qe/network.txt        | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt
index 29b28b8..017cbf7 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt
@@ -41,3 +41,38 @@ Example:
 		fsl,mdio-pin = <12>;
 		fsl,mdc-pin = <13>;
 	};
+
+* HDLC
+
+Currently defined compatibles:
+- fsl,ucc_hdlc
+
+Properties for fsl,ucc_hdlc:
+rx-clock-name : which clock QE use for RX
+tx-clock-name : which clock QE use for TX
+fsl,rx-sync-clock : which pin QE use for RX sync
+fsl,tx-sync-clock : which pin QE use for TX sync
+fsl,tx-timeslot : tx timeslot
+fsl,rx-timeslot : rx timeslot
+fsl,tdm-framer-type : tdm framer type
+fsl,tdm-mode : tdm mode, normal or internal-loopback
+fsl,tdm-id : tdm ID
+fsl,siram-entry-id : SI RAM entry ID for the TDM
+fsl,tdm-interface : hdlc based on tdm-interface
+
+Example:
+
+	ucc@2000 {
+		compatible = "fsl,ucc_hdlc";
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
