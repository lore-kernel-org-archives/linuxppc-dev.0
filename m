Return-Path: <linuxppc-dev+bounces-23669-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0710C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 04:30:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvStw0jK7z3brc;
	Tue, 07 Jul 2026 14:30:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783398600;
	cv=none; b=EPSbnGcRM1i2pcOl8nLjsZq+x1LM5fjvAYK9jA1uGeBtjRUuIfjy9NU+xS6IoP8WEzj5DoqMmlcmUxv9MRzIUyjKAKGmQzjvFd7XUIO4NwR73B0QxTehiRCu8aRtxLm036OSen3g9VyIIV38e81wbqeyjGUPP+E3K51uhi11vml22TBcow0owUYfHTcY6nV+SROPYGHxZYGqvSU7NbvJmIuX/+LVAFgjPLLmkEcz8SWxarnozman9WuLg8R+I+24uDXYw1YqULPhE46Ix98xbQbXydsr4WFai8cRXC1JLBGvAO5guDrTzbegjFWTuuk429RFQ4h2wISh7Nx/kzMBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783398600; c=relaxed/relaxed;
	bh=zBk+0WH3uF1AubSJTBaz9h0Ji7U8tbBsTJcpbEbVTmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHdB6SEKkZS+6ENKJDZVWYV29vd11cRPTyouhqB+5JZ8oadUH2HrHGYUIQPV/XTOfSk8ukedW0jRiCFE2fKIM4sJhTaPdz5fE8kbzFrxpzxx/5pSRG/kR8ANuqw/gFL0/kPvYhf4TpF67Pn/7Zct4+PRcVOccX35vWJK1GPTnH4qYRxDAgg95vQux0zGfd82G0CseNu4lj6E2Xgcu35dtpxFX7Hjc4kaGb5jzF5vNZ1nZ24KK+ewuIJV4xpZnFHkEa79f5+780yssoLiwElbFaaDnauMTW9MXTDb+nCB1QqUaJ9UpPjpEZWu6qo4XwWysLEOqDkT7YMjAFTVEPMV+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gfWEh2qJ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gfWEh2qJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvStt6JMMz2yR5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 14:29:58 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6674InEF2520413;
	Tue, 7 Jul 2026 04:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zBk+0W
	H3uF1AubSJTBaz9h0Ji7U8tbBsTJcpbEbVTmc=; b=gfWEh2qJGa9ynCXAprxJoY
	f6GXKfMCf3Rmcusm0SK3YerNTaYu2ysIPd5si9wMVYm5Xfy1PR3pyxxVO23xIxwm
	mGAjXUsz7rOischrFPcApP2ekxHXx23OKegJPDGVl1z4sDH5cySd1NicpiWGmOt+
	0nRkl0evzLfutBJPar9L7XMinGlHbiJEB2AtS4InjI3RApK1zCI8ZN0N6Nb6WTWW
	dVIjPlzFe+sXgH7x54Hhb02/EU0D8RTk9n4OaXykPI5t5/3Erao5pZw8IPkmc+kp
	ikQ2LbPhalwuPXQ91OfmACMwGtEwiJC96D6wnAgXTmDRUMiVAv4Vx1PmOLyNgS8Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknd02t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 04:29:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6674Jx0p032171;
	Tue, 7 Jul 2026 04:29:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6y0hnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 04:29:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6674TCEs45416762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 04:29:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9FB220043;
	Tue,  7 Jul 2026 04:29:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D374E20040;
	Tue,  7 Jul 2026 04:29:04 +0000 (GMT)
Received: from [9.124.214.176] (unknown [9.124.214.176])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 04:29:04 +0000 (GMT)
Message-ID: <18acdffe-a06b-4bfa-bbf6-e38274700b04@linux.ibm.com>
Date: Tue, 7 Jul 2026 09:59:03 +0530
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
 <877bn9vfd4.fsf@igel.home>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <877bn9vfd4.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4c809e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=aoHAD-nEe2P4sfjmd58A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nkTS0WiPD9ZF7Lh3uvPuU8g-5SXxPiis
X-Proofpoint-ORIG-GUID: 0AJT3fxolVd1Rb-Fz5cRiTc9rGwb953g
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDAzNyBTYWx0ZWRfXwa1SzJqlzJuO
 mR8VlfSdefXV4RKl5hULc6Uj8JGrJUC5Capri7AWMsMxRLotqqRDI3deMRZWwFunKvnkdHZ1FO7
 XFaNOCkkY4Yef0BdUMkYPEoEXSHmkO0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDAzNyBTYWx0ZWRfX+DyJJW+LAQIQ
 lA1Iz418kGuRxLEzDm7hZ2z9epgs5SBBhmn/l7XGlr92uRrFnU4sfrqJAoBv2v+GfqnfztU9Hls
 Oq0xakK+qLFFZgyoHKywc3xgr5f8LmpvbQN4elKLQVEwy/t7HgD+IWozYu5+j2aVEgP+pLdTTQ8
 gjuWi14jGdX8OCZBMG7ZI95n2x9hevAjjXGL0z4r5uFmJy2KfikAau9KHGWYEqhVMO+BO9pJvda
 L6zyqb1VGI2l+qNHCcm9P4/kn9ULZGZy0ANsUMVRgWUweSkkKX2Rsv/FaVONKp/Xn1OeKB/imYc
 eXaeetff+7EuReFWfioTb8PEXuH6MORUdJb3cJoJrY6xt0IVx2BhE2IxMSCfHOYboSfb1I6APHN
 3HJ7UzKnRchiwmIA6E8xe1tA2fnXNxCgq/OsfX5p0koy3d8ff+UyYa6FEi3OpT35xoP3u8tqdJ0
 sLiy29Povsc79tkiBqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070037



On 7/5/26 5:05 PM, Andreas Schwab wrote:
> On Jul 05 2026, Christophe Leroy (CS GROUP) wrote:
> 
>> Le 04/07/2026 à 17:49, Andreas Schwab a écrit :
>>> This breaks booting on the PowerMac G5 (PowerMac7,3), there is a panic
>>> somwhere in an irq.
>>>
>>
>> Do you have more details ? Like at least the dump of the panic Oops ?
> 
> NIP .power4_idle_nap+0x30/0x34
> LR .power4_idle+0x64/0x70
> --- interrupt: 900
> 
> .arch_spu_idle+0x88/0x100
> .default_idle_call+0x3c/0x5c
> .do_idle+0x194/0x2b4
> .cpu_startup_entry+0x3c/0x40
> .start_secondary+0x6b0/0x820
> start_secondary_prolog+0x10/0x14
> 
>> Can it be reproduced on QEMU ?
> 
> No, qemu does not support SMP.
> 

Can you try "powersave=off" commandline to disable idlestate and
see if it boots?

Other call stacks are very likely not possible such as sched_balance_find_src_group


