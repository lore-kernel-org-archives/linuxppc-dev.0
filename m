Return-Path: <linuxppc-dev+bounces-25128-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEEAC55164
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 17:11:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9whS12VQz2y8c;
	Fri, 31 Jul 2026 03:11:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785431464;
	cv=none; b=oLHuA+HcZ5AhtMtmEwM70Dk2R3qtilNjvLgtQ2fsv1e+c6bVI5h26suH1kTS9TfH4xHNP0nwL7HjEBlfm0EltiTSNCRaDobLVm7Kgewi9VFWkHmqV/2SisLVa6xeqXUdcOe6vCcLZ9h0pQHNclgxAIWEG1iIC8Tsc8vo9OJQDpuMr7bMCQJDb1LQl0j/XWwehvx29bwUzTI9aJA9wBVVG6jFH5RkYCvER/mde1J+WbDFug+tYXSK0e9IOjsIAIE5pZApRpfFRnyivFkflhzYhW3pH3sXuiRvS51nifNxYHkdATCKByp9FmT3WW3fQyJLxgEpX/tMWkX6LwDgz6HN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785431464; c=relaxed/relaxed;
	bh=u343b+9PMA/Lg6k5e0qQBmvGxtjeucL/00JB7v0JdUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5k/mLivd2s7dmEqGcRlqwkdmikSAZmXqaoFuRiu3NNalaDtRVQZdlcc1q50xNcw9YK/mt7HsH/sJj3LDtaKAXZ7JJprti89uf6jZJMWdKiRGbPshgYftPkDE4Htv7rLwSd0Qp68RP+y3vTvHr/gLW46guBk6rtRt/rqLYDFCP9a92J473Qm/DU4UJSebZzlJrtD08biAPpcKrXK1/Y/Vmab1JmANIzStyARvTDwxF9NfO+1y/Sj5PVsDrTfhGxVmlrY2qkaNBU2jr8TKkcHDRHBnpAUrkGzJOB3HA1W6RWvueaeaMyZeHBXMECGj/O60BldrvBCbt+FT2BFA44Erw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XXkhp8+z; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XXkhp8+z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9whR1xbgz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 03:11:02 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UGm3vv3612834;
	Thu, 30 Jul 2026 17:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=u343b+
	9PMA/Lg6k5e0qQBmvGxtjeucL/00JB7v0JdUg=; b=XXkhp8+zoY24YhEuNwIIXD
	QjZ1wQVOtjev4x3B9T0VfisILrRTjD1SPjsenIBkJh9/C7MFQ7M2/e1WsT58oTOr
	7Wc2pmmMeGXAfAp2F3mk4Y8niLIF+4WTT2pMXmo0Itvs9o5g28dyDoqXW995KIWN
	1V1Wk6ATYe7vtu0eynnM+BoG3/gTAXTUgtsmPku9+wrYTm5sUdQiks7cHvxMxs0e
	xWvEx805GXXrbjHmhLg6FP3ClUlOg9Ju05amZx7lSKkm/N/sEGbadT/EuAWYwtXj
	XG8mOFjQpnqYcEQrIldKP5HTFLF59nx17MJMTz9OpfMjnnqEo0PiW0LSwwwpL3jw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd82p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 17:10:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UGuG2Z014374;
	Thu, 30 Jul 2026 17:10:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhm733-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 17:10:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UHAfOm43712776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 17:10:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C26220043;
	Thu, 30 Jul 2026 17:10:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D01320040;
	Thu, 30 Jul 2026 17:10:39 +0000 (GMT)
Received: from [9.124.208.29] (unknown [9.124.208.29])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 17:10:39 +0000 (GMT)
Message-ID: <57d9de4a-65aa-44cf-9024-de4e5bdd1971@linux.ibm.com>
Date: Thu, 30 Jul 2026 22:40:38 +0530
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
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
To: Jirka Hladky <jhladky@redhat.com>, paulmck@kernel.org
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        christophe.leroy@csgroup.eu, mpe@ellerman.id.au, npiggin@gmail.com,
        bigeasy@linutronix.de, will@kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
