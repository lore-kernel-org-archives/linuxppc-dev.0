Return-Path: <linuxppc-dev+bounces-20544-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD70CD342C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 02:30:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9x6w5Tbpz2xm1;
	Thu, 07 May 2026 12:30:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778121016;
	cv=none; b=E5DftTNFV5BDKDWFFFUtkPYQ9sV+zUgZw+UF6YCprGrKdLWE+gYEw6SHB3Jd/RDYjAoYIF+CVBhZrBxKuq9TqLFX/M0ROq4rAAM+95cPjTF04Fm7jqIoG2uGvMpoYOrGVsg4HqCBLU2fn23g2TbaeC4LWXouA1bABITmOLwlaVXZsNTfF68JP6DyO+ZFHoBC61Qlz0YktP2TESONCr8K8yvtBPCLlsQupG4RkMSAtaNVxJL/c0I4u/9ERZwLlxcs4P1e+a+HxqlWTvITpFITyhfydZTvbVu0x19FGXWNEuQc2U/p3Ae1O5Ejp48XVA/yoCJ9s9UXhkU68i8uSiObkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778121016; c=relaxed/relaxed;
	bh=Q2Xyt8OQpnsAQ/cFUq7Ld59Cdlzxoj1hldmsNg7MLnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPK4cKSTNj68OByO0kENnE704K695WUDXFQtm6kYWApu5DUjhzsq9xxZyNpfQuOpzsICPICHoDuxUiv6gz+21OGuzoBOeK63VA6M4SC2NRpRP4EVhIYDIPIl6oNlPZhf9Dn+nlGRlnrN/4PSTpeUxhP18Sh2G5hmj0ieIYLRVK+GJUXZy75rYWFeC0G7R4K7BPai+PLzeR+gBTSUhCOVf4Eqnvm+kamRwothrctXC/g2Lf7EcaHaYwXDPksvKL+x9ku7ME2gRlsGf3bkGtw2VjT42vot39fVf1OKVL8O1X+ijt2DrO/UaMBru8ZjnUrwZX7mi2n8Ii9Uhcb5vcF3pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=C9V0kCnK; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=C9V0kCnK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9x6v6fRBz2xlm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 12:30:15 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646JieWS2217751;
	Thu, 7 May 2026 02:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Q2Xyt8
	OQpnsAQ/cFUq7Ld59Cdlzxoj1hldmsNg7MLnk=; b=C9V0kCnKvXXxHX3952uYcN
	4StIVa1PIN5yF7tt++PUmmfKbEeVt+igN4/hRefrZD0dzmRnhdPFLPS5ZVRzFpJh
	kF4p2GEplXO0D+UFHB4+1EDiK3FQf0JOIxCQkrgdDWg1WfG/J8c6TiUWbqE7MLmN
	Ls+Je/2Iz3KtrlSnIzslf0N2JxN1TB/FPnunWs7FUaQv93Vi3gWhGWn9qwUnnflq
	ofonITtvpzqXIR5dBvx9JH3j5PsmaUiYV/9KFHm6D/VcIRXyWxDduJXeJZ0+RDTI
	vvSsNvA5RSuHRXe1sTqgiTNOT94a+CTVjRxxEwB2yzRc2gHYSJHRa4hvOjLrUErA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4us38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 02:30:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6472OcTC013566;
	Thu, 7 May 2026 02:30:05 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukqhaem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 02:30:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6472U5Yb29557334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 02:30:05 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BF2D5805F;
	Thu,  7 May 2026 02:30:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5975A58051;
	Thu,  7 May 2026 02:30:01 +0000 (GMT)
Received: from [9.43.90.101] (unknown [9.43.90.101])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 02:30:00 +0000 (GMT)
Message-ID: <3bdda159-ca5b-4a17-935f-46eec9adc74a@linux.ibm.com>
Date: Thu, 7 May 2026 07:59:58 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] powerpc/g5: Enable all windfarms by default
To: Linus Walleij <linusw@kernel.org>, Michael Ellerman <mpe@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260505-powermac-g5-config-v3-1-7747bf72f874@kernel.org>
 <5a28c484-5500-4b68-b837-28d30648e592@kernel.org>
 <CAD++jLmBn4moNJKp8TLmMvdmSVaT4qnY10OuBMEQmaZnO8D1JQ@mail.gmail.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <CAD++jLmBn4moNJKp8TLmMvdmSVaT4qnY10OuBMEQmaZnO8D1JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDAxOSBTYWx0ZWRfX4jbiZexYgQg4
 9UocfKyG1HRArW9aZoCsbd5UtLFj8muuLup+xwZOdUEuLLrk16cSkS9YZPuaZRlLg5gz2swV5gY
 9jxSZ/bR4k3mh+PRLk6/HHji0kK7Aq1OcFIDVwJ6V/JY8qObVekfzYk6nJKHv0z0DOpTRnxTnI3
 rFd6LgWu9gRQrEtoZ2uCrFsTgAa/Nc0+OlLmlYqk+PP4bQeF64QzGzVH3rgX2xY3bYxKj4atxNm
 1XWC/S9UaTs7Km0ckhefYB8pZD3QgrzyswfvZ4awi7E0Wm0konD3hgbZN/yhFY/ROkIKquege+M
 HRT4olfHug5jD6qtRmHmPt0eDclNu8OxOP+SSHIPiP9heHrOxvKHuPnuXSClgz0wLqNSg2qXYeo
 bZa//t08DKjCgNnulK5L1CRl+3OpDLv1yySvD5hwI5bOIojgH6U+vtLA/wrc7MBm3YOTygCgGPj
 0nAfO3qOb2RLSEjbQhA==
X-Proofpoint-ORIG-GUID: v8RHmUvFBR5jhjmnbatV79pfX9PFjowF
X-Proofpoint-GUID: CjfgaOd1loug-Eiz4SpwRoWQ1hDtjelH
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fbf92f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=vnREMb7VAAAA:8
 a=VwQbUJbxAAAA:8 a=dAP_cPKA4Pf4eObYin4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1011 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070019


On 5/6/26 11:00 PM, Linus Walleij wrote:
> On Wed, May 6, 2026 at 1:41 PM Michael Ellerman <mpe@kernel.org> wrote:
>
>> I don't have any G5s anymore, but the ones I did have used the other
>> windfarm drivers so I never hit this.
>>
>> You might be the last person on earth booting Linux on those :)
> Not really, Sean (Action Retro) did this thing and follow-ups on
> YouTube:
> https://www.youtube.com/watch?v=g-Ugfqj1ank
>
> Including installing a contemporary graphics card:
> https://www.youtube.com/watch?v=WPDd1Y0flSg
>
> This likely means he inspired a whole bunch of geeks to
> go and do the same. :)
Interesting and good to know. Thanks for the links
Maddy


> Yours,
> Linus Walleij
>

