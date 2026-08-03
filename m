Return-Path: <linuxppc-dev+bounces-25237-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B542C55162
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:57:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD6v40wwGz30Bd;
	Mon, 03 Aug 2026 16:57:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785740272;
	cv=none; b=kTvTGYqmoIWm+GvsZHnXiokJgoK39cEtYaPgcmBgTOSZw81+IQvfkZL95mYyGLQhEUwm11ikElTys8CAJ35K0huJO9FPnMlLgk4VJzviXApRDJEgPiDHynlQ8rrRwwVLpg5msCHix+v/Yov8KNFfKg5ENRM+hLE3o30Z9qQ7WjalasP7mAUl+v9qaRPzy2GABT7RkSt3bBMiSzsZbSqsoQzIBHWpQPWMIGnDpUEKfZqJVMlqt+dKGs2St91vrna3ESiX7zKz0DmLFA2PgyCCnPQ9+Q2eY8Zaxk07hN2dSIjkks5ZGk705Q/+6H/+X3pBmhfXWFBrZnDCBUYggzxuZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785740272; c=relaxed/relaxed;
	bh=WYwNVSlxk8/aWD6wHGwCyNIqaHuQGOWmgpV67N4nzGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6bEskheRpaCR754vu7IvUYZyWuTQqfrYcqIBMlUpSG9GeKyz7A1Kuhj2g+sl4KkzkIH7xLLcb7e7L5f1pFqT9UfaqRiRrzULe8V1/bVK2QYbTtpBb6G05xqeVUOsSZTe4QF1/nsriTNCH2qOsdDuDB4DT+u/tYi4BUhv6I8vGX22/oFpfQAmYbtZCb2ucP7PVjg2TpmMd2X4g0QdpmpM3Jq/L78UJVFVPilHVDGJHV3VDrfxud/gwmP/sCLBpVVa9SV8Tr3lStNDoywK69EfOruSIakxOPRchDaXPMV9Pq7o4VLUEs1i0QpcOCWnqOPJuEX9BSCJaJioUFdtPVvrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Yp8sl6SD; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Yp8sl6SD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD6v33H0wz2yfD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:57:51 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LmOU1224726;
	Mon, 3 Aug 2026 06:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WYwNVS
	lxk8/aWD6wHGwCyNIqaHuQGOWmgpV67N4nzGI=; b=Yp8sl6SDfGXsGNKFdk0llI
	hZo0FQexeYqOY6hHXnw98TosW9sp13EVD/UDi+Q1hqScQXCeU//45MExY46/jkYg
	csEfJuLneRaVWqkHoj7hQS7yRULQdxzACD9pqrIQE1TDZGw6YkKAHC6+EWfxcNjH
	/72oBmfI+3HJpRGxg5PLsTCOBp5GGSZlbBRQ1rwRhrb3jAgtnBwAissNhPym2Qmc
	fNY8fTa9XroVJjsqV8A5VCi+kTmaK+QAogNy2GTe/6+IyiPIi8laC/4ca1zIJU5A
	pSUYMFDzYzaCrmkZ+IoSVyec4t2wmrECQyhIgPcVXi2sR+8kQ3VRtkNGdPXwMmew
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3qa5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6736uJtU026385;
	Mon, 3 Aug 2026 06:57:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvv7ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6736vZtM29884726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 06:57:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81BB32005A;
	Mon,  3 Aug 2026 06:57:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C97D02004F;
	Mon,  3 Aug 2026 06:57:33 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 06:57:33 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/boot: drop redundant assignment in serial_edit_cmdline
Date: Mon,  3 Aug 2026 12:27:32 +0530
Message-ID: <178574013460.29744.15552261140931093313.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260528082357.1397611-3-thorsten.blum@linux.dev>
References: <20260528082357.1397611-3-thorsten.blum@linux.dev>
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
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a703be3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=417ZechrxDjhR8qvf5wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: L6rAAHvNcnJvumiInsX2DV6aVo4S9QEh
X-Proofpoint-GUID: opm1gMNKuFE60FH3Ljj0Ty0ycLPYevHv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX3IudYxTGng95
 PrdhSE2Bk11NBTNbEj+xo1CC5JgSWCUMiygRYTi9maV3MOrJY16RpLyNzvrgVFY/aPIBlfRVVBW
 oKTnVqqk22iTNowcll4RwPLejC67KAc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX8CDzfEIEOCC1
 Eoo/3hw8S6CpfhVwBi0xp5agA4sl36fIrc5g+vxbsyYunuN59PCDfw+B4U9YiYjLhJpp9t5rXvq
 /KlNuyRrcu5FaLay7Hi5RnF90ZyYKjy6ltHQBp9buyCMlrOpQjuP3s5dgpo6KYCFMd7cR4cvvSS
 MQSdbSCf+Ikhb4bz3kpU+hlHBqSs9NDxwqNU82ndPZ0uiGkybb+WCMhAa4xUeuJW1AvkifsJjp9
 DDIP72mwRbF4olqzx5JdIWhHy1okcmVj02pUi2HKsxQJLIymc/evDdZyaVhKcJAUqE2pmnsl75C
 TlO3DHVfix3IxrIqOgpdjIXkP0KAO/vooHZL6ietxNnKWPflqFNBC8ijVPPWYT0XMNrXdJgl4RH
 /GU5Z3b7H/47aGhZqgPhPm+OUNugWWF1DgfQ0E6en0pQXeX2kEz9FlaLw6i8842aJAM/KOiOTdv
 bIZ6kng3V67X5vDz6UQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030058

On Thu, 28 May 2026 10:23:58 +0200, Thorsten Blum wrote:
> Drop the redundant buffer assignment in serial_edit_cmdline() since the
> cp pointer is immediately overwritten.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/boot: drop redundant assignment in serial_edit_cmdline
      https://git.kernel.org/powerpc/c/73dca15a3b813048b01e9c06c260c6508088c2ff

cheers

