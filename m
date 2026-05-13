Return-Path: <linuxppc-dev+bounces-20826-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AFACD37B6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 05:42:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFj5q4zNSz2xpt;
	Wed, 13 May 2026 15:42:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778650943;
	cv=none; b=VB1LPbaE2qs6wgY80SpVOkMQj1hFszDQ3XmYNNW54tjajDnLSVnkhYqCsADdVevI6vuVIc7FHLkXosMDNPquk+vLsDKeJ5KiwPWtu9Qfm/IvAzoK7j6Gf8Q2ooontG4wknl3cvKDjZY6s1YtEmkc3GZ8qnY9pOaJcH2X6PUMrSHDtSmqK1Bs26WPm7SKygFsI3xFmukEzNZaFuIOXFyh66b1jOMDbBqkeWTbogfbccsv/DgG7fZaD5oxq1vhVXD0Q7ol/GNSNjfkitWATeA1kgom/4nU80j4B8GB4e44TJOCjxQeHofHVN71kLGaWJlLdA3kXKQijGYj/pDmg/nx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778650943; c=relaxed/relaxed;
	bh=xuq5LtljQdLyoPY0FCPpzNs5AFTl1JLRU0TOa/TpHJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlcI9sEp0/GSXmiH8CiGADOmWQ05swT7XquTmdiyiySU+yIAorZEx/pRKoRBBFs4lrsOhG+5FTa1cuiT1GqA1HJWXvHs5TA6pYqpuXmHLaI8wLSPUtnBjjGTN+K1GaVhC4HIZfDinxfaRzfGf7Xgr8Ikv2FgBvJDBfTUCQA08RnXIkapkGYIED/ictWWGkWYrZOVPhgxc9XobYnWT8yVw9kHAgZEsS5c1T1Dll7Czxos+gdiGHyVDoE8VW+05FA1HZiXMWJcYeebiCIRHLgVwaFLp4YAFPYCEak2YTbY9bvsOe/xS/FyuCQtMISJb+Va7Wz4mo0h60/ZT8mqMeV7VQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eW35pEXU; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eW35pEXU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFj5p3bRRz2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 15:42:21 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D1h6oG3179743;
	Wed, 13 May 2026 05:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xuq5Lt
	ljQdLyoPY0FCPpzNs5AFTl1JLRU0TOa/TpHJU=; b=eW35pEXUkTCuoW3PKeC0V4
	4l+VwBBic2vsKReVFYbadXMHaFZJ2dxd5qjxfGtAvYUmj+5ifsFsqv03SEViIzQg
	bemffswkjLW5HsJlzmNnqU4D63EWxWTjOGD89tGfZV0BD8+I39TfXRgw0shzsR7h
	yX4+vyhwZqw6yW8AY+njLYcDfe6nrptk6q9SSTe7LkzReb1WzRef5T9TF237wJcd
	6n37gjy5O99jnRh2kTMGmhwGE7w/GtskxW7xUdexEQRAbxaAlp1FYloYRyEH6Pq0
	EhbjAbhYz2QjZJpPp+Bh/1HOezr3xxN01VCtsWyarIgjgtj0FZf+TYJnZud0renQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6nxnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 05:41:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64D5dZsg016960;
	Wed, 13 May 2026 05:41:57 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgecwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 05:41:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64D5fuF329950532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 05:41:56 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A2BF58058;
	Wed, 13 May 2026 05:41:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FF7D58057;
	Wed, 13 May 2026 05:41:51 +0000 (GMT)
Received: from [9.123.2.213] (unknown [9.123.2.213])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 05:41:50 +0000 (GMT)
Message-ID: <09e72f42-e180-4e2b-b379-92b755792a2c@linux.ibm.com>
Date: Wed, 13 May 2026 11:11:49 +0530
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
Subject: Re: [PATCH v3] powerpc/audit: Convert powerpc to
 AUDIT_ARCH_COMPAT_GENERIC
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>, Eric Paris <eparis@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        audit@vger.kernel.org,
        Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        ritesh.list@gmail.com
