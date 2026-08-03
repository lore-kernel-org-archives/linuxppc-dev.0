Return-Path: <linuxppc-dev+bounces-25227-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AB9C5516F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 04:52:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD45q24j9z309L;
	Mon, 03 Aug 2026 14:51:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785732719;
	cv=none; b=FvzS8jdqPys/u1zxPsHMMI0kysL1EQKTywT+AFykbnSSS7QaeV0hDdI9vjiFgZVMb5phib3r60N2nJuilGOw46lhYKeHJdNpuU07IsYr/UkBVqPzNYrBhNB+bJpsEMEE6+Sg71EN90Gcilz+OYOeU3Hu7Q3NWyegwTmBqeANmGcmgpGkpVGI0DLoQjphRqzniLoDgBxec31fbZNjED+myuy4Zr9tdKRPIkfLIk5kz0XsgJzzpBXsDn/MxrcvfJALirdYN9PLajhcUyrfX3GBL6zQMeffJjgmvYcxE/HjY9Zr4tGHe8YQEkQXhJbYlqit/LSFjYRebttEExG5R6CpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785732719; c=relaxed/relaxed;
	bh=lU6emKOG99JULYEeszWMaT6C/GIzIjuXR1dBdXGvjKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juMLFtdnjsMWc204QcmjKbdowzjfCY1PtlrkQ5gqWf19at2H0/1W7TZh+JPB+yUyB7xWGqWYxiB9bFbLUNUt7EUZdozLTvlzPAiasaaFRUGI3MJvnLf5TIS0AkefhjuY+M4KkzkS4yOFKdDf7NRyYyA4XrQ/Z4xqDmOU1GBY4n92KvcCyIzOtbn/29UskRBYRnqV32VxpAau/0m8RVrSIZ9gcd2b/1Dn5jt0zMY1Q8yS4dhZO6I++bO6dp0ncp/uY8oEGsYuA3DFAAsHE2IKBGeRUmjlPioNZnBJTjuF7ln9dA+xPxSceXA4YJ0oO5p1BN88Z+y0FKgs4PPI8u4Z4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cSpTFxRA; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cSpTFxRA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD45p3sHlz3090
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 14:51:58 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LlbU9243645;
	Mon, 3 Aug 2026 04:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lU6emK
	OG99JULYEeszWMaT6C/GIzIjuXR1dBdXGvjKM=; b=cSpTFxRAhH0Sls7Y3Xf1g0
	EsE19xX9mMD6fyt9xQFbKtS8FojhCVPyQLrycv4lECFiL/aEXydKWioFZHZN76gS
	tgAtxKfjdt/rdEyafNJAkIZQdRJ2QbrK1m5ryNbW76yLUK4lWGTJWY4m9QTjRtWK
	2s59fVpQ6HERNeSsQaPqM03mlcHzSchCBJC/quiQGlfmsR2pISP6c8aKeJRgSo9A
	bFD+q0BFve7buiQycK150fWvL1r17tIkwvXUm7F6KQTPo+Uihog97s0RgclUSTwF
	MG41YV7ZAgmpqYjYtXjLLqRMMCrXs5E1oV1lMkXjctMY/mwIOgARiiCOpwsRLVlQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4puuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 04:51:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6734fKYS026367;
	Mon, 3 Aug 2026 04:51:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qbwvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 04:51:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6734pTlQ11272452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 04:51:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8986E2004B;
	Mon,  3 Aug 2026 04:51:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22E7020043;
	Mon,  3 Aug 2026 04:51:27 +0000 (GMT)
Received: from [9.124.211.72] (unknown [9.124.211.72])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 04:51:26 +0000 (GMT)
Message-ID: <3b524463-91de-4034-9478-7dbb5848262b@linux.ibm.com>
Date: Mon, 3 Aug 2026 10:21:26 +0530
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
To: paulmck@kernel.org
Cc: Jirka Hladky <jhladky@redhat.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        npiggin@gmail.com, bigeasy@linutronix.de, will@kernel.org,
        linux-kernel@vger.kernel.org
