Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZCbh0k5NzDqFM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 15:20:32 +1000 (AEST)
Message-ID: <1466572831.19785.5.camel@ellerman.id.au>
Subject: Re: [PATCH] ppc: Fix BPF JIT for ABIv2
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Thadeu Lima de
 Souza Cascardo <cascardo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, Matt Evans <matt@ozlabs.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Alexei Starovoitov <ast@fb.com>, Denis Kirjanov
 <kda@linux-powerpc.org>, Paul Mackerras <paulus@samba.org>, "David S.
 Miller" <davem@davemloft.net>, Ananth N Mavinakayanahalli
 <ananth@in.ibm.com>
Date: Wed, 22 Jun 2016 15:20:31 +1000
In-Reply-To: <20160621085807.GE8886@naverao1-tp.localdomain>
References: <908d3552b5eb240b28f70aee7c4c86e2b600aa02.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
 <3rWKtT2tSrz9t2G@ozlabs.org> <20160617130042.GO3516@indiana.gru.redhat.com>
 <20160619174914.GC8886@naverao1-tp.localdomain>
 <20160620185620.GD3516@indiana.gru.redhat.com>
 <20160621085807.GE8886@naverao1-tp.localdomain>
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

On Tue, 2016-06-21 at 14:28 +0530, Naveen N. Rao wrote:
> On 2016/06/20 03:56PM, Thadeu Lima de Souza Cascardo wrote:
> > On Sun, Jun 19, 2016 at 11:19:14PM +0530, Naveen N. Rao wrote:
> > > On 2016/06/17 10:00AM, Thadeu Lima de Souza Cascardo wrote:
> > > > 
> > > > Hi, Michael and Naveen.
> > > > 
> > > > I noticed independently that there is a problem with BPF JIT and ABIv2, and
> > > > worked out the patch below before I noticed Naveen's patchset and the latest
> > > > changes in ppc tree for a better way to check for ABI versions.
> > > > 
> > > > However, since the issue described below affect mainline and stable kernels,
> > > > would you consider applying it before merging your two patchsets, so that we can
> > > > more easily backport the fix?
> > > 
> > > Hi Cascardo,
> > > Given that this has been broken on ABIv2 since forever, I didn't bother 
> > > fixing it. But, I can see why this would be a good thing to have for 
> > > -stable and existing distros. However, while your patch below may fix 
> > > the crash you're seeing on ppc64le, it is not sufficient -- you'll need 
> > > changes in bpf_jit_asm.S as well.
> > 
> > Hi, Naveen.
> > 
> > Any tips on how to exercise possible issues there? Or what changes you think
> > would be sufficient?
> 
> The calling convention is different with ABIv2 and so we'll need changes 
> in bpf_slow_path_common() and sk_negative_common().
> 
> However, rather than enabling classic JIT for ppc64le, are we better off 
> just disabling it?
> 
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -128,7 +128,7 @@ config PPC
>         select IRQ_FORCED_THREADING
>         select HAVE_RCU_TABLE_FREE if SMP
>         select HAVE_SYSCALL_TRACEPOINTS
> -       select HAVE_CBPF_JIT
> +       select HAVE_CBPF_JIT if CPU_BIG_ENDIAN
>         select HAVE_ARCH_JUMP_LABEL
>         select ARCH_HAVE_NMI_SAFE_CMPXCHG
>         select ARCH_HAS_GCOV_PROFILE_ALL
> 
> 
> Michael,
> Let me know your thoughts on whether you intend to take this patch or 
> Cascardo's patch for -stable before the eBPF patches. I can redo my 
> patches accordingly.

Can one of you send me a proper version of this patch, with change log and
sign-off etc.

cheers
