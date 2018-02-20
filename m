Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmDnK2sKczF1B9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 08:50:29 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1KJIuUX018567
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 14:22:35 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g8qv6cwmg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 14:22:34 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 20 Feb 2018 19:22:31 -0000
Date: Wed, 21 Feb 2018 00:52:27 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH bpf v2 1/2] bpf: allow 64-bit offsets for bpf
 function calls
To: ast@fb.com, Daniel Borkmann <daniel@iogearbox.net>, Michael Ellerman
 <mpe@ellerman.id.au>, Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
References: <20180213040600.5821-1-sandipan@linux.vnet.ibm.com>
 <d39a3902-39bc-df56-71bf-0e6f9869ce14@iogearbox.net>
 <ad895533-2f15-bfe4-671c-6d1a8c672bbd@iogearbox.net>
 <1518791626.5484j97if6.naveen@linux.ibm.com>
 <87po50roup.fsf@concordia.ellerman.id.au>
In-Reply-To: <87po50roup.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1519153431.im5wioxel1.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>> Daniel Borkmann wrote:
>>> On 02/15/2018 05:25 PM, Daniel Borkmann wrote:
>>>> On 02/13/2018 05:05 AM, Sandipan Das wrote:
>>>>> The imm field of a bpf_insn is a signed 32-bit integer. For
>>>>> JIT-ed bpf-to-bpf function calls, it stores the offset from
>>>>> __bpf_call_base to the start of the callee function.
>>>>>
>>>>> For some architectures, such as powerpc64, it was found that
>>>>> this offset may be as large as 64 bits because of which this
>>>>> cannot be accomodated in the imm field without truncation.
>>>>>
>>>>> To resolve this, we additionally make aux->func within each
>>>>> bpf_prog associated with the functions to point to the list
>>>>> of all function addresses determined by the verifier.
>>>>>
>>>>> We keep the value assigned to the off field of the bpf_insn
>>>>> as a way to index into aux->func and also set aux->func_cnt
>>>>> so that this can be used for performing basic upper bound
>>>>> checks for the off field.
>>>>>
>>>>> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
>>>>> ---
>>>>> v2: Make aux->func point to the list of functions determined
>>>>>     by the verifier rather than allocating a separate callee
>>>>>     list for each function.
>>>>=20
>>>> Approach looks good to me; do you know whether s390x JIT would
>>>> have similar requirement? I think one limitation that would still
>>>> need to be addressed later with such approach would be regarding the
>>>> xlated prog dump in bpftool, see 'BPF calls via JIT' in 7105e828c087
>>>> ("bpf: allow for correlation of maps and helpers in dump"). Any
>>>> ideas for this (potentially if we could use off + imm for calls,
>>>> we'd get to 48 bits, but that seems still not be enough as you say)?
>>
>> All good points. I'm not really sure how s390x works, so I can't comment=
=20
>> on that, but I'm copying Michael Holzheu for his consideration.
>>
>> With the existing scheme, 48 bits won't be enough, so we rejected that=20
>> approach. I can also see how this will be a problem with bpftool, but I=20
>> haven't looked into it in detail. I wonder if we can annotate the output=
=20
>> to indicate the function being referred to?
>>
>>>=20
>>> One other random thought, although I'm not sure how feasible this
>>> is for ppc64 JIT to realize ... but idea would be to have something
>>> like the below:
>>>=20
>>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>>> index 29ca920..daa7258 100644
>>> --- a/kernel/bpf/core.c
>>> +++ b/kernel/bpf/core.c
>>> @@ -512,6 +512,11 @@ int bpf_get_kallsym(unsigned int symnum, unsigned =
long *value, char *type,
>>>  	return ret;
>>>  }
>>>=20
>>> +void * __weak bpf_jit_image_alloc(unsigned long size)
>>> +{
>>> +	return module_alloc(size);
>>> +}
>>> +
>>>  struct bpf_binary_header *
>>>  bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
>>>  		     unsigned int alignment,
>>> @@ -525,7 +530,7 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **ima=
ge_ptr,
>>>  	 * random section of illegal instructions.
>>>  	 */
>>>  	size =3D round_up(proglen + sizeof(*hdr) + 128, PAGE_SIZE);
>>> -	hdr =3D module_alloc(size);
>>> +	hdr =3D bpf_jit_image_alloc(size);
>>>  	if (hdr =3D=3D NULL)
>>>  		return NULL;
>>>=20
>>> And ppc64 JIT could override bpf_jit_image_alloc() in a similar way
>>> like some archs would override the module_alloc() helper through a
>>> custom implementation, usually via __vmalloc_node_range(), so we
>>> could perhaps fit the range for BPF JITed images in a way that they
>>> could use the 32bit imm in the end? There are not that many progs
>>> loaded typically, so the range could be a bit narrower in such case
>>> anyway. (Not sure if this would work out though, but I thought to
>>> bring it up.)
>>
>> That'd be a good option to consider. I don't think we want to allocate=20
>> anything from the linear memory range since users could load=20
>> unprivileged BPF programs and consume a lot of memory that way. I doubt=20
>> if we can map vmalloc'ed memory into the 0xc0 address range, but I'm not=
=20
>> entirely sure.
>>
>> Michael,
>> Is the above possible? The question is if we can have BPF programs be=20
>> allocated within 4GB of __bpf_call_base (which is a kernel symbol), so=20
>> that calls to those programs can be encoded in a 32-bit immediate field=20
>> in a BPF instruction.
>=20
> Hmmm.
>=20
> It's not technically impossible, but I don't think it's really a good
> option.
>=20
> The 0xc range is a linear mapping of RAM, and the kernel tends to be
> near the start of RAM for reasons. That means there generally isn't a
> hole in the 0xc range within 4GB for you to map BPF programs.
>=20
> You could create a hole by making the 0xc mapping non linear, ie.
> mapping some RAM near the kernel elsewhere in the 0xc range, to make a
> hole that you can then remap BPF programs into. But I think that would
> cause a lot of bugs, it's a pretty fundamental assumption that the
> linear mapping is 1:1.
>=20
>> As an extension, we may be able to extend it to=20
>> 48-bits by combining with another BPF instruction field (offset). In=20
>> either case, the vmalloc'ed address range won't work.
>=20
> 48-bits could possibly work, we don't have systems with that much RAM
> *yet*. So you could remap the BPF programs at the end of the 0xc range,
> or somewhere we have a gap in RAM.
>=20
> That would probably still confuse some things, ie. the 0xc mapping would
> be a 1:1 mapping of RAM plus some other stuff, but it might be tractable
> to fix.
>=20
> We don't have page tables for the 0xc range when using the hash MMU, so
> we'd need to either fix that or use some bespoke data structure for
> keeping track of the mappings.
>=20
> It doesn't really appeal :)

Thanks for the detailed explanation. That does look gross :)

