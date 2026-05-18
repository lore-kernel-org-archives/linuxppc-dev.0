Return-Path: <linuxppc-dev+bounces-21024-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A70CD343F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 03:18:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJjg30KNYz2xfB;
	Mon, 18 May 2026 13:18:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779074286;
	cv=none; b=bcemtlJ6lGbIWnJfjYPTMkISrqyqIIIR1Qj8t5udC1pmGtr3TmvSSAhT+ZHRU6fJpeLxcIYty3pvy9tyJIqxOZDe3aBCh9zgcE/iAv1g2InLjIRE+lyytTgLWhqnJdRXYMI845MakcI04D7F8F7mScFGlYi1ZJpwDc/jI0oNn7kdQbLikjwLsPUVHb5H24kvz/pM3ZZ/eXoOj00guIwxd830n/gksWY6C/KeBnKdC5BQyGPPf5G50uyjc6W77amBH0RS9OehI475rjEmd/l86tWYnr0dy44JJdhOxq1Y2KCWMMa3+Gop7wFV3GWJ/jeZU92BbboXWE/MqU6VnkWJiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779074286; c=relaxed/relaxed;
	bh=kGLEeE9csXNMvLYvViAJJtVJmF37IWudqILJWiMk1uE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O/hVwR2weayxKDCF6oNMZj9DtVbZ9rOtUfOo1pEjYqaYJs+Z87FDnxXv/v7SlTOoIRJPFffqnPtQtzdrJMeukU2KixJLrHS8b1qZmgoNKkZmgpL/ER27OhUa5m6mYsJW6U8CqTIZd3Us/KP9o2kvIniaVxn79/27LOVBtfIWrHERs9OAjhCRvdJwJVJr3uEqt8bD/q0jCJAfaoRfu9q2arWAHae2mYDSDgHNeBYpaOgG5HLE1pASK/tO/4uZw1QOD0iEUWeh/gNewtve7O+hDBmmgsVI1ShfeoDKaSwC0M3y7uHlzkIR70XPaCIaYeJJYSwYM97pmeUcMBp+4M9DUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qXVyFpge; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qXVyFpge;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJjg142sFz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 13:18:04 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HAT3tu817859;
	Mon, 18 May 2026 03:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=kGLEeE9csXNMvLYvViAJJtVJmF37IW
	udqILJWiMk1uE=; b=qXVyFpge+Lq1Yd2eQ1UYCncwPq0VuEaVNaJXaDvBUvhFy2
	PeLI42tTrIGbuCqoZ5W51cyAMEzt7w6a+jho5WeKCjRht96ckApTU0ILg2km9zgx
	p8rprnF/mEl7VR4kye2mI/dOzsSVvm2YNRMo+gPBmV1egJAfu1onCY2z6imIkL1a
	Z6Pb5uCan1A9Z1sI/Cfrt5eNgrqI646PEmfHh1grv+CqpqE5rZ3NAPGHrDXs2ZgR
	aC1Bg8EDXAgslt0vRR9DOfzwNrZhGaDXdFfG7mgz/uTeKluEmG/vWav0ECCjUaSQ
	BquJ+OUicfSIbJHCZzs+HXh0TwlPyQEYPcPYrTZg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h885jhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 03:17:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I39TQl015506;
	Mon, 18 May 2026 03:17:46 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754g3rbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 03:17:46 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I3Hien30868018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 03:17:44 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C928E5805C;
	Mon, 18 May 2026 03:17:44 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EC5358054;
	Mon, 18 May 2026 03:17:40 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.124.214.181])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with SMTP;
	Mon, 18 May 2026 03:17:40 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Mon, 18 May 2026 08:47:38 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: Gautam Menghani <Gautam.Menghani@ibm.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/64s: Fix the vector number in comments for
 h_facility_unavailable
In-Reply-To: <agcaxAANsk5gNzWX@Gautams-MacBook-Pro.local>
References: <20260511080412.50722-1-Gautam.Menghani@ibm.com>
 <87fr3vvfvq.fsf@vajain21.in.ibm.com>
 <agcaxAANsk5gNzWX@Gautams-MacBook-Pro.local>
Date: Mon, 18 May 2026 08:47:37 +0530
Message-ID: <87lddh5ru6.fsf@vajain21.in.ibm.com>
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
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: rRPbrBXtqFZNDjj3CnQF4OM-9GRofx6u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDAyNyBTYWx0ZWRfX2yCs0foMvaJ6
 YBnhF0Ll2WpFb9OUY/qCwFsE2fbTv5fNe3O+3KEVNULyXkkHpsEBFPlHKbgNX0nYANHMFdz+9F0
 qO++1e+1G4d92/qs6CHrj0imcnXlh1ivgY4CK889j3mvb2ULBJ1+nZ3wVapeQa//TH6jGl4KGX2
 Pfuv072w4eI9JeM+ZfMf2EdYcsmULF0cdtxB/KNnxgAUHqdoYl6W8TAoGbV4l0noqgrzWb6PEjp
 JiketkQYa6B1pOwJeH8KZ2B6OZanBsUE/B8/Yw5c4ETIITUbcDf8uRKD1ONKCaBJr3q16ApP+mx
 2jfuH56sDU3elFEo5VHUAXyH6wIJCJiXnh3Ut/6dIK1yeCyRprd250GboKjfl2IT+5QOARhaRVa
 Bk6btx3RsHvPS95fswpDBf3UdFl7zgO+dfTVPTzD9SfFGZMi3zzlppW9/UKpapnEMSvOZZmgVCe
 DFMhx5u+Yh+OmVjKi5w==
X-Proofpoint-GUID: GSVhSdmzNvJzN8TqZbVCh7hr1UPO17i8
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0a84db cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=AfUdzLCmHS7IjoRIdVsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180027

Gautam Menghani <gautam@linux.ibm.com> writes:

> On Wed, May 13, 2026 at 02:35:29PM +0530, Vaibhav Jain wrote:
>> Hey Gautam,
>> 
>> Thanks for the patch. Since this patch doesnt have any functional or
>> code change can you please put a 'trivial' suffix to it patch title like
>> [1] or some other suffix indicating its a non-functional change. That
>> way maintainers can easily pull the patch without worrying much about a
>> regression.
>> 
>> [1]
>> https://git.kernel.org/powerpc/c/d2827e5e2e0f0941a651f4b1ca5e9b778c4b5293
>
> Yeah I've mentioned "comments" in the title, so I guess that's fine?
>
> Thanks,
> Gautam

Bike shedding a bit but using the term 'trivial' might be better then
using the term 'comments'

-- 
Cheers
~ Vaibhav

