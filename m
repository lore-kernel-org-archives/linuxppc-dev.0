Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18453.18943.906693.409245@cargo.ozlabs.ibm.com>
Date: Mon, 28 Apr 2008 13:52:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Add fast little-endian switch system call
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds a system call on 64-bit platforms for switching between
little-endian and big-endian modes that is much faster than doing a
prctl call.  This system call is handled as a special case right at
the start of the system call entry code, and because it is a special
case, it uses a system call number which is out of the range of
normal system calls, namely 0x1ebe.

Measurements with lmbench on a 4.2GHz POWER6 showed no measurable
change in the speed of normal system calls with this patch.

Switching endianness with this new system call takes around 60ns on a
4.2GHz POWER6, compared with around 300ns to switch endian mode with a
prctl.  This can provide a significant performance advantage for
emulators for little-endian architectures that want to switch between
big-endian and little-endian mode frequently, e.g. because they are
generating instructions sequences on the fly and they want to run
those sequences in little-endian mode.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 215973a..2eb49a7 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -239,6 +239,10 @@ instruction_access_slb_pSeries:
 	.globl	system_call_pSeries
 system_call_pSeries:
 	HMT_MEDIUM
+BEGIN_FTR_SECTION
+	cmpdi	r0,0x1ebe
+	beq-	1f
+END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
 	mr	r9,r13
 	mfmsr	r10
 	mfspr	r13,SPRN_SPRG3
@@ -253,6 +257,13 @@ system_call_pSeries:
 	rfid
 	b	.	/* prevent speculative execution */
 
+/* Fast LE/BE switch system call */
+1:	mfspr	r12,SPRN_SRR1
+	xori	r12,r12,MSR_LE
+	mtspr	SPRN_SRR1,r12
+	rfid		/* return to userspace */
+	b	.
+
 	STD_EXCEPTION_PSERIES(0xd00, single_step)
 	STD_EXCEPTION_PSERIES(0xe00, trap_0e)
 
