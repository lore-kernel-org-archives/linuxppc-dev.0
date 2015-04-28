Return-Path: <cmetcalf@ezchip.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0090.outbound.protection.outlook.com [157.55.234.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9BCA51A0211
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 00:57:48 +1000 (AEST)
From: Chris Metcalf <cmetcalf@ezchip.com>
To: "Geert Uytterhoeven <geert@linux-m68k.org> Rusty Russell"
 <rusty@rustcorp.com.au>
Subject: [PATCH] tile: properly use node_isset() on a nodemask_t
Date: Tue, 28 Apr 2015 10:41:47 -0400
Message-ID: <1430232107-15041-1-git-send-email-cmetcalf@ezchip.com>
In-Reply-To: <CAMuHMdXEH6ZnTSdBi2uJzPriqTLvJvd0bPYH3NPWV5LjZB5S=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI
 Development <dri-devel@lists.freedesktop.org>,
 Chris Metcalf <cmetcalf@ezchip.com>, Mark Brown <broonie@kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>,
 Matthew Wilcox <willy@linux.intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The code accidentally used cpu_isset() previously in one place
(though properly node_isset() elsewhere).

Signed-off-by: Chris Metcalf <cmetcalf@ezchip.com>
---
 arch/tile/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/tile/kernel/setup.c b/arch/tile/kernel/setup.c
index 6873f006f7d0..d366675e4bf8 100644
--- a/arch/tile/kernel/setup.c
+++ b/arch/tile/kernel/setup.c
@@ -774,7 +774,7 @@ static void __init zone_sizes_init(void)
 		 * though, there'll be no lowmem, so we just alloc_bootmem
 		 * the memmap.  There will be no percpu memory either.
 		 */
-		if (i != 0 && cpumask_test_cpu(i, &isolnodes)) {
+		if (i != 0 && node_isset(i, isolnodes)) {
 			node_memmap_pfn[i] =
 				alloc_bootmem_pfn(0, memmap_size, 0);
 			BUG_ON(node_percpu[i] != 0);
-- 
2.1.2
