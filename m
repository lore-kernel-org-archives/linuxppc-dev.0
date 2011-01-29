Return-Path: <anton@samba.org>
Date: Sun, 30 Jan 2011 09:28:04 +1100
From: Anton Blanchard <anton@samba.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, jlarrew@linux.vnet.ibm.com
Subject: [PATCH 3/5] powerpc/numa: Add length when creating OF properties
	via VPHN
Message-ID: <20110130092804.45c80318@kryten>
In-Reply-To: <20110130092434.42a887ef@kryten>
References: <20110118123152.50f75a72@kryten>
	<20110118224718.GA19039@us.ibm.com>
	<1295409980.2148.125.camel@pasglop>
	<20110119043757.GA29865@us.ibm.com>
	<20110130092217.70ebb424@kryten> <20110130092434.42a887ef@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The rest of the NUMA code expects an OF associativity property with
the first cell containing the length. Without this fix all topology changes
cause us to misparse the property and put the cpu into node 0.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/mm/numa.c
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/numa.c	2011-01-29 12:45:09.257654450 +1100
+++ linux-2.6/arch/powerpc/mm/numa.c	2011-01-29 12:56:30.854975882 +1100
@@ -1356,8 +1356,11 @@ static int update_cpu_associativity_chan
 	return nr_cpus;
 }
 
-/* 6 64-bit registers unpacked into 12 32-bit associativity values */
-#define VPHN_ASSOC_BUFSIZE (6*sizeof(u64)/sizeof(u32))
+/*
+ * 6 64-bit registers unpacked into 12 32-bit associativity values. To form
+ * the complete property we have to add the length in the first cell.
+ */
+#define VPHN_ASSOC_BUFSIZE (6*sizeof(u64)/sizeof(u32) + 1)
 
 /*
  * Convert the associativity domain numbers returned from the hypervisor
@@ -1373,7 +1376,7 @@ static int vphn_unpack_associativity(con
 #define VPHN_FIELD_MSB		(0x8000)
 #define VPHN_FIELD_MASK		(~VPHN_FIELD_MSB)
 
-	for (i = 0; i < VPHN_ASSOC_BUFSIZE; i++) {
+	for (i = 1; i < VPHN_ASSOC_BUFSIZE; i++) {
 		if (*field == VPHN_FIELD_UNUSED) {
 			/* All significant fields processed, and remaining
 			 * fields contain the reserved value of all 1's.
@@ -1398,6 +1401,9 @@ static int vphn_unpack_associativity(con
 		}
 	}
 
+	/* The first cell contains the length of the property */
+	unpacked[0] = nr_assoc_doms;
+
 	return nr_assoc_doms;
 }
 
