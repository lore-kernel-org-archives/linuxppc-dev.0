Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 41K0Zn4sqFzF1LQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2018 18:21:21 +1000 (AEST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>
Message-Id: <720e9899186bed184fb9b5cce070e2dc519f9665.1530519301.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1530519301.git.fthain@telegraphics.com.au>
References: <cover.1530519301.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v4 01/11] macintosh/via-pmu: Fix section mismatch warning
Date: Mon,  2 Jul 2018 04:21:18 -0400 (EDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pmu_init() function has the __init qualifier, but the ops struct
that holds a pointer to it does not. This causes a build warning.
The driver works fine because the pointer is only dereferenced early.

The function is so small that there's negligible benefit from using
the __init qualifier. Remove it to fix the warning, consistent with
the other ADB drivers.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/macintosh/via-pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 25c1ce811053..f8a2c917201f 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -378,7 +378,7 @@ static int pmu_probe(void)
 	return vias == NULL? -ENODEV: 0;
 }
 
-static int __init pmu_init(void)
+static int pmu_init(void)
 {
 	if (vias == NULL)
 		return -ENODEV;
-- 
2.16.4
