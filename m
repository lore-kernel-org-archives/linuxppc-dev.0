Return-Path: <linuxppc-dev+bounces-25472-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226C2C55838
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:11:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFwP25Zfgz308Y;
	Thu, 06 Aug 2026 15:11:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785993094;
	cv=none; b=OyqXvNs4YRfnkNAX1WuLDloxgORtQU6iS8oh/m/IM0QkEpTVlH+8iAxqEFEogbV8HNu0nX1PCWCUjVDGAhlIyowfFw4oZyV0RYdiYD/o6GdztCDpsNz9y03QB5uuMOXjlB6zjt7YD4Jrw+GAHr3HL1PYmczrw82tf6IFeUtKBnxzljQq+3EHT5pvRn2e9m8T8FtGjmkyfJY0x28tUIW4bvomtKyjMXyq2CKISc0/nCV3zbkmVmbeIv93jhVEHQpVy0w1PXpWIZYfeig+PY7j6n03e8FlErd1LvcKYO80vPd2taf8zkiIt5TMk3FRLsukCthSUoW04UlByd3FdkJ79g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785993094; c=relaxed/relaxed;
	bh=NRlQAGUrrVdurl5Ud73PHabFaetpx5eiJ8tVv/ONQjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqZ74VEC/2BtteBDqRKCfObBb0OpAS8HhxghcUw6O421o+y3XEoDDWHloIm/aiMhwJ+obbqSx1Cq4XYttsR3h18OnbunKRGaN66WcMjMTe7JjI2Bg9bwI7LRd6I4cf7cG7XILHe8eXUrcJXclk7WZPGk5veHybJxuDq88GQMnnLFk4//eTGz/a/zASmJzJRfcUbu3HzOLkM2ZHheFSCiNbJicbdwwyMyq6IDUIha1z3i6ueaJcSnUHZMFfe/wYSzzW0S9MSMqGteqqwJb+xpVp1MngZkzfVuhMX81kfH/oP9ivtWeQJHW5ZrzFVsr8zoKdTb7kFFq3Xp/ALC9s7ANA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S80oe2Fl; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S80oe2Fl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFwP13x2Wz30DK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 15:11:33 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NlqkU1092931
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2026 05:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NRlQAGUrrVdurl5Ud
	73PHabFaetpx5eiJ8tVv/ONQjc=; b=S80oe2FlT6KGkumA4BTBXed6oU1HuRO5V
	CF7Oz9isSr/SN6s+J311P7gyj4CJ4VE6gesqwQVLvcDvX17KyaR2JBIUtVmzI9gs
	pGHQF0FX0QuELRoBkjdU+6toEoI25wxRqhNaJ5gyrk150z+IGsB3GTfGhJnE80TG
	3h2rxn0kNNAaIbNBLHjdXfmTXCGDdm7Pek6riflBjvUWcIecCxOk9ysE7GgShnkH
	WfwwGQjvXSBl3qDKURmKN/5d4o7yVzyiDxUQMq4n+jyB7neG42ChfHJK12nyKnjK
	0Ale/fYMjeR6MIibw7D58wSwWrmJDyOZZEFOjVpiXiH6332mFxSQQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h56fvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 05:11:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6765BHKO003055;
	Thu, 6 Aug 2026 05:11:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhhp0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 05:11:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6765BPOq35520926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 05:11:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6E732004D;
	Thu,  6 Aug 2026 05:11:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4951720040;
	Thu,  6 Aug 2026 05:11:24 +0000 (GMT)
Received: from jupiter.j9d-in.ibm.com (unknown [9.123.91.90])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 05:11:24 +0000 (GMT)
From: Mahesh Salgaonkar <mahesh@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Praveen K Pandey <praveen@linux.ibm.com>,
        Nikhil Kumar Singh <nikhilks@linux.ibm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PATCH v4 2/4] powerpc: Add Power12 raw mode
