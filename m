Return-Path: <linuxppc-dev+bounces-22100-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48ABCD6E5D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 05:53:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWrGT72YPz2yR5;
	Fri, 05 Jun 2026 15:53:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780638833;
	cv=none; b=oKvndlXvjuTZypez4rX/9k677/cV8MAKvl5MSfffT4NaZafe/fSPI77+m6w7Vo3HwyJD+0kFNP5HWfBqnfUy04fVfgax8nYs7DJFZNFRckCNhSFb8Cr0dCcu2TNTMiacYhHf3oJFcMcTuqD0uCfNd6O6TxSDkY6MxK/jFek3LyG0xiqSHHNyFU0ep9B2yL3n3eltrn/XWcjnFVU+OTS/tRb1vvPPNuyX+olTbwRgFC3kZWsLDzMx35ayOxtSlJskrk2nm/muLZWHADWcvFWwa06T1HVQb5PTKllG3JB44f+ZpPXZfaunE8SmNaEwa5uYUxowEaZG04t3MX9E7JpRSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780638833; c=relaxed/relaxed;
	bh=QZLGJwS4lKbRFbdP1PzGvhzLA/XwdGktSGY1YKpGj3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b+UNkR21Lh8gCMMj0HVAbk8+xZ5wfQpqPOEDPTHmMS7xsmTprskjy4DKr6wYCRQoZ4RekOQ4OVbb5Wu7WbPqCcOxNp5TyIewzakrtF1Eq8/W9oS/cEdKLPMhdIbMtjcfJ1e7YdOTn0REwJ2Y8OBg2vJgw6NzhEpIXudl8VE9+l1DUpJm6VfHWZGzW+RdQa1TVaQuCvdk1a6p5wke+EMESlKWCQBQMI5tkR13lU6l04qKejMVF/A4tJR0P1RtXaPNl2TIxstWnC/SIU0zE2wS6funU5aWlIGC43PsOLipdpG8A5F6UIGO3F9JpL57Vx/2KKDh2Z/Ve5GPd6k+9eA/Pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DNWtM42G; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DNWtM42G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWrGS3BW0z2yNn;
	Fri, 05 Jun 2026 15:53:51 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654LAcHI2665536;
	Fri, 5 Jun 2026 05:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=QZLGJwS4lKbRFbdP1PzGvhzLA/XwdGktSGY1YKpGj
	3E=; b=DNWtM42Gxel3CCysr4Id5r50Ap50CL9hirBPgQmY/6iWDy3g2FOgnIfz+
	8rK4vxemb2ZOJnJJ9XDpUfHzNDtN2zqbjDSzmVXrzsG+BAhseROfeby5YNKYWUfy
	0hTb2g0aWMAtLwopXJFgEyMiMDwMPy87b8sGxtH+2aGoN/CuYDYOMmE8TdWJXQpB
	v2mlm1iQAxCS7Q8F7TbKsJwXDk5LnDoTUKjwTMCRRk1sMD25LyX6U2r99ljv0PIK
	djD+Fc/eh8vyf3Zmalow8JbgNOyHYoUGOKAP9JyXd9pL1Cql97ZVStfBVz3+jR2b
	yhKE65N2Svn+7u6lLPBZiHrPyvLSw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhtjc5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 05:53:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6555O59J001305;
	Fri, 5 Jun 2026 05:53:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwyr1du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 05:53:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6555ra3U43123100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 05:53:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35B1720043;
	Fri,  5 Jun 2026 05:53:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 871F720040;
	Fri,  5 Jun 2026 05:53:34 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.123.90.163])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jun 2026 05:53:34 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, skiboot@lists.ozlabs.org,
        arbab@linux.ibm.com, mahesh@linux.ibm.com, chleroy@kernel.org,
        Srikar Dronamraju <srikar@linux.ibm.com>
Subject: [PATCH v2 0/3] powerpc/numa: Enable coregroup support on PowerNV
Date: Fri,  5 Jun 2026 11:22:43 +0530
Message-ID: <20260605055242.1757485-5-srikar@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
X-Proofpoint-GUID: 0pVwiXXWisku7a6Vs9sRAtbY12Rb0ySw
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a226464 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ovkfszED7a6RniWwQ0gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA1MSBTYWx0ZWRfX9DzeWHzmUU/G
 lcJloMmVUH3tpBdKWy+YWT6/HLq45FNZyS0FsPlUwUJpOoKJOp//eujg9uqvxl+qcDGEAqvlup5
 GxXRSsV9KtYkHC6ROlFIVG622NkDwKpiIQGPK3Z3l3cgMtOJlzMF0o2GHpQ1SJYcL/vmYGaZ81a
 iurh8biN/itA1nEI63xVNdOZfr5gjquHf3Pb67i/t8SUK4AkYmQNAzVcYXp8iiblDLYFRoLw5+0
 XNcjRIzbKEfXJzLNLhDfQKymitHaFvBG6qXbuaErzBeCKKqIY2Ibp40xGYDnBexPA/H3R0cSbzh
 4VJy3PFwuAVZWE5XlQIreNzvCt931MJkMwo4+Dpoj/oaogOh6BNaCtb3w5KuZ6qHSHI4oSllD3Y
 AzXxMLnbqK8i60m/thxoBux+UvITB/6V/DxoGeLnqZs9fW3Cp7q6Ls6mA4klPxlfTVoaJBtQ8P4
 BHdjLXMU1wwKPL6B3vQ==
X-Proofpoint-ORIG-GUID: 0pVwiXXWisku7a6Vs9sRAtbY12Rb0ySw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050051

This series prepares cpu_to_coregroup_id() for broader use and enables
coregroup support on PowerNV when firmware exposes the required
associativity information.

The first patch cleans up find_primary_domain_index(). The second makes
cpu_to_coregroup_id() available outside PPC_SPLPAR while preserving the
existing fallback behavior. The final patch detects coregroup support
from the associativity hierarchy and uses it on PowerNV systems.

Changelog from v1: https://lkml.kernel.org/r/20260524010017.140408-1-srikar@linux.ibm.com
- Split into 3 patches
- Handle comments from Christophe Leroy

Srikar Dronamraju (3):
  powerpc/numa: Simplify find_primary_domain_index
  powerpc/numa: Allow cpu_to_coregroup_id without PPC_SPLPAR
  powerpc/numa: Support coregroup on PowerNV

 arch/powerpc/include/asm/topology.h | 15 +++--
 arch/powerpc/mm/numa.c              | 85 ++++++++++++++++++++++-------
 2 files changed, 71 insertions(+), 29 deletions(-)

-- 
2.43.0


