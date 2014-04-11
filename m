Return-Path: <paulus@ozlabs.org>
Date: Fri, 11 Apr 2014 16:43:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] powerpc: Don't try to set LPCR unless we're in hypervisor mode
Message-ID: <20140411064335.GA8806@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 8f619b5429d9 ("powerpc/ppc64: Do not turn AIL (reloc-on
interrupts) too early") added code to set the AIL bit in the LPCR
without checking whether the kernel is running in hypervisor mode.
The result is that when the kernel is running as a guest (i.e.,
under PowerKVM or PowerVM), the processor takes a privileged
instruction interrupt at that point, causing a panic.  The visible
result is that the kernel hangs after printing "returning from
prom_init".

This fixes it by checking for hypervisor mode being available
before setting LPCR.  If we are not in hypervisor mode, we enable
relocation-on interrupts later in pSeries_setup_arch using the
H_SET_MODE hcall.

Signed-off-by: Paul Mackerras <paulus@samba.org>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
Linus, Ben asked me to send this to you since he's about to be on
vacation, and this bug stops the kernel from booting under a
hypervisor on POWER8 machines.  He would like it to go in before rc1.

 arch/powerpc/kernel/setup_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 3d7a50a..fbe2437 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -201,7 +201,8 @@ static void cpu_ready_for_interrupts(void)
 	get_paca()->kernel_msr = MSR_KERNEL;
 
 	/* Enable AIL if supported */
-	if (cpu_has_feature(CPU_FTR_ARCH_207S)) {
+	if (cpu_has_feature(CPU_FTR_HVMODE) &&
+	    cpu_has_feature(CPU_FTR_ARCH_207S)) {
 		unsigned long lpcr = mfspr(SPRN_LPCR);
 		mtspr(SPRN_LPCR, lpcr | LPCR_AIL_3);
 	}
-- 
1.9.rc1
