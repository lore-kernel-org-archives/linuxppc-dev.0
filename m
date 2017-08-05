Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xPzmF0xsCzDqHq
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Aug 2017 09:00:44 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v75MxHX2107816
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 5 Aug 2017 19:00:42 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c5860gkym-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Aug 2017 19:00:42 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Sun, 6 Aug 2017 09:00:35 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v75N0XmS29229110
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 6 Aug 2017 09:00:33 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v75N0OMC031071
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 6 Aug 2017 09:00:24 +1000
Subject: Re: [PATCH 08/13] powerpc/64s: irq replay remove spurious irq reason
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Sun, 06 Aug 2017 09:00:32 +1000
In-Reply-To: <20170805170241.22966-9-npiggin@gmail.com>
References: <20170805170241.22966-1-npiggin@gmail.com>
 <20170805170241.22966-9-npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1501974032.2664.135.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-08-06 at 03:02 +1000, Nicholas Piggin wrote:
> HVI interrupts have always used 0x500, so remove the dead branch.

Maybe we should fix that and "catch" in incorrect entry via 0x500
which would mean the XIVE is trying to deliver guest irqs to the OS...

That can happen if some LPCR bits aren't set properly and/or KVM
doesn't pull the guest in time. I had bugs like that in my early
dev so I've been running with a b . at 0x500 for a while :-)

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/exceptions-64s.S | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 29253cecf713..566cf126c13b 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1680,8 +1680,6 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_300)
>  BEGIN_FTR_SECTION
>  	cmpwi	r3,0xa00
>  	beq	h_doorbell_common_msgclr
> -	cmpwi	r3,0xea0
> -	beq	h_virt_irq_common
>  	cmpwi	r3,0xe60
>  	beq	hmi_exception_common
>  FTR_SECTION_ELSE
