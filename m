Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366E4606A327
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nXhyDQkC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJ5h14GMQz2yKn;
	Mon, 02 Nov 2026 20:17:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793611041;
	cv=none; b=jXbjjGRbLTg/13WCiymvvw4xGbaejNXSlz8M5ZT3mGOf5Bp20yhnTk3QsTOt1B27/gUbpSa0G+4H7G5NUKwfjzyIxUKgZVCeDHb1AyBZyujfSoxSvoBVV3hgYhRX5luTkeZXfjekzJHtgbV6daECeeJxvRdNmTa/r7yHJDxYzN3qIKyEI1FneDlCTU+NmsCiGZj1qR/II1LCfvz+JA1a4MxTdJ/t4LwkxWrLV8HTEiTMSSrPZaRQ4NdZ4uy04RBbUOE7Et6VqvepyPNd3lOh+X/O80hrtzR0Rc+a7a+BmJ8dw8XFTgQ7KjiwOfsCV7eWNNsXTD/FORk1RkmeucTsIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793611041; c=relaxed/relaxed;
	bh=3MV7QetbXCaQFOkeg/BYUNGDOFmcDgX3YW4BjUb3FHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nRbYsWACmPVThLGjDFBBM13pL+U7Z3zxtyAw85l10nim6lKzIx9Bku3hwLgo0iidRD9xWBvfBKEc5nfgm2RJPr6RKOVvEs68zGGqJXPGuY82+q2ki9R0h+dI1gooMQrx6MALg2GM5qFI2s3gQlHCAQnnuA6r6iQj9+WQ2Pu3qmpz9N5VF1hUK4qhrjE86sFIpVQFiOE8InJDAC4ueeErTGKpS0Y6CA0rPeWRyJXLCTr4Go+DCcalHDC5pvz5QM/AyrFbaoF+YCsxgx11JsxjOQZHzoxhEVsHUPvkGGLTu9n+C7iLduLUxoiZIev8S0uDfQOw45HV6Qs6H6OAsfRSZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nXhyDQkC; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nXhyDQkC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJ5h04BNGz2xH9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 20:17:19 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29EVjq2489759;
	Mon, 2 Nov 2026 09:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=3MV7QetbXCaQFOkeg/BYUNGDOFmcDgX3YW4BjUb3F
	Hs=; b=nXhyDQkC5j8rhoDM1+n27nMJryHYPUMAl9CVF3mfXwG1lbSBRBcvOAdRi
	imN01ytMhteTmOlj+9rCjXLyBnpqz1ux3aTTx/CZ1COh0b7BkxijTeWom5Ejn+/k
	A8RjIo740+PywwHeHe0k+QagMHU5axo3ym8K5e0pbRBkRJpvZi0MVYHD0b0AcDqZ
	r6mNSHlYyLZYhdB48fPJ0kM6uXBdsTEToKEP+Ji9L4G75jJ9IQtJs9r8gcMpgnDH
	2Znmv5cVExvKtQuEFJVXtsq/1J6L1ANkjmQdx/8Qd3njuc/6ZCZcjLxsQkW1ct2m
	3iQusm1SKbcUbP4u7zJEA2XW/do0g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826fnmq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 09:17:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A28Wi3m394411;
	Mon, 2 Nov 2026 09:17:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnwbxvuku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 09:17:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A29H53A43647278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 09:17:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37E3820043;
	Mon,  2 Nov 2026 09:17:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95F1F20040;
	Mon,  2 Nov 2026 09:17:02 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibmuc.com (unknown [9.39.25.78])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 09:17:02 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Timothy Pearson <tpearson@raptorengineering.com>
