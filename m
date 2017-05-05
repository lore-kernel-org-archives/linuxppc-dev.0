Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJz4P3lH8zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 14:12:05 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4548l58062604
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 May 2017 00:11:52 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a8d27thb9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 May 2017 00:11:52 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Fri, 5 May 2017 14:11:12 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v454B2W651773584
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 May 2017 14:11:10 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v454AVNm000653
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 May 2017 14:10:32 +1000
Subject: Re: [linux-next][bisected 1945bc45] build brakes for PowerPC BE
 configuration on LPAR
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>, ego <ego@linux.vnet.ibm.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, mahesh@linux.vnet.ibm.com, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 05 May 2017 09:40:10 +0530
In-Reply-To: <20170504204112.130d7735@roar.ozlabs.ibm.com>
References: <1493889859.7355.17.camel@abdul.in.ibm.com>
 <20170504204112.130d7735@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1493957410.7355.29.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-05-04 at 20:41 +1000, Nicholas Piggin wrote:
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
> 
> Thanks for the report. I wouldn't reproduce it with this config. I
> suspect the following patch should fix it, can you test?
> 
> powerpc/64s: Fix unnecessary machine check handler relocation branch
> 
> Similarly to 2563a70c3b ("powerpc/64s: Remove unnecessary relocation
> branch from idle handler"), the machine check handler has a BRANCH_TO
> from relocated to relocated code, which is unnecessary.
> 
> It has also caused build errors with some toolchains:
> 
>   arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
>   arch/powerpc/kernel/exceptions-64s.S:395: Error: operand out of range
>   (0xffffffffffff8280 is not between 0x0000000000000000 and
>   0x000000000000ffff)
> 
> Fixes: 1945bc4549 ("powerpc/64s: Fix POWER9 machine check handler from stop state")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/exceptions-64s.S | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 3840a7700285..ef72065f684c 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -391,9 +391,7 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
>  	 */
>  	BEGIN_FTR_SECTION
>  	rlwinm.	r11,r12,47-31,30,31
> -	beq-	4f
> -	BRANCH_TO_COMMON(r10, machine_check_idle_common)
> -4:
> +	bne	machine_check_idle_common
>  	END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
>  #endif
> 

Machine Builds and boots fine, Thanks for the patch :-)

Reported-and-tested-by : Abdul Haleem <abdhalee@linux.vnet.ibm.com>

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
