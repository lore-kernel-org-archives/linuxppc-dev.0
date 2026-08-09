Return-Path: <linuxppc-dev+bounces-25652-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F570C5AD2C
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Aug 2026 13:14:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hHyyc6wlGz2xyl;
	Sun, 09 Aug 2026 23:14:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786281256;
	cv=none; b=VTy+LQ6h5CvzZWzdz7ZcNFzqu9B9zT2D8/883mAxeh6JCPDBIg4erPeqidZd2w+RV5Wp/6uZqIMG/Tw5y2rvfPQWXGjysVfiOUDOS6yGsFQx6A3YJ5LqDPwQnEmBKFsUYDEdN5SdN8z/AcixdzTXkI7AtRAutTMdKpmXpgV06M2RFGBHOWzmuoEVXDjhhtYZnvlMhu0+kPHCkclAzEDaQ1dZYg4BKKnTd3wjm4k0j3eyj4irEmNyqKLM5dVpZSnr86uk9f0zxoi7kllD+hnkhRntL1WlTpucBgg+2jRWDG0xJWPyqJD2PiNQ5A15UpbSRn6p27K1s0pGwtxzFJKn+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786281256; c=relaxed/relaxed;
	bh=rAIMIMTomtyg5Bzamr/+FfWK+9dIsPwz0g/OOzv7woQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTti2uDAJuJUmva5RYNagzEw6o+iJ8GZbZTI+46HH49qpZoxDF/ipUmx0nmtpZvGO7MQAY60Woy5b2dRDbAltnnKppP7vJK9LVhnz2WzjIFU0LHi9EBBcwJHf0Y7HkovK/wSTPkhT98xZxWdA7KyFW8PkKqkqP4Oy/msUg68lvPBnfmJsfw6c1IZlm9cC4aW69RZpFsvCRJERt+HU8yCUt3JPllh6U01mJ52Lqw43J5E/w/dwlhqPszmAZOsk7G71nOGxH93Xn/O1Bz8qfb0HsM9RQ/opG993/FGam0/YAJGyWgEdZP0HiW3nwdSjYM87XTL8ti5cQMJW/2HGwod6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S15dXqKU; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S15dXqKU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hHyyc1h4hz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Aug 2026 23:14:15 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679C2bfM2873376;
	Sun, 9 Aug 2026 13:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rAIMIM
	Tomtyg5Bzamr/+FfWK+9dIsPwz0g/OOzv7woQ=; b=S15dXqKUIbvLPTPcnvblQU
	qrSFH7Gp9IiGJuZVNyUVp45kg9nUHB5zbDtDXXkNoKmvV5ojplrcgoFhwpqBeWP7
	Vq6dbYN40HTaEzkGqM1E5WKTMEHXBVMapIQrlHCkyHqV8HetnDW3kBlEoin6gTSK
	tLbAOjxfnSO8hybfnq6DpScwzSxWkAt4oz2kSMqr5brj1/3hoEu9fU8/6kvodCb3
	6bjQZLVExOWOILgT8ZBIr7Z0MPZ1eXSKM7rAmni9+bGwn22MAkDVjrOZeOjmHXzG
	wv3LpeoyRer72xtZqo8q9MNp7Pc9s72GW53pFbqVQPNu1GYFmmiqWRxjaj0lpH7A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq948h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 13:14:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 679DBGwl011321;
	Sun, 9 Aug 2026 13:14:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5vsfp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 13:14:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 679DE0iX49480142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Aug 2026 13:14:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EC3220040;
	Sun,  9 Aug 2026 13:14:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1827E20043;
	Sun,  9 Aug 2026 13:13:58 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.32.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  9 Aug 2026 13:13:57 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: PPC: booke: Use min() in watchdog_next_timeout()
Date: Sun,  9 Aug 2026 18:43:56 +0530
Message-ID: <178627549726.530848.18124700226916109095.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804112011.59416-3-thorsten.blum@linux.dev>
References: <20260804112011.59416-3-thorsten.blum@linux.dev>
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
X-Proofpoint-GUID: M6kla8c4D5vQypXwGMBCQj1yqcY9q7Tx
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a787d1c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=Bagx-dtLvwiT4Ypvb4QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDExNSBTYWx0ZWRfX6tjGAb2o8NPU
 wdG5kCTMemTKbGiUIZ/7Tpqt4h7FGJVJ597zfbJslHvBKpk3cwz1bwEm6q7kDu4MZZhQ65J8kLC
 sON0vGBtZu/x+tRfMxFyN9++SxZe6K/x7pAijOFagiu9U9iZzx/q3N9VKYDisXxT4EL1en8I3br
 hWL+1pTF0k8Cwm3JFD3jaJjO9FxvIHrbQaKqk7+yljXbhzYLkzSbXtmjhkKHoUYDvjTLwuqmaEs
 //4YdTIOMnm8fGUHQEo26/HXmf0kU40zDvAZPgQpWS5W8WJU9oYjukpMJLb6LBCJJeqH/74ZGh3
 ZHFXdF4IU5kETazVm6Ro09eje/xd0QTcXrQ1DNGv5DQvXsFftdwneqc8gA3o8gQ+7HOQ4nuhsLP
 LhlXOuVWS2+xNb05QZF3ZxOgVlgL13WhT9ouEvDl8oH0a980GngB166ZUQU34bQdCnB7x4+zdUD
 5gNipWtfOyAk4f95Acg==
X-Proofpoint-ORIG-GUID: VG_C0zq56BALBfAX0KK3MI9yT-UeIPAQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDExNSBTYWx0ZWRfX4UThm9BFSs5R
 4FwK2bRjOjyd/IAG0Eg1yrvi7HF1/yp7AXI1kkQPFkKK3NGZMG4R+9JKbsMfa3kQl0VALqG4WQ8
 xHjCiLitHBg7/iwAv10P4u0wgw0uk0g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_04,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608090115

On Tue, 04 Aug 2026 13:20:12 +0200, Thorsten Blum wrote:
> Replace min_t() with the simpler min() macro since the values are
> unsigned and compatible.
> 
> 

Applied to powerpc/next.

[1/2] KVM: PPC: booke: Use min() in watchdog_next_timeout()
      https://git.kernel.org/powerpc/c/ad0889338bfed33da6b8127d7d8ae0a4d6e4cd5d
[2/2] KVM: PPC: Use min() in kvm_vm_ioctl_check_extension()
      https://git.kernel.org/powerpc/c/0fcdb510932b90160c47d3c38f6ce43852d7e14f

cheers