Date: Thu,  6 Aug 2026 10:41:18 +0530
Message-ID: <20260806051120.3703698-3-mahesh@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806051120.3703698-1-mahesh@linux.ibm.com>
References: <20260806051120.3703698-1-mahesh@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMyBTYWx0ZWRfXxj78KYjSz9aq
 ZmqTHPcZNUXsuPhcSDnrGq2USM2Wmz4F617m+H5Gs+CXWvZm903SDJA+kgfvXCkRyPBw2X4oq/o
 KHW2IKw7N3Grfdp6yNKZnQovJGLAnUY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMyBTYWx0ZWRfX6RR1Uizu/iYm
 UMFK9uJircctP6CpDZlae3QF6GbtIaVd5G9Lz+2jIU+mWhE4IARxm+ZRS9jHqIh/5p5UV2aPgFo
 ORiBB7UH2st+/5WAnfqSOMxMrwpwzP1ghjOgYLOXkdslUO6iT1gA8NOG7A4fa+98eTtgtTmQNQb
 hSbvnP44Wp7FrWlruvsBbZkvLufTaX6aQxtdHsfiCHUR7T91M1GxwAC8omg+FjTjNqgKAGtpHx6
 ALk1y3vh69bR491ZiXg1x/TSoCf9t5n4023MPKV+bv6Ln+QoAvlGRyb2AY727ldT0udfUkeUicF
 kNnQmlBjGeG0f1nD//vn1kZUObMp7A/Py9RqF8NBwHxBORE1yi+BpkoB9ztoA7lnF2aMwHWFYwn
 nmjJX3ZxAMgSoxpr6RNaloBOrjJDq8yeWBm0oNc69tt8xsNx3X25UKT+QnqwMhRvTqEcoRKdaO1
 PfRsw4WrOqv3qVD3iPg==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a741783 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=M-W3f8DC5bqc30M1Q3YA:9
X-Proofpoint-ORIG-GUID: iU2XdRYgB08JQm_X_BTT4etra2IgCCZX
X-Proofpoint-GUID: qLkLuLiVL4mMHeMkNIZ3xrlhQCC02Ifw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060033

From: Nicholas Piggin <npiggin@gmail.com>

Add CPU table entries for raw mode.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Tested-by: Praveen K Pandey <praveen@linux.ibm.com>
Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Change in v2:
- Added Reviewed-by from Nikhil
---
 arch/powerpc/include/asm/cpu_setup.h      |  2 ++
 arch/powerpc/include/asm/cputable.h       | 17 +++++++--
 arch/powerpc/include/asm/mmu.h            |  1 +
 arch/powerpc/include/asm/reg.h            |  5 ++-
 arch/powerpc/include/asm/synch.h          |  6 +++-
 arch/powerpc/include/uapi/asm/cputable.h  |  1 +
 arch/powerpc/kernel/cpu_setup_power.c     | 43 +++++++++++++++++++++++
 arch/powerpc/kernel/cpu_specs_book3s_64.h | 22 ++++++++++++
 arch/powerpc/kernel/dt_cpu_ftrs.c         | 37 +++++++++++++++++++
 arch/powerpc/kernel/setup-common.c        |  1 +
 arch/powerpc/kvm/book3s_hv.c              |  9 +++--
 arch/powerpc/mm/book3s64/hash_native.c    | 22 ++++++++----
 arch/powerpc/mm/init_64.c                 |  4 ++-
 13 files changed, 157 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/cpu_setup.h b/arch/powerpc/include/asm/cpu_setup.h
index 30e2fe389502..26d2c0e2c99c 100644
--- a/arch/powerpc/include/asm/cpu_setup.h
+++ b/arch/powerpc/include/asm/cpu_setup.h
@@ -9,10 +9,12 @@ void __setup_cpu_power7(unsigned long offset, struct cpu_spec *spec);
 void __setup_cpu_power8(unsigned long offset, struct cpu_spec *spec);
 void __setup_cpu_power9(unsigned long offset, struct cpu_spec *spec);
 void __setup_cpu_power10(unsigned long offset, struct cpu_spec *spec);
