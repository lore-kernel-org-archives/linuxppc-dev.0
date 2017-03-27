Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsPT00xPkzDqY6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 06:38:11 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2RJSgbm186385
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 15:38:01 -0400
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29f2w3kw5k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 15:38:01 -0400
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 28 Mar 2017 01:07:58 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2RJbtGD13172804
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 01:07:55 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2RJbraw032296
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 01:07:55 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, Anton Blanchard <anton@samba.org>
Subject: Re: Optimised memset64/memset32 for powerpc
Date: Tue, 28 Mar 2017 01:07:39 +0530
In-Reply-To: <20170322193030.GA8008@bombadil.infradead.org>
References: <20170322193030.GA8008@bombadil.infradead.org>
Message-Id: <cover.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/03/22 12:30PM, Matthew Wilcox wrote:
> On Wed, Mar 22, 2017 at 06:18:05AM -0700, Matthew Wilcox wrote:
> > There's one other potential user I've been wondering about, which are the
> > various console drivers.  They use 'memsetw' to blank the entire console
> > or lines of the console when scrolling, but the only architecture which
> > ever bothered implementing an optimised version of it was Alpha.
> > 
> > Might be worth it on powerpc actually ... better than a loop calling
> > cpu_to_le16() on each iteration.  That'd complete the set with a
> > memset16().
> 
> All hail plane rides ... This would need to be resplit and merged properly,
> but I think it makes life a little saner.

... not to forget train rides :)

Here's a straight-forward implementation for powerpc64, along with one
other user in bpf. It is obviously non-critical, but given that we have
64K pages on powerpc64, it does help to speed up the BPF JIT.

- Naveen

Naveen N. Rao (2):
  powerpc: string: implement optimized memset variants
  powerpc: bpf: use memset32() to pre-fill traps in BPF page(s)

 arch/powerpc/include/asm/string.h | 24 ++++++++++++++++++++++++
 arch/powerpc/lib/mem_64.S         | 19 ++++++++++++++++++-
 arch/powerpc/net/bpf_jit_comp64.c |  6 +-----
 3 files changed, 43 insertions(+), 6 deletions(-)

-- 
2.11.1
