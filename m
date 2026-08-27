Return-Path: <linuxppc-dev+bounces-26140-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B82AC61DB9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2026 06:37:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVsHv5kJbz2y2b;
	Thu, 27 Aug 2026 16:36:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787812619;
	cv=none; b=gnnxJwtyOUwm0UBGTD7MTVYxE4XDSbCkpNsWKBmCuUVPJi0XgVMFBwx3zZN/zAyr341HT6cy7pi3qXRCctswJXHf+bAuwwi6l08f43gvdrn+LrNM0KgzZJ21o2wFMMRK744P0Gc7wUrKv/M9zNVHq6SxyxUX+5psM+0PQ6r9H1A96Nz8a/2vIMnxmXXWXHlIm7xhRH+7eiS0WyyQAfbowhmZ1ehX9DAyAIEkU6o4wCwxyOJdwMl905cjvx4dEThYzNe1cxr6rLKqaBNgR8eniszuOLEYRqhnr52guYytPDJFQRKdGZMeqE75DnE/bSdPos4heWy25VIQ7qZtYv71DA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787812619; c=relaxed/relaxed;
	bh=774X5XYQfk2yYWBsf0UUS3OosFUHf1+lQ1N65JAXb9Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CZedmZJbVVcAssR2BDe7Ju6PXYgJ+DhF7B8w75/8HqNxZAc8DQQWWCUTSON0670+2t5/jRKxHimu2dv+6g3oP6suBpDLaxQe3euxjO1EJU8+qnJpymFFUrGCNZnPNu97FM3NSRas2qfPgtocVzwPxtME4QXAKeXL8ZoomOy5cwJWLdsIEH+mNTlwdlaZpjeAucZgRhUOQKiLIl2z0MpzYfVXH+Y7BeMLbB7XVL9vm9XUFSxkeYdCWnA4pymfON2yTgJbTaDGbtEzkjjDn61UCSvdeNj50DBwDTCCFU3dapDvhMxpjYOMtQKuqxGIH1Ui3qxU62wz5pjW5b7KCKy+aA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e7OBJsjn; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e7OBJsjn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVsHt6jtPz2xwN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 16:36:58 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6Vc2L2266280;
	Thu, 27 Aug 2026 06:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=774X5X
	YQfk2yYWBsf0UUS3OosFUHf1+lQ1N65JAXb9Y=; b=e7OBJsjnRMpFf9wetTIfnZ
	cRSIaBwpBoZbiJ6y96yFXOrj2FFooJrqveN1GbiE7FjkWSevwhqHAXAcZcDj9sYM
	WYrhGRjs71plXN/vkCcdDDmBM/Cb1cV6/u8gGRreagg4IXdYk9aVI0/JW4dFxYhF
	C4J5NmMESGSxhiV3z6KOYv0bs6Rsaq8WlHsw6JJfoo5xT1Ofd8RUjD9gYsDtwNjJ
	TG+zqO4NGhQ+ERGqKC2hAhergsWxbSS7QV4YJ3tRuH9phNYYCge4KgA2cGFPo6+2
	T9nbo3FqGD99aNXi98/h+LjhwCMq9FKXDygnB5vWAMsPOubSLhDtw8I9af27cLpA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxkafv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 06:36:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67R6QeqT028927;
	Thu, 27 Aug 2026 06:36:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsye9gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 06:36:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67R6ahsW50725218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 06:36:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E4D920043;
	Thu, 27 Aug 2026 06:36:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C9AC20040;
	Thu, 27 Aug 2026 06:36:41 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 06:36:40 +0000 (GMT)
Message-ID: <7ed10640c0b27403d7e9ef9807b957cff59eba60.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ppc/fadump: collect dump if the collected size is
 lesser than reserved
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: adityag@linux.ibm.com, adri.vero.dev@gmail.com,
        anushree.mathur@linux.vnet.ibm.com, chleroy@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com
Date: Thu, 27 Aug 2026 12:06:39 +0530
In-Reply-To: <1a0a3a16-b92e-47ec-8545-035022583de7@linux.ibm.com>
References: <20260826125626.2108771-1-shivangu@linux.ibm.com>
	 <1a0a3a16-b92e-47ec-8545-035022583de7@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA1MiBTYWx0ZWRfXwp01h2IqJNBB
 JCKG/0W6PdQQjIB+HjkDmLaF34bkCSNkMfWhQvs2NRl7pKQZN3bhXxejAXvkBu30XmRoX5nMJfk
 Pdx8ZQf1fccObXNCjkatC2ayRpQaQn4=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8fdb00 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=KmcBeXU3GxEOogffeAkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FCF_hExInMVtTzag69QzXVWCkA5buUqY
X-Proofpoint-GUID: fIJQqww17JMr5S6blgc3OLLDhCy5cRAo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA1MiBTYWx0ZWRfXwN9U1ZECMXiD
 t17vb3b3nZmqIjxajKdz43UPCYbijdQX79C4rVWLuO8UkjFVM9KKKfU1pfDC/fWk1rhuInprQ8a
 auZvUVgN7Q1Hd2jMsLoLxeUzbg5xgBSOnXcWeMyZbzlyfxymxNGeALCrUrDZrCLKGp9QwfvgIQz
 5TDKJs5gzcsGjBlZKP2Pm3esvhneUTiI9DbtHiHyIPmq7vwKPgqPLUEQHsQc2LlS8fKDooKYUSj
 sE/Bn38YNqcBomMgzLja2AOC/e7j+nxXCT3bVu9ee9utQsSc14l82MCa5Vr7jQVVApILdLvyRTh
 iWHAwqldG/BhJL2N7wcy1o5nPKJ6DH4HgmQiiNYJ+bboJmSVKAtaPl4oTadec15z9k3L7ZvQ5kR
 9XwcphxbNFcm3gJkfgNtFKnSVuUcM8oc4IUL3hRbt26IDT59BWHCS2er2pGovywn1caVhYe98v/
 EG6OUeOTEGmn+7LJLmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270052

On Thu, 2026-08-27 at 11:05 +0530, Sourabh Jain wrote:
>=20
> > bytes_dumped <=3D source_len));
>=20
> Do we really need region_collected variable? Can't we manage with rc
> only?
>=20
> Is bytes_dumped < source_len is good enough instead of <=3D. There are
> a=20
> couple of warnings/errors reported by the checkpatch script.
> Please address them in the next version.
>=20
> - Sourabh Jain
>=20
Hi Sourabh,=20

bytes_dumped < source_len should also be correct, but "<=3D" is more
expressive. Why not leave such optimizations to compiler.

For the region_collected, RC should be used to manage the return code,
so I as per me it is more appropriate to use new variable here. Or
maybe, type the condition in the bracket itself(?).

Thanks for pointing out the checkpatch bugs, I'll send a revision soon.

~Shivang.

