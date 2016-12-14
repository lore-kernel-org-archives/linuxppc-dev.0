Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdrFR2gj4zDw1W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 20:02:51 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBE8xTt1085851
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 04:02:48 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27b1ut3dp0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 04:02:48 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 14 Dec 2016 04:02:46 -0500
Date: Wed, 14 Dec 2016 14:32:38 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 3/4] powernv: Pass PSSCR value and mask to
 power9_idle_stop
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1481288905.git.ego@linux.vnet.ibm.com>
 <31b1024af69726cdf3cfb25413fc3dff28fa3547.1481288905.git.ego@linux.vnet.ibm.com>
 <b2b6c3c6-f564-6970-0281-dfddc739dda4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b2b6c3c6-f564-6970-0281-dfddc739dda4@gmail.com>
Message-Id: <20161214090238.GC26271@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Balbir,


Thanks for reviewing the patch. Please find my comments inline.

On Wed, Dec 14, 2016 at 11:16:26AM +1100, Balbir Singh wrote:
[..snip..]
> >  
> >  /*
> > - * r3 - requested stop state
> > + * r3 - PSSCR value corresponding to the requested stop state.
> >   */
> >  power_enter_stop:
> >  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> > @@ -274,9 +272,19 @@ power_enter_stop:
> >  	stb	r4,HSTATE_HWTHREAD_STATE(r13)
> >  #endif
> >  /*
> > + * Check if we are executing the lite variant with ESL=EC=0
> > + */
> > +	andis.   r4, r3, PSSCR_EC_ESL_MASK_SHIFTED
> 
> r4 = psscr & (PSSCR_EC | PSSCR_ESL)
> 
> > +	andi.    r3, r3, PSSCR_RL_MASK   /* r3 = requested stop state */
> 
> r3 = psscr & RL_MASK (requested mask). 
> 
> Why do we do and andis. followed by andi. and a compdi below?

Do you mean why are we not using the CR0 value instead of using cmpdi
again ? Hmm.. The subsequent code expect r3 to contain only the RL
value. So, how about the following?

andi.  r4, r3, PSSCR_RL_MASK;
andis. r3, r3, PSSCR_EC_ESL_MASK_SHIFTED;
mr     r3, r4;
bne    1f;

> 
> > +	cmpdi	 r4, 0
> 
> r4 == 0 implies we either both PSSCR_EC|ESL are cleared.

> I am not sure if our checks for EC are well defined/implemented.
> Should we worry about EC at all at this point?

Yes, we need to check the value of EC. Because if EC == 0, that
implies that the hardware will wake up from the stop instruction at
the subsequent instruction which we need to handle. This behaviour is
only available from POWER9 onwards, since on POWER8, the wakeup from
nap,sleep and winkle were always at 0x100. Hence the existing code
assumes that all the wakeups are at 0x100, which is what this patch
modifies.


> 
> > +	bne	 1f
> > +	IDLE_STATE_ENTER_SEQ(PPC_STOP)
> > +	li	r3,0  /* Since we didn't lose state, return 0 */
> > +	b 	pnv_wakeup_noloss
> > +/*
> >   * Check if the requested state is a deep idle state.
> >   */
> > -	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
> > +1:	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
> >  	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
> >  	cmpd	r3,r4
> >  	bge	2f
> > @@ -353,16 +361,17 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
> >  	ld	r3,ORIG_GPR3(r1);	/* Restore original r3 */	\
> >  20:	nop;
> >  
> > -
> 
> Spurious change?

There were two empty lines for no particular reason. So got rid of one
of them.

> 
> >  /*
> > - * r3 - requested stop state
> > + * r3 - The PSSCR value corresponding to the stop state.
> > + * r4 - The PSSCR mask corrresonding to the stop state.
> >   */
> >  _GLOBAL(power9_idle_stop)
> > -	LOAD_REG_IMMEDIATE(r4, PSSCR_HV_TEMPLATE)
> > -	or	r4,r4,r3
> > -	mtspr	SPRN_PSSCR, r4
> > -	li	r4, 1
> > +	mfspr   r5, SPRN_PSSCR
> > +	andc    r5, r5, r4
> > +	or      r3, r3, r5
> > +	mtspr 	SPRN_PSSCR, r3
> >  	LOAD_REG_ADDR(r5,power_enter_stop)
> > +	li	r4, 1
> >  	b	pnv_powersave_common
> >  	/* No return */
> >  /*

[..snip..]

> > @@ -253,9 +259,11 @@ static void power9_idle(void)
> >  u64 pnv_first_deep_stop_state = MAX_STOP_STATE;
> >  
> >  /*
> > - * Deepest stop idle state. Used when a cpu is offlined
> > + * psscr value and mask of the deepest stop idle state.
> > + * Used when a cpu is offlined.
> >   */
> > -u64 pnv_deepest_stop_state;
> > +u64 pnv_deepest_stop_psscr_val;
> > +u64 pnv_deepest_stop_psscr_mask;
> >  
> >  /*
> >   * Power ISA 3.0 idle initialization.
> > @@ -302,28 +310,58 @@ static int __init pnv_arch300_idle_init(struct device_node *np, u32 *flags,
> >  					int dt_idle_states)
> 
> In some cases we say power9 and arch300 in others, not related to
> >  this patchset, but just a generic comment

Will see if I can make this consistent.


[..snip..]

> > @@ -333,12 +371,27 @@ static int __init pnv_arch300_idle_init(struct device_node *np, u32 *flags,
> >  		     (pnv_first_deep_stop_state > psscr_rl))
> >  			pnv_first_deep_stop_state = psscr_rl;
> >  
> > -		if (pnv_deepest_stop_state < psscr_rl)
> > -			pnv_deepest_stop_state = psscr_rl;
> > -	}
> > +		if (max_residency_ns < residency_ns[i]) {
> > +			max_residency_ns = residency_ns[i];
> > +			pnv_deepest_stop_psscr_val =
> > +				compute_psscr_val(psscr_val[i], psscr_mask[i]);
> > +			pnv_deepest_stop_psscr_mask =
> > +				compute_psscr_mask(psscr_mask[i]);
> > +		}
> >  
> 
> Does it make sense to have them sorted and then use the last value
> from the array?

Yes, if the firmware can be relied upon to do this, we can obtain the
deepest_stop_psscr_val and the mask in constant time.

However, this init function is called only once during the boot, and
we are anyway iterating over all the idle states to find the first
deep stop state and the default stop state. So the optimization for
deepest_stop_psscr_val and mask may not gain us much.

> 
> 
> Balbir Singh
> 

--
Thanks and Regards
gautham.
