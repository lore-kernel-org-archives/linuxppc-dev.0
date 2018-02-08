Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zcmDY1qDNzF17y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 04:59:40 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w18Hpih0039345
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Feb 2018 12:59:38 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g0sc8p747-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Feb 2018 12:59:37 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 8 Feb 2018 17:59:36 -0000
Date: Thu, 08 Feb 2018 23:29:30 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH bpf 1/2] bpf: allow 64-bit offsets for bpf function
 calls
To: Alexei Starovoitov <ast@fb.com>, daniel@iogearbox.net, Sandipan Das
 <sandipan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, netdev@vger.kernel.org
References: <20180208120306.2568-1-sandipan@linux.vnet.ibm.com>
 <4ce54c76-f8d5-e739-d9c2-e3318e398417@fb.com>
In-Reply-To: <4ce54c76-f8d5-e739-d9c2-e3318e398417@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1518112079.b4po0pmm3v.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexei Starovoitov wrote:
> On 2/8/18 4:03 AM, Sandipan Das wrote:
>> The imm field of a bpf_insn is a signed 32-bit integer. For
>> JIT-ed bpf-to-bpf function calls, it stores the offset from
>> __bpf_call_base to the start of the callee function.
>>
>> For some architectures, such as powerpc64, it was found that
>> this offset may be as large as 64 bits because of which this
>> cannot be accomodated in the imm field without truncation.
>>
>> To resolve this, we additionally use the aux data within each
>> bpf_prog associated with the caller functions to store the
>> addresses of their respective callees.
>>
>> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
>> ---
>>  kernel/bpf/verifier.c | 39 ++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 5fb69a85d967..52088b4ca02f 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -5282,6 +5282,19 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
>>  	 * run last pass of JIT
>>  	 */
>>  	for (i =3D 0; i <=3D env->subprog_cnt; i++) {
>> +		u32 flen =3D func[i]->len, callee_cnt =3D 0;
>> +		struct bpf_prog **callee;
>> +
>> +		/* for now assume that the maximum number of bpf function
>> +		 * calls that can be made by a caller must be at most the
>> +		 * number of bpf instructions in that function
>> +		 */
>> +		callee =3D kzalloc(sizeof(func[i]) * flen, GFP_KERNEL);
>> +		if (!callee) {
>> +			err =3D -ENOMEM;
>> +			goto out_free;
>> +		}
>> +
>>  		insn =3D func[i]->insnsi;
>>  		for (j =3D 0; j < func[i]->len; j++, insn++) {
>>  			if (insn->code !=3D (BPF_JMP | BPF_CALL) ||
>> @@ -5292,6 +5305,26 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
>>  			insn->imm =3D (u64 (*)(u64, u64, u64, u64, u64))
>>  				func[subprog]->bpf_func -
>>  				__bpf_call_base;
>> +
>> +			/* the offset to the callee from __bpf_call_base
>> +			 * may be larger than what the 32 bit integer imm
>> +			 * can accomodate which will truncate the higher
>> +			 * order bits
>> +			 *
>> +			 * to avoid this, we additionally utilize the aux
>> +			 * data of each caller function for storing the
>> +			 * addresses of every callee associated with it
>> +			 */
>> +			callee[callee_cnt++] =3D func[subprog];
>=20
> can you share typical /proc/kallsyms ?
> Are you saying that kernel and kernel modules are allocated from
> address spaces that are always more than 32-bit apart?

Yes. On ppc64, kernel text is linearly mapped from 0xc000000000000000,=20
while vmalloc'ed area starts from 0xd000000000000000 (for radix, this is
different, but still beyond a 32-bit offset).

> That would mean that all kernel calls into modules are far calls
> and the other way around form .ko into kernel?
> Performance is probably suffering because every call needs to be built
> with full 64-bit offset. No ?

Possibly, and I think Michael can give a better perspective, but I think
this is due to our ABI. For inter-module calls, we need to setup the TOC
pointer (or the address of the function being called with ABIv2), which=20
would require us to load a full address regardless.

- Naveen

=
