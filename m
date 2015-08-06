Return-Path: <pebolle@tiscali.nl>
Received: from lb1-smtp-cloud6.xs4all.net (lb1-smtp-cloud6.xs4all.net
 [194.109.24.24])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 286CB1A088A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 08:21:57 +1000 (AEST)
Message-ID: <1438899707.25241.29.camel@tiscali.nl>
Subject: Re: windfarm: decrement client count when unregistering
From: Paul Bolle <pebolle@tiscali.nl>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Fri, 07 Aug 2015 00:21:47 +0200
In-Reply-To: <20150805041611.ACBD6140324@ozlabs.org>
References: <20150805041611.ACBD6140324@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On wo, 2015-08-05 at 14:16 +1000, Michael Ellerman wrote:
> On Fri, 2015-31-07 at 12:08:58 UTC, Paul Bolle wrote:
> > windfarm_corex_exit() contains:
> >     BUG_ON(wf_client_count != 0);
> > 
> > I wonder why that, apparently. never triggered.
> 
> Hmm interesting.
> 
> A quick test here on an iMacG5 shows that we get into a state where we can't
> remove windfarm_core:
> 
>   $ lsmod
>   Module                  Size  Used by
>   windfarm_smu_sensors    7549  2
>   windfarm_core          15391  1 windfarm_smu_sensors
> 
> 
> Which means we can't trigger windfarm_core_exit() and the BUG_ON().

Perhaps this is what, roughly, happens:

smu_sensors_init()
    smu_ads_create()
        /* Let's assume this happens ... */
        ads->sens.ops = &smu_cpuamp_ops
        ads->sens.name = "cpu-current"
    smu_ads_create()
        /* ditto ... */
        ads->sens.ops = &smu_cpuvolt_ops
        ads->sens.name = "cpu-voltage"

    /* ... so this would then be true */
    if (volt_sensor && curr_sensor)
        /* and we do this */
        smu_cpu_power_create(&volt_sensor->sens, &curr_sensor->sens)
            wf_get_sensor(&volt_sensor->sens)
                try_module_get(volt_sensor->sens->ops->owner /* THIS_MODULE */)
            wf_get_sensor(&curr_sensor->sens)
                try_module_get(curr_sensor->sens->ops->owner /* THIS_MODULE */)

The cleanup would have happened here:

smu_sensors_exit()
    while (!list_empty(&smu_ads)
        wf_unregister_sensor(&ads->sens)
            wf_put_sensor()
                /* would this also be done for sensors that never 
                 * triggered a call to module_get()? */
                module_put(ads->sens->ops->owner /* THIS MODULE */)

But, whatever it is that smu_sensors_exit() wants to do, it will never
be called since there are these two references to this module that
smu_sensors_init() created itself, preventing the unloading of this
module.

Does the above look plausible?

Note that this was only cobbled together by staring at the code for far
too long. If I had some powerpc machine at hand I could have actually
tested this with a few strategically placed printk()'s.

> I also get an oops when removing windfarm_lm75_sensor, so I suspect there are
> gremlins in the module ref counting for windfarm.

(This I haven't (yet) looked into.)

> I'll merge this as probably correct.

Hope this helps,


Paul Bolle
