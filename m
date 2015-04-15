Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DD41C1A0143
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 22:22:42 +1000 (AEST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 15 Apr 2015 06:22:40 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 41A603E40044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 06:22:38 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3FCMM8m43384886
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 05:22:22 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3FCMYHK001342
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 06:22:35 -0600
Message-ID: <552E5806.6070103@linux.vnet.ibm.com>
Date: Wed, 15 Apr 2015 17:52:30 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] powerpc/powernv: Introduce sysfs control for
 fastsleep workaround behavior
References: <1429079049-5955-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1429079049-5955-4-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1429079049-5955-4-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: ego@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/15/2015 11:54 AM, Shreyas B. Prabhu wrote:
> +/*
> + * Used to store fastsleep workaround state
> + * 0 - Workaround applied/undone at fastsleep entry/exit path (Default)
> + * 1 - Workaround applied once, never undone.
> + */
> +static u8 fastsleep_workaround_state;
> +
> +static const char * const fastsleep_workaround_avail_states[] = {
> +	"dynamic", "applyonce"
> +};
> +
> +/*
> + * fastsleep_workaround_avail_states values
> + */
> +enum {
> +	WORKAROUND_DYNAMIC,
> +	WORKAROUND_APPLYONCE
> +};

Is there a strong reason to use the above and not a boolean
fastsleep_workaround_once knob ? I also don't know what the user can
make out from 'dynamic'. Its not straight forward and is open to a great
deal of interpretation.

Why is this called the 'available' states. You can only echo applyonce
to it. And once applied it cannot be reverted.  'dynamic' is not a state
that is available to the user to choose. It is the default value. It is
therefore misleading.

My point is lets make the purpose and usage of this knob clear to the
user. Instead if we have fastsleep_workaround_once set to a default
value of 0. If it is 1, it is clear that  the workaround is applied only
once. If it is '0' it is not the case and that it is repeatedly applied
somewhere.There are some advantages when we do this during printing of
errors as well. See below:

> +	/*
> +	 * fastsleep_workaround_state = WORKAROUND_APPLYONCE implies
> +	 * fastsleep workaround needs to be left in 'applied' state on all
> +	 * the cores. Do this by-
> +	 * 1. Patching out the call to 'undo' workaround in fastsleep exit path
> +	 * 2. Sending ipi to all the cores which have atleast one online thread
> +	 * 3. Patching out the call to 'apply' workaround in fastsleep entry
> +	 * path
> +	 * There is no need to send ipi to cores which have all threads
> +	 * offlined, as last thread of the core entering fastsleep or deeper
> +	 * state would have applied workaround.
> +	 */
> +	err = patch_instruction(
> +		(unsigned int *)pnv_fastsleep_workaround_at_exit,
> +		PPC_INST_NOP);
> +	if (err) {
> +		pr_err("fastsleep_workaround_state change failed while patching pnv_fastsleep_workaround_at_exit");
> +		goto fail;
> +	}
> +
> +	get_online_cpus();
> +	primary_thread_mask = cpu_online_cores_map();
> +	on_each_cpu_mask(&primary_thread_mask,
> +				pnv_fastsleep_workaround_apply,
> +				&err, 1);
> +	put_online_cpus();
> +	if (err) {
> +		pr_err("fastsleep_workaround_state change failed while running pnv_fastsleep_workaround_apply");
> +		goto fail;
> +	}


> +
> +	err = patch_instruction(
> +		(unsigned int *)pnv_fastsleep_workaround_at_entry,
> +		PPC_INST_NOP);
> +	if (err) {
> +		pr_err("fastsleep_workaround_state change failed while patching pnv_fastsleep_workaround_at_entry");
> +		goto fail;
> +	}

Now in all the above error conditions, we know that the workaround will
end up being applied always. But the error messages don't indicate that
since it says state change failed. state change to 'what' failed? I
understand that the user in question can make sense of it, but it seems
to indicate that there is a state machine in question and that the user
can rotate among them, when there is only one state that he can choose.
If we instead use fastsleep_workaround_once, all the above error
messages will simply fallback to 'fastsleep_workaround_once failed',
which indicates clearly that the workaround will be repeatedly applied
somewhere. When the user tries to echo a '0' after a 1, we can fail with
"fastsleep_workaround_once cannot be reverted", indicating its applied
once now and nothing can be done about it.

Thus the consequence of every action of the user becomes explicit,
informing even a clueless user what can be done with this knob IMO.

Regards
Preeti U Murthy
> +
> +	fastsleep_workaround_state = WORKAROUND_APPLYONCE;
> +
> +	return count;
> +fail:
> +	return -EIO;
> +}
> +
> +static DEVICE_ATTR(fastsleep_workaround_state, 0600,
> +			show_fastsleep_workaround_state,
> +			store_fastsleep_workaround_state);
> +
>  static int __init pnv_init_idle_states(void)
>  {
>  	struct device_node *power_mgt;
> @@ -180,7 +305,16 @@ static int __init pnv_init_idle_states(void)
>  		patch_instruction(
>  			(unsigned int *)pnv_fastsleep_workaround_at_exit,
>  			PPC_INST_NOP);
> +	} else {
> +		/*
> +		 * OPAL_PM_SLEEP_ENABLED_ER1 is set. It indicates that
> +		 * workaround is needed to use fastsleep. Provide sysfs
> +		 * control to choose how this workaround has to be applied.
> +		 */
> +		device_create_file(cpu_subsys.dev_root,
> +					&dev_attr_fastsleep_workaround_state);
>  	}
> +
>  	pnv_alloc_idle_core_states();
>  out_free:
>  	kfree(flags);
> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
> index a7ade94..bf15ead 100644
> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
> @@ -283,6 +283,7 @@ OPAL_CALL(opal_sensor_read,			OPAL_SENSOR_READ);
>  OPAL_CALL(opal_get_param,			OPAL_GET_PARAM);
>  OPAL_CALL(opal_set_param,			OPAL_SET_PARAM);
>  OPAL_CALL(opal_handle_hmi,			OPAL_HANDLE_HMI);
> +OPAL_CALL(opal_config_cpu_idle_state,		OPAL_CONFIG_CPU_IDLE_STATE);
>  OPAL_CALL(opal_slw_set_reg,			OPAL_SLW_SET_REG);
>  OPAL_CALL(opal_register_dump_region,		OPAL_REGISTER_DUMP_REGION);
>  OPAL_CALL(opal_unregister_dump_region,		OPAL_UNREGISTER_DUMP_REGION);
> 