+void __setup_cpu_power12(unsigned long offset, struct cpu_spec *spec);
 void __restore_cpu_power7(void);
 void __restore_cpu_power8(void);
 void __restore_cpu_power9(void);
 void __restore_cpu_power10(void);
+void __restore_cpu_power12(void);
 
 void __setup_cpu_e500v1(unsigned long offset, struct cpu_spec *spec);
 void __setup_cpu_e500v2(unsigned long offset, struct cpu_spec *spec);
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index ec16c12296da..a3be81c47df3 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -194,6 +194,7 @@ static inline void cpu_feature_keys_init(void) { }
 #define CPU_FTR_DAWR1			LONG_ASM_CONST(0x0008000000000000)
 #define CPU_FTR_DEXCR_NPHIE		LONG_ASM_CONST(0x0010000000000000)
 #define CPU_FTR_P11_PVR			LONG_ASM_CONST(0x0020000000000000)
+#define CPU_FTR_ARCH_32			LONG_ASM_CONST(0x0040000000000000)
 
 #ifndef __ASSEMBLER__
 
@@ -457,6 +458,18 @@ static inline void cpu_feature_keys_init(void) { }
 
 #define CPU_FTRS_POWER11	(CPU_FTRS_POWER10 | CPU_FTR_P11_PVR)
 
+#define CPU_FTRS_POWER12 (CPU_FTR_LWSYNC | \
+	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_206 |\
+	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
+	    CPU_FTR_COHERENT_ICACHE | \
+	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
+	    CPU_FTR_DSCR | \
+	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
+	    CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
+	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_ARCH_207S | \
+	    CPU_FTR_ARCH_300 | CPU_FTR_ARCH_31 | CPU_FTR_ARCH_32 | \
+	    CPU_FTR_DAWR | CPU_FTR_DAWR1)
+
 #define CPU_FTRS_CELL	(CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
@@ -476,7 +489,7 @@ static inline void cpu_feature_keys_init(void) { }
 	    (CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | CPU_FTRS_POWER8 | \
 	     CPU_FTR_ALTIVEC_COMP | CPU_FTR_VSX_COMP | CPU_FTRS_POWER9 | \
 	     CPU_FTRS_POWER9_DD2_1 | CPU_FTRS_POWER9_DD2_2 | \
-	     CPU_FTRS_POWER9_DD2_3 | CPU_FTRS_POWER10 | CPU_FTRS_POWER11)
+	     CPU_FTRS_POWER9_DD2_3 | CPU_FTRS_POWER10 | CPU_FTRS_POWER11 | CPU_FTRS_POWER12)
 #else
 #define CPU_FTRS_POSSIBLE	\
 	    (CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | \
@@ -484,7 +497,7 @@ static inline void cpu_feature_keys_init(void) { }
 	     CPU_FTRS_POWER8 | CPU_FTRS_CELL | CPU_FTRS_PA6T | \
 	     CPU_FTR_VSX_COMP | CPU_FTR_ALTIVEC_COMP | CPU_FTRS_POWER9 | \
 	     CPU_FTRS_POWER9_DD2_1 | CPU_FTRS_POWER9_DD2_2 | \
-	     CPU_FTRS_POWER9_DD2_3 | CPU_FTRS_POWER10 | CPU_FTRS_POWER11)
+	     CPU_FTRS_POWER9_DD2_3 | CPU_FTRS_POWER10 | CPU_FTRS_POWER11 | CPU_FTRS_POWER12)
 #endif /* CONFIG_CPU_LITTLE_ENDIAN */
 #endif
 #else
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 5f9c5d436e17..4fd7f81a2930 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -133,6 +133,7 @@
 #define MMU_FTRS_POWER9		MMU_FTRS_POWER6
 #define MMU_FTRS_POWER10	MMU_FTRS_POWER6
 #define MMU_FTRS_POWER11	MMU_FTRS_POWER6
