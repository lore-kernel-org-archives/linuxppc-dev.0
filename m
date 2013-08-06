Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 11/63] powerpc: More little endian fixes for prom.c
Date: Wed,  7 Aug 2013 02:01:28 +1000
Message-Id: <1375804940-22050-12-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alistair Popple <alistair@popple.id.au>

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/kernel/prom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index d072f67..987a4fb 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -456,7 +456,7 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
 	if (dm == NULL || l < sizeof(__be32))
 		return 0;
 
-	n = *dm++;	/* number of entries */
+	n = of_read_number(dm++, 1);	/* number of entries */
 	if (l < (n * (dt_root_addr_cells + 4) + 1) * sizeof(__be32))
 		return 0;
 
@@ -468,7 +468,7 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
 
 	for (; n != 0; --n) {
 		base = dt_mem_next_cell(dt_root_addr_cells, &dm);
-		flags = dm[3];
+		flags = of_read_number(&dm[3], 1);
 		/* skip DRC index, pad, assoc. list index, flags */
 		dm += 4;
 		/* skip this block if the reserved bit is set in flags (0x80)
-- 
1.8.1.2
