Return-Path: <siccegge@cs.fau.de>
Received: from faui40.informatik.uni-erlangen.de
	(faui40.informatik.uni-erlangen.de [131.188.34.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B2AD1B7D64
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jun 2010 20:09:47 +1000 (EST)
Date: Wed, 9 Jun 2010 12:01:12 +0200
From: Christoph Egger <siccegge@cs.fau.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Torez Smith <lnxtorez@linux.vnet.ibm.com>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] Removing dead CONFIG_PPC47x
Message-ID: <b7f3a0f1bbcd39544df81c12719a820ba5906bd5.1275925219.git.siccegge@cs.fau.de>
References: <cover.1275925219.git.siccegge@cs.fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1275925219.git.siccegge@cs.fau.de>
Cc: vamos@i4.informatik.uni-erlangen.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_PPC47x doesn't exist in Kconfig, therefore removing all
references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/powerpc/mm/44x_mmu.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c
index d8c6efb..f70da7e 100644
--- a/arch/powerpc/mm/44x_mmu.c
+++ b/arch/powerpc/mm/44x_mmu.c
@@ -76,11 +76,7 @@ static void __init ppc44x_pin_tlb(unsigned int virt, unsigned int phys)
 		"tlbwe	%1,%3,%5\n"
 		"tlbwe	%0,%3,%6\n"
 	:
-#ifdef CONFIG_PPC47x
-	: "r" (PPC47x_TLB2_S_RWX),
-#else
 	: "r" (PPC44x_TLB_SW | PPC44x_TLB_SR | PPC44x_TLB_SX | PPC44x_TLB_G),
-#endif
 	  "r" (phys),
 	  "r" (virt | PPC44x_TLB_VALID | PPC44x_TLB_256M),
 	  "r" (entry),
-- 
1.6.3.3
