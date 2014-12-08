Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9798E1A0A0D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 21:40:31 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0109.outbound.protection.outlook.com [157.56.110.109])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A214B1400A0
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Dec 2014 21:40:30 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <linuxppc-dev@ozlabs.org>,
 <devicetree@vger.kernel.org>
Subject: [PATCH v5 0/6] powerpc/mpc85xx: Add FSL QorIQ DPAA B/QMan support to
 device tree(s)
Date: Mon, 8 Dec 2014 04:29:15 -0600
Message-ID: <1418034561-12034-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v5:	Fix the alloc-ranges property
	Factorize the SoC specific reserved-memory properties

v4:	Add binding for the portals phandle
	Fix portals phandle

v3:	Remove no-map
	Adjust alloc-ranges for the 32-/36-bit SoC(s)

v2:	Remove some reserved-memory properties
	Split the patchset per IP block
	Refined patch assignment

Emil Medve (2):
  dt/bindings: b/qman: Fix the alloc-ranges in the example(s)
  dt/bindings: b/qman: Add phandle to the portals

Kumar Gala (4):
  powerpc/mpc85xx: Create dts components for the FSL QorIQ DPAA BMan
  powerpc/mpc85xx: Create dts components for the FSL QorIQ DPAA QMan
  powerpc/mpc85xx: Add FSL QorIQ DPAA BMan support to device tree(s)
  powerpc/mpc85xx: Add FSL QorIQ DPAA QMan support to device tree(s)

 Documentation/devicetree/bindings/soc/fsl/bman.txt |  12 +-
 Documentation/devicetree/bindings/soc/fsl/qman.txt |  14 +-
 arch/powerpc/boot/dts/b4qds.dtsi                   |  29 +-
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi        | 129 ++++-
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi           | 195 ++++++-
 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi        |  80 ++-
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |  24 +-
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |  24 +-
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        |  24 +-
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |  24 +-
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |  24 +-
 arch/powerpc/boot/dts/fsl/qoriq-bman1-portals.dtsi |  90 ++++
 arch/powerpc/boot/dts/fsl/qoriq-bman1.dtsi         |  41 ++
 arch/powerpc/boot/dts/fsl/qoriq-qman1-portals.dtsi | 101 ++++
 arch/powerpc/boot/dts/fsl/qoriq-qman1.dtsi         |  41 ++
 arch/powerpc/boot/dts/fsl/qoriq-qman3.dtsi         |  41 ++
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        | 143 ++++-
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi        | 231 +++++++-
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        | 583 ++++++++++++++++++++-
 arch/powerpc/boot/dts/kmcoge4.dts                  |  27 +
 arch/powerpc/boot/dts/oca4080.dts                  |  27 +
 arch/powerpc/boot/dts/p1023rdb.dts                 |  30 +-
 arch/powerpc/boot/dts/p2041rdb.dts                 |  29 +-
 arch/powerpc/boot/dts/p3041ds.dts                  |  29 +-
 arch/powerpc/boot/dts/p4080ds.dts                  |  29 +-
 arch/powerpc/boot/dts/p5020ds.dts                  |  29 +-
 arch/powerpc/boot/dts/p5040ds.dts                  |  29 +-
 arch/powerpc/boot/dts/t104xqds.dtsi                |  29 +-
 arch/powerpc/boot/dts/t104xrdb.dtsi                |  26 +
 arch/powerpc/boot/dts/t208xqds.dtsi                |  29 +-
 arch/powerpc/boot/dts/t208xrdb.dtsi                |  27 +
 arch/powerpc/boot/dts/t4240qds.dts                 |  29 +-
 arch/powerpc/boot/dts/t4240rdb.dts                 |  27 +
 33 files changed, 2221 insertions(+), 25 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-bman1-portals.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-bman1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-qman1-portals.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-qman1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-qman3.dtsi

-- 
2.2.0
