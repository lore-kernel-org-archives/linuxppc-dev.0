Return-Path: <B32616@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 119E82C01F1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 19:18:39 +1000 (EST)
From: Qiang Liu <qiang.liu@freescale.com>
To: <linux-crypto@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 0/4] Raid: enable talitos xor offload for improving
 performance
Date: Wed, 11 Jul 2012 16:57:24 +0800
Message-ID: <1341997044-17994-1-git-send-email-qiang.liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: vinod.koul@intel.com, qiang.liu@freescale.com, herbert@gondor.hengli.com.au,
 dan.j.williams@intel.com, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following 4 patches enabling fsl-dma and talitos offload raid
operations for improving raid performance and balancing CPU load.

Write performance will be improved by 40% tested by iozone. CPU load
will be reduced by 8%.

Changes in v2:
	- rebase onto cryptodev tree
	- split the patch 3/4 up to 3 independent patches
	- remove the patch 4/4, the fix is not for cryptodev tree

Qiang Liu (4):
      Talitos: Support for async_tx XOR offload
      fsl-dma: remove attribute DMA_INTERRUPT of dmaengine
      fsl-dma: change the release process of dma descriptor
      fsl-dma: use spin_lock_bh to instead of spin_lock_irqsave

 drivers/crypto/Kconfig   |    9 +
 drivers/crypto/talitos.c |  410 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/crypto/talitos.h |   53 ++++++
 drivers/dma/fsldma.c     |   76 +++------
 4 files changed, 496 insertions(+), 52 deletions(-)
