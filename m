Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A45C9DE4EA
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 10:56:59 +1100 (EST)
Date: Wed, 7 Jan 2009 10:56:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: use correct type in prom_init.c
Message-Id: <20090107105652.0931ae41.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Ingo Molnar <mingo@elte.hu>

tce_entryp is a "u64 *" not an "unsigned long *".

[Split from a large patch -sfr]
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/prom_init.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 2445945..7f1b33d 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1210,7 +1210,7 @@ static void __init prom_initialize_tce_table(void)
 		/* Initialize the table to have a one-to-one mapping
 		 * over the allocated size.
 		 */
-		tce_entryp = (unsigned long *)base;
+		tce_entryp = (u64 *)base;
 		for (i = 0; i < (minsize >> 3) ;tce_entryp++, i++) {
 			tce_entry = (i << PAGE_SHIFT);
 			tce_entry |= 0x3;
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
