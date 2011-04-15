Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <f653265d4078a836a27545cbad8fe7b6f964f28a.1302856271.git.michael@ellerman.id.au>
In-Reply-To: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
References: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
Subject: [PATCH 13/15] powerpc/book3e: Flush IPROT protected TLB entries
	leftover by firmware
Date: Fri, 15 Apr 2011 18:32:05 +1000 (EST)
From: michael@ozlabs.org (Michael Ellerman)
Cc: Jimi Xenidis <jimix@watson.ibm.com>, jack@codezen.org, imunsie@au.ibm.com,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jack Miller <jack@codezen.org>

When we set up the TLB for ourselves on Book3E, we need to flush out any
old mappings established by the firmware or bootloader.  At present we
attempt this with a tlbilx to flush everything, but this will leave behind
any entries with the IPROT bit set.

There are several good reason firmware might establish mappings with IPROT,
and in fact ePAPR compliant firmwares are required to establish their
initial mapped area with IPROT.

This patch, therefore adds more complex code to scan through the TLB upon
entry and flush away any entries that are not our own.

Signed-off-by: Jack Miller <jack@codezen.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/mmu-book3e.h |    1 +
 arch/powerpc/kernel/exceptions-64e.S  |   45 ++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
index 3903d0c..84948e3 100644
--- a/arch/powerpc/include/asm/mmu-book3e.h
+++ b/arch/powerpc/include/asm/mmu-book3e.h
@@ -43,6 +43,7 @@
 #define MAS0_TLBSEL(x)		(((x) << 28) & 0x30000000)
 #define MAS0_ESEL(x)		(((x) << 16) & 0x0FFF0000)
 #define MAS0_NV(x)		((x) & 0x00000FFF)
+#define MAS0_ESEL_MASK		0x0FFF0000
 #define MAS0_HES		0x00004000
 #define MAS0_WQ_ALLWAYS		0x00000000
 #define MAS0_WQ_COND		0x00001000
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index e6c0926..ab5c4dd 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -886,8 +886,51 @@ have_hes:
 	bctr
 
 1:	/* We are now running at PAGE_OFFSET, clean the TLB of everything
-	 * else (XXX we should scan for bolted crap from the firmware too)
+	 * else (including IPROTed things left by firmware)
+	 * r4 = TLBnCFG
+	 * r3 = current address (more or less)
 	 */
+
+	li	r5,0
+	mtspr	SPRN_MAS6,r5
+	tlbsx	0,r3
+
+	rlwinm	r9,r4,0,TLBnCFG_N_ENTRY
+	rlwinm	r10,r4,8,0xff
+	addi	r10,r10,-1	/* Get inner loop mask */
+
+	li	r3,1
+
+	mfspr	r5,SPRN_MAS1
+	rlwinm	r5,r5,0,(~(MAS1_VALID|MAS1_IPROT))
+
+	mfspr	r6,SPRN_MAS2
+	rldicr	r6,r6,0,51		/* Extract EPN */
+
+	mfspr	r7,SPRN_MAS0
+	rlwinm	r7,r7,0,0xffff0fff	/* Clear HES and WQ */
+
+	rlwinm	r8,r7,16,0xfff		/* Extract ESEL */
+
+2:	add	r4,r3,r8
+	and	r4,r4,r10
+
+	rlwimi	r7,r4,16,MAS0_ESEL_MASK
+
+	mtspr	SPRN_MAS0,r7
+	mtspr	SPRN_MAS1,r5
+	mtspr	SPRN_MAS2,r6
+	tlbwe
+
+	addi	r3,r3,1
+	and.	r4,r3,r10
+
+	bne	3f
+	addis	r6,r6,(1<<30)@h
+3:
+	cmpw	r3,r9
+	blt	2b
+
 	PPC_TLBILX(0,0,0)
 	sync
 	isync
-- 
1.7.1
