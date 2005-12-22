Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 624C968802
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Dec 2005 06:52:20 +1100 (EST)
Date: Thu, 22 Dec 2005 17:52:21 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
	Dan Malek <dan@embeddededge.com>
Message-ID: <20051222195221.GA9494@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] ppc32 8xx: last two 8MB D-TLB entries are incorrectly set
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

The last two 8MB TLB entries are being incorrectly set by initial_mmu on 8xx. 

The first entry is written with the same virtual/physical address, which
renders it invalid:

BDI>rms 792 0x00001e00
BDI>rms 824 1
BDI>rds 824
SPR  824 : 0xc08000c0  -1065353024
BDI>rds 825
SPR  825 : 0xc0800de0  -1065349664
BDI>rds 826
SPR  826 : 0x00000000            0

And the second entry, in addition, does not have its TLB index set
correctly.

Dan, I'm afraid that, with this problem fixed, the issue you mentioned
before with relation to conflicts with the vmalloc space becomes real.

* only pin available RAM at initial_mmu, the pinned mappings pointing
beyond the end of physical RAM cause conflicts with vmalloc() space.

Is there any way to know the RAM size at this point in boot? The bd_t
structure is board-specific, so no chance at offseting bd_t to reach the
"mem_size" field.

I see no improvements with the following patch on 128MB boxen, probably
because most referenced kernel data is above 24MB (SLAB caches, etc).
But lower mem machines should benefit significantly - anyone willing to
do some testing?

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index de09787..c67cb5c 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -733,13 +733,16 @@ initial_mmu:
 	mtspr	SPRN_MD_TWC, r9
 	li	r11, MI_BOOTINIT	/* Create RPN for address 0 */
 	addis	r11, r11, 0x0080	/* Add 8M */
-	mtspr	SPRN_MD_RPN, r8
+	mtspr	SPRN_MD_RPN, r11
+
+	addi	r10, r10, 0x0100
+	mtspr	SPRN_MD_CTR, r10
 
 	addis	r8, r8, 0x0080		/* Add 8M */
 	mtspr	SPRN_MD_EPN, r8
 	mtspr	SPRN_MD_TWC, r9
 	addis	r11, r11, 0x0080	/* Add 8M */
-	mtspr	SPRN_MD_RPN, r8
+	mtspr	SPRN_MD_RPN, r11
 #endif
 
 	/* Since the cache is enabled according to the information we
