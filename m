Return-Path: <cel@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5E0AEB6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Jul 2011 02:50:06 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p6QGUwrf012421
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2011 10:30:58 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p6QGo01W132470
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2011 10:50:00 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p6QAnBkW023968
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2011 04:49:11 -0600
Subject: [PATCH RFC] perf event: Torrent, add support for the various PMUs
	on the Torrent chip.
From: "Carl E. Love" <cel@linux.vnet.ibm.com>
To: ltc-interlock@lists.ibm.com, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 26 Jul 2011 09:49:34 -0700
Message-ID: <1311698974.28685.4.camel@oc5652146517.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



We are requesting your help to review the following patch prior to posting it 
upstream. The patch is against the 2.6.39 tree (which is already out of date).
Thank your for your help and input.

                       Carl Love
--------------------------------------------------------------------------
[PATCH RFC] perf event: Torrent, add support for the various PMUs on the Torrent chip.

Support for the Torrent hardware performance monitor units (PMU) on the LL
link, WXYZ links, MCD bus, and CAU units is added.  These PMUs are specific
to the Torrent system which is built using POWER7 processors.  These PMUs
are specifc to the IBM P7IH system's Torrent chips, which are used to
interconnect POWER7 processors.  Hence the platform specific files to
support these PMUs are in the platform-specific directory
arch/powerpc/platforms/torrent.  The include files are added to the
standard powerpc include directory.  The Torrent PMU support uses the
multiple PMU perf_events support.  A single perf_events PMU type is
created to cover all of the various Torrent hardware PMUs.  The generic
Torrent PMU type allows all of the specific Torrent hardware PMU events to
be included into a group of events within the perf_events Torrent PMU type.
The advantage of this model is that all of the events for the various
links are guaranteed to be measured at the same time, providing good
correlation between the activity on each of the different Torrent links.

This patch is a forward port of the initial Torrent PMU patch for 2.6.32
that was done as part of the development effort on Torrent and never pushed
upstream.

Signed-off-by: Carl Love <carll@us.ibm.com>
---
 arch/powerpc/include/asm/cau_pmu.h                 |   39 +
 arch/powerpc/include/asm/hvcall.h                  |   14 +
 arch/powerpc/include/asm/mmu_pmu.h                 |   39 +
 arch/powerpc/include/asm/power_torrent_events.h    |  106 ++
 arch/powerpc/include/asm/powerbus_bus_util_pmu.h   |   39 +
 arch/powerpc/include/asm/powerbus_ll_pmu.h         |   39 +
 arch/powerpc/include/asm/powerbus_mcd_pmu.h        |   44 +
 arch/powerpc/include/asm/powerbus_wxyz_pmu.h       |   38 +
 arch/powerpc/include/asm/torrent_nest_pmu.h        |  192 +++
 arch/powerpc/kernel/perf_event.c                   |    4 +
 arch/powerpc/platforms/Makefile                    |    1 +
 arch/powerpc/platforms/p7ih/Makefile               |   10 +
 arch/powerpc/platforms/p7ih/cau_pmu.c              |  160 ++
 arch/powerpc/platforms/p7ih/mmu_pmu.c              |  156 ++
 .../powerpc/platforms/p7ih/powerbus_bus_util_pmu.c |  410 +++++
 arch/powerpc/platforms/p7ih/powerbus_ll_pmu.c      |  273 ++++
 arch/powerpc/platforms/p7ih/powerbus_mcd_pmu.c     |  492 ++++++
 arch/powerpc/platforms/p7ih/powerbus_wxyz_pmu.c    |  244 +++
 arch/powerpc/platforms/p7ih/torrent_pmu.c          | 1582 ++++++++++++++++++++
 arch/powerpc/platforms/pseries/Kconfig             |    5 +
 20 files changed, 3887 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/include/asm/cau_pmu.h
 create mode 100644 arch/powerpc/include/asm/mmu_pmu.h
 create mode 100644 arch/powerpc/include/asm/power_torrent_events.h
 create mode 100644 arch/powerpc/include/asm/powerbus_bus_util_pmu.h
 create mode 100644 arch/powerpc/include/asm/powerbus_ll_pmu.h
 create mode 100644 arch/powerpc/include/asm/powerbus_mcd_pmu.h
 create mode 100644 arch/powerpc/include/asm/powerbus_wxyz_pmu.h
 create mode 100644 arch/powerpc/include/asm/torrent_nest_pmu.h
 create mode 100644 arch/powerpc/platforms/p7ih/Makefile
 create mode 100644 arch/powerpc/platforms/p7ih/cau_pmu.c
 create mode 100644 arch/powerpc/platforms/p7ih/mmu_pmu.c
 create mode 100644 arch/powerpc/platforms/p7ih/powerbus_bus_util_pmu.c
 create mode 100644 arch/powerpc/platforms/p7ih/powerbus_ll_pmu.c
 create mode 100644 arch/powerpc/platforms/p7ih/powerbus_mcd_pmu.c
 create mode 100644 arch/powerpc/platforms/p7ih/powerbus_wxyz_pmu.c
 create mode 100644 arch/powerpc/platforms/p7ih/torrent_pmu.c

diff --git a/arch/powerpc/include/asm/cau_pmu.h b/arch/powerpc/include/asm/cau_pmu.h
new file mode 100644
index 0000000..1fc6f48
--- /dev/null
+++ b/arch/powerpc/include/asm/cau_pmu.h
@@ -0,0 +1,39 @@
+/*
+ * Torrent Performance Monitor
+ *
+ * Copyright Carl Love, Corey Ashford IBM Corporation 2010, 2011
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ASM_CAU_PMU_H_
+#define __ASM_CAU_PMU_H_
+
+extern int cau_compute_pmc_reg(struct torrent_pmu_events *torrent_pmu_events,
+			       struct hcall_data *hcall_write);
+extern int cau_pmu_check_constraints(struct torrent_pmu_events
+				     *torrent_pmu_events,
+				     struct unit_config *unit_cfg);
+extern void cau_enable_disable_hw_cntr(int op,
+				       struct torrent_pmu_events
+				       *torrent_pmu_events,
+				       struct hcall_data *hcall_write);
+extern void cau_pmd_write(struct torrent_pmu_events *torrent_pmu_events,
+			  struct hcall_data *hcall_read);
+extern int cau_pmd_read(struct torrent_pmu_events *torrent_pmu_events,
+			struct hcall_data *hcall_read);
+extern int cau_get_phys_pmd_reg(u64 event_code);
+
+#endif
diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index fd8201d..2343636 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -238,6 +238,20 @@
 #define H_GET_MPP_X		0x314
 #define MAX_HCALL_OPCODE	H_GET_MPP_X
 
+/* PHyp calls for P7IH */
+#define H_TOR_ACCESS_PMU_SCOM_REGS      0xF048ULL
+#define H_HFI_DUMP_INFO                 0xF01CULL
+
+/* Dump request codes for the H_HFI_DUMP_INFO PHyp call */
+/* request code is in bits 32..47 */
+#define DUMP_REQUEST_SHIFT              (63 - 47)
+#define DUMP_WINDOW_REGS                (0x1ULL << DUMP_REQUEST_SHIFT)
+#define DUMP_NON_WINDOW_REGS            (0x2ULL << DUMP_REQUEST_SHIFT)
+#define DUMP_BROADCAST_COUNTERS         (0x3ULL << DUMP_REQUEST_SHIFT)
+#define DUMP_PERFORMANCE_COUNTERS       (0x4ULL << DUMP_REQUEST_SHIFT)
+#define DUMP_PHYP_INTERNALS             (0x5ULL << DUMP_REQUEST_SHIFT)
+#define DUMP_MMIO_PERFORMANCE_COUNTERS  (0x6ULL << DUMP_REQUEST_SHIFT)
+
 #ifndef __ASSEMBLY__
 
 /**
diff --git a/arch/powerpc/include/asm/mmu_pmu.h b/arch/powerpc/include/asm/mmu_pmu.h
new file mode 100644
index 0000000..ad433ea
--- /dev/null
+++ b/arch/powerpc/include/asm/mmu_pmu.h
@@ -0,0 +1,39 @@
+/*
+ * Torrent Performance Monitor
+ *
+ * Copyright Carl Love, Corey Ashford IBM Corporation 2010, 2011
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ASM_MMU_PMU_H_
+#define __ASM_MMU_PMU_H_
+
+extern int mmu_compute_pmc_reg(struct torrent_pmu_events *torrent_pmu_events,
+			       struct hcall_data *hcall_write);
+extern int mmu_pmu_check_constraints(struct torrent_pmu_events
+				     *torrent_pmu_events,
+				     struct unit_config *unit_cfg);
+extern void mmu_enable_disable_hw_cntr(int op,
+				       struct torrent_pmu_events
+				       *torrent_pmu_events,
+				       struct hcall_data *hcall_write);
+extern void mmu_pmd_write(struct torrent_pmu_events *torrent_pmu_events,
+			  struct hcall_data *hcall_read);
+extern int mmu_pmd_read(struct torrent_pmu_events *torrent_pmu_events,
+			struct hcall_data *hcall_read);
+extern int mmu_get_phys_pmd_reg(u64 event_code);
+
+#endif
diff --git a/arch/powerpc/include/asm/power_torrent_events.h b/arch/powerpc/include/asm/power_torrent_events.h
new file mode 100644
index 0000000..7d71cab
--- /dev/null
+++ b/arch/powerpc/include/asm/power_torrent_events.h
@@ -0,0 +1,106 @@
+/*
+ * Torrent Performance Monitor
+ *
+ * Copyright Carl Love, Corey Ashford IBM Corporation 2010, 2011
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/* Power Torrent PMU event codes */
+
+#ifndef __POWER_TORRENT_EVENTS_H__
+#define __POWER_TORRENT_EVENTS_H__
+
+/* PRELIMINARY EVENT ENCODING
+ * 0x0000_0000 - 0x00FF_FFFF = POWER core events
+ * 0x0100_0000 - 0x01FF_FFFF = Torrent events
+ * 0x0200_0000 - 0xFFFF_FFFF = reserved
+ * For Torrent events:
+ * Reserve encodings 0x0..0x00FF_FFFF for core POWER events.
+ * For Torrent events
+ *    0x00F0_0000 = Torrent PMU id
+ *    0x000F_0000 = PMU unit number (e.g. 0 for MCD0, 1 for MCD1)
+ *    0x0000_FF00 = virtual counter number (unused on MCD)
+ *    0x0000_00FF = PMC event selector mux value (unused on Util, MMU, CAU)
+ * (Note that some of these fields are wider than necessary)
+ *
+ * The upper bits 0xFFFF_FFFF_0000_0000 are reserved for attribute
+ * fields.
+ */
+
+#define PMU_SPACE_MASK		0xFF000000
+#define POWERPC_CORE_SPACE	0x00000000
+#define TORRENT_SPACE		0x01000000
+#define IS_CORE_EVENT(x)	((x & PMU_SPACE_MASK) == POWERPC_CORE_SPACE)
+#define IS_TORRENT_EVENT(x)	((x & PMU_SPACE_MASK) == TORRENT_SPACE)
+#define TORRENT_PMU_SHIFT	20
+#define TORRENT_PMU_MASK	(0xF << TORRENT_PMU_SHIFT)
+#define TORRENT_PMU_GET(x)	((x & TORRENT_PMU_MASK) >> TORRENT_PMU_SHIFT)
+#define TORRENT_UNIT_SHIFT	16
+#define TORRENT_UNIT_MASK	(0xF << TORRENT_UNIT_SHIFT)
+#define TORRENT_UNIT_GET(x)	((x & TORRENT_UNIT_MASK) >> TORRENT_UNIT_SHIFT)
+#define TORRENT_VIRT_CTR_SHIFT	8
+#define TORRENT_VIRT_CTR_MASK	(0xFF << TORRENT_VIRT_CTR_SHIFT)
+#define TORRENT_VIRT_CTR_GET(x)	((x & TORRENT_VIRT_CTR_MASK) >> \
+				 TORRENT_VIRT_CTR_SHIFT)
+#define TORRENT_MUX_SHIFT	0
+#define TORRENT_MUX_MASK	0xFF
+#define TORRENT_MUX_GET(x)	((x & TORRENT_MUX_MASK) >> TORRENT_MUX_SHIFT)
+
+#define TORRENT_ATTR_UTIL_SEL_SHIFT    32
+#define TORRENT_ATTR_UTIL_SEL_MASK     (0x3ULL << TORRENT_ATTR_UTIL_SEL_SHIFT)
+#define TORRENT_ATTR_UTIL_CMP_SHIFT    34
+#define TORRENT_ATTR_UTIL_CMP_MASK     (0x1FULL << TORRENT_ATTR_UTIL_CMP_SHIFT)
+
+#define TORRENT_PBUS_WXYZ_ID	0x0
+#define TORRENT_PBUS_LL_ID	0x1
+#define TORRENT_PBUS_MCD_ID	0x2
+#define TORRENT_PBUS_UTIL_ID	0x3
+#define TORRENT_MMU_ID		0x4
+#define TORRENT_CAU_ID		0x5
+
+#define TORRENT_LAST_PMU_ID		(TORRENT_CAU_ID)
+#define TORRENT_NUM_PMU_TYPES		(TORRENT_LAST_PMU_ID + 1)
+#define TORRENT_LAST_PBUS_PMU_ID	(TORRENT_PBUS_UTIL_ID)
+#define TORRENT_NUM_PBUS_PMU_TYPES	(TORRENT_LAST_PBUS_PMU_ID + 1)
+
+#define TORRENT_PMU(pmu)	(TORRENT_SPACE | \
+				TORRENT_##pmu##_ID << TORRENT_PMU_SHIFT)
+
+#define TORRENT_PBUS_WXYZ	TORRENT_PMU(PBUS_WXYZ)
+#define TORRENT_PBUS_LL		TORRENT_PMU(PBUS_LL)
+#define TORRENT_PBUS_MCD	TORRENT_PMU(PBUS_MCD)
+#define TORRENT_PBUS_UTIL	TORRENT_PMU(PBUS_UTIL)
+#define TORRENT_MMU		TORRENT_PMU(MMU)
+#define TORRENT_CAU		TORRENT_PMU(CAU)
+
+#define COUNTER_W		(0 << TORRENT_VIRT_CTR_SHIFT)
+#define COUNTER_X		(1 << TORRENT_VIRT_CTR_SHIFT)
+#define COUNTER_Y		(2 << TORRENT_VIRT_CTR_SHIFT)
+#define COUNTER_Z		(3 << TORRENT_VIRT_CTR_SHIFT)
+#define COUNTER_LL0		(0 << TORRENT_VIRT_CTR_SHIFT)
+#define COUNTER_LL1		(1 << TORRENT_VIRT_CTR_SHIFT)
+#define COUNTER_LL2		(2 << TORRENT_VIRT_CTR_SHIFT)
+#define COUNTER_LL3		(3 << TORRENT_VIRT_CTR_SHIFT)
+#define COUNTER_LL4		(4 << TORRENT_VIRT_CTR_SHIFT)
+#define COUNTER_LL5		(5 << TORRENT_VIRT_CTR_SHIFT)
+#define COUNTER_LL6		(6 << TORRENT_VIRT_CTR_SHIFT)
+
+/* Attributes */
+
+#define TORRENT_ATTR_MCD_TYPE_SHIFT	32
+#define TORRENT_ATTR_MCD_TYPE_MASK	(0x3ULL << TORRENT_ATTR_MCD_TYPE_SHIFT)
+
+#endif
diff --git a/arch/powerpc/include/asm/powerbus_bus_util_pmu.h b/arch/powerpc/include/asm/powerbus_bus_util_pmu.h
new file mode 100644
index 0000000..17a30d3
--- /dev/null
+++ b/arch/powerpc/include/asm/powerbus_bus_util_pmu.h
@@ -0,0 +1,39 @@
+/*
+ * Torrent Performance Monitor
+ *
+ * Copyright Carl Love, Corey Ashford IBM Corporation 2010, 2011
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ASM_POWERBUS_BUS_UTIL_PMU_H_
+#define __ASM_POWERBUS_BUS_UTIL_PMU_H_
+
+extern int bus_util_compute_pmc_reg(
+				struct torrent_pmu_events *torrent_pmu_events,
+				struct hcall_data *hcall_write);
+extern int bus_util_pmu_check_constraints(
+				struct torrent_pmu_events *torrent_pmu_events,
+				struct unit_config *unit_cfg);
+extern void bus_util_enable_disable_hw_cntr(int op,
+				struct torrent_pmu_events *torrent_pmu_events,
+				struct hcall_data *hcall_write);
+extern void bus_util_pmd_write(struct torrent_pmu_events *torrent_pmu_events,
+			       struct hcall_data *hcall_read);
+extern int bus_util_pmd_read(struct torrent_pmu_events *torrent_pmu_events,
+			     struct hcall_data *hcall_read);
+extern int bus_util_get_phys_pmd_reg(u64 event_code);
+
+#endif
diff --git a/arch/powerpc/include/asm/powerbus_ll_pmu.h b/arch/powerpc/include/asm/powerbus_ll_pmu.h
new file mode 100644
index 0000000..a3d289d
--- /dev/null
+++ b/arch/powerpc/include/asm/powerbus_ll_pmu.h
@@ -0,0 +1,39 @@
+/*
+ * Torrent Performance Monitor
+ *
+ * Copyright Carl Love, Corey Ashford IBM Corporation 2010, 2011
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ASM_POWERBUS_LL_PMU_H_
+#define __ASM_POWERBUS_LL_PMU_H_
+
+extern int ll_link_compute_pmc_reg(
+				struct torrent_pmu_events *torrent_pmu_events,
+				struct hcall_data *hcall_write);
+extern int ll_link_pmu_check_constraints(
+				struct torrent_pmu_events *torrent_pmu_events,
+				struct unit_config *unit_cfg);
+extern void ll_link_enable_disable_hw_cntr(int op,
+				struct torrent_pmu_events *torrent_pmu_events,
+				struct hcall_data *hcall_write);
+extern void ll_link_pmd_write(struct torrent_pmu_events *torrent_pmu_events,
+			      struct hcall_data *hcall_read);
+extern int ll_link_pmd_read(struct torrent_pmu_events *torrent_pmu_events,
+			    struct hcall_data *hcall_read);
+extern int ll_link_get_phys_pmd_reg(u64 event_code);
+
+#endif
diff --git a/arch/powerpc/include/asm/powerbus_mcd_pmu.h b/arch/powerpc/include/asm/powerbus_mcd_pmu.h
new file mode 100644
index 0000000..acd2fcd
--- /dev/null
+++ b/arch/powerpc/include/asm/powerbus_mcd_pmu.h
@@ -0,0 +1,44 @@
+/*
+ * Torrent Performance Monitor
+ *
+ * Copyright Carl Love, Corey Ashford IBM Corporation 2010, 2011
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ASM_POWERBUS_MCD_PMU_H_
+#define __ASM_POWERBUS_MCD_PMU_H_
+
+extern int mcd_compute_pmc_reg(struct torrent_pmu_events *torrent_pmu_events,
+			       struct hcall_data *hcall_write);
+extern int mcd_pmu_check_constraints(
+				struct torrent_pmu_events *torrent_pmu_events,
+				struct unit_config *unit_cfg);
+extern void mcd_enable_disable_hw_cntr(int op,
+				struct torrent_pmu_events *torrent_pmu_events,
+				struct hcall_data *hcall_write);
+extern void mcd_pmd_write(struct torrent_pmu_events *torrent_pmu_events,
+			  struct hcall_data *hcall_read);
+extern int mcd_pmd_read(struct torrent_pmu_events *torrent_pmu_events,
+			struct hcall_data *hcall_read);
+extern int mcd_get_phys_pmd_reg(u64 event_code);
+
+/* The following is the shift/mask for the physical register location */
+#define TORRENT_REG_ATTR_MCD_TYPE_SHIFT	61
+
+#define TORRENT_REG_ATTR_MCD_TYPE_MASK	(0x3ULL << \
+					 TORRENT_REG_ATTR_MCD_TYPE_SHIFT)
+
+#endif
diff --git a/arch/powerpc/include/asm/powerbus_wxyz_pmu.h b/arch/powerpc/include/asm/powerbus_wxyz_pmu.h
new file mode 100644
index 0000000..198ca71
--- /dev/null
+++ b/arch/powerpc/include/asm/powerbus_wxyz_pmu.h
@@ -0,0 +1,38 @@
+/*
+ * Torrent Performance Monitor
+ *
+ * Copyright Carl Love, Corey Ashford IBM Corporation 2010, 2011
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ASM_POWERBUS_WXYZ_PMU_H_
+#define __ASM_POWERBUS_WXYZ_PMU_H_
+
+extern int wxyz_link_compute_pmc_reg(struct torrent_pmu_events *pmu_events,
+				     struct hcall_data *hcall_write);
+extern int wxyz_link_pmu_check_constraints(
+					struct torrent_pmu_events *pmu_events,
+					struct unit_config *unit_cfg);
+extern void wxyz_link_enable_disable_hw_cntr(int op,
+					struct torrent_pmu_events *pmu_events,
+					struct hcall_data *hcall_write);
+extern void wxyz_link_pmd_write(struct torrent_pmu_events *pmu_events,
+				struct hcall_data *hcall_read);
+extern int wxyz_link_pmd_read(struct torrent_pmu_events *pmu_events,
+			      struct hcall_data *hcall_read);
+extern int wxyz_link_get_phys_pmd_reg(u64 event_code);
+
+#endif
diff --git a/arch/powerpc/include/asm/torrent_nest_pmu.h b/arch/powerpc/include/asm/torrent_nest_pmu.h
new file mode 100644
index 0000000..88339cf
--- /dev/null
+++ b/arch/powerpc/include/asm/torrent_nest_pmu.h
@@ -0,0 +1,192 @@
+/*
+ * Torrent Performance Monitor
+ *
+ * Copyright Carl Love, Corey Ashford IBM Corporation 2010, 2011
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ASM_POWERPC_TORRENT_PMU_H_
+#define __ASM_POWERPC_TORRENT_PMU_H_
+
+#include <asm/power_torrent_events.h>
+
+/* Currently, partitions never span octants, which means that exactly one
+ * Torrent chip is visible from each partition.
+ */
+#define MAX_TORRENT_CHIPS	1
+
+/* Max number of counters in each PMU type */
+#define MAX_CNTRS_PER_WXYZ_LINK_PMU	4
+#define MAX_CNTRS_PER_LL_LINK_PMU	7
+#define MAX_CNTRS_PER_BUS_UTIL_PMU	12
+#define MAX_CNTRS_PER_MCD_PMU		4
+#define MAX_CNTRS_PER_MMU_PMU		4
+#define MAX_CNTRS_PER_CAU_PMU		1
+
+/* Overall max of counters across all PMU types */
+#define MAX_CNTRS_TORRENT_PMUS		12
+
+/* Torrent HCall defines */
+#define H_WRITE_TORRENT_PMU_SCOM_REGS	0
+#define H_READ_TORRENT_PMU_SCOM_REGS	1
+
+/* Torrent PowerBus physical register */
+#define PBE_LINKS_TRACE			0
+#define PBE_LINKS_CTRS			1
+#define PBL_LINKS_TRACE_PERF_CTR_CFG	2
+#define PBL_LINKS_CTRS_1		3
+#define PBL_LINKS_CTRS_2		4
+#define PBUS_REG21_PERF_CTR		5
+#define PBUS_REG22_PERF_CTR		6
+#define PBUS_REG23_PERF_CTR		7
+#define PBUS_REG24_PERF_CTR		8
+#define PBUS_REG25_PERF_CTR		9
+#define PBUS_REG26_PERF_CTR		10
+#define PBUS_MCD_PERF_CTRS_CFG		11
+#define PBUS_MCD_PERF_CTRS_SEL		12
+#define PBUS_MCD_PERF_CTRS		13
+#define MAX_HCALL_REGS			14
+
+/* Hcall token IDs and argument array */
+#define PBUS_HCALL_READ			0
+#define PBUS_HCALL_WRITE		1
+#define PBUS_HCALL_LOCK			2
+#define PBUS_HCALL_UNLOCK		3
+
+/* counter use flags */
+#define CNTR_FREE			0
+#define CNTR_ALLOCATED			1  /* event assigned to physical cntr
+					    *  but not being counted yet.
+					    */
+#define CNTR_IN_USE			2  /* event is being counted on its
+					    * assigned physical counter.
+					    */
+
+/* These two structures are defined by PHyp */
+struct tor_pmu_reg {
+	u64 regId;
+	u64 regValue;
+};
+
+struct dump_mmio_perf_counters {
+	/* CAU */
+	u64 cycles_waiting_on_a_credit;
+	/* MMU */
+	u64 G_MMCHIT;
+	u64 G_MMCMIS;
+	u64 G_MMATHIT;
+	u64 G_MMATMIS;
+};
+
+/* Torrent Hcall data structs */
+#define MAX_HCALL_WRITE_ARGS		4
+#define MAX_HCALL_READ_ARGS		8
+struct hcall_data {
+	int num_regs;      /* number of physical registers to read */
+
+	/* Map each Torrent PMU register number to a request array index
+	 * in the Hcall memory buffer, if there is currently is one for
+	 * that register, and if not the mapped value is -1.
+	 */
+	int request_idx[MAX_HCALL_REGS];
+
+	/* Which request index has the virtual PMD value for the
+	 * counter.
+	 */
+	int virt_cntr_to_request_idx
+			[TORRENT_NUM_PMU_TYPES][MAX_CNTRS_TORRENT_PMUS];
+
+	struct tor_pmu_reg tor_pmu_reg[MAX_HCALL_REGS];
+
+	int do_dump_mmio_perf_counters;
+	struct dump_mmio_perf_counters mmio_perf_counters;
+};
+
+#define MAX_TORRENT_PMC_REGS 2
+#define MAX_TORRENT_PMD_REGS 8   /* Maximum number for all PMUs */
+
+#define BUS_UTIL_CNTR_SEL_AVAIL  0xFFFFFFFF /* code for sel field not in use */
+struct unit_config {
+	u8 cntr_state[MAX_CNTRS_TORRENT_PMUS];
+	/* Place any needed PMU-specific config values here
+	 * as a union of structs.
+	 */
+	u64 mcd_cntr_attr;
+	u64 bus_util_enable_mask;
+	u64 bus_util_cntr_sel;
+};
+
+/* This structure tracks the events being counted and being added for an
+ * individual HW PMU.
+ */
+struct torrent_pmu_events {
+	int max_events; /* max physical counters in this PMU */
+	struct unit_config unit; /* PMU configuration array */
+
+	struct perf_event *event[MAX_CNTRS_TORRENT_PMUS];
+	int n_events;  /* number of Torrent events being counted */
+	int n_add;     /* number of Torrent events being added.
+			*/
+	int update;    /* boolean - The number of events has changed
+			* so the PMU hardware needs to be updated.
+			*/
+	int disabled;
+
+	/* The rest of the entries are only used by PMUs whose registers are
+	 * accessed via the Hcall.
+	 */
+	u64 shadow_pmc_reg[MAX_TORRENT_PMC_REGS];
+};
+
+/* The Torrent PMU structure tracks the PMC value written to the HW register so
+ * it is not necessary to read the physical register when updating the value.
+ * This is done to minimize the number of hypervisor and SCOM register reads
+ * that are needed.
+ */
+struct torrent_pmu_counters {
+	int (*check_constraints)(struct torrent_pmu_events *torrent_pmu_events,
+				 struct unit_config *unit_cfg);
+	int (*compute_pmc_regs)(struct torrent_pmu_events *torrent_pmu_events,
+				struct hcall_data *hcall_write);
+	void (*enable_disable_cntr)(int op,
+				struct torrent_pmu_events *torrent_pmu_events,
+				struct hcall_data *hcall_write);
+	int (*read_pmd)(struct torrent_pmu_events *torrent_pmu_events,
+			struct hcall_data *hcall_read);
+	void (*write_pmd)(struct torrent_pmu_events *torrent_pmu_events,
+			  struct hcall_data *hcall_read);
+	int (*get_phys_pmd_reg)(u64 event_code);
+};
+
+/* This is the max number of instances of each type of Torrent PMU.  Currently,
+ * all supported PMUs have a single instance.  Supporting HFI non-windowed
+ * counters would require changing this to 2.
+ */
+#define MAX_TORRENT_PMUS_PER_TYPE	1
+
+struct torrent_events {
+	int count[TORRENT_NUM_PMU_TYPES][MAX_TORRENT_PMUS_PER_TYPE];
+	int max_count[TORRENT_NUM_PMU_TYPES];
+	struct torrent_pmu_counters
+		cntrs[MAX_TORRENT_CHIPS][TORRENT_NUM_PMU_TYPES];
+};
+
+extern void torrent_pmu_enable(struct pmu *pmu);
+extern void torrent_pmu_disable(struct pmu *pmu);
+extern void record_hcall_request_idx(int phys_register_index,
+				     struct hcall_data *hcall_request,
+				     u64 shadow_reg_index);
+#endif
diff --git a/arch/powerpc/kernel/perf_event.c b/arch/powerpc/kernel/perf_event.c
index 822f630..aa1eb43 100644
--- a/arch/powerpc/kernel/perf_event.c
+++ b/arch/powerpc/kernel/perf_event.c
@@ -19,6 +19,8 @@
 #include <asm/firmware.h>
 #include <asm/ptrace.h>
 
