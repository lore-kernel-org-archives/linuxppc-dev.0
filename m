Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdnsD3Ff9zDvjw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 18:15:12 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBE7E3OS059804
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 02:15:09 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27avy4huhu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 02:15:09 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 14 Dec 2016 00:15:08 -0700
Date: Wed, 14 Dec 2016 12:44:58 +0530
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
Subject: Re: [PATCH v4 2/4] cpuidle:powernv: Add helper function to populate
 powernv idle states.
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1481288905.git.ego@linux.vnet.ibm.com>
 <36f9cd2d944772d8e414a8240f9ec36eaec65ebd.1481288905.git.ego@linux.vnet.ibm.com>
 <d50fa1c4-9f48-c463-ddf8-293c23053b8f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d50fa1c4-9f48-c463-ddf8-293c23053b8f@gmail.com>
Message-Id: <20161214071458.GB26271@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Balbir,

On Tue, Dec 13, 2016 at 10:51:04PM +1100, Balbir Singh wrote:
> 
> 
> On 10/12/16 00:32, Gautham R. Shenoy wrote:
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > In the current code for powernv_add_idle_states, there is a lot of code
> > duplication while initializing an idle state in powernv_states table.
> > 
> > Add an inline helper function to populate the powernv_states[] table for
> > a given idle state. Invoke this for populating the "Nap", "Fastsleep"
> > and the stop states in powernv_add_idle_states.
> > 
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > ---
> >  drivers/cpuidle/cpuidle-powernv.c | 85 ++++++++++++++++++++++-----------------
> >  include/linux/cpuidle.h           |  1 +
> >  2 files changed, 50 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> > index 7fe442c..db18af1 100644
> > --- a/drivers/cpuidle/cpuidle-powernv.c
> > +++ b/drivers/cpuidle/cpuidle-powernv.c
> > @@ -167,6 +167,24 @@ static int powernv_cpuidle_driver_init(void)
> >  	return 0;
> >  }
> >  
> > +static inline void add_powernv_state(int index, const char *name,
> > +				     unsigned int flags,
> > +				     int (*idle_fn)(struct cpuidle_device *,
> > +						    struct cpuidle_driver *,
> > +						    int),
> > +				     unsigned int target_residency,
> > +				     unsigned int exit_latency,
> > +				     u64 psscr_val)
> > +{
> > +	strlcpy(powernv_states[index].name, name, CPUIDLE_NAME_LEN);
> > +	strlcpy(powernv_states[index].desc, name, CPUIDLE_NAME_LEN);
> 
> Do name and desc ever diverge?

On some other architectures, like kirkwood (see
drivers/cpuidle/cpuidle-kirkwood.c) they do. "desc" field is used to
provide a more descriptive information regarding the idle state.

On POWER, the names were self-explanatory. So, we have desc same as
the name.

> 
> > +	powernv_states[index].flags = flags;
> > +	powernv_states[index].target_residency = target_residency;
> > +	powernv_states[index].exit_latency = exit_latency;
> > +	powernv_states[index].enter = idle_fn;
> 
> Why not call it idle_fn instead of enter?

"enter" is a field name in the generic cpuidle_state structure and
powernv_states[] is an instance of that structure.

> 
> > +	stop_psscr_table[index] = psscr_val;
> > +}
> > +
> >  static int powernv_add_idle_states(void)
> >  {
> >  	struct device_node *power_mgt;
> > @@ -236,6 +254,7 @@ static int powernv_add_idle_states(void)
> >  		"ibm,cpu-idle-state-residency-ns", residency_ns, dt_idle_states);
> >  
> >  	for (i = 0; i < dt_idle_states; i++) {
> > +		unsigned int exit_latency, target_residency;
> >  		/*
> >  		 * If an idle state has exit latency beyond
> >  		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it
> > @@ -243,28 +262,33 @@ static int powernv_add_idle_states(void)
> >  		 */
> >  		if (latency_ns[i] > POWERNV_THRESHOLD_LATENCY_NS)
> 
> Ideally this should be called POWERNV_MAX_THRESHOLD_LATENCY_NS then

Yes, it can be called that. But then again, we're only interested in
the upper threshold in this code. I will add a comment near the macro
definition.

> 
> >  			continue;
> > +		/*
> > +		 * Firmware passes residency and latency values in ns.
> > +		 * cpuidle expects it in us.
> > +		 */
> > +		exit_latency = ((unsigned int)latency_ns[i]) / 1000;
> > +		if (!rc)
> > +			target_residency = residency_ns[i] / 1000;
> > +		else
> > +			target_residency = 0;
> 
> Where do we get rc from? what does target_residency = 0 mean?

The rc value comes from the
of_property_read_u32_array(power_mgt,
		"ibm,cpu-idle-state-residency-ns", residency_ns,
		dt_idle_states);

just before the for-loop. This tells us whether the firmware has
populated the residency information for the idle state or not.

rc != 0 indicates that the firmware has not populated the value.

Since the governor will pick the first idle state whose
target_residency matches the predicted residency, setting
target_residency = 0 implies that if any stop state is selected at
all, it is the earliest state.


> Balbir Singh
> 
