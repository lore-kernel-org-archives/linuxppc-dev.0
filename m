Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF3606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HTZMN6Xz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTQHZ20LPz2xlY;
	Wed, 18 Nov 2026 00:16:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794921418;
	cv=none; b=dQEzvCQo+S4j/hWLZtvULLEbxc6djLJeOpcLBGBXqNWIxW59UeOZpy2V7gpZTR93S6e2a7z1gJ494wBehBhkF81C3qvtB2yyai8njWAaB0GppC6VZWWqZpZnRQxOAn8lc0g6I8SK7JQpldF7rn3KkOxU/9Fe+8p6cofGnPepEffX1vQG4OVH0+v4elAOZr/QCk50EKlWdCsfrjkgDkraqETwKaFUvJoG++gC/brJ+huI8xHmQVUxqY9th7WWoKOt5VzhoRt1X+mDKHy8MzLUI5zswafKjFjv0KezqNPWuHBTUQMHLwi/70QM/UKwnWZR1zJ3vfa8xGafii7m8x1IjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794921418; c=relaxed/relaxed;
	bh=tjgKiaaz9e7qoHiFwJCppI10mxoqPyPjumN5RnXHqkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvXFPIylBXb4JhQ0np3+1HzS5+Hpk7/bpQuwGc8O0o3U2IkeYX71oWPgRYonU9US6lfWxc965NHZrI2hi572jJkpXLxa8dAvC40wDmGkJS4TgrUggA+GMu+h02s0Ea4ugEUw20sI9rXFfv/LlDqdPCwReupDaR0VMFJ/FWLAZSwRanOHw0xXW7lfKXP9C3i1qGlL1q9nUs5/5EiKxpOCLj5TDOiumysu2qcckQoSqAdHBpMHO2yp0BT8CW5vGYUyw9vrwDpaaCfRDRSniqtB9xjovz9TDsMZcRghduIkI6cgHKUOODOuxLHmsV6k30Cpkam4A1t7iglhdifcBAw86w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HTZMN6Xz; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HTZMN6Xz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTQHY3s37z2xnZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 00:16:57 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHBwENv2452532;
	Tue, 17 Nov 2026 13:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tjgKiaaz9e7qoHiFw
	JCppI10mxoqPyPjumN5RnXHqkg=; b=HTZMN6XzCJQysR9C90qUtw9INeOC45skz
	tba1XDtB6eifDNG7APnTgrCQwyuC5Y9Kyxr28FlhUAEFf1oyBwSWi7h5cK3h4PA/
	woetu7p2+YMtYU/g5D67xGVXxAq/9K8hv/KTe0kAcYvNFPHKlxKICwXb+UUlA44N
	VDf7jMUCNVPkjfitzj4h7QgcYYH9XcvARInMtnTilfnUwhBSPJEQuocWZ/imDBRz
	D1lma1G8hEW7Wc+ef1Kra8+hwhFtHj3I+quNU66p8iyo6clResQVChDU7bztJbl0
	zxzIroNu1PyuIL2yubFwIcdgYSm+3rYVqSoaGiRBvT/1seZWrhm9g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxf56bdhy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 13:16:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHC4rsH471678;
	Tue, 17 Nov 2026 13:16:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j02dfd2ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 13:16:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHDGWGc56492420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 13:16:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 843C420043;
	Tue, 17 Nov 2026 13:16:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2A9A20040;
	Tue, 17 Nov 2026 13:16:27 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.217.181])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Nov 2026 13:16:27 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        msuchanek@suse.de, ritesh.list@gmail.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
        nnmlinux@linux.ibm.com, mkchauras@gmail.com
Subject: [PATCH v4 2/3] KVM: PPC: BookE: Load FP and Altivec before enabling the interrupts
Date: Tue, 17 Nov 2026 18:46:11 +0530
Message-ID: <20261117131612.707038-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261117131612.707038-1-sshegde@linux.ibm.com>
References: <20261117131612.707038-1-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA1MSBTYWx0ZWRfX6+Y5AYLUCWhy
 +mDpi82atyTOq88cR7bjZ6DqJL0pDYdrMT6hMMbq9LXnZjBTRNKF7v+u56dr7hV+GGzlpm90bCh
 eWxEqugoKkRWuIVo2RWaNvm6Yl9d1c8=
X-Proofpoint-GUID: WD4WS3SffMazWzQIpofurbvbFZzGSA7l
X-Authority-Analysis: v=2.4 cv=ROImjIi+ c=1 sm=1 tr=0 ts=6afc53b7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=hyHdCrymTFJ9VBfVSMoA:9
X-Proofpoint-ORIG-GUID: XUdHcqpxlHK6rrgo8Qzk9X2MPztAjJmi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA1MSBTYWx0ZWRfXyaPQPAqfJvRg
 E/M/MjYQHHm3Qn6mJW2Fyco3zKllHMQn4MVLv043EmUTbCyOWbM5P2XlKcq1JTE39CG1l8zgFXi
 1UD60SbdddJt0kgsjDsQJ7sxhmp6Y3NDA7A0CRHxkni3dHr0EYZaXHQ4vW7RZnVgM0FLJ4Be+c9
 GEler+sQEsqwsef/Ms42v60W4/Z3mkC0TYMFwCB3IJbK1tA10fd0ndlSlj07P97XGDekeCpUAJc
 KAx7/sYPIIsKD7h89hSbM0+tknlNAs4wU4FuwiKCB1vF3dN/VI0TlbCx331P3GHvrhfrAa5xPHU
 AwYfD/9sOspxVNR8gMZ94kx7aP2oXbnU7HQlt/6RzfjgZjUhUcQLwiEavVZFN0+T6M2+U8rv/Wl
 l+FzCA5NgS6MPd0dJQeYjhLmVCx3k+AK16k7weGbyjYpYMAYdWF3KuaEPDYOxtVN2tlQj5D01GS
 RSnqVpIJ/hQpdBs+dIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170051
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
Reviewed-by: Narayana Murty N <nnmlinux@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
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
2.54.0


