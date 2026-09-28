Return-Path: <linuxppc-dev+bounces-28393-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F55CA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 11:04:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htdk55zDtz30YZ;
	Mon, 28 Sep 2026 21:04:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790593485;
	cv=none; b=U/wE/ID0zXDjvZ3AoYNqxrpDFLQ3F8regqfab7rUgv32CapmmDPpHCIX9ATs9rNy11NS8lAmNiqkq5iYe5MrS68gG4cQHku29K7eY8InQjpiEY/LowwoMJcxTFGzbj3qp7YulZP2U01ZKa4rI4w9bdLxOP3Yq8vsgGZNWO1tZ6Bx7DuxeMF3tDQe2G0yiE76hJuXJiv427Y0Sd/56gFlKLyQtsaNoBsFiIgBRJSXJmogsHwYew1Y9qpJh34Go+pEGXukHGw25UNpDj4DOyQnbEz3DM6S+jIqFjrqdHFeggpYBLWWeZCGaadxdLh9UUxFRhJCV5NwzdsrQm6D3ZibwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790593485; c=relaxed/relaxed;
	bh=FEqBa8xMDpGo83yoUduwxbh0X+wdQSkhwrLmg1SoHe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFfJ2utXs4WH0YL0rffC1jvLv8Zlax3q/dQCdH06KZA+Vff9I3KQ0M3FdLVSR7NoAdOl4mgND6KyukTMlKvJLBOxHYZMpvhpW9pzcs0zdaS+PqL678KBH9FiC5vjzY8VnWVZKyPTW4Msb8awcP9ioYMML6HK2VbkTovjaTv0I2OHortUUVbxbRFEC+82XqQI9re+u2yGztH7AmiXJQX3jiBfs5UvZyz69MDf8VVDDzoUKiXxs1mxr0zR9GZM53Q9yfZyXrgxMYm9o2aEYAnAJ6Y9ECrMbLfB+OPa73+0AWcSYDWM12WmhtsA+5S+tlVq8GTOVWR0DCzb3XEPUklRtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AyOiNBBe; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AyOiNBBe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htdk50bCRz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 21:04:44 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S9ZMeb3129483;
	Mon, 28 Sep 2026 11:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FEqBa8xMDpGo83yoU
	duwxbh0X+wdQSkhwrLmg1SoHe4=; b=AyOiNBBeXou7GIAnLNzI+vplC32zwYu8e
	d3FPgYxpCetPg+fSAdoDPF640JmSmqmm2sO1UW5Iku6wN2jhqHfVj4gvd7LY81Ix
	+8PWanSXwfh/dtR77i5q7n3nOCpuY0Zisfg+mn9DvDdbLgszIi+EkoYF5atTIbPE
	usrIUO+xyQLl7oe7avTRa7wYaVYdRbxgi+55huuKICHx+Cr5m1J2PjzNRs0pEjzf
	X+/SSpuyOI8K/iaaY2vH30FyVTYKhIclYCNkKVnMn43UnzQGu0trav7oZ3BFCfOv
	wEFcS4eGCAd4M7+hErEAkLzRn72PuFJF8AibyHdRm4pJpsoaQeskg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr0ugd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 11:04:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S9HVQM4087015;
	Mon, 28 Sep 2026 11:04:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrw505h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 11:04:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SB4ScG16843226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 11:04:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57A4120040;
	Mon, 28 Sep 2026 11:04:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B86212004B;
	Mon, 28 Sep 2026 11:04:24 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.213.68])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 11:04:24 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        msuchanek@suse.de, ritesh.list@gmail.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
        nnmlinux@linux.ibm.com
Subject: [PATCH 1/2] KVM: PPC: BookE: Disable preemption before loading guest FP and Altivec
Date: Mon, 28 Sep 2026 16:34:10 +0530
Message-ID: <20260928110411.844582-2-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928110411.844582-1-sshegde@linux.ibm.com>
References: <20260928110411.844582-1-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfXzwW1fwGEQATp
 jIfWTcrMoVGWu0XA1gebhRhniT+KAy8HDbjYx+V4oN6dO9Qy2II+P+t+E4CNXuPcIUjkRXezJao
 Nh3ug4tIfm1KEuA1GqLXHYnpOejzAhRTOnFBdIB1JOC0PeoEeCAmudNdKmz1RhOTyKKe7BeioLg
 chPIbB1S/QhOg59DNd7XV5nruae2rcb5S37+wXw0Bnom8teX8I8dUmtPFvpxGpscgFkr6RMIatz
 WDncGXy5DBfioblNPcuYZZu6WHp3Bfs1xIc3N5Eb2YT4H/fgMYmXc3HIritSTvfKWgW3B7SU5k5
 BIQ7uGvDB6wZls5eH16YxpfCfulVJfsO5zjesIxOxin43Zd5pCLtQgAtm5elz9CgylSw8EYoLgc
 sLtilXetqgQIf+depV7LcJp/O5kvDpbGUNh2wbNfnZB515YcONi8zhiIuhHYvSqOOUENbTrIgaG
 pXMqHUbRvp5lzF5bgaA==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6aba49c2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=hyHdCrymTFJ9VBfVSMoA:9
X-Proofpoint-ORIG-GUID: roiYrB_Vfbv0I-xrszSlRTDWQ2JuNt1h
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfXyYkzLY/7xlUX
 nb3lGgc5Fr4d8Kpkk+lmQK6mDrXKzqr7WSy8iwR8ukFvtB5NTu+jGmPMritPhlqzLzmkVOXss//
 damALff0ZDlNvtKKIDj3cughHzLuxfU=
X-Proofpoint-GUID: agCYMxc9amh6QoWyypxXJAdT0yCxV7s4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280042

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

Fix it by disabling the preemption using the preempt disable.
Note, it is calling noresched variant of preempt enable, since hard
irq are disabled. It is likely not a good idea to call schedule.

Fixes: 3efc7da61f6c ("KVM: PPC: Book3E: Increase FPU laziness")
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Closes: https://lore.kernel.org/all/33342fbf-eb7b-bde6-2c8c-254fe8bfb993@xenosoft.de/
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/kvm/booke.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 13ad4cf5fa71..5b9118eefe1d 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1404,10 +1404,17 @@ int kvmppc_handle_exit(struct kvm_vcpu *vcpu, unsigned int exit_nr)
 		if (s <= 0)
 			r = (s << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
 		else {
-			/* interrupts now hard-disabled */
+			/*
+			 * kvmppc_fix_ee_before_entry() marks the software
+			 * IRQ state enabled while interrupts are still
+			 * hard-disabled. So disable preemption while loading
+			 * guest FP and Altivec.
+			 */
 			kvmppc_fix_ee_before_entry();
+			preempt_disable();
 			kvmppc_load_guest_fp(vcpu);
 			kvmppc_load_guest_altivec(vcpu);
+			preempt_enable_no_resched();
 		}
 	}
 
-- 
2.52.0


