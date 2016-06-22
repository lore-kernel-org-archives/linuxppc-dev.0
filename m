Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZSR02kJkzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 00:58:52 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5MEsVV3002338
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 10:58:48 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23q9nbmpnr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 10:58:48 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 23 Jun 2016 00:58:45 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DDD103578056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 00:58:43 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5MEwhxN3277142
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 00:58:43 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5MEwgWN010981
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 00:58:43 +1000
Date: Wed, 22 Jun 2016 20:27:25 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Matt Evans <matt@ozlabs.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@fb.com>, netdev@vger.kernel.org,
 Denis Kirjanov <kda@linux-powerpc.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH] ppc: Fix BPF JIT for ABIv2
References: <908d3552b5eb240b28f70aee7c4c86e2b600aa02.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
 <3rWKtT2tSrz9t2G@ozlabs.org>
 <20160617130042.GO3516@indiana.gru.redhat.com>
 <20160619174914.GC8886@naverao1-tp.localdomain>
 <20160620185620.GD3516@indiana.gru.redhat.com>
 <20160621085807.GE8886@naverao1-tp.localdomain>
 <1466507748.18876.3.camel@ellerman.id.au>
 <20160621144725.GH3516@indiana.gru.redhat.com>
 <20160622071225.GJ8886@naverao1-tp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160622071225.GJ8886@naverao1-tp.localdomain>
Message-Id: <20160622145725.GL8886@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/06/22 12:42PM, Naveen N Rao wrote:
> On 2016/06/21 11:47AM, Thadeu Lima de Souza Cascardo wrote:
> > On Tue, Jun 21, 2016 at 09:15:48PM +1000, Michael Ellerman wrote:
> > > On Tue, 2016-06-21 at 14:28 +0530, Naveen N. Rao wrote:
> > > > On 2016/06/20 03:56PM, Thadeu Lima de Souza Cascardo wrote:
> > > > > On Sun, Jun 19, 2016 at 11:19:14PM +0530, Naveen N. Rao wrote:
> > > > > > On 2016/06/17 10:00AM, Thadeu Lima de Souza Cascardo wrote:
> > > > > > > 
> > > > > > > Hi, Michael and Naveen.
> > > > > > > 
> > > > > > > I noticed independently that there is a problem with BPF JIT and ABIv2, and
> > > > > > > worked out the patch below before I noticed Naveen's patchset and the latest
> > > > > > > changes in ppc tree for a better way to check for ABI versions.
> > > > > > > 
> > > > > > > However, since the issue described below affect mainline and stable kernels,
> > > > > > > would you consider applying it before merging your two patchsets, so that we can
> > > > > > > more easily backport the fix?
> > > > > > 
> > > > > > Hi Cascardo,
> > > > > > Given that this has been broken on ABIv2 since forever, I didn't bother 
> > > > > > fixing it. But, I can see why this would be a good thing to have for 
> > > > > > -stable and existing distros. However, while your patch below may fix 
> > > > > > the crash you're seeing on ppc64le, it is not sufficient -- you'll need 
> > > > > > changes in bpf_jit_asm.S as well.
> > > > > 
> > > > > Hi, Naveen.
> > > > > 
> > > > > Any tips on how to exercise possible issues there? Or what changes you think
> > > > > would be sufficient?
> > > > 
> > > > The calling convention is different with ABIv2 and so we'll need changes 
> > > > in bpf_slow_path_common() and sk_negative_common().
> > > 
> > > How big would those changes be? Do we know?

So, this does need quite a few changes:
- the skb helpers need to emit code to setup TOC and the JIT code needs 
  to be updated to setup r12.
- the slow path code needs to be changed to store r3 elsewhere on ABIv2
- the above also means we need to change the stack macros with the 
  proper ABIv2 values
- the little endian support isn't complete as well -- some of the skb 
  helpers are not using byte swap instructions.

As such, I think we should just disable classic JIT on ppc64le.


- Naveen
 
