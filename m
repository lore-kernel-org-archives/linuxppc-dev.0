Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55150606A331
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Np+aZ7Ng
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZRnk0WLXz2xL5;
	Thu, 26 Nov 2026 04:42:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795628522;
	cv=none; b=m1Aa896PIDpfP7lNivqJymm8B6BtaPB1xSTKBPWDhihgjNo9aalGSix3wIGtliHMBYiUlOVHeoHCGrB7C9Cno3pbYDuP1J1JsQht8fPD+WGg7rTpRmSi7p0Q4qJrTAlQcNNF/WuYybTq9tmdljLHsBiQS1vSjq6JTmKlChgrwQ9JDAaTd7Qkqy8QKP1FCeViTjkHHcNXRk01YPCN6HApogJW6VMTt73yq5igBSML5A+dyXKl54gF+dgnECgf9tO85RoqvtUsZbNt5hzi5sDDGUhYAqvf6/DqFH59h209kRTS3TFdHq3mMt4oBJBZVQyQNMT2cEAb+lRWqWU8oYBErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795628522; c=relaxed/relaxed;
	bh=9rMQxBziEh/dYfp+WtStPbgH6bEsj4gjtQkf78yl9KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JykmeKbOkrQRZxQNHlzkKgkWKO2gWju7y82mmte6Nzpvb2DxoKD4wTVjX5i5Fr0uqUdzbuF5NvGl1NUuIYgMMbfJvQr6xHdDoUtGcUrPDL6xpllkCMquHmcuTY+wHAoxGmJlMmujJKoWb9Io8veIOlzWM8uD15a0rJZ8LEA95oPCh5UZ/2+3MOyBC0ALxWOP1C/YCrOe6DSCOjnVnSCCE5W3jLcbtikjId007arRpkZKF5rhAURBkxCSTb1Iva2XcKhtN1xyaiQIsjoaVkk5iVeZYIn4N2nBu/jA+eFq0Lhl7aP3u4Li5I+jPrdgBPwnKET4PorYtcnQ2JL2l7HKsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Np+aZ7Ng; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nysal@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Np+aZ7Ng;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nysal@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZRnj08d9z2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 04:42:00 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APGYk411852766;
	Wed, 25 Nov 2026 17:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9rMQxBziEh/dYfp+W
	tStPbgH6bEsj4gjtQkf78yl9KM=; b=Np+aZ7NgdZjeMAQrfg7itKYFair6A08q2
	0ALRuHpQ4VvXBsOK8QNvi2mvb7UNSiUhTkQjgQLjmM2jtahxBlJUlWDrBhrbXQ2t
	2TdOuEH9prcvZ79myzzpLcvKzO83aeNBOZunH9tJNmndopYSE9nvrrkSes/mqLmZ
	rWZGvt7gaEda0LBRvKukvWk7J+S54IsUbc2lno5sQ8Tn6eSWuyE25wmywTzsLPOj
	hEg6CkJrvrFeq+nErDqEs/2xAsrDyLXZ5jDcZGtKOM+ksjdgatIq2ZJWtFlfNmkW
	8Cy+RIs/IEWKgZeCdaEdCzk7VUnfvbbDMYReoWhY/fc5l/9iB8Rrg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g1d7vq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 17:41:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6APGYJgr955083;
	Wed, 25 Nov 2026 17:41:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5axkvtw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 17:41:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6APHfSGw33817002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 17:41:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A3B520063;
	Wed, 25 Nov 2026 17:41:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BD302004B;
	Wed, 25 Nov 2026 17:41:23 +0000 (GMT)
