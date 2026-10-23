Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472F6606A32A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PUYZTHko
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jB3Tp3CyCz30TQ;
	Sat, 24 Oct 2026 00:17:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792761454;
	cv=none; b=Yg2KQnWHODOK7QM3E6SqiHp1OaBg4szodG9EzN53SgF/RdwKXv2F/nvaniOIjX3gaAeNc/H48JOzaiHHQJFL+K+77Vu/aPwAsgnGTdNG++sdJqt1w7P0FRi6oX0LxwJjBrWnN1RSIfrsQiUcgHAaUsCsKJVV1iKLETGp5fz5PfsqWMQHx3mkds1G5cd4L1VCkpQDv6T0+PmhcHJPbqJ4tkqjT/lqsANKpckCFKHHkBM3215KcvhuskflTDKFNKZxaHU/m49IaFDKUT/Ry8RhDr1bIEwz/Hb/N6xUfr8v8HMJeuwvQZ3Ce+8ry8Ju6PwF3CoLkqI1nqqCWiYD/5Tt7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792761454; c=relaxed/relaxed;
	bh=qxpAztfnmKjrHr4CL3O/dOVke4KGlZT/jqWelaHqxJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+ZdrDwZ2wRupz2z2IpS7BlD28pIKCFA+9J2mp27uyJmz4Os5tMh8RZiGtCCskIZvk7qXi8GwlByqCNXjSkZgdKhH5dnehiTshE0IvZLGlaclDvVOJIrtGwtWbmFFF37I3JYOkIh+N3ijNDRs+8G5eoClKNQQf2aUBLMaAefz9FjABqx67w9bCeE7UMv4C5WTxc5un1C10aeC3iLGuZogTPriz9gXGxHn2BlPTXYk/U+y2c11U0SsFYQqTEhFhlZjVfdxuOCtA93Umu89x3bCEKy+gkq1/s6JtwLA+cYb/T74XAhvj6v9KkpHsXJV7d8u+wBFUaoHYOJ8UDf1IZaZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PUYZTHko; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PUYZTHko;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jB3Tn3zLcz2yDr
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 00:17:33 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAEFLS2540749;
	Fri, 23 Oct 2026 13:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qxpAztfnmKjrHr4CL
	3O/dOVke4KGlZT/jqWelaHqxJQ=; b=PUYZTHko29CCWegh+EEr6EjMJbHCM5Zw9
	f7MIunD/jLHHL5Iei7Q83tY/UCc7LWOaIM0HNfktGx5NeQH2aI7k7BKmIa9G5/FS
	oIqqe1e02fDKQXcxerZ4vu31YpnPrBgAsROatr8gk//aqfDsqI20CIpCSii525D4
	e/Gm+D6lbKR6Q8HQe4K/9X8cztUR4tNerj74vvf60Qnxp4jZEAQ49Tb+TEJjn6Vm
	G+xXjO8K55yccyn6p6nlKgkSz6mAXZGXgs3vNiLi4rGupYjyqdSjRugEmm02MLTn
	aA/RyMhfTHgNXnXNN3E6F1FlFihUWqYmJxWWyGe5mEjWORSJTzE1g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5b4ryv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 13:17:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAK37A1912661;
	Fri, 23 Oct 2026 13:17:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfkg24w0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 13:17:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NDH83C43975022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 13:17:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 100412004B;
	Fri, 23 Oct 2026 13:17:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7374F2004E;
	Fri, 23 Oct 2026 13:17:03 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.19.68])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 13:17:03 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
        tim.c.chen@linux.intel.com
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com,
        kprateek.nayak@amd.com, yu.c.chen@intel.com, vineethr@linux.ibm.com,
        vincent.guittot@linaro.org, srikar@linux.ibm.com, npiggin@gmail.com,
        mpe@ellerman.id.au