+#define MMU_FTRS_POWER12	MMU_FTRS_POWER6
 #define MMU_FTRS_CELL		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | \
 				MMU_FTR_CI_LARGE_PAGE
 #define MMU_FTRS_PA6T		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | \
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index b9ab9df1e2bc..541a493e13bf 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -492,11 +492,12 @@
  * determine both the compatibility level which we want to emulate and the
  * compatibility level which the host is capable of emulating.
  */
+#define   PCR_ARCH_31   0x20		/* Architecture 3.1 */
 #define   PCR_ARCH_300	0x10		/* Architecture 3.00 */
 #define   PCR_ARCH_207	0x8		/* Architecture 2.07 */
 #define   PCR_ARCH_206	0x4		/* Architecture 2.06 */
 #define   PCR_ARCH_205	0x2		/* Architecture 2.05 */
-#define   PCR_LOW_BITS	(PCR_ARCH_207 | PCR_ARCH_206 | PCR_ARCH_205 | PCR_ARCH_300)
+#define   PCR_LOW_BITS	(PCR_ARCH_207 | PCR_ARCH_206 | PCR_ARCH_205 | PCR_ARCH_300 | PCR_ARCH_31)
 #define   PCR_MASK	~(PCR_HIGH_BITS | PCR_LOW_BITS)	/* PCR Reserved Bits */
 #define	SPRN_HEIR	0x153	/* Hypervisor Emulated Instruction Register */
 #define SPRN_TLBINDEXR	0x154	/* P7 TLB control register */
@@ -1344,6 +1345,7 @@
 #define PVR_POWER9	0x004E
 #define PVR_POWER10	0x0080
 #define PVR_POWER11	0x0082
+#define PVR_POWER12	0x0083
 #define PVR_BE		0x0070
 #define PVR_PA6T	0x0090
 
@@ -1356,6 +1358,7 @@
 #define PVR_ARCH_300	0x0f000005
 #define PVR_ARCH_31	0x0f000006
 #define PVR_ARCH_31_P11	0x0f000007
+#define PVR_ARCH_32	0x0f000008
 
 /*
  * Kernel-internal sentinel for invalid processor compatibility modes.
diff --git a/arch/powerpc/include/asm/synch.h b/arch/powerpc/include/asm/synch.h
index 0d3ccb34adfb..d0e9765dee28 100644
--- a/arch/powerpc/include/asm/synch.h
+++ b/arch/powerpc/include/asm/synch.h
@@ -37,8 +37,12 @@ static inline void ppc_after_tlbiel_barrier(void)
 	 * accelerators mapped will use tlbie (which does invalidate the copy)
 	 * to invalidate translations. It's not possible to limit POWER10 this
 	 * way due to local copy-paste.
+	 *
+	 * POWER12 does not need it.
 	 */
-	asm volatile(ASM_FTR_IFSET(PPC_CP_ABORT, "", %0) : : "i" (CPU_FTR_ARCH_31) : "memory");
+	asm volatile(ASM_FTR_IF(PPC_CP_ABORT, "", %0, %1) :
+		: "i" (CPU_FTR_ARCH_31|CPU_FTR_ARCH_32), "i" (CPU_FTR_ARCH_31)
+		: "memory");
 }
 #endif /* __ASSEMBLER__ */
 
diff --git a/arch/powerpc/include/uapi/asm/cputable.h b/arch/powerpc/include/uapi/asm/cputable.h
index 731b97dc2d15..bc9bd225f587 100644
--- a/arch/powerpc/include/uapi/asm/cputable.h
+++ b/arch/powerpc/include/uapi/asm/cputable.h
@@ -52,6 +52,7 @@
 #define PPC_FEATURE2_HTM_NO_SUSPEND	0x00080000 /* TM w/out suspended state */
 #define PPC_FEATURE2_ARCH_3_1		0x00040000 /* ISA 3.1 */
 #define PPC_FEATURE2_MMA		0x00020000 /* Matrix Multiply Assist */
