Return-Path: <linuxppc-dev+bounces-24971-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D58C53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 06:28:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h92Tg0ZxFz2yDr;
	Wed, 29 Jul 2026 16:28:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785306519;
	cv=none; b=HaXL9W5vuL3Ys9VyRP0WmrvbT1CR+T3Z3dMDcgF0TemXY7BWaspSeJWvQ2xXeMAOlI/GOmhtpmPoSiFuy0OKVhydUAf3M/mBDxVyqhX1PItWo0CEMYQ0ZHwY9JCPv/EuhJ9sNWbpslVyMkjjLh+an32XXdcKhcc/roLVHEwo1L/lEzF29qsMg5p4zdK2gpWMSw2vRHQWoEfbMhrwTkISOtAPrz/yBa8ja3L60z1fXmwl3bmjhBORk4lT8L4evUawcDyJxywPeyagKwxozygfUMQYO3Nc4XYHqb41It7KoVR0SNrVOSNmXw8t0nalLG2AugM31pRxIT4YhEz0NGnW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785306519; c=relaxed/relaxed;
	bh=UYIl8uzSgQRf00wG8SFqHpJVrX+Hc1S0Vp/YCpu8iq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R68x9NuJ94NpoG4vuOymgKv9yY5BaopWtGheSgJ6/LrBBYxBKqwj9uh5WyBjPpfA6C6ryQwbEQqx7GkiXImtZ9yujv+e3MBdxG6LOf+Q3+qEIulfUlZKBYC5EuezB9YL+kkAXyX6ejmMey7ygQpj8x4rqsGCWRwbm7AqHVTYx3hOQw1+cLMhJvGSy1Ci620m5CHruRduXJT6udHc2usIkrxZk9AcCfr83OwNWYDOE7mspDgc7xZ+0T+Ks/SKbRg0m70WT0DAAKZspXi/uCj21Z/0P4mcv60XpIVvFf+cdjBCN2HpszK/7VqDoUiUOUZHAYJq/QehBx59WmW1iSu90w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UnzJy7TO; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UnzJy7TO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h92Td5Tdrz2xFc
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 16:28:37 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T4lcXE3243364;
	Wed, 29 Jul 2026 06:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UYIl8u
	zSgQRf00wG8SFqHpJVrX+Hc1S0Vp/YCpu8iq8=; b=UnzJy7TOUa5SfWIgudA7dB
	e7UukHWV4Mmc5tnFFHcYd0GTnhnAD7Gff0Mht9SmplqJs9EsX/OTJ+ymxnIyL1jH
	qPmFvPGJjHZCk7vODjubCkBNycZ17XBLex7zp449YZdJm5ngYr6+VhS4PCq+sjLv
	FSX0qhFN539zw3NbRVkh3AlSv0MRP1370j+BCdW/in3WtEAY/slER16BMsm7JEo6
	kSE+Zepb8x9e53qxEwIdON6Pff8NPiRViMOlPMDOpdNTwGjyy7In9NiWwm7TBRGE
	K1aTz4owgAAlzmXbYQhP4txyISV+yTBr+5Df7KRAq1y2HlB9imi9fJu5jHLh3I9w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xs82k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 06:28:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T6QGmd006272;
	Wed, 29 Jul 2026 06:28:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw5kus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 06:28:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66T6SMJ638601054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 06:28:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D4B620043;
	Wed, 29 Jul 2026 06:28:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45F6620040;
	Wed, 29 Jul 2026 06:28:18 +0000 (GMT)
Received: from [9.39.23.157] (unknown [9.39.23.157])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 06:28:17 +0000 (GMT)
Message-ID: <7eb8ed5f-0652-4675-9369-913a17463093@linux.ibm.com>
Date: Wed, 29 Jul 2026 11:58:16 +0530
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
Subject: Re: [PATCH] ppc/fadump: collect dump if the collected size is lesser
 than reserved
To: Shivang Upadhyay <shivangu@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, adri.vero.dev@gmail.com, adityag@linux.ibm.com,
        anushree.mathur@linux.vnet.ibm.com
References: <20260714173010.615682-1-shivangu@linux.ibm.com>
 <446c84c2-8639-4ecb-8a46-1e203a166e46@linux.ibm.com>
 <afd516619eea338039a6defb123ffaf38cf82949.camel@linux.ibm.com>
 <72589eca-2e97-4a2f-8665-b2a817a04722@linux.ibm.com>
 <7618bf3e48f6770a803f8350d0b3b084c23042fa.camel@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <7618bf3e48f6770a803f8350d0b3b084c23042fa.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Zp0mt4U5s7HB276ZFV2kUBqHKvQZQUTK
