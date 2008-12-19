Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 67674DDF32
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Dec 2008 07:13:33 +1100 (EST)
Date: Fri, 19 Dec 2008 14:13:09 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH] wrapper: Use the child-bus #address-cells to decide which
	range entry to use
Message-ID: <20081219201309.GB2077@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The correct #address-cells was still used for the actual translation,
so the impact is only a possibility of choosing the wrong range entry
or failing to find any match.  Most common cases were not affected.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/devtree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
index 5d12336..a7e21a3 100644
--- a/arch/powerpc/boot/devtree.c
+++ b/arch/powerpc/boot/devtree.c
@@ -213,7 +213,7 @@ static int find_range(u32 *reg, u32 *ranges, int nregaddr,
 		u32 range_addr[MAX_ADDR_CELLS];
 		u32 range_size[MAX_ADDR_CELLS];
 
-		copy_val(range_addr, ranges + i, naddr);
+		copy_val(range_addr, ranges + i, nregaddr);
 		copy_val(range_size, ranges + i + nregaddr + naddr, nsize);
 
 		if (compare_reg(reg, range_addr, range_size))
-- 
1.5.6.rc1.6.gc53ad.dirty
