Return-Path: <paulus@ozlabs.org>
Date: Tue, 6 Dec 2011 16:35:32 +1100
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/powernv: Fix problems in onlining CPUs
Message-ID: <20111206053532.GA12389@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At present, on the powernv platform, if you off-line a CPU that was
online, and then try to on-line it again, the kernel generates a
warning message "OPAL Error -1 starting CPU n".  Furthermore, if the
CPU is a secondary thread that was used by KVM while it was off-line,
the CPU fails to come online.

The first problem is fixed by only calling OPAL to start the CPU the
first time it is on-lined, as indicated by the cpu_start field of its
PACA being zero.  The second problem is fixed by restoring the
cpu_start field to 1 instead of 0 when using the CPU within KVM.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index e37f8f4..ca9b733 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -65,7 +65,7 @@ BEGIN_FTR_SECTION
 	lbz	r0,PACAPROCSTART(r13)
 	cmpwi	r0,0x80
 	bne	1f
-	li	r0,0
+	li	r0,1
 	stb	r0,PACAPROCSTART(r13)
 	b	kvm_start_guest
 1:
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index e877366..17210c5 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -75,7 +75,7 @@ int __devinit pnv_smp_kick_cpu(int nr)
 	/* On OPAL v2 the CPU are still spinning inside OPAL itself,
 	 * get them back now
 	 */
-	if (firmware_has_feature(FW_FEATURE_OPALv2)) {
+	if (!paca[nr].cpu_start && firmware_has_feature(FW_FEATURE_OPALv2)) {
 		pr_devel("OPAL: Starting CPU %d (HW 0x%x)...\n", nr, pcpu);
 		rc = opal_start_cpu(pcpu, start_here);
 		if (rc != OPAL_SUCCESS)
