Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsR511GmlzF1bT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2018 19:52:04 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w218oGiR143096
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Mar 2018 03:52:02 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gecbed9jh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Mar 2018 03:52:02 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 1 Mar 2018 08:51:59 -0000
Date: Thu, 01 Mar 2018 14:21:51 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH bpf] tools: bpftool: Fix tags for bpf-to-bpf calls
To: Daniel Borkmann <daniel@iogearbox.net>, Sandipan Das
 <sandipan@linux.vnet.ibm.com>
Cc: ast@fb.com, jakub.kicinski@netronome.com, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, netdev@vger.kernel.org
References: <1519153431.im5wioxel1.naveen@linux.ibm.com>
 <20180227121346.16199-1-sandipan@linux.vnet.ibm.com>
 <4cdcc751-d830-51ce-23a0-62f773dc015e@iogearbox.net>
In-Reply-To: <4cdcc751-d830-51ce-23a0-62f773dc015e@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1519891203.b146m3c5tj.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Daniel Borkmann wrote:
> On 02/27/2018 01:13 PM, Sandipan Das wrote:
>> With this patch, it will look like this:
>>    0: (85) call pc+2#bpf_prog_8f85936f29a7790a+3
>=20
> (Note the +2 is the insn->off already.)
>=20
>>    1: (b7) r0 =3D 1
>>    2: (95) exit
>>    3: (b7) r0 =3D 2
>>    4: (95) exit
>>=20
>> where 8f85936f29a7790a is the tag of the bpf program and 3 is
>> the offset to the start of the subprog from the start of the
>> program.
>=20
> The problem with this approach would be that right now the name is
> something like bpf_prog_5f76847930402518_F where the subprog tag is
> just a placeholder so in future, this may well adapt to e.g. the actual
> function name from the elf file. Note that when kallsyms is enabled
> then a name like bpf_prog_5f76847930402518_F will also appear in stack
> traces, perf records, etc, so for correlation/debugging it would really
> help to have them the same everywhere.
>=20
> Worst case if there's nothing better, potentially what one could do in
> bpf_prog_get_info_by_fd() is to dump an array of full addresses and
> have the imm part as the index pointing to one of them, just unfortunate
> that it's likely only needed in ppc64.

Ok. We seem to have discussed a few different aspects in this thread. =20
Let me summarize the different aspects we have discussed:
1. Passing address of JIT'ed function to the JIT engines:
    Two approaches discussed:
    a. Existing approach, where the subprog address is encoded as an=20
    offset from __bpf_call_base() in imm32 field of the BPF call=20
    instruction. This requires the JIT'ed function to be within 2GB of=20
    __bpf_call_base(), which won't be true on ppc64, at the least. So,=20
    this won't on ppc64 (and any other architectures where vmalloc'ed=20
    (module_alloc()) memory is from a different, far, address range).
   =20
    [As a side note, is it _actually_ guaranteed that JIT'ed functions=20
    will be within 2GB (signed 32-bit...) on all other architectures=20
    where BPF JIT is supported? I'm not quite sure how memory allocation=20
    works on other architectures, but it looks like this can fail if=20
    there are other larger allocations.]

    b. Pass the full 64-bit address of the call target in an auxiliary=20
    field for the JIT engine to use (as implemented in this mail chain). =20
    We can then use this to determine the call target if this is a=20
    pseudo call.

    There is a third option we can consider:
    c. Convert BPF pseudo call instruction into a 2-instruction sequence=20
    (similar to BPF_DW) and encode the full 64-bit call target in the=20
    second bpf instruction. To distinguish this from other instruction=20
    forms, we can set imm32 to -1.

    If we go with (b) or (c), we will need to take a call on whether we=20
    will implement this in the same manner across all architectures, or=20
    if we should have ppc64 (and any other affected architectures) work=20
    differently from the rest.

    Further more, for (b), bpftool won't be able to derive the target=20
    function call address, but approaches (a) and (c) are fine. More=20
    about that below...

2. Indicating target function in bpftool:
    In the existing approach, bpftool can determine target address since=20
    the offset is encoded in imm32 and is able to lookup the name from=20
    kallsyms, if enabled.

    If we go with approach (b) for ppc64, this won't work and we will=20
    have to minimally update bpftool to detect that the target address=20
    is not available on ppc64.

    If we go with approach (c), the target address will be available and=20
    we should be able to update bpftool to look that up.
=20
    [As a side note, I suppose part of Sandipan's point with the=20
    previous patch was to make the bpftool output consistent whether or=20
    not JIT is enabled. It does look a bit weird that bpftool shows the=20
    address of a JIT'ed function when asked to print the BPF bytecode.]

Thoughts?


- Naveen

=