References: <29a407ab-268e-4443-96dc-8f5f933cb63c@linux.ibm.com>
 <CAE4VaGDzVa3+MKUbwH4LFj_mHZ721fd=7cWEd+G5=eVNWLePsg@mail.gmail.com>
 <529b8d9f-54a0-4ec2-9886-83cd528e5e04@paulmck-laptop>
 <CAE4VaGDJxcu_zgDyrSW=j9WzLEpNsQ9A9Rza-F5PLZq03kJYew@mail.gmail.com>
 <57d9de4a-65aa-44cf-9024-de4e5bdd1971@linux.ibm.com>
 <972db4f1-406b-477b-895e-59ffc643e384@kernel.org>
 <CAE4VaGD0Ekz+5s26iTW=UV4PuBkUm9AzorBgAVGJBjttH7sMWQ@mail.gmail.com>
 <4be922b5-7dc2-48c1-938c-de02245bc5e2@linux.ibm.com>
 <CAE4VaGDQ0Ysdfhqc-eF9Oby-QkZxiL-TvS-WkJ_KKEVrRvTc7Q@mail.gmail.com>
 <1eab63fc-b70d-41ef-b720-8ae77d8e56d8@linux.ibm.com>
 <c85a1f0a-d702-4470-b2d5-c308805acebb@paulmck-laptop>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <c85a1f0a-d702-4470-b2d5-c308805acebb@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDAzOSBTYWx0ZWRfX+3suSzZUhjLB
 TgHcfi5famx6Ihv6m2/GaUv77IOCmr8GFuPk/GsrU3lvL4Qv+JSwmu4hwXaXyc72v7xJfy5f9U+
 5yCfoQX1umBeTRDAYTXquZ4qwq7fkxc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDAzOSBTYWx0ZWRfX0MwBNQQc/cV8
 do0esE+MhYwtFN3Ip9U03vQESih+rw/qADtQDORdXK6UF92Ul3/Rzf8BIbQ1Xr6z7FKDE9Ibw+E
 2e+J9bTFGh+NXCQUxAuZv2UDsOV2POwbrDlA7d9EaJaxt6PlL5vQn5fazq1YqPtsbM3ubKvEid6
 Z33xn/6DcjW3tiA639A0laOX7YwqPH8+vIoRnaLIlvHfkyRmA4fr+ggb2CvzqC5OmkmD8W+kpX0
 x2H+Ll5oqlmKhO8nB2qo0QJOO7WSm4xV/wP1XljAdNlkJI1ETr7mItqS+GA74s8IWxXC6A0M5nz
 awREmltxqgJpbGc+mrQoS84AQN4nGfhywX8lluismwQHV117N7Mv8a9R2snN4jGimBWQfU32/m3
 UMC+woeVNyT604jt6/euFpf8AP3CRA9JsmCtwA967U7zpyy4G0Ar5E3qPJo6dFGdmdEIquQZdNx
 nfHH8pCe7NfU1DR8c9Q==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a701e55 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=px_DR1VyBJH5svcGKecA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 53ib-ODhAT5uWMKFuAar_-DXBhfJcX6M
X-Proofpoint-GUID: 682vuke97HwPTVZmG_Tvj_qVAIfYnCim
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030039


Hi Paul,

>> I tried moving to PACA plus splitting 64 bit into need_resched and preempt
>> count. But it doesn;t move the needle. But it maybe worth pursuing,
>> since it could help preemption modes. It needs more work and needs numbers
>> across benchmark.
>>
>>> Thanks for trying. Paul questioned whether barriers are actually
>>> needed for preempt_count, or whether software interrupt disabling
>>> would suffice (his words: "I can see why the preempt_count()
>>> operations need to be interrupt-safe, but I don't see why you would
>>> need barriers"). Any thoughts on whether that's feasible for
>>> powerpc?
>>
>> Barrier are likely not the concern as it is mostly nop.
>> Also, soft disabling interrupts needs to arch specific hooks to setup
>> before preempt_disable and replay interrupts after preempt_enable.
>> I don't think it would benefit since interrupt disabling during this likely
>> shouldn't happen. Maybe I don't understand how that could work.
> 
> For some reason, I remembered powerpc software-disabling interrupts,
> but when I go look now, there is no such thing.  Maybe powerpc used to
> but no longer does.  Or maybe I am just hallucinating.  ;-)
> 
> 							Thanx, Paul

It is there still,

static inline unsigned long arch_local_irq_save(void)
{
         return irq_soft_mask_or_return(IRQS_DISABLED);
}
Sets the softmask bit, and any interrupt that arrives,
gets added to a list and that will be replayed in arch_local_irq_restore.

That will protect against the race of irq vs preempt count in
__preempt_count_dec_and_test. In the PACA based PoC i have i tried to use it,
but it doesn't make a difference, since this particular test accounts mainly
preempt count overhead itself, which cannot be escaped in dynamic preemption.

So, I think this is the tax we got to live with for dynamic preemption on RISC archs.
But good thing is, its effect is limited to a very few microbenchmarks.

