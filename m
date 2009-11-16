Return-Path: <dbaryshkov@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.26])
	by ozlabs.org (Postfix) with ESMTP id 886B4B6F29
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 07:51:25 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id 9so1180056eyd.1
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 12:51:23 -0800 (PST)
Date: Mon, 16 Nov 2009 23:51:20 +0300
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4] mpc8349emitx: add OF descriptions of LocalBus devices
Message-ID: <20091116205120.GA22074@doriath.ww600.siemens.net>
References: <1258379934-32352-1-git-send-email-dbaryshkov@gmail.com>
	<1258379934-32352-4-git-send-email-dbaryshkov@gmail.com>
	<20091116193627.GA15505@b07421-ec1.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091116193627.GA15505@b07421-ec1.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Describe all LocalBus chipselects on MPC8349E-MITX board. Also add flash
bindings.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/boot/dts/mpc8349emitx.dts |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 0fb78b2..346d1ba 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -374,7 +374,26 @@
 		compatible = "fsl,mpc8349e-localbus",
 			     "fsl,pq2pro-localbus";
 		reg = <0xe0005000 0xd8>;
-		ranges = <0x3 0x0 0xf0000000 0x210>;
+		ranges = <0x0 0x0 0xfe000000 0x1000000	/* flash */
+			  0x1 0x0 0xf8000000 0x20000	/* VSC 7385 */
+			  0x2 0x0 0xf9000000 0x200000	/* exp slot */
+			  0x3 0x0 0xf0000000 0x210>;	/* CF slot */
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0x0      0x0 0x800000>;
+			bank-width = <2>;
+			device-width = <1>;
+		};
+
+		flash@0,800000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x0 0x800000 0x800000>;
+			bank-width = <2>;
+			device-width = <1>;
+		};
 
 		pata@3,0 {
 			compatible = "fsl,mpc8349emitx-pata", "ata-generic";
-- 
1.6.5

-- 
With best wishes
Dmitry
