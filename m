Return-Path: <linuxppc-dev+bounces-19450-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809CBFF5130
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 18:21:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqvf21Strz2ydq;
	Wed, 08 Apr 2026 04:21:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775586074;
	cv=none; b=J6bb+Fo1qM7N+WrsUxGJGtIl2CAg4UsfUJe9nFFmRpyUhw7urwvFNgCvi5x62JnS9vdlv/BmHVi5GJcPElZZlv3yvPA4hmgug5cx2802K9WZHH8E5iyclvaVrlQkalXD2E6h20fag3UAffm5Kv9GK9cXUm13XW7NKIJC/g7jolmSnMLbj++jwSQMCm9ZgFsAqLzlMqC59zdPc87mLVfeiBoBnwmdL5VKZgjh1htMwiEukDlCayq9uvbBfrPmtOQgwPmZWJKBic7aaAMEUH/Jinp/C4ieBe9F6oN4WhsZBhn9Zn+WiG6bDfkosRowJOMsuC6yvb9GqJyZk4uqIn8vqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775586074; c=relaxed/relaxed;
	bh=eNvs0HXImvo0INQNNcJRQbi1TogG903xwwNQgA1mZ9Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XRqHGsFZq70TYRbIPaMYiKqPuPLFA5wpIKj6oI6455PHVGpX8S5YOw90gBCd4iYc1xqfzx3ALXuBXq9dlY+FSt1LCN0nbjsVhq9vHuBxCZTddxHgg3mJUrHxqxwSX9VRECbLtybS4nraCyEFgWYwd3UM55soZ0Sdxs6cv1PD1WzC+uRnoR1C5Np+Omf2NQFV4Q9iKYkNMWYSWqc+SQEm2JTUCUMey+JYiGREa7md3MrvizWZZNFQmOyXe/7tx8LkITXs/11THox6YDCDSO93e3shENH89een02G+wP1LVDgBWQmxWIQfn2mivKKHrqGfgDX8//4c6uwgleYs73K4WA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lFu2AvMQ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=haren@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lFu2AvMQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=haren@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqvf11FMrz2ySC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 04:21:12 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637DXhZI2301594;
	Tue, 7 Apr 2026 18:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eNvs0H
	XImvo0INQNNcJRQbi1TogG903xwwNQgA1mZ9Y=; b=lFu2AvMQ4/KuxTRKdViAii
	DWgvTfxA5vBl08MtlRdTP6asaf8+vi5e/7z1ii0CVDUj2YLAewr6nk5MzSPje+Pe
	FQifXSZbx9h4TBWcGk9blUCZK9UoiCmrlzHKaY2DGh0PEjuaiKvo5djiZ3eq2R/4
	/xLPeY3Ae5udPAiUKaOypOWAMopkts9SgRfY8t1gMqHpXZuDs7MlhWGOvbweiy1x
	34TuFETZXbYNKf/yuhhyHcbH/qtaG/aQtOVLWPT/kWiULw1GHZV1bYkCLlMRelTs
	+5/4a2R5/qAzikiKWRrxfHbXFuv4uc/GIRGjBAHOUo360jrGM5yT1AoDAuQHemkQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fchrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 18:21:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637EIdQt013821;
	Tue, 7 Apr 2026 18:21:07 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf44c6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 18:21:07 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637IL5Ui32244290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 18:21:05 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E27558055;
	Tue,  7 Apr 2026 18:21:05 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9859558065;
	Tue,  7 Apr 2026 18:21:04 +0000 (GMT)
Received: from li-4c4c4544-0038-3410-8038-c4c04f423534.ibm.com (unknown [9.61.150.36])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 18:21:04 +0000 (GMT)
Message-ID: <b1482f1a1aad7b4a271a18836cde8b4e4511d039.camel@linux.ibm.com>
Subject: Re: [RFC v1 0/6] pseries/papr-hvpipe: Fix and simplify papr-hvpipe
From: Haren Myneni <haren@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Christophe Leroy
	 <chleroy@kernel.org>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org
Date: Tue, 07 Apr 2026 11:21:04 -0700
In-Reply-To: <cover.1775569027.git.ritesh.list@gmail.com>
References: <cover.1775569027.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE2NSBTYWx0ZWRfX3nlPNvA6KZnm
 yXICYCfJLvvHJG/W6ZrazHvdgQy2D2+7yzITFjOWnts1AKc85DvzBtMQc8X7m/B0tvd/wXXrbc+
 25sBu0fvPSW0oMXslMiYf3n/JGp+xRlCymktWZ+6Eo4OOcO/0+/WeW5F0RpUv0/ce2Mqu2qY0I1
 9IOK+zsy55RSycuBwE75NSYaTblD7FLvv2AEVeGcxVp974gp0+rMJsgPE5WubJLVmuUMr6kiCz+
 gQM90M4N43bndQxNQ04CJyqX0ylFVRgIrM2uHhpNkgNTqZRS8DCmLG874e9/eoswj8Zp5cyb+7X
 xukljcxWqog0nNEg/489KedyZtZOhYbK53YHaHaN4+MEijtyDwvR+tbWXP5lcckIoer6FFxohsS
 0jagRnUgrhoYaeouchHauqOY3dli8bDR9aRo24nDQZ47AUk/SY/jZtf6eZmsSW9lXHlY/L8/kwy
 /D3EE+MGLE4Bbu4VpOQ==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d54b14 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Fo4P1SXAy8xpn9AqH74A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ob_e8oio59vUEGKDosLsNycfxLyOZP6T
X-Proofpoint-GUID: cZ-3oDN0vbxB39FzN4sgBXDYkyYD6xr2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070165

On Tue, 2026-04-07 at 20:01 +0530, Ritesh Harjani (IBM) wrote:
> Haren reported a UAF / null ptr deref issue here [1]. While reviewing
> that and
> going over papr-hvpipe code, I found couple of more issues around the
> usage of
> copy_to_user() and few refactoring which simplifies the code.
>=20
> This patch series is an attempt to that. Note that this is only
> compile tested
> on pseries for now.
>=20
> Haren, I will kindly need your help in verifying this please. Let me
> know if we
> have a selftests or any other test framework for this, which I can
> utilize too.

Thanks for fixes and cleanup the code. The testing should be part of
HMC/RCST framework. So we do not have selftests. I will work with HMC
to verify these patches.=20

>=20
> [1]:
> https://lore.kernel.org/linuxppc-dev/20260317040444.2785741-1-haren@linux=
.ibm.com/
>=20
>=20
> Ritesh Harjani (IBM) (6):
> =C2=A0 pseries/papr-hvpipe: Fix null ptr deref in
> papr_hvpipe_dev_create_handle
> =C2=A0 pseries/papr-hvpipe: Fix the usage of copy_to_user()
> =C2=A0 pseries/papr-hvpipe: Simplify spin_unlock() usage in
> papr_hvpipe_handle_release
> =C2=A0 pseries/papr-hvpipe: Kill task_struct pointer from struct
> hvpipe_source_info
> =C2=A0 pseries/papr-hvpipe: Refactor and simplify hvpipe_rtas_recv_msg()
> =C2=A0 pseries/papr-hvpipe: Simplify error handling in papr_hvpipe_init()
>=20
> =C2=A0arch/powerpc/platforms/pseries/papr-hvpipe.c | 135 +++++++++-------=
-
> --
> =C2=A0arch/powerpc/platforms/pseries/papr-hvpipe.h |=C2=A0=C2=A0 1 -
> =C2=A02 files changed, 66 insertions(+), 70 deletions(-)
>=20
> --
> 2.39.5

