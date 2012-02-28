Return-Path: <joe@perches.com>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 (using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AE48FB6FD6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 06:50:38 +1100 (EST)
From: Joe Perches <joe@perches.com>
To: Jiri Kosina <trivial@kernel.org>
Subject: [PATCH trivial next 5/9] powerpc: Use vsprintf extention %pf with
 builtin_return_address
Date: Tue, 28 Feb 2012 10:49:34 -0800
Message-Id: <2dbc648307582b19ab17f899936ab6d0ca456978.1330454853.git.joe@perches.com>
In-Reply-To: <cover.1330454853.git.joe@perches.com>
References: <cover.1330454853.git.joe@perches.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Emit the function name not the address when possible.

builtin_return_address() gives an address.  When building
a kernel with CONFIG_KALLSYMS, emit the actual function
name not the address.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/mm/pgtable_32.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 51f8795..0907f92 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -207,7 +207,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 	 */
 	if (mem_init_done && (p < virt_to_phys(high_memory)) &&
 	    !(__allow_ioremap_reserved && memblock_is_region_reserved(p, size))) {
-		printk("__ioremap(): phys addr 0x%llx is RAM lr %p\n",
+		printk("__ioremap(): phys addr 0x%llx is RAM lr %pf\n",
 		       (unsigned long long)p, __builtin_return_address(0));
 		return NULL;
 	}
-- 
1.7.8.111.gad25c.dirty