Subject: [PATCH v2 3/4] powerpc/topology: Update arch_llc_mask based llc_override
Date: Fri, 23 Oct 2026 18:46:45 +0530
Message-ID: <20261023131646.2907938-4-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023131646.2907938-1-sshegde@linux.ibm.com>
References: <20261023131646.2907938-1-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6adb5e59 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=c4_4ORLq-ylGgVheI_IA:9
X-Proofpoint-ORIG-GUID: d3cXJXhwwGZ67gt1kgxSF053CffX1GO7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1MSBTYWx0ZWRfX0+D4h36CoiKW
 NtTselcQsxW4OD11T8VfR6Xe43PAPUdWqnMpC5dc8qc+CZoZY47jyeNb27bUYWlz1bfJLKO+pJq
 6rgfjDvhfV5sSy8XRP2xKNsbQUtcg85MXMv3BCCnQxNaWo4wvZU+q9URbZyhyE0vXnZVQKeEzuQ
 InDxvMpP0EgS9TVEgyKvS2zzNtG7S1hcFVPMrUoo6R/pgnHN0gPCptdve3WTUXJEAwbdKZGONBp
 m/V0M3fry3la1sxH4aPOHPzUrrnv6DskVqn+Gq7wgkUWI31UNieNOMXKl2jpUyUP9NKS+nR9+v9
 mQMnlIEX5gNAXvDdBqrEjOAvZdo2togDENQGE7aKK073aZfcAjHU5kOgp63IIfYspW2bgU4tITC
 zetEm1jAzC2Cyn022Of5ZsTAqSmG94+pr/Y/Py9yjnvv6EZoqkuJYKny9DeY2YU3zLpT/Yiu1a+
 zZx+dJDY6/wSYfdMe6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1MSBTYWx0ZWRfXyKDplrX/Tkve
 98I3dwfsID2sNepmiLLh+smHJq2KGPWRJFr48O6ztKLKhdr6GTzJ8aYj9HH/K8z10a2h2DrW8lD
 eux22/9xPA0trpUyXIZ+XejQDDv1mG4=
X-Proofpoint-GUID: Dc9DVq-SItaGtsfpNkh_g10jRRkLBTmF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230051
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update the arch_llc_mask passed for building the cache aware scheduling
data structures such as llc_id etc.

Since llc_override is kernel parameter, this helps to keep the
arch_llc_mask stable after boot which in turn keeps llc_id consistent,
since llc_id are not updated even on rebuilding the sched domains.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/include/asm/topology.h |  8 ++------
 arch/powerpc/kernel/smp.c           | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 44ec416fa489..e1ca91d9b2c2 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -135,12 +135,8 @@ struct cpumask *cpu_coregroup_mask(int cpu);
 const struct cpumask *cpu_die_mask(int cpu);
 int cpu_die_id(int cpu);
 
-/*
- * Points to where the LLC is. On power9 this will point at CACHE
- * domain, On others it will point to SMT domain. In all cases
- * cpu_l2_cache_mask points to where LLC is
- */
-#define arch_llc_mask(cpu)     cpu_l2_cache_mask(cpu)
+const struct cpumask *arch_llc_mask(int cpu);
+#define arch_llc_mask arch_llc_mask
 
 #ifdef CONFIG_PPC64
 #include <asm/smp.h>
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index ca1821dedc98..4ece21abb1c4 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1099,6 +1099,25 @@ static int __init set_llc_override(char *str)
 }
 __setup("llc_override=", set_llc_override);
 
+/*
+ * Points to where the LLC is. On power9 this will point at CACHE
+ * domain, On others it will point to SMT domain. In all cases
+ * cpu_l2_cache_mask points to where LLC is.
+ *
+ * If there is llc_override set, return the appropriate mask
+ */
+const struct cpumask *arch_llc_mask(int cpu)
+{
+	switch (READ_ONCE(llc_override)) {
+	case LLC_OVERRIDE_MC:
+		return cpu_coregroup_mask(cpu);
+	case LLC_OVERRIDE_PKG:
+		return cpu_node_mask(cpu);
+	default:
+		return cpu_l2_cache_mask(cpu);
+	}
+}
+
 static int __init init_big_cores(void)
 {
 	int cpu;
-- 
2.52.0


