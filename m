Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdyJL6lcczF0cY
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 03:37:03 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1AGaU33135487
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 11:37:00 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g1uxubvnh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 11:36:59 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Sat, 10 Feb 2018 16:36:57 -0000
Subject: Re: [RFC][PATCH bpf 1/2] bpf: allow 64-bit offsets for bpf function
 calls
To: Alexei Starovoitov <ast@fb.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, daniel@iogearbox.net,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, netdev@vger.kernel.org
References: <20180208120306.2568-1-sandipan@linux.vnet.ibm.com>
 <4ce54c76-f8d5-e739-d9c2-e3318e398417@fb.com>
 <1518112079.b4po0pmm3v.naveen@linux.ibm.com>
 <1518194739.ublbsk69cm.naveen@linux.ibm.com>
 <5a552a19-5600-1fd4-57f2-6337127b75e9@fb.com>
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
Date: Sat, 10 Feb 2018 22:06:51 +0530
MIME-Version: 1.0
In-Reply-To: <5a552a19-5600-1fd4-57f2-6337127b75e9@fb.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <26259daa-3064-3c23-f0f9-7ebcdda4b61a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 02/10/2018 06:08 AM, Alexei Starovoitov wrote:
> On 2/9/18 8:54 AM, Naveen N. Rao wrote:
>> Naveen N. Rao wrote:
>>> Alexei Starovoitov wrote:
>>>> On 2/8/18 4:03 AM, Sandipan Das wrote:
>>>>> The imm field of a bpf_insn is a signed 32-bit integer. For
>>>>> JIT-ed bpf-to-bpf function calls, it stores the offset from
>>>>> __bpf_call_base to the start of the callee function.
>>>>>
>>>>> For some architectures, such as powerpc64, it was found that
>>>>> this offset may be as large as 64 bits because of which this
>>>>> cannot be accomodated in the imm field without truncation.
>>>>>
>>>>> To resolve this, we additionally use the aux data within each
>>>>> bpf_prog associated with the caller functions to store the
>>>>> addresses of their respective callees.
>>>>>
>>>>> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
>>>>> ---
>>>>>  kernel/bpf/verifier.c | 39 ++++++++++++++++++++++++++++++++++++++-
>>>>>  1 file changed, 38 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>>> index 5fb69a85d967..52088b4ca02f 100644
>>>>> --- a/kernel/bpf/verifier.c
>>>>> +++ b/kernel/bpf/verifier.c
>>>>> @@ -5282,6 +5282,19 @@ static int jit_subprogs(struct
>>>>> bpf_verifier_env *env)
>>>>>       * run last pass of JIT
>>>>>       */
>>>>>      for (i = 0; i <= env->subprog_cnt; i++) {
>>>>> +        u32 flen = func[i]->len, callee_cnt = 0;
>>>>> +        struct bpf_prog **callee;
>>>>> +
>>>>> +        /* for now assume that the maximum number of bpf function
>>>>> +         * calls that can be made by a caller must be at most the
>>>>> +         * number of bpf instructions in that function
>>>>> +         */
>>>>> +        callee = kzalloc(sizeof(func[i]) * flen, GFP_KERNEL);
>>>>> +        if (!callee) {
>>>>> +            err = -ENOMEM;
>>>>> +            goto out_free;
>>>>> +        }
>>>>> +
>>>>>          insn = func[i]->insnsi;
>>>>>          for (j = 0; j < func[i]->len; j++, insn++) {
>>>>>              if (insn->code != (BPF_JMP | BPF_CALL) ||
>>>>> @@ -5292,6 +5305,26 @@ static int jit_subprogs(struct
>>>>> bpf_verifier_env *env)
>>>>>              insn->imm = (u64 (*)(u64, u64, u64, u64, u64))
>>>>>                  func[subprog]->bpf_func -
>>>>>                  __bpf_call_base;
>>>>> +
>>>>> +            /* the offset to the callee from __bpf_call_base
>>>>> +             * may be larger than what the 32 bit integer imm
>>>>> +             * can accomodate which will truncate the higher
>>>>> +             * order bits
>>>>> +             *
>>>>> +             * to avoid this, we additionally utilize the aux
>>>>> +             * data of each caller function for storing the
>>>>> +             * addresses of every callee associated with it
>>>>> +             */
>>>>> +            callee[callee_cnt++] = func[subprog];
>>>>
>>>> can you share typical /proc/kallsyms ?
>>>> Are you saying that kernel and kernel modules are allocated from
>>>> address spaces that are always more than 32-bit apart?
>>>
>>> Yes. On ppc64, kernel text is linearly mapped from 0xc000000000000000,
>>> while vmalloc'ed area starts from 0xd000000000000000 (for radix, this is
>>> different, but still beyond a 32-bit offset).
>>>
>>>> That would mean that all kernel calls into modules are far calls
>>>> and the other way around form .ko into kernel?
>>>> Performance is probably suffering because every call needs to be built
>>>> with full 64-bit offset. No ?
>>>
>>> Possibly, and I think Michael can give a better perspective, but I think
>>> this is due to our ABI. For inter-module calls, we need to setup the TOC
>>> pointer (or the address of the function being called with ABIv2),
>>> which would require us to load a full address regardless.
>>
>> Thinking more about this, as an optimization, for bpf-to-bpf calls, we
>> could detect a near call and just emit a relative branch since we don't
>> care about TOC with BPF. But, this will depend on whether the different
>> BPF functions are close enough (within 32MB) of one another.
> 
> so that will be just an optimization. Understood.
> How about instead of doing callee = kzalloc(sizeof(func[i]) * flen..
> we keep  insn->off pointing to subprog and move
> prog->aux->func = func;
> before the last JIT pass.
> Then you won't need to alloc this extra array.
> 

Agreed. Will make the necessary changes in v2.

--
With Regards,
Sandipan
