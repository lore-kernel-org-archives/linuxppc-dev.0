Return-Path: <holzheu@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znCqc6g2czF0q1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 23:10:52 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1MCAXTO038348
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 07:10:50 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g9u8pe5cj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 07:10:44 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <holzheu@linux.vnet.ibm.com>;
 Thu, 22 Feb 2018 12:10:22 -0000
Date: Thu, 22 Feb 2018 13:10:17 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>, "Naveen N. Rao"
 <naveen.n.rao@linux.vnet.ibm.com>, ast@fb.com, Daniel Borkmann
 <daniel@iogearbox.net>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Subject: Re: [RFC][PATCH bpf v2 1/2] bpf: allow 64-bit offsets for bpf
 function calls
In-Reply-To: <20180222130640.0043c8d3@TP-holzheu>
References: <20180213040600.5821-1-sandipan@linux.vnet.ibm.com>
 <d39a3902-39bc-df56-71bf-0e6f9869ce14@iogearbox.net>
 <ad895533-2f15-bfe4-671c-6d1a8c672bbd@iogearbox.net>
 <1518791626.5484j97if6.naveen@linux.ibm.com>
 <20180222130640.0043c8d3@TP-holzheu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20180222131017.3c7aaa79@TP-holzheu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Thu, 22 Feb 2018 13:06:40 +0100
schrieb Michael Holzheu <holzheu@linux.vnet.ibm.com>:

> Am Fri, 16 Feb 2018 21:20:09 +0530
> schrieb "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>:
> 
> > Daniel Borkmann wrote:
> > > On 02/15/2018 05:25 PM, Daniel Borkmann wrote:
> > >> On 02/13/2018 05:05 AM, Sandipan Das wrote:
> > >>> The imm field of a bpf_insn is a signed 32-bit integer. For
> > >>> JIT-ed bpf-to-bpf function calls, it stores the offset from
> > >>> __bpf_call_base to the start of the callee function.
> > >>>
> > >>> For some architectures, such as powerpc64, it was found that
> > >>> this offset may be as large as 64 bits because of which this
> > >>> cannot be accomodated in the imm field without truncation.
> > >>>
> > >>> To resolve this, we additionally make aux->func within each
> > >>> bpf_prog associated with the functions to point to the list
> > >>> of all function addresses determined by the verifier.
> > >>>
> > >>> We keep the value assigned to the off field of the bpf_insn
> > >>> as a way to index into aux->func and also set aux->func_cnt
> > >>> so that this can be used for performing basic upper bound
> > >>> checks for the off field.
> > >>>
> > >>> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
> > >>> ---
> > >>> v2: Make aux->func point to the list of functions determined
> > >>>     by the verifier rather than allocating a separate callee
> > >>>     list for each function.
> > >> 
> > >> Approach looks good to me; do you know whether s390x JIT would
> > >> have similar requirement? I think one limitation that would still
> > >> need to be addressed later with such approach would be regarding the
> > >> xlated prog dump in bpftool, see 'BPF calls via JIT' in 7105e828c087
> > >> ("bpf: allow for correlation of maps and helpers in dump"). Any
> > >> ideas for this (potentially if we could use off + imm for calls,
> > >> we'd get to 48 bits, but that seems still not be enough as you say)?
> > 
> > All good points. I'm not really sure how s390x works, so I can't comment 
> > on that, but I'm copying Michael Holzheu for his consideration.
> > 
> > With the existing scheme, 48 bits won't be enough, so we rejected that 
> > approach. I can also see how this will be a problem with bpftool, but I 
> > haven't looked into it in detail. I wonder if we can annotate the output 
> > to indicate the function being referred to?
> > 
> > > 
> > > One other random thought, although I'm not sure how feasible this
> > > is for ppc64 JIT to realize ... but idea would be to have something
> > > like the below:
> > > 
> > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > index 29ca920..daa7258 100644
> > > --- a/kernel/bpf/core.c
> > > +++ b/kernel/bpf/core.c
> > > @@ -512,6 +512,11 @@ int bpf_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
> > >  	return ret;
> > >  }
> > > 
> > > +void * __weak bpf_jit_image_alloc(unsigned long size)
> > > +{
> > > +	return module_alloc(size);
> > > +}
> > > +
> > >  struct bpf_binary_header *
> > >  bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
> > >  		     unsigned int alignment,
> > > @@ -525,7 +530,7 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
> > >  	 * random section of illegal instructions.
> > >  	 */
> > >  	size = round_up(proglen + sizeof(*hdr) + 128, PAGE_SIZE);
> > > -	hdr = module_alloc(size);
> > > +	hdr = bpf_jit_image_alloc(size);
> > >  	if (hdr == NULL)
> > >  		return NULL;
> > > 
> > > And ppc64 JIT could override bpf_jit_image_alloc() in a similar way
> > > like some archs would override the module_alloc() helper through a
> > > custom implementation, usually via __vmalloc_node_range(), so we
> > > could perhaps fit the range for BPF JITed images in a way that they
> > > could use the 32bit imm in the end? There are not that many progs
> > > loaded typically, so the range could be a bit narrower in such case
> > > anyway. (Not sure if this would work out though, but I thought to
> > > bring it up.)
> > 
> > That'd be a good option to consider. I don't think we want to allocate 
> > anything from the linear memory range since users could load 
> > unprivileged BPF programs and consume a lot of memory that way. I doubt 
> > if we can map vmalloc'ed memory into the 0xc0 address range, but I'm not 
> > entirely sure.
> > 
> > Michael,
> > Is the above possible? The question is if we can have BPF programs be 
> > allocated within 4GB of __bpf_call_base (which is a kernel symbol), so 
> > that calls to those programs can be encoded in a 32-bit immediate field 
> > in a BPF instruction. As an extension, we may be able to extend it to 
> > 48-bits by combining with another BPF instruction field (offset). In 
> > either case, the vmalloc'ed address range won't work.
> > 
> > The alternative is to pass the full 64-bit address of the BPF program in 
> > an auxiliary field (as proposed in this patch set) but we need to fix it 
> > up for 'bpftool' as well.
 
> Hi Naveen,
> 
> Our s390 kernel maintainer Martin Schwidefsky took over
> eBPF responsibility for s390 from me.
> 
> @Martin: Can you answer Navee's question?
> 
> Michael

Damn, I forgot adding Martin to cc.
Time for vacation ;-)

Michael 
