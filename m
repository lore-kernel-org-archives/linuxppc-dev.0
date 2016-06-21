Return-Path: <cascardo@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYrDR02yczDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 00:47:34 +1000 (AEST)
Date: Tue, 21 Jun 2016 11:47:26 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, Matt Evans <matt@ozlabs.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@fb.com>,
 Denis Kirjanov <kda@linux-powerpc.org>, Paul Mackerras <paulus@samba.org>,
 "David S. Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH] ppc: Fix BPF JIT for ABIv2
Message-ID: <20160621144725.GH3516@indiana.gru.redhat.com>
References: <908d3552b5eb240b28f70aee7c4c86e2b600aa02.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
 <3rWKtT2tSrz9t2G@ozlabs.org>
 <20160617130042.GO3516@indiana.gru.redhat.com>
 <20160619174914.GC8886@naverao1-tp.localdomain>
 <20160620185620.GD3516@indiana.gru.redhat.com>
 <20160621085807.GE8886@naverao1-tp.localdomain>
 <1466507748.18876.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466507748.18876.3.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 21, 2016 at 09:15:48PM +1000, Michael Ellerman wrote:
> On Tue, 2016-06-21 at 14:28 +0530, Naveen N. Rao wrote:
> > On 2016/06/20 03:56PM, Thadeu Lima de Souza Cascardo wrote:
> > > On Sun, Jun 19, 2016 at 11:19:14PM +0530, Naveen N. Rao wrote:
> > > > On 2016/06/17 10:00AM, Thadeu Lima de Souza Cascardo wrote:
> > > > > 
> > > > > Hi, Michael and Naveen.
> > > > > 
> > > > > I noticed independently that there is a problem with BPF JIT and ABIv2, and
> > > > > worked out the patch below before I noticed Naveen's patchset and the latest
> > > > > changes in ppc tree for a better way to check for ABI versions.
> > > > > 
> > > > > However, since the issue described below affect mainline and stable kernels,
> > > > > would you consider applying it before merging your two patchsets, so that we can
> > > > > more easily backport the fix?
> > > > 
> > > > Hi Cascardo,
> > > > Given that this has been broken on ABIv2 since forever, I didn't bother 
> > > > fixing it. But, I can see why this would be a good thing to have for 
> > > > -stable and existing distros. However, while your patch below may fix 
> > > > the crash you're seeing on ppc64le, it is not sufficient -- you'll need 
> > > > changes in bpf_jit_asm.S as well.
> > > 
> > > Hi, Naveen.
> > > 
> > > Any tips on how to exercise possible issues there? Or what changes you think
> > > would be sufficient?
> > 
> > The calling convention is different with ABIv2 and so we'll need changes 
> > in bpf_slow_path_common() and sk_negative_common().
> 
> How big would those changes be? Do we know?
> 
> How come no one reported this was broken previously? This is the first I've
> heard of it being broken.
> 

I just heard of it less than two weeks ago, and only could investigate it last
week, when I realized mainline was also affected.

It looks like the little-endian support for classic JIT were done before the
conversion to ABIv2. And as JIT is disabled by default, no one seems to have
exercised it.

> > However, rather than enabling classic JIT for ppc64le, are we better off 
> > just disabling it?
> > 
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -128,7 +128,7 @@ config PPC
> >         select IRQ_FORCED_THREADING
> >         select HAVE_RCU_TABLE_FREE if SMP
> >         select HAVE_SYSCALL_TRACEPOINTS
> > -       select HAVE_CBPF_JIT
> > +       select HAVE_CBPF_JIT if CPU_BIG_ENDIAN
> >         select HAVE_ARCH_JUMP_LABEL
> >         select ARCH_HAVE_NMI_SAFE_CMPXCHG
> >         select ARCH_HAS_GCOV_PROFILE_ALL
> > 
> > 
> > Michael,
> > Let me know your thoughts on whether you intend to take this patch or 
> > Cascardo's patch for -stable before the eBPF patches. I can redo my 
> > patches accordingly.
> 
> This patch sounds like the best option at the moment for something we can
> backport. Unless the changes to fix it are minimal.
> 
> cheers
> 

With my patch only, I can run a minimal tcpdump tcp port 22 with success. It
correctly filter packets. But as pointed out, slow paths may not be taken.

I don't have strong opinions on what to apply to stable, just that it would be
nice to have something for the crash before applying all the nice changes by
Naveen.

Cascardo.
