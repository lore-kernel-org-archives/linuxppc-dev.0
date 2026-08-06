Return-Path: <linuxppc-dev+bounces-25506-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B877AC5AC7C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:21:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGDZy268Qz30B0;
	Fri, 07 Aug 2026 03:21:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786036874;
	cv=none; b=KGSG/q4WBanyEwhgH5pbk/3KOwdzk8sBVV44+2oIHxI74IL/AiuhkuKf+rge/I2/xc1M50Q/+46vEKMZihrT0ao3IIskAiykV1oUKHKARhLoAnwxzi6ii4L6g8E5rUtUBWqCgquXEm42HRNeihHLrZybfiefyi6FBxpYDzx2xUtg1jrb5OCi4Xeg9FwgMjs29H5SB9IMjl3bJE33LLYicPDZKSi6zHV3oupc2cpnZUEal7K3FLD4215mUmF/cXhnNIm3p9MFgr8Hm4Zq7kn3ygXQ+zvJm/1uXuxvSL6sexAwBD8VO4UW7PX2qpI2D7qIp/ypJ00N5/bp20/8hVudcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786036874; c=relaxed/relaxed;
	bh=DKd41YUsoOFsNtDTUrm0zcmL2OTpi+GXlU+2pMsFqLw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OEl7WRCe4EDQXpSezHZzJyz2BDu7a6xkatS10EttujlsDzZ8fUaxudAKZxpt8GOiN3oQeOOvC3WUqTWthCTSfmuGRBbI6pF7xD69wDLD2+UW+Qp8Q8thDlNJbrwxIm3HmISRSb3faX4/E9qr5JVbJKW2l8dkQndrgKvu3Vg5OMz6Ig4vXPBAf58M3viVtkyDEDEssrcFhGDRC1CvJEcV7/Ug9j0aeQbE6treWCerddKL1W4VYX5Vn4SiDSK6SxJk6fh9rhshnL1vCulzuqcwUAdHfw1oo3NmKiStFXXXmHQxuuDN1BBdYTa7cudzPnZwBIlaM066DaVJg3uparghTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ETQ6fF8d; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ETQ6fF8d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGDZx2B5Zz309r
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 03:21:12 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676HHiw21405111;
	Thu, 6 Aug 2026 17:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DKd41Y
	UsoOFsNtDTUrm0zcmL2OTpi+GXlU+2pMsFqLw=; b=ETQ6fF8dkP0zCV0S7gdmYi
	nHV9c3XPY9kdOsn8SBJwh1VO3u60mHV//e29S7MRWzBLkllOmfMo03VsiJJfCcuX
	fg8qK0yVwUwNh9f7dTd7TJM+RtKx+QHTBkEwibXDegB6dhDHL0Sxi6nBoyv+BdW4
	LhuRKCSSTQVoNhErj+1280ltG8FvqFbwXNzZCYeLbwAc4feb0VcW+kGD75Zj9gXb
	oShVFqtwyH3saJTfF+xT/OQa4tUT1u3MLluJ/qW/4WQgyR6+DU/gca6OTCiCJmis
	YJfOWsFSAmVrE2mxRtC5X4IPdVZ2t4RSiJqs7OZtQWkHve5SFGyAXlVmu3z7ee4A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fr1f97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:20:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676HBFfT021547;
	Thu, 6 Aug 2026 17:20:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kc64j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:20:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676HKoAu32112960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 17:20:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CEB12004D;
	Thu,  6 Aug 2026 17:20:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E4C220040;
	Thu,  6 Aug 2026 17:20:47 +0000 (GMT)
Received: from [9.124.215.184] (unknown [9.124.215.184])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 17:20:47 +0000 (GMT)
Message-ID: <f7ce05c7-ce2a-4119-8f95-fdf885d0a26c@linux.ibm.com>
Date: Thu, 6 Aug 2026 22:50:46 +0530
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
Subject: Re: [PATCH v10 3/8] selftest/bpf: Fixing powerpc JIT disassembly
 failure
From: Hari Bathini <hbathini@linux.ibm.com>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com
References: <cover.1785906979.git.skb99@linux.ibm.com>
 <8b7bde664004feb383741b8807a561dba601285c.1785906979.git.skb99@linux.ibm.com>
 <e867421c-3700-451d-911e-b5eb235fae94@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <e867421c-3700-451d-911e-b5eb235fae94@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qy2u7ma4M0v9uuIaMi-FMBRGNz0Jjt_7
