Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31781606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 01:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SlpmpBsg
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTkts1cyyz2xqv;
	Wed, 18 Nov 2026 12:45:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794966309;
	cv=none; b=gCFECqtu3Vz0i7dCGM/AkzxnshmRXpWSE6BOt+Irr6cFr73n6MZ19YjHYh3UPrALN+mB99kLdUCpcL2pCn5Hrfp0Ii3xhVe2OrDjhUNF3EFWDmzhOg4wou6hdlGJybMNTzQa0HhVDjFJMNGPny5sajHQSFjPvmzUXCOpnUpslNVmKv5d1B/8Ts7+SMtQfGt8ui0dTdR5Wwe9/5joKBJPlnv9zEYM4I/qH7WR/5uB/MNctpOAR8v+ZOc0ipbxpT5VMynRMeGoAeqXruzPzOhgUZE0J8CIKXhiland6g89xewwBQjjeg854Xup+dMJ5jiXqw67mWEp2/hYQggMBukcmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794966309; c=relaxed/relaxed;
	bh=wBd3abtayDCX1/scCG//Fqe+VkHX8eEt4tUfkgwFGdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OEWZFFsenZQnAq3YH/QywpRyxSWJLA6gNEST2WxJQe7JfzgTsHRgdhxkxP6AkOk/VUmktIG1YWi9mdp1cxRsSJPUVI74OJ50AfypETuwem4K2Jiw3Zb7rUbL+oDVO6bBhh9faTeQkEPGCWpelITnSNswtNaHWIs9aqdGOilJvYeXAaqy4VlG4YEWS/z9TmHPkuQiHwH8IiqU5V4JYrD7jL4Q7IUJKNpIJvo1TTHi7Rwjc9upDKvGW7Tl8ccFnv7hOjXcPpfWsYM7ubvsVZCQTnSBDGFIRvJfrfV/Ntd9E+BzpP59C0pzdBIi5unNf8eQ00YnR7nFdoMHtuZ09tVkBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SlpmpBsg; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SlpmpBsg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTktr1ggPz2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 12:45:08 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMvDSa3659438;
	Wed, 18 Nov 2026 01:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wBd3ab
	tayDCX1/scCG//Fqe+VkHX8eEt4tUfkgwFGdg=; b=SlpmpBsg/gInCg02C37n6B
	miSaDp44za3T0lTDZ4oCrZDaKcAAM9hlXeLAIEqBQSPTxFR9mVL5z97iFnxkTQan
	y3g0U/fv35QKpMu+xtf197CPjDmnZlLAqaK+njQmcMrq8wmfqLmeHx8tfbV2mtb4
	LC535umW7wCO9gCo2Yj49FdK8Sk8fNRH7+qeLWB/XW22ubkEZdqf9wpeftw8810R
	ioNAu07LGSyJZ/rUP4iZZ5i5CSGrZAuNt3cu/JlyTFBgSxOdVUUDynqP5V6ZMrpB
	oI2tlFwKOYgnYpBsxhegiNeBiaZf93T/aBA6jk8AcWNpxxUw3K+aGX82G+99agpA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vgcun-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:44:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMnxQJ1188940;
	Wed, 18 Nov 2026 01:44:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j02dffbp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:44:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI1ipRK49611238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 01:44:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D96172004B;
	Wed, 18 Nov 2026 01:44:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD73020040;
	Wed, 18 Nov 2026 01:44:48 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.63.250])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 01:44:48 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
        sshegde@linux.ibm.com, amachhiw@linux.ibm.com,
        Gautam Menghani <gautam@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Fixes for KVM HV around synchronization and initializations
Date: Wed, 18 Nov 2026 07:14:47 +0530
Message-ID: <179496619897.633156.4329278378485966847.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261012082922.218799-1-gautam@linux.ibm.com>
References: <20261012082922.218799-1-gautam@linux.ibm.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1IopNUmBuvQVeVZide_RQgkxDjw0FsYq
X-Authority-Analysis: v=2.4 cv=HL9WhYtv c=1 sm=1 tr=0 ts=6afd0318 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=lk0zUodt4WDNUAK1QE4A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: SzGNbwTHxbfT4gIPHJi6y05jDKmhSnmy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfX8ji+SSuEbngW
 3YVGTquMp+d2dn3dVz55WZUXlM0OEJ4e4CvKapJMXAEgrMOfPfdVJIRKF5IpBDn0a3X9BKp32TT
 EBKA76acqerEIjDV66GD/m4qOUHwqyCzJdDekCOZq/5JQM2+1Cx+XOCDaQFf0dssOTQx8bvUt/j
 JezHs4B4mmZBjwi2pKOl6zRDszsOdjSBBuDjsTR6Fsbt26ktT7YPmxu5k4BB1n5F7fhu1sxYdt0
 tKQzp2T7KZ/6BhMvlf1cxOsH01wjEkUutsMG6J2+6ayxvdlAJv0M6kzRfyy4vHz9P5xwjffwrkN
 n2E2W6QMHc13rIkypiHAt1H8NHXyJbVE9ej7vc8JoBhezt2/avwYL8rAt3NfhAHq/05uRQEjjSn
 RYPeZTDMbPXk0xqB6QTkJm2MmCHA/N/g8msJ1B13V8+bgL7mv7RHJaFYNuVQyDB49KkpUS2iSMD
 V5qBpk3HnKJUA9OdOhQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfX7wnjgTJvWwyr
 Kc5pDIfcixMjXrq/HpvKLjm4gVDqWvUAhWTBiiJ7mSd9t6rtTGq7yCRhQTr//or8ngnwPR6vlzV
 A+CCP0pob9HThS+EsxhGI2gr2K5NQXk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180005
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 12 Oct 2026 13:59:16 +0530, Gautam Menghani wrote:
> This series contains the fixes for synchronization and initializations
> bugs in the KVM HV code.
> 
> Patch 1: Fix for concurrent calls to idr_alloc
> 
> Patch 2: Initialize the arch.irq_type correctly for cleanup to work
> 
> [...]

Applied to powerpc/fixes.

[1/4] KVM: PPC: Book3S HV: Ensure that calls to idr_alloc are synchronized
      https://git.kernel.org/powerpc/c/d8c6ab0aeeca7cc2adfcf0ce1f796c6a86314ec0
[2/4] KVM: PPC: Book3S HV: XICS: Update irq_type for cleanup to work
      https://git.kernel.org/powerpc/c/b9d9a8741752c5b42c65b1c8dffba867889b74e5
[3/4] KVM: PPC: Book3S HV: XICS: Avoid NULL ptr deref in kvmppc_xive_cleanup_vcpu()
      https://git.kernel.org/powerpc/c/7279692d70f3e399b3dd2d07ffa365e9f533761f
[4/4] KVM: PPC: Book3S HV: Take SRCU read lock around kvmppc_h_page_init() call
      https://git.kernel.org/powerpc/c/b04be22bf6ea06b92bff7850328a8057b8d964ae

cheers

