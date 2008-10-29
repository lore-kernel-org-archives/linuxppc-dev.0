Return-Path: <cel@us.ibm.com>
Subject: Re: [UPDATED PATCH VER2] Cell OProfile: Incorrect local array size
	in activate spu profiling function
From: Carl Love <cel@us.ibm.com>
To: michael@ellerman.id.au
In-Reply-To: <1225241514.7799.2.camel@localhost>
References: <1224874049.20229.5.camel@carll-linux-desktop>
	<1224909595.16090.5.camel@localhost>
	<1225207079.20229.32.camel@carll-linux-desktop>
	<1225241514.7799.2.camel@localhost>
Content-Type: text/plain
Date: Wed, 29 Oct 2008 08:06:45 -0700
Message-Id: <1225292805.20229.52.camel@carll-linux-desktop>
Mime-Version: 1.0
Cc: acjohnso <acjohnso@us.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>,
	Hannsj_uhl <Hannsj_uhl@de.ibm.com>, linuxppc-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, cel@linux.vnet.ibm.com,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Updated the patch to address comments by Michael Ellerman.  
Specifically, changed upper limit in for loop to 
ARRAY_SIZE() macro and added a check to make sure the 
number of events specified by the user, which is used as
the max for indexing various arrays, is no bigger then the
declared size of the arrays.

The size of the pm_signal_local array should be equal to the
number of SPUs being configured in the array.  Currently, the
array is of size 4 (NR_PHYS_CTRS) but being indexed by a for 
loop from 0 to 7 (NUM_SPUS_PER_NODE).  

Signed-off-by: Carl Love <carll@us.ibm.com>


Index: Cell_kernel_10_24_2008/arch/powerpc/oprofile/op_model_cell.c
===================================================================
--- Cell_kernel_10_24_2008.orig/arch/powerpc/oprofile/op_model_cell.c
+++ Cell_kernel_10_24_2008/arch/powerpc/oprofile/op_model_cell.c
@@ -582,6 +582,13 @@ static int cell_reg_setup(struct op_coun
 
 	num_counters = num_ctrs;
 
+	if (unlikely(num_ctrs > NR_PHYS_CTRS)) {
+		printk(KERN_ERR
+		       "%s: Oprofile, number of specified events " \
+		       "exceeds number of physical counters\n",
+		       __func__);
+		return -EIO;
+	}
 	pm_regs.group_control = 0;
 	pm_regs.debug_bus_control = 0;
 
@@ -830,13 +837,13 @@ static int calculate_lfsr(int n)
 static int pm_rtas_activate_spu_profiling(u32 node)
 {
 	int ret, i;
-	struct pm_signal pm_signal_local[NR_PHYS_CTRS];
+	struct pm_signal pm_signal_local[NUM_SPUS_PER_NODE];
 
 	/*
 	 * Set up the rtas call to configure the debug bus to
 	 * route the SPU PCs.  Setup the pm_signal for each SPU
 	 */
-	for (i = 0; i < NUM_SPUS_PER_NODE; i++) {
+	for (i = 0; i < ARRAY_SIZE(pm_signal_local); i++) {
 		pm_signal_local[i].cpu = node;
 		pm_signal_local[i].signal_group = 41;
 		/* spu i on word (i/2) */
@@ -848,7 +855,7 @@ static int pm_rtas_activate_spu_profilin
 
 	ret = rtas_ibm_cbe_perftools(SUBFUNC_ACTIVATE,
 				     PASSTHRU_ENABLE, pm_signal_local,
-				     (NUM_SPUS_PER_NODE
+				     (ARRAY_SIZE(pm_signal_local)
 				      * sizeof(struct pm_signal)));
 
 	if (unlikely(ret)) {
