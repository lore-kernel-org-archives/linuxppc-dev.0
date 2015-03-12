Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0103.outbound.protection.outlook.com [65.55.169.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D66B21A0198
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 14:14:46 +1100 (AEDT)
From: Scott Wood <scottwood@freescale.com>
To: <trivial@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/22] powerpc/32: %pF is only for function pointers
Date: Wed, 11 Mar 2015 22:13:46 -0500
Message-ID: <1426130037-17956-11-git-send-email-scottwood@freescale.com>
In-Reply-To: <1426130037-17956-1-git-send-email-scottwood@freescale.com>
References: <1426130037-17956-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use %pS for actual addresses, otherwise you'll get bad output
on arches like ppc64 where %pF expects a function descriptor.  Even on
other architectures, refrain from setting a bad example that people
copy.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/mm/pgtable_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 03b1a3b..24f304a 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -221,7 +221,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 	 */
 	if (mem_init_done && (p < virt_to_phys(high_memory)) &&
 	    !(__allow_ioremap_reserved && memblock_is_region_reserved(p, size))) {
-		printk("__ioremap(): phys addr 0x%llx is RAM lr %pf\n",
+		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
 		       (unsigned long long)p, __builtin_return_address(0));
 		return NULL;
 	}
-- 
2.1.0
