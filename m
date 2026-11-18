Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79927606A32C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 05:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Liry3Y5I
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTqXz44p5z2y2B;
	Wed, 18 Nov 2026 16:14:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794978899;
	cv=none; b=l1QcoL5yIGlAZr+FbtveX0XR6aB7Xxy0X3trHhixlQvmxTgQiCB+RYUsDZdyKBKxf6hcxEik3Hqg2o4/y7uaoeO730Nu2DPB5m8xv4uqiJWDRd3/RhchOOS2UoXNGThgFGcHJxeqr4PE5v+qPbcVAaWgYUL8hRonDD5NC+NdOFAJPFi4cqBoYf7Ih99hhIrXSvBZCCM6wVNp1gRWGoAwDx/a/m7WlAruFiBIZF/ndBzIFVxnMedmJ3myUuO4DOhyw5zRWYx5R3aniH5FjzUWySct8+U49bTRx0rU7Bj7w6NHsfxIIATxfj2UqWA/BhtMQr2NjeW3L3Gs26dX/pkjxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794978899; c=relaxed/relaxed;
	bh=tjgKiaaz9e7qoHiFwJCppI10mxoqPyPjumN5RnXHqkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiqNQBwFcD2d8oR4qDfhvudYeFY87Emhmv+RkABTDyGxPpFsiFrDvDaqU7jnQAsTMgMaRLZee+4+mSKeoW9nm4z/fPdjqLGsAVmKLrFUBVroEgGy2AFoj9wP5zWLWXHTOINClKLnc8oN5stj7c3r3q3twkOPfqQ1rpk3X199AjHvIg3j66ESyt9VyjDXQWO4awunL4pPJYINLpHO5nBRfKaBN6rrUeeSPBx9vifDpaQsWOxCQIk4xbZeaNpDltDZE9m+wMyYXM+eLpqjuxt+KtHtPcAx1t1gIJtcN6Y00QoiWGakLbS4ta8MlQLiHvQXL7ZzQ5kzdVrQBGZ60S131g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Liry3Y5I; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Liry3Y5I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTqXy5Sw9z2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 16:14:58 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2Tb1H2865105;
	Wed, 18 Nov 2026 05:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tjgKiaaz9e7qoHiFw
	JCppI10mxoqPyPjumN5RnXHqkg=; b=Liry3Y5Ir+lsnzoghDFUIClJVnLbiLAkS
	SiNI5BVQc9Za2Sp08JBaP0F8jN1GIE4q+F8ckxwgCR9I0/vkFrMcFe7Kn4FyhWmC
	mOkYmTEiVekaKB9i4wvVkv7WTehcexsR0Op8MoE8Y033DyITFx3UIqLeb3p2R3Q/
	9hFBPdmOxtr83Yk0+2x4M+f37NQhgWlwh+qucD7rBNvV04TMhtR0cGLMRzgSVAOD
	n4YXeJ/1N0zYJNssp7qGoeDObirb6QlsbGziwGBGnWtSR4mVXmgPjENPfKep/3fd
	ARoZwJ/qTHbD8sYdv3bnQgWbn14sjqLYvtyE+CKlmsKR812oeARTg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vrxqr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 05:14:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2Z2ph2477260;
	Wed, 18 Nov 2026 05:14:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j02jueyqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 05:14:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI5EeSa52036002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 05:14:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F5982004B;
	Wed, 18 Nov 2026 05:14:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F298620040;
	Wed, 18 Nov 2026 05:14:34 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.20.10])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 05:14:34 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        msuchanek@suse.de, ritesh.list@gmail.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
        nnmlinux@linux.ibm.com, mkchauras@gmail.com
Subject: [PATCH v5 2/3] KVM: PPC: BookE: Load FP and Altivec before enabling the interrupts
Date: Wed, 18 Nov 2026 10:44:18 +0530
Message-ID: <20261118051419.783878-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261118051419.783878-1-sshegde@linux.ibm.com>
References: <20261118051419.783878-1-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: kAXfPTvqRIF_4RyJvxoxM7aG1iu7ne2m
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6afd3445 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=hyHdCrymTFJ9VBfVSMoA:9
X-Proofpoint-ORIG-GUID: 9ZuOFK0kv1N7cqXwF8u7CZ5rLEiT5Ymp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAxOSBTYWx0ZWRfXzSNPkG1IklbK
 eW4gSY1yHXaSZqqH5qogXW+m8fQv8eWft5VMzBxvfsieDjvXt6nC0gTYO2JQiNUFgUQhmcBV66I
 kezUe4lTgaJnOpROsKFVHQeLaQp4+w0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAxOSBTYWx0ZWRfXy6Y4RmMTc66/
 bDwZm5GpNh/gqcPudAU7ik5KltE4EJzPpzNqMAV03kzAixVSyu0p+OPh6wXUqeXLdnIXxUsZnnT
 q7sKIeGRj65TCl3s3u7gUSwoGny1zs+D9//mLDIf47xsHsi7PoKgrelcV1y+2ohm+OLh1AcNa8Q
 1aiWG7512eUHk1FffdhzanN6PClTocYJuLUxTPATsg8hyt8YBgIk8A7wyi9feATFUOzbEAapJRb
 kgfraULxChMgPB4Q7jAaVcIKQa8PZWSgRr3lDVAo6gdvT+GV52TfLqnHzgyyxRv4iClVvN91Ocp
 MaDeOkV2+osZobhcRAaPd0ScZ9p+/q/ocdFmVlKnCTBes3lGIZo9SWm9R8Iwi2s4c1ZQt203Ksz
 YNEdSaqbIJVgl4KjAR1Qp3bWekmCbtOnvz0yTGGubXg1Rro+I84xcORYMRCyDIH4irQYd+zZNoe
 YoxxF2ocKc5YAI3sbCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180019
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