Subject: [PATCH v5] KVM: PPC: Book3S HV: Avoid spurious interrupts caused by LPCR_MER bit
Date: Mon,  2 Nov 2026 14:46:59 +0530
Message-ID: <20261102091700.253381-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
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
X-Proofpoint-ORIG-GUID: 1xCTqIO-R6O4I7UknL9LItpBB8SQ9GdA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzNiBTYWx0ZWRfX+e9PO0TL10Qz
 hjS+vaFzr07I4waGgYsF0T62LrURQ23/hWlf1e+Entqw2NlPHpU/UyqUBwWf5PoMghNwbq23uXI
 YqE6bTHgUon4ekUsn9Qvoa7fGXgAKfo+zryPGxL+XAYqqqNPBK+RBA5axp7NJT9qmjoY+EfN1OX
 PNLyjhUhf0lg0yIEOoa4Df81yxLi7FSSN6K7k5j9sMsvKIlfw3htCq2vHPrzgKKArgHBUnGXOni
 q7jE6sOYPXjpxzg0pK7Bq9NG20ad6xKyH6fiICKiQ8GN+qesP1KYHZvpMuR4aGenwZISi5iUjbN
 5md5E9TliAgbKuiFe1UiJ4CgZhENTytoHnWrIIzLTQ72XeXbzrYilu9TMozDlVQbhBNEDCfzJwu
 EDa8jtVPpubCa7upn9fKjLSjTmPrmn/Gh/7IsbO4vT+DDV4isCsHYZ08281YpvNhimW0pBDZZZa
 kqt3/hlwFEHr/QcouuA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzNiBTYWx0ZWRfX1DGZSkJsc4A/
 /WKJQqnyTmCenyBToPYHCAoBM5Fb33J012nTyqMEHkHuXrpWSPk5AQuI0W/VSGDjdDnFVwnbzUx
 gt6fTYnZbfxswNOObOe6ud7SyARv5/k=
X-Proofpoint-GUID: sODIPSMf0RgplZhJwFRSOSvwSs2E-GtE
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6ae85516 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=yKAn6K1XAAAA:8 a=_AprYWD3AAAA:8
 a=VnNF1IyMAAAA:8 a=r95I5fjiukzm4VaaYucA:9 a=6M1ixcW_PCWoKiWyFx5v:22
 a=fKH2wJO7VO9AkD4yHysb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020036
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A huge number of spurious interrupts can be seen immediately after a KVM
on PowerNV guest boots up in XIVE mode.

$ cat /proc/interrupts  | grep SPU
SPU:     223705     192439     273526     147623   Spurious interrupts

This bug was introduced by commit ecd10702baae5 ("KVM: PPC: Book3S HV:
Handle pending exceptions on guest entry with MSR_EE"). The root cause
is that once LPCR_MER bit is set, it is supposed to be reset by
software. But when a vCPU starts running with LPCR_MER set, the vCPU does
not exit back to the host until the decrementer expires or there is an
hcall, etc. This is because KVM on PowerNV guests have support for
native XIVE, so they are not dependent on host for interrupt emulation.
Due to this behaviour, a huge number of spurious interrupts are seen
since LPCR_MER continues to be set and LPCR_MER cannot be reset until the
vCPU exits to the host.

Fix this behaviour by not using the LPCR_MER bit whenever native XIVE is
available (currently in case of KVM on PowerNV only), as the XIVE hardware
can present interrupts to the KVM guest vCPU directly. So the LPCR_MER
functionality is not required. This reduces the number of spurious
interrupts drastically.

Fixes: ecd10702baae5 ("KVM: PPC: Book3S HV: Handle pending exceptions on guest entry with MSR_EE")
Cc: stable@vger.kernel.org # 6.8+
Reported-by: Timothy Pearson <tpearson@raptorengineering.com>
Closes: https://lore.kernel.org/linuxppc-dev/582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v5:
1. Drop the redundant check for the presence of the native XIVE
device. (Ritesh)

v4:
1. If interrupt mode is changed to XICS during guest reboot, MER should
be used. (Amit)

v3:
1. Continue the use of LPCR_MER when kernel-irqchip=off (Sashiko)

v2:
1. Handle the case where xive_interrupt_pending() is true and also the
external exception bit is set. (Narayana)

 arch/powerpc/kvm/book3s_hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 22283d46e8fe..41012b0accf4 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4984,7 +4984,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 			if (!kvmhv_on_pseries() && (__kvmppc_get_msr_hv(vcpu) & MSR_EE))
 				kvmppc_inject_interrupt_hv(vcpu,
 							   BOOK3S_INTERRUPT_EXTERNAL, 0);
-			else
+			else if (!kvmppc_xive_enabled(vcpu))
 				lpcr |= LPCR_MER;
 		} else {
 			/*
-- 
2.55.0


