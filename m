Return-Path: <cascardo@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYKp72qNHzDqCr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 04:56:31 +1000 (AEST)
Date: Mon, 20 Jun 2016 15:56:21 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 Matt Evans <matt@ozlabs.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@fb.com>, Denis Kirjanov <kda@linux-powerpc.org>,
 Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH] ppc: Fix BPF JIT for ABIv2
Message-ID: <20160620185620.GD3516@indiana.gru.redhat.com>
References: <908d3552b5eb240b28f70aee7c4c86e2b600aa02.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
 <3rWKtT2tSrz9t2G@ozlabs.org>
 <20160617130042.GO3516@indiana.gru.redhat.com>
 <20160619174914.GC8886@naverao1-tp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160619174914.GC8886@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 19, 2016 at 11:19:14PM +0530, Naveen N. Rao wrote:
> On 2016/06/17 10:00AM, Thadeu Lima de Souza Cascardo wrote:
> > On Fri, Jun 17, 2016 at 10:53:21PM +1000, Michael Ellerman wrote:
> > > On Tue, 2016-07-06 at 13:32:23 UTC, "Naveen N. Rao" wrote:
> > > > diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> > > > new file mode 100644
> > > > index 0000000..954ff53
> > > > --- /dev/null
> > > > +++ b/arch/powerpc/net/bpf_jit_comp64.c
> > > > @@ -0,0 +1,956 @@
> > > ...
> > > > +
> > > > +static void bpf_jit_fill_ill_insns(void *area, unsigned int size)
> > > > +{
> > > > +	int *p = area;
> > > > +
> > > > +	/* Fill whole space with trap instructions */
> > > > +	while (p < (int *)((char *)area + size))
> > > > +		*p++ = BREAKPOINT_INSTRUCTION;
> > > > +}
> > > 
> > > This breaks the build for some configs, presumably you're missing a header:
> > > 
> > >   arch/powerpc/net/bpf_jit_comp64.c:30:10: error: 'BREAKPOINT_INSTRUCTION' undeclared (first use in this function)
> > > 
> > > http://kisskb.ellerman.id.au/kisskb/buildresult/12720611/
> > > 
> > > cheers
> > 
> > Hi, Michael and Naveen.
> > 
> > I noticed independently that there is a problem with BPF JIT and ABIv2, and
> > worked out the patch below before I noticed Naveen's patchset and the latest
> > changes in ppc tree for a better way to check for ABI versions.
> > 
> > However, since the issue described below affect mainline and stable kernels,
> > would you consider applying it before merging your two patchsets, so that we can
> > more easily backport the fix?
> 
> Hi Cascardo,
> Given that this has been broken on ABIv2 since forever, I didn't bother 
> fixing it. But, I can see why this would be a good thing to have for 
> -stable and existing distros. However, while your patch below may fix 
> the crash you're seeing on ppc64le, it is not sufficient -- you'll need 
> changes in bpf_jit_asm.S as well.

Hi, Naveen.

Any tips on how to exercise possible issues there? Or what changes you think
would be sufficient?

I will see what I can find by myself, but would appreciate any help.

Regards.
Cascardo.

> 
> Regards,
> Naveen
> 