References: <261b1be5b8dc526b83d73e8281e682a73536ea28.1773155031.git.chleroy@kernel.org>
 <CAHC9VhTyOuuPs1uovodM9M_8zZeJnVXs9xrWSdPhZcjXUb=mvA@mail.gmail.com>
 <fce0a701-ee58-4cb2-b34b-8aec26aaab5d@linux.ibm.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <fce0a701-ee58-4cb2-b34b-8aec26aaab5d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Us1T8ewB c=1 sm=1 tr=0 ts=6a040f26 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=1UX6Do5GAAAA:8 a=aow-egSQAAAA:8 a=U9SjFSZQ4YHa6oGgTWoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Et2XPkok5AAZYJIKzHr1:22
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: uPkV2bk2g3EF9lFjnjbKhq59e6Nnuiid
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA1NCBTYWx0ZWRfX6W1Ko2CSd/96
 P5y3UOVboC/cf4CJS1ogv4tqDnIdlcgQeKdqF003TOuORnULKnUdpWDmqgSGeKzgM7kE1jBxHxK
 z4cv5/SMGmWdFLyEeNJfXj3x3mZpEaCdqZSobbWBsTvLBUzx2LQW3WPjuZwsY+5ebwYsv+6DZma
 6jMobCfaU0aqImmYueRRt1TGfmWz3YXJO/us8kwO17IgMlqTLAiyofyxOV3aA3YperIKWDe3GpW
 vRvS/O0mJ9/Q+VSH781kGkd/P0QMYAFFolLthELkSsYXGdJNGctc3FHA/XrAZSC5U7mOFu1rDpr
 4k1EpvtX65fp3/IsxnNf0eZQw4jovdJ/I1gHhePF7SY3lQxyr9E9WGIZcK/lYB0SdxnQY2Pfr+d
 w3xY2X7YRtSiAjmmbjEmbe1zCuvl1psvr7Ae1jOQnqbhvsbRovcXB7idZKdZQHN2sJfWdeot3W+
 7ZJg+LpnNEPeTn3dHMA==
X-Proofpoint-ORIG-GUID: dl-Rp2Qq6poBOLRUzMiY-CJkCkQAyW6e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130054


On 5/13/26 10:05 AM, Harsh Prateek Bora wrote:
> + Ritesh
>
> Hi Venkat,
>
> On 11/03/26 12:49 am, Paul Moore wrote:
>> On Tue, Mar 10, 2026 at 11:08 AM Christophe Leroy (CS GROUP)
>> <chleroy@kernel.org> wrote:
>>>
>>> From: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>
>>> Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
>>> targets") added generic support for AUDIT but that didn't include
>>> support for bi-arch like powerpc.
>>>
>>> Commit 4b58841149dc ("audit: Add generic compat syscall support")
>>> added generic support for bi-arch.
>>>
>>> Convert powerpc to that bi-arch generic audit support.
>>>
>>> With this change generated text is similar.
>>>
>>> Thomas has confirmed that the previously failing filter_exclude/test
>>> is now successful both without and with this patch, see [1]
>>>
>>> [1] 
>>> https://lore.kernel.org/all/20260306115350-ef265661-6d6b-4043-9bd0-8e6b437d0d67@linutronix.de/
>>>
>>> Link: https://github.com/linuxppc/issues/issues/412
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>> ---
>>> Venkat, a test result with 
>>> https://github.com/linux-audit/audit-testsuite would be appreciated.
>>
>> Yes, I'd like to see confirmation that the audit test suite runs clean
>> on ppc systems with this patch applied, and unfortunately without a
>> ppc system I have no way to test this myself.
>
My bad, this is a miss from my end.
Venkat is already on this and will update the results here.

Maddy


> Is it possible to include this test suite in the IBM CI ?
>
> Thanks
> Harsh
>>
>>> v3: Rebased on v7.0-rc1
>>>
>>> v2: 
>>> https://lore.kernel.org/all/a4b3951d1191d4183d92a07a6097566bde60d00a.1629812058.git.christophe.leroy@csgroup.eu/
>>> ---
>>>   arch/powerpc/Kconfig                |  5 +-
>>>   arch/powerpc/include/asm/unistd32.h |  7 +++
>>>   arch/powerpc/kernel/Makefile        |  3 -
>>>   arch/powerpc/kernel/audit.c         | 87 
>>> -----------------------------
>>>   arch/powerpc/kernel/compat_audit.c  | 49 ----------------
>>>   5 files changed, 8 insertions(+), 143 deletions(-)
>>>   create mode 100644 arch/powerpc/include/asm/unistd32.h
>>>   delete mode 100644 arch/powerpc/kernel/audit.c
>>>   delete mode 100644 arch/powerpc/kernel/compat_audit.c
>>
>
>

