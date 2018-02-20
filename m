Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlwL72k8NzDrVQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 20:29:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, ast@fb.com,
 Daniel Borkmann <daniel@iogearbox.net>,
 Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH bpf v2 1/2] bpf: allow 64-bit offsets for bpf
 function calls
In-Reply-To: <1518791626.5484j97if6.naveen@linux.ibm.com>
References: <20180213040600.5821-1-sandipan@linux.vnet.ibm.com>
 <d39a3902-39bc-df56-71bf-0e6f9869ce14@iogearbox.net>
 <ad895533-2f15-bfe4-671c-6d1a8c672bbd@iogearbox.net>
 <1518791626.5484j97if6.naveen@linux.ibm.com>
Date: Tue, 20 Feb 2018 20:29:18 +1100
Message-ID: <87po50roup.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> Daniel Borkmann wrote:
>> On 02/15/2018 05:25 PM, Daniel Borkmann wrote:
>>> On 02/13/2018 05:05 AM, Sandipan Das wrote:
>>>> The imm field of a bpf_insn is a signed 32-bit integer. For
>>>> JIT-ed bpf-to-bpf function calls, it stores the offset from
>>>> __bpf_call_base to the start of the callee function.
>>>>
>>>> For some architectures, such as powerpc64, it was found that
>>>> this offset may be as large as 64 bits because of which this
>>>> cannot be accomodated in the imm field without truncation.
>>>>
>>>> To resolve this, we additionally make aux->func within each
>>>> bpf_prog associated with the functions to point to the list
>>>> of all function addresses determined by the verifier.
>>>>
>>>> We keep the value assigned to the off field of the bpf_insn
>>>> as a way to index into aux->func and also set aux->func_cnt
>>>> so that this can be used for performing basic upper bound
>>>> checks for the off field.
>>>>
>>>> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
>>>> ---
>>>> v2: Make aux->func point to the list of functions determined
>>>>     by the verifier rather than allocating a separate callee
>>>>     list for each function.
>>> 
>>> Approach looks good to me; do you know whether s390x JIT would
>>> have similar requirement? I think one limitation that would still
>>> need to be addressed later with such approach would be regarding the
>>> xlated prog dump in bpftool, see 'BPF calls via JIT' in 7105e828c087
>>> ("bpf: allow for correlation of maps and helpers in dump"). Any
>>> ideas for this (potentially if we could use off + imm for calls,
>>> we'd get to 48 bits, but that seems still not be enough as you say)?
>
> All good points. I'm not really sure how s390x works, so I can't comment 
> on that, but I'm copying Michael Holzheu for his consideration.
>
> With the existing scheme, 48 bits won't be enough, so we rejected that 
> approach. I can also see how this will be a problem with bpftool, but I 
> haven't looked into it in detail. I wonder if we can annotate the output 
> to indicate the function being referred to?
>
>> 
>> One other random thought, although I'm not sure how feasible this
>> is for ppc64 JIT to realize ... but idea would be to have something
>> like the below:
>> 
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 29ca920..daa7258 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -512,6 +512,11 @@ int bpf_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
>>  	return ret;
>>  }
>> 
>> +void * __weak bpf_jit_image_alloc(unsigned long size)
>> +{
>> +	return module_alloc(size);
>> +}
>> +
>>  struct bpf_binary_header *
>>  bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
>>  		     unsigned int alignment,
>> @@ -525,7 +530,7 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
>>  	 * random section of illegal instructions.
>>  	 */
>>  	size = round_up(proglen + sizeof(*hdr) + 128, PAGE_SIZE);
>> -	hdr = module_alloc(size);
>> +	hdr = bpf_jit_image_alloc(size);
>>  	if (hdr == NULL)
>>  		return NULL;
>> 
>> And ppc64 JIT could override bpf_jit_image_alloc() in a similar way
>> like some archs would override the module_alloc() helper through a
>> custom implementation, usually via __vmalloc_node_range(), so we
>> could perhaps fit the range for BPF JITed images in a way that they
>> could use the 32bit imm in the end? There are not that many progs
>> loaded typically, so the range could be a bit narrower in such case
>> anyway. (Not sure if this would work out though, but I thought to
>> bring it up.)
>
> That'd be a good option to consider. I don't think we want to allocate 
> anything from the linear memory range since users could load 
> unprivileged BPF programs and consume a lot of memory that way. I doubt 
> if we can map vmalloc'ed memory into the 0xc0 address range, but I'm not 
> entirely sure.
>
> Michael,
> Is the above possible? The question is if we can have BPF programs be 
> allocated within 4GB of __bpf_call_base (which is a kernel symbol), so 
> that calls to those programs can be encoded in a 32-bit immediate field 
> in a BPF instruction.

Hmmm.

It's not technically impossible, but I don't think it's really a good
option.

The 0xc range is a linear mapping of RAM, and the kernel tends to be
near the start of RAM for reasons. That means there generally isn't a
hole in the 0xc range within 4GB for you to map BPF programs.

You could create a hole by making the 0xc mapping non linear, ie.
mapping some RAM near the kernel elsewhere in the 0xc range, to make a
hole that you can then remap BPF programs into. But I think that would
cause a lot of bugs, it's a pretty fundamental assumption that the
linear mapping is 1:1.

> As an extension, we may be able to extend it to 
> 48-bits by combining with another BPF instruction field (offset). In 
> either case, the vmalloc'ed address range won't work.

48-bits could possibly work, we don't have systems with that much RAM
*yet*. So you could remap the BPF programs at the end of the 0xc range,
or somewhere we have a gap in RAM.

That would probably still confuse some things, ie. the 0xc mapping would
be a 1:1 mapping of RAM plus some other stuff, but it might be tractable
to fix.

We don't have page tables for the 0xc range when using the hash MMU, so
we'd need to either fix that or use some bespoke data structure for
keeping track of the mappings.

It doesn't really appeal :)

We load modules in the 0xd range, and they call functions in the kernel,
we handle that with trampolines. Can you do something similar?

You obviously still need a 64-bit branch somewhere, but perhaps you only
need one, or one per BPF program, rather than one per function call.

> The alternative is to pass the full 64-bit address of the BPF program in 
> an auxiliary field (as proposed in this patch set) but we need to fix it 
> up for 'bpftool' as well.

OK. You'll have to explain to me how bpftool is related, I thought it
was just for loading/examining BPF programs.

cheers