X-Proofpoint-ORIG-GUID: -ZszbdO3NXcRBAd5rQPmzfw01vOfG-Ic
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA0OSBTYWx0ZWRfX4H/u4wWn1ovd
 9wOKyVykzHOPorWqO5ocR/kuml+JFPwJu0AiIqk9H4MqC5/StXmNvDbJ3KrRCbdrDxMvYGwA3Z0
 dOCS7n/8l3rQZ+3ke0i5a3xQMY1ys70=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a699d8c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=P-IC7800AAAA:8
 a=VnNF1IyMAAAA:8 a=4GP81UFHlDIpScr7_KYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA0OSBTYWx0ZWRfX7iJ2vEwArMDZ
 hP8KOrhZOfkHUKQmBAuWFIl7lKOwknP0E2SNFAEY/Lxd1Pr344dRgM/NDEW/KP1RQHK0ZslRvR8
 Y4K2pwvcXiFXCXc5VZmA/LjlY97rlr1HbkzVZ2HPlfd2SNlnkVY532/OFuftmeZG4na3PzPKUNn
 kXstY4SgWZaE/B4Oz5hVjwmvuAkPzSs0QJavuIgQCeTxlCo50ZnvktTwBEw2prOx8tEyCwBWxYL
 5/dSTMFApxBkzaRhco+wCcmU1ysYea/pgGp7mufhBcxRhOkr9x/InpWRuejkUNdJ0b6OQiQ40Xw
 WvwtXD0RtRF/HWBD1Nsws0d5H1zH+uTRuKGxxzv08zYvsf3yho20LKDb5HrH6Zfe6PZgaySoM4s
 l6SVOlU4qCRsFqJrmh2QWkHUV1cFjzb5RcTVb8OuMDnTnv1C4hNMxjWc6vyrSG0L6w1u0Rf6ERi
 enZOoZu8++KR3zPHEqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_02,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290049



