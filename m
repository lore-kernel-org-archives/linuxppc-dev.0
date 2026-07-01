Return-Path: <linuxppc-dev+bounces-23238-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC868C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 02:15:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqk9y1JYpz2yQL;
	Wed, 01 Jul 2026 12:15:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782872102;
	cv=none; b=LOzsuKbcI4NUJ7qRyiz1vjxiyM685RT1O3fMZwgJa2r3pd1Q0IBQWn/M4vJbeV19iLqm1JO+HhMJrdYfS0G5rs/ksQ1XgJjKiEC8CXFhNc/xvzEQ8huKY40nb+EkdgjVYfsi2ZVM8BsDW4HG9dM2oGbjsWbYfKECdt7wsX+xhVem816IRG0rbL1swrZBVJHlCnMnzM/D0tI8X6CK3Dx1EZzLBrX26q5rEzBJysfkTVDkt7oiUMR7gyB6p3s0DlrmhLpG1PW68UdaVWfAdixlkkB+i4vPwDQk/FXPfpSU4JLoqCYcEU6u8nRWwWDzS2celpMuwtdLsSQ5CwOxV38ymw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782872102; c=relaxed/relaxed;
	bh=3VV6hlyTk8M+Y6wz1i3jKDfGm4Rjn4j0CJGxehuHMEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFuoQ2nipTyoW9svFZklt0sDsmCNeMHlWnpv3XE9fhTG+TkbCVYtC4nK/4pmKWNOMq2/YtpIaRod2dZCoeJ1R0IKDSHyUSWJ+29DMGwc08jQEucor/wGAoyP8rvQDeQgYJQ1HYlCFsy481+QpzFIn4orpDrSmlmypoMgNPm5lEqV+xgS8VaQl23xaURV+Yxske8WkZwvS52f2/WJDoxqZ6N0V1sLeI0CTV0JYak1Wi9U3fbTuLd9HvC/7DiM7dIgJxvdSr+8R4BnWnsZEAiiBroRgt5xJsMWlxlfi6m7GkUovmFIr/cxnUEDF+efwEomfyASsZhhalpRq7n/RY6aUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gIbdLNtx; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gIbdLNtx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqk9x0RKXz2yQG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 12:15:00 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UNJ03C3390408;
	Wed, 1 Jul 2026 02:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3VV6hl
	yTk8M+Y6wz1i3jKDfGm4Rjn4j0CJGxehuHMEo=; b=gIbdLNtxNqpXy2pa5QSAWU
	2jGEzmd3FtpfnJKHiO9WQ7gZS3A8a7ZHSw2szGJCXXIe0y2KRMSJX6vOBbWwBNGe
	sdEqcH+AbIQaSB6gUDcT0YVPymOMNxC/ZwryMtii/GjGkGVD45nP0QWuEI/dirS3
	A83eS/h3ixwpIx4PbcoUqs5Vl+UfMg1usR2556bjRQRPH7GKL8lK1kKs72EbQUrR
	R20jlbAFWAUwT/FXJ9ZYhys45zrz7lLkO5cnn0OmRu/5gj24gr5fOuyJ70FPbkX0
	DsPLjRPQYQvj1ftQRWYTtGYFeYQjMDL+B2XsbWpih5xQKkZ5C26eEGWBr9rw/9+Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5t1xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 02:14:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66124arR002345;
	Wed, 1 Jul 2026 02:14:15 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2suk57gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 02:14:15 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6612EEJ931720174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 02:14:14 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20F9958059;
	Wed,  1 Jul 2026 02:14:14 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82CB55804B;
	Wed,  1 Jul 2026 02:14:09 +0000 (GMT)
Received: from [9.123.5.176] (unknown [9.123.5.176])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 02:14:09 +0000 (GMT)
Message-ID: <ea6e629f-dac7-45dd-bb18-5cd6361fe6c4@linux.ibm.com>
Date: Wed, 1 Jul 2026 07:44:07 +0530
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
To: Paul Moore <paul@paul-moore.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Eric Paris <eparis@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        audit@vger.kernel.org,
        Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        ritesh.list@gmail.com
