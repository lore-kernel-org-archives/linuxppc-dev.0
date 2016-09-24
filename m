Return-Path: <alexei.starovoitov@gmail.com>
Received: from mail-pa0-f67.google.com (mail-pa0-f67.google.com
 [209.85.220.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sh23Q5S7kzDrLX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Sep 2016 17:31:30 +1000 (AEST)
Received: by mail-pa0-f67.google.com with SMTP id i5so2869353pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Sep 2016 00:31:30 -0700 (PDT)
Date: Sat, 24 Sep 2016 03:30:26 -0400
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Alexei Starovoitov <ast@fb.com>, "David S. Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH 2/3] bpf powerpc: implement support for tail calls
Message-ID: <20160924073025.GB48071@ast-mbp.thefacebook.com>
References: <40b65ab2bb3a48837ab047a70887de3ccd70c56b.1474661927.git.naveen.n.rao@linux.vnet.ibm.com>
 <c7c16b999694b2851705d79da939988e521bda3a.1474661927.git.naveen.n.rao@linux.vnet.ibm.com>
 <57E5ADD2.7090308@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57E5ADD2.7090308@iogearbox.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 24, 2016 at 12:33:54AM +0200, Daniel Borkmann wrote:
> On 09/23/2016 10:35 PM, Naveen N. Rao wrote:
> >Tail calls allow JIT'ed eBPF programs to call into other JIT'ed eBPF
> >programs. This can be achieved either by:
> >(1) retaining the stack setup by the first eBPF program and having all
> >subsequent eBPF programs re-using it, or,
> >(2) by unwinding/tearing down the stack and having each eBPF program
> >deal with its own stack as it sees fit.
> >
> >To ensure that this does not create loops, there is a limit to how many
> >tail calls can be done (currently 32). This requires the JIT'ed code to
> >maintain a count of the number of tail calls done so far.
> >
> >Approach (1) is simple, but requires every eBPF program to have (almost)
> >the same prologue/epilogue, regardless of whether they need it. This is
> >inefficient for small eBPF programs which may not sometimes need a
> >prologue at all. As such, to minimize impact of tail call
> >implementation, we use approach (2) here which needs each eBPF program
> >in the chain to use its own prologue/epilogue. This is not ideal when
> >many tail calls are involved and when all the eBPF programs in the chain
> >have similar prologue/epilogue. However, the impact is restricted to
> >programs that do tail calls. Individual eBPF programs are not affected.
> >
> >We maintain the tail call count in a fixed location on the stack and
> >updated tail call count values are passed in through this. The very
> >first eBPF program in a chain sets this up to 0 (the first 2
> >instructions). Subsequent tail calls skip the first two eBPF JIT
> >instructions to maintain the count. For programs that don't do tail
> >calls themselves, the first two instructions are NOPs.
> >
> >Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> 
> Thanks for adding support, Naveen, that's really great! I think 2) seems
> fine as well in this context as prologue size can vary quite a bit here,
> and depending on program types likelihood of tail call usage as well (but
> I wouldn't expect deep nesting). Thanks a lot!

Great stuff. In this circumstances approach 2 makes sense to me as well.
