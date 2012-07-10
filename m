Return-Path: <B32616@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C88B32C020A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 16:17:55 +1000 (EST)
From: Qiang Liu <qiang.liu@freescale.com>
To: <linux-crypto@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 0/3] Raid: enable talitos xor offload for improving performance
Date: Tue, 10 Jul 2012 13:56:45 +0800
Message-ID: <1341899809-20630-1-git-send-email-qiang.liu@freescale.com>
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

The following 4 patches enabling fsl-dma and talitos offload raid
operations for improving raid performance and balancing CPU load.

Write performance will be improved by 40% tested by iozone. CPU load
will be reduced by 8%.

Qiang Liu (4):
      Talitos: move the data structure into header file
      Talitos: Support for async_tx XOR offload
      fsl-dma: support attribute of DMA_MEMORY when async_tx enabled
      Talitos: fix the issue of dma memory leak

 drivers/crypto/Kconfig   |    9 +
 drivers/crypto/talitos.c |  520 ++++++++++++++++++++++++++++++++++++----------
 drivers/crypto/talitos.h |  161 ++++++++++++++
 drivers/dma/fsldma.c     |   78 +++-----
 4 files changed, 606 insertions(+), 162 deletions(-)
