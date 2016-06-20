Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYS3H686TzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 09:38:19 +1000 (AEST)
Message-ID: <1466465899.437.0.camel@ellerman.id.au>
Subject: Re: [6/6] ppc: ebpf/jit: Implement JIT compiler for extended BPF
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, Matt Evans <matt@ozlabs.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Alexei Starovoitov <ast@fb.com>, Denis Kirjanov
 <kda@linux-powerpc.org>, Paul Mackerras <paulus@samba.org>, "David S.
 Miller" <davem@davemloft.net>, Ananth N Mavinakayanahalli
 <ananth@in.ibm.com>
Date: Tue, 21 Jun 2016 09:38:19 +1000
In-Reply-To: <20160619173642.GB8886@naverao1-tp.localdomain>
References: <908d3552b5eb240b28f70aee7c4c86e2b600aa02.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
 <3rWKtT2tSrz9t2G@ozlabs.org>
 <20160619173642.GB8886@naverao1-tp.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-06-19 at 23:06 +0530, Naveen N. Rao wrote:
> On 2016/06/17 10:53PM, Michael Ellerman wrote:
> > On Tue, 2016-07-06 at 13:32:23 UTC, "Naveen N. Rao" wrote:
> > > diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> > > new file mode 100644
> > > index 0000000..954ff53
> > > --- /dev/null
> > > +++ b/arch/powerpc/net/bpf_jit_comp64.c
> > > @@ -0,0 +1,956 @@
> > ...

> > > +
> > > +static void bpf_jit_fill_ill_insns(void *area, unsigned int size)
> > > +{
> > > +	int *p = area;
> > > +
> > > +	/* Fill whole space with trap instructions */
> > > +	while (p < (int *)((char *)area + size))
> > > +		*p++ = BREAKPOINT_INSTRUCTION;
> > > +}
> > 
> > This breaks the build for some configs, presumably you're missing a header:
> > 
> >   arch/powerpc/net/bpf_jit_comp64.c:30:10: error: 'BREAKPOINT_INSTRUCTION' undeclared (first use in this function)
> > 
> > http://kisskb.ellerman.id.au/kisskb/buildresult/12720611/
> 
> Oops. Yes, I should have caught that. I need to add:
> 
> #include <asm/kprobes.h>
> 
> in bpf_jit_comp64.c
> 
> Can you please check if it resolves the build error?

Can you? :D

cheers