+#define PPC_FEATURE2_ARCH_3_2		0x00010000 /* ISA 3.2 */
 
 /*
  * IMPORTANT!
diff --git a/arch/powerpc/kernel/cpu_setup_power.c b/arch/powerpc/kernel/cpu_setup_power.c
index 98bd4e6c1770..5de704ac031d 100644
--- a/arch/powerpc/kernel/cpu_setup_power.c
+++ b/arch/powerpc/kernel/cpu_setup_power.c
@@ -286,3 +286,46 @@ void __restore_cpu_power10(void)
 	init_HFSCR();
 	init_PMU_HV();
 }
+
+void __setup_cpu_power12(unsigned long offset, struct cpu_spec *t)
+{
+	init_FSCR_power10();
+	init_PMU();
+	init_PMU_ISA31();
+
+	if (!init_hvmode_206(t))
+		return;
+
+	mtspr(SPRN_PSSCR, 0);
+	mtspr(SPRN_LPID, 0);
+	mtspr(SPRN_PID, 0);
+	mtspr(SPRN_AMOR, ~0);
+	mtspr(SPRN_PCR, PCR_MASK);
+	init_LPCR_ISA300((mfspr(SPRN_LPCR) | LPCR_PECEDH | LPCR_PECE_HVEE |\
+			 LPCR_HVICE | LPCR_HEIC) & ~(LPCR_UPRT | LPCR_HR), 0);
+	init_HFSCR();
+	init_PMU_HV();
+}
+
+void __restore_cpu_power12(void)
+{
+	u64 msr;
+
+	init_FSCR_power10();
+	init_PMU();
+	init_PMU_ISA31();
+
+	msr = mfmsr();
+	if (!(msr & MSR_HV))
+		return;
+
+	mtspr(SPRN_PSSCR, 0);
+	mtspr(SPRN_LPID, 0);
+	mtspr(SPRN_PID, 0);
+	mtspr(SPRN_AMOR, ~0);
+	mtspr(SPRN_PCR, PCR_MASK);
+	init_LPCR_ISA300((mfspr(SPRN_LPCR) | LPCR_PECEDH | LPCR_PECE_HVEE |\
+			 LPCR_HVICE | LPCR_HEIC) & ~(LPCR_UPRT | LPCR_HR), 0);
+	init_HFSCR();
+	init_PMU_HV();
+}
diff --git a/arch/powerpc/kernel/cpu_specs_book3s_64.h b/arch/powerpc/kernel/cpu_specs_book3s_64.h
index 98d4274a1b6b..7619dd157646 100644
--- a/arch/powerpc/kernel/cpu_specs_book3s_64.h
+++ b/arch/powerpc/kernel/cpu_specs_book3s_64.h
@@ -63,6 +63,11 @@
 #define COMMON_USER_POWER11	COMMON_USER_POWER10
 #define COMMON_USER2_POWER11	COMMON_USER2_POWER10
 
+#define COMMON_USER_POWER12	COMMON_USER_POWER10
+#define COMMON_USER2_POWER12	(COMMON_USER2_POWER10 | \
+				 PPC_FEATURE2_ARCH_3_2)
+
+
 static struct cpu_spec cpu_specs[] __initdata = {
 	{	/* PPC970 */
 		.pvr_mask		= 0xffff0000,
@@ -485,6 +490,23 @@ static struct cpu_spec cpu_specs[] __initdata = {
 		.machine_check_early	= __machine_check_early_realmode_p10,
 		.platform		= "power11",
 	},
+	{	/* Power12 */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x00830000,
+		.cpu_name		= "Power12 (raw)",
+		.cpu_features		= CPU_FTRS_POWER12,
+		.cpu_user_features	= COMMON_USER_POWER12,
+		.cpu_user_features2	= COMMON_USER2_POWER12,
+		.mmu_features		= MMU_FTRS_POWER12,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_IBM,
+		.cpu_setup		= __setup_cpu_power12,
+		.cpu_restore		= __restore_cpu_power12,
+		.machine_check_early	= __machine_check_early_realmode_p10,
+		.platform		= "power12",
+	},
 	{	/* Cell Broadband Engine */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x00700000,
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 1b15e47e5340..a87b22f555b2 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -26,6 +26,7 @@
 /* Device-tree visible constants follow */
 #define ISA_V3_0B       3000
 #define ISA_V3_1        3100
+#define ISA_V3_2        3200
 
 #define USABLE_PR               (1U << 0)
 #define USABLE_OS               (1U << 1)
@@ -464,6 +465,35 @@ static int __init feat_enable_mce_power11(struct dt_cpu_feature *f)
 	return 1;
 }
 
