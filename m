Return-Path: <chrisp@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDK2S0ryMzDq8b
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 10:23:59 +1100 (AEDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: linux-edac@vger.kernel.org,
	morbidrsa@gmail.com
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Borislav Petkov <bp@alien8.de>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] EDAC: mpc85xx: Add T2080 l2-cache support
Date: Thu,  2 Feb 2017 12:16:24 +1300
Message-Id: <20170201231624.28843-1-chris.packham@alliedtelesis.co.nz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The l2-cache controller on the T2080 SoC has similar capabilities to the
others already supported by the mpc85xx_edac driver. Add it to the list
of compatible devices.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Acked-by: Johannes Thumshirn <jth@kernel.org>
---
This is a resend of a patch that got an ack[1] but didn't seem to get
picked up.

[1] http://marc.info/?l=linux-edac&m=148042072225488&w=2

Changes since v1:
- Collect ack from Johannes.

 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi | 1 +
 drivers/edac/mpc85xx_edac.c                 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
index c744569a20e1..a97296c64eb2 100644
--- a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
@@ -678,5 +678,6 @@
 		compatible = "fsl,t2080-l2-cache-controller";
 		reg = <0xc20000 0x40000>;
 		next-level-cache = <&cpc>;
+		interrupts = <16 2 1 9>;
 	};
 };
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 8f66cbed70b7..67f7bc3fe5b3 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -629,6 +629,7 @@ static const struct of_device_id mpc85xx_l2_err_of_match[] = {
 	{ .compatible = "fsl,p1020-l2-cache-controller", },
 	{ .compatible = "fsl,p1021-l2-cache-controller", },
 	{ .compatible = "fsl,p2020-l2-cache-controller", },
+	{ .compatible = "fsl,t2080-l2-cache-controller", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mpc85xx_l2_err_of_match);
-- 
2.11.0.24.ge6920cf