Received: from li-398ad3cc-28e7-11b2-a85c-e030a5b10d54.ibm.com.com (unknown [9.43.127.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Nov 2026 17:41:23 +0000 (GMT)
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
        Ryan Roberts <ryan.roberts@arm.com>,
        Andreas Larsson <andreas@gaisler.com>,
        Usama Arif <usama.arif@linux.dev>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 1/3] powerpc: Add support for 128-bit cmpxchg
Date: Wed, 25 Nov 2026 23:10:22 +0530
Message-ID: <20261125174035.1412724-2-nysal@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: M77aQP4icH2U9ZVXF-isvv4LaYqbr3EX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA3MCBTYWx0ZWRfX7LCe7oaLpvig
 goEoOXzHGmNz95wwlpqpENdOVpSnDIgOZ1kZr5FrH0tWkawBvhkEGbxbsc0u3C0Pq6bmGfRjxvF
 sJUCQHzbeZ80Jtee5LQfZeRZt+28AWw=
X-Proofpoint-GUID: -xDHhEfGJAiiEoWcGEBEU8puYlcZBT8q
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b071dcd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8 a=mDV3o1hIAAAA:8 a=VnNF1IyMAAAA:8
 a=ZSv_wlDq-XBJSszeE34A:9 a=isR4AqL0EaFW8Alr:21
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA3MCBTYWx0ZWRfX4BkquK0Ijw8Q
 q8nS8TBq3HaNYSMMOTNSZEUFFS6WY8WZ/EnOoZg8my15xwY5qz9vJf99KQjwweltVOoVO1FJJWv
 Er+sbR7AaX/847XTdzHSuMJ7hqt8kvwy+i9++MSja5m1sKeSnMB9O1LCJf5JkFfpoKtSznA4h3X
 Pe5uacZ11Mi2ck8P5u1MVxeV0Y+eCxgy66rudxL8K02Hn6HyNRAG/z/xokPQdwHmln7Eerkvvzi
 nlTskPlQ1Udu6h8AATSCzeyuNyqIDL4inXaFJ/NI8+ZqhICXvcuV95q62mx4Bvr96JOyY4jAdMd
 0aOV7otggnoR/+QtaYWj0j9DBbNWPtwofa8IGOGr9XVGRY00Ujn/6RbM2Bfyc1zLXGELYUV0IVD
 ZSML4d4fMiXsgAcVgFSh1pp/WtC6XXxTyQa2IAsSeIaTnVWhYogYbX2mIjW6IVmcctH9HzZEizf
 JY+u6wJzd4fl42YQdAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250070
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement arch_cmpxchg128() and arch_cmpxchg128_local() for 64-bit
little-endian PowerPC (POWER8 and later) using the lqarx and stqcx.
instructions.

This enables HAVE_CMPXCHG_DOUBLE, which allows SLUB to use the lockless
__update_freelist_fast() path and provides kmalloc_nolock() required by
BPF task-local storage and arena allocations.
Select HAVE_ALIGNED_STRUCT_PAGE to ensure 16-byte alignment for struct
page as required by quadword load/store instructions.

The lqarx and stqcx. instructions require a consecutive even/odd
register pair, with the most significant 64 bits in the even register
and the least significant 64 bits in the odd register. Leverage GCC's
PTI mode variable attribute to allow the compiler to allocate suitable
register pairs. On little-endian, the halves are swapped to match the
memory layout.

Link: https://github.com/linuxppc/issues/issues/463
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106895
Signed-off-by: Nysal Jan K.A. <nysal@linux.ibm.com>
---
 arch/powerpc/Kconfig                   |  8 ++++
 arch/powerpc/include/asm/cmpxchg.h     | 60 ++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype |  3 ++
 3 files changed, 71 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c3b6cd655606..79cda056dfc4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -15,6 +15,9 @@ config CC_HAS_PCREL
 	# do pcrel yet.
 	def_bool PPC64 && CC_IS_GCC && $(cc-option, -mcpu=power10 -mpcrel)
 
+config CC_HAS_PTI_MODE_VAR_ATTR
+	def_bool $(success,echo 'void foo(void) { unsigned __int128 u128 __attribute__((__mode__(PTI))); }' | $(CC) -x c - -c -o /dev/null)
+
 config 32BIT
 	bool
 	default y if PPC32
@@ -214,6 +217,7 @@ config PPC
 	select GENERIC_PCI_IOMAP		if PCI
 	select GENERIC_SMP_IDLE_THREAD
 	select HAS_IOPORT			if PCI
+	select HAVE_ALIGNED_STRUCT_PAGE		if PPC_HAS_LQARX && CPU_LITTLE_ENDIAN && CC_HAS_PTI_MODE_VAR_ATTR
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMALLOC		if HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_HUGE_VMAP		if PPC_RADIX_MMU || PPC_8xx
@@ -234,6 +238,7 @@ config PPC
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ASM_MODVERSIONS
+	select HAVE_CMPXCHG_DOUBLE		if PPC_HAS_LQARX && CPU_LITTLE_ENDIAN && CC_HAS_PTI_MODE_VAR_ATTR
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
@@ -341,6 +346,9 @@ config PPC_BARRIER_NOSPEC
 config PPC_HAS_LBARX_LHARX
 	bool
 
+config PPC_HAS_LQARX
+	bool
+
 config EARLY_PRINTK
 	bool
 	default y
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index dbb50c06f0bf..b3164c3c0b81 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -6,6 +6,7 @@
 #include <linux/compiler.h>
 #include <asm/synch.h>
 #include <linux/bug.h>
+#include <linux/types.h>
 
 #ifdef __BIG_ENDIAN
 #define BITOFF_CAL(size, off)	((sizeof(u32) - size - off) * BITS_PER_BYTE)
@@ -617,6 +618,65 @@ __cmpxchg_u64_acquire(u64 *p, unsigned long old, unsigned long new)
 }
 #endif
 