+static void init_pmu_power12(void)
+{
+	init_pmu_power10();
+}
+
+static int __init feat_enable_pmu_power12(struct dt_cpu_feature *f)
+{
+	hfscr_pmu_enable();
+
+	init_pmu_power12();
+	init_pmu_registers = init_pmu_power12;
+
+	cur_cpu_spec->cpu_features |= CPU_FTR_MMCRA;
+	cur_cpu_spec->cpu_user_features |= PPC_FEATURE_PSERIES_PERFMON_COMPAT;
+
+	cur_cpu_spec->num_pmcs          = 6;
+	cur_cpu_spec->pmc_type          = PPC_PMC_IBM;
+
+	return 1;
+}
+
+static int __init feat_enable_mce_power12(struct dt_cpu_feature *f)
+{
+	cur_cpu_spec->platform = "power12";
+	cur_cpu_spec->machine_check_early = __machine_check_early_realmode_p10;
+
+	return 1;
+}
+
 static int __init feat_enable_tm(struct dt_cpu_feature *f)
 {
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
@@ -655,9 +685,11 @@ static struct dt_cpu_feature_match __initdata
 	{"machine-check-power9", feat_enable_mce_power9, 0},
 	{"machine-check-power10", feat_enable_mce_power10, 0},
 	{"machine-check-power11", feat_enable_mce_power11, 0},
+	{"machine-check-power12", feat_enable_mce_power12, 0},
 	{"performance-monitor-power9", feat_enable_pmu_power9, 0},
 	{"performance-monitor-power10", feat_enable_pmu_power10, 0},
 	{"performance-monitor-power11", feat_enable_pmu_power10, 0},
+	{"performance-monitor-power12", feat_enable_pmu_power12, 0},
 	{"event-based-branch-v3", feat_enable, 0},
 	{"random-number-generator", feat_enable, 0},
 	{"system-call-vectored", feat_disable, 0},
@@ -712,6 +744,11 @@ static void __init cpufeatures_setup_start(u32 isa)
 		if (PVR_VER(mfspr(SPRN_PVR)) >= PVR_POWER11)
 			cur_cpu_spec->cpu_features |= CPU_FTR_P11_PVR;
 	}
+
+	if (isa >= ISA_V3_2) {
+		cur_cpu_spec->cpu_features |= CPU_FTR_ARCH_32;
+		cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_ARCH_3_2;
+	}
 }
 
 static bool __init cpufeatures_process_feature(struct dt_cpu_feature *f)
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 67c545f61f0d..4afaba19b586 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -304,6 +304,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 				break;
 			case 0x004e: /* POWER9 bits 12-15 give chip type */
 			case 0x0080: /* POWER10 bit 12 gives SMT8/4 */
+			case 0x0083: /* POWER12 bit 12 gives SMT8/4 */
 				maj = (pvr >> 8) & 0x0F;
 				min = pvr & 0xFF;
 				break;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 15b422861894..1b5f5ebea4a3 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -388,7 +388,7 @@ static void kvmppc_set_pvr_hv(struct kvm_vcpu *vcpu, u32 pvr)
 }
 
 /* Dummy value used in computing PCR value below */
