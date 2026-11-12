Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34108606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=toA1u4dx
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQLMY3ChMz30VX;
	Fri, 13 Nov 2026 00:09:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794488985;
	cv=none; b=Ti82Qg2WRKxKd7powvOFrtz22JAKdAR8lmJ+BvX3oYg6mj8rpG1M5PZVhBp9JSolV1Do948RnEC9vt/AINAA0OEkaJbDk1kFC30wGDPd7p3rbKNrla7jHYyqQ9WFUyMBoLR+Zeb0VkbQ360dTrVL1fNjCBKlFzJfqTLeCV5M4SkHoJHLD9sB9UYHzA2E1vcsNUuxXq9waObdUuM7ei7ERS4Meu+3D2vzgbUDM1LSFdZWnjeV2M7F8mH4vfgX0fg8rdr+s1FzlwHK3cYO6CMNAqXtYuoLWlUVOuNzYWGVY2oO2+lhnUr2+c1+Lvrr9T7WGnV666rGciGRaK4UBy7W/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794488985; c=relaxed/relaxed;
	bh=5HGGoZ3suU3yH5SBSyjiKGHZ8zfIiJUqwU8Oy3Y9GZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRpjSlI/EvJK4gRx2ivmKb/yckR2MeDUI7IyZLLrl8v9d5f4WXV9bPR9mUgrO8KgW+UsWciETUGI2PMbV7hteFG+lfyHmNwlp+25fT8lKOHcfbF3zuPIkht/M5QsqK77pvA+K+kgsAIKBX8BBFrnh32RUAEWMBnJj43H5Zaqb/nn4h6ak/ma6/EhH6InPWX8iaI/pFZpT8IXHPRNage2tceYKv+GlDW5uxPzcuSXZkrCiXkZvH6DZdyHrsVnR4UnnlEBKkVyLU+IcVn01h++GWXq/ZtwSpgiNxMXOsTs0qBjz2dUkhyeUISN7gBKwkzNDmerH6TKozickU61m947/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=toA1u4dx; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=toA1u4dx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQLMX56ptz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 00:09:44 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2iaDL1215170;
	Thu, 12 Nov 2026 13:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5HGGoZ3suU3yH5SBS
	yjiKGHZ8zfIiJUqwU8Oy3Y9GZo=; b=toA1u4dx8EhioT90CTkC19FSrj1LxTqru
	u3UqRvmvTyWyYNayTk5CJ6ocljj2rZfUEuSxxNUHDYUOfYdZA2yq6iCL6+NZsV2Z
	9z3ku4GF12u7/USh1zhQRZo8TuihzbVcbPmp772W4zDrI59TS+6E+Y9VjqcsunCP
	yLwnzZaqvxE8mYmYxwODR6pTKjgT/cRkrp8euA1p9QnqbX4JJVKtovocFZ5gK6UW
	19u9uWp9IiFtfc+59JNjiIqCSj559DoY8yczPwGKsR9mSXhRchMyX19FpOAx8Efb
	zL+i8U6w3yV/mt6jip/mGV4eX9dLned4G6g69vrZGIYN1TwWCAX3A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuntfkh6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 13:09:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACD2i95016709;
	Thu, 12 Nov 2026 13:09:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hv3328vn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 13:09:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACD9RgO50070000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 13:09:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 172DA2004E;
	Thu, 12 Nov 2026 13:09:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6E6C20040;
	Thu, 12 Nov 2026 13:09:21 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.18.47])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 13:09:21 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        msuchanek@suse.de, ritesh.list@gmail.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
        nnmlinux@linux.ibm.com, mkchauras@gmail.com
Subject: [PATCH v3 1/3] powerpc/irq: Add ppc_hard_irq_disable()
Date: Thu, 12 Nov 2026 18:39:11 +0530
Message-ID: <20261112130913.4124175-2-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112130913.4124175-1-sshegde@linux.ibm.com>
References: <20261112130913.4124175-1-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MCBTYWx0ZWRfX4ydoYdUUpA4/
 y6wV+QjSxOqDFZYSWFAMp3ao8ut/WRHJ/runHf8t5+Bw2mP4kq7qk5igeJB2kuV0VLpQb+rNetu
 8YDzZc8EFq6FNgO2t7AQsvhDU5G+4p/Fw1GvafdqoUPvMAwjYYOUTlDg+tLGkCKKAXFjjO/oYXD
 eSpQD9n6fzRaxJxdlakd4UnHHeZagmvF3x+RQ7AILCV0z9WZtbqx+ekY4ui1BAh+Edzncvp/RWQ
 r4K/HCx56Y1JSiG0Y3veL/hAnei/kS8CZuxnKlT5jmJ7K0nfROWVRfLxs80ppp/8tr3/Vwu3ycd
 rnsjE4SwpbV/BNqcv+fx8FK2r28MIoeFugyfFzWO8EOua7zGuYDCaY/19BiDpCYfcQZMevnrtDC
 0aQ5NL90JiKJH21UlaxQtkXwKwH6FRL/4BN/pYXGQrHQ0xdUylXGJmSBzraCc4P6hcF3Jzs1Wlm
 s5QpPEBCnUa1hKs2PRw==
X-Proofpoint-ORIG-GUID: FWg-ZWyDmR4YV58CMRhmKCiK8BhNxsmM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MCBTYWx0ZWRfX2f4eIoxMq4GT
 E4Qm9YLmWtslBUpL/w9oM2BP9/sIqOgSYT3wTyRXUlumMvCw5vyXy0dyZiK2ZWJltkapritIfBz
 24toGeLylZWfy1GVwEcdjpYEccTXCdM=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af5ba8c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=_WWFrvYBg-EO3VjvraEA:9
X-Proofpoint-GUID: 8PreUY82_xYZ2NmIZcJbpaAa5SRwtq5l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120050
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a flavour of interrupt disable which could be used in
multiple places which also takes care of lockdep in both 32 and
64 bit archs.

On PPC64:
- Disable hard interrupts using hard_irq_disable. It takes care of
  lockdep and tracing. local_irq_disable only alters softmask's state.

On PPC32:
- Interrupts are hard disabled with local_irq_disable. It also takes
  care of lockdep and tacing.

Subsequent patch uses this API in KVM code to avoid the warnings.
Wider use of it is possible, but it will be taken subsequently.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/include/asm/hw_irq.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index b7eee6385ae5..075442366e1e 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -516,6 +516,23 @@ static inline unsigned long mtmsr_isync_irqsafe(unsigned long msr)
 
 #define ARCH_IRQ_INIT_FLAGS	IRQ_NOREQUEST
 
+/*
+ * Hard-disable interrupts while keeping the IRQ tracing state
+ * consistent.
+ *
+ * On PPC64, local_irq_disable() only soft-disables interrupts, leaving
+ * a window where an interrupt can be recorded in irq_happened before
+ * interrupts are hard-disabled.
+ *
+ * On PPC32, hard_irq_disable() does not update the IRQ tracing state, so
+ * use local_irq_disable().
+ */
+#ifdef CONFIG_PPC64
+#define ppc_hard_irq_disable()	hard_irq_disable()
+#else
+#define ppc_hard_irq_disable()	local_irq_disable()
+#endif
+
 #endif  /* __ASSEMBLER__ */
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_HW_IRQ_H */
-- 
2.52.0


