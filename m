Return-Path: <schwidefsky@de.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ADE021A05BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 21:32:13 +1000 (AEST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <schwidefsky@de.ibm.com>;
 Thu, 27 Aug 2015 12:32:02 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5E65217D8066
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 12:33:05 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7RBVMTF37224512
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 11:31:25 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7RBVCR0018788
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 05:31:13 -0600
Date: Thu, 27 Aug 2015 13:31:02 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Joseph Myers <joseph@codesourcery.com>, "David	S.Miller"
 <davem@davemloft.net>, heiko.carstens@de.ibm.com,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Ping Re: [PATCH 0/8] math-emu: Update kernel math-emu code from
 current glibc soft-fp
Message-ID: <20150827133102.77026410@mschwide>
In-Reply-To: <1440645125.23182.11.camel@ellerman.id.au>
References: <alpine.DEB.2.10.1507021542380.29415@digraph.polyomino.org.uk>
 <alpine.DEB.2.10.1508191433380.11312@digraph.polyomino.org.uk>
 <1440026806.13406.2.camel@ellerman.id.au>
 <alpine.DEB.2.10.1508261442440.13146@digraph.polyomino.org.uk>
 <1440645125.23182.11.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 27 Aug 2015 13:12:05 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> On Wed, 2015-08-26 at 14:44 +0000, Joseph Myers wrote:
> > On Thu, 20 Aug 2015, Michael Ellerman wrote:
> > 
> > > On Wed, 2015-08-19 at 14:39 +0000, Joseph Myers wrote:
> > > > I'd like to ping this patch series, not having seen any comments on it.
> > > > 
> > > > [PATCH 0/8] math-emu: Update kernel math-emu code from current glibc soft-fp
> > > > https://lkml.org/lkml/2015/7/2/394
> > > > 
> > > > [PATCH 1/8] math-emu: Move math-emu to math-emu-old
> > > > https://lkml.org/lkml/2015/7/2/395
> > > > 
> > > > [PATCH 2/8] math-emu: Import current glibc soft-fp as include/math-emu
> > > > https://lkml.org/lkml/2015/7/2/398
> > > > 
> > > > [PATCH 3/8] alpha/math-emu: Move alpha from math-emu-old to math-emu
> > > > https://lkml.org/lkml/2015/7/2/399
> > > > 
> > > > [PATCH 4/8] powerpc/math-emu: Move powerpc from math-emu-old to math-emu
> > > > https://lkml.org/lkml/2015/7/2/400
> > > > 
> > > > [PATCH 5/8] s390/math-emu: Move s390 from math-emu-old to math-emu
> > > > https://lkml.org/lkml/2015/7/2/401
> > > > 
> > > > [PATCH 6/8] sh/math-emu: Move sh from math-emu-old to math-emu
> > > > https://lkml.org/lkml/2015/7/2/402
> > > > 
> > > > [PATCH 7/8] sparc/math-emu: Move sparc from math-emu-old to math-emu
> > > > https://lkml.org/lkml/2015/7/2/404
> > > > 
> > > > [PATCH 8/8] math-emu: Remove math-emu-old
> > > > https://lkml.org/lkml/2015/7/2/405
> > > > 
> > > > As noted in patch 0, the dependencies are as follows: patch 2 depends on 
> > > > patch 1, patches 3-7 depend on patches 1 and 2 but are independent of each 
> > > > other, patch 8 depends on all the other patches.
> > > 
> > > Hi Joseph,
> > > 
> > > I have done some testing on powerpc, and it seems good.
> > > 
> > > I'm reluctant to proceed with merging them though until we've heard at least
> > > *something* from the other maintainers.
> > 
> > Ping again for the other-architecture maintainers (alpha, s390, sh, 
> > sparc)....
> 
> 
> OK I've put this whole series in a branch with the acks we have so far.
> 
> I'll ask Stephen to put it in linux-next once 4.3-rc1 is out, and I'll ask
> Linus to pull it for 4.4
> 
> I haven't published the branch yet, so if the s390 and sparc maintainers want
> to send me acks I'll rebase and add them.
> 

For the s390 parts:
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com> 


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
