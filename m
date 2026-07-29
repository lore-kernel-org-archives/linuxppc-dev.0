Return-Path: <linuxppc-dev+bounces-24973-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A081C54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 07:01:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h93CB58F2z2xrL;
	Wed, 29 Jul 2026 17:01:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785308470;
	cv=none; b=BjngdEK6k4m9HSNJPDHeUQhLuHCmoF3/Z5uiHn/6DR+F0KNRg+91NKWuhuGSzYXi1aE74leZQjwT7KSEFcXPZHS5vH4oT5tuRxGmeGs1aGx2L/cR7nQ6SbSpOuOLv+0IDyacEP4Hf5PpUh2TpUhevMRUdAwqmHzOge5RRH77rTDUtHXYfC6LW8Bl+xCTGWn37sPnTusvzyudVWD4DRGs1AhlcV/Mo1dZJZ7UUi1uhi6xYmCQoLsy346pvW2Mz9HymH0aclolUCup0tj04kltrYh/e6NDHpBAgEqShy88C6NoGt41wOpr/GKF2J3+sN+QazvYrsNogWl2g/GjsOzDbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785308470; c=relaxed/relaxed;
	bh=A/W1A44PThN+VxYJRKc1pgZWf7SnzxtSUYjq6FS+5F8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=POP2MEaAjRy0jxspk3YVOFFjOz/JHQHkT6FfOPbbAThBUGU/VMrRiduaEYKaEhtjdik8LHB9Iybdx0VL5e/iLi61O/QsxFM8snI1X74o5561rEdqRqi9Uu+E08F/jtBJcUj5yRul61RZXE7+pCw8GWE8u//NfboNo/0reMjrNoZMLR9TjYJTHerEGsU1bLA6wjjxkHr5hRepZIXln/pNX1FB/xxSVNmrV3Z0rb2uF4EXDyQk/ROVEnKjkEXoSICCV+XFYfwBlEa4NLxE7YiyIweJ9vMr1JNLJ5DtoLaKDjEMsAQv2mB4pXBQuUuPXS+y4DD6mQMpQjpacutKNH0kyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AGaTB/3z; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AGaTB/3z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h93C944Khz2xFc
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 17:01:09 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T4liKY3128817;
	Wed, 29 Jul 2026 07:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A/W1A4
	4PThN+VxYJRKc1pgZWf7SnzxtSUYjq6FS+5F8=; b=AGaTB/3zzCBg0qlIDAS560
	QSsDcUOSuBnOQsQwUX9X5hpOl53vUFdGJQZESyIr6QekAvdqBgZJjqy59mbgSB55
	WzTndFGz4ttk+gQep4hfhImebAFqO2MSfkFkA5hzIpVR/QuXmsLHEocd/Fj/f1L3
	AyP46Bi1kG9Np0xhap/drDCqzjysiVPxmK9iXErhKppWwZYgmxUX1b7byZzcr4Uf
	wBkEeed3fQIWZJER1qHS14/1lNdwPmpITrx+9DrpqX+BoaqiLgJYxHe6MMhxFrdZ
	a/nWZYaO+NeLwVO6Ys2nlEaeoppDIzu81GU0SexJWNNDheNmoH12AwRyoyUEGkaA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj8kgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 07:00:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T6uHOh009785;
	Wed, 29 Jul 2026 07:00:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw5qkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 07:00:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66T70pmu47841622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 07:00:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11A402004B;
	Wed, 29 Jul 2026 07:00:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DB0E20040;
	Wed, 29 Jul 2026 07:00:47 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 07:00:47 +0000 (GMT)
Message-ID: <4e7bd9342efa0cbdd162445a994f73c9ad473645.camel@linux.ibm.com>
Subject: Re: [PATCH] ppc/fadump: collect dump if the collected size is
 lesser than reserved
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, adri.vero.dev@gmail.com, adityag@linux.ibm.com,
        anushree.mathur@linux.vnet.ibm.com
Date: Wed, 29 Jul 2026 12:30:45 +0530
In-Reply-To: <7eb8ed5f-0652-4675-9369-913a17463093@linux.ibm.com>
References: <20260714173010.615682-1-shivangu@linux.ibm.com>
	 <446c84c2-8639-4ecb-8a46-1e203a166e46@linux.ibm.com>
	 <afd516619eea338039a6defb123ffaf38cf82949.camel@linux.ibm.com>
	 <72589eca-2e97-4a2f-8665-b2a817a04722@linux.ibm.com>
	 <7618bf3e48f6770a803f8350d0b3b084c23042fa.camel@linux.ibm.com>
	 <7eb8ed5f-0652-4675-9369-913a17463093@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA1MyBTYWx0ZWRfX4Z5Sul/8RpYv
 zybijXXjA3sfSfio3sWUTIiQzhomCSTY0J5UjFvfUb2dgyNyYe3C3PJ3UgnPhQqEb4y9J3j/VTd
 R/D5y8hc7XX1tZWaQkliNJ9j1ZD/T+g=
X-Proofpoint-GUID: FxR4NkjJrGGHUqJiMuaOQ5dQPJoVVKHH
X-Proofpoint-ORIG-GUID: ie8ghA4lw0tJbUIvCBrrCm-DRJqWds3A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA1MyBTYWx0ZWRfX0VB/wOHjx9c4
 z2+MWj8okf+YXyVmTvXjEdfw+zNWj+Fq7O+zMIkKHD9tN4zyh9Xtxak/hStEuzPzLOApBecQqkQ
 7pjagJeCJbDIdrUhYRJSCHbpqyUzCwO6EWCnZJtUDPhGnUrYwPbEd0PxD71y963rZEmafJIFyfX
 6DV4htF9RXDbqWq4MJJIhHbHSSDnKDspNFPPCneP2+ldtQ2z37UyVOk0dHGr5kCE3GnEpHAc3C0
 oabUlyd6RVmZyV160EKg+VDkI/8zZ7lJeLZrHtjbLVkUANEVrOcpm4DhEZc8ozVs1hM2P75SPNz
 ih1P5sengxQ6YwyIR6xULBJGFDCylTfmJSS0mrGZkCjr11rzFPSwZHPcticHopWPhVvU/STrleM
 jUhQ7WHut2rV/c2YoHTzcY+pW68drVj02H525XIgKzkvnkWeBw0Fj/SJxbgwHn08Oo52PtBK5iq
 C7ZayA5aPktBhEAlynA==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a69a527 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=TYIx_TtZ_rMfSVSMxWUA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_02,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290053

On Wed, 2026-07-29 at 11:58 +0530, Sourabh Jain wrote:
> > >=20
> > Yes, I made it this way by reading the dump_bytes and source_len
> > relation. PAPR only says that dumped_bytes should not exceed the
> > source_len. My change reflects the same restriction in sw. Also
> > along
> > with this lengths check, we have firmware reported error flag also,
> > which should take care of overflow (Qemu handles it like this [1]).
>=20
> But the firmware not copying the entire Real Mode memory is also a=20
> problem for
> the kernel, isn't it?
>=20

I think it should be fine. Firmware will report it status flags, right?
There are these valid flag values.=20

Dump Error Flags (set by platform)
 Bit mask
 0x8000 =3D Invalid section data type
 0x4000 =3D Invalid source address
 0x2000 =3D Requested section length exceeds source
 0x1000 =3D Invalid partition destination address
 0x0800 =3D Partition memory destination too small

I think these should cover all our error cases.

~Shivang.

