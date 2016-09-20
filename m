Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdbc33Lx6zDsff
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 18:32:51 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8K8RmH6016799
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 04:32:49 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25jpd2rsss-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 04:32:48 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 20 Sep 2016 02:32:48 -0600
Date: Tue, 20 Sep 2016 14:02:36 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Michael Neuling <mikey@neuling.org>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powernv:idle:Implement lite variant of
 power_enter_stop
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1474015799.git.ego@linux.vnet.ibm.com>
 <86d28da16d5bf66f111cc93eea3f000e41faff57.1474015799.git.ego@linux.vnet.ibm.com>
 <a7ad3c83-b6cd-0a20-5775-b7f41c5a6d23@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a7ad3c83-b6cd-0a20-5775-b7f41c5a6d23@gmail.com>
Message-Id: <20160920083236.GA22328@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Balbir,

On Tue, Sep 20, 2016 at 03:54:43PM +1000, Balbir Singh wrote:
> > diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> > index 479c256..c3d3fed 100644
> > --- a/arch/powerpc/platforms/powernv/idle.c
> > +++ b/arch/powerpc/platforms/powernv/idle.c
> > @@ -244,8 +244,15 @@ static DEVICE_ATTR(fastsleep_workaround_applyonce, 0600,
> >  static void power9_idle(void)
> >  {
> >  	/* Requesting stop state 0 */
> > -	power9_idle_stop(0);
> > +	power9_idle_stop(0, 0);
> >  }
> > +
> > +static void power9_idle_lite(void)
> > +{
> > +	/* Requesting stop state 0 with ESL=EC=0 */
> > +	power9_idle_stop(0, 1);
> > +}
> > +
> >  /*
> >   * First deep stop state. Used to figure out when to save/restore
> >   * hypervisor context.
> > @@ -414,8 +421,12 @@ static int __init pnv_init_idle_states(void)
> >  
> >  	if (supported_cpuidle_states & OPAL_PM_NAP_ENABLED)
> >  		ppc_md.power_save = power7_idle;
> > -	else if (supported_cpuidle_states & OPAL_PM_STOP_INST_FAST)
> > -		ppc_md.power_save = power9_idle;
> > +	else if (supported_cpuidle_states & OPAL_PM_STOP_INST_FAST) {
> > +		if (supported_cpuidle_states & OPAL_PM_WAKEUP_AT_NEXT_INST)
> > +			ppc_md.power_save = power9_idle_lite;
> > +		else
> > +			ppc_md.power_save = power9_idle;
> > +	}
> 
> If I am reading this correctly we decide at boot time whether we support
> wakeup at next instruction and make that the default sleep state.
> I am a little surprised that these are exclusive. I was expecting
> power9_idle_lite to be one of the states to go into before
> power9_idle

At boot time, we initialize ppc_md.power_save to
power9_idle/power9_idle_lite which ends up being the default idle
function in the absence of the cpuidle subsystem. When cpuidle is
available, idle code will call cpuidle governors which will determine
the appropriate idle state that can be entered into. Each of these
idle states has an associated callback function. In case of the
idle-states without OPAL_PM_STOP_INST_FAST associated with them, the
callback is stop_loop() and when the flag is set, the callback
function is stop_lite_loop().  So when cpuidle is present, these
states are not exclusive.

Note that both power9_idle() and power9_idle_lite() call stop0. Just
that the former executes stop0 with ESL=EC=1 and latter with ESL=EC=0.

That said, you're right that in the absence of the cpuidle governor,
if the lite variant of stop is advertised by the firmware through the
device-tree, we end up picking the liter version of stop0 as the
default idle state. Do you suggest that we retain power9_idle which
calls stop0 with ESL=EC=1 ? 

> Balbir Singh.
> 
--
Thanks and Regards
gautham.
