Return-Path: <daniel@iogearbox.net>
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrM1J3LLCzF1Cm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 01:45:08 +1100 (AEDT)
Subject: Re: [RFC][PATCH bpf] tools: bpftool: Fix tags for bpf-to-bpf calls
To: Sandipan Das <sandipan@linux.vnet.ibm.com>, naveen.n.rao@linux.vnet.ibm.com
Cc: ast@fb.com, mpe@ellerman.id.au, jakub.kicinski@netronome.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1519153431.im5wioxel1.naveen@linux.ibm.com>
 <20180227121346.16199-1-sandipan@linux.vnet.ibm.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4cdcc751-d830-51ce-23a0-62f773dc015e@iogearbox.net>
Date: Tue, 27 Feb 2018 15:44:55 +0100
MIME-Version: 1.0
In-Reply-To: <20180227121346.16199-1-sandipan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/27/2018 01:13 PM, Sandipan Das wrote:
> "Naveen N. Rao" wrote:
>> I'm wondering if we can instead encode the bpf prog id in
>> imm32. That way, we should be able to indicate the BPF
>> function being called into.  Daniel, is that something we
>> can consider?
> 
> Since each subprog does not get a separate id, we cannot fetch
> the fd and therefore the tag of a subprog. Instead we can use
> the tag of the complete program as shown below.
> 
> "Daniel Borkmann" wrote:
>> I think one limitation that would still need to be addressed later
>> with such approach would be regarding the xlated prog dump in bpftool,
>> see 'BPF calls via JIT' in 7105e828c087 ("bpf: allow for correlation
>> of maps and helpers in dump"). Any ideas for this (potentially if we
>> could use off + imm for calls, we'd get to 48 bits, but that seems
>> still not be enough as you say)?
> 
> As an alternative, this is what I am thinking of:
> 
> Currently, for bpf-to-bpf calls, if bpf_jit_kallsyms is enabled,
> bpftool looks up the name of the corresponding symbol for the
> JIT-ed subprogram and shows it in the xlated dump alongside the
> actual call instruction. However, the lookup is based on the
> target address which is calculated using the imm field of the
> instruction. So, once again, if imm is truncated, we will end
> up with the wrong address. Also, the subprog aux data (which
> has been proposed as a mitigation for this) is not accessible
> from this tool.
> 
> We can still access the tag for the complete bpf program and use
> this with the correct offset in an objdump-like notation as an
> alterative for the name of the subprog that is the target of a
> bpf-to-bpf call instruction.
> 
> Currently, an xlated dump looks like this:
>    0: (85) call pc+2#bpf_prog_5f76847930402518_F
>    1: (b7) r0 = 1
>    2: (95) exit
>    3: (b7) r0 = 2
>    4: (95) exit
> 
> With this patch, it will look like this:
>    0: (85) call pc+2#bpf_prog_8f85936f29a7790a+3

(Note the +2 is the insn->off already.)

>    1: (b7) r0 = 1
>    2: (95) exit
>    3: (b7) r0 = 2
>    4: (95) exit
> 
> where 8f85936f29a7790a is the tag of the bpf program and 3 is
> the offset to the start of the subprog from the start of the
> program.

The problem with this approach would be that right now the name is
something like bpf_prog_5f76847930402518_F where the subprog tag is
just a placeholder so in future, this may well adapt to e.g. the actual
function name from the elf file. Note that when kallsyms is enabled
then a name like bpf_prog_5f76847930402518_F will also appear in stack
traces, perf records, etc, so for correlation/debugging it would really
help to have them the same everywhere.

Worst case if there's nothing better, potentially what one could do in
bpf_prog_get_info_by_fd() is to dump an array of full addresses and
have the imm part as the index pointing to one of them, just unfortunate
that it's likely only needed in ppc64.
