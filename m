Return-Path: <Xiaotian.Feng@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id F1DE9DE034
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 11:49:41 +1000 (EST)
From: Xiaotian Feng <Xiaotian.Feng@windriver.com>
To: galak@kernel.crashing.org, davem@davemloft.net, netdev@vger.kernel.org
Subject: [PATCH net] gianfar: fix babbling rx error event bug
Date: Wed, 27 May 2009 09:52:36 +0800
Message-Id: <1243389156-1668-1-git-send-email-Xiaotian.Feng@windriver.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gianfar interrupt handler uses IEVENT_ERR_MASK to check and handle errors.
Babbling RX error (IEVENT_BABR) should be included in IEVENT_ERROR_MASK.
Otherwise if BABR is raised, it never gets handled nor cleared, and an
interrupt storm results. This has been observed to happen on sending a
burst of ethernet frames to a gianfar based board.

Signed-off-by: Xiaotian Feng <xiaotian.feng@windriver.com>
---
 drivers/net/gianfar.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/gianfar.h b/drivers/net/gianfar.h
index 0642d52..cf35296 100644
--- a/drivers/net/gianfar.h
+++ b/drivers/net/gianfar.h
@@ -259,7 +259,7 @@ extern const char gfar_driver_version[];
 (IEVENT_RXC | IEVENT_BSY | IEVENT_EBERR | IEVENT_MSRO | \
  IEVENT_BABT | IEVENT_TXC | IEVENT_TXE | IEVENT_LC \
  | IEVENT_CRL | IEVENT_XFUN | IEVENT_DPE | IEVENT_PERR \
- | IEVENT_MAG)
+ | IEVENT_MAG | IEVENT_BABR)
 
 #define IMASK_INIT_CLEAR	0x00000000
 #define IMASK_BABR              0x80000000
-- 
1.5.5.1
