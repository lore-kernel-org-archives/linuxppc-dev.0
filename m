Return-Path: <albert_herranz@yahoo.es>
Received: from smtp106.mail.ukl.yahoo.com (smtp106.mail.ukl.yahoo.com
	[77.238.184.38]) by ozlabs.org (Postfix) with SMTP id E6DA41008C5
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 09:02:14 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 14/19] powerpc: allow ioremap within reserved fake ram
	regions
Date: Sun, 22 Nov 2009 23:01:45 +0100
Message-Id: <1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Nintendo Wii has two discontiguous RAM memory areas called
MEM1 and MEM2.
MEM1 starts at 0x00000000 and contains 24MB of 1T-SRAM.
MEM2 starts at 0x10000000 and contains 64MB of DDR2 RAM.
Between both memory address ranges there is an address space
where memory-mapped I/O registers are found.

Currently, Linux 32-bit PowerPC does not support RAM in
discontiguous memory address spaces. Thus, in order to use
both RAM areas, we declare as RAM the range from the start of
MEM1 to the end of useable MEM2 and exclude the needed parts
with /memreserve/ statements, at the expense of wasting a bit
of memory.

As a side effect, we need to allow ioremapping RAM areas
because the I/O address space sits within the memreserve'd part
of the declared RAM region.
Note that this is not safe if the region ioremapped is covered
by an existing BAT mapping used to map RAM, so this is
specifically banned here.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/mm/pgtable_32.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index cb96cb2..ba00cb1 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -191,9 +191,22 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 	 * Don't allow anybody to remap normal RAM that we're using.
 	 * mem_init() sets high_memory so only do the check after that.
 	 */
-	if (mem_init_done && (p < virt_to_phys(high_memory))) {
-		printk("__ioremap(): phys addr 0x%llx is RAM lr %p\n",
-		       (unsigned long long)p, __builtin_return_address(0));
+	if (mem_init_done && (p < virt_to_phys(high_memory))
+#ifdef CONFIG_WII
+		/*
+		 * On some systems, though, we may want to remap an area
+		 * declared as normal RAM that we have memreserve'd at the
+		 * device tree. See wii.dts.
+		 * But we can't do that safely if we are using BATs to map
+		 * part of that area.
+		 */
+	    && !__map_without_bats
+#endif
+	    ) {
+		printk(KERN_WARNING
+		       "__ioremap(): phys addr 0x%llx is RAM lr %p\n",
+		       (unsigned long long)p,
+			 __builtin_return_address(0));
 		return NULL;
 	}
 #endif
-- 
1.6.3.3
