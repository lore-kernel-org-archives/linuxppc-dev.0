Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wszpd22xzzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 19:25:45 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5L9OELI085874
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 05:25:42 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b7kukq2xs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 05:25:42 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Wed, 21 Jun 2017 19:25:39 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5L9Pb1P5570892
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 19:25:37 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5L9Paos002222
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 19:25:37 +1000
Subject: Re: [PATCH] powerpc/64: Initialise thread_info for emergency stacks
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, Stephen
 Rothwell <sfr@canb.auug.org.au>
Date: Wed, 21 Jun 2017 14:55:29 +0530
In-Reply-To: <20170620135801.13272-1-npiggin@gmail.com>
References: <20170620135801.13272-1-npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1498037129.30044.5.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-06-20 at 23:58 +1000, Nicholas Piggin wrote:
> Emergency stacks have their thread_info mostly uninitialised, which in
> particular means garbage preempt_count values.
> 
> Emergency stack code runs with interrupts disabled entirely, and is
> used very rarely, so this has been unnoticed so far. It was found by a
> proposed new powerpc watchdog that takes a soft-NMI directly from the
> masked_interrupt handler and using the emergency stack. That crashed at
> BUG_ON(in_nmi()) in nmi_enter(). preempt_count()s were found to be
> garbage.
> 
> Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> 
> FYI, this bug looks to be breaking linux-next on some powerpc
> boxes due to interaction with a proposed new powerpc watchdog
> driver Andrew has in his tree:
> 
> http://marc.info/?l=linuxppc-embedded&m=149794320519941&w=2
> 
>  arch/powerpc/include/asm/thread_info.h | 19 +++++++++++++++++++
>  arch/powerpc/kernel/setup_64.c         |  6 +++---
>  2 files changed, 22 insertions(+), 3 deletions(-)

Hi Nicholas,

Thanks for the patch, Verified on next-20170621 and PowerPC bare-metal
boots fine with your patch

Tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>

Thanks for all your support.

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
