Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znCyj21LjzDrLP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 23:17:00 +1100 (AEDT)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linux-mm@kvack.org, Joel Stanley <joel@jms.id.au>,
 Christophe LEROY <christophe.leroy@c-s.fr>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/5] powerpc/mm/32: Use page_is_ram to check for RAM
Date: Thu, 22 Feb 2018 13:15:14 +0100
Message-Id: <20180222121516.23415-4-j.neuschaefer@gmx.net>
In-Reply-To: <20180222121516.23415-1-j.neuschaefer@gmx.net>
References: <20180222121516.23415-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/powerpc/mm/pgtable_32.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index d35d9ad3c1cd..d54e1a9c1c99 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -145,9 +145,8 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 #ifndef CONFIG_CRASH_DUMP
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using.
-	 * mem_init() sets high_memory so only do the check after that.
 	 */
-	if (slab_is_available() && (p < virt_to_phys(high_memory)) &&
+	if (page_is_ram(__phys_to_pfn(p)) &&
 	    !(__allow_ioremap_reserved && memblock_is_region_reserved(p, size))) {
 		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
 		       (unsigned long long)p, __builtin_return_address(0));
-- 
2.16.1
