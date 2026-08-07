Return-Path: <linuxppc-dev+bounces-25537-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F05C5AC67
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 03:21:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGTw42X7Jz3bs0;
	Fri, 07 Aug 2026 13:21:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786072916;
	cv=none; b=YXCR+unA2lwOvv6F1S00PvFjcbMiBS5KS/E534/WI6E5l0J3ERhJwi2DDWXoMaM5LevVw17HjqEgU2j8vFa/sahjQifu9Lc5n3c6sX/NVGjOWi7domb6WHo87ycxTg2ne0F/jCd06Jdk9raCycxHB7zruyOq3IEwBOy8eV+RKXNz1+XIqMZRYtNatXyByl1R6ebuJvxpuYjbwk8CIDREe0HTtWlEnDjHbSnBDGUxBuDgGWgU9zU76rTa2Re9XyXx7hqMiJsMrjcTTVkKvyqAK6AKSbRWp+EhkCET+3px8hQs0cQutQGuy+3rqxVyxxPcxrlfLSEZY+zYctwn1k5row==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786072916; c=relaxed/relaxed;
	bh=oq1/4AteBQkbzcUb15yRekJZzK8hjvwNRsfe0e9P/Zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZikMnlrs5LmnOfzedGXtm0Lh8XHqjc0jR6aNMM1fzdVCxJLvX/IvggPbcF3vvqvsrjDS8TPViLVSyi9TvMZaR3IH/KDsgGdzU5hsUj+V8AE6oGI0zCRbQTw1vwIQlL91TYusjwjkeF3GjhR+RLLJjq4HybMTdu9ISsItdJB1/3n8qhN9wdmpmN9aR2POW2I2dsO6PO9XAvH5YjenmbAQDUm1RzSd7ZOHbl+p2EDDY+d4qseeqdaz5Ur9fiJJyVyR7SL5PZ4szAACIYyeLkQORQZgr2maLAvWJY1420Rv89bSSsqXhFXRUr2mf8pjljdp/FXoxIrtp0M/ebXn0U58Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f5El7pUR; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f5El7pUR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGTw25f9Cz30FB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 13:21:54 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HgYr2276108;
	Fri, 7 Aug 2026 03:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oq1/4A
	teBQkbzcUb15yRekJZzK8hjvwNRsfe0e9P/Zo=; b=f5El7pURZLWJRmua0Cngyv
	79PwGXQbVllzmXhrQ/1jyqcxgiI4Lcgo6OH5pQhFY6YM+MCxOwouiOftQImvTbD3
	dW73YmZAmGrCpQJdKLmqE4kWHP4eiuqyWsltlftOgxSVWy9Vu6LNBMH23IfXvRzl
	FpEFJqicU7CehQNI3IMPdx8pOShfzrogB3RMhgIn7x3VbZn9ccjhzAW/oTvk5S0Y
	CyB6PliIzaAQszbCWf4uT33bpC4BZ+byoBTEd0x4RWbSrvR6WvkYUKyyVh71b6S0
	qKEW8FkZAJ/je+C4+h0Xxplx5TBIYI+cwjHknoMcz6LCMvs5hgcm/vmHkkLj2CiQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy01j05r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 03:21:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6772uTNK025391;
	Fri, 7 Aug 2026 03:21:27 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtywuhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 03:21:27 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6773LQw95112456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 03:21:26 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F0F85805B;
	Fri,  7 Aug 2026 03:21:26 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5278A58058;
	Fri,  7 Aug 2026 03:21:22 +0000 (GMT)
Received: from [9.123.14.9] (unknown [9.123.14.9])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 03:21:22 +0000 (GMT)
Message-ID: <fe4fa7c2-db08-471f-b23d-cb34f38fc947@linux.ibm.com>
Date: Fri, 7 Aug 2026 08:51:02 +0530
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
Subject: Re: [PATCH v10 0/8] powerpc/bpf: address missing verifier selftest
 coverage
To: Hari Bathini <hbathini@linux.ibm.com>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com
References: <cover.1785871099.git.skb99@linux.ibm.com>
 <7ffaff94-b1b1-4420-8c19-c88bf49139a6@linux.ibm.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <7ffaff94-b1b1-4420-8c19-c88bf49139a6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z7FTfv6oZp0G-ItBKcUUUZz30XM-oziG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDAyMSBTYWx0ZWRfX8p08cIsWkVSz
 F06mAN5S52K9xdAfTuB8awDS31/VDQhju4w94XHwMizTLMW9WSjLgzt5TyPNM7k8m1Mu6oHyq0R
 ETJ4YnIdxuIePjDE5Tpgj4d8FBd26Xk=
