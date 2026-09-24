Return-Path: <linuxppc-dev+bounces-28118-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30486C98317
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 13:26:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrF3P3Xdzz2y24;
	Thu, 24 Sep 2026 23:26:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790256385;
	cv=none; b=dMuHUvtDXbjORLa3m/vMrjmRiV0r+S0OLKjOMungeXaXEvF2OvQ7QSlrTtiR5nsuGYHK/APIjgvC/X5AWm5yqy0sGcB9yonzWkVF0Ltj8hsT7YFHLmNJyy4cbTPPwcWil/AU+9dYASEO963MS3y4ApJAJC1anPR4ewlvuLv969XGXwCqSRNIOU6OJZkfj6Uf7sk0WMpf+EG7vmwjUXIx4+fhPfT7VbpYJio3lIBE405Xt0UB2UAi9pV1IS7Bk9yomg/PvSnVyQtXY9aAEthxzpn32YRq6VABnykqMIIcj8W+uSEiJjxwjLKd59iW0KO+JDxCELYSq+lBmQfOGZ/bvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790256385; c=relaxed/relaxed;
	bh=gwpARKiQNnpgf81tDX2md7RZxQA/xVzy0a5NV+C+Fz8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V+ZUYVCiGpXNUmNlSGLscVQoDd5RqvjgwlYPe+7L88S4XKvvoRvLNM9Tw8pxEM023JhiRJUap+ZGc4zJ3ZDJj1F+EckDyxcVPQhnOaxxqE+9z8fEaeugKUjxp+C9EDsv/i8fxticam8Bsem7Pr7fxEFSig1iF6ynoswFohwe8GLupWfZGvgjjdUIoDK2z2xUimVc4Xb7uux4i39u8wVy0S5YGTJcw/HTK2bERz5A8uAoqeVSSbA+JeCrR6tJZCDh0KuWzp7RMsBNq3Xh6xZH0ukpz2Bt828CiLRat8h/AhuyYxy/626beep8gEdhoNWyLeDJTicEvc3oud1XuTo1EA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mye103in; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mye103in;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrF3N4KHVz2y21
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 23:26:24 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC6Lnr2028082;
	Thu, 24 Sep 2026 13:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gwpARK
	iQNnpgf81tDX2md7RZxQA/xVzy0a5NV+C+Fz8=; b=mye103inZqYrHyL69VTQBA
	aEk0iyS5LCx1miSbeJt/enSakQWqMQVOWTePpCun46rfhJod1AVQUqyfnYlyqMvQ
	D1KJxUBVybo9j57sUIp6hJABBtHFnNxk7h2+iJcu1WmcezwY2Y6EfVWcQHMAbLMP
	uFrOGU/UHeG0FmSGNGsDWhtDUhWhnbk/XojNQLWZvIBOM7uaL09sg5XeFX5pZmFE
	DLAR3keX8fTQVfuX9mpEw79jD+CB1MaVN4oiMvOOpwhtIT+MCrS4bnxpUUlWHNuc
	SD5C8XheXgM1BsQs+CnragHAinEMdF6+zsY7bZBUFjtjSJLRqEeCmvaqG5WZv2gw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1rpym-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 13:26:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OCHYD72061443;
	Thu, 24 Sep 2026 13:26:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8jx1ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 13:26:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68ODQ63q43581846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 13:26:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 293732004F;
	Thu, 24 Sep 2026 13:26:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D3DF20040;
	Thu, 24 Sep 2026 13:26:02 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.19.125])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 13:26:02 +0000 (GMT)
Message-ID: <a18fbf8f3923f14215006a23a5a94dae63ab3ae9.camel@linux.ibm.com>
Subject: Re: [PATCH v4] ppc/fadump: collect dump when CPU_STATE_DATA is less
 than reserved
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sourabhjain@linux.ibm.com, adityag@linux.ibm.com,
        adri.vero.dev@gmail.com, anushree.mathur@linux.vnet.ibm.com,
        chleroy@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com
Date: Thu, 24 Sep 2026 18:56:01 +0530
In-Reply-To: <arTuiz2iOQkPdHwT@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260828094942.2439404-1-shivangu@linux.ibm.com>
	 <arTuiz2iOQkPdHwT@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: wVOix475_KU8V2_XIJ4UU-t0I4Z6HeUh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1NCBTYWx0ZWRfX3Pz844GeKK41
 ixIiaRSEbQ2XAp3dy62052i/DQ49tc7nF0Gzyb7gnU0SFIYoeFFy9UB9cmiVKvM91FG0kWO1NWN
 7KtG95s0WslX+bYii4t8nf+lPYCmLMdyHlbXLzOD9cWG/TKa+zwtRiokhThQrzkao18O5z+KPGe
 ITuBxjVVW07ajerHuZ+ry16mrjU+ekQ3U5rVf88jnGNZNwOv5jhhvQ7mckAZfK31UDz0Ub8ON1J
 r2RQ2DA+p6XQLdJiU5NfI3EiYU6O4xBKj1XVR/CMRNSOpEEndtatLTNe/BQruZZEle+ozvcJcDz
 ofN55prhBdShzM3hTdI8NIXQBsJYhZ1uf18eIDgzGehTdonxhoQSe1yoy1CnICoktRm4wgCO/ld
 5LSENzjyFTFFmlDHeORtibO+/b+wM1EM6hZ5NmHoZqPc907Z7Bu5RKXfuEVRDThiu1btlcPZnz6
 Yp1A0YdfyeQW3JvejKw==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab524f3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=5BmOn03dfxg9LWZ0LBYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1NCBTYWx0ZWRfXzb3MKBOFYzyr
 mx1kDb11idXRVZLENdAOL36ANhA7Xy3JZIkfmWgWptHtL7HA9AlRS1o45XEgGdMqFtn0e2V/8Ev
 rGijqIWb7bAQYh/+N1dUthn9oIiuqwI=
X-Proofpoint-GUID: mNk1XpUK_s02Vdcn8pomy1Q2iB-qdEqD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240054

On Thu, 2026-09-24 at 15:06 +0530, Mukesh Kumar Chaurasiya wrote:
> > +			 */
> > +			if (!(bytes_dumped =3D=3D source_len ||
> > +			(type =3D=3D RTAS_FADUMP_CPU_STATE_DATA &&
> > bytes_dumped <=3D source_len))) {
> > +
> Extra line here.
I'll fix this in next revision.

> > =C2=A0=C2=A0				pr_err("Dump taken by platform is
> > incomplete (%d)\n", i);
> > +				pr_debug("type -> %d, bytes_dumped
> > -> %llx, source_len -> %llx\n",
> > +					 type, bytes_dumped,
> > source_len);
> > =C2=A0=C2=A0				rc =3D -EINVAL;
> > =C2=A0=C2=A0			}
> Can bytes_dumped be greater than source_len?=20
> If yes then the error is misinformed that it's incomplete instead
> it's corrupted.
> If No then shouldn't the internal check bytes_dumped <=3D source_len
> should handle it?
>=20
Yes, It can be more. The wording on error here can be better. I should
change that in next revision.

Thanks for your review.

~Shivang.
>=20