+#ifdef CONFIG_HAVE_CMPXCHG_DOUBLE
+union __u128_halves {
+	u128 full __mode(PTI);
+	struct {
+		u64 low, high;
+	};
+};
+
+#define __CMPXCHG128(name, entry_mb, exit_mb)			\
+static __always_inline u128					\
+__cmpxchg_u128##name(volatile u128 *p, u128 old, u128 new)	\
+{								\
+	union __u128_halves tmp, r, o = { .full = (old) };	\
+								\
+	__asm__ __volatile__ (					\
+	entry_mb						\
+"1:     lqarx   %[r],0,%[ptr]\n"				\
+"       xor     %L[t],%L[r],%[ol]\n"				\
+"       xor     %[t],%[r],%[oh]\n"				\
+"       or.     %[t],%[t],%L[t]\n"				\
+"       bne-    2f\n"						\
+"       mr      %L[t],%[n]\n"					\
+"       mr      %[t],%L[n]\n"					\
+"       stqcx.  %[t],0,%[ptr]\n"				\
+"       bne-    1b\n"						\
+	exit_mb							\
+"2:     mr      %[t],%[r]\n"					\
+"       mr      %[r],%L[r]\n"					\
+"       mr      %L[r],%[t]\n"					\
+	: [r] "=&r" (r.full),					\
+	  [t] "=&r" (tmp.full), "+m" (*p)			\
+	: [ptr] "r" (p),					\
+	  [ol] "r" (o.low), [oh] "r" (o.high),			\
+	  [n] "r" (new)						\
+	: "cc", "memory");					\
+								\
+	return r.full;						\
+}
+
+__CMPXCHG128(, PPC_ATOMIC_ENTRY_BARRIER, PPC_ATOMIC_EXIT_BARRIER)
+__CMPXCHG128(_local, ,)
+
+#undef __CMPXCHG128
+
+#define system_has_cmpxchg128() 1
+
+#define arch_cmpxchg128(ptr, o, n)				\
+({								\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 16);			\
+	__cmpxchg_u128((ptr), (o), (n));			\
+})
+
+#define arch_cmpxchg128_local(ptr, o, n)			\
+({								\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 16);			\
+	__cmpxchg_u128_local((ptr), (o), (n));			\
+})
+#endif
+
 static __always_inline unsigned long
 __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
 	  unsigned int size)
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index f0adbf7ecb7f..a42fd4c64159 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -163,12 +163,14 @@ config POWER8_CPU
 	select ARCH_HAS_FAST_MULTIPLIER
 	select PPC_64S_HASH_MMU
 	select PPC_HAS_LBARX_LHARX
+	select PPC_HAS_LQARX
 
 config POWER9_CPU
 	bool "POWER9"
 	depends on PPC_BOOK3S_64
 	select ARCH_HAS_FAST_MULTIPLIER
 	select PPC_HAS_LBARX_LHARX
+	select PPC_HAS_LQARX
 
 config POWER10_CPU
 	bool "POWER10"
@@ -176,6 +178,7 @@ config POWER10_CPU
 	select ARCH_HAS_FAST_MULTIPLIER
 	select PPC_HAVE_PREFIXED_SUPPORT
 	select PPC_HAVE_PCREL_SUPPORT
+	select PPC_HAS_LQARX
 
 config E5500_CPU
 	bool "Freescale e5500"
-- 
2.52.0


