Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wK2Md6t9wzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 16:40:29 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id u187so1179400pgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 23:40:29 -0700 (PDT)
Date: Fri, 5 May 2017 16:40:12 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>, ego <ego@linux.vnet.ibm.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, mahesh@linux.vnet.ibm.com, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [linux-next][bisected 1945bc45] build brakes for PowerPC BE
 configuration on LPAR
Message-ID: <20170505164012.5f228dc1@roar.ozlabs.ibm.com>
In-Reply-To: <1493957410.7355.29.camel@abdul.in.ibm.com>
References: <1493889859.7355.17.camel@abdul.in.ibm.com>
 <20170504204112.130d7735@roar.ozlabs.ibm.com>
 <1493957410.7355.29.camel@abdul.in.ibm.com>
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

On Fri, 05 May 2017 09:40:10 +0530
Abdul Haleem <abdhalee@linux.vnet.ibm.com> wrote:

> On Thu, 2017-05-04 at 20:41 +1000, Nicholas Piggin wrote:
> > On Thu, 04 May 2017 14:54:19 +0530
> > Abdul Haleem <abdhalee@linux.vnet.ibm.com> wrote:
> >   
> > > Hi,
> > > 
> > > linux-next build fails on BE config with next-20170424 onwards
> > > 
> > > the patch https://lkml.org/lkml/2017/4/20/994  fixes a similar issue
> > > with kvm guest build failure.
> > > 
> > > arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> > > arch/powerpc/kernel/exceptions-64s.S:395: Error: operand out of range
> > > (0xffffffffffff8280 is not between 0x0000000000000000 and
> > > 0x000000000000ffff)
> > > make[1]: *** [arch/powerpc/kernel/head_64.o] Error 1
> > > 
> > > Bisection resulted with the below bad commit.
> > > 
> > > commit 1945bc4549e5cb1f9aa873ec29191aa54dc851d
> > > Author: Nicholas Piggin <npiggin@gmail.com>
> > > Date:   Wed Apr 19 23:05:47 2017 +1000
> > > 
> > >     powerpc/64s: Fix POWER9 machine check handler from stop state
> > > 
> > >     Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > >     Reviewed-by: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
> > >     Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > >     Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > > 
> > >  arch/powerpc/include/asm/reg.h       |  1 +
> > >  arch/powerpc/kernel/exceptions-64s.S | 79 ++++++++++++++++++++++++++++++++++++++++++++-----------------------------------
> > >  arch/powerpc/kernel/idle_book3s.S    | 25 +++++++++++++++++++++++++
> > >  3 files changed, 70 insertions(+), 35 deletions(-)
> > > 
> > > the BE configuration file is attached.
> > >   
> > 
> > Thanks for the report. I wouldn't reproduce it with this config. I
> > suspect the following patch should fix it, can you test?
> > 
> > powerpc/64s: Fix unnecessary machine check handler relocation branch
> > 
> > Similarly to 2563a70c3b ("powerpc/64s: Remove unnecessary relocation
> > branch from idle handler"), the machine check handler has a BRANCH_TO
> > from relocated to relocated code, which is unnecessary.
> > 
> > It has also caused build errors with some toolchains:
> > 
> >   arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> >   arch/powerpc/kernel/exceptions-64s.S:395: Error: operand out of range
> >   (0xffffffffffff8280 is not between 0x0000000000000000 and
> >   0x000000000000ffff)
> > 
> > Fixes: 1945bc4549 ("powerpc/64s: Fix POWER9 machine check handler from stop state")
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/kernel/exceptions-64s.S | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> > index 3840a7700285..ef72065f684c 100644
> > --- a/arch/powerpc/kernel/exceptions-64s.S
> > +++ b/arch/powerpc/kernel/exceptions-64s.S
> > @@ -391,9 +391,7 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
> >  	 */
> >  	BEGIN_FTR_SECTION
> >  	rlwinm.	r11,r12,47-31,30,31
> > -	beq-	4f
> > -	BRANCH_TO_COMMON(r10, machine_check_idle_common)
> > -4:
> > +	bne	machine_check_idle_common
> >  	END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
> >  #endif
> >   
> 
> Machine Builds and boots fine, Thanks for the patch :-)
> 
> Reported-and-tested-by : Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> 

Okay, thanks for testing. I've tested the MCE-from-idle wakeup path in
the simulator with this patch and that still seems to work fine.

Thanks,
Nick
