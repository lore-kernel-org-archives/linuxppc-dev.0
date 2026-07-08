Return-Path: <linuxppc-dev+bounces-23790-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C934C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 08:33:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwBFC6819z308T;
	Wed, 08 Jul 2026 18:33:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783499599;
	cv=none; b=PCtYXWnooyYgq007pioc4LQbB/x2bUxdFXHzhv0JP0goGyvOtHQ3yYInepmPVGi0XR9zJu0IOY4nF7gLaP5HB2hkFaGl0WAUNPqI1a9nZq1Z6+KLxVvCezLYc6tgSw65vs+3VHH4/7wbZFjU8ui7otxdiOvps5sM+c8t8XsYwdAEwo5o2hJC36OpaEGeO+OhrjogGocMxH+gacGUqUzdZMB0NNLdkMXXgsBHtftUNbEXVUKmGMCwBw1JKLLrL8KYPeW4Lar225Oa4U5fiXAI4E0GoGD0+aCNgaGX+ygxEWMUvgpM0OM6Ot1YZGvoptVKEatIqzEGjve08LrwL8/zZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783499599; c=relaxed/relaxed;
	bh=bVsD4NzAR4LV+499y5IFB67oNeZHsZ3coRs3dCztfho=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jU9hS31jjn5WCgkrh4BU83PEGCKIaUe+WGXXQMAHThUh2PVBYhWebOSW1Yan5G79GIUztjR7BWg191h+p7EQYbW6cacMOIpFyWM1hzq1XnsyT7eZBnlGNL5hMD8WlzMlIUfdo2r0RhqyZW2KG8FW2DLjOMOjXY9l8b1aqUnnvdMedU84fCmlSB+qsZPfGXERuxoS1VIXtDST4jLlTHMwiIPGRpybJE1mvShVDK4HkXr3vUPetHoaVlzabEYQBoDyb1alSfxlPEEaBGZ03cGbd+Xcv2ONhKafs5V5/2hmbiHCSpl00NPIPn1wAF2/f8BmdZHWVW6dQT6wEGvaPvNFWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BDyRAYAB; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BDyRAYAB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwBFB4Hwmz307v
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 18:33:18 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6688ICBb2501452
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jul 2026 08:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=bVsD4NzAR4LV+499y5IFB67oNeZHsZ
	3coRs3dCztfho=; b=BDyRAYABoEYnMsgxtVGkF6ThfZkr6YKujbMj7TjjNn+S8Y
	ERWUnRFQ3srWW3sgxnLLwDfc9O1uWCuEL7ooYH8NPNgA5neFllukM3oVYSewfz4m
	igwZ3g1kDNfYiwB/mn5cSqGQrYEn1ilY4GrqP2yQ6eekOiMlXJq0/1U6fYH9TBe5
	Qox/5tbaJeDSFxacQqEvggRkJgswwABf9lX1f8gqYpWxAO8fN00L3WJVByoAyxlV
	/hSkN4Ijlc3SrszQbzdq6yDVreScbs6YkWHd4XUdGz+YGo5qSLKLmIwqfHnBuzo+
	Ld6QQrpfF2SUh49PU9VrH7ax8E679NpAsGmTICPA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4ufxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 08:33:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6688JuXL007048
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jul 2026 08:33:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgk6txh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 08:33:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6688XB4g24838840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 08:33:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3EAB2004B;
	Wed,  8 Jul 2026 08:33:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2249E20040;
	Wed,  8 Jul 2026 08:33:10 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 08:33:09 +0000 (GMT)
Message-ID: <fa47cb85e275b9374efbf0f992281fa196ddf8ec.camel@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/powernv: Cache OPAL check_token() results
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Wed, 08 Jul 2026 14:02:54 +0530
In-Reply-To: <1be96e32-ac9c-4160-9f2b-23eb29c22893@linux.ibm.com>
References: <20260626123534.396456-1-shivangu@linux.ibm.com>
	 <1be96e32-ac9c-4160-9f2b-23eb29c22893@linux.ibm.com>