>=20
> We load modules in the 0xd range, and they call functions in the kernel,
> we handle that with trampolines. Can you do something similar?

Yes, we already handle this in our JIT. The scenario being considered=20
here is in how the BPF core informs the BPF JIT engine when it has to=20
call out to a different BPF JIT'ed function. The existing approach=20
encodes an offset from __bpf_call_base() in the imm32 field of the BPF=20
instruction itself. For powerpc64 though, I think we'll have to have the=20
address of the JIT'ed BPF functions passed in through other means.

>=20
> You obviously still need a 64-bit branch somewhere, but perhaps you only
> need one, or one per BPF program, rather than one per function call.

We may have more than a single branch depending on how the program is=20
laid out. We are looking to see if it is worth detecting that a call is=20
close-by to do a relative branch, rather than loading a full 64-bit=20
address and branching to that. For BPF-to-BPF calls, we should also be=20
able to skip all the r12/r2 GEP/TOC handling. We may need to emit an=20
additional branch to skip over some instructions (or emit nops) just so=20
we consistently emit a fixed number of instructions each pass.

>=20
>> The alternative is to pass the full 64-bit address of the BPF program in=
=20
>> an auxiliary field (as proposed in this patch set) but we need to fix it=
=20
>> up for 'bpftool' as well.
>=20
> OK. You'll have to explain to me how bpftool is related, I thought it
> was just for loading/examining BPF programs.

It is, and it can also dump loaded BPF programs. When such programs call=20
out to other BPF programs, bpftool currently figures out the address of=20
the target BPF function by essentially doing (__bpf_call_base + imm32)=20
and looking up kallsyms. Since we've established that imm32 is not=20
enough for us, this won't work on powerpc64.

However, if bpf_jit_kallsyms is not enabled, it looks like bpftool will=20
still fail to resolve the call, and only print out an address today. I'm=20
wondering if we can instead encode the bpf prog id in imm32. That way,=20
we should be able to indicate the BPF function being called into. =20
Daniel, is that something we can consider?


Thanks!
- Naveen

=