X-Proofpoint-ORIG-GUID: Z7FTfv6oZp0G-ItBKcUUUZz30XM-oziG
X-Authority-Analysis: v=2.4 cv=afNRWxot c=1 sm=1 tr=0 ts=6a754f38 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=08ZcwYSK7qFRmE5rvXsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDAyMSBTYWx0ZWRfX2h49pkqH+b9a
 WrT7lb09yzUgFaRqtaeXU3nN5hQ8d19Xu/5e3NPSXieaiUS9RWcyKss2LIAoxe61ewXd8Ig8Xyk
 W+hqNiLZOTzz7lKLc6OxnDU+Jq8H7Tsi5DEmazmYrEQy1/N7DxVA22Tm2BGqKrjG4QymDHvkU/y
 OsehHOrLR0zLEUEWzOqqd1ccaSYb3mn3XBz5VTTbbZ7rSs8muXA55fI242X/X5uNazhVH1i/eKv
 gviWVEIrQV/6DmuDDs13+Pqy4Dbq3TTYPH8M+UacxDwXT1/d7j1LIJu3h2WG9bIMRuifJacW1Lk
 UyWiu3wGop1iU6BrOWvrb0Td1zfqG+tsCQdF41EkhcjtuEcFBeGgUZ/NX23X3JCMPYk78slFLs6
 VV/7q29fw4EgAbch9ZtmlnnaO0Tts/yjOvmLQ1Kwn3gr1EMnIzE9eaxYkB8Qd6WrlLQNSbKZ8I9
 8jDAiGFDxqxtBrfI4Rw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070021


