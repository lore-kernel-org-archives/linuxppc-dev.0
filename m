Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 0EB7BDDFE0
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jan 2009 03:51:30 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 23 Jan 2009 17:51:28 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20090118202943.85450@gmx.net>
Message-ID: <20090123165128.74270@gmx.net>
MIME-Version: 1.0
References: <20081219051455.EBC28DE04A@ozlabs.org>	
	<20090118194353.85500@gmx.net> <1232308506.23611.43.camel@pasglop>
	<20090118202943.85450@gmx.net>
Subject: [PATCH] powerpc/mm: Fix handling of _PAGE_COHERENT in BAT setup code
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Cc: kumar.gala@freescale.com, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

_PAGE_COHERENT is now always set in _PAGE_RAM resp. PAGE_KERNEL.
Thus it has to be masked out, if the BAT mapping should be non
cacheable or CPU_FTR_NEED_COHERENT is not set.

Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
---
 arch/powerpc/mm/ppc_mmu_32.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 45d9253..fe65c40 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -123,9 +123,9 @@ void __init setbat(int index, unsigned long virt, phys_addr_t phys,
 	int wimgxpp;
 	struct ppc_bat *bat = BATS[index];
 
-	if (((flags & _PAGE_NO_CACHE) == 0) &&
-	    cpu_has_feature(CPU_FTR_NEED_COHERENT))
-		flags |= _PAGE_COHERENT;
+	if ((flags & _PAGE_NO_CACHE) ||
+	    (cpu_has_feature(CPU_FTR_NEED_COHERENT) == 0))
+		flags &= ~_PAGE_COHERENT;
 
 	bl = (size >> 17) - 1;
 	if (PVR_VER(mfspr(SPRN_PVR)) != 1) {
-- 
1.5.3.4


-- 
NUR NOCH BIS 31.01.! GMX FreeDSL - Telefonanschluss + DSL 
für nur 16,37 EURO/mtl.!* http://dsl.gmx.de/?ac=OM.AD.PD003K11308T4569a
