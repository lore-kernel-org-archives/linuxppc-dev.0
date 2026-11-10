Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF09C606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 05:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MwbDZu3s
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNwKh60GMz30Vv;
	Tue, 10 Nov 2026 16:33:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794288792;
	cv=none; b=h3NPKiyoE8xkcHf1n+4pKGPrQJmx8E+UqoeFXKVA8Gg019OJN/fDfj/g8gPP1BIEv9V6F5I9pmMi9awiE5xDogkttqAM2T79yDFhiH9HWa1v5lDo2GGB6lUNAGuXLPBwkRFpjDGQ8si0cKZelOTQC6tK6zE4eTpEbMTdjoppRuEftA91hKu0sL77fT6WoHZ3ERYnVKBmdkiWXwJnz7fCj7KIJYu6j1y0gv8dRQaan55+puFWzd/wRJY4vUJP4LUVI7MMhiYgeFRSfVhg3ESik/zu8N8lj0fg5N3tCeTth2EB5x7QT52aXJGajL5tXTYXkPNmt6MZfVXmWPwT5t+uXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794288792; c=relaxed/relaxed;
	bh=8x57gFet6/+tWb3KFj2DhF//Y8ZmfPHDcI2Qs+r2VFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsnDz12PUSY4rqSKZsqc9/1KB9mAXVLXizypYc/TL1fBd4exUubOg8W804RhPoytGvQV3vp2EQzw7dBRJdpgxtsefME1h9yS/bmdM+JaSggRG2sRkNVuub6fz5VelD2j/YRNQJIwZ5vTwAAZSIwRebqoVqUbqySXsXyYy7mO22jh8BbyND9ru03rw1zYiZI4vWjplKTvrNVexKJebbcJWDDCEVlZMXB7ZMeZUq/MK1JV58mc9QqZS1KdkPBs8eLt7Pfl+6Q7UQUfm3HBpEQtI5wnb1CuLXzSgBCa6UZMbuZqhSEnk2WC5hXjQ2KDbGBzYHQf0Xo9Os7OWkmbrfyVRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MwbDZu3s; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MwbDZu3s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNwKh0S9Pz2xf8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 16:33:11 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA51ngX1439462;
	Tue, 10 Nov 2026 05:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8x57gFet6/+tWb3KF
	j2DhF//Y8ZmfPHDcI2Qs+r2VFE=; b=MwbDZu3s9J2cFAWAt8z7fhUH65uUQ6L7s
	777ywdebm9aHAhmeIuD2sU8E1pd5JTqrz907dwPfbbuJS/QwsvDcUGXwc3bWHG4J
	pjb65qrYJI2wLpTTGo+p2YxXcMJqCcDBhwe8ME7K4ksl6+lHcJf8rrrwbTZAHf77
	GZatqfBTaoW61xnhocZyZMRwgJFC42BbXGAbOKxOM84P+0LPq/Frw0f4umTI34/s
	m1zb5rOsv9GjofDqqziRBuIa3tTwL1a2xiXuXJd/QqB78ARzUlJ6LoTM3dga6AHc
	Of4q7+7sFW/ScB2aBx7qDwSMx5ciOmqu55chOc/w3leSKSW9Nsoug==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumutpcv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 05:33:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA4JvT9099324;
	Tue, 10 Nov 2026 05:33:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4htghg50s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 05:33:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AA5Wvj526673526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 05:32:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C2B220043;
	Tue, 10 Nov 2026 05:32:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F6D820040;
	Tue, 10 Nov 2026 05:32:53 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.31.82])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 05:32:53 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        msuchanek@suse.de, ritesh.list@gmail.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
        nnmlinux@linux.ibm.com, mkchauras@gmail.com
Subject: [PATCH v2 2/3] KVM: PPC: BookE: Load FP and Altivec before enabling the interrupts
Date: Tue, 10 Nov 2026 11:02:37 +0530
Message-ID: <20261110053238.3794500-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110053238.3794500-1-sshegde@linux.ibm.com>
References: <20261110053238.3794500-1-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAyMCBTYWx0ZWRfX/2snh2rH6eg3
 /GNv8TW/QsuLxVxZOEDMZPz5nR5xJN5aiy7ZI4C9N8J+jASsm9m+Cjk/JSNGCKjlst9YS+DVZhz
 gPzwrkTXWuo1QAHKfyf5h79oCvq9RJU=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af2ac8e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=hyHdCrymTFJ9VBfVSMoA:9
X-Proofpoint-GUID: FgHVbOLvQ-vFJbTOczteiV_DomMrv8zN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAyMCBTYWx0ZWRfX+rBVsdm617DR
 lBAWrl64WUFwBX8dbRe+0ZxUuiQRswZFEUd2TXfBZDu9sbo6ZAwqJn3FUzHQzqVoo/OBXwWHvQG
 9E2ET9/qVdbYepQHPYgfFUGVT7R4CyJoiR9otMTtH9BGghR1qGfqjrxEbVxyfVhkng8JFdhmcUh
 lmY5b89TA900CoNX9O1pZu9slufdQI1GMXP10SbmDJTWJl1cQlETJv2Y8Uh0mEmji2XmwrApvCK
 h+efOU0Sfy3FSxPx3z8GuKrw6UAn6Yea/o2JCb/STPUwsx0LrfloQ6iKVk6YhFmik8kgXFiF/u4
 igrM5W4lQ1nhneTALqBrsyNAZlPKSKIsOEKwBdV7nylzKtNXfK5e3cWr0SpFVa6lq85wjdpqpa6
 9b5dw7IdpDD6e5L+GjgRgx98myEA7b0k8+/hJKXklg8Pw+ZdRFKAe9pPLFS9RLtVjpiZKoJgCHH
 JiALmr0efX6KEqVgeBw==
X-Proofpoint-ORIG-GUID: Bq0N-D7jXvQRn0b9NXnCbVLHnLI2XM6U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100020
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

Fixes: 3efc7da61f6c ("KVM: PPC: Book3E: Increase FPU laziness")
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Closes: https://lore.kernel.org/all/33342fbf-eb7b-bde6-2c8c-254fe8bfb993@xenosoft.de/
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/kvm/booke.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 13ad4cf5fa71..c35e98d544ec 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1404,10 +1404,13 @@ int kvmppc_handle_exit(struct kvm_vcpu *vcpu, unsigned int exit_nr)
 		if (s <= 0)
 			r = (s << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
 		else {
-			/* interrupts now hard-disabled */
-			kvmppc_fix_ee_before_entry();
+			/*
+			 * Interrupts are still hard disabled and soft enabled
+			 * after loading the FP and Altivec.
+			 */
 			kvmppc_load_guest_fp(vcpu);
 			kvmppc_load_guest_altivec(vcpu);
+			kvmppc_fix_ee_before_entry();
 		}
 	}
 
-- 
2.52.0


