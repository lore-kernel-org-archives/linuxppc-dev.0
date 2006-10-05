Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 66C8167DAB
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Oct 2006 13:28:13 +1000 (EST)
Date: Wed, 4 Oct 2006 22:28:00 -0500
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] linux,tce-size property is 32 bits
Message-ID: <20061005032800.GH24705@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, matthltc@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The "linux,tce-size" property is only 32 bits (see
prom_initialize_tce_table() in arch/powerpc/kernel/prom_init.c).
Treating it as an unsigned long in iommu_table_setparms() leads to
access beyond the end of the property's buffer, so we pass garbage to
the memset() in that function.

[boot]0020 XICS Init
i8259 legacy interrupt controller initialized
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 32768 bytes)
cpu 0x0: Vector: 300 (Data Access) at [c0000000fe783850]
    pc: c000000000035e90: .memset+0x60/0xfc
    lr: c000000000044fa4: .iommu_table_setparms+0xb0/0x158
    sp: c0000000fe783ad0
   msr: 9000000000009032
   dar: c000000100000000
 dsisr: 42010000
  current = 0xc00000000450e810
  paca    = 0xc000000000411580
    pid   = 1, comm = swapper
enter ? for help
[link register   ] c000000000044fa4 .iommu_table_setparms+0xb0/0x158
[c0000000fe783ad0] c000000000044f4c .iommu_table_setparms+0x58/0x158
(unreliable)
[c0000000fe783b70] c00000000004529c
.iommu_bus_setup_pSeries+0x1c4/0x254
[c0000000fe783c00] c00000000002b8ac .do_bus_setup+0x3c/0xe4
[c0000000fe783c80] c00000000002c924 .pcibios_fixup_bus+0x64/0xd8
[c0000000fe783d00] c0000000001a2d5c .pci_scan_child_bus+0x6c/0x10c
[c0000000fe783da0] c00000000002be28 .scan_phb+0x17c/0x1b4
[c0000000fe783e40] c0000000003cfa00 .pcibios_init+0x58/0x19c
[c0000000fe783ec0] c0000000000094b4 .init+0x1e8/0x3d8
[c0000000fe783f90] c000000000026e54 .kernel_thread+0x4c/0x68

Signed-off-by: Nathan Lynch <ntl@pobox.com>

---

I believe this is a regression since 2.6.18, so please push for
inclusion in 2.6.19.


--- linux-2.6.git.orig/arch/powerpc/platforms/pseries/iommu.c
+++ linux-2.6.git/arch/powerpc/platforms/pseries/iommu.c
@@ -267,7 +267,8 @@ static void iommu_table_setparms(struct 
 				 struct iommu_table *tbl)
 {
 	struct device_node *node;
-	const unsigned long *basep, *sizep;
+	const unsigned long *basep;
+	const u32 *sizep;
 
 	node = (struct device_node *)phb->arch_data;
 
