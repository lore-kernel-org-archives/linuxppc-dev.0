Return-Path: <linuxppc-dev+bounces-21057-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D83CD4F50
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 05:43:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJmvD4Ndwz3clw;
	Mon, 18 May 2026 15:43:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779083032;
	cv=none; b=fTAAkvm+2fR15T12T91clTFnKdR4sbRQ1sAqtgJuVQoamBnL1aUi5wGsHsyYgQnMNkyxywwIIcdOO+87+HMSbk0QQG9uemiuS/hWvIJhFeJAUqEaSgiJBMRHiEWORfzLH3kfn1QsrUGwxJHIcbGVfO63+IdhBoh5tqS7+pMh6MP/rwG29h6GIIbnL0BxTj2XDtvm1ZUWyx+dJHIgCHc/5ypZIrmx5Q+NILQZDhUne3oKR0FhrIczrm/W93LZ6FsP1t8dmDormvk/sQaxNTgjIguEnO+NpbsD2OJh5NBeI5AwMMf+jAM+4F9Po7VpqvlucUhVyG5u2CaRy80xb837cg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779083032; c=relaxed/relaxed;
	bh=oSMbH/Tm+lmpg3kohoiRI1mT4wzcsubTNnYXb2wSt/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkH0cPjODV8R0ceErMQs03RH1aMnDv5f4tvo0XoJQWqvhmOksRNlfvWtTeofknKz4u4IsQ3AAHCewmvKiNdsI9iFm6ix4BGj0+Vw4yisvX6QB3nKJ2r9TTSwd/MEHMBQhW1sdc0MyoT1EsOp54Su0wVjorCqKH27Ldt5ec0oR+JhdJEr+l2UOnzJmCDdbgQ3rczRwcIsP0AiocivXelnzOoikHqusDKShO2gID6qzfwDuiu7nigDMj8MWKwd/lKTPl8Wr1j8JryXa55M/kW1RiTMKCXGUhKSvRz+Vw3wX/mXfrEqkpY40uGl1axjIcPQPRMAXsJmxdwNIs+HjJKxJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dSk7z3nw; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dSk7z3nw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJmvC6460z3cky
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 15:43:51 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HLegnc1409980;
	Mon, 18 May 2026 05:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oSMbH/
	Tm+lmpg3kohoiRI1mT4wzcsubTNnYXb2wSt/k=; b=dSk7z3nwDOtr67Li0ofQrB
	WB+5XE+XKsY77V/wkrW1nwZ6LJAP68iUrpIXhSmJXB6/SdmP+Ka7YGSg1HGhR46W
	Ai7ER3IGuWqWzpBEQ42k6Yd6FPMJYxqyAqeBI+5txO/6sZU58hntxkD4soa+rvaO
	xpjOrxD95Dey5slryUQ2xLaWQ3HIcuyTbY1Vk8dBwjq0zSuA1gKj5BU9PHGa8FE6
	hHPGhLt0t1wFSBTbJahTX15q50HAu24MlD/BCp0Z9EtSV1CusBe9b2kdWqpeiWVn
	H99cHrw59M8lcNomFY/Vc/iB9IR80Koat9YwI8Uvu154d6NWOovd9Za+NOxemUIA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9xpc9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:43:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I5dEtP026289;
	Mon, 18 May 2026 05:43:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhc9kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:43:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I5hY8A52101450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 05:43:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5433520043;
	Mon, 18 May 2026 05:43:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C63FF20040;
	Mon, 18 May 2026 05:43:31 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.43.25])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 05:43:31 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        jniethe5@gmail.com, Julian Braha <julianbraha@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: fix dead default for GUEST_STATE_BUFFER_TEST
Date: Mon, 18 May 2026 11:13:30 +0530
Message-ID: <177908291162.287704.6425111571012280321.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260405161545.161006-1-julianbraha@gmail.com>
References: <20260405161545.161006-1-julianbraha@gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA1MSBTYWx0ZWRfX6RtwQGsN0LwX
 7qIIH8e/+CZdpW9YndQs+eKvWK8J6ntBxYquoNJcZM9bA21q3JuzcGj3WODkgA4iTNcVH65dYu/
 WlPJmQTu7Usy3MDJA0m5VJq3AvFmsOMtx5O1vCgXh2JIWMmDd+VgVKmt7kh5Gbwdg6VzX96PEuv
 BaIEtWCgG1BVUuKsVVa8AQ81CxPKswC8NGwk3IV7NRSXYzCjqv7MMrbkwCGM5s4u0Q3UBferLTY
 TzsMFOA+ZcqrXMZRyB09CKiQ5rQrMQb14K5v1EVu2Jj25MGoMD0U0I/O5f4zzD8h5gnedkmVsID
 PxXVVJsfqb3ruE5PyXRWIk9B1pxj+5TH9sxSwC06KERM4AtPD3075aojpVtQ8xhpzk9Mv1pjqwn
 tRyzZgknDXncmb/0bj53PYa/pQsALY5TMVhcVHrnFpMwb/WJGMaLy5ECW7Tdr0tRFFH/no7mRST
 IHVLpl4DsEZUH15ZisA==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0aa709 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=ruEsGexEiFxvD3VCdrgA:9 a=QEXdDO2ut3YA:10 a=0lgtpPvCYYIA:10
X-Proofpoint-ORIG-GUID: KxqQVUXsM0YHjtCTUXYpgqn7CqDECKVS
X-Proofpoint-GUID: 27xYcVYycwu37JB0RvD5iCUyDTjSjYPH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180051

On Sun, 05 Apr 2026 17:15:45 +0100, Julian Braha wrote:
> The GUEST_STATE_BUFFER_TEST config option should default
> to KUNIT_ALL_TESTS so that if all tests are enabled then
> it is included, but currently the 'default KUNIT_ALL_TESTS'
> statement is shadowed by 'def_tristate n',
> meaning that this second default statement is currently dead code.
> 
> It looks to me like the commit
> 6ccbbc33f06a ("KVM: PPC: Add helper library for Guest State Buffers")
> intended to set the default to KUNIT_ALL_TESTS, but mistakenly
> missed the def_tristate.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc: fix dead default for GUEST_STATE_BUFFER_TEST
      https://git.kernel.org/powerpc/c/aef656a0e6c01796190bb5bd2bdba1c644ed7811

cheers

