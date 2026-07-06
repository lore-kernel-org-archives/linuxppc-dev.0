Return-Path: <linuxppc-dev+bounces-23586-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521B4C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 06:04:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtv1z4cNDz2yfS;
	Mon, 06 Jul 2026 16:04:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783317847;
	cv=none; b=GXpiJT9Zhm1Dn8edeAFKUVpaEmm05rXKW4P7IDB4ccnXVBZ8KCB/qH16zc8m5rZYG54fG/gD0TcinA8WyG58MQ6PavojNeSUbXt+DILPnvikCblaS31Mm0rX2hqrMhmUr1fcuehb7gFlmfKPSWYuGgV9JdbydyIBG1XLstSnYgqaTej+8jUZIxSzXjfvCvKGomXPoG4uHBrO7sESYxJBqt5AuU3fejynOiMXLEdlqaTFRHpG41g+VUYk8VixFvCsIjdAvGm3kLgQ5yyGKBOxJaSh9ZbQVqX2I36eCqQA/AujhQPIQ592gRUoachFg5UVBhxpetGf7pYF2120dkPLng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783317847; c=relaxed/relaxed;
	bh=98p+H6suEVoGhj8b+aF3PmEbJAz+Vvv4cgwfXKZMd0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEVzGg8qPaYr+djnn92Wk8V/iaTP0qmyoaFRY5t9zzVlKZ3W/bv7ZoKPwqeiPctu9A11z/NbKAqHH4ccGt4oSPFKt2r/zX+xjaqhdD3XE8N0g++ISL63St5gfhKLRJLrjoNDoqmavxDLwJI7o8Vzp9jc/7ko527nuvrnOlbAaG8mheXpgRsotJZQM9trjIEY9cOMxQ2EvqNlMEOD/2wGKXSe4g+l+8HbiWhhudDfzTy8nIqIMmpZJDI012NTo6VPiUyFkPIlXlNbPgUFfD5MnUJqaeQiCQGWShbx1arPyyz3w5VBW6SlQLeOjcDwqki52/LqSrtk/gmyu46YA9ujaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=N92goH3C; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=N92goH3C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtv1y0dJnz2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 16:04:05 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MIYX61515279;
	Mon, 6 Jul 2026 06:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=98p+H6
	suEVoGhj8b+aF3PmEbJAz+Vvv4cgwfXKZMd0E=; b=N92goH3C+6uBVwKR7krCkm
	ssGv+vf9zmt3pfCWRBn0u44khcMQsw5Xkffl2wDDOeZm7tz1h4QG7HFhBT1hXN1N
	MLi9ouQyWb3xzKClSCFTLZlUPDbxT3ig9Z/5U8GUYklQYTo5i93TU/SkTk/7DzaJ
	xW5wNSaP3h9IPWCdUycbja168DuxiDSWwjzTeuGRFmD1fR6aFl/Xn9NQ0PEkuO2+
	yVjw+Xv6JeLCxl1aujQ5AnpB9prCddO+Zj+eavOGhUrtSVNFvjeHjY11GIXnsUAM
	g/rl4XqC7HfDnLpH1fWMNK95ePdySb77zydcN637kPu4lnhWkwuvW7mvMYwYpqFQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdghpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 06:03:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6665ndvB018298;
	Mon, 6 Jul 2026 06:03:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgpvgme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 06:03:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66662wQP47972786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 06:02:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E07B2004F;
	Mon,  6 Jul 2026 06:02:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF7A620040;
	Mon,  6 Jul 2026 06:02:50 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 06:02:50 +0000 (GMT)
Message-ID: <7f013fb9-c3fb-4c03-8a2b-cd395cc1e113@linux.ibm.com>
Date: Mon, 6 Jul 2026 11:32:49 +0530
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
Subject: Re: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
To: Andreas Schwab <schwab@linux-m68k.org>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, ryabinin.a.a@gmail.com,
        glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
        vincenzo.frascino@arm.com, oleg@redhat.com, kees@kernel.org,
        luto@amacapital.net, wad@chromium.org, mchauras@linux.ibm.com,
        thuth@redhat.com, ruanjinjie@huawei.com, akpm@linux-foundation.org,
        macro@orcam.me.uk, ldv@strace.io, charlie@rivosinc.com, deller@gmx.de,
        kevin.brodsky@arm.com, ritesh.list@gmail.com, yeoreum.yun@arm.com,
        agordeev@linux.ibm.com, segher@kernel.crashing.org,
        mark.rutland@arm.com, ryan.roberts@arm.com, pmladek@suse.com,
        feng.tang@linux.alibaba.com, peterz@infradead.org,
        kan.liang@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
References: <20260427122742.210074-1-mkchauras@gmail.com>
 <87wlvazrdy.fsf@igel.home> <1693b268-ee26-4764-871a-5a067ae96080@kernel.org>
 <8733xxve3h.fsf@igel.home>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <8733xxve3h.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4b4518 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=80_pbJD88MFYAXRLd50A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA1NSBTYWx0ZWRfX9B8GBgNO7fAm
 3qswhmql8PZ+M9FLpAbodGpTmGWEyms9j5tj8WB2rnkLXJa6VXpU2zvkbwZLVfeuLiTmfTV3nNt
 3/bqlfCBsjnnplW5dE2tovPrQ4tqI8tm3YzedpNdO4/u/dwLyekffQ/Ci2oDLXWU1H2V+lbMjW9
 5VTwtfOkD7Dxu6D2cIOuDN6CO2NGm6SLO9mJ8E94WVRd6dHBYxElZx4xeUQAYs0ludmt+Q/ADVo
 1pRtF5okNtyNMUgCOYbVzEVzjiYsDqbxeGxUJd/jLzzcCE/gYKd283/m9Bncv/L9rY5kodYBY9W
 Md1dY33ryVXUGzebRWA+BVSs2Xf/a80+JSDkmqkxOzM+JEO0cVvYvFZrkxyyX4eTRdoxtEPLTFi
 08mDMaBPppEUMOYUU/jUYImaEOsptG6mxvE6sRIe3i2jiOr5N2bHA06gAAZ+g6a6Z7BfUYIFFew
 a/L2eCqRp29QsZQL6ng==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA1NSBTYWx0ZWRfX0cBAzrxA653e
 5WtQniRTwLLND1MdEPYxY/4nIHfSxH9NaDPfRUlq9QonVcR2hbPKja/zb1vLDj3WE33TUVZ2kHY
 hya7bz17Tsv0qOgb2NLHRvhQjHOxy+k=
X-Proofpoint-GUID: hUdxJ9eovfhkfPLhD8ybsjVgdN99M6eb
X-Proofpoint-ORIG-GUID: Dml9H1R2EgyKqVNI-uUfnh494UHp77CC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060055

Hi Andreas.

On 7/5/26 5:32 PM, Andreas Schwab wrote:
> BUG: Unable to handle kernel data access at 0x30af548c0000028
> Faulting instruction address: 0xc0000000000af47c
> 
> c0000000000aee6c <.sched_balance_find_src_group>:
> 
> c0000000000af474:       e9 3f 00 18     ld      r9,24(r31)
> c0000000000af478:       e9 29 0d 48     ld      r9,3400(r9)
> c0000000000af47c:       89 49 00 28     lbz     r10,40(r9)
> c0000000000af480:       7c 0a e0 40     cmplw   r10,r28
> 

Does the stack-trace change every time?

There were couple more fixes on top of it. Is it included in your kernel already?
https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=next&id=334f3f6d7a1660fd65597bad9960bfa33a716d35
https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=next&id=4e1187e12de40b5301977b2476d21b569358dafb

