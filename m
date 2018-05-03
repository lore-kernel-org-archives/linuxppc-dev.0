Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cJkP2vzWzF2WL
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 01:20:45 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w43FKZXD074956
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 May 2018 11:20:40 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hr38c525s-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 May 2018 11:20:39 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 3 May 2018 16:20:37 +0100
Date: Thu, 03 May 2018 20:50:31 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH bpf] tools: bpftool: Fix tags for bpf-to-bpf calls
To: Alexei Starovoitov <ast@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: jakub.kicinski@netronome.com, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
References: <1519153431.im5wioxel1.naveen@linux.ibm.com>
 <20180227121346.16199-1-sandipan@linux.vnet.ibm.com>
 <4cdcc751-d830-51ce-23a0-62f773dc015e@iogearbox.net>
 <1519891203.b146m3c5tj.naveen@linux.ibm.com>
 <415b415e-f47f-082c-1bc9-87d3e9d3aed1__9575.16645216874$1520270545$gmane$org@fb.com>
In-Reply-To: <415b415e-f47f-082c-1bc9-87d3e9d3aed1__9575.16645216874$1520270545$gmane$org@
 fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1525359470.vtelzti5l2.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexei Starovoitov wrote:
> On 3/1/18 12:51 AM, Naveen N. Rao wrote:
>> Daniel Borkmann wrote:
>>>
>>> Worst case if there's nothing better, potentially what one could do in
>>> bpf_prog_get_info_by_fd() is to dump an array of full addresses and
>>> have the imm part as the index pointing to one of them, just unfortunat=
e
>>> that it's likely only needed in ppc64.
>>
>> Ok. We seem to have discussed a few different aspects in this thread.
>> Let me summarize the different aspects we have discussed:
>> 1. Passing address of JIT'ed function to the JIT engines:
>>    Two approaches discussed:
>>    a. Existing approach, where the subprog address is encoded as an
>> offset from __bpf_call_base() in imm32 field of the BPF call
>> instruction. This requires the JIT'ed function to be within 2GB of
>> __bpf_call_base(), which won't be true on ppc64, at the least. So,
>> this won't on ppc64 (and any other architectures where vmalloc'ed
>> (module_alloc()) memory is from a different, far, address range).
>=20
> it looks like ppc64 doesn't guarantee today that all of module_alloc()
> will be within 32-bit, but I think it should be trivial to add such
> guarantee. If so, we can define another __bpf_call_base specifically
> for bpf-to-bpf calls when jit is on.

Ok, we prefer not to do that for powerpc (atleast, not for all of=20
module_alloc()) at this point.

And since option (c) below is not preferable, I think we will implement=20
what Daniel suggested above. This patchset already handles communicating=20
the BPF function addresses to the JIT engine, and enhancing=20
bpf_prog_get_info_by_fd() should address the concerns with bpftool.


- Naveen

=
