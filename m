Return-Path: <linuxppc-dev+bounces-28398-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDC7C9833F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 11:37:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htfSB6yZYz2xnn;
	Mon, 28 Sep 2026 21:37:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790595466;
	cv=none; b=GTc23Afui5pvsg1M9dTtH7yK8KInFCNEnf7iVvUcwQyLvz9nbrlMTqKpAp1pAYu6hTvwzPv0Wp0Zblh1ADfxPvfLp64s3DH4ZOKUkNakWyg8t53PziqoK/8x/HmYjddjxxW3W8zVPgmiv9rhCS/hW+0GKRzPI4lWZbpbt59RseZ5ZkEL9pkMqkvzTfb2cF5EEJmhMNBFhbGpJpj0TuqRmZbB0RXGFqKh6WltYxQ7BgFzubIWAVMP1N+zmlJMo3H8U8DNm2Am/QXCLTQhOVUCWoALrOL+RCv0hhCvvF/Nal6b79jDv6exdeLee7s58ZutEYQQLz+u+wkFwk23MzOAaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790595466; c=relaxed/relaxed;
	bh=2Y2UbgdV+77CAyq+MVK/R24FHgPjixP/AxA2RLOoCjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzcJtnIQy1cHY1xJ3cv2HfhyWXcz6Iu2zT1dPKWpQvfVWUWnRPbmm/mMn4Np2tsrIurBHrIxomFACqs5aQ+gwENGDWpemm01Ui7u0SsPvv66Ls8djL4r9Yff4yHNU9K+xaxXWnfkC4jAJW2lO/GkT09M2/PB0dJPcO6INJJZqfrf3+VKkki8i2TXBqbfAUUlx9G1vubOTRVojEUptz5G5NT/Jf01Koqs6GzIGSw0k2cMvkKegeLjxr6LOvFa9F0B7/vIQk+fM/jVOxhVzNH4NcLW9yNDxHN8roM6DOc4D8w8w7JMuFgX4spUP9DJzotPz7p8EE+x5y5PA/FbVCedRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=m7IGonwy; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=m7IGonwy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htfS974B7z2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 21:37:45 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBZL5g1046877;
	Mon, 28 Sep 2026 11:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2Y2Ubg
	dV+77CAyq+MVK/R24FHgPjixP/AxA2RLOoCjo=; b=m7IGonwyES9wg6efRrYqO+
	Y/5U1JPXD6olSDIm27+8dKJnhOR/KtNhk/kTQDEvhbgF058cYk4ZFf1aCF8VoXgk
	/lC7njLFQeR0ZbBlQZPBEuTTQkU+j8L8JB35/6r0tCpzbZtvBKRwNR8p+QS74RW6
	lWkX98uAYwaS+8LFZPv9B0gRRisgdd4BxBvoEEVz/Mwuaj4fCjd8mUIFg7UJrtMS
	DOFmC6RrveTuHGtFZ6iA2rcJdpqL+3jIVl5TomstYQN1YR58eYoq/krrEHqV1GZT
	mIDjrvhCfwEINbNkVp6Q642vly+gryh6TWoL/be0W39SWmOEtP6bAMPdGxBv0r7Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j512dk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 11:37:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBHZZD027148;
	Mon, 28 Sep 2026 11:37:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrw53cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 11:37:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SBbWGT37749046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 11:37:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6482F2004B;
	Mon, 28 Sep 2026 11:37:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 340DD2004D;
	Mon, 28 Sep 2026 11:37:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.213.32])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 11:37:27 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, kvm-ppc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gautam Menghani <gautam@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        R Nageswara Sastry <rnsastry@linux.ibm.com>,
        Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org,
        stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
