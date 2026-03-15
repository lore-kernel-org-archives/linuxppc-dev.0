Return-Path: <linuxppc-dev+bounces-18204-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20100F3026D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Mar 2026 18:42:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYnCV4h1Qz2yYy;
	Mon, 16 Mar 2026 05:42:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773600166;
	cv=none; b=ITkubUQax7ijV8ehONjKNZ9iS0UOWFCYwd9oLN/f+qMwU++ZYG8dq/Y1vUsAqYwp9XsXHMVCIrvNDpvQAYuaXyvBXkY0VkCtdke6zGD2f9gaxahAxjShKCeKvcgP9hrXqNA8zbzTrf0qGz5CoTvBv28MD64zjBGy+mTPEzzCtHmFX0O3TUcTBN3OZDJacpsdvRljCFWqIbIKnC16gbxEgsRpvfjgsKOqocbj/7FBdWsD0SR4O3bAQlv7H56qsvUygMCM9oOiP1Ym1qWSsWNvlteT/TZuZpEs5pmEea/k+FsAS7tiPg74ERaEZU/d5sIW/m8oH5JlyTZi39xbOcyGWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773600166; c=relaxed/relaxed;
	bh=F7lFzj9MqKPxsMunWFa2d3PQ0CHreNXAXqtbxoY042c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=n1h+eEIi1CNUBFmMXUQJ149CrY4kwA9ban9syrSU4wYyFPFadR5nuRr+fBVnPj/okV3waDsN+Udxhjp3biY/4pgQFnh8Mx0dM6rdOGZzMAO6mCNnSnBTWmFkDtbQt4nGMiLJOAqXX31qazXkUnIoG8BwUbLRlH8Pfpe6UnGE0OaylENAI0UIrzY9Q7EVeF3tb8MtM7jBJJG6AK2EiMc5zTzIyw3QyR3/0124FSDRQiWkkGFyN/MZVkk5c7AU4rmKDcGl3r37go3OQTLtPYZ0wt50Rie1Q8YJmINjxWYk51ffTNjfZ+Dr18B85atW8LH83GIXyL2PK1M74lfTRjoznQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j+y0P3UO; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j+y0P3UO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYnCT3x2yz2yF1
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 05:42:44 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FA7Llr3739556;
	Sun, 15 Mar 2026 18:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F7lFzj
	9MqKPxsMunWFa2d3PQ0CHreNXAXqtbxoY042c=; b=j+y0P3UOPVvX29pbQAG0/J
	2DyOURefM6rMtjW3heQzgLupGDPyhGzh5zFDKkHzK2Mf1RLkB0A5A9u9l4k8RLZ2
	LS/Dvlc8E8ncWRS29asD99sJm9ktMRrxebECddY007HVtHt6EPTDiTNoJGCUS7nF
	VfVNxAVNPXQxB+6GYJQZNOrI7N0Lj8w9bHk1yVhSIkyKotlMuMgVSNWPRtNAkOFJ
	W/Vwrhuj+Xwd2VgGvWE5YHRhEFsy4KVtoDs7JS+IoaBe4R8eCVqeMyOrjGHUbdh+
	y0r2c2F3EZjnPgAzxNKP/wmTlQzNLOEgsC7i5lXV6mshNg5zEQUs0NAuZgaAUTQA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3hmvh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Mar 2026 18:42:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62FFPQqC014113;
	Sun, 15 Mar 2026 18:42:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcxt636-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Mar 2026 18:42:28 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62FIgOGE50987500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Mar 2026 18:42:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C2EF2004B;
	Sun, 15 Mar 2026 18:42:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FA6920040;
	Sun, 15 Mar 2026 18:42:22 +0000 (GMT)
Received: from [9.43.35.105] (unknown [9.43.35.105])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Mar 2026 18:42:22 +0000 (GMT)
Message-ID: <b82b417a-6ec3-4f6d-9c4e-24b81086d927@linux.ibm.com>
Date: Mon, 16 Mar 2026 00:12:20 +0530
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
Subject: Re: [PATCH 1/4] powerpc/bpf: Move out dummy_tramp_addr after Long
 branch stub
From: Hari Bathini <hbathini@linux.ibm.com>
To: adubey@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, maddy@linux.ibm.com
References: <20260225013627.22098-1-adubey@linux.ibm.com>
 <20260225013627.22098-2-adubey@linux.ibm.com>
 <e506a5b7-fd3e-4a9a-82e0-1d952c4ee949@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <e506a5b7-fd3e-4a9a-82e0-1d952c4ee949@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B2OMGAGMfxi5V1vBheZ8mAF7yuaZUIZj
X-Proofpoint-ORIG-GUID: B2OMGAGMfxi5V1vBheZ8mAF7yuaZUIZj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE1MDE0OCBTYWx0ZWRfXzttVc9V/vrXU
 HK9etCYfHN1AY2m3C2nvDpG50LfgC4UQRsY4/Nmz6XteaG1dtoKtXDQ/DBywwvQ1DhCl5oYu2ap
 oTyJvRtfGOoUuhl0n7wHB/Y4NpXM0gmkd2OwPJTg4ZVvsmZ5qvAVaKKVRmP53Jzk26BirkzsLQK
 pqxJA9QnWC+CXAOIBnqAxLXc3bCnI7A1FgKfJP/h3m0CRf5Of9WfAQk+wu1DwhxT4wZ5OeGphDj
 INJ++y934rIPzl3l3Bwvjet/9PhT0nu7llXWE3/B1F67Exfidvkxg/6XhFDtQsKhDxcvzfqwRnu
 ORpP1tlbfOt+AxKnjKODjNigWg2ejTX1CxERDwxGd9CNh+8RVh6I21dskOW4UjwMnM3Rdx8InHm
 //wrYvVHP6sb4+escjPcHOZ7uKlCgClsH4MP0HdsGYFA6aWpPpa332fl0zyTyb8rc2dx0sPa/9b
 DT1hEV8eLpjiIW8+rqg==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69b6fd95 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=0v2u5nxREl804tHrgJkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-15_06,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603150148



