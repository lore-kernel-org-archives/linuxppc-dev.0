Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21BBD1A0281
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 09:51:28 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org
Subject: [PATCH 2/2] powerpc: Change vsrX register defines to vsX to match gcc
 and glibc
Date: Tue, 10 Feb 2015 09:51:23 +1100
Message-Id: <1423522283-29397-2-git-send-email-anton@samba.org>
In-Reply-To: <1423522283-29397-1-git-send-email-anton@samba.org>
References: <1423522283-29397-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As our various loops (copy, string, crypto etc) get more complicated,
we want to share implementations between userspace (eg glibc) and
the kernel. We also want to write userspace test harnesses to put
in tools/testing/selftest.

One gratuitous difference between userspace and the kernel is the
VSX register definitions - the kernel uses vsrX whereas gcc uses
vsX.

Change the kernel to match userspace.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/ppc_asm.h | 128 ++++++++++++++++++-------------------
 arch/powerpc/lib/ldstfp.S          |   6 +-
 2 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index c746103..dd0fc18 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -672,70 +672,70 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,945)
 
 /* VSX Registers (VSRs) */
 
-#define	vsr0	0
-#define	vsr1	1
-#define	vsr2	2
-#define	vsr3	3
-#define	vsr4	4
-#define	vsr5	5
-#define	vsr6	6
-#define	vsr7	7
-#define	vsr8	8
-#define	vsr9	9
-#define	vsr10	10
-#define	vsr11	11
-#define	vsr12	12
-#define	vsr13	13
-#define	vsr14	14
-#define	vsr15	15
-#define	vsr16	16
-#define	vsr17	17
-#define	vsr18	18
-#define	vsr19	19
-#define	vsr20	20
-#define	vsr21	21
-#define	vsr22	22
-#define	vsr23	23
-#define	vsr24	24
-#define	vsr25	25
-#define	vsr26	26
-#define	vsr27	27
-#define	vsr28	28
-#define	vsr29	29
-#define	vsr30	30
-#define	vsr31	31
-#define	vsr32	32
-#define	vsr33	33
-#define	vsr34	34
-#define	vsr35	35
-#define	vsr36	36
-#define	vsr37	37
-#define	vsr38	38
-#define	vsr39	39
-#define	vsr40	40
-#define	vsr41	41
-#define	vsr42	42
-#define	vsr43	43
-#define	vsr44	44
-#define	vsr45	45
-#define	vsr46	46
-#define	vsr47	47
-#define	vsr48	48
-#define	vsr49	49
-#define	vsr50	50
-#define	vsr51	51
-#define	vsr52	52
-#define	vsr53	53
-#define	vsr54	54
-#define	vsr55	55
-#define	vsr56	56
-#define	vsr57	57
-#define	vsr58	58
-#define	vsr59	59
-#define	vsr60	60
-#define	vsr61	61
-#define	vsr62	62
-#define	vsr63	63
+#define	vs0	0
+#define	vs1	1
+#define	vs2	2
+#define	vs3	3
+#define	vs4	4
+#define	vs5	5
+#define	vs6	6
+#define	vs7	7
+#define	vs8	8
+#define	vs9	9
+#define	vs10	10
+#define	vs11	11
+#define	vs12	12
+#define	vs13	13
+#define	vs14	14
+#define	vs15	15
+#define	vs16	16
+#define	vs17	17
+#define	vs18	18
+#define	vs19	19
+#define	vs20	20
+#define	vs21	21
+#define	vs22	22
+#define	vs23	23
+#define	vs24	24
+#define	vs25	25
+#define	vs26	26
+#define	vs27	27
+#define	vs28	28
+#define	vs29	29
+#define	vs30	30
+#define	vs31	31
+#define	vs32	32
+#define	vs33	33
+#define	vs34	34
+#define	vs35	35
+#define	vs36	36
+#define	vs37	37
+#define	vs38	38
+#define	vs39	39
+#define	vs40	40
+#define	vs41	41
+#define	vs42	42
+#define	vs43	43
+#define	vs44	44
+#define	vs45	45
+#define	vs46	46
+#define	vs47	47
+#define	vs48	48
+#define	vs49	49
+#define	vs50	50
+#define	vs51	51
+#define	vs52	52
+#define	vs53	53
+#define	vs54	54
+#define	vs55	55
+#define	vs56	56
+#define	vs57	57
+#define	vs58	58
+#define	vs59	59
+#define	vs60	60
+#define	vs61	61
+#define	vs62	62
+#define	vs63	63
 
 /* SPE Registers (EVPRs) */
 
diff --git a/arch/powerpc/lib/ldstfp.S b/arch/powerpc/lib/ldstfp.S
index 659c7ca..5d0cdbf 100644
--- a/arch/powerpc/lib/ldstfp.S
+++ b/arch/powerpc/lib/ldstfp.S
@@ -280,12 +280,12 @@ _GLOBAL(do_stvx)
 #endif /* CONFIG_ALTIVEC */
 
 #ifdef CONFIG_VSX
-/* Get the contents of vsrN into vsr0; N is in r3. */
+/* Get the contents of vsN into vs0; N is in r3. */
 _GLOBAL(get_vsr)
 	mflr	r0
 	rlwinm	r3,r3,3,0x1f8
 	bcl	20,31,1f
-	blr			/* vsr0 is already in vsr0 */
+	blr			/* vs0 is already in vs0 */
 	nop
 reg = 1
 	.rept	63
@@ -299,7 +299,7 @@ reg = reg + 1
 	mtlr	r0
 	bctr
 
-/* Put the contents of vsr0 into vsrN; N is in r3. */
+/* Put the contents of vs0 into vsN; N is in r3. */
 _GLOBAL(put_vsr)
 	mflr	r0
 	rlwinm	r3,r3,3,0x1f8
-- 
2.1.0
