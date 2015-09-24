Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
 [209.85.215.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFE5E1A0026
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 03:27:53 +1000 (AEST)
Received: by lacao8 with SMTP id ao8so71640180lac.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 10:27:50 -0700 (PDT)
From: Alexander Popov <alex.popov@linux.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anatolij Gustschin <agust@denx.de>, Gerhard Sittig <gsi@denx.de>,
 Rob Herring <robh@kernel.org>, Timur Tabi <timur@tabi.org>,
 Grant Likely <grant.likely@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, Alexander Popov <alex.popov@linux.com>,
 linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] powerpc/512x: add LocalPlus Bus FIFO device driver
Date: Thu, 24 Sep 2015 20:28:54 +0300
Message-Id: <1443115737-3948-1-git-send-email-alex.popov@linux.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This driver for Freescale MPC512x LocalPlus Bus FIFO (called SCLPC
in the Reference Manual) allows Direct Memory Access transfers
between RAM and peripheral devices on LocalPlus Bus.

Changes in v3:
 - resource usage in probe() is fixed;
 - driver methods are made safe against remove();
 - dma_request_slave_channel() is used to get DMA channel number from
    the device tree;
 - chip select number concerned with the DMA transaction is determined
    from 'localbus' device tree node information;
 - register set is described as a structure;
 - symbolic names are given to shift counts to keep magic numbers
    out of the code;
 - choosing values for LPBFIFO BPT (bytes per transfer) and DMA maxburst
    is improved, so DMA transfer size has increased for some cases;
 - device tree binding for LPBFIFO is documented;
 - Kconfig and Makefile are improved;
 - email address "a13xp0p0v88@gmail.com" is changed to a more pleasant
    alias "alex.popov@linux.com";

Alexander Popov (3):
  powerpc/512x: add LocalPlus Bus FIFO device driver
  powerpc/512x: add a device tree binding for LocalPlus Bus FIFO
  dmaengine: mpc512x: initialize with subsys_initcall()

 .../bindings/powerpc/fsl/mpc512x_lpbfifo.txt       |  21 +
 arch/powerpc/boot/dts/mpc5121.dtsi                 |  11 +-
 arch/powerpc/boot/dts/mpc5125twr.dts               |  11 +-
 arch/powerpc/configs/mpc512x_defconfig             |   1 +
 arch/powerpc/include/asm/mpc5121.h                 |  59 +++
 arch/powerpc/platforms/512x/Kconfig                |   6 +
 arch/powerpc/platforms/512x/Makefile               |   1 +
 arch/powerpc/platforms/512x/mpc512x_lpbfifo.c      | 560 +++++++++++++++++++++
 drivers/dma/mpc512x_dma.c                          |  12 +-
 9 files changed, 678 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/mpc512x_lpbfifo.txt
 create mode 100644 arch/powerpc/platforms/512x/mpc512x_lpbfifo.c

-- 
1.9.1
