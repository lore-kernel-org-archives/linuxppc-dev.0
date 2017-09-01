Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkFP25hQWzDqgB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 20:10:30 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v81A9K2A007517
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Sep 2017 06:10:28 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cq2x4gt5a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Sep 2017 06:10:24 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Fri, 1 Sep 2017 20:10:21 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v81A94c843385066
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Sep 2017 20:09:04 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v81A93fQ017583
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Sep 2017 20:09:03 +1000
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/powernv: Clear LPCR[PECE1] via stop-api only for
 deep state offline
References: <1504180061-32345-1-git-send-email-ego@linux.vnet.ibm.com> <>
Cc: linux-kernel@vger.kernel.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Pavithra Prakash <pavirampu@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Date: Fri, 1 Sep 2017 15:38:59 +0530
MIME-Version: 1.0
In-Reply-To: <>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e75eda1b-c6ae-fe74-d45c-2c98e366be2a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 08/31/2017 05:37 PM, Nicholas Piggin wrote:
> On Thu, 31 Aug 2017 17:17:41 +0530
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:
>
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> >
> > commit 24be85a23d1f ("powerpc/powernv: Clear PECE1 in LPCR via
> > stop-api only on Hotplug") clears the PECE1 bit of the LPCR via
> > stop-api during CPU-Hotplug to prevent wakeup due to a decrementer on
> > an offlined CPU which is in a deep stop state.
> >
> > In the case where the stop-api support is found to be lacking, the
> > commit 785a12afdb4a ("powerpc/powernv/idle: Disable LOSE_FULL_CONTEXT
> > states when stop-api fails") disables deep states that lose hypervisor
> > context. Thus in this case, the offlined CPU will be put to some
> > shallow idle state.
> >
> > However, we currently unconditionally clear the PECE1 in LPCR via
> > stop-api during CPU-Hotplug even when deep states are disabled due to
> > stop-api failure.
> >
> > Fix this by clearing PECE1 of LPCR via stop-api during CPU-Hotplug
> > *only* when the offlined CPU will be put to a deep state that loses
> > hypervisor context.
>
> This looks okay to me. The bug is due to calling opal_slw_set_reg when
> firmware has not enabled that feature, right?
Yes,

In the case where the stop-api support is found to be lacking, the 
commit 785a12afdb4a ("powerpc/powernv/idle: Disable LOSE_FULL_CONTEXT 
states when stop-api fails") disables deep states that lose hypervisor 
context. Thus in this case, the offlined CPU will be put to some shallow 
idle state.

If a shallow state ( < stop4 ) is being chosen for cpu hotplug, then :
1) this opal call is not required.
2) may not be supported.

Hence  should call opal_slw_set_reg() only if a deep state chosen for 
cpu hotplug.
>
> >
> > Fixes: commit 24be85a23d1f ("powerpc/powernv: Clear PECE1 in LPCR via
> > stop-api only on Hotplug")
> >
> > Reported-by: Pavithra Prakash <pavirampu@linux.vnet.ibm.com>
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/platforms/powernv/idle.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/platforms/powernv/idle.c
> b/arch/powerpc/platforms/powernv/idle.c
> > index 9f59041..23f8fba 100644
> > --- a/arch/powerpc/platforms/powernv/idle.c
> > +++ b/arch/powerpc/platforms/powernv/idle.c
> > @@ -393,7 +393,13 @@ static void
> pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val)
> >      u64 pir = get_hard_smp_processor_id(cpu);
> >
> >      mtspr(SPRN_LPCR, lpcr_val);
> > -    opal_slw_set_reg(pir, SPRN_LPCR, lpcr_val);
> > +
> > +    /*
> > +     * Program the LPCR via stop-api only for deepest stop state
> > +     * can lose hypervisor context.
> > +     */
> > +    if (supported_cpuidle_states & OPAL_PM_LOSE_FULL_CONTEXT)
> > +        opal_slw_set_reg(pir, SPRN_LPCR, lpcr_val);
> >  }
> >
> >  /*
>
