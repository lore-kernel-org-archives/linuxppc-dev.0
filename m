Return-Path: <linuxppc-dev+bounces-25184-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E262C5516F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 17:57:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBYgy2gqQz2yY1;
	Sat, 01 Aug 2026 03:57:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785520670;
	cv=none; b=kzAg2Jd9KUXFbVjeMLgPW/cXB9BUaLuohDMgf0AaQk537ImIVA9ukNJPE0DdC2ymnrAcw5G4tgfPjN2sOC7twxMImSmFx8hbKbcXrJ+OaRRyr1yGDvJV2uQ94XrgYR7T23tW7ZGWWY4TBQNpOkaCr+dmen+opF/dV9OurSRAWy3KCKvB9xSYElIef/tEB3PO0B2COI1kNJGIkF3qHdBiEdP+/5hKiaAkSuBy0vHLRXSZsbVTXBicqGPdc3PYijNtwUHWAzLrE3+MfeHuspKXATT0t8SQtQefI9dQnmWuHCNkjzSyvHLd0MkuuQ8/TRtF1Nx5QCbASmIjmk9rZ0O8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785520670; c=relaxed/relaxed;
	bh=0+3nMJAHcXKQqB6/6Ck/Snc72GTc00jhqWgqMfaEij8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCW1WfdaDvFw3oXKRtrxAcwxlIDqbqkKZ7x3POUOfdRkE7oKYYLYIWTCZXfJ6YNoksmdnNu5iA5EaVN5aiJQdDCJSTpVhQvs1RhU/H8WuelxXiJbHT6Mke7xVI5VeQHrBkkL9aAyH8et5QCaR1GtRxEfG3EGSsBzzYNe6H5A6Sk+6crKeOXsQ2bpePg7IdVidm9ddQrL3j245BpL7SYvMBITBUKg4vfNj76OPkJX/BgoGAGlNndUiLIYVzH3zmFycH/03r1SR5VegEx8S4NVBw2Uaq4FJVdCyzL9dpVqZ4fOuwIajCOuw5dijWCIekOSD39FlgporD1kmBUVYqHRsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JG6pym3a; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JG6pym3a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBYgx16P6z2xwH
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Aug 2026 03:57:48 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFlq7u2194603;
	Fri, 31 Jul 2026 17:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0+3nMJ
	AHcXKQqB6/6Ck/Snc72GTc00jhqWgqMfaEij8=; b=JG6pym3ain7Nb/w/3wi6B7
	Uj/N6FLrtdRx05WQ5bh9zlNaeJJXZ1mduGmIr7I1UskhdZ3WlWS/kmOfadr7RGkI
	j55rXRkfh6R2AKYMGvBJDhwxKQAu+uJpsR6hegQDUQzUsZ/2tl4sjVLAnG+hKKT/
	m3V8ebt1Ls9tCWdWDJDc8YhGQvoaW7XNtrLHAcg+rEDc3FTTA1eVZnTy6D4aecrh
	RcFhA1zTtt13UoO3fTK7YTy7CKa21tcL4wer7ag/S7F+atEozwVdWRiK2wUbY5vR
	3v240xQP3YcYpysraVwQdAcKcaHioHSymoD0kcrkCtgVoz0PXSM5evtfS1nZfmuQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0p59u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 17:57:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VHuISM030228;
	Fri, 31 Jul 2026 17:57:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhrwhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 17:57:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VHvB6w30540242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 17:57:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 776B520040;
	Fri, 31 Jul 2026 17:57:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31BBB20043;
	Fri, 31 Jul 2026 17:57:09 +0000 (GMT)
Received: from [9.124.209.55] (unknown [9.124.209.55])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 17:57:08 +0000 (GMT)
Message-ID: <1eab63fc-b70d-41ef-b720-8ae77d8e56d8@linux.ibm.com>
Date: Fri, 31 Jul 2026 23:27:06 +0530
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
To: Jirka Hladky <jhladky@redhat.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, paulmck@kernel.org,
        maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        npiggin@gmail.com, bigeasy@linutronix.de, will@kernel.org,
        linux-kernel@vger.kernel.org
