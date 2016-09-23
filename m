Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sgZTq5S08zDsmq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 23:49:18 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8NDmp8o138520
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 09:49:16 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25mqb7k7wr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 09:49:15 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 23 Sep 2016 07:49:14 -0600
Date: Fri, 23 Sep 2016 19:18:52 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Michael Neuling <mikey@neuling.org>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powernv:idle:Implement lite variant of
 power_enter_stop
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1474015799.git.ego@linux.vnet.ibm.com>
 <86d28da16d5bf66f111cc93eea3f000e41faff57.1474015799.git.ego@linux.vnet.ibm.com>
 <871t0a98tq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <871t0a98tq.fsf@concordia.ellerman.id.au>
Message-Id: <20160923134852.GA22259@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Fri, Sep 23, 2016 at 09:03:45PM +1000, Michael Ellerman wrote:
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
> 
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> >
> > This patch adds a function named power_enter_stop_lite() that can
> > execute a stop instruction when ESL and EC bits are set to zero in the
> > PSSCR.  The function handles the wake-up from idle at the instruction
> > immediately after the stop instruction.
> >
> > If the flag OPAL_PM_WAKEUP_AT_NEXT_INST[1] is set in the device tree
> > for a stop state, then use the lite variant for that particular stop
> > state.
> 
> Hi Gautham,
> 
> It seems to me that this would be cleaner if it was modelled as a new
> stop state? Surely it must have different power saving characteristics
> to the existing state?

It is supposed to be a new stop state, whose behaviour is different
from the existing stop states in terms of where it wakes up from stop.

You are right, it has different power saving characteristics to the
existing state.

> 
> > [1] : The corresponding patch in skiboot that defines
> >       OPAL_PM_WAKEUP_AT_NEXT_INST and enables it in the device tree
> >       can be found here:
> >       https://lists.ozlabs.org/pipermail/skiboot/2016-September/004805.html
> 
> Which says "This will reduce the exit latency of the idle state", and
> yet it doesn't change any of the latency/residency values?
> 
> If all it does is reduce the exit latency, then shouldn't we always use
> it? Presumably it also saves less power?

It does save less power compared to the corresponding variant where
ESL=EC=1.

> 
> > diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> > index 32d666b..47ee106 100644
> > --- a/arch/powerpc/kernel/idle_book3s.S
> > +++ b/arch/powerpc/kernel/idle_book3s.S
> > @@ -43,6 +43,8 @@
> >  #define PSSCR_HV_TEMPLATE	PSSCR_ESL | PSSCR_EC | \
> >  				PSSCR_PSLL_MASK | PSSCR_TR_MASK | \
> >  				PSSCR_MTL_MASK
> > +#define PSSCR_HV_TEMPLATE_LITE	PSSCR_PSLL_MASK | PSSCR_TR_MASK | \
> > +				 PSSCR_MTL_MASK
> 
> Why do we have these at all? Firmware tells us the PSSCR values to use
> in the "ibm,cpu-idle-state-psscr" property.
> 
> If we just used what firmware gave us then we wouldn't need the above,
> or the juggling below.

Let me rework the patch to use the cpu-idle-state-psscr property which
is currently set to 0 in the firmware and
cpu-idle-state-psscr-mask which is set to 0xF for all the stop
states.

I agree, we can do without the hardcoding of the mask in the
kernel.

> 
> > @@ -333,13 +349,19 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
> >  
> >  /*
> >   * r3 - requested stop state
> > + * r4 - Indicates if the lite variant with ESL=EC=0 should be executed.
> >   */
> >  _GLOBAL(power9_idle_stop)
> > -	LOAD_REG_IMMEDIATE(r4, PSSCR_HV_TEMPLATE)
> > -	or	r4,r4,r3
> > +	cmpdi	r4, 1
> > +	bne	4f
> > +	LOAD_REG_IMMEDIATE(r4, PSSCR_HV_TEMPLATE_LITE)
> > +	LOAD_REG_ADDR(r5,power_enter_stop_lite)
> > +	b 	5f
> > +4:	LOAD_REG_IMMEDIATE(r4, PSSCR_HV_TEMPLATE)
> > +	LOAD_REG_ADDR(r5,power_enter_stop)
> > +5:	or	r4,r4,r3
> >  	mtspr	SPRN_PSSCR, r4
> >  	li	r4, 1
> > -	LOAD_REG_ADDR(r5,power_enter_stop)
> >  	b	pnv_powersave_common
> >  	/* No return */
> >  /*
> 
> > diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> > index 479c256..c3d3fed 100644
> > --- a/arch/powerpc/platforms/powernv/idle.c
> > +++ b/arch/powerpc/platforms/powernv/idle.c
> > @@ -244,8 +244,15 @@ static DEVICE_ATTR(fastsleep_workaround_applyonce, 0600,
> >  static void power9_idle(void)
> >  {
> >  	/* Requesting stop state 0 */
> > -	power9_idle_stop(0);
> >  }
> 
> That seems like the root of the problem, why aren't we passing a PSSCR
> value here?
> 
> I also don't see us using the psscr-mask property anywhere. Why isn't
> that a bug?

Because we are only setting the Requested Level field which is the
bottom 4 bits. Everything else is taken from the hardcoded mask, which
is not incorrect, but not a very flexible design.

Thanks for the comments Michael. I will come back with a cleaner
patch.

> 
> cheers
> 

--
Thanks and Regards
gautham.
