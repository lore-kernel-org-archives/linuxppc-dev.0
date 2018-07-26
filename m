Return-Path: <AlexeiS@astrosoft.ru>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00089.outbound.protection.outlook.com [40.107.0.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bsT82DQ3zDqnG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 22:52:56 +1000 (AEST)
From: Alexey Spirkov <AlexeiS@astrosoft.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: "trivial@kernel.org" <trivial@kernel.org>, "andrew@ncrmnt.org"
 <andrew@ncrmnt.org>
Subject: [PATCH] Adds __init annotation at mmu_init_secondary func
Date: Thu, 26 Jul 2018 12:52:50 +0000
Message-ID: <AM5PR03MB28499BE4A0B6200F7DA83835C92B0@AM5PR03MB2849.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mmu_init_secondary function called at initialization sequence
but it misses __init annotation. As result modpost warning is generated.
Some building systems sensitive to such kind of warnings.

Signed-off-by: Alexey Spirkov <alexeis@astrosoft.ru>
---
 arch/powerpc/mm/44x_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c
index 82b1ff7..12d9251 100644
--- a/arch/powerpc/mm/44x_mmu.c
+++ b/arch/powerpc/mm/44x_mmu.c
@@ -229,7 +229,7 @@ void setup_initial_memory_limit(phys_addr_t first_membl=
ock_base,
 }
=20
 #ifdef CONFIG_SMP
-void mmu_init_secondary(int cpu)
+void __init mmu_init_secondary(int cpu)
 {
 	unsigned long addr;
 	unsigned long memstart =3D memstart_addr & ~(PPC_PIN_SIZE - 1);
--=20
2.9.5