On 15/03/26 11:36 pm, Hari Bathini wrote:
> 
> 
> On 25/02/26 7:06 am, adubey@linux.ibm.com wrote:
>> From: Abhishek Dubey <adubey@linux.ibm.com>
>>
>> Move the long branch address space to the bottom of the long
>> branch stub. This allows uninterrupted disassembly until the
>> last 8 bytes. Exclude these last bytes from the overall
>> program length to prevent failure in assembly generation.
>> Also, align dummy_tramp_addr field with 8-byte boundary.
>>
>> Following is disassembler output for test program with moved down
>> dummy_tramp_addr field:
>> .....
>> .....
>> pc:68    left:44     a6 03 08 7c  :  mtlr 0
>> pc:72    left:40     bc ff ff 4b  :  b .-68
>> pc:76    left:36     a6 02 68 7d  :  mflr 11
>> pc:80    left:32     05 00 9f 42  :  bcl 20, 31, .+4
>> pc:84    left:28     a6 02 88 7d  :  mflr 12
>> pc:88    left:24     14 00 8c e9  :  ld 12, 20(12)
>> pc:92    left:20     a6 03 89 7d  :  mtctr 12
>> pc:96    left:16     a6 03 68 7d  :  mtlr 11
>> pc:100   left:12     20 04 80 4e  :  bctr
>> pc:104   left:8      c0 34 1d 00  :
>>
>> Failure log:
>> Can't disasm instruction at offset 104: c0 34 1d 00 00 00 00 c0
>> Disassembly logic can truncate at 104, ignoring last 8 bytes.
>>
>> Update the dummy_tramp_addr field offset calculation from the end
>> of the program to reflect its new location, for bpf_arch_text_poke()
>> to update the actual trampoline's address in this field.
>>
>> All BPF trampoline selftests continue to pass with this patch applied.
>>
>> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
>> ---
>>   arch/powerpc/net/bpf_jit_comp.c | 45 +++++++++++++++++++++++++--------
>>   1 file changed, 34 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/ 
>> bpf_jit_comp.c
>> index 7a78e03d482f..f8f6305b0d9f 100644
>> --- a/arch/powerpc/net/bpf_jit_comp.c
>> +++ b/arch/powerpc/net/bpf_jit_comp.c
>> @@ -51,7 +51,9 @@ asm (
>>   void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context 
>> *ctx)
>>   {
>> -    int ool_stub_idx, long_branch_stub_idx;
>> +    int ool_stub_idx, long_branch_stub_idx, tramp_load_offset;
>> +    bool tramp_needs_align;
>> +    u32 tramp_idx;
>>       /*
>>        * Out-of-line stub:
>> @@ -70,27 +72,45 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct 
>> codegen_context *ctx)
>>       /*
>>        * Long branch stub:
>> -     *    .long    <dummy_tramp_addr>
>>        *    mflr    r11
>>        *    bcl    20,31,$+4
>> -     *    mflr    r12
>> -     *    ld    r12, -8-SZL(r12)
>> +     *    mflr    r12        // lr/r12 stores current pc
>> +     *    ld    r12, 20(r12)    // offset(dummy_tramp_addr) from prev 
>> inst. is 20
>>        *    mtctr    r12
>> -     *    mtlr    r11 // needed to retain ftrace ABI
>> +     *    mtlr    r11        // needed to retain ftrace ABI
>>        *    bctr
>> +     *    nop            // Optional, for mem alignment of 
>> dummy_tramp_addr
>> +     *    .long    <dummy_tramp_addr>
>>        */
>> -    if (image)
>> -        *((unsigned long *)&image[ctx->idx]) = (unsigned 
>> long)dummy_tramp;
>> -    ctx->idx += SZL / 4;
>>       long_branch_stub_idx = ctx->idx;
>>       EMIT(PPC_RAW_MFLR(_R11));
>>       EMIT(PPC_RAW_BCL4());
>>       EMIT(PPC_RAW_MFLR(_R12));
>> -    EMIT(PPC_RAW_LL(_R12, _R12, -8-SZL));
>> +
>> +    /* Relative offset of dummy_tramp_addr wrt start of long branch 
>> stub */
>> +    tramp_idx = long_branch_stub_idx + 7;
>> +    /*
>> +     * Image layout need not be considered 8-byte aligned.
>> +     * Lower 3 bits must be clear for 8-bytes alignment.
>> +     * Adjust offset for padding NOP before dummy_tramp_addr
>> +     */
> 
>> +    tramp_needs_align = (((unsigned long)&image[tramp_idx]) & 7) != 0;
> 
> I would rather check:
> 

>    is_8byte_aligned = (((unsigned long)&image[tramp_idx]) & 0x7) == 0x4;

Oh wait, I meant:

   is_8byte_aligned = ((((unsigned long)&image[tramp_idx]) & 0x7) == 0);

- Hari