Content-Type: multipart/alternative; boundary="=-Z/eeLHiYbgNibad4WwDI"
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
X-Proofpoint-GUID: _LOtzJe0oiDcXFcw3d_-GNSJymqCbFBh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA3OSBTYWx0ZWRfX4iK3vhUVu0Du
 oMddsCVe7hG/5lhLglSBXieey+YvkTtV8QPAbajepF898PpIhu1Caz91HYua6UZtH31A1pqnoFT
 AD9n3frJIyAv2laH/k8h22XNCBB/arZIidSjjl3ZUyeyora4lzzGH4ZdFcZdNHomMDAty+kwUJ4
 s4DyepB32s2LmGrC84OTDGXZqdOAEwZy9xXdI5F0Be7y5C5XZd3+6RzKqy0NyKksDOqtQfYv2AP
 YhBhy9r38LAIzEMo0vxfooWfH+XZcwUZjSPuQdCrS8IqmniKjjVAbHIE3UjLhmHoPmWmYESdAkJ
 vmITjcBhBTX2RHlvtoJ8CzxSEaLbseS1cPQvOVDyeCyoOyyQNIvPW3A4bX4FRQPihCjaOoq8SMl
 6A0KKJl7bdRWQymNhe9gzsXXH7VZrJ+qE8Y0Nvfc15j8zuD6woZKIgUwG/I3tXmAJ/hhIZtNTy/
 70Bv+BC0u7xA6mjy/gg==
X-Proofpoint-ORIG-GUID: _LOtzJe0oiDcXFcw3d_-GNSJymqCbFBh
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4e0b4c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=i25_RXJr9mwm25CwVrIA:9 a=QEXdDO2ut3YA:10
 a=KH4Uaj9yQ7VSa-17P3IA:9 a=8BVnaRfnpVEoPsKV:21 a=_W_S_7VecoQA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA3OSBTYWx0ZWRfX3jPkZHrF9TTZ
 yqD046IdGsRLB2d+hYHEJ/WmIwgiRhfvna98uEDRzFCgLPBxkm5IG13KJvDe+vdAb5UruG4G4Zl
 eQSJ5iFr/kVykbD7YDkx6XksRnRZhg4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080079

--=-Z/eeLHiYbgNibad4WwDI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-07-07 at 12:36 +0530, Nikhil Kumar Singh wrote:
> You can wrap the if (token_cache[token] =3D=3D SUPP_UNKNOWN) check, as
> well as the if (token > OPAL_LAST) check above it, with unlikely(),
> since this function is in the hot path. Out-of-bounds tokens are very
> rare, and after the cache is populated, the SUPP_UNKNOWN condition is
> expected to be false in almost all cases. Wrapping these checks with
> unlikely() will help the compiler optimize branch=C2=A0

Thanks for your suggestion, but Which hotpath code is calling this?
we can maybe change that hotpath to not do rtas calls.

~Shivang.

--=-Z/eeLHiYbgNibad4WwDI
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><style>pre,code,address {
  margin: 0px;
}
h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}
ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}
blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}
</style></head><body><div>On Tue, 2026-07-07 at 12:36 +0530, Nikhil Kumar S=
ingh wrote:</div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; bord=
er-left:2px #729fcf solid;padding-left:1ex"><div>You can wrap the if (token=
_cache[token] =3D=3D SUPP_UNKNOWN) check, as well as the if (token &gt; OPA=
L_LAST) check above it, with unlikely(), since this function is in the hot =
path. Out-of-bounds tokens are very rare, and after the cache is populated,=
 the SUPP_UNKNOWN condition is expected to be false in almost all cases. Wr=
apping these checks with unlikely() will help the compiler optimize branch&=
nbsp;</div></blockquote><div><br></div><div>Thanks for your suggestion, but=
 Which hotpath code is calling this?</div><div>we can maybe change that hot=
path to not do rtas calls.</div><div><br></div><div>~Shivang.</div><div><sp=
an></span></div></body></html>

--=-Z/eeLHiYbgNibad4WwDI--


