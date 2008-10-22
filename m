Return-Path: <brking@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 05030DDE0E
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 02:54:13 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9MFsA2v026161
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 11:54:10 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9MFsARI083476
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 11:54:10 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9MFs703003102
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 11:54:07 -0400
Message-ID: <48FF4C89.60704@linux.vnet.ibm.com>
Date: Wed, 22 Oct 2008 10:53:45 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: [PATCHv3 1/1] powerpc: Update page in counter for CMM
References: <200810210436.m9L4aepT056796@sullivan.realtime.net>
	<48FE3B16.5050402@linux.vnet.ibm.com>
	<1224634291.7654.287.camel@pasglop>
In-Reply-To: <1224634291.7654.287.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A new field has been added to the VPA as a method for
the client OS to communicate to firmware the number of
page ins it is performing when running collaborative
memory overcommit. The hypervisor will use this information
to better determine if a partition is experiencing memory
pressure and needs more memory allocated to it.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/include/asm/lppaca.h |    3 ++-
 arch/powerpc/kernel/paca.c        |    1 +
 arch/powerpc/mm/fault.c           |   12 ++++++++++--
 3 files changed, 13 insertions(+), 3 deletions(-)

diff -puN arch/powerpc/mm/fault.c~powerpc_vrm_mm_pressure arch/powerpc/mm/fault.c
--- linux-2.6/arch/powerpc/mm/fault.c~powerpc_vrm_mm_pressure	2008-10-20 17:13:25.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/mm/fault.c	2008-10-22 08:53:13.000000000 -0500
@@ -30,6 +30,7 @@
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
 
+#include <asm/firmware.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/mmu.h>
@@ -318,9 +319,16 @@ good_area:
 			goto do_sigbus;
 		BUG();
 	}
-	if (ret & VM_FAULT_MAJOR)
+	if (ret & VM_FAULT_MAJOR) {
 		current->maj_flt++;
-	else
+#ifdef CONFIG_PPC_SMLPAR
+		if (firmware_has_feature(FW_FEATURE_CMO)) {
+			preempt_disable();
+			get_lppaca()->page_ins++;
+			preempt_enable();
+		}
+#endif
+	} else
 		current->min_flt++;
 	up_read(&mm->mmap_sem);
 	return 0;
diff -puN arch/powerpc/include/asm/lppaca.h~powerpc_vrm_mm_pressure arch/powerpc/include/asm/lppaca.h
--- linux-2.6/arch/powerpc/include/asm/lppaca.h~powerpc_vrm_mm_pressure	2008-10-20 17:13:25.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/include/asm/lppaca.h	2008-10-21 13:46:45.000000000 -0500
@@ -133,7 +133,8 @@ struct lppaca {
 //=============================================================================
 // CACHE_LINE_4-5 0x0180 - 0x027F Contains PMC interrupt data
 //=============================================================================
-	u8	pmc_save_area[256];	// PMC interrupt Area           x00-xFF
+	u32	page_ins;			// CMO Hint - # page ins by OS  x00-x04
+	u8	pmc_save_area[252];	// PMC interrupt Area           x04-xFF
 } __attribute__((__aligned__(0x400)));
 
 extern struct lppaca lppaca[];
diff -puN arch/powerpc/kernel/paca.c~powerpc_vrm_mm_pressure arch/powerpc/kernel/paca.c
--- linux-2.6/arch/powerpc/kernel/paca.c~powerpc_vrm_mm_pressure	2008-10-20 17:13:25.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/kernel/paca.c	2008-10-20 17:13:25.000000000 -0500
@@ -37,6 +37,7 @@ struct lppaca lppaca[] = {
 		.end_of_quantum = 0xfffffffffffffffful,
 		.slb_count = 64,
 		.vmxregs_in_use = 0,
+		.page_ins = 0,
 	},
 };
 
_
