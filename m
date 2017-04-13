Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3gQc2vKGzDqFq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 22:41:44 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: On PPC32, display 32 bits addresses in page table
 dump
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Rashmica Gupta <rashmicy@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170413124140.853856E664@localhost.localdomain>
Date: Thu, 13 Apr 2017 14:41:40 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/dump_linuxpagetables.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index 98b7b07c6863..05109d7fa027 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -271,7 +271,11 @@ static void dump_addr(struct pg_state *st, unsigned long addr)
 	const char *unit = units;
 	unsigned long delta;
 
+#ifdef CONFIG_PPC32
+	seq_printf(st->seq, "0x%08lx-0x%08lx   ", st->start_address, addr - 1);
+#else
 	seq_printf(st->seq, "0x%016lx-0x%016lx   ", st->start_address, addr-1);
+#endif
 	delta = (addr - st->start_address) >> 10;
 	/* Work out what appropriate unit to use */
 	while (!(delta & 1023) && unit[1]) {
-- 
2.12.0
