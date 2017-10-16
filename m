Return-Path: <aik@ozlabs.ru>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Greg Kurz <groug@kaod.org>,
 Balbir Singh <bsingharora@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, slof@lists.ozlabs.org
Subject: [PATCH kernel] RFC: prom_init: Fetch flatten device tree from the
 system firmware
Date: Mon, 16 Oct 2017 16:49:17 +1100
Message-Id: <20171016054917.21577-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment, on 256CPU + 256 PCI devices guest, it takes the guest
about 8.5sec to read the entire device tree. Some explanation can be
found here: https://patchwork.ozlabs.org/patch/826124/ but mostly it is
because the kernel traverses the tree twice and it calls "getprop" for
each properly which is really SLOF as it searches from the linked list
beginning every time.

Since SLOF has just learned to build FDT and this takes less than 0.5sec
for such a big guest, this makes use of the proposed client interface
method - "fdt-fetch".

If "fdt-fetch" is not available, the old method is used.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kernel/prom_init.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 02190e90c7ae..daa50a153737 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2498,6 +2498,31 @@ static void __init flatten_device_tree(void)
 		prom_panic("Can't allocate initial device-tree chunk\n");
 	mem_end = mem_start + room;
 
+	if (!call_prom_ret("fdt-fetch", 2, 1, NULL, mem_start,
+			   room - sizeof(mem_reserve_map))) {
+		u32 size;
+
+		hdr = (void *) mem_start;
+
+		/* Fixup the boot cpuid */
+		hdr->boot_cpuid_phys = cpu_to_be32(prom.cpu);
+
+		/* Append the reserved map to the end of the blob */
+		hdr->off_mem_rsvmap = hdr->totalsize;
+		size = be32_to_cpu(hdr->totalsize);
+		rsvmap = (void *) hdr + size;
+		hdr->totalsize = cpu_to_be32(size + sizeof(mem_reserve_map));
+		memcpy(rsvmap, mem_reserve_map, sizeof(mem_reserve_map));
+
+		/* Store the DT address */
+		dt_header_start = mem_start;
+
+#ifdef DEBUG_PROM
+		prom_printf("Fetched DTB: %d bytes to @%x\n", size, mem_start);
+#endif
+		goto print_exit;
+	}
+
 	/* Get root of tree */
 	root = call_prom("peer", 1, 1, (phandle)0);
 	if (root == (phandle)0)
@@ -2548,6 +2573,7 @@ static void __init flatten_device_tree(void)
 	/* Copy the reserve map in */
 	memcpy(rsvmap, mem_reserve_map, sizeof(mem_reserve_map));
 
+print_exit:
 #ifdef DEBUG_PROM
 	{
 		int i;
-- 
2.11.0
