Return-Path: <shaggy@linux.vnet.ibm.com>
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: [PATCH 4/4] powerpc/47x: Add an isync before the tlbivax instruction
Date: Wed, 18 Aug 2010 11:44:26 -0500
Message-Id: <1282149866-4710-5-git-send-email-shaggy@linux.vnet.ibm.com>
In-Reply-To: <1282149866-4710-1-git-send-email-shaggy@linux.vnet.ibm.com>
References: <1282149866-4710-1-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---
 arch/powerpc/mm/tlb_nohash_low.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/tlb_nohash_low.S b/arch/powerpc/mm/tlb_nohash_low.S
index cfa7682..b9d9fed 100644
--- a/arch/powerpc/mm/tlb_nohash_low.S
+++ b/arch/powerpc/mm/tlb_nohash_low.S
@@ -200,6 +200,7 @@ _GLOBAL(_tlbivax_bcast)
 	rlwimi	r5,r4,0,16,31
 	wrteei	0
 	mtspr	SPRN_MMUCR,r5
+	isync
 /*	tlbivax	0,r3 - use .long to avoid binutils deps */
 	.long 0x7c000624 | (r3 << 11)
 	isync
-- 
1.7.1