X-Proofpoint-ORIG-GUID: Qy2u7ma4M0v9uuIaMi-FMBRGNz0Jjt_7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEzNSBTYWx0ZWRfX8wf3uv2Dl9U7
 yhcBx9ol1k56YB023qefCmwB8uUwPEYm+drEDdF/9djhNxes6XcG0mHVdVTL4Y+vjcDynpTnrqW
 ALtdXBQ91FIRKhOCAwMivzX3III/6yM=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a74c277 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=8u2cJU0ZqL2LooIGNWQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEzNSBTYWx0ZWRfX1b6FUmq8kkOC
 SCZZi0wIN425oiWClXOfJDHI1MvaZvuRdVLsSER2x2YKUeqmH50GqOeYFCtqeUKe5yUSeUX0REw
 iumDcrHAra+bmVAySjpxI+nPprf0Nt5XpXflMNBQaUC6Mqj9cHZxJEinBqNa+EsBTBNiHLObUeV
 uyJ26Qg4j0kSgLngvW92wcZE6kq1NriOxNWug/KKVhFTKqjLWioN0w85cNBtc4L0iiGgfKO3MOF
 hAVuJcEU+7hoheEIX2pzCFEi8iwK+A5Y6nt4gOUIvWEm8PFdJiT/xEiGUs4XCy8fPcDZbcYTLWn
 En7W7bx91QayGAk0f8nLssNHA73ziZi0svOyk/TppciUjT7D2RwiUItkweMPBilele6lBh/NJWJ
 Kr5JYhd6dNI6e2rM1J7c0FTZ4WnypK+jI2HNOarLTbJJGhD8P8RisIxJZ7bMPlvQuJfdMr1/k4T
 5ge4rW0KFAruiNl92VA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060135



On 06/08/26 10:49 pm, Hari Bathini wrote:
> 
> 
> On 05/08/26 11:36 am, Saket Kumar Bhaskar wrote:
>> From: Abhishek Dubey <adubey@linux.ibm.com>
>>
>> Ensure that the trampoline stubs JITed at the tail of the
>> epilogue do not expose the dummy trampoline address stored
>> in the last 8 bytes(64-bit) and last 4 bytes(32-bit)
>> to the disassembly flow. Prevent the disassembler from
>> ingesting this memory address, as it may occasionally decode
>> into a seemingly valid but incorrect instruction. Fix this
>> issue by truncating the last 8/4 bytes from JITed buffers
>> before supplying them for disassembly.
> 
>>
>> Fixes: b991fc520700 ("selftests/bpf: utility function to get program 
>> disassembly after jit")
> 
> The fixes tag on this patch doesn't really help. Please drop it.

With that..

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>

> 
>> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
>> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
>> Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
>> ---
>>   .../selftests/bpf/jit_disasm_helpers.c        | 25 ++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/ 
>> testing/selftests/bpf/jit_disasm_helpers.c
>> index 3558fe10e28c..c4aa1d69d3bb 100644
>> --- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
>> +++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
>> @@ -179,9 +179,11 @@ int get_jited_program_text(int fd, char *text, 
>> size_t text_sz)
>>       struct bpf_prog_info info = {};
>>       __u32 info_len = sizeof(info);
>>       __u32 jited_funcs, len, pc;
>> +    __u32 trunc_len = 0, disasm_len;
>>       __u32 *func_lens = NULL;
>>       FILE *text_out = NULL;
>>       uint8_t *image = NULL;
>> +    char *triple = NULL;
>>       int i, err = 0;
>>       if (!llvm_initialized) {
>> @@ -225,9 +227,30 @@ int get_jited_program_text(int fd, char *text, 
>> size_t text_sz)
>>       if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd #2"))
>>           goto out;
>> +    /*
>> +     * last 8 bytes contains dummy_trampoline address in JIT
>> +     * output on 64-bit and last 4 bytes on 32-bit powerpc,
>> +     * which can't disassemble to a valid instruction.
>> +     */
>> +    triple = LLVMGetDefaultTargetTriple();
>> +    if (triple) {
>> +        if (strstr(triple, "powerpc64") || strstr(triple, "ppc64"))
>> +            trunc_len = 8;
>> +        else if (strstr(triple, "powerpc") || strstr(triple, "ppc"))
>> +            trunc_len = 4;
>> +        LLVMDisposeMessage(triple);
>> +    }
>> +
>>       for (pc = 0, i = 0; i < jited_funcs; ++i) {
>> +
>>           fprintf(text_out, "func #%d:\n", i);
>> -        disasm_one_func(text_out, image + pc, func_lens[i]);
>> +        /*
>> +         * Disabled JIT have zero func_lens, hence underflow
>> +         */
>> +        disasm_len = func_lens[i] > trunc_len ?
>> +                    func_lens[i] - trunc_len : 0;
>> +        disasm_one_func(text_out, image + pc, disasm_len);
>> +
>>           fprintf(text_out, "\n");
>>           pc += func_lens[i];
>>       }
> 
> - Hari


