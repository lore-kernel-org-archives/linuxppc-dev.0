Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743C7606A31A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rkbUZE6b
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jB3Tz2m5Xz2yFQ;
	Sat, 24 Oct 2026 00:17:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792761463;
	cv=none; b=iIlR0Q/sQTqyv7lwk030KBalQL3GRTvb6HAThZ6Xy/Tp/h89t3QVN7tIfgl8sPvgBg9cB8ju0HmQdwAGXRTLx8B7aNxhN6+iXgEtftys1SsZVMJZ8yCDu2OgKFBYJ6TnJIGr9wwt1hvDt+fPfxCDcmEr84Qw9OQOjtifMKIwowwtwkBf0BN/LQxg2QHW7PMu3iYcR+5bkHkra5NbefLaUQljzq1kUbhIUAqirtg7Nhc4DM/iiyH8pDCVuyHNUFjMGeNa/98DqUAhAh6A2HFzcpBttIhihOuZXFPDcJyJhC8RVMnww8BO5dWyXtGw8caggbgvZCoVqNGcN7m13P301A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792761463; c=relaxed/relaxed;
	bh=4INMN6jfyiWPWNdUFOTQaGKc6GvuhZz5CWDkHfXlFIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhdMHphoUqS8EmzuDZhitpHGO55cE37Ah0OZFBzzrYE/iXslrxzvi1EQTjc5L7QFDsm+AVUVvXk8DUPmy2e4QV94hJX3rsQ4GzMxHMRSEHM/vaw+BWzrA3qN8rz5nO9xP1UuDFOD7d5MH8aGnyG8TljSnqFhXqlTvdTo9VourrYHye5PpkfmYPjVNeSnt61OBwvmne2WXche2wbENuBBmI+z2c3VHHCIoPc/FcAf+LF5W3d3RVMVC6wJm/sDuGjQb1SpHySOSMDRP+s64lX0P/XXCmyKgQijnYC/px1nW1dT/2rJTVl3eEKeTdqKQUNIaPU0s4v53j2rdpfEkf8Dzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rkbUZE6b; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rkbUZE6b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jB3Ty4fxXz2yDr
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 00:17:42 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAF1ci947964;
	Fri, 23 Oct 2026 13:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4INMN6jfyiWPWNdUF
	OTQaGKc6GvuhZz5CWDkHfXlFIw=; b=rkbUZE6bZY3Q/lQEvrwpWrNXK3tYnthGX
	x8GJQMbd/8KduO9BGcpRVRLbOCzjTHSvf92NDTIvF4vcJKUcdLfHmdmaDfO3lTHo
	6vSi7nIke56GFiOR5lvU2Y5nI2Ga+9+CGc5XrntIhPRGM0g9HboPrqcKeqy13JcE
	yGifjlMsnjyryCPWWEqG/vMllfB86QA090eeJconOYkN0ZV97Hq0hjgQ/4Lk/DhU
	JRdnK74yBw9CIX5zWj575kjXfoLSVcUMioqAVl0bJjIbBCIrKrJU90aPH5wuginZ
	kUsPpScFbwILAiZUEM/UPGqL0z7lC2jbsxM0ez7fftTuuI/QtbjDA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5bweqy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 13:17:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAJwqb2010122;
	Fri, 23 Oct 2026 13:17:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfgck5khq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 13:17:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NDHDSH32440632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 13:17:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFAF620043;
	Fri, 23 Oct 2026 13:17:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D9852004D;
	Fri, 23 Oct 2026 13:17:08 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.19.68])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 13:17:08 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
        tim.c.chen@linux.intel.com
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com,
        kprateek.nayak@amd.com, yu.c.chen@intel.com, vineethr@linux.ibm.com,
        vincent.guittot@linaro.org, srikar@linux.ibm.com, npiggin@gmail.com,
        mpe@ellerman.id.au
Subject: [PATCH v2 4/4] Documentation/powerpc: Add details about llc_override
Date: Fri, 23 Oct 2026 18:46:46 +0530
Message-ID: <20261023131646.2907938-5-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: mYiWZWp3FE02QV-FPj1QhIanFZo5R5fE
X-Proofpoint-ORIG-GUID: EfNZofRMjBi8XQjEi0XnUdb7SCIFw-Uo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1MSBTYWx0ZWRfX/f3r3u0+F5PE
 jVxVTyf3siq6HDkkOFgfANlVwk7exnQJfmR8gbpcLs+izJ8uLkI8veV7s9tPZpjJNd+7yXeKGUU
 KWmdfCnGkX2Qe3i5RdDuGKP5vzP5mlA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1MSBTYWx0ZWRfXywBv6kLsNHRN
 3w4T8UY153BKIUzdzSdLrahFVf2oMMi1OLJLtW3qDQHD2tuJZUgB5MNhRClWhhh/7s926UFlJeL
 sq2Nayn6JdD7Ul5xs7A1Tn5o9y6UI6S3JoR7U5XZkndqD8AHx9Gug2FxUgodayURfVw7ITHNIee
 mpMJV+ot53UPbwObNGd63CF9/kaucg2X13PaQ2edh5AsoMeAmy/xRX7TtyxyAhc6e5BFqXrrFHq
 pe2tauvjzuWXsAz8DdsQrYtvZavCA0O+m1Ip60j68Q/vCowPWp38xtVkeXBtznYj+k8wHhYY/j6
 SSR0ZjJ5dF5iOed4EQP2CkZ+fqF81sh1TKj+jaTRxbnwMUQgHFxdaX1u1Um3JYZKKwZRZEi0DS5
 vd+13Iggt7LNdAL3WfITv3pMBgDhn0R6xszHaeHYEcvzd0uSG1OaGLUIMXeamuG6bEDpWhxusfL
 NntgxzW2LADX85h2ptA==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6adb5e5e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=EDzFc5kV9KizNyu6t7gA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230051
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Provide documentation for the newly introduced llc_override kernel
parameter.

This may help one if they want to experiment with cache aware
scheduling on powerpc.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fbee7b544903..e13514076c18 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3568,6 +3568,21 @@ Kernel parameters
 			Enable Live Update Orchestrator (LUO).
 			Default: off.
 
+	llc_override=	[PPC] Override the scheduler-visible LLC domain.
+			Format: { mc | pkg }
+
+			Use the specified topology domain as the LLC domain
+			for scheduler decisions. This is intended for
+			experimenting with Cache Aware Scheduling.
+
+			mc	Use the MC domain as the LLC domain.
+			pkg	Use the package domain as the LLC domain.
+
+			If unset, use the platform-provided LLC topology.
+
+			This is a debug option only. It does not change the
+			hardware cache topology.
+
 	lockd.nlm_grace_period=P  [NFS] Assign grace period.
 			Format: <integer>
 
-- 
2.52.0


