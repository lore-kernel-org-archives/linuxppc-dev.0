Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjHrk1BQLzDrTn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 18:56:38 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8Q8rEuX077569
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 04:56:36 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25p6ajae1y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 04:56:36 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 26 Sep 2016 18:56:33 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7E2F5357805E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 18:56:30 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8Q8uUEu65667110
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 18:56:30 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8Q8uT5t001410
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 18:56:30 +1000
Date: Mon, 26 Sep 2016 14:26:22 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Alexei Starovoitov <ast@fb.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 2/3] bpf powerpc: implement support for tail calls
References: <40b65ab2bb3a48837ab047a70887de3ccd70c56b.1474661927.git.naveen.n.rao@linux.vnet.ibm.com>
 <c7c16b999694b2851705d79da939988e521bda3a.1474661927.git.naveen.n.rao@linux.vnet.ibm.com>
 <57E5ADD2.7090308@iogearbox.net>
 <20160924073025.GB48071@ast-mbp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160924073025.GB48071@ast-mbp.thefacebook.com>
Message-Id: <20160926085622.GG15470@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/09/24 03:30AM, Alexei Starovoitov wrote:
> On Sat, Sep 24, 2016 at 12:33:54AM +0200, Daniel Borkmann wrote:
> > On 09/23/2016 10:35 PM, Naveen N. Rao wrote:
> > >Tail calls allow JIT'ed eBPF programs to call into other JIT'ed eBPF
> > >programs. This can be achieved either by:
> > >(1) retaining the stack setup by the first eBPF program and having all
> > >subsequent eBPF programs re-using it, or,
> > >(2) by unwinding/tearing down the stack and having each eBPF program
> > >deal with its own stack as it sees fit.
> > >
> > >To ensure that this does not create loops, there is a limit to how many
> > >tail calls can be done (currently 32). This requires the JIT'ed code to
> > >maintain a count of the number of tail calls done so far.
> > >
> > >Approach (1) is simple, but requires every eBPF program to have (almost)
> > >the same prologue/epilogue, regardless of whether they need it. This is
> > >inefficient for small eBPF programs which may not sometimes need a
> > >prologue at all. As such, to minimize impact of tail call
> > >implementation, we use approach (2) here which needs each eBPF program
> > >in the chain to use its own prologue/epilogue. This is not ideal when
> > >many tail calls are involved and when all the eBPF programs in the chain
> > >have similar prologue/epilogue. However, the impact is restricted to
> > >programs that do tail calls. Individual eBPF programs are not affected.
> > >
> > >We maintain the tail call count in a fixed location on the stack and
> > >updated tail call count values are passed in through this. The very
> > >first eBPF program in a chain sets this up to 0 (the first 2
> > >instructions). Subsequent tail calls skip the first two eBPF JIT
> > >instructions to maintain the count. For programs that don't do tail
> > >calls themselves, the first two instructions are NOPs.
> > >
> > >Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > 
> > Thanks for adding support, Naveen, that's really great! I think 2) seems
> > fine as well in this context as prologue size can vary quite a bit here,
> > and depending on program types likelihood of tail call usage as well (but
> > I wouldn't expect deep nesting). Thanks a lot!
> 
> Great stuff. In this circumstances approach 2 makes sense to me as well.

Alexie, Daniel,
Thanks for the quick review!

- Naveen