On 29/07/26 11:36, Shivang Upadhyay wrote:
> On Wed, 2026-07-29 at 09:14 +0530, Sourabh Jain wrote:
>>
>> On 22/07/26 14:41, Shivang Upadhyay wrote:
>>> On Sun, 2026-07-19 at 12:39 +0530, Sourabh Jain wrote:
>>>> Could you please reword the commit title to make it a bit
>>>> clearer?
>>>>
>>>>
>>>> On 14/07/26 23:00, Shivang Upadhyay wrote:
>>>>> When a machine is subjected to CPUs add/remove, using dlpar
>>>>> operations, the number of collected CPU_NOTES can change.
>>>>> As per PAPR, collected dump size should not be more than
>>>>> allocated size. Reflecting the same in source.
>>>> Can you add more details about the problem you are trying to
>>>> solve
>>>> with this patch and how.
>>>>
>>>> Adding the error message and scenario would be really helpful in
>>>> understanding the problem.
>>>>
>>> Hi Sourabh,
>>>
>>>    When a qemu ppc machine is booted with fadump=on and `-
>>> smp=x,maxcpus=y`, on the panic kernel, /proc/vmcore is not
>>> generated
>>> because dump_bytes and source_len does'nt match for CPU_STATE_DATA
>>> region in fadump, then we just give up on parsing rest of the data.
>>>
>>>
>>>> Can you add Closes tag if it is reported upstream and if possible
>>>> fixes
>>>> tag too.
>>>>
>>>>> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
>>>>> ---
>>>>>     arch/powerpc/platforms/pseries/rtas-fadump.c | 3 ++-
>>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c
>>>>> b/arch/powerpc/platforms/pseries/rtas-fadump.c
>>>>> index 3bb4ac2ab6cc..19a5adaf326b 100644
>>>>> --- a/arch/powerpc/platforms/pseries/rtas-fadump.c
>>>>> +++ b/arch/powerpc/platforms/pseries/rtas-fadump.c
>>>>> @@ -469,7 +469,8 @@ static int __init
>>>>> rtas_fadump_process(struct
>>>>> fw_dump *fadump_conf)
>>>>>     				pr_err("Dump taken by platform
>>>>> is
>>>>> not valid (%d)\n", i);
>>>>>     				rc = -EINVAL;
>>>>>     			}
>>>>> -			if (fdm_active->rgn[i].bytes_dumped !=
>>>>> fdm_active->rgn[i].source_len) {
>>>>> +			if (be64_to_cpu(fdm_active-
>>>>>> rgn[i].bytes_dumped)
>>>>> +			    > be64_to_cpu(fdm_active-
>>>>>> rgn[i].source_len)) {
>>>> Can you please share your observations about `bytes_dump` for
>>>> both
>>>> QEMU
>>>> and a
>>>> real system (LPAR) where the number of online CPUs is not equal
>>>> to
>>>> the
>>>> maximum
>>> I have the following observation.
>>>
>>> I booted LPAR with 8 cpus. After crashing it I saw that fadump
>>> CPU_STATE_DATA has notes for total 16 cpus, and only top 8 notes
>>> have
>>> valid entries.when trying with 16, I see all NOTES have entried
>>> filled.
>> Yes even I noticed the same on a LPAR with (Min=1 Desired=1 Max=2
>> with
>> SMT=8 CPUs) maxcpus as 16 and online CPUs as 8.
>>
>> [    0.036128] rtas fadump: --------CPU State Data------------
>> [    0.036129] rtas fadump: Magic Number: 5245475341564500
>> [    0.036131] rtas fadump: NumCpuOffset: 1c
>> [    0.036132] rtas fadump: NumCpus     : 16
>> [    0.036135] fadump: Allocated buffer for cpu notes of size 65536
>> at
>> 0xc000000006a30000
>> [    0.036138] rtas fadump: Reading register data for cpu 0...
>> [    0.036173] rtas fadump: Reading register data for cpu 1...
>> [    0.036178] rtas fadump: Reading register data for cpu 2...
>> [    0.036209] rtas fadump: Reading register data for cpu 3...
>> [    0.036240] rtas fadump: Reading register data for cpu 4...
>> [    0.036272] rtas fadump: Reading register data for cpu 5...
>> [    0.036304] rtas fadump: Reading register data for cpu 6...
>> [    0.036335] rtas fadump: Reading register data for cpu 7...
>> [    0.036390] rtas fadump: Updating elfcore header
>> (c000000006a20000)
>> with cpu notes
>>
>> The NumCpus is populated to be 16 CPUs by the firmware (RTAS/PHYP)
>> even
>> though only 8 CPUs were online.
>>
>> Kernel avoid processing reg entries of CPUs which were offline using
>> below condition.
>> code snippet from rtas_fadump_build_cpu_notes()/rtas-faudmp.c
>>
>>           if (fdh && !cpumask_test_cpu(cpu, &fdh->cpu_mask)) {
>>               RTAS_FADUMP_SKIP_TO_NEXT_CPU(reg_entry);
>>               continue;
>>           }
>>
>> But when I removed the avoid condition kernel failed to process the
>> reg
>> entries and
>> below logs were printed.
>>
>> [    0.037877] rtas fadump: --------CPU State Data------------
>> [    0.037879] rtas fadump: Magic Number: 5245475341564500
>> [    0.037881] rtas fadump: NumCpuOffset: 1c
>> [    0.037883] rtas fadump: NumCpus     : 16
>> [    0.037889] fadump: Allocated buffer for cpu notes of size 65536
>> at
>> 0xc000000007a50000
>> [    0.037891] rtas fadump: Reading register data for cpu 0...
>> [    0.037937] rtas fadump: Reading register data for cpu 1...
>> [    0.037974] rtas fadump: Reading register data for cpu 2...
>> [    0.038009] rtas fadump: Reading register data for cpu 3...
>> [    0.038044] rtas fadump: Reading register data for cpu 4...
>> [    0.038079] rtas fadump: Reading register data for cpu 5...
>> [    0.038082] rtas fadump: Reading register data for cpu 6...
>> [    0.038117] rtas fadump: Reading register data for cpu 7...
>> [    0.038155] rtas fadump: CPU 8 was offline
>> [    0.038157] rtas fadump: Reading register data for cpu 8...
>> [    0.038195] rtas fadump: CPU 10 was offline
>> [    0.038197] rtas fadump: Reading register data for cpu 10...
>> [    0.038235] rtas fadump: CPU 12 was offline
>> [    0.038236] rtas fadump: Reading register data for cpu 12...
>> [    0.038273] rtas fadump: CPU 14 was offline
>> [    0.038275] rtas fadump: Reading register data for cpu 14...
>> [    0.038311] rtas fadump: Unable to read CPU state data
>> [    0.038319] fadump: Invalidating firmware-assisted dump
>> registration
>> [    0.038370] rtas fadump: Firmware busy during fadump invalidate,
>> waiting 1ms (total 0ms)
>> [    0.039403] fadump: reserved_memory_range[0]
>> [0x00000040000000-0x000000800305c7], 0x400305c8 bytes
>> [    0.039408] fadump: freeing reserved memory (0x80030000 -
>> 0xa00000000)
>>
>> For some reason, only CPUs with even-numbered IDs were present from
>> offline CPUs list. This suggests that although
>> NumCpus was 16, only 8 CPUs had valid reg entries. I think we should
>> discuss this case with the firmware team before
>> finalizing the solution.
> Thats weird, I remember seeing entries for all of the maxcpus. Maybe I
> put my prints differently, Can you share your debug patch source?

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 7f79c9aea..ee1ad6493 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -11,7 +11,7 @@
   * Author: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
   */

-#undef DEBUG
+#define DEBUG
  #define pr_fmt(fmt) "fadump: " fmt

  #include <linux/string.h>
diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c 
b/arch/powerpc/platforms/pseries/rtas-fadump.c
index 3bb4ac2ab..55271fbbf 100644
--- a/arch/powerpc/platforms/pseries/rtas-fadump.c
+++ b/arch/powerpc/platforms/pseries/rtas-fadump.c
@@ -6,6 +6,8 @@
   * Copyright 2019, Hari Bathini, IBM Corporation.
   */

+#define DEBUG
+
  #define pr_fmt(fmt) "rtas fadump: " fmt

  #include <linux/string.h>
@@ -422,7 +424,7 @@ static int __init rtas_fadump_build_cpu_notes(struct 
fw_dump *fadump_conf)
                        RTAS_FADUMP_CPU_ID_MASK);
                 if (fdh && !cpumask_test_cpu(cpu, &fdh->cpu_mask)) {
                         RTAS_FADUMP_SKIP_TO_NEXT_CPU(reg_entry);
-                       continue;
+                       pr_debug("CPU %d was offline\n", cpu);
                 }
                 pr_debug("Reading register data for cpu %d...\n", cpu);
                 if (fdh && fdh->crashing_cpu == cpu) {


>
>> On the other hand when I increased the CPUs count on the same system
>> (Min=2 Desired=4 and max=8 with SMT 8) the
>> system was booted with 32 possible CPUs instead of 64 CPUs. And
>> NumCpus
>> was 32 in fadump kernel.
>>
>>> I previously proposed this fake entries fix in qemu [1]. But that
>>> is
>>> not compliant with PAPR, which states that cpu notes should be
>>> collected for current_cpus only.
>> Yes, that solution does not appear to be PAPR-compliant. However,
>> based
>> on our experiments, it is unclear why the firmware reports NumCpus as
>> 16
>> when only 8 CPUs are actually online.
> I think fw's reason for doing for maxcpus would be same as our case
> also, CPU hotplug. It would be hard to handle variable cpus in dump, so
> why not just keep entries for all?

I think there is some inconsistency here. The firmware reports 16 CPUs in
NumCpus, but the kernel fails when it tries to read the reg entries for 
the offline CPUs.

I'm not sure where the problem is yet. Could you dump the Register Save 
Area for
a case where maxcpus is greater than the number of online CPUs? Then we can
check what data is present for the offline CPUs.


>
>>> As per current states of things, reservation is always done for
>>> maxcpus, (LPAR and QEMU both), NOTES collections is done for
>>> current
>>> cpus on QEMU, and maxcpus on LPARs.
>>>
>>> My proposal here is that we make the check for bytes_dumped and
>>> source_len, less restrictive to let QEMU also generate
>>> /proc/vmcore,
>>> when current_cpus != maxcpus.
>> By the way, the changes proposed in this patch also apply to other
>> regions,
>> such as HPTE and REAL_MODE. That is not the intended behavior, right?
>>
> Yes, I made it this way by reading the dump_bytes and source_len
> relation. PAPR only says that dumped_bytes should not exceed the
> source_len. My change reflects the same restriction in sw. Also along
> with this lengths check, we have firmware reported error flag also,
> which should take care of overflow (Qemu handles it like this [1]).

But the firmware not copying the entire Real Mode memory is also a 
problem for
the kernel, isn't it?

- Sourabh Jain

> [1]
> https://elixir.bootlin.com/qemu/v11.1.0-rc1/source/hw/ppc/spapr_fadump.c#L263
>
>
> ~Shivang.
>