References: <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com>
 <500d8e8c-088c-4e6d-ab53-868ade6b0eda@paulmck-laptop>
 <CAE4VaGDGS8wkZj4SF5XVC3-1yDmvJxjUjThTPqVw3kxg56ssQA@mail.gmail.com>
 <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com>
 <CAE4VaGAJ9mT8-V=GRPYj8h0RXuNf6S5icrmqeOOFDnkpPMQjaw@mail.gmail.com>
 <a1e04751-eab5-465b-8238-c9f4cd40e472@linux.ibm.com>
 <CAE4VaGCaN6uBBGqbGAsxudSxMC0JdXYn2vpuDJZPFR3xxJgMYA@mail.gmail.com>
 <29a407ab-268e-4443-96dc-8f5f933cb63c@linux.ibm.com>
 <CAE4VaGDzVa3+MKUbwH4LFj_mHZ721fd=7cWEd+G5=eVNWLePsg@mail.gmail.com>
 <529b8d9f-54a0-4ec2-9886-83cd528e5e04@paulmck-laptop>
 <CAE4VaGDJxcu_zgDyrSW=j9WzLEpNsQ9A9Rza-F5PLZq03kJYew@mail.gmail.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <CAE4VaGDJxcu_zgDyrSW=j9WzLEpNsQ9A9Rza-F5PLZq03kJYew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: uQD7T08f2t2jxPCPwtz9k4R2mkXxvdbt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyNiBTYWx0ZWRfXz+PWI4s3h34a
 86Xg55i79qLjA9uv9LV/4WdLOXnmhumawUq0zZHy02AccjJjr53XoTzWPAXIhlrF0XghZo9aXdZ
 uku+rI3MC13wEvqq9PIZ6DnIsvqAyLE=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6b8594 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=PJQI2bccM3a4naaGRUEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyNiBTYWx0ZWRfXw1hW3kZ8xbV4
 IqlQ+XLqu8vtWrzuONH0oXYYuEfEfXx8pBy+WcqKCmBop2xQovOz4b77V1wALg53gs2JdlV+/7I
 +rtclCpwUknr/n3d//q6uoag1oiZAUYvArIfTA3UfS+jBOu4HV/Uvi6lDrPT3ZnWoZ2uqQwz1cY
 2u+TubvdD/hrZ1rU2Tyvw1H4Sf3+LVMeTWq1UfzaehrQ5ATDpLBzlYIPmkck2lTu5ahVQeYhsbd
 OzpYxtu6idSfZq7CbmG9Z9/+5pC/ShsWXv8hnidi9YGBmG+prZ6zOkJIpyrjTXVAalnu24xqf8G
 2xy+gT/7uxd099t3SBTLoQuXdBqJZHBPdxDeOkHjjCDlU0iWeKXPpqnGL6Bnc/dcfSwibLyqegz
 G3yMeHtCQnw1ctwubWM8qIlyk4oozJ7mUdrRixOEpAkLjoqI/keiRtVswkbqyOWzrrZ6zWn6Azb
 wrIPEuGJN/W3kVq2Cgw==
X-Proofpoint-GUID: kkDHm0-UNfhYdyRcjhquJ3zLG_zQ4oFq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300126

Hi Jirka, Paul,


+cc will

On 7/30/26 8:38 PM, Jirka Hladky wrote:
> On Thu, Jul 30, 2026 at 4:53 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>> But is this really a fundamental RISC cost?  For example, does arm64
>> see the same performance issues?
> 
> We tested arm64 (Ampere Altra Max) with the same controlled
> experiment -- two 6.18 kernels, both voluntary, differing only in
> PREEMPT_DYNAMIC:
> 
> Arch     PREEMPT_DYNAMIC   kill bogo-ops/sec   Delta
> -------  ---------------   -----------------   -----
> ppc64le  off               108,836
> ppc64le  on                 68,197             -37.3%
> aarch64  off                 5,538
> aarch64  on                  5,082              -8.2%
> 
> arm64 sees -8.2% vs ppc64le's -37.3%. So arm64 is affected but
> much less severely.

Ouch!. But that's good to know.

> 
>> In particular, I can see why the preempt_count() operations need to be
>> interrupt-safe, but I don't see why you would need barriers.  And
>> doesn't powerpc still use software interrupt disabling?  If so, why
>> not use that to simply software-disable interrupts around the
>> preempt_count() operations?

Barrier are in core implementation, not in arch specific.

#ifdef CONFIG_PREEMPT_COUNT
#define preempt_disable() \
do { \
         preempt_count_inc(); \
         barrier(); \
} while (0)


#ifdef CONFIG_PREEMPTION
#define preempt_enable() \
do { \
         barrier(); \
         if (unlikely(preempt_count_dec_and_test())) \
                 __preempt_schedule(); \
} while (0)



>>
>> What am I missing here?
> 
> That's a good question -- I don't know enough about the powerpc
> preempt_count implementation to answer this. Shrikanth, could you
> comment on whether removing the barriers or using software interrupt
> disabling around preempt_count is feasible?
> 
> Thank you
> Jirka
> 

PowerPC currently uses asm-generic implementation which is probably sub-optimal
w.r.t to check of need_resched.

When i see ARM's implementation, i see there is trick of splitting it into two.

         union {
                 u64             preempt_count;  /* 0 => preemptible, <0 => bug */
                 struct {
#ifdef CONFIG_CPU_BIG_ENDIAN
                         u32     need_resched;
                         u32     count;
#else
                         u32     count;
                         u32     need_resched;
#endif
                 } preempt;
         };


Seeing Will's changelog is on similar direction.

396244692232 arm64: preempt: Provide our own implementation of asm/preempt.h
"The asm-generic/preempt.h implementation doesn't make use of the
PREEMPT_NEED_RESCHED flag, since this can interact badly with load/store
architectures which rely on the preempt_count word being unchanged across
an interrupt.

However, since we're a 64-bit architecture and the preempt count is
only 32 bits wide, we can simply pack it next to the resched flag and
load the whole thing in one go, so that a dec-and-test operation doesn't
need to load twice. "

I am speculating this might help solve for ppc64 too. But i don't have a system
to try this right now, will get back once i do

