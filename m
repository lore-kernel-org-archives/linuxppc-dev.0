Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfkDF5MykzDqXx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 21:35:09 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2AAYNCc130325
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 05:35:02 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 293f4ugvr7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 05:35:02 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 10 Mar 2017 05:35:01 -0500
Date: Fri, 10 Mar 2017 16:04:57 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Gautham R Shenoy <ego.lkml@gmail.com>, ego@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/5] powerpc/64s: fix POWER9 machine check handler from
 stop state
Reply-To: ego@linux.vnet.ibm.com
References: <20170216183901.28611-1-npiggin@gmail.com>
 <20170216183901.28611-6-npiggin@gmail.com>
 <CAHZ_5WxicD=W6wqVdtEVRrewCgszO-S5mmdsiGWPm4wvUCOE-A@mail.gmail.com>
 <20170308221919.732986fd@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170308221919.732986fd@roar.ozlabs.ibm.com>
Message-Id: <20170310103457.GA10714@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 08, 2017 at 10:19:19PM +1000, Nicholas Piggin wrote:
> Hi Gautham,
> 
> I'm just getting back to this. Sorry for the late reply, and
> thanks for the reviews.

No problems.

> 
[..snip..]
> > > +#ifdef CONFIG_PPC_P7_NAP
> > > +EXC_COMMON_BEGIN(machine_check_idle_common)
> > > +       bl      machine_check_queue_event
> > > +       /*
> > > +        * Queue the machine check, then reload SRR1 and use it to set
> > > +        * CR3 according to pnv_powersave_wakeup convention.
> > > +        */
> > > +       ld      r12,_MSR(r1)
> > > +       rlwinm  r11,r12,47-31,30,31
> > > +       cmpwi   cr3,r11,2
> > > +
> > > +       /*
> > > +        * Now have to make SRR1 wake up reason look like a system reset
> > > +        * interrupt. Put 0xf in there, which is reserved (and does not
> > > +        * match HMI).  
> > 
> > The only places where the wakeup reason is presently checked on the way out
> > of idle-exit are in KVM guest entry path in kvmppc_check_wake_reason()
> >  and on the CPU-Hotplug exit path pnv_smp_cpu_kill_self(). In both places
> > we do a positive check for EE, Doorbell, HVEE . The kvm case is also
> > interested in
> > HMI. We ignore all the other reasons at the moment.
> > 
> > So this should be fine.
> 
> Okay, thanks for confirming. We will have to be careful about this I
> suppose if the wakeup reasons are expanded. I'll make a note of it
> in asm/reg.h with the WAKEMASK definitions.

Sounds reasonable.

> 
> > > +        */
> > > +       li      r11,0xf
> > > +       insrdi  r12,r11,4,45  
> > 
> > 
> > Shouldn't this be insrdi r12,r11,4,42? The exception bits are 42:45.
> > I always have trouble wrapping my head around these nifty
> > rotate-shift-mask-insert instructions. So I might as well be wrong!
> 
> Ah I think you're right, good catch. Maybe oris r12,r12,0x3c is a better
> choice than that insrdi?

Perhaps oris is a better choice in this case since we are anyway
setting every bit in 42:45 range. Not sure if it will save any cycles,
but it will certainly reduce an instruction!

> 
> 
> > 
> > Otherwise, the patch looks correct to me.
> > Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> 
> Very much appreciate the reviews. I'm just getting some time to work on
> the winkle count patch, so I'll repost with your suggestions when that's
> done.
>

Looking forward to the new version!


> Thanks,
> Nick
> 
--
Thanks and Regards
gautham.