References: <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
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
 <57d9de4a-65aa-44cf-9024-de4e5bdd1971@linux.ibm.com>
 <972db4f1-406b-477b-895e-59ffc643e384@kernel.org>
 <CAE4VaGD0Ekz+5s26iTW=UV4PuBkUm9AzorBgAVGJBjttH7sMWQ@mail.gmail.com>
 <4be922b5-7dc2-48c1-938c-de02245bc5e2@linux.ibm.com>
 <CAE4VaGDQ0Ysdfhqc-eF9Oby-QkZxiL-TvS-WkJ_KKEVrRvTc7Q@mail.gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <CAE4VaGDQ0Ysdfhqc-eF9Oby-QkZxiL-TvS-WkJ_KKEVrRvTc7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzNiBTYWx0ZWRfX6Ch+w55QOPJK
 36A+8CGVav9NwE4v4fCy9Ooo9PIgGt/6+o8KhY0yVUp2JAl+dMBjpuSzCts4B7QrSbH19VxJLr1
 A97tbZbnfYRgHOrnPRGKu1590SdGHyU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzNiBTYWx0ZWRfX3sZv9aGuqCNb
 jVhcN+59yGz6SgBsGIPeL9sRyxGm00vTWmAqVDPMjTDvJqI1Nbf0Dp6cA+7kYYRf4hgndaaaMVl
 kic5e6uXtPf5jEHL75LCLYOw+DK1L3kCBFI80kMu4ljRkOah2iEaPjRFmy0sRVwi1r+EcUylIh/
 unukaMVh/IaJJg8myu6FnSfTorr/wHPB4o8kleH1JtyQHYwztJmiMa5vuJmP8mH1427DBGPQluP
 ihytpwI2VMZxIGNSk4eht98lg/sui526Cn5f+L2P1jF1NpI09M/IsN6orF9jkAxSgJSN7RcN36j
 O1Pe+eThlvAce4b+E45g9caiLw7gbJDzfi8LLps8jTZriZWTwHWuvls4mNPhMvjZb/LxzBsvhqX
 lezh07nBGQkWZ8iehu5qY4rxuDyHE22UdAdOE58PFA06rrXrBfa17MOnR0wZBEULe74gVJoucnV
 XJ5IzmmlgbpMQM2RUWA==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6ce1fa cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=mal8egYMvLHp7vc5aikA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hG2IEA05qLzghVrZFTxYUMPqdXkH9gsv
X-Proofpoint-ORIG-GUID: 2pSQfoAUXyn4C2t1M9pezscMOXB7tMae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310136

Hi Jirka.

On 7/31/26 7:20 PM, Jirka Hladky wrote:
> On Fri, Jul 31, 2026 at 10:03 AM Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>> Coming into numbers, I did notice later, arm64 numbers are almost 20x less.
>> But if we compare the time taken for each operations, it tells a
>> different story.

> 
> The bottom line: PREEMPT_DYNAMIC/preempt_count overhead is present
> on both RISC architectures but its visibility depends heavily on the
> workload profile and hardware topology.
> 
>> PS: I tried porting some of those changes in arm64 to powerpc to
>> split preempt count into two. but i don;t see much improvement
>> there.

I tried moving to PACA plus splitting 64 bit into need_resched and preempt
count. But it doesn;t move the needle. But it maybe worth pursuing,
since it could help preemption modes. It needs more work and needs numbers
across benchmark.

> 
> Thanks for trying. Paul questioned whether barriers are actually
> needed for preempt_count, or whether software interrupt disabling
> would suffice (his words: "I can see why the preempt_count()
> operations need to be interrupt-safe, but I don't see why you would
> need barriers"). Any thoughts on whether that's feasible for
> powerpc?
> 

Barrier are likely not the concern as it is mostly nop.
Also, soft disabling interrupts needs to arch specific hooks to setup
before preempt_disable and replay interrupts after preempt_enable.
I don't think it would benefit since interrupt disabling during this likely
shouldn't happen. Maybe I don't understand how that could work.

