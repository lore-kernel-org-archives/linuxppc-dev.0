Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-lb0-f171.google.com (mail-lb0-f171.google.com
 [209.85.217.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 171A81A0666
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 08:06:56 +1100 (AEDT)
Received: by lbcao8 with SMTP id ao8so126084615lbc.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2015 14:06:52 -0700 (PDT)
From: Alexander Popov <alex.popov@linux.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anatolij Gustschin <agust@denx.de>, Rob Herring <robh@kernel.org>,
 Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, Alexander Popov <alex.popov@linux.com>,
 linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] powerpc/512x: add LocalPlus Bus FIFO device driver
Date: Mon, 12 Oct 2015 00:08:00 +0300
Message-Id: <1444597682-22181-1-git-send-email-alex.popov@linux.com>
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
    alias "alex.popov@linux.com".

Changes in v4:
 - the race condition is fixed;
 - plenty of style fixes are made;
 - devm_* functions and EPROBE_DEFER are used in probe().

Alexander Popov (2):
  powerpc/512x: add LocalPlus Bus FIFO device driver
  powerpc/512x: add a device tree binding for LocalPlus Bus FIFO

 .../bindings/powerpc/fsl/mpc512x_lpbfifo.txt       |  21 +
 arch/powerpc/boot/dts/mpc5121.dtsi                 |  11 +-
 arch/powerpc/boot/dts/mpc5125twr.dts               |  11 +-
 arch/powerpc/configs/mpc512x_defconfig             |   1 +
 arch/powerpc/include/asm/mpc5121.h                 |  59 +++
 arch/powerpc/platforms/512x/Kconfig                |   6 +
 arch/powerpc/platforms/512x/Makefile               |   1 +
 arch/powerpc/platforms/512x/mpc512x_lpbfifo.c      | 539 +++++++++++++++++++++
 8 files changed, 646 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/mpc512x_lpbfifo.txt
 create mode 100644 arch/powerpc/platforms/512x/mpc512x_lpbfifo.c

-- 
1.9.1
