Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BBA28DE698
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 11:27:43 +1100 (EST)
Date: Wed, 7 Jan 2009 11:27:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: cleanup from l64 to ll64 change: arch code
Message-Id: <20090107112738.e00a0067.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/pci_64.c                 |    6 +++---
 arch/powerpc/platforms/cell/spufs/coredump.c |    2 +-
 arch/powerpc/platforms/cell/spufs/fault.c    |    2 +-
 arch/powerpc/platforms/cell/spufs/file.c     |    6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 39fadc6..3941bd9 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -470,7 +470,7 @@ int __devinit pcibios_map_io_space(struct pci_bus *bus)
 	if (bus->self) {
 		pr_debug("IO mapping for PCI-PCI bridge %s\n",
 			 pci_name(bus->self));
-		pr_debug("  virt=0x%016lx...0x%016lx\n",
+		pr_debug("  virt=0x%016llx...0x%016llx\n",
 			 bus->resource[0]->start + _IO_BASE,
 			 bus->resource[0]->end + _IO_BASE);
 		return 0;
@@ -502,7 +502,7 @@ int __devinit pcibios_map_io_space(struct pci_bus *bus)
 					      hose->io_base_phys - phys_page);
 
 	pr_debug("IO mapping for PHB %s\n", hose->dn->full_name);
-	pr_debug("  phys=0x%016lx, virt=0x%p (alloc=0x%p)\n",
+	pr_debug("  phys=0x%016llx, virt=0x%p (alloc=0x%p)\n",
 		 hose->io_base_phys, hose->io_base_virt, hose->io_base_alloc);
 	pr_debug("  size=0x%016lx (alloc=0x%016lx)\n",
 		 hose->pci_io_size, size_page);
@@ -517,7 +517,7 @@ int __devinit pcibios_map_io_space(struct pci_bus *bus)
 	hose->io_resource.start += io_virt_offset;
 	hose->io_resource.end += io_virt_offset;
 
-	pr_debug("  hose->io_resource=0x%016lx...0x%016lx\n",
+	pr_debug("  hose->io_resource=0x%016llx...0x%016llx\n",
 		 hose->io_resource.start, hose->io_resource.end);
 
 	return 0;
diff --git a/arch/powerpc/platforms/cell/spufs/coredump.c b/arch/powerpc/platforms/cell/spufs/coredump.c
index af116aa..c4d4a19 100644
--- a/arch/powerpc/platforms/cell/spufs/coredump.c
+++ b/arch/powerpc/platforms/cell/spufs/coredump.c
@@ -42,7 +42,7 @@ static ssize_t do_coredump_read(int num, struct spu_context *ctx, void *buffer,
 		return spufs_coredump_read[num].read(ctx, buffer, size, off);
 
 	data = spufs_coredump_read[num].get(ctx);
-	ret = snprintf(buffer, size, "0x%.16lx", data);
+	ret = snprintf(buffer, size, "0x%.16llx", data);
 	if (ret >= size)
 		return size;
 	return ++ret; /* count trailing NULL */
diff --git a/arch/powerpc/platforms/cell/spufs/fault.c b/arch/powerpc/platforms/cell/spufs/fault.c
index f093a58..a4dd3ae 100644
--- a/arch/powerpc/platforms/cell/spufs/fault.c
+++ b/arch/powerpc/platforms/cell/spufs/fault.c
@@ -132,7 +132,7 @@ int spufs_handle_class1(struct spu_context *ctx)
 
 	spuctx_switch_state(ctx, SPU_UTIL_IOWAIT);
 
-	pr_debug("ctx %p: ea %016lx, dsisr %016lx state %d\n", ctx, ea,
+	pr_debug("ctx %p: ea %016llx, dsisr %016llx state %d\n", ctx, ea,
 		dsisr, ctx->state);
 
 	ctx->stats.hash_flt++;
diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 7106b63..0da7f2b 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -1654,7 +1654,7 @@ out:
 
 static int spufs_check_valid_dma(struct mfc_dma_command *cmd)
 {
-	pr_debug("queueing DMA %x %lx %x %x %x\n", cmd->lsa,
+	pr_debug("queueing DMA %x %llx %x %x %x\n", cmd->lsa,
 		 cmd->ea, cmd->size, cmd->tag, cmd->cmd);
 
 	switch (cmd->cmd) {
@@ -1671,7 +1671,7 @@ static int spufs_check_valid_dma(struct mfc_dma_command *cmd)
 	}
 
 	if ((cmd->lsa & 0xf) != (cmd->ea &0xf)) {
-		pr_debug("invalid DMA alignment, ea %lx lsa %x\n",
+		pr_debug("invalid DMA alignment, ea %llx lsa %x\n",
 				cmd->ea, cmd->lsa);
 		return -EIO;
 	}
@@ -2633,7 +2633,7 @@ static int spufs_show_ctx(struct seq_file *s, void *private)
 	}
 
 	seq_printf(s, "%c flgs(%lx) sflgs(%lx) pri(%d) ts(%d) spu(%02d)"
-		" %c %lx %lx %lx %lx %x %x\n",
+		" %c %llx %llx %llx %llx %x %x\n",
 		ctx->state == SPU_STATE_SAVED ? 'S' : 'R',
 		ctx->flags,
 		ctx->sched_flags,
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
