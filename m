Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wR7ps71GrzDqLL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 15:06:45 +1000 (AEST)
In-Reply-To: <20170504204112.130d7735@roar.ozlabs.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, ego <ego@linux.vnet.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, mahesh@linux.vnet.ibm.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [linux-next, bisected,
 1945bc45] build brakes for PowerPC BE configuration on LPAR
Message-Id: <3wR7ps3BjQz9s86@ozlabs.org>
Date: Mon, 15 May 2017 15:06:45 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-05-04 at 10:41:12 UTC, Nicholas Piggin wrote:
> On Thu, 04 May 2017 14:54:19 +0530
> Abdul Haleem <abdhalee@linux.vnet.ibm.com> wrote:
> 
> > Hi,
> > 
> > linux-next build fails on BE config with next-20170424 onwards
> > 
> > the patch https://lkml.org/lkml/2017/4/20/994  fixes a similar issue
> > with kvm guest build failure.
> > 
> > arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> > arch/powerpc/kernel/exceptions-64s.S:395: Error: operand out of range
> > (0xffffffffffff8280 is not between 0x0000000000000000 and
> > 0x000000000000ffff)
> > make[1]: *** [arch/powerpc/kernel/head_64.o] Error 1
> > 
> > Bisection resulted with the below bad commit.
> > 
> > commit 1945bc4549e5cb1f9aa873ec29191aa54dc851d
> > Author: Nicholas Piggin <npiggin@gmail.com>
> > Date:   Wed Apr 19 23:05:47 2017 +1000
> > 
> >     powerpc/64s: Fix POWER9 machine check handler from stop state
> > 
> >     Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> >     Reviewed-by: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
> >     Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >     Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > 
> >  arch/powerpc/include/asm/reg.h       |  1 +
> >  arch/powerpc/kernel/exceptions-64s.S | 79 ++++++++++++++++++++++++++++++++++++++++++++-----------------------------------
> >  arch/powerpc/kernel/idle_book3s.S    | 25 +++++++++++++++++++++++++
> >  3 files changed, 70 insertions(+), 35 deletions(-)
> > 
> > the BE configuration file is attached.
> > 

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6102c005a71b4a7a6433d43b887662

cheers
