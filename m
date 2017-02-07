Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHdhl2nmHzDqCq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 20:05:11 +1100 (AEDT)
Message-Id: <cover.1486456900.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 0/2] get rid of immrbar_virt_to_phys()
To: Li Yang <leoli@freescale.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Scott Wood <oss@buserror.net>, "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Tue,  7 Feb 2017 10:05:07 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ucc_geth ethernet driver is the only driver using immrbar_virt_to_phys() and it uses it incorrectly.

This patch fixes ucc_geth driver then removes immrbar_virt_to_phys()

Christophe Leroy (2):
  net: ethernet: ucc_geth: fix MEM_PART_MURAM mode
  soc/fsl/qe: get rid of immrbar_virt_to_phys()

 drivers/net/ethernet/freescale/ucc_geth.c |  8 +++-----
 drivers/soc/fsl/qe/qe.c                   |  4 +---
 include/soc/fsl/qe/immap_qe.h             | 19 -------------------
 include/soc/fsl/qe/qe.h                   |  1 +
 4 files changed, 5 insertions(+), 27 deletions(-)

-- 
2.10.1
