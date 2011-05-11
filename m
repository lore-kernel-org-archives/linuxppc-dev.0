Return-Path: <paulus@ozlabs.org>
Date: Wed, 11 May 2011 20:44:07 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org
Subject: [PATCH 09/13] powerpc: Set up LPCR for running guest partitions
Message-ID: <20110511104407.GJ2837@brick.ozlabs.ibm.com>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110511103443.GA2837@brick.ozlabs.ibm.com>
Cc: Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In hypervisor mode, the LPCR controls several aspects of guest
partitions, including virtual partition memory mode, and also controls
whether the hypervisor decrementer interrupts are enabled.  This sets
up LPCR at boot time so that guest partitions will use a virtual real
memory area (VRMA) composed of 16MB large pages, and hypervisor
decrementer interrupts are disabled.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/reg.h         |    4 ++++
 arch/powerpc/kernel/cpu_setup_power7.S |   18 +++++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 05658b7..c07b7be 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -231,10 +231,12 @@
 #define   LPCR_VPM0	(1ul << (63-0))
 #define   LPCR_VPM1	(1ul << (63-1))
 #define   LPCR_ISL	(1ul << (63-2))
+#define   LPCR_VC_SH	(63-2)
 #define   LPCR_DPFD_SH	(63-11)
 #define   LPCR_VRMA_L	(1ul << (63-12))
 #define   LPCR_VRMA_LP0	(1ul << (63-15))
 #define   LPCR_VRMA_LP1	(1ul << (63-16))
+#define   LPCR_VRMASD_SH (63-16)
 #define   LPCR_RMLS    0x1C000000      /* impl dependent rmo limit sel */
 #define   LPCR_ILE     0x02000000      /* !HV irqs set MSR:LE */
 #define   LPCR_PECE	0x00007000	/* powersave exit cause enable */
@@ -242,8 +244,10 @@
 #define     LPCR_PECE1	0x00002000	/* decrementer can cause exit */
 #define     LPCR_PECE2	0x00001000	/* machine check etc can cause exit */
 #define   LPCR_MER	0x00000800	/* Mediated External Exception */
+#define   LPCR_LPES    0x0000000c
 #define   LPCR_LPES0   0x00000008      /* LPAR Env selector 0 */
 #define   LPCR_LPES1   0x00000004      /* LPAR Env selector 1 */
+#define   LPCR_LPES_SH	2
 #define   LPCR_RMI     0x00000002      /* real mode is cache inhibit */
 #define   LPCR_HDICE   0x00000001      /* Hyp Decr enable (HV,PR,EE) */
 #define SPRN_LPID	0x13F	/* Logical Partition Identifier */
diff --git a/arch/powerpc/kernel/cpu_setup_power7.S b/arch/powerpc/kernel/cpu_setup_power7.S
index 4f9a93f..2ef6749 100644
--- a/arch/powerpc/kernel/cpu_setup_power7.S
+++ b/arch/powerpc/kernel/cpu_setup_power7.S
@@ -61,19 +61,23 @@ __init_LPCR:
 	 *   LPES = 0b01 (HSRR0/1 used for 0x500)
 	 *   PECE = 0b111
 	 *   DPFD = 4
+	 *   HDICE = 0
+	 *   VC = 0b100 (VPM0=1, VPM1=0, ISL=0)
+	 *   VRMASD = 0b10000 (L=1, LP=00)
 	 *
 	 * Other bits untouched for now
 	 */
 	mfspr	r3,SPRN_LPCR
-	ori	r3,r3,(LPCR_LPES0|LPCR_LPES1)
-	xori	r3,r3, LPCR_LPES0
+	li	r5,1
+	rldimi	r3,r5, LPCR_LPES_SH, 64-LPCR_LPES_SH-2
 	ori	r3,r3,(LPCR_PECE0|LPCR_PECE1|LPCR_PECE2)
-	li	r5,7
-	sldi	r5,r5,LPCR_DPFD_SH
-	andc	r3,r3,r5
 	li	r5,4
-	sldi	r5,r5,LPCR_DPFD_SH
-	or	r3,r3,r5
+	rldimi	r3,r5, LPCR_DPFD_SH, 64-LPCR_DPFD_SH-3
+	clrrdi	r3,r3,1		/* clear HDICE */
+	li	r5,4
+	rldimi	r3,r5, LPCR_VC_SH, 0
+	li	r5,0x10
+	rldimi	r3,r5, LPCR_VRMASD_SH, 64-LPCR_VRMASD_SH-5
 	mtspr	SPRN_LPCR,r3
 	isync
 	blr
-- 
1.7.4.4
