Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3A6C267B27
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Mar 2006 17:38:29 +1100 (EST)
Date: Thu, 23 Mar 2006 17:38:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] powerpc: fix various sparse warnings
Message-Id: <20060323173810.44f836ff.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/kernel/legacy_serial.c          |    4 ++--
 arch/powerpc/kernel/nvram_64.c               |    3 ++-
 arch/powerpc/kernel/process.c                |    6 +++++-
 arch/powerpc/kernel/setup_32.c               |    2 +-
 arch/powerpc/lib/sstep.c                     |    2 +-
 arch/powerpc/platforms/powermac/bootx_init.c |    2 +-
 arch/powerpc/platforms/powermac/nvram.c      |   12 ++++++------
 arch/powerpc/platforms/powermac/udbg_scc.c   |    2 +-
 8 files changed, 19 insertions(+), 14 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

7debffaf860554fd5ff8029d306140094e8b5022
diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index c7a799a..09d9c82 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -37,7 +37,7 @@ static int legacy_serial_console = -1;
 static int __init add_legacy_port(struct device_node *np, int want_index,
 				  int iotype, phys_addr_t base,
 				  phys_addr_t taddr, unsigned long irq,
-				  unsigned int flags)
+				  upf_t flags)
 {
 	u32 *clk, *spd, clock = BASE_BAUD * 16;
 	int index;
@@ -113,7 +113,7 @@ static int __init add_legacy_soc_port(st
 {
 	phys_addr_t addr;
 	u32 *addrp;
-	unsigned int flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ;
+	upf_t flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ;
 
 	/* We only support ports that have a clock frequency properly
 	 * encoded in the device-tree.
diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index fd7db8d..6c3989f 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -174,8 +174,9 @@ static int dev_nvram_ioctl(struct inode 
 		return 0;
 	}
 #endif /* CONFIG_PPC_PMAC */
+	default:
+		return -EINVAL;
 	}
-	return -EINVAL;
 }
 
 struct file_operations nvram_fops = {
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 1770a06..10a8363 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -363,7 +363,11 @@ static void show_instructions(struct pt_
 		if (!(i % 8))
 			printk("\n");
 
-		if (BAD_PC(pc) || __get_user(instr, (unsigned int *)pc)) {
+		/* We use __get_user here *only* to avoid an OOPS on a
+		 * bad address because the pc *should* only be a
+		 * kernel address.
+		 */
+		if (BAD_PC(pc) || __get_user(instr, (unsigned int __user *)pc)) {
 			printk("XXXXXXXX ");
 		} else {
 			if (regs->nip == pc)
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index db72a92..1861b73 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -111,7 +111,7 @@ unsigned long __init early_init(unsigned
 
 	/* First zero the BSS -- use memset_io, some platforms don't have
 	 * caches on yet */
-	memset_io(PTRRELOC(&__bss_start), 0, _end - __bss_start);
+	memset_io((void __iomem *)PTRRELOC(&__bss_start), 0, _end - __bss_start);
 
 	/*
 	 * Identify the CPU type and fix up code sections
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 666c2aa..c251d99 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -18,7 +18,7 @@ extern char system_call_common[];
 
 #ifdef CONFIG_PPC64
 /* Bits in SRR1 that are copied from MSR */
-#define MSR_MASK	0xffffffff87c0ffff
+#define MSR_MASK	0xffffffff87c0ffffUL
 #else
 #define MSR_MASK	0x87c0ffff
 #endif
diff --git a/arch/powerpc/platforms/powermac/bootx_init.c b/arch/powerpc/platforms/powermac/bootx_init.c
index fa8b4d7..a94571b 100644
--- a/arch/powerpc/platforms/powermac/bootx_init.c
+++ b/arch/powerpc/platforms/powermac/bootx_init.c
@@ -493,7 +493,7 @@ void __init bootx_init(unsigned long r3,
 		    && (strcmp(model, "iMac,1") == 0
 			|| strcmp(model, "PowerMac1,1") == 0)) {
 			bootx_printf("iMac,1 detected, shutting down USB \n");
-			out_le32((unsigned *)0x80880008, 1);	/* XXX */
+			out_le32((unsigned __iomem *)0x80880008, 1);	/* XXX */
 		}
 	}
 
diff --git a/arch/powerpc/platforms/powermac/nvram.c b/arch/powerpc/platforms/powermac/nvram.c
index 5fd2899..3aa3477 100644
--- a/arch/powerpc/platforms/powermac/nvram.c
+++ b/arch/powerpc/platforms/powermac/nvram.c
@@ -74,7 +74,7 @@ struct core99_header {
  * Read and write the non-volatile RAM on PowerMacs and CHRP machines.
  */
 static int nvram_naddrs;
-static volatile unsigned char *nvram_data;
+static volatile unsigned char __iomem *nvram_data;
 static int is_core_99;
 static int core99_bank = 0;
 static int nvram_partitions[3];
@@ -148,7 +148,7 @@ static ssize_t core99_nvram_size(void)
 }
 
 #ifdef CONFIG_PPC32
-static volatile unsigned char *nvram_addr;
+static volatile unsigned char __iomem *nvram_addr;
 static int nvram_mult;
 
 static unsigned char direct_nvram_read_byte(int addr)
@@ -285,7 +285,7 @@ static int sm_erase_bank(int bank)
 	int stat, i;
 	unsigned long timeout;
 
-	u8* base = (u8 *)nvram_data + core99_bank*NVRAM_SIZE;
+	u8 __iomem *base = (u8 __iomem *)nvram_data + core99_bank*NVRAM_SIZE;
 
        	DBG("nvram: Sharp/Micron Erasing bank %d...\n", bank);
 
@@ -317,7 +317,7 @@ static int sm_write_bank(int bank, u8* d
 	int i, stat = 0;
 	unsigned long timeout;
 
-	u8* base = (u8 *)nvram_data + core99_bank*NVRAM_SIZE;
+	u8 __iomem *base = (u8 __iomem *)nvram_data + core99_bank*NVRAM_SIZE;
 
        	DBG("nvram: Sharp/Micron Writing bank %d...\n", bank);
 
@@ -352,7 +352,7 @@ static int amd_erase_bank(int bank)
 	int i, stat = 0;
 	unsigned long timeout;
 
-	u8* base = (u8 *)nvram_data + core99_bank*NVRAM_SIZE;
+	u8 __iomem *base = (u8 __iomem *)nvram_data + core99_bank*NVRAM_SIZE;
 
        	DBG("nvram: AMD Erasing bank %d...\n", bank);
 
@@ -399,7 +399,7 @@ static int amd_write_bank(int bank, u8* 
 	int i, stat = 0;
 	unsigned long timeout;
 
-	u8* base = (u8 *)nvram_data + core99_bank*NVRAM_SIZE;
+	u8 __iomem *base = (u8 __iomem *)nvram_data + core99_bank*NVRAM_SIZE;
 
        	DBG("nvram: AMD Writing bank %d...\n", bank);
 
diff --git a/arch/powerpc/platforms/powermac/udbg_scc.c b/arch/powerpc/platforms/powermac/udbg_scc.c
index c4352a8..b4fa9f0 100644
--- a/arch/powerpc/platforms/powermac/udbg_scc.c
+++ b/arch/powerpc/platforms/powermac/udbg_scc.c
@@ -116,7 +116,7 @@ void udbg_scc_init(int force_scc)
 	/* Setup for 57600 8N1 */
 	if (ch == ch_a)
 		addr += 0x20;
-	sccc = (volatile u8 * __iomem) ioremap(addr & PAGE_MASK, PAGE_SIZE) ;
+	sccc = ioremap(addr & PAGE_MASK, PAGE_SIZE) ;
 	sccc += addr & ~PAGE_MASK;
 	sccd = sccc + 0x10;
 
-- 
1.2.4
