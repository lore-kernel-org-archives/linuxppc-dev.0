Return-Path: <B45939@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ED5242C00E0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 20:16:11 +1000 (EST)
From: <hongbo.zhang@freescale.com>
To: <rob.herring@calxeda.com>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
 <swarren@wwwdotorg.org>, <ian.campbell@citrix.com>, <vinod.koul@intel.com>,
 <djbw@fb.com>
Subject: [PATCH v10 0/3] DMA: Freescale: Add support for 8-channel DMA engine
Date: Wed, 18 Sep 2013 18:15:30 +0800
Message-ID: <1379499333-4745-1-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Hongbo Zhang <hongbo.zhang@freescale.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hongbo Zhang <hongbo.zhang@freescale.com>

Hi DMA and DT maintainers, please have a look at these V10 patches.

Freescale QorIQ T4 and B4 introduce new 8-channel DMA engines, this patch set
adds support this DMA engine.

V9->V10 changes:
- update binding description text, mainly about the reg property and also Elo3
  DMA controller specification

V8->V9 changes:
- add "Acked-by: Mark Rutland <mark.rutland@arm.com>" into patch [1/3]
- update reg entry <0x100300 0x4 0x100600 0x4> to two seperate ones
  <0x100300 0x4>, <0x100600 0x4> in patch [2/3]
- and also use "QorIQ Elo3 DMA" to mention previous "QorIQ DMA" in [2/3]

V7->V8 changes:
- change the word "mapping" to "specifier" for reg and interrupts description

V6->V7 changes:
- only remove unnecessary "CHIP-dma" explanations in [1/3]

V5->V6 changes:
- minor updates of descriptions in binding document and Kconfig
- remove [4/4], that should be another patch in future

V4->V5 changes:
- update description in the dt binding document, to make it more resonable
- add new patch [4/4] to eliminate a compiling warning which already exists
  for a long time

V3->V4 changes:
- introduce new patch [1/3] to revise the legacy dma binding document
- and then add new paragraph to describe new dt node binding in [2/3]
- rebase to latest kernel v3.11-rc1

V2->V3 changes:
- edit Documentation/devicetree/bindings/powerpc/fsl/dma.txt
- edit text string in Kconfig and the driver files, using "elo series" to
  mention all the current "elo*"

V1->V2 changes:
- removed the codes handling the register dgsr1, since it isn't used currently
- renamed the DMA DT compatible to "fsl,elo3-dma"
- renamed the new dts files to "elo3-dma-<n>.dtsi"

Hongbo Zhang (3):
  DMA: Freescale: revise device tree binding document
  DMA: Freescale: Add new 8-channel DMA engine device tree nodes
  DMA: Freescale: update driver to support 8-channel DMA engine

 .../devicetree/bindings/powerpc/fsl/dma.txt        |  137 ++++++++++++++------
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |    4 +-
 arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi          |   82 ++++++++++++
 arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi          |   82 ++++++++++++
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |    4 +-
 drivers/dma/Kconfig                                |    9 +-
 drivers/dma/fsldma.c                               |    9 +-
 drivers/dma/fsldma.h                               |    2 +-
 8 files changed, 280 insertions(+), 49 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi

-- 
1.7.9.5
