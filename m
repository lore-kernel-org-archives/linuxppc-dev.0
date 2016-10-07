Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sr1CX48DlzDrSJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Oct 2016 18:21:12 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u977JOmu090441
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Oct 2016 03:21:09 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25x57ucugb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Oct 2016 03:21:09 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 7 Oct 2016 01:21:08 -0600
Date: Fri, 7 Oct 2016 12:50:58 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 "skiboot@lists.ozlabs.org" <skiboot@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] powernv: Pass PSSCR value and mask to power9_idle_stop
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1475130107.git.ego@linux.vnet.ibm.com>
 <21e080ffa52f432b40750028a624aee1baebbaf7.1475130107.git.ego@linux.vnet.ibm.com>
 <87int84d6w.fsf@concordia.ellerman.id.au>
 <0e7ad8ff-8c44-86bc-f560-258bc7b29a32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0e7ad8ff-8c44-86bc-f560-258bc7b29a32@gmail.com>
Message-Id: <20161007072058.GC13873@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Balbir, Michael,

On Tue, Oct 04, 2016 at 10:33:27PM +1100, Balbir Singh wrote:
> 
> 
> On 04/10/16 21:32, Michael Ellerman wrote:
> > "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
> > 
> >> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> >>
> >> The power9_idle_stop method currently takes only the requested stop
> >> level as a parameter and picks up the rest of the PSSCR bits from a
> >> hand-coded macro. This is not a very flexible design, especially when
> >> the firmware has the capability to communicate the psscr value and the
> >> mask associated with a particular stop state via device tree.
> >>
> >> This patch modifies the power9_idle_stop API to take as parameters the
> >> PSSCR value and the PSSCR mask corresponding to the stop state that
> >> needs to be set. These PSSCR value and mask are respectively obtained
> >> by parsing the "ibm,cpu-idle-state-psscr" and
> >> "ibm,cpu-idle-state-psscr-mask" fields from the device tree.
> >>
> >> In addition to this, the patch adds support for handling stop states
> >> for which ESL and EC bits in the PSSCR are zero. As per the
> >> architecture, a wakeup from these stop states resumes execution from
> >> the subsequent instruction as opposed to waking up at the System
> >> Vector.
> > 
> > That looks good.
> > 
> >> This patch depends on the following skiboot patch that exports the
> >> PSSCR values and the mask for all the stop states:
> >> https://lists.ozlabs.org/pipermail/skiboot/2016-September/004869.html
> > 
> > But we can't depend on a skiboot patch. The kernel has to cope with
> > running on an old skiboot.
>

Hmm.. We can still do that. The older skiboot only provides the RL
field of the PSSCR value for each stop state and the corresponding
PSSCR mask is set to 0xF in the older skiboot for all the stop states.

We can insist that the future skiboot sets the ESL, EC, PSLL, TR, MTL
and the the RL fields of the PSSCR for any exported stop state. This
should be reflected in the psscr_mask of that stop state.  Thus, the
psscr_mask of any stop state proposed in the future will have:
(PSSCR_ESL_MASK | PSCCR_EC_MASK | PSCCR_PSLL_MASK | PSSCR_TR_MASK |
PSSCR_MTL_MASK | PSSCR_RL_MASK) bits set in the skiboot.

To handle the older firmware, we can do something like the following
during the discovery of the stop states to mimic the behaviour present
in the 4.8 kernel running on older firmware.

=============== drivers/cpuidle/cpuidle-powernv.c =======================
/*
 * By default we set the ESL and EC bits in the PSSCR.
 * The MTL and PSLL are set to the maximum value possible as per the
 * ISA, i.e 15.
 * The Transition Rate is set to the Maximum value 3.
 */
#define DEFAULT_PSSCR_VAL      PSSCR_ESL_MASK |			\
			       PSCCR_EC_MASK | PSCCR_PSLL_MASK |\
			       PSSCR_TR_MASK | PSSCR_MTL_MASK

#define DEFAULT_PSSCR_MASK     PSSCR_ESL_MASK |			\
			       PSCCR_EC_MASK | PSCCR_PSLL_MASK |\
			       PSSCR_TR_MASK | PSSCR_MTL_MASK | \
			       PSSCR_RL_MASK


static int powernv_add_idle_states(void)
{
	.
	.
	.
	for (i = 0; i < dt_idle_states; i++) {
	    u64 val, mask;
	    	.	    
		.
		.
		val = (DEFAULT_PSSCR_VAL & ~psscr_mask[i]) | psscr_val[i];
		mask = DEFAULT_PSSCR_MASK | psscr_mask[i];
		stop_psscr_table[nr_idle_states].val = val;
        	stop_psscr_table[nr_idle_states].mask = mask;
	}
}		
============================================================================


Is this approach ok ?


> Hi, Michael
> 
> I think with an older skiboot the flags don't get exported and the
> new cpuidle (stop state) does not get discovered. I don't think there
> is any breakage. Gautham am I missing something?

In the second verison of the patch, I am not adding any new flags in
the skiboot, but explicitly providing the psscr_value and psscr_mask
for each stop state.  Thus if you see the v2 of the skiboot patch, the
lite versions of stop0,stop1 and stop2 are defined with no additional
flags.

The second version of the kernel patch wouldn't then work with the
older skiboot since the older skiboot exports only the RL field of the
psscr_val while the new kernel patch expects all the relavant bits of
the psscr_val be set. This would result in a breakage.


> 
> Balbir Singh.
> 

--
Thanks and Regards
gautham.
