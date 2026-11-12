Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B548606A323
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SRD7557V
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQLMn5fBjz2ynW;
	Fri, 13 Nov 2026 00:09:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794488997;
	cv=none; b=CBjhogvcS9FagmldZNozhlfhZNlCLfABQ8FkPOmPQLy4WKnzmA17F4/SOI0cubQlWo3D9WbMtGRwdkJctfXnNRDRUYblYk1nYUmV+UWATYHQxIb8obXcfujT4MvAO2s7RXrioMV16j2t8WAYvWmjmz49ZOEY3zl/v8UHuRtoxuV4wx5sV/kWsWiICCA+J2a6hMT5Ek1wZWWSjvJj6oky+qOJPV57qaXlnt4QLtSIVWKQ7pMGK1UUib68xG08m7AxjqClqHFdrEcToT3K9P2gP4EThZoPSd7UxtuP7UeL1S8SxvNpFv7oXywe99Dk26XHa5lu523UYdGSOknhsOXBng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794488997; c=relaxed/relaxed;
	bh=o2GNcSbRCHPA18ByBDNg1tD9RoVzz/GERzR3TgJri4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZqnZLWRLW3qrUY2/SGvUkBudRkY8CzBJhkZChgo1foRA/rfKNN2ciP7YEHM6BSejU/Jm7QZ0tr6MMlEthjN3tyRE5bbU1Q3WX8fLWS9sBhBxLoi0IcK12yNMkJ7zU/Cag65ehJZzUTyFi65l/uE52KyGiLUEhM5QhZTRek2zlWYFGyKDOFJSswDxzGeIjeVcpupAEMakL2UmCVL2ICwEo15SeKoHo0iQ0hKnWifX0DAGMGSDrixdMY80WD+/sUyRT4F8pmSe+SzqVqHpAKBKYBmplT6+Y8X6UZCUbqbRBkmRpHvJJDwXTonOg/e9jjjumCyGJ/l/22Q/FZ20pw7XQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SRD7557V; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SRD7557V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQLMm0kSjz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 00:09:55 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2iYiN2857994;
	Thu, 12 Nov 2026 13:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=o2GNcSbRCHPA18ByB
	DNg1tD9RoVzz/GERzR3TgJri4w=; b=SRD7557VqQS8AbfqjiUVyHbrj+5zvah/J
	ta57yDzHUCRcGMcKJJ+PZCuwPD2XEhXoYMGgv96Qf9Les7979jHKjWBxV5etTjUG
	7W9hp4j3lMkA2KOg+vQMG9Y095O0tT5Ur+0OIQBsQbzPC3WtnUEW39u7ZxQjl89O
	ZwOobrbhmcSJOOSDF8/stYJH4+zVHQbCRTHoNsqL614C4cWJPqIjGdabcltPhzXY
	mYAAkbnReAKQ8COiCKG22mg2tTJWF850UrmPjw7bWUZVDfmaVgy0pdlsZuunUKCh
	RrNrr+AQGbYeznsWxsYfknbMRagkogAC4mmoFLSY58XAV9pJA8aIA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumv6b1v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 13:09:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACAlYvX676844;
	Thu, 12 Nov 2026 13:09:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hwc0t8e9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 13:09:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACD9VQi36372948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 13:09:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C37BA2004B;
	Thu, 12 Nov 2026 13:09:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EC4F20043;
	Thu, 12 Nov 2026 13:09:27 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.18.47])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 13:09:27 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        msuchanek@suse.de, ritesh.list@gmail.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
        nnmlinux@linux.ibm.com, mkchauras@gmail.com
Subject: [PATCH v3 2/3] KVM: PPC: BookE: Load FP and Altivec before enabling the interrupts
Date: Thu, 12 Nov 2026 18:39:12 +0530
Message-ID: <20261112130913.4124175-3-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MCBTYWx0ZWRfXzf2swm0GZM8W
 uEL40xLG+hCebeszMNRb1xHSbAnvyDNmPozAUxRm884z592RIX94xaMtx9oIIW4wbXNztasPi/X
 rIFJGic65AkdCOjJHjJqjUZVaeCKIYA=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af5ba90 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=hyHdCrymTFJ9VBfVSMoA:9
