Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32995606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DvgzvCWI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZqqT5m2Cz2yDc;
	Thu, 26 Nov 2026 19:44:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795682693;
	cv=none; b=DA4vs/2Ov1JjAPnksF+Tk6d9RpP8XTzbUSL3pfx9P5YnKTrl19DBUU6NdLNkIPA712hPGUrlyDilaBG3vcvpMK+QhiGW3v5/wFTRAUl1O6Mjn+iUMBAiwHPWqJd46YA1dp8o7LU1zwmKal5IRhAlNx+ydS/njnS87Hd24gV65EuLkvEOwG+c9FFWsQ6RVQVCO2SJOcZPACFOpQKbt7TMhq5B3mNXmKdwgR/VFx51nlkGKz3TZ20sfsDA6Blpr/ZcfIDX182IEasaBd9JwpVECBP5OhwHl9oSlvVXlfrffRVlRET3Wpmk2PQlCOWPcjqz2J62Q1t3FZIquLFtTc+9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795682693; c=relaxed/relaxed;
	bh=cbifB8fuc30PkqRHHmUwpEMqOf54sxwJdMhH+DVQhi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LpF+9J9fRRsU+RVg6S0abv2h79Voqd+WVJhtM6To+aQU/SmpqG2VQXkvcMdxmHToBs+8uShYqTPjFfGV6mJlmBeF71DQAucR3Wb/Jkm/bNvkBdBrg5+WWWHu41CY9wZuDHwnEcNiypAHthe5T7xlUk0SjZK4/1aGekLKGyEy3Q2oNZ6egz9vVxVIQ7nx9E9nOYaFEL7AcyNjg+9Mb9BrI7QG82C4/MGeRonci7iJGeVS+/zuDC1Y0BLQrrQK2d0sEfJfD5qclBaEYKFAlFUtC0d/HdTbr6uxBGEWkWG0Z9dNv5BVs4IFm4qn2l8usu9SBxUx4StHCIrZ9mnbmCKB6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DvgzvCWI; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DvgzvCWI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZqqT06tvz2xns
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 19:44:52 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7YsN13849127;
	Thu, 26 Nov 2026 08:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=cbifB8fuc30PkqRHHmUwpEMqOf54sxwJdMhH+DVQh
	i4=; b=DvgzvCWIqZ/Yvxl1QJ2TgCWjKPjICSW46ncV9fPhjyxiMsDAm+k1GkerU
	LFMIm20b2qy3CZP3X+cimKKptRaxy76xbOLZk9JfHPLrGFbmD1WmGI0BLovFkyoX
	6Gj5ESGp0CsSTcFSl9rNhnDxtNzcE/SpXqTAHYT4YqtbT3uEx2FOcXllVAdQz+W+
	/PnKJqlCodMzAatGPWdWgsFovyln0QMSFb/bX2mEZenIUW85u4+8G+4FhZM9ejU4
	QmeFtI7X8iPv+PLHBVotsVD2Il35kuiA1iXJGSLuQwAChedqSYTfqRVrqLF96f5B
	tqtzLtRhQCVRTV2RYGWoAVi7yDSgQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fagh21-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 08:44:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7JSq61900574;
	Thu, 26 Nov 2026 08:44:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5axky8nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 08:44:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AQ8iPmv29426272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Nov 2026 08:44:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E91D2004D;
	Thu, 26 Nov 2026 08:44:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF13420040;
	Thu, 26 Nov 2026 08:44:22 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.4.64])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Nov 2026 08:44:22 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <chleroy@kernel.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Narayana Murty N <nnmlinux@linux.ibm.com>,
        linux-kernel@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
Subject: [PATCH v2 0/3] KVM: PPC: Book3S: Protect TCE IOMMU table walks with RCU
Date: Thu, 26 Nov 2026 14:13:52 +0530
Message-ID: <20261126084351.32375-5-nnmlinux@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfX+Gqu5TIvmIHq
 wYmpX5QaczZ4nQPKNhtaI5wSL5eTrsGIEtq8T4nKZN5VtLV6GMSSTrPNsNx6G8TwEsCKal6V6vj
 e7D/JBsyP7+hD0DgZ2fJwTPmRWF8jXhKyLobr034+xZmncMNDbhYhtHR4U2JBxIywapWKXm6K8/
 ySqlcGMpsWiH7mLr5Z4RXjhUtRFlQIusFbfH6pTAbSIa6tqlhu52JCZNUrBXPgdxAGdTRLrr7K6
 UfltGHbzlT2UCkGW33fEJ1aooZSflwZD2KhJcLBMBJleD8eZfk4qPDrVmZ+zSe8Q/sSu8TyzSkH
 YWzdVEeRRjBIFhfuEhDsuLZutlI7G/Q3POO/ZmE8NlL6cdhhNZK4oNa6ow1z+czuIgcIA3MFDao
 oR94N7W+ura0DsPxk4tsgy4sKj+3cQTyK9g931F2Pma63ICl/Vf8wuFo140cdv6XVN4/7sMn93M
 GXZvrWqtCrNVUd9zrQA==
X-Proofpoint-ORIG-GUID: uNuE4I_lUnExa2iZYZi38qLpH2BNBbTt
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b07f16e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1MgcrAwz64_Jl8qLJtcA:9
X-Proofpoint-GUID: 4EmihsMDuGt5CGMz5zXcXUnD7skmR9eB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfX4n+Q2jaG4HQb
 z5Zk8TY9R1eHMyh3z2hvkYEj4crjnPf/TExA/bCjR8JPrI9OPdVIHJvfW8QB6PpPUg2yRhHPRZq
 PCzWj6PVv+H3nH9LpfCyIzjd6+lDK8A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611260033
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The sPAPR TCE hypercalls run in preemptible virtual mode and may race
with concurrent TCE table fd release or VFIO IOMMU group detachment.

This series addresses the parent TCE table lifetime, synchronizes IOMMU
table access with detach, and ensures safe child-table reclamation.

Changes log:
v1:
  - Revisited the Fixes tag for IOMMU table traversal and 
    used 121f80ba68f1.(Ritesh Harjani) 
  - Added parent TCE table reference counting and SRCU
    synchronization with fd release.
  - Added SRCU-protected child-table traversal and synchronization
    with VFIO detach.
  - Added SRCU-aware reclamation to prevent child-table
    use-after-free.
  - The partial IOMMU mapping rollback issue will be addressed
    in a separate follow-up patch.(Sashiko Review)

Narayana Murty N (3):
  KVM: PPC: Book3S: Hold a reference to sPAPR TCE tables during hcalls
  KVM: PPC: Book3S: Synchronize TCE hcalls with IOMMU table detach
  KVM: PPC: Book3S: Free child IOMMU tables after an SRCU grace period

 arch/powerpc/include/asm/kvm_host.h |   2 +
 arch/powerpc/kvm/book3s_64_vio.c    | 179 +++++++++++++++++++++-------
 2 files changed, 141 insertions(+), 40 deletions(-)

-- 
2.54.0