On 8/6/26 11:04 PM, Hari Bathini wrote:
>
>
> On 05/08/26 11:36 am, Saket Kumar Bhaskar wrote:
>> From: Abhishek Dubey <adubey@linux.ibm.com>
>>
>> The verifier selftest validates JITed instructions by matching expected
>> disassembly output. The first two patches fix issues in powerpc 
>> instruction
>> disassembly that were causing test flow failures. The fix is common for
>> 64-bit & 32-bit powerpc. Add support for the powerpc-specific 
>> "__powerpc64"
>> architecture tag in the third patch, enabling proper test filtering in
>> verifier test files. Introduce verifier testcases for tailcalls on 
>> powerpc64.
>>
>> The first patch in series is fix patch, correcting memory alignment with
>> 8-byte boundary for long branch address field. The subsequent patches
>> enables verifier selftests on powerpc. The fifth patch in the series 
>> fixes
>> incorrect comparator usage for comparing tailcall info with tailcall
>> threshold. The last two patches fix JIT buffer overflow for large BPF 
>> progs
>> and private stack memory leak (identified by bot during reviews).
>>
>> Issue Details:
>> --------------
>>
>>      The Long branch stub in the trampoline implementation[1] provides
>>      flexibility to handles short as well as long branch distance to
>>      actual trampoline. Whereas, the 8 bytes long dummy_tramp_addr field
>>      sitting before long branch stub leads to failure when enabling
>>      verifier based seltest for ppc64.
>>           The verifier selftests require disassembing the final jited 
>> image
>>      to get native instructions. Later the disassembled instruction
>>      sequence is matched against sequence of instructions provided in
>>      test-file under __jited() wrapper. The final jited image contains
>>      Out-of-line stub and Long branch stub as part of epilogue jitting
>>      for a bpf program. The 8 bytes space for dummy_tramp is sandwiched
>>      between both above mentioned stubs. These 8 bytes contain memory
>>      address of dummy trampoline during trampoline invocation which 
>> don't
>>      correspond to any powerpc instructions. So, disassembly fails
>>      resulting in failure of verifier selftests.
>>           The following code snippet shows the problem with current 
>> arrangement
>>      made for dummy_tramp_addr.
>>           /* Out-of-line stub */
>>      mflr    r0
>>      [b|bl]  tramp
>>      mtlr    r0 //only with OOL
>>      b       bpf_func + 4
>>      /* Long branch stub */
>>      .long   <dummy_tramp_addr>  <---Invalid bytes sequence, 
>> disassembly fails
>>      mflr    r11
>>      bcl     20,31,$+4
>>      mflr    r12
>>      ld      r12, -8-SZL(r12)
>>      mtctr   r12
>>      mtlr    r11 //retain ftrace ABI
>>      bctr
>>
>>      Consider test program binary of size 112 bytes:
>>      0:  00000060 10004de8 00002039 f8ff21f9 81ff21f8 7000e1fb 3000e13b
>>      28: 3000e13b 2a006038 f8ff7ff8 00000039 7000e1eb 80002138 7843037d
>>      56: 2000804e a602087c 00000060 a603087c bcffff4b c0341d00 000000c0
>>      84: a602687d 05009f42 a602887d f0ff8ce9 a603897d a603687d 2004804e
>>
>>      Disassembly output of above binary for ppc64le:
>>      pc:0     left:112    00 00 00 60  :  nop
>>      pc:4     left:108    10 00 4d e8  :  ld 2, 16(13)
>>      pc:8     left:104    00 00 20 39  :  li 9, 0
>>      pc:12    left:100    f8 ff 21 f9  :  std 9, -8(1)
>>      pc:16    left:96     81 ff 21 f8  :  stdu 1, -128(1)
>>      pc:20    left:92     70 00 e1 fb  :  std 31, 112(1)
>>      pc:24    left:88     30 00 e1 3b  :  addi 31, 1, 48
>>      pc:28    left:84     30 00 e1 3b  :  addi 31, 1, 48
>>      pc:32    left:80     2a 00 60 38  :  li 3, 42
>>      pc:36    left:76     f8 ff 7f f8  :  std 3, -8(31)
>>      pc:40    left:72     00 00 00 39  :  li 8, 0
>>      pc:44    left:68     70 00 e1 eb  :  ld 31, 112(1)
>>      pc:48    left:64     80 00 21 38  :  addi 1, 1, 128
>>      pc:52    left:60     78 43 03 7d  :  mr    3, 8
>>      pc:56    left:56     20 00 80 4e  :  blr
>>      pc:60    left:52     a6 02 08 7c  :  mflr 0
>>      pc:64    left:48     00 00 00 60  :  nop
>>      pc:68    left:44     a6 03 08 7c  :  mtlr 0
>>      pc:72    left:40     bc ff ff 4b  :  b .-68
>>      pc:76    left:36     c0 34 1d 00  :
>>      ...
>>
>>      Failure log:
>>      Can't disasm instruction at offset 76: c0 34 1d 00 00 00 00 c0 
>> a6 02 68 7d 05 00 9f 42
>>      --------------------------------------
>>
>>      Observation:
>>      Can't disasm instruction at offset 76 as this address has
>>      ".long <dummy_tramp_addr>" (0xc0341d00000000c0)
>>      But valid instructions follow at offset 84 onwards.
>>
>>      Move the long branch address space to the bottom of the long
>>      branch stub. This allows uninterrupted disassembly until the
>>      last 8 bytes. Exclude these last bytes from the overall
>>      program length to prevent failure in assembly generation.
>>
>>      Following is disassembler output for same test program with 
>> moved down
>>      dummy_tramp_addr field:
>>      .....
>>      .....
>>      pc:68    left:44     a6 03 08 7c  :  mtlr 0
>>      pc:72    left:40     bc ff ff 4b  :  b .-68
>>      pc:76    left:36     a6 02 68 7d  :  mflr 11
>>      pc:80    left:32     05 00 9f 42  :  bcl 20, 31, .+4
>>      pc:84    left:28     a6 02 88 7d  :  mflr 12
>>      pc:88    left:24     14 00 8c e9  :  ld 12, 20(12)
>>      pc:92    left:20     a6 03 89 7d  :  mtctr 12
>>      pc:96    left:16     a6 03 68 7d  :  mtlr 11
>>      pc:100   left:12     20 04 80 4e  :  bctr
>>      pc:104   left:8      c0 34 1d 00  :
>>
>>      Failure log:
>>      Can't disasm instruction at offset 104: c0 34 1d 00 00 00 00 c0
>>      ---------------------------------------
>>      Disassembly logic can truncate at 104, ignoring last 8 bytes.
>>
>>      Update the dummy_tramp_addr field offset calculation from the end
>>      of the program to reflect its new location, for 
>> bpf_arch_text_poke()
>>      to update the actual trampoline's address in this field.
>>
>>      [1] 
>> https://lore.kernel.org/all/20241030070850.1361304-18-hbathini@linux.ibm.com
>>
>> v9->v10:
>>    Modified expected JIT instruction in selftest for
>>    CONFIG_PPC_KERNEL_PCREL incase of PPC_LI64 instruction.
>>    Fix for stale entries in exception table
>>    Update ARCH_POWERPC64 enum value to 0x40 to resolve rebase
>>    conflict with ARCH_LOONGARCH (0x20).
>>
>> v8->v9:
>>    Dynamic pass handling until code keeps shrinking
>>    Fix private stack memory leak
>>
>> v7->v8:
>>    Fixed bot identified issues of alt_exit_addr and BPF_EXIT
>>    Fixed 32-bit ppc function signature mismatch
>>
>> v6->v7:
>>    Fixed JIT buffer overflow in case of large BPF progs
>>    Addressed remaining bot comments
>>
>> v5->v6:
>>    Changed alignment NOP emittion dependency on fimage layout
>>    Adjust tail truncate length for 32-bit ppc
>>    Addressed few minor bot comments
>>
>> v4->v5:
>>    Handled alignment NOP emit logic and corresponding stub offsets
>>    Handled image buffer overflow problem in last pass
>>    Above changes took care of other bot reviews
>>    Included LLVMDisposeMessage() for graceful freeing
>>    Adjusted parameters in bpf_jit_build_fentry_stubs for ppc32
>>    Adjusted expected JIT inst. in tailcall test for
>> CONFIG_PPC_KERNEL_PCREL config
>>    Added fix patch at last for inaccurate use of cmplwi inst.
>>
>> v3->v4:
>>    Changed logic for emitting alignment NOP
>>
>> v2->v3:
>>    Removed fixed NOP from bottom of long branch stub
>>    Rebased on top of bpf-next
>>
>> v1->v2:
>>    Added fix-patch to correct memory alignment in-place
>>    Moved the optional alignmnet NOP before OOL stub
>>
>> [v1]: 
>> https://lore.kernel.org/bpf/20260225013627.22098-1-adubey@linux.ibm.com
>> [v2]: 
>> https://lore.kernel.org/bpf/20260403004011.44417-1-adubey@linux.ibm.com
>> [v3]: 
>> https://lore.kernel.org/bpf/20260411221413.44304-1-adubey@linux.ibm.com
>> [v4]: 
>> https://lore.kernel.org/bpf/20260517214043.12975-1-adubey@linux.ibm.com
>> [v5]: 
>> https://lore.kernel.org/bpf/20260519233812.18787-1-adubey@linux.ibm.com
>> [v6]: 
>> https://lore.kernel.org/bpf/20260529015855.364704-1-adubey@linux.ibm.com
>> [v7]: 
>> https://lore.kernel.org/bpf/20260611153826.31187-1-adubey@linux.ibm.com
>> [v8]: 
>> https://lore.kernel.org/bpf/20260616164741.32252-1-adubey@linux.ibm.com
>> [v9]: 
>> https://lore.kernel.org/bpf/20260623231411.6216-1-adubey@linux.ibm.com/
>>
>> Abhishek Dubey (8):
>>    powerpc/bpf: fix alignment of long branch trampoline addres to t
>>    powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
>>    selftest/bpf: Fixing powerpc JIT disassembly failure
>>    selftest/bpf: Enable verifier selftest for powerpc64
>>    powerpc64/bpf: fix compare instruction emitted for tailcall
>>    selftest/bpf: Add tailcall verifier selftest for powerpc64
>>    powerpc/bpf: fix buffer overflow in JIT for large BPF programs
>>    powerpc64/bpf: fix percpu private stack leak on JIT failure
>>
>>   arch/powerpc/net/bpf_jit.h                    |  20 +++-
>>   arch/powerpc/net/bpf_jit_comp.c               | 102 +++++++++++++-----
>>   arch/powerpc/net/bpf_jit_comp32.c             |   7 +-
>>   arch/powerpc/net/bpf_jit_comp64.c             |  15 +--
>>   .../selftests/bpf/jit_disasm_helpers.c        |  25 ++++-
>>   tools/testing/selftests/bpf/progs/bpf_misc.h  |   1 +
>>   .../bpf/progs/verifier_tailcall_jit.c         |  74 +++++++++++++
>>   tools/testing/selftests/bpf/test_loader.c     |   5 +
>>   8 files changed, 209 insertions(+), 40 deletions(-)
>>
>
> Alexei, Maddy,
>
> Given this has changes in common code too, should this go via bpf tree?
> If yes, @Saket can you post the next revision with bpf tag to make
> it explicit...

If I get an ack from Alexei, I can take this via ppc tree.

Maddy

>
> - Hari