-#define PCR_ARCH_31    (PCR_ARCH_300 << 1)
+#define PCR_ARCH_32	(PCR_ARCH_31 << 1)
 
 static inline unsigned long map_pcr_to_cap(unsigned long pcr)
 {
@@ -417,7 +417,9 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
 	struct kvmppc_vcore *vc = vcpu->arch.vcore;
 
 	/* We can (emulate) our own architecture version and anything older */
-	if (cpu_has_feature(CPU_FTR_P11_PVR) || cpu_has_feature(CPU_FTR_ARCH_31))
+	if (cpu_has_feature(CPU_FTR_ARCH_32))
+		host_pcr_bit = PCR_ARCH_32;
+	else if (cpu_has_feature(CPU_FTR_P11_PVR) || cpu_has_feature(CPU_FTR_ARCH_31))
 		host_pcr_bit = PCR_ARCH_31;
 	else if (cpu_has_feature(CPU_FTR_ARCH_300))
 		host_pcr_bit = PCR_ARCH_300;
@@ -461,6 +463,9 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
 			}
 			guest_pcr_bit = PCR_ARCH_31;
 			break;
+		case PVR_ARCH_32:
+			guest_pcr_bit = PCR_ARCH_32;
+			break;
 		default:
 			return -EINVAL;
 		}
diff --git a/arch/powerpc/mm/book3s64/hash_native.c b/arch/powerpc/mm/book3s64/hash_native.c
index e9e2dd70c060..ab2a80e59011 100644
--- a/arch/powerpc/mm/book3s64/hash_native.c
+++ b/arch/powerpc/mm/book3s64/hash_native.c
@@ -184,9 +184,14 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
 		va |= ssize << 8;
 		sllp = get_sllp_encoding(apsize);
 		va |= sllp << 5;
-		asm volatile(ASM_FTR_IFSET("tlbiel %0", PPC_TLBIEL_v205(%0, 0), %1)
-			     : : "r" (va), "i" (CPU_FTR_ARCH_206)
-			     : "memory");
+
+		if (cpu_has_feature(CPU_FTR_ARCH_32)) {
+			asm volatile(PPC_TLBIEL(%0, %1, 0, 0, 0) : : "r"(va), "r"(0) : "memory");
+		} else {
+			asm volatile(ASM_FTR_IFSET("tlbiel %0", PPC_TLBIEL_v205(%0, 0), %1)
+				     : : "r" (va), "i" (CPU_FTR_ARCH_206)
+				     : "memory");
+		}
 		break;
 	default:
 		/* We need 14 to 14 + i bits of va */
@@ -203,9 +208,14 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
 		 */
 		va |= (vpn & 0xfe);
 		va |= 1; /* L */
-		asm volatile(ASM_FTR_IFSET("tlbiel %0", PPC_TLBIEL_v205(%0, 1), %1)
-			     : : "r" (va), "i" (CPU_FTR_ARCH_206)
-			     : "memory");
+
+		if (cpu_has_feature(CPU_FTR_ARCH_32)) {
+			asm volatile(PPC_TLBIEL(%0, %1, 0, 0, 0) : : "r"(va), "r"(0) : "memory");
+		} else {
+			asm volatile(ASM_FTR_IFSET("tlbiel %0", PPC_TLBIEL_v205(%0, 1), %1)
+				     : : "r" (va), "i" (CPU_FTR_ARCH_206)
+				     : "memory");
+		}
 		break;
 	}
 	trace_tlbie(0, 1, va, 0, 0, 0, 0);
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 64f0df5bb5cd..0e777d7dc332 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -628,7 +628,9 @@ void __init mmu_early_init_devtree(void)
 
 	of_scan_flat_dt(dt_scan_mmu_pid_width, NULL);
 	if (hvmode && !mmu_lpid_bits) {
-		if (early_cpu_has_feature(CPU_FTR_ARCH_207S))
+		if (early_cpu_has_feature(CPU_FTR_ARCH_32))
+			mmu_lpid_bits = 16; /* POWER12 */
+		else if (early_cpu_has_feature(CPU_FTR_ARCH_207S))
 			mmu_lpid_bits = 12; /* POWER8-10 */
 		else
 			mmu_lpid_bits = 10; /* POWER7 */
-- 
2.55.0


