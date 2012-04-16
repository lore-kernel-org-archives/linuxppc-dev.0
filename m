Return-Path: <B21284@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2A556B6FFA
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2012 12:20:08 +1000 (EST)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/4] powerpc/mpic_msgr: fix offset error when setting mer
 register
Date: Mon, 16 Apr 2012 10:05:07 +0800
Message-ID: <1334541908-19331-3-git-send-email-Mingkai.hu@freescale.com>
In-Reply-To: <1334541908-19331-2-git-send-email-Mingkai.hu@freescale.com>
References: <1334541908-19331-1-git-send-email-Mingkai.hu@freescale.com>
 <1334541908-19331-2-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mingkai Hu <Mingkai.hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
---
 arch/powerpc/sysdev/mpic_msgr.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic_msgr.c b/arch/powerpc/sysdev/mpic_msgr.c
index dc1cfe3..483d8fa 100644
--- a/arch/powerpc/sysdev/mpic_msgr.c
+++ b/arch/powerpc/sysdev/mpic_msgr.c
@@ -228,7 +228,7 @@ static __devinit int mpic_msgr_probe(struct platform_device *dev)
 
 		reg_number = block_number * MPIC_MSGR_REGISTERS_PER_BLOCK + i;
 		msgr->base = msgr_block_addr + i * MPIC_MSGR_STRIDE;
-		msgr->mer = msgr->base + MPIC_MSGR_MER_OFFSET;
+		msgr->mer = (u32 *)((u8 *)msgr->base + MPIC_MSGR_MER_OFFSET);
 		msgr->in_use = MSGR_FREE;
 		msgr->num = i;
 		raw_spin_lock_init(&msgr->lock);
-- 
1.7.5.1