+#include <asm/torrent_nest_pmu.h>
+
 struct cpu_hw_events {
 	int n_events;
 	int n_percpu;
@@ -1092,6 +1094,8 @@ static int power_pmu_event_init(struct perf_event *event)
 		break;
 	case PERF_TYPE_RAW:
 		ev = event->attr.config;
+		if (!IS_CORE_EVENT(ev))
+			return -ENOENT;
 		break;
 	default:
 		return -ENOENT;
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index 73e2116..d5db464 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_PPC_PS3)		+= ps3/
 obj-$(CONFIG_EMBEDDED6xx)	+= embedded6xx/
 obj-$(CONFIG_AMIGAONE)		+= amigaone/
 obj-$(CONFIG_PPC_WSP)		+= wsp/
+obj-$(CONFIG_PPC_P7IH)		+= p7ih/
diff --git a/arch/powerpc/platforms/p7ih/Makefile b/arch/powerpc/platforms/p7ih/Makefile
new file mode 100644
index 0000000..5b7b8db
--- /dev/null
+++ b/arch/powerpc/platforms/p7ih/Makefile
@@ -0,0 +1,10 @@
+
+subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
+
+obj-$(CONFIG_PPC_P7IH)	+= mmu_pmu.o powerbus_bus_util_pmu.o \
+				powerbus_ll_pmu.o   \
+				powerbus_mcd_pmu.o  \
+				powerbus_wxyz_pmu.o \
+				mmu_pmu.o \
+				cau_pmu.o \
+				torrent_pmu.o
diff --git a/arch/powerpc/platforms/p7ih/cau_pmu.c b/arch/powerpc/platforms/p7ih/cau_pmu.c
new file mode 100644
index 0000000..3f70298
--- /dev/null
+++ b/arch/powerpc/platforms/p7ih/cau_pmu.c
@@ -0,0 +1,160 @@
+/*
+ * Performance counter support for IBM Torrent interconnect chip
+ *
+ * Copyright 2010, 2011  Carl Love, Corey Ashford, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <asm/torrent_nest_pmu.h>
+
+
+int cau_pmu_check_constraints(struct torrent_pmu_events *pmu_events,
+			      struct unit_config *unit_cfg)
+{
+	int total_events, i;
+	u8 virt_cntr;
+	u64 event_code;
+
+	total_events = pmu_events->n_events + pmu_events->n_add;
+	for (i = pmu_events->n_events; i < total_events; i++) {
+		/*
+		 *  Get the event code from attr.config value as the hw.config
+		 * field is not set yet since the event has not been added.
+		 */
+		event_code = pmu_events->event[i]->attr.config;
+		virt_cntr = (u8)TORRENT_VIRT_CTR_GET(event_code);
+		if (virt_cntr != 0) {
+			pr_err("%s:%d, CAU virt_cntr is %d instead of 0\n",
+			       __func__, __LINE__, virt_cntr);
+			return -1;
+		}
+		if (unit_cfg->cntr_state[virt_cntr] != CNTR_FREE)
+			return -1;
+		unit_cfg->cntr_state[virt_cntr] = CNTR_IN_USE;
+	}
+	return 0;
+}
+
+int cau_compute_pmc_reg(struct torrent_pmu_events *pmu_events,
+			struct hcall_data *hcall_write)
+{
+	int i, total_events;
+	u8 virt_cntr;
+	u64 event_code;
+
+	/*
+	 *There are no control registers in the MMU PMU.  Just
+	 * assign the hw.idx field.
+	 */
+	total_events = pmu_events->n_events + pmu_events->n_add;
+	for (i = 0; i < total_events; i++) {
+		event_code = pmu_events->event[i]->hw.config;
+		virt_cntr = (u8)TORRENT_VIRT_CTR_GET(event_code);
+		if (virt_cntr != 0) {
+			pr_err("%s:%d, CAU virt_cntr is %u instead of 0\n",
+			       __func__, __LINE__, virt_cntr);
+			return -1;
+		}
+		pmu_events->event[i]->hw.idx = virt_cntr;
+	}
+	return 0;
+}
+
+void cau_enable_disable_hw_cntr(int op, struct torrent_pmu_events *pmu_events)
+{
+	/*
+	 * The MMU performance counters are free running, and can't be
+	 * disabled or enabled.
+	 *
+	 * Function is needed as it is an argument to the function
+	 * torrent_pmu_initialize() which is used to initialize each of the
+	 * physical PMUs in the Torrent chip.
+	 */
+}
+
+void cau_pmd_write(struct torrent_pmu_events *pmu_events,
+		   struct hcall_data *hcall_read)
+{
+	int i;
+	u8 virt_cntr;
+	u64 value, event_code;
+
+	for (i = 0; i < pmu_events->n_events; i++) {
+		event_code = pmu_events->event[i]->hw.config;
+		virt_cntr = (u8)TORRENT_VIRT_CTR_GET(event_code);
+		/* CAU PMU has just a single counter */
+		if (virt_cntr != 0) {
+			pr_err("%s:%d, CAU virt_cntr is %u instead of 0\n",
+			       __func__, __LINE__, virt_cntr);
+			return;
+		}
+		if (pmu_events->unit.cntr_state[virt_cntr] != CNTR_FREE) {
+			/*
+			 * The counters are stopped.  The HCall to
+			 * read the counters has been done.  The
+			 * current count must be set to the previous
+			 * count.  The counters will be enabled.
+			 * When the counters are stopped and read
+			 * again, the actual count will be the
+			 * new count minus the previous count.
+			 */
+			value = hcall_read->
+				mmio_perf_counters.cycles_waiting_on_a_credit;
+			local64_set(&pmu_events->event[i]->hw.prev_count,
+				    value);
+		}
+	}
+}
+
+int cau_pmd_read(struct torrent_pmu_events *pmu_events,
+		 struct hcall_data *hcall_read)
+{
+	/*
+	 * This PMU is accessed via hypervisor calls.  The HCall to read the
+	 * counters has been done.  The counter data is in hcall_read.
+	 */
+	int i;
+	u8  virt_cntr;
+	u64 value, prev, delta;
+	struct perf_event *event;
+
+	for (i = 0; i < pmu_events->n_events; i++) {
+		event = pmu_events->event[i];
+		virt_cntr = (u8)TORRENT_VIRT_CTR_GET(event->hw.config);
+		/* CAU PMU has just a single counter */
+		if (virt_cntr != 0) {
+			pr_err("%s:%d, CAU virt_cntr is %d instead of 0\n",
+			       __func__, __LINE__, virt_cntr);
+			return -1;
+		}
+		if (pmu_events->unit.cntr_state[virt_cntr] == CNTR_IN_USE) {
+			/*
+			 *Get the initial value, which was saved by the pmd
+			 * write call into prev_count.
+			 */
+			prev = local64_read(
+				&event->hw.prev_count);
+
+			value = hcall_read->
+				mmio_perf_counters.cycles_waiting_on_a_credit;
+
+			/* calculate/save the count */
+			delta = value - prev;
+			local64_add(delta, &event->count);
+			local64_set(&event->hw.prev_count, value);
+		}
+	}
+	return 0;
+}
+
+int cau_get_phys_pmd_reg(u64 event_code)
+{
+	/* This function never should be called */
+	return -1;
+}
diff --git a/arch/powerpc/platforms/p7ih/mmu_pmu.c b/arch/powerpc/platforms/p7ih/mmu_pmu.c
new file mode 100644
index 0000000..4d6d5c2
--- /dev/null
+++ b/arch/powerpc/platforms/p7ih/mmu_pmu.c
@@ -0,0 +1,156 @@
+/*
+ * Performance counter support for IBM Torrent interconnect chip
+ *
+ * Copyright 2010, 2011  Carl Love, Corey Ashford, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <asm/torrent_nest_pmu.h>
+
+u64 get_mmu_counter_value(struct hcall_data *hcall_read, u8 virt_cntr)
+{
+	switch (virt_cntr) {
+	case 0:
+		return hcall_read->mmio_perf_counters.G_MMCHIT;
+	case 1:
+		return hcall_read->mmio_perf_counters.G_MMCMIS;
+	case 2:
+		return hcall_read->mmio_perf_counters.G_MMATHIT;
+	case 3:
+		return hcall_read->mmio_perf_counters.G_MMATMIS;
+	default:
+		pr_err("MMU event code has illegal virt counter field: %u",
+		       virt_cntr);
+		return 0;
+	}
+}
+
+int mmu_pmu_check_constraints(struct torrent_pmu_events *pmu_events,
+			      struct unit_config *unit_cfg)
+{
+	int total_events, i;
+	u8 virt_cntr;
+	u64 event_code;
+
+	total_events = pmu_events->n_events + pmu_events->n_add;
+	for (i = pmu_events->n_events; i < total_events; i++) {
+		/*
+		 * Get the event code from attr.config value as the hw.config
+		 * field is not set yet since the event has not been added.
+		 */
+		event_code = pmu_events->event[i]->attr.config;
+		virt_cntr = (u8)TORRENT_VIRT_CTR_GET(event_code);
+
+		if (unit_cfg->cntr_state[virt_cntr] == CNTR_IN_USE)
+			return -1;
+
+		unit_cfg->cntr_state[virt_cntr] = CNTR_IN_USE;
+	}
+	return 0;
+}
+
+int mmu_compute_pmc_reg(struct torrent_pmu_events *pmu_events,
+			struct hcall_data *hcall_write)
+{
+	int i, total_events;
+	u8 virt_cntr;
+	u64 event_code;
+
+	/*
+	 * There are no control registers in the MMU PMU.  Just
+	 * assign the hw.idx field.
+	 */
+	total_events = pmu_events->n_events + pmu_events->n_add;
+	for (i = 0; i < total_events; i++) {
+		event_code = pmu_events->event[i]->hw.config;
+		virt_cntr = (u8)TORRENT_VIRT_CTR_GET(event_code);
+		pmu_events->event[i]->hw.idx = virt_cntr;
+	}
+	return 0;
+}
+
+void mmu_enable_disable_hw_cntr(int op, struct torrent_pmu_events *pmu_events)
+{
+	/*
+	 * The MMU performance counters are free running, and can't be
+	 * disabled or enabled.
+	 *
+	 * Function is needed as it is an argument to the function
+	 * torrent_pmu_initialize() which is used to initialize each of the
+	 * physical PMUs in the Torrent chip.
+	 */
+}
+
+void mmu_pmd_write(struct torrent_pmu_events *pmu_events,
+		   struct hcall_data *hcall_read)
+{
+	int i;
+	u8 virt_cntr;
+	u64 value, event_code;
+
+	for (i = 0; i < pmu_events->n_events; i++) {
+		event_code = pmu_events->event[i]->hw.config;
+		virt_cntr = (u8)TORRENT_VIRT_CTR_GET(event_code);
+
+		if (pmu_events->unit.cntr_state[virt_cntr] == CNTR_IN_USE) {
+			/*
+			 * The counters are stopped.  The HCall to
+			 * read the counters has been done.  The
+			 * current count must be set to the previous
+			 * count.  The counters will be enabled.
+			 * When the counters are stopped and read
+			 * again, the actual count will be the
+			 * new count minus the previous count.
+			 */
+			value = get_mmu_counter_value(hcall_read, virt_cntr);
+			local64_set(&pmu_events->event[i]->hw.prev_count,
+				    value);
+		}
+	}
+}
+
+int mmu_pmd_read(struct torrent_pmu_events *pmu_events,
+		 struct hcall_data *hcall_read)
+{
+	/*
+	 * This PMU is accessed via hypervisor calls.  The HCall to read the
+	 * counters has been done.  The counter data is in hcall_read.
+	 */
+	int i;
+	u8 virt_cntr;
+	u64 value, prev, delta;
+	struct perf_event *event;
+
+	for (i = 0; i < pmu_events->n_events; i++) {
+		event = pmu_events->event[i];
+		virt_cntr = (u8)TORRENT_VIRT_CTR_GET(event->hw.config);
+
+		if (pmu_events->unit.cntr_state[virt_cntr] == CNTR_IN_USE) {
+			/*
+			 * Get the initial value, which was saved by the pmd
+			 * write call into prev_count.
+			 */
+			prev = local64_read(&event->hw.prev_count);
+
+			value = get_mmu_counter_value(hcall_read, virt_cntr);
+
+			/* calculate/save the count */
+			delta = value - prev;
+			local64_add(delta, &event->count);
+			local64_set(&event->hw.prev_count, value);
+		}
+	}
+	return 0;
+}
+
+int mmu_get_phys_pmd_reg(u64 event_code)
+{
+	/* This function never should be called */
+	return -1;
+}
diff --git a/arch/powerpc/platforms/p7ih/powerbus_bus_util_pmu.c b/arch/powerpc/platforms/p7ih/powerbus_bus_util_pmu.c
new file mode 100644
index 0000000..213c500
--- /dev/null
+++ b/arch/powerpc/platforms/p7ih/powerbus_bus_util_pmu.c
@@ -0,0 +1,410 @@
+/*
+ * Performance counter support for IBM Torrent interconnect chip
+ *
+ * Copyright 2010, 2011  Carl Love, Corey Ashford, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <asm/torrent_nest_pmu.h>
+#include <asm/powerbus_mcd_pmu.h>
+#include <asm/power_torrent_events.h>
+
+#define BUS_UTIL_PMC_FIELD_WIDTH		8
+#define NUM_BUS_UTIL_PMC_REGS			4
+#define BUS_UTIL_CNTR_SIZE			16
+#define BUS_UTIL_OPCODE_MASK			0xFF
+#define NUM_BUS_UTIL_COUNTERS			4
+
+#define BUS_UTIL_APM_ENABLE_MASK		0x8000000000000000UL
+#define BUS_UTIL_PMU_ENABLE_MASK		0x1000000000000000UL
+#define BUS_UTIL_16_BIT_CNTR			16
+#define BUS_UTIL_32_BIT_CNTR			32
+#define BUS_UTIL_16_BIT_CNTR_MASK		0xFFFF
+#define BUS_UTIL_32_BIT_CNTR_MASK		0xFFFFFFFF
+#define BUS_UTIL_SHADOW_REG21			0
+#define BUS_UTIL_SHADOW_REG22			1
+#define BUS_UTIL_SHADOW_REG23			2
+#define BUS_UTIL_SHADOW_REG24			3
+#define BUS_UTIL_SHADOW_REG25			4
+#define BUS_UTIL_SHADOW_REG26			5
+#define BUS_UTIL_REG21_SEL_BASE                 (63 - 2)
+#define BUS_UTIL_HI_COMP_BASE                   (63 - 10)
+#define BUS_UTIL_LO_COMP_BASE                   (63 - 15)
+
+/*
+ * Bus utilization counters consist of a couple of configurable counters and
+ * a set of 10 dedicated counters.  Register 21 has two enable bits:
+ * pb_cfg_apm_en and pb_cfg_pmucnt_en.  Only one of these bits can be set at
+ * a time.  The pb_cfg_apm_en enables the two 16-bit counters to count event.
+ * The pb_cfg_pmucnt_en enable is used to enable the counters to count the
+ * events specified in the pb_cfg_pmucnt_sel field.  The select field options
+ * are:
+ *    00 - rcmd0    (reflected command 0)
+ *    01 - rcmd1    (reflected command 1)
+ *    1x - rcmd0 or rcmd 1
+ *
+ * The counters in registers 22 to 26 are enabled if pb_cfg_apm_en OR
+ * pb_cfg_pmucnt_en are enabled.
+ */
+
+int virtual_cntr_to_phys_reg(u8 virt_cntr)
+{
+	int phys_reg_num;
+
+	/*
+	 * Map event to the physical hardware register that has the counter to
+	 * count the specified event.
+	 */
+
+	switch (virt_cntr) {
+	case 0:
+	case 1:
+		phys_reg_num = PBUS_REG21_PERF_CTR;
+		break;
+
+	case 2:
+	case 3:
+		phys_reg_num = PBUS_REG22_PERF_CTR;
+		break;
+
+	case 4:
+	case 5:
+		phys_reg_num = PBUS_REG23_PERF_CTR;
+		break;
+
+	case 6:
+	case 7:
+		phys_reg_num = PBUS_REG24_PERF_CTR;
+		break;
+
+	case 8:
+	case 9:
+		phys_reg_num = PBUS_REG25_PERF_CTR;
+		break;
+
+	case 10:
+	case 11:
+		phys_reg_num = PBUS_REG26_PERF_CTR;
+		break;
+
+	default:
+		pr_err("%s, %d ERROR not able to map virt counter to physical register\n",
+			__func__, __LINE__);
+		phys_reg_num = -1;
+		break;
+	}
+	return phys_reg_num;
+}
+
+int virt_cntr_to_shadow_reg(u8 virt_cntr)
+{
+	int phys_reg;
+
+	/*
+	 * Map the virtual counter that counts the specified event to the
+	 * physical register that contains the counter for that event.
+	 *
+	 * virtual counters 0, 1 are in BUS_UTIL_SHADOW_REG21  (index 0)
+	 * virtual counters 2, 3 are in BUS_UTIL_SHADOW_REG22
+	 * virtual counters 4, 5 are in BUS_UTIL_SHADOW_REG23
+	 * virtual counters 6, 7 are in BUS_UTIL_SHADOW_REG24
+	 * virtual counters 8, 9 are in BUS_UTIL_SHADOW_REG25
+	 * virtual counters 10, 11 are in BUS_UTIL_SHADOW_REG26  (index 5)
+	 */
+
+	if (virt_cntr < 12) {
+		phys_reg = virt_cntr >> 1;  /* just divide virt counter by 2 */
+	} else {
+		pr_err("%s, %d ERROR not able to map virtual counter to physical register number..\n",
+			__func__, __LINE__);
+		phys_reg = -1;
+	}
+	return phys_reg;
+}
+
+int bus_util_pmu_check_constraints(struct torrent_pmu_events *pmu_events,
+				   struct unit_config *unit_cfg)
+{
+	int i, total_events;
+	u8 virt_cntr;
+	u64 event_code, sel, enable_mask;
+
+	total_events = pmu_events->n_events + pmu_events->n_add;
+
+	for (i = pmu_events->n_events; i < total_events; i++) {
+		if (pmu_events->unit.cntr_state[i] != CNTR_FREE)
+			/*
+			 * Each event has an assigned counter that is used to
+			 * count the event.  If the counter is already in use,
+			 * the constraint check fails.
+			 */
+			return -1;
+
+		/*
+		 * Get the event code from attr.config value as the hw.config
+		 * field is not set yet since the event has not been added.
+		 */
+		event_code = pmu_events->event[i]->attr.config;
+		virt_cntr = TORRENT_VIRT_CTR_GET(event_code);
+
+		if ((virt_cntr >= 0) && (virt_cntr <= 3)) {
+			/* Check constraints for the reg21 and reg22
+			 * registers.
+			 *
+			 * The sel field is shared by counters 0 through 3.
+			 * The enable bits define which set of events the
+			 * counters can count.
+			 */
+			if (TORRENT_MUX_GET(event_code) == 0)
+				/* APM event */
+				enable_mask = BUS_UTIL_APM_ENABLE_MASK;
+			else
+				/* PMU event */
+				enable_mask = BUS_UTIL_PMU_ENABLE_MASK;
+
+			if (unit_cfg->bus_util_enable_mask == 0)
+				/* PMU configuration is not set yet */
+				unit_cfg->bus_util_enable_mask = enable_mask;
+
+			else
+				if (unit_cfg->bus_util_enable_mask
+				    != enable_mask)
+					/* event and PMU config conflict */
+					return -1;
+
+			sel = TORRENT_ATTR_UTIL_SEL_MASK & event_code;
+
+			if (unit_cfg->bus_util_cntr_sel
+			    == BUS_UTIL_CNTR_SEL_AVAIL)
+					unit_cfg->bus_util_cntr_sel = sel;
+			else if (unit_cfg->bus_util_cntr_sel != sel)
+				/*
+				 * PMU sel configuration and event sel
+				 * value are not compatible.
+				 */
+				return -1;
+		}
+
+		/*
+		 * Assign the event to the counter but it has not been
+		 * enabled yet.
+		 */
+		unit_cfg->cntr_state[virt_cntr] = CNTR_ALLOCATED;
+	}
+	return 0;
+}
+
+int bus_util_compute_pmc_reg(struct torrent_pmu_events *pmu_events,
+			     struct hcall_data *hcall_write)
+{
+
+	int i, phys_reg, total_events, shift;
+	u8 virt_cntr;
+	u64 event_code, sel, comp;
+
+	/*
+	 * The assumption is that we have passed the constraint test before
+	 * this routine is called so we know that for the counter configuration
+	 * (two or four counters) there are enough counters available for the
+	 * new events.
+	 */
+
+	total_events = pmu_events->n_events + pmu_events->n_add;
+
+	for (i = 0; i < total_events; i++) {
+		event_code = pmu_events->event[i]->hw.config;
+		virt_cntr = TORRENT_VIRT_CTR_GET(event_code);
+
+		pmu_events->event[i]->hw.idx = virt_cntr;
+
+		phys_reg = virtual_cntr_to_phys_reg(virt_cntr);
+		if (phys_reg == -1)
+			return -1;  /* could not map event to phys_reg */
+
+		/*
+		 * Assign the event to the counter but it has not been
+		 * enabled yet.
+		 */
+		pmu_events->unit.cntr_state[virt_cntr] = CNTR_ALLOCATED;
+
+		if (phys_reg >= PBUS_REG23_PERF_CTR)
+			/* no additional configuration information to write */
+			return 0;
+
+		/* set the sel and comp fields */
+		shift = 63 + TORRENT_ATTR_UTIL_SEL_SHIFT
+						- BUS_UTIL_REG21_SEL_BASE;
+		pmu_events->shadow_pmc_reg[virt_cntr] &=
+					~(TORRENT_ATTR_UTIL_SEL_MASK << shift);
+
+		sel = (pmu_events->unit.bus_util_cntr_sel) << shift;
+
+		comp = event_code && TORRENT_ATTR_UTIL_CMP_MASK;
+		switch (virt_cntr) {
+		case 0:
+		case 2:
+			shift = 63 + TORRENT_ATTR_UTIL_CMP_SHIFT
+				- BUS_UTIL_HI_COMP_BASE;
+			break;
+
+		case 1:
+		case 3:
+			shift = 63 + TORRENT_ATTR_UTIL_CMP_SHIFT
+				- BUS_UTIL_LO_COMP_BASE;
+			break;
+
+		default:
+			pr_err("%s, ERROR, virtual counter value not in expected range. virt_cntr = %u\n",
+				__func__, virt_cntr);
+			return -1;
+			break;
+
+		}
+		comp = comp << shift;
+		pmu_events->shadow_pmc_reg[virt_cntr]
+			&= ~(TORRENT_ATTR_UTIL_CMP_MASK << shift);
+
+		pmu_events->shadow_pmc_reg[virt_cntr] |= comp
+				|| pmu_events->unit.bus_util_cntr_sel;
+
+		/* Configuration register needs to be written */
+		record_hcall_request_idx(phys_reg, hcall_write,
+					pmu_events->shadow_pmc_reg[virt_cntr]);
+	}
+	return 0;
+}
+
+void bus_util_enable_disable_hw_cntr(int op,
+				     struct torrent_pmu_events *pmu_events,
+				     struct hcall_data *hcall_write)
+{
+	int index, cntr_num, phys_reg;
+	u8 virt_cntr;
+	u64 enable_bit;
+
+	for (cntr_num = 0; cntr_num < pmu_events->max_events;
+	     cntr_num++) {
+		if (pmu_events->unit.cntr_state[cntr_num] != CNTR_FREE) {
+			/*
+			 * Which enable bit to use is based on what events
+			 * the first two counters are counting.  The compute
+			 * function will set the needed enable bit based on
+			 * the events being counted.  The physical register
+			 * for virtual counter 0 contains the enable bits used
+			 * by all of the counters.
+			 */
+			virt_cntr = 0;
+			if (pmu_events->unit.bus_util_enable_mask == 0)
+				/*
+				 * No REG21 events are configured, set the
+				 * enable to APM enable to enable the counters
+				 * for the other registers.
+				 */
+				enable_bit = BUS_UTIL_APM_ENABLE_MASK;
+			else
+				enable_bit = pmu_events->
+						unit.bus_util_enable_mask;
+
+			phys_reg = virtual_cntr_to_phys_reg(virt_cntr);
+			index = virt_cntr_to_shadow_reg(virt_cntr);
+
+			/*
+			 * The enable bits for the first two counters are used
+			 * to control all of the counters.
+			 */
+			if (op) {
+				pmu_events->shadow_pmc_reg[index] |=
+								enable_bit;
+				pmu_events->unit.cntr_state[cntr_num] =
+								CNTR_IN_USE;
+			} else if (pmu_events->unit.cntr_state[cntr_num]
+				   == CNTR_IN_USE)
+				/*
+				 * Disable only if the counter is actually
+				 * in use.
+				 */
+				pmu_events->shadow_pmc_reg[index] &=
+								~enable_bit;
+
+			/* get entry, record which PMC needs to be written */
+			record_hcall_request_idx(phys_reg, hcall_write,
+						 pmu_events->
+						 shadow_pmc_reg[index]);
+		}
+	}
+}
+
+void bus_util_pmd_write(struct torrent_pmu_events *pmu_events,
+			struct hcall_data *hcall_read)
+{
+	int i, index;
+	u8 virt_cntr;
+	u64 value, event_code;
+
+	for (i = 0; i < pmu_events->n_events; i++) {
+		event_code = pmu_events->event[i]->hw.config;
+		virt_cntr = (u8)pmu_events->event[i]->hw.idx;
+
+		if (pmu_events->unit.cntr_state[virt_cntr] == CNTR_IN_USE) {
+			index = hcall_read->virt_cntr_to_request_idx
+					[TORRENT_PBUS_UTIL_ID][virt_cntr];
+			value = hcall_read->tor_pmu_reg[index].regValue;
+
+			local64_set(&pmu_events->event[i]->hw.prev_count,
+				    value);
+		}
+	}
+}
+
+int bus_util_pmd_read(struct torrent_pmu_events *pmu_events,
+		      struct hcall_data *hcall_read)
+{
+	/*
+	 * This PMU is accessed via hypervisor calls.  The HCall to read the
+	 * counters has been done.  The counter data is in hcall_read.
+	 */
+	int i, index;
+	u8 virt_cntr;
+	u64 value, prev, delta;
+	struct perf_event *event;
+
+	for (i = 0; i < pmu_events->n_events; i++) {
+		event = pmu_events->event[i];
+		virt_cntr = (u8)pmu_events->event[i]->hw.idx;
+
+		if (pmu_events->unit.cntr_state[virt_cntr] == CNTR_IN_USE) {
+			/*
+			 * Read the PMD register.  Its count value is the
+			 * current value minus the previous value from when
+			 * the counter was started.
+			 */
+
+			 /* get current count, from the HCall */
+			index =	hcall_read->virt_cntr_to_request_idx
+					[TORRENT_PBUS_UTIL_ID][virt_cntr];
+
+			/*
+			 * Get initial value, which was saved by the pmd write
+			 * call into prev_count.
+			 */
+			prev = local64_read(&event->hw.prev_count);
+			value = hcall_read->tor_pmu_reg[index].regValue;
+			delta = ((value - prev) & BUS_UTIL_16_BIT_CNTR_MASK);
+
+			local64_add(delta, &event->count);
+			local64_set(&event->hw.prev_count, value);
+		}
+	}
+	return 0;
+}
+
+int bus_util_get_phys_pmd_reg(u64 event_code)
+{
+	return virtual_cntr_to_phys_reg(TORRENT_VIRT_CTR_GET(event_code));
+}
diff --git a/arch/powerpc/platforms/p7ih/powerbus_ll_pmu.c b/arch/powerpc/platforms/p7ih/powerbus_ll_pmu.c
new file mode 100644
index 0000000..bf8d453
--- /dev/null
+++ b/arch/powerpc/platforms/p7ih/powerbus_ll_pmu.c
@@ -0,0 +1,273 @@
+/*
+ * Performance counter support for IBM Torrent interconnect chip
+ *
+ * Copyright 2010, 2011  Carl Love, Corey Ashford, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <asm/torrent_nest_pmu.h>
+#include <asm/powerbus_ll_pmu.h>
+#include <asm/power_torrent_events.h>
+
+#define LL_PMC_FIELD_WIDTH	4
+#define LL_NUM_VIRT_CTRS	7
+#define LL_CTR_SIZE		16
+#define LL_OPCODE_MASK		0x7ULL
+#define LL_PMD_MASK		0xFFFFULL
+#define LL_ENABLE_MASK		(1ULL << (63 - 6))
+#define LL_SHADOW_IDX		0
+
+#define PB_CFG_PERF_CNT_MODE	(1ULL << (63 - 7))
+
+int ll_link_pmu_check_constraints(struct torrent_pmu_events *pmu_events,
+				  struct unit_config *unit_cfg)
+{
+	/*
+	 * Check that there is only one event for each link (LL0..LL7)
+	 * being counted at a time.
+	 */
+	int i, total_events;
+	u8 virt_cntr;
+	u64 event_code;
+
+	total_events = pmu_events->n_events + pmu_events->n_add;
+
+	for (i = pmu_events->n_events; i < total_events; i++) {
+		/*
+		 * Get the event code from attr.config value as the hw.config
+		 * field is not set yet since the event has not been added.
+		 */
+		event_code = pmu_events->event[i]->attr.config;
+		virt_cntr = (u8)TORRENT_VIRT_CTR_GET(event_code);
+		if (unit_cfg->cntr_state[virt_cntr] != CNTR_FREE)
+			return -1;
+
+		/*
+		 * Assign the event to the counter but it has not been
+		 * enabled yet.
+		 */
+		unit_cfg->cntr_state[virt_cntr] = CNTR_ALLOCATED;
+	}
+	return 0;
+}
+
+int ll_link_compute_pmc_reg(struct torrent_pmu_events *pmu_events,
+			    struct hcall_data *hcall_write)
+{
+	int i, total_events, shift_by;
+	u64 event_code;
+	u8 mux, virt_cntr;
+
+	total_events = pmu_events->n_events + pmu_events->n_add;
+
+	for (i = 0; i < total_events; i++) {
+		event_code = pmu_events->event[i]->hw.config;
+		virt_cntr = (u8)TORRENT_VIRT_CTR_GET(event_code);
+		pmu_events->event[i]->hw.idx = virt_cntr;
+		mux = (u8) TORRENT_MUX_GET(event_code);
+
+		/*
+		 * The PBL_LINKS_TRACE_PERF_CTR_CFG event fields are:
+		 *   LL0 counter [52:49]
+		 *   LL1 counter [48:45]
+		 *   LL2 counter [44:41]
+		 *   LL3 counter [40:37]
+		 *   LL4 counter [36:33]
+		 *   LL5 counter [32:29]
+		 *   LL6 counter [28:25]
+		 */
+		shift_by = 25 +	(LL_NUM_VIRT_CTRS - virt_cntr - 1)
+							  * LL_PMC_FIELD_WIDTH;
+
+		pmu_events->shadow_pmc_reg[LL_SHADOW_IDX]
+				&= ~(LL_OPCODE_MASK << shift_by);
+		pmu_events->shadow_pmc_reg[LL_SHADOW_IDX]
+				|= (u64)mux << shift_by | PB_CFG_PERF_CNT_MODE;
+
+		/* record which PMC needs to be written */
+		record_hcall_request_idx(PBL_LINKS_TRACE_PERF_CTR_CFG,
+					 hcall_write,
+					 pmu_events->
+					 shadow_pmc_reg[LL_SHADOW_IDX]);
+	}
+	return 0;
+}
+
+void ll_link_enable_disable_hw_cntr(int op,
+				    struct torrent_pmu_events *pmu_events,
+				    struct hcall_data *hcall_write)
+{
+	int cntr_num;
+
+	for (cntr_num = 0; cntr_num < pmu_events->max_events;
+	     cntr_num++) {
+		if (op) {
+			/* enable if cntr is in use or has been allocated */
+			if (pmu_events->unit.cntr_state[cntr_num] !=
+			   CNTR_FREE) {
+				pmu_events->shadow_pmc_reg[LL_SHADOW_IDX] |=
+					LL_ENABLE_MASK;
+				pmu_events->unit.cntr_state[cntr_num] =
+					CNTR_IN_USE;
+			}
+		} else {
+			/* disable, only if the counter is actually in use */
+			if (pmu_events->unit.cntr_state[cntr_num] ==
+			   CNTR_IN_USE)
+				pmu_events->shadow_pmc_reg[LL_SHADOW_IDX] &=
+					~LL_ENABLE_MASK;
+		}
+
+		/* record which PMC needs to be written */
+		record_hcall_request_idx(PBL_LINKS_TRACE_PERF_CTR_CFG,
+					 hcall_write,
+					 pmu_events->shadow_pmc_reg
+					 [LL_SHADOW_IDX]);
+	}
+}
+
+void ll_link_pmd_write(struct torrent_pmu_events *pmu_events,
+		       struct hcall_data *hcall_read)
+{
+	/*
+	 * The physical counters are 16 bits wide each.
+	 * The eight counters are packed into two registers:
+	 *    LL0 counter -> PBL Links Counters 1  [47:32]
+	 *    LL1 counter -> PBL Links Counters 1  [31:16]
+	 *    LL2 counter -> PBL Links Counters 1  [15:0]
+	 *    LL3 counter -> PBL Links Counters 2  [63:48]
+	 *    LL4 counter -> PBL Links Counters 2  [47:32]
+	 *    LL5 counter -> PBL Links Counters 2  [31:16]
+	 *    LL6 counter -> PBL Links Counters 2  [15:0]
+	 */
+
+	/*
+	 * The PMD can only be accessed via an HCall.  The four counters are
+	 * packed into a single register.  It is not practical to read the
+	 * register, reset one counter field, then write the counter back.
+	 * Secondly, being able to write a non-zero value is only needed when
+	 * collecting a profile.  Profiling on non-CPU counters doesn't make
+	 * sense since there is no reliable way to associate the number of
+	 * events that have occurred back to a specific instruction.
+	 * Therefore, we will not support writing a value.  The enable/disable
+	 * HCall will need to sample the counts before the counter is enabled
+	 * and then generate a delta count when the counters are disabled
+	 */
+	int i, index;
+	u8 virt_cntr;
+	u64 event_code, value;
+
+	for (i = 0; i < pmu_events->n_events; i++) {
+		event_code = pmu_events->event[i]->hw.config;
+		virt_cntr = TORRENT_VIRT_CTR_GET(event_code);
+
+		if (pmu_events->unit.cntr_state[virt_cntr] == CNTR_IN_USE) {
+			/*
+			 * The counters are stopped.  The HCall to
+			 * read the counters has been done.  The
+			 * current count must be set to the previous
+			 * count.  The counters will be enabled.
+			 * When the counters are stopped and read
+			 * again, the actual count will be the
+			 * new count minus the previous count.
+			 */
+
+			/*
+			 * Get the request entry that contains the PMD for
+			 * this virtual counter that is in use.
+			 */
+			index = hcall_read->virt_cntr_to_request_idx
+				[TORRENT_PBUS_LL_ID][virt_cntr];
+
+			value = hcall_read->tor_pmu_reg[index].regValue;
+			if (virt_cntr < 3)
+				value = value >> ((2 - virt_cntr)
+						  * LL_CTR_SIZE) & LL_PMD_MASK;
+			else
+				value = value >> ((6 - virt_cntr)
+						  * LL_CTR_SIZE) & LL_PMD_MASK;
+			local64_set(&pmu_events->event[i]->hw.prev_count,
+				    value);
+		}
+	}
+}
+
+int ll_link_pmd_read(struct torrent_pmu_events *pmu_events,
+		     struct hcall_data *hcall_read)
+{
+	/*
+	 * This PMU is accessed via hypervisor calls.  The HCall to read the
+	 * counters has been done.  The counter data is in hcall_read.
+	 */
+	int i, index;
+	u8 virt_cntr;
+	u64 value, prev, delta;
+	struct perf_event *event;
+
+	/*
+	 * The physical counters are 16 bits wide each.
+	 * The eight counters are packed into two registers:
+	 *    LL0 counter -> PBL Links Counters 1  [47:32]
+	 *    LL1 counter -> PBL Links Counters 1  [31:16]
+	 *    LL2 counter -> PBL Links Counters 1  [15:0]
+	 *    LL3 counter -> PBL Links Counters 2  [63:48]
+	 *    LL4 counter -> PBL Links Counters 2  [47:32]
+	 *    LL5 counter -> PBL Links Counters 2  [31:16]
+	 *    LL6 counter -> PBL Links Counters 2  [15:0]
+	 */
+
+	for (i = 0; i < pmu_events->n_events; i++) {
+		event = pmu_events->event[i];
+		virt_cntr = (u8)TORRENT_VIRT_CTR_GET(event->hw.config);
+
+		if (pmu_events->unit.cntr_state[virt_cntr] == CNTR_IN_USE) {
+			/*
+			 * Read the PMD register.  Its count value is the
+			 * current value minus the previous value from when
+			 * the counter was started.
+			 */
+
+			/* get current count, from the HCall */
+			index =	hcall_read->virt_cntr_to_request_idx
+				[TORRENT_PBUS_LL_ID][virt_cntr];
+
+			/*
+			 * Get initial value, which was saved by the pmd write
+			 * call into prev_count.
+			 */
+			prev = local64_read(&event->hw.prev_count);
+			value = hcall_read->tor_pmu_reg[index].regValue;
+
+			if (virt_cntr < 3)
+				value = value >> ((2 - virt_cntr)
+						  * LL_CTR_SIZE) & LL_PMD_MASK;
+			else
+				value = value >> ((6 - virt_cntr)
+						  * LL_CTR_SIZE) & LL_PMD_MASK;
+
+			/* calculate/save the count */
+			delta = ((value - prev) & 0xffffUL) << 16;
+			local64_add(delta, &event->count);
+			local64_set(&event->hw.prev_count, value);
+		}
+	}
+	return 0;
+}
+
+int ll_link_get_phys_pmd_reg(u64 event_code)
+{
+	int virt_cntr = TORRENT_VIRT_CTR_GET(event_code);
+
+	if (virt_cntr < 3)
+		/* LL0..LL2 */
+		return PBL_LINKS_CTRS_1;
+	else
+		/* LL3.. LL6 */
+		return PBL_LINKS_CTRS_2;
+}
diff --git a/arch/powerpc/platforms/p7ih/powerbus_mcd_pmu.c b/arch/powerpc/platforms/p7ih/powerbus_mcd_pmu.c
new file mode 100644
index 0000000..57070e5
--- /dev/null
+++ b/arch/powerpc/platforms/p7ih/powerbus_mcd_pmu.c
@@ -0,0 +1,492 @@
+/*
+ * Performance counter support for IBM Torrent interconnect chip
+ *
+ * Copyright 2010, 2011  Carl Love, Corey Ashford, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <asm/torrent_nest_pmu.h>
+#include <asm/powerbus_mcd_pmu.h>
+#include <asm/power_torrent_events.h>
+
+#define MCD_PMC_FIELD_WIDTH		8
+#define NUM_MCD_PMC_REGS		4
+#define MCD_CNTR_SIZE			16
+#define MCD_OPCODE_MASK			0xFF
+#define NUM_MCD_COUNTERS		4
+#define MCD_ENABLE_MASK			0x8000000000000000ULL
+#define MCD_UNIT_ROUTE_MASK		0x1L
+#define MCD_UNIT_ROUTE_CLEAR_MASK	0x11L
+#define MCD_16_BIT_CNTR			16
+#define MCD_32_BIT_CNTR			32
+#define MCD_16_BIT_CNTR_MASK		0xFFFF
+#define MCD_32_BIT_CNTR_MASK		0xFFFFFFFF
+#define MCD_CFG_SHADOW_REG_IDX		0
+#define MCD_SEL_SHADOW_REG_IDX		1
+
+u64 get_counter_attr(u64 event_code)
+{
+	u64 event_counter_type;
+
+	/* extract the counter type from the attribute field */
+	event_counter_type = TORRENT_ATTR_MCD_TYPE_MASK & event_code;
+
+	/*
+	 * Move the type field to the location for the physical
+	 * register.
+	 */
+	event_counter_type >>= TORRENT_ATTR_MCD_TYPE_SHIFT;
+
+	return event_counter_type;
+}
+
+int mcd_get_prescale(u64 event_counter_type)
+{
+	switch (event_counter_type) {
+	case 0x0L:    /* two 64-bit counters with 32-bit prescale */
+		return 32;
+		break;
+
+		/* four 32-bit counters with 16-bit prescale */
+	case 0x1L:
+		return 16;
+		break;
+
+		/* two 32-bit counters no prescale. */
+	case 0x2L:
+		/* four 16-bit counters no prescale. */
+	case 0x3L:
+		return 0;
+		break;
+
+	default:
+		pr_err("%s ERROR, UNKNOWN counter configuration setting 0x%Lx.\n",
+		       __func__, event_counter_type);
+		return -1;
+	}
+}
+
+int mcd_get_num_ctrs(u64 event_counter_type)
+{
+	switch (event_counter_type) {
+		/* two 64-bit counters with 32-bit prescale */
+	case 0x0L:
+		/* two 32-bit counters no prescale. */
+	case 0x2L:
+		return 2;
+		break;
+
+		/* four 32-bit counters with 16-bit prescale */
+	case 0x1L:
+		/* four 16-bit counters no prescale. */
+	case 0x3L:
+		return 4;
+		break;
+
+	default:
+		pr_err("%s ERROR, UNKNOWN counter configuration setting, 0x%Lx.\n",
+		       __func__, event_counter_type);
+		return -1;
+	}
+}
+
+int mcd_assign_counter(u8 *physical_counter_num,
+		       struct torrent_pmu_events *pmu_events,
+		       int num_config_cntrs)
+{
+	int i;
+	/*
+	 * If the physical_counter_num is not equal to -1, then the event
+	 * has already been assigned to a counter.  Otherwise, assign
+	 * physical_counter_num to the next available counter.
+	 */
+
+	/* Look for first available counter, assign it */
+	for (i = 0; i < num_config_cntrs; i++) {
+		if (pmu_events->unit.cntr_state[i] == CNTR_FREE) {
+			pmu_events->unit.cntr_state[i] = CNTR_IN_USE;
+			*physical_counter_num = i;
+			return 0;
+		}
+	}
+
+	pr_err("%s, ERROR could not find an available counter to use.\n",
+	       __func__);
+	return -1;
+}
+
+int mcd_pmu_check_constraints(struct torrent_pmu_events *pmu_events,
+			      struct unit_config *unit_cfg)
+{
+	/*
+	 * The MCD 0 and 1 units share the same physical counters.  Therefore,
+	 * copy_unit_config sends unit 0's unit config structure to check
+	 * constraints so both units share the same counter reservation.
+	 */
+
+	int i, total_events;
+	int config_max_counters;
+	u64 event_code;
+
+	total_events = pmu_events->n_events + pmu_events->n_add;
+
+	for (i = pmu_events->n_events; i < total_events; i++) {
+		/*
+		 * Get the event code from attr.config value as the hw.config
+		 * field is not set yet since the event has not been added.
+		 */
+		event_code = pmu_events->event[i]->attr.config;
+
+		/*
+		 * If the PMU is currently not counting any events, set the
+		 * counter attribute.  Make sure counter attribute for all
+		 * events are consistent.  Also, if the events are
+		 * accepted, i.e. n_counters for this unit is updated, the
+		 * counter attribute will also be set.  If the events are not
+		 * accepted, the counter attribute is not changed
+		 */
+		if ((pmu_events->n_events == 0) && (i == 0))
+			/*
+			 * If no counters are in use and this is the first
+			 * event in the group, set the counter attribute and
+			 * check that all the other events in the group are
+			 * consistent.
+			 */
+			unit_cfg->mcd_cntr_attr = get_counter_attr(event_code);
+
+		/*
+		 * The event counter configuration must match the
+		 * current counter configuration.
+		 */
+		if (get_counter_attr(event_code) != unit_cfg->mcd_cntr_attr) {
+			pr_warning("%s Warning, rejecting MCD PMU events due to inconsistent counter attribute.\n",
+				   __func__);
+			return -1;
+		}
+	}
+
+	/*
+	 * Check that there are enough counters for the events given the
+	 * number of counters configured as specified by the counter attribute.
+	 */
+	config_max_counters = mcd_get_num_ctrs(unit_cfg->mcd_cntr_attr);
+
+	if (config_max_counters == -1)
+		return -1;
+
+	if (total_events > config_max_counters) {
+		pr_warning("%s Warning, rejecting PMU events due to insufficient number of counters\n",
+			   __func__);
+		return -1;
+	}
+	return 0;
+}
+
+int mcd_compute_pmc_reg(struct torrent_pmu_events *pmu_events,
+			struct hcall_data *hcall_write)
+{
+	/* There are two MCD units however, they share the same physical
+	 * PMU counters.  Hence we only have one MCD PMU unit.  The unit
+	 * number is used to calculate the appropriate shift to write the
+	 * unit specific counter event field.
+	 */
+
+	int i, total_events, shift_by, input_unit, num_config_cntrs;
+	u8 virt_cntr;
+	u64 event_code, event_counter_type, err, mux;
+
+	/* The assumption is that we have passed the constraint test before
+	 * this routine is called so we know that for the counter configuration
+	 * (two or four counters) there are enough counters available for the
+	 * new events.
+	 */
+
+	total_events = pmu_events->n_events + pmu_events->n_add;
+
+	for (i = 0; i < total_events; i++) {
+		event_code = pmu_events->event[i]->hw.config;
+
+		/* extract the counter type from the attribute field */
+		event_counter_type = get_counter_attr(event_code);
+		num_config_cntrs = mcd_get_num_ctrs(event_counter_type);
+		err = mcd_assign_counter(&virt_cntr, pmu_events,
+					 num_config_cntrs);
+		if (err)
+			return -1;
+
+		pmu_events->event[i]->hw.idx = virt_cntr;
+		pmu_events->unit.cntr_state[i] = CNTR_ALLOCATED;
+
+		/* determine which of the input MCD unit signals to count */
+		input_unit = TORRENT_UNIT_GET(event_code);
+
+		/*
+		 * Setup the MCD config register fields:
+		 * counter configuration field
+		 * Unit signal routing field for the counter
+		 */
+		shift_by = 52 + (NUM_MCD_PMC_REGS - virt_cntr - 1);
+
+		/* Clear signal routing bits for both units.e */
+		pmu_events->shadow_pmc_reg[MCD_CFG_SHADOW_REG_IDX] &=
+				~(MCD_UNIT_ROUTE_CLEAR_MASK << shift_by);
+
+		if (input_unit == 0)
+			shift_by += 4;
+
+		pmu_events->shadow_pmc_reg[MCD_CFG_SHADOW_REG_IDX] |=
+					MCD_UNIT_ROUTE_MASK << shift_by;
+
+		/* set the counter number/prescale bits in config register */
+		pmu_events->shadow_pmc_reg[MCD_CFG_SHADOW_REG_IDX]
+					&= ~TORRENT_REG_ATTR_MCD_TYPE_MASK;
+
+		pmu_events->shadow_pmc_reg[MCD_CFG_SHADOW_REG_IDX]
+				|= event_counter_type
+					<< TORRENT_REG_ATTR_MCD_TYPE_SHIFT;
+
+		/* Configuration register needs to be written */
+		record_hcall_request_idx(PBUS_MCD_PERF_CTRS_CFG, hcall_write,
+					 pmu_events->shadow_pmc_reg
+						     [MCD_CFG_SHADOW_REG_IDX]);
+
+		/* Setup the MCD selection register */
+		mux = (u64) TORRENT_MUX_GET(event_code);
+
+		/* The MCD  event fields are:
+		 *   MCD 0 counter 0  [63:56]
+		 *   MCD 0 counter 1  [55:48]
+		 *   MCD 0 counter 2  [47:40]
+		 *   MCD 0 counter 3  [39:32]
+		 *   MCD 1 counter 0  [31:24]
+		 *   MCD 1 counter 1  [23:16]
+		 *   MCD 1 counter 2  [15:8]
+		 *   MCD 1 counter 3  [7:0]
+		 */
+		if (input_unit == 0) /* adjust position based on input unit */
+			shift_by = 32;
+		else
+			shift_by = 0;
+
+		shift_by += (NUM_MCD_PMC_REGS - virt_cntr - 1)
+							* MCD_PMC_FIELD_WIDTH;
+
+		/*
+		 * Set the event specifier field for the counter in the
+		 * selection register
+		 */
+		pmu_events->shadow_pmc_reg[MCD_SEL_SHADOW_REG_IDX] &=
+						MCD_OPCODE_MASK << shift_by;
+		pmu_events->shadow_pmc_reg[MCD_SEL_SHADOW_REG_IDX]
+							|= mux << shift_by;
+
+		/* Get request_idx and record which PMC needs to be written */
+		record_hcall_request_idx(PBUS_MCD_PERF_CTRS_SEL,
+					 hcall_write,
+					 pmu_events->shadow_pmc_reg
+					 [MCD_SEL_SHADOW_REG_IDX]);
+	}
+	return 0;
+}
+
+void mcd_enable_disable_hw_cntr(int op, struct torrent_pmu_events *pmu_events,
+				struct hcall_data *hcall_write)
+{
+	int cntr_num;
+
+	/* There is a single PMU enable bit for all counters
+	 *
+	 * Note, the PMU can be configured with 2 or 4 physical counters.
+	 */
+
+	for (cntr_num = 0; cntr_num < pmu_events->max_events;
+	     cntr_num++) {
+		if (op) {
+			/* enable if cntr is in use or has been allocated */
+			if (pmu_events->unit.cntr_state[cntr_num] !=
+			   CNTR_FREE) {
+				pmu_events->shadow_pmc_reg
+						[MCD_CFG_SHADOW_REG_IDX] |=
+							MCD_ENABLE_MASK;
+				pmu_events->unit.cntr_state[cntr_num] =
+								CNTR_IN_USE;
+			}
+		} else {
+			/* disable, only if the counter is actually in use */
+			if (pmu_events->unit.cntr_state[cntr_num] ==
+			   CNTR_IN_USE)
+					pmu_events->shadow_pmc_reg
+						[MCD_CFG_SHADOW_REG_IDX] &=
+							~MCD_ENABLE_MASK;
+		}
+		/* record which PMC needs to be written */
+		record_hcall_request_idx(PBUS_MCD_PERF_CTRS_CFG, hcall_write,
+						 pmu_events->shadow_pmc_reg
+						 [MCD_CFG_SHADOW_REG_IDX]);
+	}
+}
+
+void mcd_pmd_write(struct torrent_pmu_events *pmu_events,
+		   struct hcall_data *hcall_read)
+{
+	/*
+	 * All counters are packed into a single physical register:
+	 *    Four counter layout:  (16-bit counters)
+	 *       counter 0  [63:48]
+	 *       counter 1  [47:32]
+	 *       counter 2  [31:16]
+	 *       counter 3  [15:0]
+	 *
+	 *    Two counter layout: (32-bit counters)
+	 *       counter 0  [63:32]
+	 *       counter 1  [31:0]
+	 */
+
+	/*
+	 * The PMD can only be accessed via an HCall.  The counters are
+	 * packed into a single register.  It is not practical to read the
+	 * register, reset one counter field, then write the counter back.
+	 * Secondly, being able to write a non-zero value is only needed when
+	 * collecting a profile.  Profiling on non-CPU counters doesn't make
+	 * sense since there is no reliable way to associate the number of
+	 * events that have occurred back to a specific instruction.
+	 * Therefore, we will not support writing a value.  The enable/disable
+	 * HCall will need to sample the counts before the counter is enabled
+	 * and then generate a delta count when the counters are disabled.
+	 */
+	int i, index, num_config_cntrs;
+	u8 virt_cntr;
+	u64 value, event_code;
+
+	for (i = 0; i < pmu_events->n_events; i++) {
+		event_code = pmu_events->event[i]->hw.config;
+		virt_cntr = pmu_events->event[i]->hw.idx;
+		num_config_cntrs = mcd_get_num_ctrs(
+					pmu_events->unit.mcd_cntr_attr);
+
+		if (pmu_events->unit.cntr_state[virt_cntr] == CNTR_IN_USE) {
+			/*
+			 * The counters are stopped.  The HCall to
+			 * read the counters has been done.  The
+			 * current count must be set to the previous
+			 * count.  The counters will be enabled.
+			 * When the counters are stopped and read
+			 * again, the actual count will be the
+			 * new count minus the previous count.
+			 */
+
+			/*
+			 * Get the request entry that contains the PMD for
+			 * this virtual counter.
+			 */
+			index = hcall_read->virt_cntr_to_request_idx
+					[TORRENT_PBUS_MCD_ID][virt_cntr];
+			value = hcall_read->tor_pmu_reg[index].regValue;
+
+			if (num_config_cntrs == 2)
+				value >>= ((num_config_cntrs - 1 - virt_cntr)
+							* MCD_32_BIT_CNTR) &
+							MCD_32_BIT_CNTR_MASK;
+			else
+				value >>= ((num_config_cntrs - 1 - virt_cntr)
+							* MCD_16_BIT_CNTR) &
+							MCD_16_BIT_CNTR_MASK;
+			local64_set(&pmu_events->event[i]->hw.prev_count,
+				    value);
+		}
+	}
+}
+
+int mcd_pmd_read(struct torrent_pmu_events *pmu_events,
+		 struct hcall_data *hcall_read)
+{
+	/*
+	 * This PMU is accessed via hypervisor calls.  The HCall to read the
+	 * counters has been done.  The counter data is in hcall_read.
+	 */
+	int i, index, num_config_cntrs, prescaler;
+	u8 virt_cntr;
+	u64 value, prev, delta;
+	struct perf_event *event;
+
+	/*
+	 * All counters are packed into a single physical register:
+	 *    Four-counter layout:  (16-bit counters)
+	 *       counter 0  [63:48]
+	 *       counter 1  [47:32]
+	 *       counter 2  [31:16]
+	 *       counter 3  [15:0]
+	 *
+	 *    Two-counter layout: (32-bit counters)
+	 *       counter 0  [63:32]
+	 *       counter 1  [31:0]
+	 */
+
+	for (i = 0; i < pmu_events->n_events; i++) {
+		event = pmu_events->event[i];
+		virt_cntr = pmu_events->event[i]->hw.idx;
+		prescaler = mcd_get_prescale(pmu_events->unit.mcd_cntr_attr);
+		num_config_cntrs = mcd_get_num_ctrs(
+					       pmu_events->unit.mcd_cntr_attr);
+
+		if (prescaler == -1) {
+			pr_err("%s ERROR, Unknown counter configuration.\n",
+			       __func__);
+			return -1;
+		}
+
+		if (pmu_events->unit.cntr_state[virt_cntr] == CNTR_IN_USE) {
+			/*
+			 * Read the PMD register.  Its count value is the
+			 * current value minus the previous value from when
+			 * the counter was started.
+			 */
+
+			/* get current count, from the HCall */
+			index =	hcall_read->virt_cntr_to_request_idx
+					[TORRENT_PBUS_MCD_ID][virt_cntr];
+
+			/*
+			 * Get initial value, which was saved by the PMD write
+			 * call into prev_count.
+			 */
+			prev = local64_read(&event->hw.prev_count);
+			value = hcall_read->tor_pmu_reg[index].regValue;
+
+			if (num_config_cntrs == 2) {
+				value >>= ((num_config_cntrs - 1
+					    - virt_cntr) * MCD_32_BIT_CNTR)
+							& MCD_32_BIT_CNTR_MASK;
+
+				delta = (value - prev) & MCD_32_BIT_CNTR_MASK;
+
+			} else {
+				value = value >> ((num_config_cntrs - 1
+						   - virt_cntr)
+						  * MCD_16_BIT_CNTR)
+							& MCD_16_BIT_CNTR_MASK;
+
+				delta = ((value - prev)
+						 & MCD_16_BIT_CNTR_MASK);
+			}
+			delta = delta << prescaler;
+			local64_add(delta, &event->count);
+			local64_set(&event->hw.prev_count, value);
+		}
+	}
+	return 0;
+}
+
+
+int mcd_get_phys_pmd_reg(u64 event_code)
+{
+	/* All of the MCD counters use this single physical PMD
+	 * register. */
+	return PBUS_MCD_PERF_CTRS;
+}
diff --git a/arch/powerpc/platforms/p7ih/powerbus_wxyz_pmu.c b/arch/powerpc/platforms/p7ih/powerbus_wxyz_pmu.c
new file mode 100644
index 0000000..e541469
--- /dev/null
+++ b/arch/powerpc/platforms/p7ih/powerbus_wxyz_pmu.c
@@ -0,0 +1,244 @@
+/*
+ * Performance counter support for IBM Torrent interconnect chip
+ *
+ * Copyright 2010, 2011  Carl Love, Corey Ashford, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <asm/torrent_nest_pmu.h>
+#include <asm/powerbus_wxyz_pmu.h>
+#include <asm/power_torrent_events.h>
+
+#define WXYZ_PMC_FIELD_WIDTH		3
+#define WXYZ_NUM_VIRT_CTRS		4
+#define WXYZ_CNTR_SIZE			16
+#define WXYZ_OPCODE_MASK		0x7ULL
+#define WXYZ_PMD_MASK			0xFFFFULL
+#define WXYZ_ENABLE_MASK		(1ULL << (63 - 6))
+#define WXYZ_SHADOW_IDX			0
+
+int wxyz_link_pmu_check_constraints(struct torrent_pmu_events *pmu_events,
+				    struct unit_config *unit_cfg)
+{
+	/*
+	 * Check that there is only one event for each link (W, X,
+	 * Y and Z) being counted at a time.
+	 */
+	int i, total_events;
+	u8 virt_cntr;
+	u64 event_code;
+
+	total_events = pmu_events->n_events + pmu_events->n_add;
+
+	for (i = pmu_events->n_events; i < total_events; i++) {
+		/*
+		 * Get the event code from attr.config value as the hw.config
+		 * field is not set yet since the event has not been added.
+		 */
+		event_code = pmu_events->event[i]->attr.config;
+		virt_cntr = (u8)TORRENT_VIRT_CTR_GET(event_code);
+		if (unit_cfg->cntr_state[virt_cntr] != CNTR_FREE)
+			return -1;
+
+		/*
+		 * Assign the event to the counter but it has not been
+		 * enabled yet.
+		 */
+		unit_cfg->cntr_state[virt_cntr] = CNTR_ALLOCATED;
+	}
+	return 0;
+}
+
+int wxyz_link_compute_pmc_reg(struct torrent_pmu_events *pmu_events,
+			      struct hcall_data *hcall_write)
+{
+	int i, total_events, shift_by;
+	u8 mux, virt_cntr;
+	u64 event_code;
+
+	total_events = pmu_events->n_events + pmu_events->n_add;
+
+	for (i = 0; i < total_events; i++) {
+		event_code = pmu_events->event[i]->hw.config;
+		virt_cntr = TORRENT_VIRT_CTR_GET(event_code);
+		pmu_events->event[i]->hw.idx = virt_cntr;
+		mux = (u8)TORRENT_MUX_GET(event_code);
+
+		/* The PBE_LINKS_TRACE event fields are:
+		 *   W counter [51:49]
+		 *   X counter [48:46]
+		 *   Y counter [45:43]
+		 *   Z counter [42:40]
+		 */
+		shift_by = 40 +
+			(WXYZ_NUM_VIRT_CTRS - virt_cntr - 1) *
+							WXYZ_PMC_FIELD_WIDTH;
+
+		pmu_events->shadow_pmc_reg[WXYZ_SHADOW_IDX]
+					&= ~(WXYZ_OPCODE_MASK << shift_by);
+		pmu_events->shadow_pmc_reg[WXYZ_SHADOW_IDX]
+					|= (u64)mux << shift_by;
+
+		/* record which PMC needs to be written */
+		record_hcall_request_idx(PBE_LINKS_TRACE,
+					 hcall_write,
+					 pmu_events->
+					 shadow_pmc_reg[WXYZ_SHADOW_IDX]);
+	}
+	return 0;
+}
+
+void wxyz_link_enable_disable_hw_cntr(int op,
+				      struct torrent_pmu_events *pmu_events,
+				      struct hcall_data *hcall_write)
+{
+	int cntr_num;
+
+	for (cntr_num = 0; cntr_num < pmu_events->max_events; cntr_num++) {
+		if (op) {
+			/* enable if cntr is in use or has been allocated */
+			if (pmu_events->unit.cntr_state[cntr_num] !=
+			   CNTR_FREE) {
+				pmu_events->shadow_pmc_reg[WXYZ_SHADOW_IDX] |=
+							WXYZ_ENABLE_MASK;
+				pmu_events->unit.cntr_state[cntr_num] =
+							CNTR_IN_USE;
+			}
+		} else {
+			/* disable, only if the counter is actually in use */
+			if (pmu_events->unit.cntr_state[cntr_num]
+			    == CNTR_IN_USE)
+				pmu_events->shadow_pmc_reg[WXYZ_SHADOW_IDX] &=
+							~WXYZ_ENABLE_MASK;
+		}
+		/* record which PMC needs to be written */
+		record_hcall_request_idx(PBE_LINKS_TRACE,
+					 hcall_write,
+					 pmu_events->shadow_pmc_reg
+					 [WXYZ_SHADOW_IDX]);
+	}
+}
+
+void wxyz_link_pmd_write(struct torrent_pmu_events *pmu_events,
+			 struct hcall_data *hcall_read)
+{
+	/*
+	 * The physical counters are 16 bits wide each.
+	 * All four counters are packed into a single physical register:
+	 *    W counter [63:48]
+	 *    X counter [47:32]
+	 *    Y counter [31:16]
+	 *    Z counter [15:0]
+	 */
+
+	/*
+	 * The PMD can only be accessed via an HCall.  The four counters are
+	 * packed into a single register.  It is not practical to read the
+	 * register, reset one counter field, then write the counter back.
+	 * Secondly, being able to write a non-zero value is only needed when
+	 * collecting a profile.  Profiling on non-CPU counters doesn't make
+	 * sense since there is no reliable way to associate the number of
+	 * events that have occurred back to a specific instruction.
+	 * Therefore, we will not support writing a value.  The enable/disable
+	 * HCall will need to sample the counts before the counter is enabled
+	 * and then generate a delta count when the counters are disabled
+	 */
+
+	int i, index;
+	u8 virt_cntr;
+	u64 value, event_code;
+
+	for (i = 0; i < pmu_events->n_events; i++) {
+		event_code = pmu_events->event[i]->hw.config;
+		virt_cntr = TORRENT_VIRT_CTR_GET(event_code);
+
+		if (pmu_events->unit.cntr_state[virt_cntr] == CNTR_IN_USE) {
+			/*
+			 * The counters are stopped.  The HCall to
+			 * read the counters has been done.  The
+			 * current count must be set to the previous
+			 * count.  The counters will be enabled.
+			 * When the counters are stopped and read
+			 * again, the actual count will be the
+			 * new count minus the previous count.
+			 */
+
+			/* Get the request entry that contains the PMD for
+			 * this virtual counter.
+			 */
+			index = hcall_read->virt_cntr_to_request_idx
+					[TORRENT_PBUS_WXYZ_ID][virt_cntr];
+			value = hcall_read->tor_pmu_reg[index].regValue;
+			value = value >> ((WXYZ_NUM_VIRT_CTRS - 1 - virt_cntr)
+					  * WXYZ_CNTR_SIZE) & WXYZ_PMD_MASK;
+			local64_set(&pmu_events->event[i]->hw.prev_count,
+				    value);
+		}
+	}
+}
+
+int wxyz_link_pmd_read(struct torrent_pmu_events *pmu_events,
+		       struct hcall_data *hcall_read)
+{
+	/*
+	 * This PMU is accessed via hypervisor calls.  The HCall to read the
+	 * counters has been done.  The counter data is in hcall_read.
+	 */
+	int i, index;
+	u8 virt_cntr;
+	u64 value, prev, delta;
+	struct perf_event *event;
+
+	/*
+	 * The physical counters are 16 bits wide each.
+	 * All four counters are packed into a single physical register:
+	 *    W counter [63:48]
+	 *    X counter [47:32]
+	 *    Y counter [31:16]
+	 *    Z counter [15:0]
+	 */
+	for (i = 0; i < pmu_events->n_events; i++) {
+		event = pmu_events->event[i];
+		virt_cntr = TORRENT_VIRT_CTR_GET(event->hw.config);
+
+		if (pmu_events->unit.cntr_state[virt_cntr] == CNTR_IN_USE) {
+			/*
+			 * Read the PMD register.  Its count value is the
+			 * current value minus the previous value from when
+			 * the counter was started.
+			 */
+			/* get current count, from the HCall */
+			index =	hcall_read->virt_cntr_to_request_idx
+				[TORRENT_PBUS_WXYZ_ID][virt_cntr];
+
+			/*
+			 * Get initial value, which was saved by the pmd write
+			 * call into prev_count.
+			 */
+			prev = local64_read(&event->hw.prev_count);
+			value = hcall_read->tor_pmu_reg[index].regValue;
+			value = value >> ((WXYZ_NUM_VIRT_CTRS - 1
+					   - virt_cntr) * WXYZ_CNTR_SIZE)
+							  & WXYZ_PMD_MASK;
+
+			/* calculate/save the count */
+			delta = ((value - prev) & 0xffffUL) << 16;
+			local64_add(delta, &event->count);
+			local64_set(&event->hw.prev_count, value);
+		}
+	}
+	return 0;
+}
+
+int wxyz_link_get_phys_pmd_reg(u64 event_code)
+{
+	/* All of the WXYZ link counters use this single physical PMD
+	 * register. */
+	return PBE_LINKS_CTRS;
+}
diff --git a/arch/powerpc/platforms/p7ih/torrent_pmu.c b/arch/powerpc/platforms/p7ih/torrent_pmu.c
new file mode 100644
index 0000000..5005fd1
--- /dev/null
+++ b/arch/powerpc/platforms/p7ih/torrent_pmu.c
@@ -0,0 +1,1582 @@
+/*
+ * Performance event support for IBM Torrent interconnect chip
+ *
+ * Copyright 2010, 2011  Carl Love, Corey Ashford, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/hrtimer.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/vmalloc.h>
+#include <linux/of.h>
+#include <linux/perf_event.h>
+#include <linux/string.h>
+#include <asm/power_torrent_events.h>
+#include <asm/torrent_nest_pmu.h>
+#include <asm/powerbus_bus_util_pmu.h>
+#include <asm/powerbus_wxyz_pmu.h>
+#include <asm/powerbus_ll_pmu.h>
+#include <asm/powerbus_mcd_pmu.h>
+#include <asm/mmu_pmu.h>
+#include <asm/cau_pmu.h>
+#include <asm/cputable.h>
+#include <asm/reg.h>
+#include <asm/hvcall.h>
+
+/*
+ * There are a number of Torrent PMUs that count non-core-specific events.
+ * These are referred to as Torrent events.
+ */
+
+static u64 torrent_chip_id;
+static u64 hfi_unit_id;
+
+struct torrent_txns {
+	unsigned int group_flag;
+	int n_txn_start[TORRENT_NUM_PMU_TYPES];
+};
+
+static struct torrent_txns torrent_txn;
+struct torrent_pmu_events txn_all_events[TORRENT_NUM_PMU_TYPES];
+
+/*
+ * The variable torrent_pmu_cntrs is doubly-indexed array.  The first index of
+ * the array is the PMU type.  Then each instance of a given type is indexed
+ * by its unit number.
+ */
+static struct torrent_pmu_counters ***torrent_pmu_cntrs;
+
+static int num_torrent_chips = 1;
+static int pbus_pmu_reservation_cnt[TORRENT_NUM_PBUS_PMU_TYPES];
+
+/* Store the list of all events, being counted and those to be added */
+struct torrent_pmu_events all_torrent_events[TORRENT_NUM_PMU_TYPES];
+
+#define HFI_SHIFT_OCTANT	3
+#define HFI_MAX_OCTANT		7
+
+#define PLPAR_HCALL plpar_hcall_norets
+
+static DEFINE_SPINLOCK(torrent_lock);
+#define PAGE_4K (1ULL << 12)
+#define ALIGN_4K(x) ALIGN(x, PAGE_4K)
+
+static u64 unaligned_buffer[2 * PAGE_4K / sizeof(u64)];
+static u64 *aligned_buffer;
+
+/*
+ * The Torrent counter polling interval needs to be set so that there's a good
+ * margin between counting to 2^32 at the speed of the fastest possible event
+ * rate.  Right now, the fastest rate is the WXYZ link idle which counts at
+ * 3 GHz.  At 3 GHz, it will take about 1.4 seconds to count to 2^32.  Note,
+ * the MCD counters can be setup as 16 bit, 32 or 64 bit counters.  It is not
+ * clear what the maximum MCD event increment rate might be.  Since the user
+ * can control the size of these counters, for now we will leave it to the user
+ * to select the correct size based on the event. To be conservative, the
+ * polling period is set to about 1/3 of the maximum counter-wrap period.
+ */
+#define POLLING_INTERVAL_SEC 0
+#define POLLING_INTERVAL_NS  500000000
+
+static ktime_t torrent_counter_poll_interval;
+struct hrtimer torrent_poll_timer;
+u64 poll_start_time;
+
+static void initialize_event_struct(struct torrent_pmu_events *event_struct)
+{
+	int pmu_type, i;
+
+	event_struct[TORRENT_PBUS_WXYZ_ID].max_events =
+						MAX_CNTRS_PER_WXYZ_LINK_PMU;
+	event_struct[TORRENT_PBUS_LL_ID].max_events =
+						MAX_CNTRS_PER_LL_LINK_PMU;
+	event_struct[TORRENT_PBUS_MCD_ID].max_events =
+						MAX_CNTRS_PER_MCD_PMU;
+	event_struct[TORRENT_PBUS_UTIL_ID].max_events =
+						MAX_CNTRS_PER_BUS_UTIL_PMU;
+	event_struct[TORRENT_MMU_ID].max_events = MAX_CNTRS_PER_MMU_PMU;
+	event_struct[TORRENT_CAU_ID].max_events = MAX_CNTRS_PER_CAU_PMU;
+
+	for (pmu_type = 0; pmu_type < TORRENT_NUM_PMU_TYPES; pmu_type++) {
+		event_struct[pmu_type].n_events = 0;
+		event_struct[pmu_type].n_add = 0;
+		event_struct[pmu_type].update = false;
+		event_struct[pmu_type].disabled = 0;
+		event_struct[pmu_type].unit.mcd_cntr_attr = 0;
+		event_struct[pmu_type].unit.bus_util_enable_mask = 0;
+		event_struct[pmu_type].unit.bus_util_cntr_sel = 0;
+
+		for (i = 0; i < MAX_CNTRS_TORRENT_PMUS; i++)
+			event_struct[pmu_type].unit.cntr_state[i] = CNTR_FREE;
+
+		/* Initialize the PMC shadow regs to all zero.
+		 * *NOTE* this assumes that the correct initial value for
+		 * every PMC reg is zero.  If this turns out not to be the
+		 * case for some PMU(s), we may want to pass in a pointer to a
+		 * function which initializes the shadow regs correctly.
+		 */
+		for (i = 0; i < MAX_TORRENT_PMC_REGS; i++)
+			event_struct[pmu_type].shadow_pmc_reg[i] = 0x0;
+
+		if (pmu_type == TORRENT_PBUS_MCD_ID)
+			/* MCD specific set up */
+			event_struct[pmu_type].unit.mcd_cntr_attr = 0;
+
+		if (pmu_type == TORRENT_PBUS_UTIL_ID) {
+			/* Bus util specific set up */
+			event_struct[pmu_type].unit.bus_util_enable_mask = 0;
+			event_struct[pmu_type].unit.bus_util_cntr_sel
+				= BUS_UTIL_CNTR_SEL_AVAIL;
+		}
+	}
+}
+
+static int wrap_hcall_hfi_dump_info(u64 torrent_chip_id,
+			struct dump_mmio_perf_counters *mmio_perf_counters)
+{
+	struct dump_mmio_perf_counters *aligned_mmio_perf_counters =
+			(struct dump_mmio_perf_counters *)aligned_buffer;
+	int ret = 0;
+
+	ret = PLPAR_HCALL(H_HFI_DUMP_INFO, hfi_unit_id,
+			  DUMP_MMIO_PERFORMANCE_COUNTERS,
+			  sizeof(struct dump_mmio_perf_counters),
+			  __pa(aligned_buffer));
+
+	if (ret == H_SUCCESS)
+		/* Copy the data out of the aligned buffer into the caller's
+		 * memory.
+		 */
+		*mmio_perf_counters = *aligned_mmio_perf_counters;
+
+	return ret;
+}
+
+static int wrap_hcall_tor_access_pmu_scom_regs(u64 torrent_chip_id,
+					       int req_type,
+					       int num_regs,
+					       struct tor_pmu_reg *tor_pmu_regs)
+{
+	struct tor_pmu_reg *aligned_tor_pmu_reg =
+		(struct tor_pmu_reg *)aligned_buffer;
+	int i, ret;
+
+	for (i = 0; i < num_regs; i++) {
+		aligned_tor_pmu_reg[i].regId = tor_pmu_regs[i].regId;
+		if (req_type == PBUS_HCALL_WRITE)
+			aligned_tor_pmu_reg[i].regValue =
+				tor_pmu_regs[i].regValue;
+	}
+	ret = PLPAR_HCALL(H_TOR_ACCESS_PMU_SCOM_REGS, torrent_chip_id,
+			 (u64)req_type, (u64)num_regs,
+			  __pa(aligned_buffer));
+
+	if (req_type == PBUS_HCALL_READ)
+		for (i = 0; i < num_regs; i++)
+			tor_pmu_regs[i].regValue =
+				aligned_tor_pmu_reg[i].regValue;
+	return ret;
+}
+
+/* Generic Torrent PMU functions
+ *
+ * These routines make calls via function pointers to the PMU-specific
+ * functions to do the PMU-specific PMU register accesses.  The number and
+ * layout of the control registers, the PMD registers and the event constraints
+ * are very PMU-specific.  Hence the use of function pointers to deal with the
+ * specifics of a given PMU.
+ */
+int get_chip(void)
+{
+	return 0;  /* Currently only supporting a single Torrent chip system */
+}
+
+int get_max_nest_events(int pmu_type)
+{
+	/* The maximum number of PMU events is independent of the chip number.
+	 * So, just get it for chip 0.
+	 */
+	return all_torrent_events[pmu_type].max_events;
+}
+
+static void hcall_data_reset(struct hcall_data *hcall_data)
+{
+	int i, pmu_type;
+
+	hcall_data->num_regs = 0;
+	for (i = 0; i < MAX_HCALL_REGS; i++)
+		hcall_data->request_idx[i] = -1;
+
+	for (pmu_type = 0; pmu_type < TORRENT_NUM_PMU_TYPES; pmu_type++) {
+		for (i = 0; i < MAX_CNTRS_TORRENT_PMUS; i++)
+			hcall_data->virt_cntr_to_request_idx[pmu_type][i] =
+				0xbadbeef;
+	}
+	hcall_data->do_dump_mmio_perf_counters = 0;
+}
+
+static int hcall_read_setup(struct torrent_pmu_events *torrent_pmu_events,
+			    int pmu_type,
+			    struct hcall_data *hcall_read)
+{
+	struct torrent_pmu_counters *torrent_pmu;
+	int num_events, i, phys_reg = 0, *num_regs_p, request_idx;
+	u8 virt_cntr;
+	u64 event_code;
+
+	torrent_pmu = torrent_pmu_cntrs[get_chip()][pmu_type];
+	num_events = torrent_pmu_events->n_events;
+
+	if (num_events == 0)
+		return 0;  /* no counters to read on this PMU. */
+
+	switch (pmu_type) {
+	case TORRENT_MMU_ID:
+	case TORRENT_CAU_ID:
+		hcall_read->do_dump_mmio_perf_counters = 1;
+		return 0;
+	default:
+		/* it must be one of the Powerbus PMU's */
+		break;
+	}
+	num_regs_p = &hcall_read->num_regs;
+
+	for (i = 0; i < num_events; i++) {
+		event_code = torrent_pmu_events->event[i]->hw.config;
+		phys_reg = torrent_pmu->get_phys_pmd_reg(event_code);
+		virt_cntr = (u8)torrent_pmu_events->event[i]->hw.idx;
+
+		/* Check if the physical reg is already in the list
+		 * to be read.
+		 */
+		if (hcall_read->request_idx[phys_reg] == -1) {
+			request_idx = *num_regs_p;
+			hcall_read->request_idx[phys_reg] = *num_regs_p;
+			hcall_read->tor_pmu_reg[*num_regs_p].regId
+				= phys_reg;
+			(*num_regs_p)++;
+
+			if (*num_regs_p == MAX_HCALL_REGS) {
+				pr_err("%s, ERROR, "
+				       "MAX_HCALL_REGS is "
+				       "too small.\n", __func__);
+				return 1;
+			}
+		} else {
+			request_idx = hcall_read->request_idx[phys_reg];
+		}
+		hcall_read->virt_cntr_to_request_idx[pmu_type][virt_cntr]
+			= request_idx;
+	}
+	return 0;
+}
+
+void do_hcall_pmd_read(struct hcall_data *hcall_read,
+		       struct torrent_pmu_events *torrent_pmu_events)
+{
+	int pmu_type, ret;
+
+	/*
+	 * Set up variable hcall_read with all the physical registers to read.
+	 * Then bundle up the registers to be read into as few HCalls as
+	 * possible to minimize the HCall overhead.
+	 */
+
+	hcall_data_reset(hcall_read);
+	for (pmu_type = 0; pmu_type < TORRENT_NUM_PMU_TYPES; pmu_type++)
+		hcall_read_setup(&torrent_pmu_events[pmu_type], pmu_type,
+				 hcall_read);
+
+	if (hcall_read->num_regs != 0) {
+		ret = wrap_hcall_tor_access_pmu_scom_regs(torrent_chip_id,
+				PBUS_HCALL_READ, hcall_read->num_regs,
+				hcall_read->tor_pmu_reg);
+		if (ret != H_SUCCESS)
+			pr_err("%s, ERROR, HCall H_TOR_ACCESS_PMU_SCOM_REGS:PBUS_HCALL_READ returned an error %d\n", __func__,
+				ret);
+	}
+	if (hcall_read->do_dump_mmio_perf_counters) {
+		ret = wrap_hcall_hfi_dump_info(torrent_chip_id,
+				&hcall_read->mmio_perf_counters);
+		if (ret != H_SUCCESS)
+			pr_err("%s, ERROR, HCall H_HFI_DUMP_INFO:DUMP_MMIO_PERFORMANCE_COUNTERS HCall returned an error %d\n", __func__,
+				ret);
+	}
+}
+
+void do_hcall_pmc_write(struct hcall_data *hcall_write)
+{
+	int ret;
+
+	if (hcall_write->num_regs != 0) {
+		ret = wrap_hcall_tor_access_pmu_scom_regs(torrent_chip_id,
+				  PBUS_HCALL_WRITE, hcall_write->num_regs,
+				  hcall_write->tor_pmu_reg);
+
+		if (ret != H_SUCCESS)
+			pr_err("%s, ERROR, HCall H_TOR_ACCESS_PMU_SCOM_REGS:PBUS_HCALL_WRITE returned an error %d\n", __func__,
+				ret);
+	}
+}
+
+void record_hcall_request_idx(int phys_register_index,
+			      struct hcall_data *hcall_request,
+			      u64 shadow_reg_index)
+{
+	int request_idx;
+
+	/* Configuration register needs to be written */
+	request_idx = hcall_request->num_regs;
+
+	if (hcall_request->request_idx[phys_register_index] == -1) {
+		hcall_request->request_idx[phys_register_index]
+			= request_idx;
+		hcall_request->tor_pmu_reg[request_idx].regId
+			= phys_register_index;
+		hcall_request->num_regs++;
+	} else {
+		/* store the updated value to write */
+		request_idx = hcall_request->
+			request_idx[phys_register_index];
+	}
+
+	hcall_request->tor_pmu_reg[request_idx].regValue = shadow_reg_index;
+}
+
+static void copy_unit_config(struct unit_config *unit_cfg_src,
+			     struct unit_config *unit_cfg_dest, int pmu_type)
+{
+	int i;
+
+	for (i = 0; i < MAX_CNTRS_TORRENT_PMUS; i++)
+		unit_cfg_dest->cntr_state[i] = unit_cfg_src->cntr_state[i];
+
+	if (pmu_type == TORRENT_PBUS_MCD_ID)
+		unit_cfg_dest->mcd_cntr_attr = unit_cfg_src->mcd_cntr_attr;
+
+	if (pmu_type == TORRENT_PBUS_UTIL_ID) {
+		unit_cfg_dest->bus_util_enable_mask =
+			unit_cfg_src->bus_util_enable_mask;
+		unit_cfg_dest->bus_util_cntr_sel =
+			unit_cfg_src->bus_util_cntr_sel;
+	}
+}
+
+static void copy_all_events(struct torrent_pmu_events *src_events,
+			    struct torrent_pmu_events *dst_events)
+{
+	int pmu_type, i;
+
+	for (pmu_type = 0; pmu_type < TORRENT_NUM_PMU_TYPES; pmu_type++) {
+		dst_events[pmu_type].max_events =
+			src_events[pmu_type].max_events;
+		dst_events[pmu_type].n_events = src_events[pmu_type].n_events;
+		dst_events[pmu_type].n_add = src_events[pmu_type].n_add;
+
+		copy_unit_config(&src_events[pmu_type].unit,
+				 &dst_events[pmu_type].unit, pmu_type);
+		for (i = 0; i < MAX_CNTRS_TORRENT_PMUS; i++)
+			dst_events[pmu_type].event[i] =
+				src_events[pmu_type].event[i];
+	}
+}
+
+int get_max_torrent_counters(int pmu_type)
+{
+	/* The maximum number of PMU events is independent of the chip number.
+	 * So, just get it for chip 0.
+	 */
+	return all_torrent_events[pmu_type].max_events;
+}
+
+static void collect_events(struct perf_event *group,
+			   struct torrent_pmu_events *tmp_pmus)
+{
+	int pmu_type;
+	struct torrent_pmu_events *torrent_pmu_events;
+	struct perf_event *event;
+
+	/*
+	 * Get the event code from attr.config value as the hw.config
+	 * field is not set yet since the event has not been added.
+	 */
+	pmu_type = TORRENT_PMU_GET(group->attr.config);
+
+	if (pmu_type < 0)
+		pr_err("%s: ERROR, collect_events: could not determine pmu_type or unit number.\n",
+		       __func__);
+
+	torrent_pmu_events = &tmp_pmus[pmu_type];
+
+	BUG_ON(torrent_pmu_events == NULL);
+
+	list_for_each_entry(event, &group->sibling_list, group_entry) {
+		if (event->state != PERF_EVENT_STATE_OFF) {
+			int pmu_type, index;
+			struct torrent_pmu_events *torrent_pmu_events;
+
+			pmu_type = TORRENT_PMU_GET(event->attr.config);
+
+			torrent_pmu_events = &tmp_pmus[pmu_type];
+			/*
+			 * Index is what is on the PMU plus pending
+			 * events to add.
+			 */
+			index = torrent_pmu_events->n_events +
+						torrent_pmu_events->n_add;
+
+			if (index >= get_max_nest_events(pmu_type))
+				return;
+
+			torrent_pmu_events->event[index] = event;
+			/*
+			 * Initialize perf event as not yet
+			 * being assigned to a physical counter.
+			 * Physical counters are numbered from 0
+			 * to n-1.
+			 */
+			torrent_pmu_events->event[index]->hw.idx = -1;
+			torrent_pmu_events->n_add++;
+		}
+	}
+}
+
+void accept_torrent_events(struct torrent_pmu_events *new_all_events,
+			   struct torrent_pmu_events *existing_all_events)
+{
+	int pmu_type, i, index, debug_total_events = 0;
+	struct torrent_pmu_events *new_events, *existing_events;
+
+	for (pmu_type = 0; pmu_type < TORRENT_NUM_PMU_TYPES;
+	     pmu_type++) {
+
+		new_events = &new_all_events[pmu_type];
+		existing_events = &existing_all_events[pmu_type];
+
+		if (new_events->n_add) {
+			/*
+			 * Move the events from the list of new events to the
+			 * list of events being measured by the PMU.
+			 */
+			for (i = 0; i < new_events->n_add; i++) {
+				index = i + existing_events->n_events;
+				existing_events->event[index] =
+					new_events->event[index];
+			}
+			existing_events->n_events += new_events->n_add;
+			debug_total_events += existing_events->n_events;
+			copy_unit_config(&new_events->unit,
+					 &existing_events->unit, pmu_type);
+			existing_events->update = 1;
+		}
+	}
+}
+
+int hw_perf_group_sched_in_torrent_check(struct torrent_pmu_events
+					 *new_pmu_events)
+{
+	struct torrent_pmu_counters *torrent_pmu;
+	struct torrent_pmu_events *torrent_pmu_events;
+	int pmu_type, n, n0, i, max_events;
+
+	for (pmu_type = 0; pmu_type < TORRENT_NUM_PMU_TYPES; pmu_type++) {
+		/*
+		 * torrent_pmu is the structure that tracks what the physical
+		 * PMU usage
+		 */
+		torrent_pmu_events = &new_pmu_events[pmu_type];
+
+		/*
+		 * We are just testing to see if the group is
+		 * self-consistent, so use a PMU config which has no
+		 * registers already reserved, nor other configuration
+		 * bits preset.
+		 */
+
+		n = torrent_pmu_events->n_add;
+		n0 = torrent_pmu_events->n_events; /* being counted */
+
+		if (n == 0)
+			continue;
+
+		/* Get the number of physical counters for the PMU */
+		max_events = torrent_pmu_events->max_events;
+
+		if (n + n0 > max_events) {
+			/*
+			 * Current plus new events exceeds physical
+			 * number of counters
+			 */
+			pr_err("%s %d, CPU %d, !!! ERROR n %d exceeded max %d\n",
+			       __func__, __LINE__, smp_processor_id(), n+n0,
+			       max_events);
+			return -EAGAIN;
+		}
+
+		/*
+		 * See if we can put the new events on with the
+		 * existing events.  We need to use the state of the real
+		 * unit config structure so we can see what is being
+		 * used.  If we fail, we need to make sure we throw
+		 * away any changes from the check constraints call.
+		 */
+
+		torrent_pmu = torrent_pmu_cntrs[get_chip()][pmu_type];
+		i = torrent_pmu->check_constraints(torrent_pmu_events,
+						   &torrent_pmu_events->unit);
+		if (i < 0)
+			return -EAGAIN;
+	}
+	return 0;
+}
+
+void torrent_pmu_enable(struct pmu *pmu)
+{
+	/*
+	 * This function adds the new events to all of the PMUs.  The n_add
+	 * value for each PMU will specify how many new events are being
+	 * added.  This routine will add n_add to n__events then set n_add
+	 * to zero to indicate the event has been added.
+	 */
+	int pmu_type, ret, dump_ret;
+	unsigned long lock_flags;
+	struct torrent_pmu_counters *torrent_pmu;
+	struct torrent_pmu_events *torrent_pmu_events;
+	struct hcall_data hcall_read;
+	struct hcall_data hcall_write;
+	bool start_timer = false;
+
+	/*
+	 * Need to do a single HCall to stop all the PMUs that need to have
+	 * events programmed on them, i.e. n_add for the PMU is not zero.
+	 */
+	spin_lock_irqsave(&torrent_lock, lock_flags); /* ensure only one CPU
+						       * at a time access the
+						       * HCall data structures
+						       */
+	hcall_data_reset(&hcall_write);
+
+	/* Disable the PMUs with new events to add */
+	for (pmu_type = 0; pmu_type < TORRENT_NUM_PMU_TYPES; pmu_type++) {
+		torrent_pmu = torrent_pmu_cntrs[get_chip()][pmu_type];
+		torrent_pmu_events = &all_torrent_events[pmu_type];
+
+		/*
+		 * We only need to stop PMUs where there are new
+		 * events added to the PMU.
+		 */
+		if (torrent_pmu_events->update)
+			torrent_pmu->enable_disable_cntr(0,
+							 torrent_pmu_events,
+							 &hcall_write);
+	}
+
+	if (hcall_write.num_regs != 0) {
+		do_hcall_pmc_write(&hcall_write);
+		hcall_data_reset(&hcall_write);
+	}
+
+	if (hcall_write.do_dump_mmio_perf_counters)
+		dump_ret = wrap_hcall_hfi_dump_info(torrent_chip_id,
+					    &hcall_write.mmio_perf_counters);
+
+	for (pmu_type = 0; pmu_type < TORRENT_NUM_PMU_TYPES;
+	     pmu_type++) {
+		torrent_pmu = torrent_pmu_cntrs[get_chip()][pmu_type];
+		torrent_pmu_events = &all_torrent_events[pmu_type];
+
+		if (torrent_pmu_events->update) {
+			torrent_pmu_events->update = 0;
+
+			if (pmu_type <= TORRENT_LAST_PBUS_PMU_ID) {
+				/* Reserve the Pbus PMU */
+
+				pbus_pmu_reservation_cnt[pmu_type] =
+						torrent_pmu_events->n_events;
+			}
+
+			/*
+			 * Set up the physical PMCs with the new
+			 * events and set the PMU enable bit,
+			 * assign events to counters
+			 */
+			ret = torrent_pmu->compute_pmc_regs(
+					torrent_pmu_events, &hcall_write);
+
+			if (ret) {
+				pr_debug("%s:%d, compute_pmc_regs returned error = %d\n",
+					__func__, __LINE__, ret);
+				return;
+			}
+
+			torrent_pmu->enable_disable_cntr(1, torrent_pmu_events,
+							 &hcall_write);
+			torrent_pmu_events->disabled = 0;
+			start_timer = true;
+		}
+	}
+
+	/* Read the initial value of all of the PMDs that will be enabled */
+	do_hcall_pmd_read(&hcall_read, all_torrent_events);
+
+	/*
+	 * Now read the virtual counter PMD values from the physical registers
+	 * returned in variable hcall_read.  Set up the new PMC values.
+	 */
+	for (pmu_type = 0; pmu_type < TORRENT_NUM_PMU_TYPES;
+	     pmu_type++) {
+		torrent_pmu = torrent_pmu_cntrs[get_chip()][pmu_type];
+		torrent_pmu_events = &all_torrent_events[pmu_type];
+		/*
+		 * Call pmd_write to update the prev_count values
+		 * with the current values.
+		 */
+		torrent_pmu->write_pmd(torrent_pmu_events, &hcall_read);
+	}
+
+	/* Enable the PMUs with new events to add */
+	do_hcall_pmc_write(&hcall_write);
+
+	if (start_timer && !hrtimer_active(&torrent_poll_timer)) {
+		int ret;
+
+		poll_start_time = get_tb();
+		ret = hrtimer_start(&torrent_poll_timer,
+				    torrent_counter_poll_interval,
+				    HRTIMER_MODE_REL);
+		WARN_ON(ret != 0);
+	}
+
+	spin_unlock_irqrestore(&torrent_lock, lock_flags);
+}
+
+
+static void release_torrent_pmu_counters(struct perf_event *event,
+					 struct torrent_pmu_events
+					 *torrent_pmu_events,
+					 int pmu_type)
+{
+	int hw_cntr;
+
+	/*
+	 * The HCall has been done to stop the counters. The counters have
+	 * been read.  This function removes the counters from the PMU.
+	 */
+
+	hw_cntr = event->hw.idx;
+	torrent_pmu_events->unit.cntr_state[hw_cntr] = CNTR_FREE;
+
+	if (pmu_type <= TORRENT_LAST_PBUS_PMU_ID)
+		/* Release the PBUS PMU */
+		pbus_pmu_reservation_cnt[pmu_type]--;
+
+	event->hw.idx = -1;
+}
+
+
+void torrent_pmu_disable(struct pmu *pmu)
+{
+	struct torrent_pmu_events *torrent_pmu_events;
+	struct torrent_pmu_counters *torrent_pmu;
+	struct hcall_data hcall_write;
+	unsigned long lock_flags;
+	int pmu_type;
+
+	/* Disable and read all of the counters on all of the PMUs */
+
+	/* Set up the HCall to write the PMC's to stop the counters. */
+	spin_lock_irqsave(&torrent_lock, lock_flags);  /* Ensure only one CPU
+							* at a time access the
+							* HCall data structures
+							*/
+	/*
+	 * The first time that torrent_pmu_disable is called is when a
+	 * measurement is started, the poll_timer won't be running yet, but
+	 * all other times, it will be.  So hrtimer_cancel will return 0 on the
+	 * first call, and 1 subsequently.
+	 */
+	hrtimer_cancel(&torrent_poll_timer);
+
+	hcall_data_reset(&hcall_write);
+
+	for (pmu_type = 0; pmu_type < TORRENT_NUM_PMU_TYPES;
+	     pmu_type++) {
+		torrent_pmu = torrent_pmu_cntrs[get_chip()][pmu_type];
+
+		torrent_pmu_events = &all_torrent_events[pmu_type];
+		torrent_pmu->enable_disable_cntr(0, torrent_pmu_events,
+						 &hcall_write);
+		torrent_pmu_events->disabled = 1;
+	}
+
+	/* Do the HCall to write the physical registers. */
+	do_hcall_pmc_write(&hcall_write);
+	spin_unlock_irqrestore(&torrent_lock, lock_flags);
+}
+
+struct torrent_pmu_counters *map_to_pmu(u64 event_code)
+{
+	/* Extract the PMU type from the event and return the pointer to the
+	 * torrent_pmu_counters struct for that PMU type.
+	 */
+	int pmu_type;
+	int chip = get_chip();
+
+	BUG_ON(!IS_TORRENT_EVENT(event_code));
+	pmu_type = TORRENT_PMU_GET(event_code);
+
+	BUG_ON(pmu_type > TORRENT_LAST_PMU_ID);
+	return torrent_pmu_cntrs[chip][pmu_type];
+}
+
+int torrent_pmu_add(struct perf_event *event, int ef_flags)
+{
+	/*
+	 * This function adds the event to the list of events for
+	 * the PMU that counts the specified event.
+	 *
+	 * This function is called directly from the arch-independent code.
+	 */
+	int pmu_type, index, err, ret = -EAGAIN;
+	unsigned long lock_flags;
+	struct torrent_pmu_events tmp_all_events[TORRENT_NUM_PMU_TYPES];
+	struct torrent_pmu_events *torrent_pmu_events;
+
+	initialize_event_struct(tmp_all_events);
+
+	spin_lock_irqsave(&torrent_lock, lock_flags);  /* Ensure only one CPU
+							* at a time access the
+							* data structures.
+							*/
+
+	copy_all_events(all_torrent_events, tmp_all_events);
+
+	if (event->group_leader != event) {
+		collect_events(event->group_leader, tmp_all_events);
+	} else {
+
+		/*
+		 * Add the new group leader event to the list of existing
+		 * nest events.
+		 */
+		pmu_type = TORRENT_PMU_GET(event->attr.config);
+
+		if (pmu_type < 0) {
+			pr_err("%s: ERROR, pmu_type < 0\n",
+			       __func__);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		torrent_pmu_events = &tmp_all_events[pmu_type];
+
+		index = torrent_pmu_events->n_events
+			+ torrent_pmu_events->n_add;
+
+		if (index > get_max_nest_events(pmu_type)) {
+			pr_err("%s: ERROR, index out of range\n",
+			       __func__);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		torrent_pmu_events->event[index] = event;
+		torrent_pmu_events->n_add++;
+	}
+
+	if (torrent_txn.group_flag & PERF_EVENT_TXN) {
+		/*
+		 * If group events scheduling transaction was started,
+		 * skip the schedulability test here, it will be performed
+		 * at commit time(->commit_txn) as a whole.  Save the event
+		 * added to the list of transaction events being added.
+		 */
+		copy_all_events(tmp_all_events, txn_all_events);
+
+	} else {
+		/* check constraints for all pmus */
+		err = hw_perf_group_sched_in_torrent_check(tmp_all_events);
+
+		if (err) {
+			pr_err("%s, ERROR, Torrent sched in check failed\n",
+			       __func__);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		/*
+		 * Can now accept the events from the tmp list into the list
+		 * of current events for the Torrent PMU an add to list for
+		 * each physical PMU.
+		 */
+		accept_torrent_events(tmp_all_events, all_torrent_events);
+	}
+
+	/* Setup the group leader period info */
+	event->hw.config = event->attr.config;
+	event->hw.config_base = event->attr.config;
+	event->hw.event_base = 0;           /* nest doesn't use the flags */
+	event->hw.last_period = event->hw.sample_period;
+	local64_set(&event->hw.period_left, event->hw.last_period);
+	ret = 0;
+
+out:
+	spin_unlock_irqrestore(&torrent_lock, lock_flags);
+	return ret;
+}
+
+void torrent_pmu_del(struct perf_event *event, int ef_flags)
+{
+	/*
+	 * This function removes a single counter from a specific PMU.
+	 * The function is called from the arch-independent perf code.
+	 */
+
+	struct torrent_pmu_events *torrent_pmu_events;
+	struct torrent_pmu_counters *torrent_pmu;
+	struct hcall_data hcall_read;
+	struct hcall_data hcall_write;
+	struct unit_config *unit_config;
+	unsigned long lock_flags;
+	int i, pmu_type, events_released = 0, ret;
+	u64 event_code = event->hw.config;
+
+	/* Remove a single counter */
+	pmu_type = TORRENT_PMU_GET(event_code);
+
+	torrent_pmu = map_to_pmu(event_code);
+	if (!torrent_pmu)
+		return;
+
+	spin_lock_irqsave(&torrent_lock, lock_flags);  /* Ensure only one CPU
+							* at a time access the
+							* HCall data structures
+							*/
+	torrent_pmu_events = &all_torrent_events[pmu_type];
+
+	/* Set up variable hcall_write for the enable/disable call */
+	hcall_data_reset(&hcall_write);
+	torrent_pmu->enable_disable_cntr(0, torrent_pmu_events, &hcall_write);
+	do_hcall_pmc_write(&hcall_write);
+
+	/* Set up to do the PMD read call */
+	do_hcall_pmd_read(&hcall_read, all_torrent_events);
+
+	/* read the virtual counters */
+	torrent_pmu->read_pmd(torrent_pmu_events, &hcall_read);
+
+	/* Update the number of events being counted by the PMU */
+	unit_config = &torrent_pmu_events->unit;
+
+	/* Remove the event from the PMU list of events to count */
+	if (event->hw.idx >= 0)
+		/*
+		 * Only need to release counter if event was assigned to a
+		 * counter.   If the event failed the constraint test, it was
+		 * not assigned to a counter.
+		 */
+		unit_config->cntr_state[event->hw.idx] = CNTR_FREE;
+
+	for (i = 0; i < torrent_pmu_events->n_events; i++) {
+		if (event == torrent_pmu_events->event[i]) {
+			release_torrent_pmu_counters(event, torrent_pmu_events,
+						     pmu_type);
+
+			while (++i < torrent_pmu_events->n_events)
+				torrent_pmu_events->event[i - 1] =
+					torrent_pmu_events->event[i];
+
+			events_released++;
+			perf_event_update_userpage(event);
+		}
+	}
+
+	torrent_pmu_events->n_events -= events_released;
+	BUG_ON(torrent_pmu_events->n_events < 0);
+
+	if (pmu_type <= TORRENT_LAST_PBUS_PMU_ID)
+		/* Release the PBUS PMU */
+		pbus_pmu_reservation_cnt[pmu_type] =
+			torrent_pmu_events->n_events;
+
+	/* release PMU specific configuration values */
+	if (pmu_type == TORRENT_PBUS_MCD_ID)
+		unit_config->mcd_cntr_attr = 0x3;
+
+	if (pmu_type == TORRENT_PBUS_UTIL_ID) {
+		unit_config->bus_util_enable_mask = 0;
+		unit_config->bus_util_cntr_sel = BUS_UTIL_CNTR_SEL_AVAIL;
+	}
+
+	/* Enable the hardware counters on the specific PMU for the new list
+	 * of events
+	 */
+	ret = torrent_pmu->compute_pmc_regs(torrent_pmu_events, &hcall_write);
+	if (ret) {
+		pr_debug("%s:%d, compute_pmc_regs returned error = %d\n",
+			__func__, __LINE__, ret);
+		spin_unlock_irqrestore(&torrent_lock, lock_flags);
+		return;
+	}
+
+	torrent_pmu->enable_disable_cntr(1, torrent_pmu_events, &hcall_write);
+
+	do_hcall_pmc_write(&hcall_write);
+	spin_unlock_irqrestore(&torrent_lock, lock_flags);
+}
+
+static void poll_all_torrent_pmus(void)
+{
+	/*
+	 * The counters need to be read and reset periodically to ensure the
+	 * counters do not overflow.  Most of the counters do not support
+	 * interrupts so in general it is not possible to only update when the
+	 * counters overflow.  This routine will stop all the counters, read
+	 * the physical PMD registers, update the virtual count for each event,
+	 * reset the counter and then restart the counters.
+	 */
+
+	int pmu_type, dump_ret;
+	unsigned long lock_flags;
+	struct torrent_pmu_counters *torrent_pmu;
+	struct torrent_pmu_events *torrent_pmu_events;
+	struct hcall_data hcall_read;
+	struct hcall_data hcall_write;
+
+	spin_lock_irqsave(&torrent_lock, lock_flags); /* Ensure only one CPU
+						       * at a time access the
+						       * HCall data structures
+						       */
+	hcall_data_reset(&hcall_write);
+
+	/* Disable all of the active PMUs */
+	for (pmu_type = 0; pmu_type < TORRENT_NUM_PMU_TYPES; pmu_type++) {
+		torrent_pmu = torrent_pmu_cntrs[get_chip()][pmu_type];
+		torrent_pmu_events = &all_torrent_events[pmu_type];
+
+		if (torrent_pmu_events->n_events)
+			/* Only disable the PMUs with events being counted */
+			torrent_pmu->enable_disable_cntr(0, torrent_pmu_events,
+							 &hcall_write);
+	}
+
+	if (hcall_write.num_regs != 0) {
+		do_hcall_pmc_write(&hcall_write);
+		hcall_data_reset(&hcall_write);
+	}
+
+	if (hcall_write.do_dump_mmio_perf_counters)
+		dump_ret = wrap_hcall_hfi_dump_info(torrent_chip_id,
+				&hcall_write.mmio_perf_counters);
+
+	/* Setup the HCall to enable all of the PMUs */
+	for (pmu_type = 0; pmu_type < TORRENT_NUM_PMU_TYPES; pmu_type++) {
+		torrent_pmu = torrent_pmu_cntrs[get_chip()][pmu_type];
+		torrent_pmu_events = &all_torrent_events[pmu_type];
+
+		if (torrent_pmu_events->n_events)
+			/* Only enablee the PMUs with events being counted */
+			torrent_pmu->enable_disable_cntr(1, torrent_pmu_events,
+							 &hcall_write);
+	}
+
+	if (hcall_write.num_regs != 0) {
+		do_hcall_pmc_write(&hcall_write);
+		hcall_data_reset(&hcall_write);
+	}
+
+	if (hcall_write.do_dump_mmio_perf_counters)
+		dump_ret = wrap_hcall_hfi_dump_info(torrent_chip_id,
+				&hcall_write.mmio_perf_counters);
+
+	/* Read the initial value of all of the PMDs that will be enabled */
+	do_hcall_pmd_read(&hcall_read, all_torrent_events);
+
+	/* Now read the virtual counter PMD values from the physical registers
+	 * returned in hcall_read.  Set up the new PMC values.
+	 */
+	for (pmu_type = 0; pmu_type < TORRENT_NUM_PMU_TYPES;
+	     pmu_type++) {
+		torrent_pmu = torrent_pmu_cntrs[get_chip()][pmu_type];
+		torrent_pmu_events = &all_torrent_events[pmu_type];
+		/*
+		 * Call pmd_write to update the prev_count values
+		 * with the current values.
+		 */
+		torrent_pmu->write_pmd(torrent_pmu_events, &hcall_read);
+	}
+
+	/* Enable the PMUs */
+	do_hcall_pmc_write(&hcall_write);
+	spin_unlock_irqrestore(&torrent_lock, lock_flags);
+}
+
+static enum hrtimer_restart poll_torrent_pmus(struct hrtimer *timer)
+{
+	poll_all_torrent_pmus();
+
+	poll_start_time = get_tb();
+	hrtimer_forward_now(timer, torrent_counter_poll_interval);
+	return HRTIMER_RESTART;
+}
+
+/*
+ * These typedefs are present mostly to clean up the declaration of
+ * torrent_pmu_initialize, keeping the lines from going beyond column 80.
+ */
+
+typedef int (*compute_pmc_regs_fptr)(struct torrent_pmu_events *pmu_events,
+				     struct hcall_data *hcall_read);
+
+typedef int (*check_constraints_fptr)(struct torrent_pmu_events *pmu_events,
+				      struct unit_config *unit_cfg);
+
+typedef void (*enable_disable_cntr_fptr)(int op,
+					 struct torrent_pmu_events *pmu_events,
+					 struct hcall_data *hcall_write);
+
+typedef int (*pmd_read_fptr)(struct torrent_pmu_events *torrent_pmu_events,
+			     struct hcall_data *hcall_read);
+
+typedef void (*pmd_write_fptr)(struct torrent_pmu_events *torrent_pmu_events,
+			       struct hcall_data *hcall_read);
+
+typedef int (*get_phys_pmd_reg_fptr)(u64 event_code);
+
+static int torrent_pmu_initialize(int chip, int pmu_type,
+				  compute_pmc_regs_fptr compute_pmc_regs,
+				  check_constraints_fptr check_constraints,
+				  enable_disable_cntr_fptr enable_disable_cntr,
+				  pmd_read_fptr pmd_read,
+				  pmd_write_fptr pmd_write,
+				  get_phys_pmd_reg_fptr get_phys_pmd_reg)
+{
+	struct torrent_pmu_counters *torrent_pmu;
+
+	/*
+	 * This function allocates and initializes the data structure for the
+	 * Torrent PMU.  The PMU structure tracks the events, how many are on
+	 * the PMU, what function to call to read/write the physical PMU data
+	 * and control registers, etc.
+	 *
+	 * This routine is assumed to return 0 on no error or -ENOMEM.
+	 */
+	torrent_pmu = torrent_pmu_cntrs[chip][pmu_type];
+
+	torrent_pmu->compute_pmc_regs = compute_pmc_regs;
+	torrent_pmu->check_constraints = check_constraints;
+	torrent_pmu->enable_disable_cntr = enable_disable_cntr;
+	torrent_pmu->read_pmd = pmd_read;
+	torrent_pmu->write_pmd = pmd_write;
+	torrent_pmu->get_phys_pmd_reg = get_phys_pmd_reg;
+
+	hrtimer_init(&torrent_poll_timer, CLOCK_MONOTONIC,
+		     HRTIMER_MODE_REL);
+	torrent_poll_timer.function = &poll_torrent_pmus;
+
+	spin_lock_init(&torrent_lock);
+
+	return 0;
+}
+
+static const struct {
+	int counters;
+} per_pmu_info[TORRENT_NUM_PMU_TYPES] = {
+	[TORRENT_PBUS_WXYZ_ID] = {
+		.counters = MAX_CNTRS_PER_WXYZ_LINK_PMU
+		},
+	[TORRENT_PBUS_LL_ID] = {
+		.counters = MAX_CNTRS_PER_LL_LINK_PMU
+		},
+	[TORRENT_PBUS_MCD_ID] = {
+		.counters = MAX_CNTRS_PER_MCD_PMU
+		},
+	[TORRENT_PBUS_UTIL_ID] = {
+		.counters = MAX_CNTRS_PER_BUS_UTIL_PMU
+		},
+	[TORRENT_MMU_ID] = {
+		.counters = MAX_CNTRS_PER_MMU_PMU
+		},
+	[TORRENT_CAU_ID] = {
+		.counters = MAX_CNTRS_PER_CAU_PMU
+		}
+};
+
+static int alloc_torrent_pmu_cntrs(int num_torrent_chips)
+{
+	int chip, pmu_type;
+
+	/* Allocate space for the torrent_pmu_cntrs struct. */
+
+	/* Allocate space for the top level index. */
+	torrent_pmu_cntrs = kmalloc(sizeof(void *) * num_torrent_chips,
+				    GFP_KERNEL);
+
+	if (!torrent_pmu_cntrs)
+		return -ENOMEM;
+
+	for (chip = 0; chip < num_torrent_chips; chip++) {
+		/* Allocate space for the node-level pointer array. */
+		torrent_pmu_cntrs[chip] = kmalloc(
+			sizeof(void *) * TORRENT_NUM_PMU_TYPES, GFP_KERNEL);
+
+		if (!torrent_pmu_cntrs[chip])
+			return -ENOMEM;
+
+		for (pmu_type = 0; pmu_type < TORRENT_NUM_PMU_TYPES;
+		     pmu_type++) {
+			torrent_pmu_cntrs[chip][pmu_type] =
+				kmalloc(
+					sizeof(struct torrent_pmu_counters),
+					GFP_KERNEL);
+
+			if (!torrent_pmu_cntrs[chip][pmu_type]) {
+				pr_err("%s: ran out of memory for torrent_pmu_cntrs",
+				       __func__);
+				return -ENOMEM;
+			}
+		}
+	}
+	return 0;
+}
+
+static void dealloc_torrent_pmu_cntrs(int num_torrent_chips)
+{
+	int chip, pmu_type;
+
+	/* Release the torrent_pmu_cntrs structs. */
+
+	for (chip = 0; chip < num_torrent_chips; chip++) {
+
+		for (pmu_type = 0; pmu_type < TORRENT_NUM_PMU_TYPES;
+		     pmu_type++)
+			kfree(torrent_pmu_cntrs[chip][pmu_type]);
+
+		kfree(torrent_pmu_cntrs[chip]);
+	}
+	torrent_pmu_cntrs = kmalloc(sizeof(void *) * num_torrent_chips,
+				    GFP_KERNEL);
+}
+
+static u64 get_torrent_chip_id(void)
+{
+	struct device_node	*node;
+	u64			*lp;
+
+	node = of_find_node_by_name(NULL, "hfi-iohub");
+	if (!node) {
+		pr_err("%s: of_find_node_by_name"
+				" 'hfi-iohub' failed\n", __func__);
+		return -EINVAL;
+	}
+
+	lp = (u64 *)of_get_property(node, "reg", NULL);
+	if (!lp) {
+		pr_err("%s: of_get_property 'hfi-iohub/reg' failed\n",
+		       __func__);
+		return -EINVAL;
+	}
+	return *lp;
+}
+
+static u64 get_hfi_unit_id(void)
+{
+	u8			octant, id;
+	u32			*p;
+	struct device_node	*node;
+	struct device_node	*child_node = NULL;
+
+	node = of_find_node_by_name(NULL, "hfi-iohub");
+	if (!node) {
+		pr_err("%s: of_find_node_by_name 'hfi-iohub' failed\n",
+		       __func__);
+		return -EINVAL;
+	}
+	octant = (node->full_name[strlen(node->full_name) - 1] - '0');
+	if (octant > HFI_MAX_OCTANT) {
+		pr_err("%s: invalid hfi-iohub octant '%s'\n",
+		       __func__, node->full_name);
+		return -EINVAL;
+	}
+
+	id = octant << HFI_SHIFT_OCTANT;
+
+	while ((child_node = of_get_next_child(node, child_node))) {
+		p = (u32 *)of_get_property(child_node, "reg", NULL);
+		if (!p) {
+			pr_err("%s: of_get_property 'reg' failed\n", __func__);
+			return -EINVAL;
+		}
+		if (id == (u8)*p)
+			return id;
+	}
+	pr_err("%s: can not find child\n", __func__);
+	return -EINVAL;
+}
+
+void torrent_pmu_start(struct perf_event *event, int ef_flags)
+{
+	/* Don't support enable/disable on individual hardware counters */
+
+	if (!event->hw.idx || !event->hw.sample_period)
+		return;
+
+	if (!(event->hw.state & PERF_HES_STOPPED))
+		return;
+
+	event->hw.state = 0;
+
+}
+
+void torrent_pmu_stop(struct perf_event *event, int ef_flags)
+{
+
+	if (!event->hw.idx || !event->hw.sample_period)
+		return;
+
+	if (event->hw.state & PERF_HES_STOPPED)
+		return;
+
+	event->hw.state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+}
+
+void torrent_pmu_read(struct perf_event *event)
+{
+
+	s64 delta, prev, value;
+	unsigned long lock_flags;
+	u8 virt_cntr;
+	int pmu_type;
+	struct hcall_data hcall_read;
+	struct torrent_pmu_events *torrent_pmu_events;
+	struct torrent_pmu_counters *torrent_pmu;
+	u64 event_code = event->hw.config;
+
+	if (!event->hw.idx)
+		return;
+
+	spin_lock_irqsave(&torrent_lock, lock_flags);  /* Ensure only one CPU
+							* at a time access the
+							* HCall data structures
+							*/
+	pmu_type = TORRENT_PMU_GET(event_code);
+	torrent_pmu = map_to_pmu(event_code);
+	torrent_pmu_events = &all_torrent_events[pmu_type];
+
+	/* Set up variable hcall_write for the enable/disable call. */
+	do_hcall_pmd_read(&hcall_read, all_torrent_events);
+	virt_cntr = TORRENT_VIRT_CTR_GET(event->hw.config);
+
+	prev = local64_read(&event->hw.prev_count);
+	value = torrent_pmu->read_pmd(torrent_pmu_events, &hcall_read);
+
+	/* calculate/save the count */
+	delta = value - prev;
+	local64_add(delta, &event->count);
+	local64_set(&event->hw.prev_count, value);
+
+	local64_add(delta, &event->count);
+	local64_sub(delta, &event->hw.period_left);
+	spin_unlock_irqrestore(&torrent_lock, lock_flags);
+}
+
+/*
+ * The transaction scheduling is done across all of the physical PMUs within
+ * the Torrent chip.  When using transaction scheduling, the compatibility
+ * check is skipped for the events as each event is being added..  Once the
+ * entire set of events has been added, the constraint check is done for all
+ * of the events that have been added.
+ *
+ * Set the flag to make pmu::enable() not perform the constraint check.
+ */
+void torrent_pmu_start_txn(struct pmu *pmu)
+{
+	perf_pmu_disable(pmu);
+
+	torrent_txn.group_flag |= PERF_EVENT_TXN;
+	copy_all_events(all_torrent_events, txn_all_events);
+}
+
+void torrent_pmu_cancel_txn(struct pmu *pmu)
+{
+	perf_pmu_disable(pmu);
+
+	torrent_txn.group_flag &= PERF_EVENT_TXN;
+}
+
+int torrent_pmu_commit_txn(struct pmu *pmu)
+{
+	/*
+	 * Do constraint check for new events across all physical PMUs within
+	 * the Torrent chip.
+	 */
+	int err;
+	unsigned long lock_flags;
+
+	spin_lock_irqsave(&torrent_lock, lock_flags);
+
+	/* check constraints for all pmus */
+	err = hw_perf_group_sched_in_torrent_check(txn_all_events);
+
+	if (err) {
+		pr_err("%s, ERROR, Torrent sched in check failed\n", __func__);
+		spin_unlock_irqrestore(&torrent_lock, lock_flags);
+		return -EAGAIN;
+	}
+
+	/*
+	 * Can now accept the events from the txn list into the list of
+	 * current events for the Torrent PMU an add to list for each physical
+	 * PMU.
+	 */
+
+	accept_torrent_events(txn_all_events, all_torrent_events);
+	spin_unlock_irqrestore(&torrent_lock, lock_flags);
+
+	perf_pmu_enable(pmu);
+	return 0;
+}
+
+int torrent_pmu_event_init(struct perf_event *event)
+{
+	int pmu_type, index, err, rtn = 0;
+	unsigned long flags;
+	struct torrent_pmu_events *torrent_pmu_events;
+	struct torrent_pmu_events tmp_all_events[TORRENT_NUM_PMU_TYPES];
+
+	/*
+	 * If this is in a group, check if it can go on with all the
+	 * other hardware events in the group.  We assume the event
+	 * hasn't been linked into its leader's sibling list at this point.
+	 */
+
+	local_irq_save(flags);
+	switch (event->attr.type) {
+	case PERF_TYPE_RAW:
+		if (!IS_TORRENT_EVENT(event->attr.config)) {
+			rtn = -ENOENT;
+			goto out;
+		}
+		break;
+
+	default:
+		rtn = -ENOENT;
+		goto out;
+	}
+
+	/*
+	 * Use an empty data structure to see if the events are self
+	 * consistent.
+	 */
+	initialize_event_struct(tmp_all_events);
+
+	if (event->group_leader != event) {
+		/*
+		 * Use a temporary array of pmu events in case the entire
+		 * group needs to be rejected.
+		 */
+		collect_events(event->group_leader, tmp_all_events);
+	}
+
+	/* Include the group leader event to list of existing nest events */
+	pmu_type = TORRENT_PMU_GET(event->attr.config);
+
+	if (pmu_type < 0) {
+		pr_err("%s: ERROR, pmu_type < 0\n", __func__);
+		rtn = -EINVAL;
+		goto out;
+	}
+
+	torrent_pmu_events = &tmp_all_events[pmu_type];
+	index = torrent_pmu_events->n_events + torrent_pmu_events->n_add;
+	if (index >= get_max_nest_events(pmu_type)) {
+		pr_err("%s: ERROR, index out of range\n",
+		       __func__);
+		rtn = -EINVAL;
+		goto out;
+	}
+	torrent_pmu_events->event[index] = event;
+	torrent_pmu_events->n_add++;
+
+	/* check constraints of new events */
+	err = hw_perf_group_sched_in_torrent_check(tmp_all_events);
+	if (err) {
+		pr_err("%s, ERROR, Torrent sched in check failed\n", __func__);
+		rtn = -EINVAL;
+		goto out;
+	}
+
+out:
+	local_irq_restore(flags);
+	return rtn;
+}
+
+struct pmu torrent_pmu = {
+	.pmu_enable	= torrent_pmu_enable,
+	.pmu_disable	= torrent_pmu_disable,
+	.event_init	= torrent_pmu_event_init,
+	.add		= torrent_pmu_add,
+	.del		= torrent_pmu_del,
+	.start		= torrent_pmu_start,
+	.stop		= torrent_pmu_stop,
+	.read		= torrent_pmu_read,
+	.start_txn	= torrent_pmu_start_txn,
+	.cancel_txn	= torrent_pmu_cancel_txn,
+	.commit_txn	= torrent_pmu_commit_txn,
+};
+
+int __init torrent_pmu_init(void)
+{
+	int chip, ret;
+
+	/*
+	 * Set up the structure for each of the PMU types to track what
+	 * events are being counted by that PMU.
+	 */
+
+	/* Attempt to determine the correct Torrent chip id, the HFI unit id
+	 * and lock the counter facility.  If we can't do these things, then
+	 * we are not on a P7IH system, exit and do not setup the Torrent PMU.
+	 */
+	torrent_chip_id = get_torrent_chip_id();
+	if (torrent_chip_id < 0)
+		/* torrent_chip_id will be set to the errno if not valid */
+		return torrent_chip_id;
+
+	hfi_unit_id = get_hfi_unit_id();
+	if (hfi_unit_id < 0)
+		/* torrent_chip_id will be set to the errno if not valid */
+		return torrent_chip_id;
+
+	/*
+	 * Lock the counter facility for this partition's access.  Note that
+	 * we don't ever unlock it.
+	 */
+
+	 ret = PLPAR_HCALL(H_TOR_ACCESS_PMU_SCOM_REGS, torrent_chip_id,
+			   PBUS_HCALL_LOCK, 0, (unsigned long)NULL);
+	if (ret != H_SUCCESS) {
+		pr_err("%s, ERROR, lock counter facility HCall returned an error %d\n",
+		       __func__, ret);
+		return -EINVAL;
+	}
+
+	/*
+	 * Looks like we are on a Torrent system, allocate space for the
+	 * torrent_pmu_cntrs struct.
+	 */
+	pr_debug("Number of Torrent chips %d\n", num_torrent_chips);
+	ret = alloc_torrent_pmu_cntrs(num_torrent_chips);
+	if (ret) {
+		pr_err("%s,%d: Failed to allocate torrent_pmu_cntrs, retval = %d\n",
+			__func__, __LINE__, ret);
+		return ret;
+	}
+
+	/* Align the 4K buffer used for HCalls */
+	aligned_buffer = (u64 *)((u64)unaligned_buffer + 0xFFFULL);
+	aligned_buffer = (u64 *)((u64)aligned_buffer & ~0xFFFULL);
+
+	/* We currently only support one Torrent chip */
+	chip = get_chip();
+
+	pr_debug("%s: set up Torrent chip %d WXYZ link PMU\n", __func__, chip);
+
+	if (torrent_pmu_initialize(chip, TORRENT_PBUS_WXYZ_ID,
+				   wxyz_link_compute_pmc_reg,
+				   wxyz_link_pmu_check_constraints,
+				   wxyz_link_enable_disable_hw_cntr,
+				   wxyz_link_pmd_read,
+				   wxyz_link_pmd_write,
+				   wxyz_link_get_phys_pmd_reg)) {
+		pr_err("%s: ERROR WXYZ Link PMU initialize failed\n",
+		       __func__);
+		goto out;
+	}
+
+	if (torrent_pmu_initialize(chip, TORRENT_PBUS_LL_ID,
+				   ll_link_compute_pmc_reg,
+				   ll_link_pmu_check_constraints,
+				   ll_link_enable_disable_hw_cntr,
+				   ll_link_pmd_read,
+				   ll_link_pmd_write,
+				   ll_link_get_phys_pmd_reg)) {
+		pr_err("%s: ERROR LL Link PMU initialize failed\n",
+		       __func__);
+		goto out;
+	}
+
+	if (torrent_pmu_initialize(chip, TORRENT_PBUS_MCD_ID,
+				   mcd_compute_pmc_reg,
+				   mcd_pmu_check_constraints,
+				   mcd_enable_disable_hw_cntr,
+				   mcd_pmd_read,
+				   mcd_pmd_write,
+				   mcd_get_phys_pmd_reg)) {
+		pr_err("%s: ERROR MCD PMU initialize failed\n",
+		       __func__);
+		goto out;
+	}
+
+	if (torrent_pmu_initialize(chip, TORRENT_PBUS_UTIL_ID,
+				   bus_util_compute_pmc_reg,
+				   bus_util_pmu_check_constraints,
+				   bus_util_enable_disable_hw_cntr,
+				   bus_util_pmd_read,
+				   bus_util_pmd_write,
+				   bus_util_get_phys_pmd_reg)) {
+		pr_err("%s: ERROR BUS UTIL PMU initialize failed\n",
+		       __func__);
+		goto out;
+	}
+
+	if (torrent_pmu_initialize(chip, TORRENT_MMU_ID,
+				   mmu_compute_pmc_reg,
+				   mmu_pmu_check_constraints,
+				   mmu_enable_disable_hw_cntr,
+				   mmu_pmd_read,
+				   mmu_pmd_write,
+				   mmu_get_phys_pmd_reg)) {
+		pr_err("%s: ERROR MMU PMU initialize failed\n",
+		       __func__);
+		goto out;
+	}
+
+	if (torrent_pmu_initialize(chip, TORRENT_CAU_ID,
+				   cau_compute_pmc_reg,
+				   cau_pmu_check_constraints,
+				   cau_enable_disable_hw_cntr,
+				   cau_pmd_read,
+				   cau_pmd_write,
+				   cau_get_phys_pmd_reg)) {
+		pr_err("%s: ERROR CAU PMU initialize failed\n",
+		       __func__);
+		goto out;
+	}
+
+	/* Initialize the structure to track the events being counted by
+	 * the physical Torrent PMUs.
+	 */
+	initialize_event_struct(all_torrent_events);
+
+	/* Initialize the poll interval value.  It's used as a constant
+	 * elsewhere.
+	 */
+	torrent_counter_poll_interval = ktime_set(POLLING_INTERVAL_SEC,
+						  POLLING_INTERVAL_NS);
+	ret = perf_pmu_register(&torrent_pmu, "torrent", -1);
+	return 0;
+out:
+	dealloc_torrent_pmu_cntrs(num_torrent_chips);
+	return -ENOMEM;
+
+}
+
+arch_initcall(torrent_pmu_init);
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 71af4c5..402a029 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -26,6 +26,11 @@ config PPC_SPLPAR
 	  processors, that is, which share physical processors between
 	  two or more partitions.
 
+config PPC_P7IH
+	bool "P7IH (w/Torrent interconnect)"
+	depends on PPC_PSERIES
+	default n
+
 config EEH
 	bool "PCI Extended Error Handling (EEH)" if EXPERT
 	depends on PPC_PSERIES && PCI
-- 
1.7.0.4
