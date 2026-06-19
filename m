Return-Path: <linuxppc-dev+bounces-22836-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919E3CD98F2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 22:00:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghs35331jz2xLq;
	Sat, 20 Jun 2026 08:00:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781906417;
	cv=none; b=ikfuMI8yKT/DxTv/tvpqum/SFuEctlcTnwSj35FVU4c5OMvtHyGCBdGkXfPFniet4lqAoJ0KMRVDyZkGG1MbAu3V7xWEqzdafOht/GHp4UofBd6QbNcgQGK6z9D1NA69alJ0dMr2gsDhP7ZF7fHr8Tpc+wGfElHzLJkBCfJ1cXplnAoLtk+Ofe9/YVeflCQIgIUKBmzjl83wrtZXpe+5ja6d4pOirGbhSyUGKUDKbRuCaUDx7YpT5qMtyjxlN5+t00V/GKdUJhiYm2TWJSJ0nHfaK3ZSn0l7rJlU1JBX3uOH7UEUFr5ZOU28OA5SzEJ73H4IGLAKW1GGZFDmzz5o5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781906417; c=relaxed/relaxed;
	bh=yE4pHTmaEflBytyOO5OBAPL4EVCjd8mVgLWw+yP9pok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hgwEC8KCkAGgt9fhTnw2aKX8r1miqVWOZRxIj70ilT412jDbKiqzPvdev+cjjbIQfclFNnleEkvbPvyjBLOupmjJWJoZaSs0rUAC3D8ptqYC88MpWGLB7t938zO3KvnbpaAvyODA3IgcRPb+mhvq6ckdqgs1CPh0b2lnEmIk+pq0uCinTm6QAvI2LVL1OjioG2PvdtQPw+RjUUs4ilw9Yrpmx6yUvpXwlTHhNCf3P6Hdy/w6/vXvlxoeiuRubySYse3hcwS5QcUoIJzOnVjKzO06GHjduiwCX477jnn5UH6ZPfVVpXDCwfotXFDFDnGHBavGHHqafkb8eVm40s5vNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CWmrVBZD; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CWmrVBZD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghs344nZ5z2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 08:00:16 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JLmD8Q3609692;
	Fri, 19 Jun 2026 21:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yE4pHT
	maEflBytyOO5OBAPL4EVCjd8mVgLWw+yP9pok=; b=CWmrVBZDBRU/Jtop1gjh8L
	1jnpouf3ORl1sMeCK0j/FlwPrznHR4OaCt8HgXBuC4LgkYovCquH/PG3dp0FYppE
	2OK4TZMCHNX97cM8m1NZMnFOaT27TrNtHlYswa9qzowX9Q4yYaLy40EEriz+wKyB
	Qlk8rFBHOm5qIDR+/bL+4BK4+y6h8vYAq+IBUFIRlSn1gqaHRHWvzz2qQKxhm0xs
	NCZkmtUguVCrBqv4ywvFpS4MQULvviv6X1Prb0lQDQxHkTJt6ry3qxWZYL/+J1ek
	wkIxYmf2bUS2Tfct7ZqYX4Iz6gLs9dp7Uf2iMLNHQkmJsxvTmVZOt4yLuW8LAloA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequfrdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 21:59:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JLncAm011347;
	Fri, 19 Jun 2026 21:59:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev172artj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 21:59:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JLxrpL9765178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 21:59:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAD0D20043;
	Fri, 19 Jun 2026 21:59:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD65320040;
	Fri, 19 Jun 2026 21:59:50 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.77.5])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 21:59:50 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        sshegde@linux.ibm.com, ruanjinjie@huawei.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: Sayali Patil <sayalip@linux.ibm.com>
Subject: Re: [PATCH V2] powerpc: Restore KUAP registers on syscall restart exit
Date: Sat, 20 Jun 2026 03:29:32 +0530
Message-ID: <178190618810.653308.8397573315437375026.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615162617.2861795-1-mkchauras@gmail.com>
References: <20260615162617.2861795-1-mkchauras@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX48h54EUw/YXo
 qNvZtuz4JJEewKr63gwOLFjblNr+5KUV04w2nSCko9CUAwxyNwJoRsS24wkpx37EJTd33eyd/hc
 Nw6qxf2K9gbYXkHTSrRl2TIqjQXIxA4=
X-Proofpoint-ORIG-GUID: Fdq1AcOkCXB-mj6dlbtvvmKPY8XG0vNV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX0jvXVKXEaPea
 53sn5CsvRJFmmEb9GxzcUU6VcBCmMeJtgPQuNYpiFqScb4qDojKJQ9IWcWufPre98yMaiyQwYx3
 CLJK2TQncUb4Mi/S/uVLBlFAmr5pCdr4AwVIoYJlCTmcVW3UpguLH5wOm4UkozsOxNlGuaR60WO
 wI4MBTlEMPT9fmy0AItQkPLtp3icVefIwl85CCOLcml4PPxsg+yH+Seg3IfIrEK778D5LPuzqoe
 mFvisC107XoDy3+NHJc/UscwoZ6+rsCAsPDbDfXIzYnHt1fXODlZfpSnWDFGLOh/OLuqSQEvA0H
 ospP0iW8uhxPqqM5Bf6k75RL5pWgt8mt/xD7FJhKTW48o4uPi3+2zF01Zy3T2EwnUdXnoekTYZB
 1VZPg5LbH1iQMwOUELinE2mGaaQx2RvvP07ZGli/vwyUGQ22VaKNzFNfUDDdS4oQ/bd8Vc0v1oW
 z5Ie7Glcnc9a5wk7dsg==
X-Proofpoint-GUID: ciivoITSdYzBXRrE00jP1vks14oMbQHR
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a35bbdd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=b1QI5ZhQ6AAWZPfWjeAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190210

On Mon, 15 Jun 2026 21:56:17 +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> During a syscall restart, block KUAP so that pending interrupts can be
> replayed. The original KUAP state is not restored before returning to
> userspace, causing subsequent userspace accesses to fault and eventually
> trigger bad_access_pkey(), crashing the kernel.
> 
> The original KUAP register values are already saved in
> arch_enter_from_user_mode(). Restore them on the syscall restart exit
> path before returning to userspace.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Restore KUAP registers on syscall restart exit
      https://git.kernel.org/powerpc/c/4e1187e12de40b5301977b2476d21b569358dafb

cheers