References: <261b1be5b8dc526b83d73e8281e682a73536ea28.1773155031.git.chleroy@kernel.org>
 <CAHC9VhTyOuuPs1uovodM9M_8zZeJnVXs9xrWSdPhZcjXUb=mvA@mail.gmail.com>
 <fce0a701-ee58-4cb2-b34b-8aec26aaab5d@linux.ibm.com>
 <09e72f42-e180-4e2b-b379-92b755792a2c@linux.ibm.com>
 <CAHC9VhTzuO=RFtrUUuZyieVdkrM5H4ZCb1=PoL-oEEgiw38azg@mail.gmail.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <CAHC9VhTzuO=RFtrUUuZyieVdkrM5H4ZCb1=PoL-oEEgiw38azg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDAxNyBTYWx0ZWRfX0yHscKuANDTi
 XkCaU+K3w60OQqNCm8T8Mj4A2Xl8yRAxlpg5UkmaWKSBC6oKghPZF1T2yDVy5bf0N95g5cippnV
 +KHtu8l5b1sEr8F7wvAb6CR/L/YNGKkkujeX80u7FjUPyg/CeZYw1vIjqLyUXbucoOD+r4BajUH
 dAl+V+T/WP/yiq9xQGZcZ15VV8XLO3LALlte3OHenFYe2bR+7UhyXPkjl0yVLl10+9TDa2DfO1c
 RjiRFBbsjv1Mr93Rn9re8amyEcBq4Ruk8JV0EQXzGYnEbgOOLy50iRu8W/6B2asQh5k5nRMx83V
 1uOkceYvAu2xbxTIpjveU3XKNwI1PC6XDi7EL4JvLMRin7+TtvYWVuovLXnumQt/s6b8G4DTFTF
 +DunbM3lxGVSdU6wq3zv9MI5g/t8bdQWoBpceD8Q2yCedRWip05qGe63eVJdy06O8H33rovJBzy
 anhJMcwyFl+R0a87SFA==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a4477f9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=1UX6Do5GAAAA:8 a=aow-egSQAAAA:8
 a=Y1MMXoS9GqY3iA00RDYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Et2XPkok5AAZYJIKzHr1:22 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-ORIG-GUID: NSujt_d28uJWWyLabZjAH9wml6_K16m5
X-Proofpoint-GUID: OJJEOKqLutOTIm8RLqSsh5cRw5XNZ4Qw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDAxNyBTYWx0ZWRfXysmzF5Ld2w1+
 RsRBxcCeqlx3rO000elDi1P5ofZ4qVx/rNt+TVo2MFLcqNa3MDBLFZ5vMxr9GZbmYzq+2W6QI/I
 kbPyyk2VQNd0UMztS8vsSem8lOYy7hE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010017


On 7/1/26 12:41 AM, Paul Moore wrote:
> On Wed, May 13, 2026 at 1:42 AM Madhavan Srinivasan <maddy@linux.ibm.com> wrote:
>> On 5/13/26 10:05 AM, Harsh Prateek Bora wrote:
>>> On 11/03/26 12:49 am, Paul Moore wrote:
>>>> On Tue, Mar 10, 2026 at 11:08 AM Christophe Leroy (CS GROUP)
>>>> <chleroy@kernel.org> wrote:
>>>>> From: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>
>>>>> Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
>>>>> targets") added generic support for AUDIT but that didn't include
>>>>> support for bi-arch like powerpc.
>>>>>
>>>>> Commit 4b58841149dc ("audit: Add generic compat syscall support")
>>>>> added generic support for bi-arch.
>>>>>
>>>>> Convert powerpc to that bi-arch generic audit support.
>>>>>
>>>>> With this change generated text is similar.
>>>>>
>>>>> Thomas has confirmed that the previously failing filter_exclude/test
>>>>> is now successful both without and with this patch, see [1]
>>>>>
>>>>> [1]
>>>>> https://lore.kernel.org/all/20260306115350-ef265661-6d6b-4043-9bd0-8e6b437d0d67@linutronix.de/
>>>>>
>>>>> Link: https://github.com/linuxppc/issues/issues/412
>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>>>> ---
>>>>> Venkat, a test result with
>>>>> https://github.com/linux-audit/audit-testsuite would be appreciated.
>>>> Yes, I'd like to see confirmation that the audit test suite runs clean
>>>> on ppc systems with this patch applied, and unfortunately without a
>>>> ppc system I have no way to test this myself.
>> My bad, this is a miss from my end.
>> Venkat is already on this and will update the results here.
> Do we have an update on this?  Maybe I missed it, but I don't recall
> seeing any test results.
Venkat, did run the test but I guess he missed to respond here,
Details of his test run that he shared me in the internal chat from May 13.

backlog_wait_time_actual_reset/test .. ok
bpf/test ............................. ok
exec_execve/test ..................... ok
exec_name/test ....................... ok
fanotify/test ........................ ok
field_compare/test ................... ok
file_create/test ..................... ok
file_delete/test ..................... ok
file_permission/test ................. ok
file_rename/test ..................... ok
filter_exclude/test .................. ok
filter_exit/test ..................... ok
filter_saddr_fam/test ................ ok
filter_sessionid/test ................ ok
io_uring/test ........................ ok
login_tty/test ....................... ok
lost_reset/test ...................... ok
netfilter_pkt/test ................... Can't exec "nc": No such file or 
directory at netfilter_pkt/test line 83.

Venkat, can you please re-run if possible and paste the log here.

Thanks
Maddy


