Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbYYf5LqgzDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 05:53:10 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 1 Apr 2016 04:53:09 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B360E3578058
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 05:52:56 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2VIqm5O44826708
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 05:52:56 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2VIqNBi018345
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 05:52:24 +1100
Date: Fri, 1 Apr 2016 00:21:39 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Alexei Starovoitov <ast@fb.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 3/4] samples/bpf: Simplify building BPF samples
Message-ID: <20160331185139.GD17907@naverao1-tp.ibm.com>
References: <922f95fb5d16686367a66d2d4bd176149a87e9ad.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
 <0ce1c8bdff478db55490a90db6732c4db9de6f22.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
 <56FD632B.4040306@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56FD632B.4040306@fb.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/03/31 10:49AM, Alexei Starovoitov wrote:
> On 3/31/16 4:25 AM, Naveen N. Rao wrote:
> >Make BPF samples build depend on CONFIG_SAMPLE_BPF. We still don't add a
> >Kconfig option since that will add a dependency on llvm for allyesconfig
> >builds which may not be desirable.
> >
> >Those who need to build the BPF samples can now just do:
> >
> >make CONFIG_SAMPLE_BPF=y
> >
> >or:
> >
> >export CONFIG_SAMPLE_BPF=y
> >make
> 
> I don't like this 'simplification'.
> make samples/bpf/
> is much easier to type than capital letters.

This started out as a patch to have the BPF samples built with a Kconfig 
option. As stated in the commit description, I realised that it won't 
work for allyesconfig builds. However, the reason I retained this patch 
is since it gets us one step closer to building the samples as part of 
the kernel build.

The 'simplification' is since I can now have the export in my .bashrc 
and the kernel build will now build the BPF samples too without 
requiring an additional 'make samples/bpf/' step.

I agree this is subjective, so I am ok if this isn't taken in.


- Naveen
