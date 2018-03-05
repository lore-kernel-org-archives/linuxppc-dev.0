Return-Path: <prvs=660224a392=ast@fb.com>
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zw6C723R6zDrbH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 04:21:38 +1100 (AEDT)
Subject: Re: [RFC][PATCH bpf] tools: bpftool: Fix tags for bpf-to-bpf calls
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Sandipan Das <sandipan@linux.vnet.ibm.com>
References: <1519153431.im5wioxel1.naveen@linux.ibm.com>
 <20180227121346.16199-1-sandipan@linux.vnet.ibm.com>
 <4cdcc751-d830-51ce-23a0-62f773dc015e@iogearbox.net>
 <1519891203.b146m3c5tj.naveen@linux.ibm.com>
CC: <jakub.kicinski@netronome.com>, <linuxppc-dev@lists.ozlabs.org>,
 <mpe@ellerman.id.au>, <netdev@vger.kernel.org>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <415b415e-f47f-082c-1bc9-87d3e9d3aed1@fb.com>
Date: Mon, 5 Mar 2018 09:02:20 -0800
MIME-Version: 1.0
In-Reply-To: <1519891203.b146m3c5tj.naveen@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/1/18 12:51 AM, Naveen N. Rao wrote:
> Daniel Borkmann wrote:
>> On 02/27/2018 01:13 PM, Sandipan Das wrote:
>>> With this patch, it will look like this:
>>>    0: (85) call pc+2#bpf_prog_8f85936f29a7790a+3
>>
>> (Note the +2 is the insn->off already.)
>>
>>>    1: (b7) r0 = 1
>>>    2: (95) exit
>>>    3: (b7) r0 = 2
>>>    4: (95) exit
>>>
>>> where 8f85936f29a7790a is the tag of the bpf program and 3 is
>>> the offset to the start of the subprog from the start of the
>>> program.
>>
>> The problem with this approach would be that right now the name is
>> something like bpf_prog_5f76847930402518_F where the subprog tag is
>> just a placeholder so in future, this may well adapt to e.g. the actual
>> function name from the elf file. Note that when kallsyms is enabled
>> then a name like bpf_prog_5f76847930402518_F will also appear in stack
>> traces, perf records, etc, so for correlation/debugging it would really
>> help to have them the same everywhere.
>>
>> Worst case if there's nothing better, potentially what one could do in
>> bpf_prog_get_info_by_fd() is to dump an array of full addresses and
>> have the imm part as the index pointing to one of them, just unfortunate
>> that it's likely only needed in ppc64.
>
> Ok. We seem to have discussed a few different aspects in this thread.
> Let me summarize the different aspects we have discussed:
> 1. Passing address of JIT'ed function to the JIT engines:
>    Two approaches discussed:
>    a. Existing approach, where the subprog address is encoded as an
> offset from __bpf_call_base() in imm32 field of the BPF call
> instruction. This requires the JIT'ed function to be within 2GB of
> __bpf_call_base(), which won't be true on ppc64, at the least. So,
> this won't on ppc64 (and any other architectures where vmalloc'ed
> (module_alloc()) memory is from a different, far, address range).

it looks like ppc64 doesn't guarantee today that all of module_alloc()
will be within 32-bit, but I think it should be trivial to add such
guarantee. If so, we can define another __bpf_call_base specifically
for bpf-to-bpf calls when jit is on.
Then jit_subprogs() math will fit:
insn->imm = func[subprog]->bpf_func - __bpf_call_base_for_jited_progs;
and will make it easier for ppc64 jit to optimize and use
near calls for bpf-to-bpf calls while still using trampoline
for bpf-to-kernel.
Also it solves bpftool issue.
For all other archs we can keep
__bpf_call_base_for_jited_progs == __bpf_call_base

>    There is a third option we can consider:
>    c. Convert BPF pseudo call instruction into a 2-instruction sequence
>    (similar to BPF_DW) and encode the full 64-bit call target in the
> second bpf instruction. To distinguish this from other instruction
> forms, we can set imm32 to -1.

Adding new instruction just for that case looks like overkill.
