Return-Path: <linuxppc-dev+bounces-19458-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C62FD5F6E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:28:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr96m70mjz2yZN;
	Wed, 08 Apr 2026 14:28:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622512;
	cv=none; b=CBpFiYKgTqdvlzQd+JP3TGUE3kGV2cvC3rTwRJfptwotCOls1Nv778NWIwnxaL9ogc694mEC3ayL5iH2Gv37zxndaurPjdETK/7QwY74zS7qCKu++ZjJyy6iPVVu1HrmThK2NrBrPemryonsP7LykTmNImHxPYSYsyjn6uqvyWzJkQlt5EmYMA0feZZ+V/Hsm5Mq6v3BC2VoibHLlKteLXQlMC5ib4Q1H+2fgXEyIVFZKXIkHZdQJBu71mFC9u/kty05ZAP5GzTh1OXt8WyIev8l6WBOKkiwD+T8UwNqspR4We4dNxcsNavo/ujg034aoZfB956gtDwbtNHtG9OH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622512; c=relaxed/relaxed;
	bh=L9RHY9sSMlRwnpkEkt0VkNTpH6ZcQ+haY5d3nV4baGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cMKfR3ZrnU2SlvNveZHeyu9YeDRqwReLOhMt44JtHxRjBSaoOmwsungPnmmL+wy61i3maKaDnBPM7UD6cl5AZg5zPy1wzf8jGzU4tyWl0kGoNrCeeZnu2WhIOmmbcYodoh7FcUDL64oJyVkxoIqaxMth7mhTG7JbYKv28t3sJzeNNShwMQa/yw0Bu3mRr3dUGCW6rxOA6U4ZwDw/iw2CE1lrhbZYhm66Az4Q9SgWbaAPxOoarFWYGR+IKEQHnbQbMv66p/Y03sqUA2NPWl6N4MTyTMZzO7FsD4IhsqDtOoMab5QduIc+H/NfmRa7mnAS1ApZ14HZTsR5CThMCMiniw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cG9GUo4F; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cG9GUo4F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr96l4r45z2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:28:30 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637DKBfZ2326115;
	Wed, 8 Apr 2026 04:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=L9RHY9
	sSMlRwnpkEkt0VkNTpH6ZcQ+haY5d3nV4baGs=; b=cG9GUo4Fg+WcehrpKMuiCP
	C9bvkI2S8sx1ngWd6HeFMvRHJkhpPLVcjRuj1wiessyfkqRWJMoeIZA4L+y8/mPv
	mpoXWwLq831YJVRxboimg3UEARVJIiLBjiA6vYWyBvodHtM35PP2nF3KWcUZLa4H
	Cn76azp48J4kJeT5k/QiFf7lD1wpzAqY9Ip/SLR1wnc6Ly7klBzitfClxWhZ9JJ+
	FmVXs5ZhYm+GJcWUXAueMuNDXaytVYFkRguve6WrCWNu1a/zxyH4XP1GZa1ptI7L
	W6+g/BfMLMwXzMuvAKTqJRlP4qZ5ten5pBCWFisfPVTrc6HQI+n9QzL5NkshXtqg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kdrd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63804Q1C007951;
	Wed, 8 Apr 2026 04:28:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2dywp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384SAxD48497056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:28:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20B5620043;
	Wed,  8 Apr 2026 04:28:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49C6B20040;
	Wed,  8 Apr 2026 04:28:08 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:28:08 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, adubey@linux.ibm.com
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/4] powerpc/bpf: Add support for instruction array and indirect jump
Date: Wed,  8 Apr 2026 09:58:07 +0530
Message-ID: <177562236435.1381144.1740306913657304878.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401152133.42544-1-adubey@linux.ibm.com>
References: <20260401152133.42544-1-adubey@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX6mozHGK0ITCa
 4Lip/NNT8GQtCo8NCOEUJrsHKBVdhOZYoEZfX6JbbIrROHrFZetzpt0CzB2UChHlvpYvALYh0S4
 27cQX7FX0wHib4fJaGQoFC5+ooOmt5Eep6jMKcIPWnMX1pLFmH7lK69M67+doNPArR0P/E7OrCD
 le3EM6lElfBXmAukzTDr0OKn9hi1x2LYlLeIltDBZ5A+lrPBzRtzDaGRHA8IuIji02aF4kmWIZ1
 ekCIaTJ6Layt/3wANuicsX9e+/Tb6fBbY+RzrghLqTYte4deGNOdQW7JF4BxXq8pZvo02QJ5on7
 a0C51QS3ayaQJvVFYuD73Yto+dBURcFC8RX6/S4Bhw0Pf8lQGRqqFcZP4aEvgmruW6vtUteOElE
 EoCBtHEw1CY3mgmoslwGdkq/D5lJ7kqepasYjPvWgnmJdvjsSOzdf4NvfGqKdPFHVDz+kl0FOm8
 6cSX8hs+tsc19LC8mzw==
X-Proofpoint-ORIG-GUID: 4NoKsOzFeyOOf25zR4ZyAEdkmFfuz52s
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d5d95f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=4nspnB3_q34YrqKDC90A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4NoKsOzFeyOOf25zR4ZyAEdkmFfuz52s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Wed, 01 Apr 2026 11:21:29 -0400, adubey@linux.ibm.com wrote:
> The first 2 patch enable support for instruction array. Now, the
> instruction offset map maintain the mapping:
> original inst -> xlated inst -> jited inst
> 
> The last two patch enable support for indirect jump. Any eligile
> register can store jump target address for control flow to jump.
> 
> [...]

Applied to powerpc/next.

[1/4] powerpc/bpf: Add support for instruction array
      https://git.kernel.org/powerpc/c/1e4bac7eb95a5a1aed5b39971ef77dca5b0f8a9f
[2/4] selftest/bpf: Enable instruction array test for powerpc
      https://git.kernel.org/powerpc/c/66cad93ad325b332868c062bbd0de65ca4e59657
[3/4] powerpc64/bpf: Add support for indirect jump
      https://git.kernel.org/powerpc/c/a32325c0e623d594992c4e4616fa685c0e765a33
[4/4] selftest/bpf: Enable gotox tests for powerpc64
      https://git.kernel.org/powerpc/c/e1f7a0e196e293c223a882788c6d1a884d06d6d8

cheers

