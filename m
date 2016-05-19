Return-Path: <falakreyaz@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9Xcy12RGzDqBs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 23:54:58 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id g132so8257293pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 06:54:58 -0700 (PDT)
From: Muhammad Falak R Wani <falakreyaz@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "David S. Miller" <davem@davemloft.net>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ps3_gelic: use kmemdup
Date: Thu, 19 May 2016 19:24:41 +0530
Message-Id: <1463666090-16540-1-git-send-email-falakreyaz@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use kmemdup when some other buffer is immediately copied into allocated
region. It replaces call to allocation followed by memcpy, by a single
call to kmemdup.

Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
---
 drivers/net/ethernet/toshiba/ps3_gelic_wireless.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
index 743b182..446ea58 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
@@ -1616,13 +1616,13 @@ static void gelic_wl_scan_complete_event(struct gelic_wl_info *wl)
 		target->valid = 1;
 		target->eurus_index = i;
 		kfree(target->hwinfo);
-		target->hwinfo = kzalloc(be16_to_cpu(scan_info->size),
+		target->hwinfo = kmemdup(scan_info,
+					 be16_to_cpu(scan_info->size),
 					 GFP_KERNEL);
 		if (!target->hwinfo)
 			continue;
 
 		/* copy hw scan info */
-		memcpy(target->hwinfo, scan_info, be16_to_cpu(scan_info->size));
 		target->essid_len = strnlen(scan_info->essid,
 					    sizeof(scan_info->essid));
 		target->rate_len = 0;
-- 
1.9.1
