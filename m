Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 56E6D1A00F6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 21:21:56 +1100 (AEDT)
In-Reply-To: <1426999379-20542-3-git-send-email-shreyas@linux.vnet.ibm.com>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v3, 3/3] powerpc/powernv: Introduce sysfs control for fastsleep
 workaround behavior
Message-Id: <20150330102156.43CD1140161@ozlabs.org>
Date: Mon, 30 Mar 2015 21:21:56 +1100 (AEDT)
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-22-03 at 04:42:59 UTC, "Shreyas B. Prabhu" wrote:
> Fastsleep is one of the idle state which cpuidle subsystem currently
> uses on power8 machines. In this state L2 cache is brought down to a
> threshold voltage. Therefore when the core is in fastsleep, the
> communication between L2 and L3 needs to be fenced. But there is a bug
> in the current power8 chips surrounding this fencing.
> 
> OPAL provides a workaround which precludes the possibility of hitting
> this bug. But running with this workaround applied causes checkstop
> if any correctable error in L2 cache directory is detected. Hence OPAL
> also provides a way to undo the workaround.
> 
> In the existing implementation, workaround is applied by the last thread
> of the core entering fastsleep and undone by the first thread waking up.
> But this has a performance cost. These OPAL calls account for roughly
> 4000 cycles everytime the core has to enter or wakeup from fastsleep.
> 
> This patch introduces a sysfs attribute (fastsleep_workaround_state)
> to choose the behavior of this workaround.
> 
> By default, fastsleep_workaround_state = 0. In this case, workaround
> is applied/undone everytime the core enters/exits fastsleep.
> 
> fastsleep_workaround_state = 1. In this case the workaround is applied
> once on all the cores and never undone. This can be triggered by
> echo 1 > /sys/devices/system/cpu/fastsleep_workaround_state
> 
> For simplicity this attribute can be modified only once. Implying, once
> fastsleep_workaround_state is changed to 1, it cannot be reverted to
> the default state.

This sounds good, although the name is a bit vague.

Just calling it "state" doesn't make it clear what 0 and 1 mean.
I think better would be "fastsleep_workaround_active" ?

Though even that is a bit wrong, because 0 doesn't really mean it's not active,
it means it's not *permanently* active.

So another option would be to make it a string attribute, with the initial
state being eg. "dynamic" and then maybe "applied" for the applied state?

I won't say you have to do that, but think about it, seeing as I'm going to ask
for a v4 anyway (see comments below).

> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 9ee0a30..8bea8fc 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -180,6 +180,13 @@ struct opal_sg_list {
>  #define OPAL_PM_WINKLE_ENABLED	0x00040000
>  #define OPAL_PM_SLEEP_ENABLED_ER1	0x00080000
>  
> +/*
> + * OPAL_CONFIG_CPU_IDLE_STATE parameters
> + */
> +#define OPAL_CONFIG_IDLE_FASTSLEEP	1
> +#define OPAL_CONFIG_IDLE_UNDO		0
> +#define OPAL_CONFIG_IDLE_APPLY		1

The OPAL defines have moved to opal-api.h in Linux.

They should also be made #defines in skiboot.

> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 77992f6..79157b9 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -13,6 +13,8 @@
>  #include <linux/mm.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> +#include <linux/device.h>
> +#include <linux/cpu.h>
>  
>  #include <asm/firmware.h>
>  #include <asm/opal.h>
> @@ -136,6 +138,77 @@ u32 pnv_get_supported_cpuidle_states(void)
>  }
>  EXPORT_SYMBOL_GPL(pnv_get_supported_cpuidle_states);
>  
> +static void pnv_fastsleep_workaround_apply(void *info)
> +{
> +	opal_config_cpu_idle_state(OPAL_CONFIG_IDLE_FASTSLEEP,
> +					OPAL_CONFIG_IDLE_APPLY);

This can fail, please check the return. You'll need to report the result via
*info.

> +}
> +
> +/*
> + * Used to store fastsleep workaround state
> + * 0 - Workaround applied/undone at fastsleep entry/exit path (Default)
> + * 1 - Workaround applied once, never undone.
> + */
> +static u8 fastsleep_workaround_state;
> +
> +static ssize_t show_fastsleep_workaround_state(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%u\n", fastsleep_workaround_state);
> +}
> +
> +static ssize_t store_fastsleep_workaround_state(struct device *dev,
> +		struct device_attribute *attr, const char *buf,
> +		size_t count)
> +{
> +	u32 val;
> +	cpumask_t primary_thread_mask;
> +
> +	/*
> +	 * fastsleep_workaround_state is write-once parameter.
> +	 * Once it has been set to 1, it cannot be undone.
> +	 */
> +	if (fastsleep_workaround_state == 1)
> +		return -EINVAL;

Better behaviour here is to delay this check until after you've done the
kstrtou32(), and if they are asking to set it to 1 (again) then you just return
count (OK).

That way scripts can just "echo 1 > .." and if the workaround is already
applied then there is no error.

> +	if (kstrtou32(buf, 0, &val))
> +		return -EINVAL;

You use a u8 above, so why not a u8 here?

> +	if (val > 1)
> +		return -EINVAL;
> +
> +	fastsleep_workaround_state = 1;

You should delay setting this until below when you know it's succeeded.

> +	/*
> +	 * fastsleep_workaround_state = 1 implies fastsleep workaround needs to
> +	 * be left in 'applied' state on all the cores. Do this by-
> +	 * 1. Patching out the call to 'undo' workaround in fastsleep exit path
> +	 * 2. Sending ipi to all the cores which have atleast one online thread
> +	 * 3. Patching out the call to 'apply' workaround in fastsleep entry
> +	 * path
> +	 * There is no need to send ipi to cores which have all threads
> +	 * offlined, as last thread of the core entering fastsleep or deeper
> +	 * state would have applied workaround.
> +	 */
> +	patch_instruction(
> +		(unsigned int *)pnv_fastsleep_workaround_at_exit,
> +		PPC_INST_NOP);

This can fail.

> +	primary_thread_mask = cpu_online_cores_map();
> +	on_each_cpu_mask(&primary_thread_mask,
> +				pnv_fastsleep_workaround_apply,
> +				NULL, 1);
> +
> +	patch_instruction(
> +		(unsigned int *)pnv_fastsleep_workaround_at_entry,
> +		PPC_INST_NOP);

And so can this.

> +	return count;
> +}
> +
> +static DEVICE_ATTR(fastsleep_workaround_state, 0600,
> +			show_fastsleep_workaround_state,
> +			store_fastsleep_workaround_state);
> +
>  static int __init pnv_init_idle_states(void)
>  {
>  	struct device_node *power_mgt;
> @@ -178,7 +251,15 @@ static int __init pnv_init_idle_states(void)
>  		patch_instruction(
>  			(unsigned int *)pnv_fastsleep_workaround_at_exit,
>  			PPC_INST_NOP);
> -	}
> +	} else

I know it's coding style to not bracket a single statement else block, but I
disagree in cases like this. Because the comment is so big it's preferable to
bracket it IMHO.

> +	/*
> +	 * OPAL_PM_SLEEP_ENABLED_ER1 is set. It indicates that workaround is
> +	 * needed to use fastsleep. Provide sysfs control to choose how this
> +	 * workaround has to be applied.
> +	 */

And the comment should indentend to match the code.

> +		device_create_file(cpu_subsys.dev_root,
> +					&dev_attr_fastsleep_workaround_state);
> +
>  	pnv_alloc_idle_core_states();
>  	return 0;
>  }

cheers
