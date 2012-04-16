Return-Path: <B21284@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe001.messaging.microsoft.com [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8EC7FB6FE3
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2012 12:20:04 +1000 (EST)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/4] powerpc/mpic_msgr: add lock for MPIC message global
 variable
Date: Mon, 16 Apr 2012 10:05:06 +0800
Message-ID: <1334541908-19331-2-git-send-email-Mingkai.hu@freescale.com>
In-Reply-To: <1334541908-19331-1-git-send-email-Mingkai.hu@freescale.com>
References: <1334541908-19331-1-git-send-email-Mingkai.hu@freescale.com>
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

Also fix issue of accessing invalid msgr pointer issue. The local
msgr pointer in fucntion mpic_msgr_get will be accessed before
getting a valid address which will cause kernel crash.

Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
---
 arch/powerpc/sysdev/mpic_msgr.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic_msgr.c b/arch/powerpc/sysdev/mpic_msgr.c
index 6e7fa38..dc1cfe3 100644
--- a/arch/powerpc/sysdev/mpic_msgr.c
+++ b/arch/powerpc/sysdev/mpic_msgr.c
@@ -27,6 +27,7 @@
 
 static struct mpic_msgr **mpic_msgrs;
 static unsigned int mpic_msgr_count;
+static DEFINE_RAW_SPINLOCK(msgrs_lock);
 
 static inline void _mpic_msgr_mer_write(struct mpic_msgr *msgr, u32 value)
 {
@@ -56,12 +57,11 @@ struct mpic_msgr *mpic_msgr_get(unsigned int reg_num)
 	if (reg_num >= mpic_msgr_count)
 		return ERR_PTR(-ENODEV);
 
-	raw_spin_lock_irqsave(&msgr->lock, flags);
-	if (mpic_msgrs[reg_num]->in_use == MSGR_FREE) {
-		msgr = mpic_msgrs[reg_num];
+	raw_spin_lock_irqsave(&msgrs_lock, flags);
+	msgr = mpic_msgrs[reg_num];
+	if (msgr->in_use == MSGR_FREE)
 		msgr->in_use = MSGR_INUSE;
-	}
-	raw_spin_unlock_irqrestore(&msgr->lock, flags);
+	raw_spin_unlock_irqrestore(&msgrs_lock, flags);
 
 	return msgr;
 }
-- 
1.7.5.1
