Return-Path: <bharat.bhushan@nxp.com>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30087.outbound.protection.outlook.com [40.107.3.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cPQS0mZCzDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 19:52:30 +1000 (AEST)
From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 oss@buserror.net, galak@kernel.crashing.org, mark.rutland@arm.com,
 kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: robh@kernel.org, keescook@chromium.org, tyreld@linux.vnet.ibm.com,
 joe@perches.com, Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: [RFC 0/5] powerpc/mpic: Add non-contiguous interrupt sources
Date: Fri, 27 Jul 2018 15:17:56 +0530
Message-Id: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
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

Freescale MPIC h/w may not support all interrupt sources reported
by hardware or "last-interrupt-source" or platform. On these platforms
a misconfigured device tree that assigns one of the reserved
interrupts leaves a non-functioning system without warning.
 
First Patch just moves the last-irq calculation logic to a function,
Second patch reworks same logic, While I feel that device-tree should
 get precedence over platform provided last-irq, but in this series
 I have not changed this logic.
Third and fourth patch add non-contiguous interrupt sources support
Fifth patch enables this for P2020RDB-PC for now.

Bharat Bhushan (5):
  powerpc/mpic: move last irq logic to function
  powerpc/mpic: Rework last source irq calculation logic
  powerpc/mpic: Add support for non-contiguous irq ranges
  powerpc/mpic: Boot print supported interrupt ranges
  powerpc/fsl: Add supported-irq-ranges for P2020

 .../devicetree/bindings/powerpc/fsl/mpic.txt       |   8 +
 arch/powerpc/boot/dts/fsl/p2020si-post.dtsi        |   3 +
 arch/powerpc/include/asm/mpic.h                    |   9 +
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |   5 +
 arch/powerpc/sysdev/mpic.c                         | 184 ++++++++++++++++++---
 5 files changed, 182 insertions(+), 27 deletions(-)

-- 
1.9.3
