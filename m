Return-Path: <monstr@monstr.eu>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6FE00B6FE7
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2011 00:14:37 +1000 (EST)
Received: by fxm1 with SMTP id 1so1329329fxm.15
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2011 07:14:33 -0700 (PDT)
From: Michal Simek <monstr@monstr.eu>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 1/7] powerpc: ppc440 remove zero physical memory base
	assumption
Date: Thu, 16 Jun 2011 16:14:22 +0200
Message-Id: <1308233668-24166-2-git-send-email-monstr@monstr.eu>
In-Reply-To: <1308233668-24166-1-git-send-email-monstr@monstr.eu>
References: <1308233668-24166-1-git-send-email-monstr@monstr.eu>
Cc: arnd@arndb.de, tmarri@apm.com, suzuki@in.ibm.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: John Williams <john.williams@petalogix.com>

The macro PHYSICAL_START is available in this context, currently always with
the value zero.  However, that will change in a future patchset.

For now, just remove the zero physical address start assumption in head_44x.S
where we setup the initial TLB, and in the later MMU setup where we map in
the remainder of low mem if required.

Signed-off-by: John Williams <john.williams@petalogix.com>
---
 arch/powerpc/kernel/head_44x.S |    5 +++--
 arch/powerpc/mm/44x_mmu.c      |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 18d8a16..d80ce05 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -135,8 +135,9 @@ skpinv:	addi	r4,r4,1				/* Increment */
 	lis	r3,PAGE_OFFSET@h
 	ori	r3,r3,PAGE_OFFSET@l
 
-	/* Kernel is at the base of RAM */
-	li r4, 0			/* Load the kernel physical address */
+	/* Kernel is at PHYSICAL_START */
+	lis	r4,PHYSICAL_START@h
+	ori	r4,r4,PHYSICAL_START@l
 
 	/* Load the kernel PID = 0 */
 	li	r0,0
diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c
index 98052ac..4a55061 100644
--- a/arch/powerpc/mm/44x_mmu.c
+++ b/arch/powerpc/mm/44x_mmu.c
@@ -94,7 +94,7 @@ unsigned long __init mmu_mapin_ram(void)
 
 	/* Pin in enough TLBs to cover any lowmem not covered by the
 	 * initial 256M mapping established in head_44x.S */
-	for (addr = PPC_PIN_SIZE; addr < lowmem_end_addr;
+	for (addr = PHYSICAL_START + PPC_PIN_SIZE; addr < lowmem_end_addr;
 	     addr += PPC_PIN_SIZE)
 		ppc44x_pin_tlb(addr + PAGE_OFFSET, addr);
 
-- 
1.5.5.6
