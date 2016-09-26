Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjJ7n3dg7zDrLK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 19:09:41 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8Q986FP054649
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 05:09:38 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25p6qst988-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 05:09:38 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 26 Sep 2016 14:39:34 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 51233394005E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 14:39:31 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8Q99UJC25559220
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 14:39:30 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8Q99PLG020133
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 14:39:29 +0530
Date: Mon, 26 Sep 2016 14:39:13 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Alexei Starovoitov <ast@fb.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 2/3] bpf powerpc: implement support for tail calls
References: <40b65ab2bb3a48837ab047a70887de3ccd70c56b.1474661927.git.naveen.n.rao@linux.vnet.ibm.com>
 <c7c16b999694b2851705d79da939988e521bda3a.1474661927.git.naveen.n.rao@linux.vnet.ibm.com>
 <57E5ADD2.7090308@iogearbox.net>
 <20160924073025.GB48071@ast-mbp.thefacebook.com>
 <20160926085622.GG15470@naverao1-tp.localdomain>
 <57E8E3B4.5030606@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57E8E3B4.5030606@iogearbox.net>
Message-Id: <20160926090913.GH15470@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/09/26 11:00AM, Daniel Borkmann wrote:
> On 09/26/2016 10:56 AM, Naveen N. Rao wrote:
> > On 2016/09/24 03:30AM, Alexei Starovoitov wrote:
> > > On Sat, Sep 24, 2016 at 12:33:54AM +0200, Daniel Borkmann wrote:
> > > > On 09/23/2016 10:35 PM, Naveen N. Rao wrote:
> > > > > Tail calls allow JIT'ed eBPF programs to call into other JIT'ed eBPF
> > > > > programs. This can be achieved either by:
> > > > > (1) retaining the stack setup by the first eBPF program and having all
> > > > > subsequent eBPF programs re-using it, or,
> > > > > (2) by unwinding/tearing down the stack and having each eBPF program
> > > > > deal with its own stack as it sees fit.
> > > > > 
> > > > > To ensure that this does not create loops, there is a limit to how many
> > > > > tail calls can be done (currently 32). This requires the JIT'ed code to
> > > > > maintain a count of the number of tail calls done so far.
> > > > > 
> > > > > Approach (1) is simple, but requires every eBPF program to have (almost)
> > > > > the same prologue/epilogue, regardless of whether they need it. This is
> > > > > inefficient for small eBPF programs which may not sometimes need a
> > > > > prologue at all. As such, to minimize impact of tail call
> > > > > implementation, we use approach (2) here which needs each eBPF program
> > > > > in the chain to use its own prologue/epilogue. This is not ideal when
> > > > > many tail calls are involved and when all the eBPF programs in the chain
> > > > > have similar prologue/epilogue. However, the impact is restricted to
> > > > > programs that do tail calls. Individual eBPF programs are not affected.
> > > > > 
> > > > > We maintain the tail call count in a fixed location on the stack and
> > > > > updated tail call count values are passed in through this. The very
> > > > > first eBPF program in a chain sets this up to 0 (the first 2
> > > > > instructions). Subsequent tail calls skip the first two eBPF JIT
> > > > > instructions to maintain the count. For programs that don't do tail
> > > > > calls themselves, the first two instructions are NOPs.
> > > > > 
> > > > > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > > > 
> > > > Thanks for adding support, Naveen, that's really great! I think 2) seems
> > > > fine as well in this context as prologue size can vary quite a bit here,
> > > > and depending on program types likelihood of tail call usage as well (but
> > > > I wouldn't expect deep nesting). Thanks a lot!
> > > 
> > > Great stuff. In this circumstances approach 2 makes sense to me as well.
> > 
> > Alexie, Daniel,
> > Thanks for the quick review!
> 
> The patches would go via Michael's tree (same way as with the JIT itself
> in the past), right?

Yes, this set is contained within arch/powerpc, so Michael can take this 
through his tree.

The other set with updates to samples/bpf can probably go through 
David's tree.

- Naveen
