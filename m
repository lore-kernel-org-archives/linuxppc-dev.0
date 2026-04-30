Return-Path: <linuxppc-dev+bounces-20338-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F5EFF886F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 05:51:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5jvp16gWz2xm1;
	Thu, 30 Apr 2026 15:51:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777528262;
	cv=none; b=QSsLED8esafVdzak5+UGtooQi1tgNx+0CZSzN3UnlLot09+uSaP0wedK1Y6OsAQqQn7mYqWu29cQi44uApK9nEL2iGQJdG0XHju452QzLp3fdkGc7qRpArn5xQvjBKG1cYAArq5C4hXlCG8MlpRC77KNzeAvJIu2+uYWCZW/cZhKmLS1wY8HP7D61XLRAX77u2QGM30S/BtUeNjlZsQLTiViM7/FyV0Dp9Q9DkzNR2muwU4D4Sa00LaepqTjjFKfxTuIQQeculqG/pFieZS8p9mNmk4p+wr1I+FSvkikdLxWHq8lqg0f60cEx1Kubw1StbJHWuyRMEZgjUfsdGxNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777528262; c=relaxed/relaxed;
	bh=A+TFab3TxBuckPuodX7Yxrhrp4K3N57dRmZphKt1Eog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jb385mYUt1yG6gRdtthyfjM44C90+1c1T86geRqqhK4GNyWVvBPBqERk+KdTQ3WYgnaCWd013WSSK5hEqHHR8H9WbSHeu5MMF592dMhWg67IQvWuiFVeG6E7+XO0Drp69bs/SvUg8k6t3P6RPJMw6j5oyuTBMi5LxdqSKGKGS5yA3JEF7lrm9CBBC0f7PbdxDshQQRrwkKNZc+7Vv9cjt2cyzx/XuPGxKVl4wo0rZljhzb7vJJ/SR+4nwKE5ExTtuQ51BHoC+HNtcZCwQtWq/mERW4nupvA1piaZ86NoR/f10okpnp0T9ZhvNRtjuyNXbyfGv6PX9QibXbfO89JcVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mkvZF/tZ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mkvZF/tZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5jvn3nLcz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 15:51:01 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U3nlGN4169201;
	Thu, 30 Apr 2026 05:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=A+TFab3TxBuckPuod
	X7Yxrhrp4K3N57dRmZphKt1Eog=; b=mkvZF/tZ9H1ZcDPBQw8C1FYMVoFP9PfLZ
	Gm9aAcX2/YFNgJ+kijTkDJIimLxaico8pF+wtq+PZa2pl18cH3O2QJK+uBjxsRht
	vFNqse3ClGn/u3ZcMSPZgpJxqural0/MbITnOTjVbt+0tbmbGby2hhngUL+eWCcs
	iduXJ7JbsoKb+1Q9BXB7rS2LA4mMpBXY/56IzMZLIhohGeTB8/PntmcX4nnH7j1c
	8Ev3EiDZBQJBG7CwszxKV+wp3i5MqqQKKWaWYX6MyxM3XmH5ADO8BiRyEie551En
	2Zq4Z9sVQ0GtnNjB2eJNzzYjojeISrEL/zOmKJ6x/ZCjAZITYXQwQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1e4fej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 05:50:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63U5dF2N026090;
	Thu, 30 Apr 2026 05:50:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8aw1nse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 05:50:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63U5osal51511636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 05:50:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B41D82004B;
	Thu, 30 Apr 2026 05:50:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44F4920043;
	Thu, 30 Apr 2026 05:50:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.18.70])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 05:50:50 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 6/6] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
Date: Thu, 30 Apr 2026 11:19:05 +0530
Message-ID: <20260430054906.94431-7-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260430054906.94431-1-amachhiw@linux.ibm.com>
References: <20260430054906.94431-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: PY1Pk5C2qoENucOkMV8Y5LISX-Mrjos1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA1NSBTYWx0ZWRfXxz0Q8GlnGWtM
 EACpotdoO0dzuIwZvB9q10VwKgpegGJshExny1JYwCH1ruDGf/ku8UOJR+tl0C+xRVNWanTlsXY
 fXUihCv6bXer8gOgw0UcxNbbmZjIFgAxVPRAXJwd0igKe1K6BclAwXj0AXFJ8wf7JSAPXeUCbvQ
 1zl2CBCsk8xGI+5WF9uFhNbyuPlbdFWv7QGhoR1mm203pd/1R6qyoA6YNTjsjSwwtVfxBMtT0pd
 s2wt73DrID/95Z456Xc4BsxdAqnEHSJ7U9zZuG/kpZROIHFFDvETBcU9xYDP2abrUEYzYy1P63p
 kkjWF/5Shwi9Q3hqySQ12oh6BHNqfoYSCFC3pQsyD6TfqmDj1NbvuNEBJWVUYstsCDlSB4nx+zw
 g7MAWXZKl0nbR9kFJv5sd/CBlSZmuWMm+hzgSgZJ/bEOnE0CB/TsDcTkcjrwQjfOs+AcTi5cFEI
 ZI9N0NdjjPfRymOZu8w==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f2edc3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=fHGwRvExhQHp1Ic8jzwA:9
X-Proofpoint-GUID: PY1Pk5C2qoENucOkMV8Y5LISX-Mrjos1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300055

Add documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl to the KVM API
documentation.

The ioctl exposes host processor compatibility modes supported for
nested KVM guests on PowerPC systems.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 Documentation/virt/kvm/api.rst | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 52bbbb553ce1..7a10c3c6cbf1 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6555,6 +6555,41 @@ KVM_S390_KEYOP_SSKE
 
 .. _kvm_run:
 
+4.145 KVM_PPC_GET_COMPAT_CAPS
+-----------------------------
+:Capability: KVM_CAP_PPC_COMPAT_CAPS
+:Architectures: powerpc
+:Type: vm ioctl
+:Parameters: struct kvm_ppc_compat_caps (out)
+:Returns:
+	0 on successful completion,
+	-EFAULT if ``struct kvm_ppc_compat_caps`` cannot be written
+
+IBM POWER system server-based processors provide a compatibility mode feature
+where an Nth generation processor can operate in modes consistent with earlier
+generations such as (N-1) and (N-2).
+
+This ioctl provides userspace with information about the CPU compatibility modes
+supported by the current host processor for booting the nested KVM guests on
+PowerNV (KVM nested APIv1) and PowerVM (KVM nested APIv2) platforms.
+
+::
+
+  struct kvm_ppc_compat_caps {
+         __u32   flags;
+         __u64   compat_capabilities;    /* Capabilities supported by the host */
+  };
+
+The ``compat_capabilities`` bit field describes the processor compatibility
+modes supported by the host. For example, the following bits indicate support
+for specific processor modes.
+
+::
+
+ bit 1: KVM guests can run in Power9 processor mode
+ bit 2: KVM guests can run in Power10 processor mode
+ bit 3: KVM guests can run in Power11 processor mode
+
 5. The kvm_run structure
 ========================
 
-- 
2.50.1