X-Proofpoint-GUID: 5aeDNAk106GtGp1zSL25m34lbGaJQhrC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MCBTYWx0ZWRfX7INzKH23sAlK
 gilry1Rb01vQ213j3aAbJkf+y6jprx1OGXQYh+bn9/uE7IGlFxAMO6K786xhFZZ7KAGpebfI5qJ
 oVfq5WT51qYnwa+2cx61YnMhTzrgjIk7/zRUnIzQwlYxF9Dry4WooAo08TY3fyOaHYLGEVDNbLf
 xxFYx/B0wSThjporzGu+SXVQXOx+7KNNkZcL62itSHmRFRMn/0zbRmLbvxZu6IzNw6/bCeKhWVs
 pK4kHpyd4eM++nQFo5oKE3gIiL61514fLa5uqjcneIWdIC/SWH7EoloFxavIIDizEllbw+PFkhc
 PNVTXvBAQYIk7xZSDXEWDwYIlQjBDq2d/z1vUwdonrrXuCHojiIukxHD3FWrHQIXA2ZBkzatcQO
 fV+K8W5qQxs/u3idOl7bcmnlAihaJ0MiVTQi50fBYRJrNpg73vkJfzP2jKopABXeCXxSPJrHSdB
 BdH839nVg4cxzV/Utfw==
X-Proofpoint-ORIG-GUID: m068ASiNWZ5a1Hp0E0LFI-Z3RHgFmwTL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120050
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Christian reported that booting preemptible kernel on FSL Cyrus+ board
causes boot hang.

The logs pointed that system was busy in printing below warning.

WARNING: at .enable_kernel_fp+0x30/0x78, CPU#3: qemu-system-ppc/4884
Modules linked in:
CPU: 3 UID: 1000 PID: 4884 Comm: qemu-system-ppc Not tainted 7.3.0-rc1-powerpc64-smp-preempt #1 PREEMPT
NIP [c000000000003338] .enable_kernel_fp+0x30/0x78
LR [c00000000005de84] .kvmppc_load_guest_fp+0x30/0x80
Call Trace:
[c000000085ca7700] [c00000000005de84] .kvmppc_load_guest_fp+0x30/0x80
[c000000085ca7780] [c00000000005f2a0] .kvmppc_handle_exit+0x5bc/0x5cc
[c000000085ca7830] [c00000000006204c] .kvmppc_resume_host+0xb8/0x10c

Which is...

void enable_kernel_fp(void)
{
        unsigned long cpumsr;
        WARN_ON(preemptible());

And...

Though irq's are hard disabled after kvmppc_prepare_to_enter, but
kvmppc_fix_ee_before_entry enables the softmask's IRQ state.
That causes the irqs_disabled to return false.
Hence leading to the warnings.

Fix it by re-ordering the code to load the FP and Altivec
before enabling the softmask IRQ state.

Suggested-by: Narayana Murty N <nnmlinux@linux.ibm.com>
Fixes: 3efc7da61f6c ("KVM: PPC: Book3E: Increase FPU laziness")
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Closes: https://lore.kernel.org/all/33342fbf-eb7b-bde6-2c8c-254fe8bfb993@xenosoft.de/
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/kvm/booke.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 13ad4cf5fa71..aed7b476b7eb 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1404,10 +1404,9 @@ int kvmppc_handle_exit(struct kvm_vcpu *vcpu, unsigned int exit_nr)
 		if (s <= 0)
 			r = (s << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
 		else {
-			/* interrupts now hard-disabled */
-			kvmppc_fix_ee_before_entry();
 			kvmppc_load_guest_fp(vcpu);
 			kvmppc_load_guest_altivec(vcpu);
+			kvmppc_fix_ee_before_entry();
 		}
 	}
 
-- 
2.52.0


