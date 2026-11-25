Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2105606A323
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f8ThLU83
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZRp553Htz2xL5;
	Thu, 26 Nov 2026 04:42:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795628541;
	cv=none; b=QBEGPqNdEWY+Jsw9RxXrUI5svnWarLvkmNbxal6dt8rM1+BIk06qOw60X/3ApMK4bW6BGeTbCvIlqwlmcWKz63eAHepKpcpsQFOByHWVRXSOjupPvaCk0hDujkxdK72ty96+NgLznND0qAv4s/DfAog9eVfPJZE2RAmOdkAf5I+/LuzankbZ2Vxqo6seH1i4WOxECETWJXfGWLRswAhKJxpaOxVyuCl7ymLTBnDwKESI4P3K9pzLLzmL7Q7LFwse1flMz6FlRL9mfLxWMCuCDnlNg4DcXNquhiyFX7tI9swXFMBwxBGKPl3DPVJKCbOGSol+dNSQYrRk3YhVkeAoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795628541; c=relaxed/relaxed;
	bh=Elwf8mMgQfGgUx/ytVRRqkcbjeXEVW2sU9FtIKJO4F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ftdj61/UrBF/m60lBu9DtKSbJsJpNtJ9MHeVvKjSl32ivSchS/nb6liQLc3CPNjjBQ+w158BVZjkEM1AsvqBEjO/c6+isfen8RkWxuSwbWGiMqN+hzhwY+HoIUhsHsZLgnsEfBu6F/pBA7FJwNlnS/+laZzWsKy2XsYBq6NkBZwFekgh5ToR++G0P9eb7/DXHxByPhPm//moAafdWBIwM0FcOiT3vtH8RXc9VBBRihRu9b/pqMu7JU0j/5M+EbymdWF6EZwND3FueTezDjhbKQFoXGTNDFPTjTsT4Wj+qGTnfWhNi/c8J1zDjEWwHCgGxeiZboSzSva3a7EOTH+jQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f8ThLU83; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nysal@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f8ThLU83;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nysal@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZRp502Skz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 04:42:20 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APGYdE11999322;
	Wed, 25 Nov 2026 17:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Elwf8mMgQfGgUx/yt
	VRRqkcbjeXEVW2sU9FtIKJO4F8=; b=f8ThLU835bj6s9c8Otwmzt88Bf6kL8Wtr
	delWW9chBgkKe306Y0wb9DaZ64CVI/izqtPteYR0p7urag4a1O9o3TChVbB7FENk
	ex4mvNMWJZEEXSgA0QdXTJ4tI14l/dR/o/7DB7fa6CC+LcqFbToJ650ZFTOEoJ76
	l96mL+13Gy2+6aRKIv/9zAgD8Ytprqwu7mmPURQgraxN87+pOryJG83nxUd6lZH5
	Fo8DTkYVQIDEPa8Ffx8TvEGNCK0DhwA7kkHtl0Kz7r66yffDrgrQLILAKhTXb6RL
	GlrVqbOmEE5SIJEuvECP5yWfZcV+QtSFZGuZ/sQj1G4e6VRs+Lk4w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fads9b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 17:41:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6APGYJwB313803;
	Wed, 25 Nov 2026 17:41:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxx1mdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 17:41:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6APHfjCn11075920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 17:41:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 640C32004B;
	Wed, 25 Nov 2026 17:41:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97B792004D;
	Wed, 25 Nov 2026 17:41:40 +0000 (GMT)
