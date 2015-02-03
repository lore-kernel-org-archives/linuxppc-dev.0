Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC0641A0B77
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 16:36:01 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 agraf@suse.de
Subject: [PATCH 3/5] powerpc: Remove arch specific byteswappers from the MXC
 MMC driver
Date: Tue,  3 Feb 2015 16:36:23 +1100
Message-Id: <1422941785-22557-4-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1422941785-22557-1-git-send-email-david@gibson.dropbear.id.au>
References: <1422941785-22557-1-git-send-email-david@gibson.dropbear.id.au>
Cc: Sascha Hauer <kernel@pengutronix.de>, aik@ozlabs.ru,
 linux-kernel@vger.kernel.org, mdroth@us.ibm.com,
 Shawn Guo <shawn.guo@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the MXC MMUC driver is used on a Freescale MPC512x machine, it
contains some additional byteswapping code (I'm assuming this is a
workaround for a hardware defect).  This uses the ppc specific st_le32()
function, but there's no reason not to use the generic swab32() function
instead.  gcc is capable of generating the efficient ppc byte-reversing
load/store instructions without the arch-specific helper.

This patch, therefore, switches to the generic byteswap routine.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 drivers/mmc/host/mxcmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 5316d9b..317d709 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -281,7 +281,7 @@ static inline void buffer_swap32(u32 *buf, int len)
 	int i;
 
 	for (i = 0; i < ((len + 3) / 4); i++) {
-		st_le32(buf, *buf);
+		*buf = swab32(*buf);
 		buf++;
 	}
 }
-- 
2.1.0