Subject: [PATCH 3/3] KVM: PPC: Fix get_d_signext() 12-bit displacement for paired-single D-form
Date: Mon, 28 Sep 2026 17:07:03 +0530
Message-ID: <20260928113704.48912-3-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928113704.48912-1-amachhiw@linux.ibm.com>
References: <20260928113704.48912-1-amachhiw@linux.ibm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NiBTYWx0ZWRfX/MOTs3Llguyu
 8lEQDGU3D9fE0P0MhxdTbYle8UUMYXY6OfQWBdu0TnOQxqDqUX+v2EchqXa9CObCv5xknlReAGv
 FFhjQhLH4BklOmaMQL89aScZvzkYYoM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NiBTYWx0ZWRfX224YAvqYqJO0
 J6pkeblTR9R+LlLsGe0BfmetIq/PbT0j8Bi31+M+PF4Qwc+rgTGU4YNllpHiGCi8/5eNXbXyRaH
 YfqSVYm2rdjxlIDnQL3T06D5BSKJPXKrn5Liui+jVLmUlrH5hLLCSz6KMti0hQOYZInzmTo6RJ4
 ZMeqrpBAAMGwXwYdZpseWlmOaao5TuJVcTeSsdnEXDj2h903AM+kX9M3oJU16ZE9y+0zpPJptex
 ZyOYknbFVEq+IscUy+ieGiw52PLolqlUQdhYcmaEqIFu5Z1PZ6MNAlYlQMRW3vBP7C++T+ZMaQu
 Y0g/Y34MBFwPcOksW5Z7VC56+bRWVCoFodWx9MiBZ6QWWSOQlmSK7Nm12EhY6iqHcyLv2DZIavV
 3mJ0qsiqJrqZ4217ypvodQc7QXOqaBNkQGnalen6TRPNoI2LEcwm7MSHu0fQ/L/ELZJZ7zMYBzs
 agt6mvj0UMDjatlD+OA==
X-Proofpoint-GUID: pqXIfokhNYB0emqw9Etz4nDQZrzwDrdu
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6aba5181 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WFAfMJoNLMmZCboqhGUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: g4v4pUiGRhewosJFl5tvqQsS72aoWeGY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280046

get_d_signext() has two compounding bugs since its introduction in 2010:

1. The extraction mask 0x8FF silently drops bits 8-10 of the 12-bit D
   field (PPC ISA bits 21-23), corrupting any displacement that has any
   of those bits set.

2. The sign-magnitude idiom "-(d & 0x7ff)" is wrong for two's-complement:
   for D=0xFFC (encoding of -4) it returns -252 instead of -4.

Together these errors produce a wrong effective address for psq_l, psq_lu,
psq_st, and psq_stu whenever the displacement is negative or is a positive
value >= 0x100 with bits 8-10 set — essentially any real-world paired-
single stack-relative access.

The D field occupies the bottom 12 bits of the instruction word (confirmed
by the adjacent W and I extractions via inst_get_field(inst,16,16) and
inst_get_field(inst,17,19)). Replace the open-coded logic with the standard
sign_extend32(inst & 0xfff, 11), which correctly performs two's-complement
sign extension from 12 bits to 32 bits.

Fixes: 831317b605e7 ("KVM: PPC: Implement Paired Single emulation")
Cc: stable@vger.kernel.org
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_paired_singles.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_paired_singles.c b/arch/powerpc/kvm/book3s_paired_singles.c
index bc39c76c9d9f..532f96293de0 100644
--- a/arch/powerpc/kvm/book3s_paired_singles.c
+++ b/arch/powerpc/kvm/book3s_paired_singles.c
@@ -479,12 +479,7 @@ static bool kvmppc_inst_is_paired_single(struct kvm_vcpu *vcpu, u32 inst)
 
 static int get_d_signext(u32 inst)
 {
-	int d = inst & 0x8ff;
-
-	if (d & 0x800)
-		return -(d & 0x7ff);
-
-	return (d & 0x7ff);
+	return sign_extend32(inst & 0xfff, 11);
 }
 
 static int kvmppc_ps_three_in(struct kvm_vcpu *vcpu, bool rc,
-- 
2.54.0 (Apple Git-157)


