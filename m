Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 6C1A5DDEEB
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 13:41:13 +1000 (EST)
Date: Wed, 30 Jul 2008 23:41:11 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Josh Boyer
	<jwboyer@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: Incorrect NOR offset in dts
Message-ID: <20080730234111.2fcb631d@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

FPGA offset in NOR flash was converted incorrectly when switching from 
64M to 4M flash.

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/arch/powerpc/boot/dts/warp.dts b/arch/powerpc/boot/dts/warp.dts
index 7300736..f4e4ba6 100644
--- a/arch/powerpc/boot/dts/warp.dts
+++ b/arch/powerpc/boot/dts/warp.dts
@@ -157,7 +157,7 @@
 					#size-cells = <1>;
 					partition@300000 {
 						label = "fpga";
-						reg = <0x0030000 0x00040000>;
+						reg = <0x0300000 0x00040000>;
 					};
 					partition@340000 {
 						label = "env";
