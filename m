Return-Path: <linuxppc-dev+bounces-29091-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C87FCA6019
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 12:31:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1R6Z2tr0z3048;
	Fri, 09 Oct 2026 23:31:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791549062;
	cv=none; b=Nke8RDNmwg2SPbGDl6mPD2UtVp9oQ0WvILREsRul9oD29MiQUIsLxnEogzOMOJ3kPMbBKBi5vDM5OPmbe9fl4dlauZslMiA7/fUNyf5ZxaxfInNAZqtbshaVRZG9CkEBs1OlV2o3VdrALuL+mccggdmH5/VVB68Ukl7RocXteSXMG7dowlYIpgBLog/thZcZ/AsOT9dtoOjnKx3qkrq/PEMYg2t/q06Cm0Z3CAnmhZ8e9tCVAlV7ZSo10St3x8NQjx06UFQdSvuhSMvuAKflg/IsxV1LzTG9NVYEVcsqE9qBKBDzI74K7XMuayuT2va7VDlva+1d0tjlkR83uyUwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791549062; c=relaxed/relaxed;
	bh=se1fv/0zrPyOXWXtWvXAy03KKez6Xd0Xw9Bw4k4HAjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FbIK5RWdMV4C42lxliRB2ea/6up6Vl1MwwAoEE7a79gGQ3QDz7J4VJUvTcOxsd0NduNCNuHE60yDx1pw+ZhizZ+jswHS6sni4H/P8bLcZtngB9IdZnw1+akGf1w1RumHKYgA6bf44BhWxZBnfteY/q7gCKO6VT4hmJFB1cC+MEzh2YRhUIS7wGG2o+Zo7JxCoiY41BHrHtetp19uFFpn/diiC0zML1M7KxpV3KzQnn67/Uq/S/fI4lJzxBNLVBn+oOpewhxuumUkM1NpejoP/yeuv7bf3mgD1uFetPgiR3EkF/kfousIGDMKjCCCH469/+XvwLVmZbUx7mPo4olvVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AASq1Mtb; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AASq1Mtb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1R6Y41wJz2yTH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 23:31:01 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998ZUbv3666265;
	Fri, 9 Oct 2026 12:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=se1fv/0zrPyOXWXtWvXAy03KKez6Xd0Xw9Bw4k4HA
	jQ=; b=AASq1Mtb6RgpATjFFdBz4HoQ7WJEDkrCpfKcOuOky8UJzTG2ap829znVc
	OFprN0fs+/YTR7DmnYwbaGEQtLrad/XiWNoaeE+m4CEG3LmaqNEoJOyppUODD8P7
	QElUmLGmFveZ8vihjcNJ99KiZt27iw8h3gPptzGE+kuV2x0J55GkXFpnu/Y5fMMy
	a9rz+4AEi07Akqgi3LF3kLJVJYabkl7/Z3WQ6DHp1f1M6S8Fur2PP5G6k6kU0OmD
	/tqP6e/8UvtJf4sDcZRK0Hk9yYNdxLUSkxTEKA274RZj+/FUTIbMa76IYH8kJvQ8
	8DpaWPNZxDzGUYZw5o9IFsqld9SUg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw9wx0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 12:30:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6999sSlQ724275;
	Fri, 9 Oct 2026 12:30:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h6x1y8gpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 12:30:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699CUhGm17826052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 12:30:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C0A920040;
	Fri,  9 Oct 2026 12:30:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 851DE2004B;
	Fri,  9 Oct 2026 12:30:40 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibmuc.com (unknown [9.39.27.243])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 12:30:40 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Fixes for KVM HV around synchronization and initializations
Date: Fri,  9 Oct 2026 18:00:29 +0530
Message-ID: <20261009123035.157770-1-gautam@linux.ibm.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0OCBTYWx0ZWRfX2BAg0WJBSOSp
 /b9G67FepRJqpKcnUOzQgnBVS2jDliPMZiNTVM81PBNsf+JtzH9BnswhJ+QvqBR1LJ5qJOq78YC
 LU+99sV0R89eybH7FDIdvu8hybx/zi8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0OCBTYWx0ZWRfX53FcjSiun0+W
 ai/sA29Wu5JXp9fF11pgR5I5z/OL/dHQbxEST0MvXGF81Wu7lNBNfhsb2Vrt1zGn3fY450hEkdQ
 xXgYtTLkYncqYO3Ft5l2C39bvZUyt9adWATwffKtDCH6bCTD4mTgYmcxgPMgDwCcqeID50bZT+m
 NVtQ+qnkbDCssNF7s+Ov8vguIbrmY6w5MQOEBmC77V2jaY1Iz1/FhPbYP7dpZGIXQ6ybFVvxIKe
 nivQOmX1b4PjPt6eJY8ALP7uRnYyEoDio8BLRhGL6Y/n3ri1bhu3KV1Yi/Cn34ATVCdpRrIlAYB
 1WkFckIp3GVu9d3517QEw5wHpdEtH2x/f3Kd2/rNIaEPZgYrJiu1S+eAFH2PbT7yVE3ePgJlCsY
 euFADd+u9p4r9gBe4A/uKBO8c2dEsETcpxn4tfdUgxq/0sxwf3CMritHyBW9K0OEPpxdhyuKWBP
 nBp0H2D/TAhd8zuZNwA==
X-Proofpoint-GUID: s7n4stqpeOyKnC2vdPMLbwJgZwd-PuZ6
X-Proofpoint-ORIG-GUID: 5vPQOMual2lPFAUoaZ60g1h8UxgOaoes
X-Authority-Analysis: v=2.4 cv=XcwcX455 c=1 sm=1 tr=0 ts=6ac8de7a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=3shF3zVF4xkQSgwXEr4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090048

This series contains the fixes for synchronization and initializations
bugs in the KVM HV code.

Patch 1: Fix for concurrent calls to idr_alloc

Patch 2: Initialize the arch.irq_type correctly for cleanup to work

Patch 3: In the cleanup function, add a check to avoid NULL ptr
dereference.

Patch 4: Add a srcu lock to fix "suspicious usage of
         rcu_dereference_check" usage.

v1 -> v2:
1. Avoid NULL pointer dereference when calling
kvmppc_xive_cleanup_vcpu(). Split this in a separate patch (patch 3)

Gautam Menghani (4):
  KVM: PPC: Book3S HV: Ensure that calls to idr_alloc are synchronized
  KVM: PPC: Book3S HV: XICS: Update irq_type for cleanup to work
  KVM: PPC: Book3S HV: XICS: Avoid masking VP IPI on init failure
  KVM: PPC: Book3s HV: Take SRCU read lock around kvmppc_h_page_init()
    call

 arch/powerpc/kvm/book3s_hv.c        |  2 ++
 arch/powerpc/kvm/book3s_hv_nested.c | 34 +++++++++--------------------
 arch/powerpc/kvm/book3s_xive.c      |  5 +++--
 3 files changed, 15 insertions(+), 26 deletions(-)

-- 
2.55.0