Received: from li-398ad3cc-28e7-11b2-a85c-e030a5b10d54.ibm.com.com (unknown [9.43.127.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Nov 2026 17:41:40 +0000 (GMT)
From: "Nysal Jan K.A." <nysal@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Jeevitha Palanisamy <jeevitha@linux.ibm.com>,
        "Nysal Jan K.A." <nysal@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David Hildenbrand (Arm)" <david@kernel.org>,
        Yeoreum Yun <yeoreum.yun@arm.com>, SJ Park <sj@kernel.org>,
        "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Usama Arif <usama.arif@linux.dev>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH 2/3] powerpc: Implement 128-bit cmpxchg fallback
Date: Wed, 25 Nov 2026 23:10:23 +0530
Message-ID: <20261125174035.1412724-3-nysal@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125174035.1412724-1-nysal@linux.ibm.com>
References: <20261125174035.1412724-1-nysal@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA3MCBTYWx0ZWRfX+HAlnviqcG4R
 yVU0kFCrEjq1sUTUUPUbymokbo2AXPdClW9KWK6HmdEBII+DF7EnTuNsgbZGOu5/q4zo53U7HD9
 wfyuY5SzqCt/VtGUjQ2dKKVBxeA4ZnH9Nr97dlleVSGcKKp1jvng8cuZXsb57Mz+mUXDAorPbqP
 ZaNAYnHNkC25nw8eNYu1w26zm3/+eOCPC/HC2sekkn8GcufQcBc6flq0p9CZhMeeTm7ajmTpg2E
 VawtWJLUOUYO3G+KNyEo39Qsc+0HMMY5o1jTzKWa1Je6FRfR5XnUn4JrjQS6f062XuuhV61JDrh
 Au4JaP2m7Kr8dCCvUZvhCTvRZpSHQ+W7a/ihj3JuGw2LDuOlnOgd7wf03KnxZO9CWNNZdGryJom
 uCcP7rRPgGNU2GZOqf0q0uA1UNi+JsKQdfn5TKR7kuG46t3zmGRxHMR18gLq6CTB/3ah8km8was
 Ln/C1DROvbi7Kc8Lq1w==
X-Proofpoint-ORIG-GUID: poPiA2crBjhBZe3b6QGcgbXe6zyQQoiH
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b071ddf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=a2Q7Us5yBMcgEmUiQH4A:9
X-Proofpoint-GUID: OcD6hxpdshANOGGw52ccJj3pbUKuyCQg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA3MCBTYWx0ZWRfX/IGNPDYZe4gY
 g4dn2qdXAAo2fTG2PuUHkd6ts2h9MHVkTYr9PAnZJ9W0FuMy62Ya3bwIl9KHXaFrYdxfZMucz83
 EW2GN9mr5jhfNGi7xQmswonktBCf8sM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250070
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Compilers that lack support for the PTI mode attribute (such as Clang
and older GCC versions) cannot dynamically allocate consecutive even/odd
register pairs for inline assembly operands. Implement a fallback path
for 128-bit cmpxchg using hard register constraints:
  - r14/r15: pair for lqarx target (old value read from memory)
  - r16/r17: pair for stqcx. source (new value to store)

With this fallback in place, remove the compiler dependency for
selecting HAVE_CMPXCHG_DOUBLE and HAVE_ALIGNED_STRUCT_PAGE on
supported CPUs.

Signed-off-by: Nysal Jan K.A. <nysal@linux.ibm.com>
---
 arch/powerpc/Kconfig               |  4 +--
 arch/powerpc/include/asm/cmpxchg.h | 42 +++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 79cda056dfc4..0b9071b16b21 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -217,7 +217,7 @@ config PPC
 	select GENERIC_PCI_IOMAP		if PCI
 	select GENERIC_SMP_IDLE_THREAD
 	select HAS_IOPORT			if PCI
-	select HAVE_ALIGNED_STRUCT_PAGE		if PPC_HAS_LQARX && CPU_LITTLE_ENDIAN && CC_HAS_PTI_MODE_VAR_ATTR
+	select HAVE_ALIGNED_STRUCT_PAGE		if PPC_HAS_LQARX && CPU_LITTLE_ENDIAN
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMALLOC		if HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_HUGE_VMAP		if PPC_RADIX_MMU || PPC_8xx
@@ -238,7 +238,7 @@ config PPC
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ASM_MODVERSIONS
-	select HAVE_CMPXCHG_DOUBLE		if PPC_HAS_LQARX && CPU_LITTLE_ENDIAN && CC_HAS_PTI_MODE_VAR_ATTR
+	select HAVE_CMPXCHG_DOUBLE		if PPC_HAS_LQARX && CPU_LITTLE_ENDIAN
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index b3164c3c0b81..efd7261a4a53 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -619,13 +619,20 @@ __cmpxchg_u64_acquire(u64 *p, unsigned long old, unsigned long new)
 #endif
 
 #ifdef CONFIG_HAVE_CMPXCHG_DOUBLE
+#ifdef CONFIG_CC_HAS_PTI_MODE_VAR_ATTR
+#define __PPC_PTI_MODE __mode(PTI)
+#else
+#define __PPC_PTI_MODE
+#endif
+
 union __u128_halves {
-	u128 full __mode(PTI);
+	u128 full __PPC_PTI_MODE;
 	struct {
 		u64 low, high;
 	};
 };
 
+#ifdef CONFIG_CC_HAS_PTI_MODE_VAR_ATTR
 #define __CMPXCHG128(name, entry_mb, exit_mb)			\
 static __always_inline u128					\
 __cmpxchg_u128##name(volatile u128 *p, u128 old, u128 new)	\
@@ -656,6 +663,39 @@ __cmpxchg_u128##name(volatile u128 *p, u128 old, u128 new)	\
 								\
 	return r.full;						\
 }
+#else
+#define __CMPXCHG128(name, entry_mb, exit_mb)			\
+static __always_inline u128					\
+__cmpxchg_u128##name(volatile u128 *p, u128 old, u128 new)	\
+{								\
+	union __u128_halves tmp, r, o = { .full = (old) },	\
+				    n = { .full = (new) };	\
+								\
+	__asm__ __volatile__ (					\
+	entry_mb						\
+"1:     lqarx   14,0,%[ptr]\n"					\
+"       xor     %[tl],15,%[ol]\n"				\
+"       xor     %[th],14,%[oh]\n"				\
+"       or.     %[th],%[th],%[tl]\n"				\
+"       bne-    2f\n"						\
+"       mr      17,%[nl]\n"					\
+"       mr      16,%[nh]\n"					\
+"       stqcx.  16,0,%[ptr]\n"					\
+"       bne-    1b\n"						\
+	exit_mb							\
+"2:     mr      %[rh],14\n"					\
+"       mr      %[rl],15\n"					\
+	: [rl] "=&r" (r.low), [rh] "=&r" (r.high),		\
+	  [tl] "=&r" (tmp.low), [th] "=&r" (tmp.high),		\
+	  "+m" (*p)						\
+	: [ptr] "r" (p),					\
+	  [ol] "r" (o.low), [oh] "r" (o.high),			\
+	  [nl] "r" (n.low), [nh] "r" (n.high)			\
+	: "r14", "r15", "r16", "r17", "cc", "memory");		\
+								\
+	return r.full;						\
+}
+#endif
 
 __CMPXCHG128(, PPC_ATOMIC_ENTRY_BARRIER, PPC_ATOMIC_EXIT_BARRIER)
 __CMPXCHG128(_local, ,)
-- 
2.52.0


