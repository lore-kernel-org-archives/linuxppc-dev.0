Return-Path: <linuxppc-dev+bounces-19662-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C09E93813
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 05:24:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvG6V0Cv2z2yjV;
	Mon, 13 Apr 2026 15:24:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776057841;
	cv=none; b=OtP5ivgfLnUldSYyeApFazZh5IPgECUEfRsPqq+NUIpbmD+FX0JqwbKwVDcaBx6OxyaGBu+l55qGu9Kj6pUUMOdrA7SCKqEgbwyFU3QjhFugQdbNyMHdiGWxQGA9ZXaDjihiLYMaCCqA0hq6F3KzRBJ/jYfFW+vSoMvcPGvGvz4hMuk/lKOh4mYcjE/N2pW77nXEq2M54CFPsLd3Lzs0/JkjGBwqUxBaQD/GDn19uGlh15Qc0NZtzWIDOd/7TTHVXW6qRp4evsuSHOGSj/83vIeCZ2KmPrPE9shkzpkroFYMn9alp4oMZ8hgqDaKJicCrWy0sRr81YT0ANP24MkbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776057841; c=relaxed/relaxed;
	bh=g66oGdErVbAYwnMXLsa/Q1L8W4j7ho6qdSj1fbUkMpQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ijVT3RrUnvVZEYwmctFiS82SkJEBUNxUvUEX+ZBskq3Gz+PZ2U15L6s7Cxx8yAh/QPJ5Jpsp0fSJ0N2P1/dcxi+bL68HTjajE1CiW8SqRitbI1v1IYKHRkigkPJlMvyFu2z1O+2eAA44m6INzg/JAOwyZ3l4G0Pmt27IR8/mMkPWkKa/eum4HLJr7z5FBc3l54pGGhO+/9V/EevjM5/ZnegOPns223GxnNrx9FgcZwgCjl023bN4YERMlOxxWNxMsRYaKLkh0xbcJXosM8V0FdIHRECZo4UT6wltOHe4uuuFPWwBtPo6nS6JrGwF1SHH08htil4J6/BbeyDT3G0hyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kjbxUZ8P; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kjbxUZ8P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvG6T1wKVz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 15:24:01 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63CKbKeL3050353;
	Mon, 13 Apr 2026 05:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=g66oGd
	ErVbAYwnMXLsa/Q1L8W4j7ho6qdSj1fbUkMpQ=; b=kjbxUZ8P5yNrXj0RLkn9ab
	Z5d/gZnHue0E0nmyJg4Fa4Oi0+b8/2uJtl7Xb2IMFfmMbFpuRLYmpq7C4D57ERQO
	q5qqLuaRit0uyJE4+DJgyGOxR6WRaWbsxonsz3t/3/A5FIkqR6pNWr9Ej0kD93Up
	sEoXzn3hGYe2Gaj8GKD4hikk7MEuHfgOTXQlXwMj8ghD6IGacz51NcrKWcbtbMn2
	lS3yEeMf44l+fg+GAMp19/30hWcBKb82SiI68FlO04H+g7NxjAPA2WEkOTObe3fr
	NAfxiefokbI4FBaQfFtzGUyXhvZ/k0FU2MVLstvEZQSoPxnBAbO3YrDVnoP2NCXg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdyqp2hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 05:23:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D45gll004188;
	Mon, 13 Apr 2026 05:23:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24k3pyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 05:23:58 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63D5Nst549152286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 05:23:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C1BE20043;
	Mon, 13 Apr 2026 05:23:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 575D820040;
	Mon, 13 Apr 2026 05:23:53 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 05:23:53 +0000 (GMT)
Message-ID: <0497cd26faa406ca1cd7a6c49227eb439e18e270.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ppc/fadump: invoke kmsg_dump in fadump panic path
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Date: Mon, 13 Apr 2026 10:53:52 +0530
In-Reply-To: <14329248-0c4a-46a6-ae32-a30dc10dc1d0@linux.ibm.com>
References: <20260412113057.46090-1-shivangu@linux.ibm.com>
	 <14329248-0c4a-46a6-ae32-a30dc10dc1d0@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
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
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ErTiaycA c=1 sm=1 tr=0 ts=69dc7def cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=_bbIk2df9rHDcjtLxoMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eJXS3q62LQ0PGvuHM0UFmDSnMY5Sg9Zk
X-Proofpoint-GUID: eJXS3q62LQ0PGvuHM0UFmDSnMY5Sg9Zk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA0OCBTYWx0ZWRfXxrsQ//tUNO1c
 Ypt7NmytglLsvoPDiE4TYsehyJXJUBcS0N8Cmy51IQbS0cnCkgyns1xAd+81k9ZW8ghGu/U+UQc
 d1O7dGbUO0RPOhmKL6M0xXn8LWwbTfPd6h9hBYgly8a5NWUYz9vhlujPjzWLMZVbueD+8T7kp4Q
 10y/B291AeHBuqGSFze+V1g7s59ryksv7aBAuiqi5H9Sd1dpm4Smo0OL+jWQpvJOAzmezCpXBTK
 sBSPgT9YCKOZ7amWt5xQLbZAMxvIbi8tPTCIX1ONz2baBkWYXVCEYWQ2gzfyGoO2+B/NCznq4iG
 M+LvzzwZuuE5Vf9gJ68Sy3uItVUxb9Pd9kkW41KprA76e+Pr5wr7UPe+FxIwYcczFawQTu8mQer
 +ne8mDNxRpsZ9CN1QCBb1PsfLDoZMGorz3Id69QAktIGXqZXLloQ9GcnBMAmlqa+Yt7y1sR4lcm
 PtJFIFPgKFeyij6zZHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_01,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130048

On Mon, 2026-04-13 at 10:52 +0530, Sourabh Jain wrote:
> Changes look good to me.
>=20
> Feel free to add:
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>=20
> - Sourabh Jain

Thanks
~Shivang.

