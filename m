Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 12DF0B7BA1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 09:38:21 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 3B6B0DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 09:38:20 +1000 (EST)
Date: Wed, 19 Aug 2009 03:38:18 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2] powerpc/85xx: Add eSDHC support for MPC8536DS boards
Message-ID: <20090818233818.GA29042@oksana.dev.rtsoft.ru>
References: <20090807195724.GA24020@oksana.dev.rtsoft.ru>
	<20090807195822.GG2735@oksana.dev.rtsoft.ru>
	<A17F24A0-87E0-4FFA-9C14-DF57D8A9D015@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <A17F24A0-87E0-4FFA-9C14-DF57D8A9D015@kernel.crashing.org>
Cc: Ben Dooks <ben@fluff.org>, linux-kernel@vger.kernel.org,
	sdhci-devel@lists.ossman.eu, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Pierre Ossman <pierre@ossman.eu>, David Vrabel <david.vrabel@csr.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch simply adds sdhci node to the device tree.

We specify clock-frequency manually, so that eSDHC will work without
upgrading U-Boot. Though, that'll only work for default setup (1500
MHz) on new board revisions. For non-default setups, it's recommended
to upgrade U-Boot, since it will fixup clock-frequency automatically.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Tue, Aug 11, 2009 at 08:48:32AM -0500, Kumar Gala wrote:
> On Aug 7, 2009, at 2:58 PM, Anton Vorontsov wrote:
> >This patch simply adds sdhci node to the device tree.
> >
> >We specify clock-frequency manually, so that eSDHC will work without
> >upgrading U-Boot. Though, that'll only work for default setup (1500
> >MHz) on new board revisions. For non-default setups, it's recommended
> >to upgrade U-Boot, since it will fixup clock-frequency automatically.
> >
> >Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> >---
> >arch/powerpc/boot/dts/mpc8536ds.dts |    8 ++++++++
> >1 files changed, 8 insertions(+), 0 deletions(-)
> 
> Can you update the mpc8536ds_36b.dts as well (its in my next branch)

Sure thing.

 arch/powerpc/boot/dts/mpc8536ds.dts     |    8 ++++++++
 arch/powerpc/boot/dts/mpc8536ds_36b.dts |    8 ++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/mpc8536ds.dts
index 22caf69..815cebb 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds.dts
@@ -250,6 +250,14 @@
 			phy_type = "ulpi";
 		};
 
+		sdhci@2e000 {
+			compatible = "fsl,mpc8536-esdhc", "fsl,esdhc";
+			reg = <0x2e000 0x1000>;
+			interrupts = <72 0x2>;
+			interrupt-parent = <&mpic>;
+			clock-frequency = <250000000>;
+		};
+
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
diff --git a/arch/powerpc/boot/dts/mpc8536ds_36b.dts b/arch/powerpc/boot/dts/mpc8536ds_36b.dts
index 113ed8b..d95b260 100644
--- a/arch/powerpc/boot/dts/mpc8536ds_36b.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds_36b.dts
@@ -250,6 +250,14 @@
 			phy_type = "ulpi";
 		};
 
+		sdhci@2e000 {
+			compatible = "fsl,mpc8536-esdhc", "fsl,esdhc";
+			reg = <0x2e000 0x1000>;
+			interrupts = <72 0x2>;
+			interrupt-parent = <&mpic>;
+			clock-frequency = <250000000>;
+		};
+
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-- 
1.6.3.3
