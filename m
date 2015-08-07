Return-Path: <a.hajda@samsung.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DE561A0021
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 18:10:34 +1000 (AEST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NSP00A8YCWQ0H40@mailout2.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 07 Aug 2015 09:00:26 +0100 (BST)
From: Andrzej Hajda <a.hajda@samsung.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrzej Hajda <a.hajda@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/31] arch/powerpc/nvram: use kmemdup rather than duplicating
 its implementation
Date: Fri, 07 Aug 2015 09:59:11 +0200
Message-id: <1438934377-4922-6-git-send-email-a.hajda@samsung.com>
In-reply-to: <1438934377-4922-1-git-send-email-a.hajda@samsung.com>
References: <1438934377-4922-1-git-send-email-a.hajda@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch was generated using fixed coccinelle semantic patch
scripts/coccinelle/api/memdup.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2014320

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 arch/powerpc/kernel/nvram_64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 1e703f8..6f6597b 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -541,10 +541,9 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
 			time->tv_sec = be64_to_cpu(oops_hdr->timestamp);
 			time->tv_nsec = 0;
 		}
-		*buf = kmalloc(length, GFP_KERNEL);
+		*buf = kmemdup(buff + hdr_size, length, GFP_KERNEL);
 		if (*buf == NULL)
 			return -ENOMEM;
-		memcpy(*buf, buff + hdr_size, length);
 		kfree(buff);
 
 		if (err_type == ERR_TYPE_KERNEL_PANIC_GZ)
-- 
1.9.1
