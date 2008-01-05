Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 52600DDEB9
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 22:56:56 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 3/3] PS3: Add logical performance monitor driver support
Date: Sat, 5 Jan 2008 12:56:22 +0100
References: <20080105003019.595703814@am.sony.com>
	<477EF9BD.2020202@am.sony.com>
In-Reply-To: <477EF9BD.2020202@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801051256.22732.arnd@arndb.de>
Cc: paulus@samba.org, Takashi Yamamoto <Takashi02_Yamamoto@hq.scei.sony.co.jp>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 05 January 2008, Geoff Levand wrote:
> From: Takashi Yamamoto <Takashi02_Yamamoto@hq.scei.sony.co.jp>
> 
> Add PS3 logical performance monitor (lpm) device driver.
> 
> The PS3's LV1 hypervisor provides a Logical Performance Monitor that
> abstarcts the Cell processor's performance monitor features for use
> by guest operating systems.
> 
> Signed-off-by: Takashi Yamamoto <Takashi02_Yamamoto@hq.scei.sony.co.jp>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Wow, great stuff!

One bit of information I'm missing in the description is what the users
of this code are. Your Kconfig text mentions that can be used for both
perfmon and oprofile. Are these, or one of them, currently under
work as well?

> --- a/arch/powerpc/platforms/ps3/Kconfig
> +++ b/arch/powerpc/platforms/ps3/Kconfig
> @@ -138,4 +138,18 @@ config PS3_FLASH
>  	  be disabled on the kernel command line using "ps3flash=off", to
>  	  not allocate this fixed buffer.
>  
> +config PS3_LPM
> +	tristate "PS3 Logical Performance Monitor support"
> +	depends on PPC_PS3
> +	default n

'default n' is redundant.

> +	help
> +	  Include support for the PS3 Logical Performance Monitor.
> +
> +	  This support is required to use the logical performance monitor
> +	  of the PS3's LV1 hypervisor.
> +
> +	  If you intend to use the advanced performance monitoring and
> +	  profiling support of the Cell processor with programs like
> +	  oprofile and perfmon, then say Y or M, otherwise say N.
> +

Should that be perfmon2 instead of perfmon?

I think once they high-level drivers are merged, it would make sense
to autoselected by these, so the user doesn't have to read through
the help text.

> +/**
> + * struct ps3_lpm_priv - private lpm device data.
> + *
> + * @mutex: Open/close mutex.
> + * @rights: The lpm rigths granted by the system policy module.
> + * @pu_id: The lv1 id of the BE prosessor for this lpm instance.
> + * @lpm_id: The lv1 id of this lpm instance.
> + * @outlet_id: The outlet created by lv1 for this lpm instance.
> + * @constructed: A flag indicating the lpm driver has been opened -- can we just use (lpm_id == ???)
> + * @tb_size: The lv1 trace buffer size
> + * @tb_cache: Trace buffer cache
> + * @tb_cache_internal: A flag indicating the trace buffer cache was allocated
> + *                     by the driver.
> + * @tb_cache: Trace buffer cache
> + * @sizeof_traced_data: Traced data size
> + * @sbd: the struct ps3_system_bus_device attached to this driver
> + */
> +
> +struct ps3_lpm_priv {
> +	struct mutex mutex;
> +	u64 rights;
> +	u64 pu_id;
> +	u64 lpm_id;
> +	u64 outlet_id;
> +	int constructed;
> +	u64 tb_size;
> +	void *tb_cache;
> +	u64 tb_cache_size;
> +	int tb_cache_internal;
> +	u64 sizeof_traced_data;
> +	u64 sizeof_total_copied_data;
> +	u64 shadow_pm_control;
> +	u64 shadow_pm_start_stop;
> +	u64 shadow_pm_interval;
> +	u64 shadow_group_control;
> +	u64 shadow_debug_bus_control;
> +	struct ps3_system_bus_device *sbd;
> +};

Some of the members in this struct are not present in the comment,
which is somewhat confusing.

> +
> +/**
> + * lpm_priv - Static instance of the lpm data.
> + *
> + * Since the exported routines don't support the notion of a device
> + * instance we need to hold the instance in this static variable
> + * and only allow at most one instance to be created.
> + */
> +
> +static struct ps3_lpm_priv *lpm_priv;

Hmmm, my gut feeling about this is that it would be better to actually
pass this around through the exported functions. That would also
provide some arbitration between the possible users, e.g. oprofile
would get -EBUSY when asking for the ps3_lpm while perfmon2 is
already active.

> +/* bookmark spr address */
> +#define BOOKMARK_SPR_ADDR 1020

This one belongs to asm/reg.h and should be named SRPN_BKMK.

> +inline u32 ps3_get_hw_thread_id(int cpu)
> +{
> +	return cpu;
> +}
> +EXPORT_SYMBOL_GPL(ps3_get_hw_thread_id);

The 'inline' is bogus, as that doesn't work across exported functions
and you are not using the function in this file.

Should you perhaps return hard_smp_processor_id(cpu) instead of cpu
here?

> +/**
> + * _ps3_copy_trace_buffer - Copy the trace buffer.
> + */
> +
> +static u64 _ps3_copy_trace_buffer(u64 offset, u64 size, u64 *to, int to_user)
> +{
> +	int result;
> +	u64 sizeof_copied_data;
> +
> +	if (offset >= lpm_priv->sizeof_traced_data)
> +		return 0;
> +
> +	result = lv1_copy_lpm_trace_buffer(lpm_priv->lpm_id, offset, size,
> +					&sizeof_copied_data);
> +	if (result) {
> +		dev_err(sbd_core(), "%s:%u: lv1_copy_lpm_trace_buffer failed: "
> +			"offset 0x%lx, size 0x%lx: %s\n", __func__, __LINE__,
> +			offset, size, ps3_result(result));
> +		return 0;
> +	}
> +
> +	if (to_user) {
> +		result = copy_to_user((void __user *)to, lpm_priv->tb_cache,
> +				      sizeof_copied_data);
> +		if (result) {
> +			dev_err(sbd_core(), "%s:%u: copy_to_user() error. "
> +				"offset:0x%lx size:0x%lx dest:0x%p src:0x%p\n",
> +				__func__, __LINE__, offset, sizeof_copied_data,
> +				to, lpm_priv->tb_cache);
> +			return 0;
> +		}
> +	} else
> +		memcpy(to, lpm_priv->tb_cache, sizeof_copied_data);
> +
> +	return sizeof_copied_data;
> +}

I don't like how this functions uses the same argument for kernel and user
pointers, this will cause sparse warnings in the code using it. How about
making this two separate functions?

> +int ps3_lpm_open(void *tb_cache, u64 tb_cache_size, u64 tb_type)
> +{
> +	int result;
> +	u64 cbe_node_id;
> +	u64 tb_size;
> +	u64 ctrl_opt;
> +	u64 tb_cache_lpar_addr;
> +	u64 lpm_id;
> +	u64 outlet_id;
> +	u64 used_tb_size;
> +
> +	if (!lpm_priv) {
> +		BUG();
> +		return -ENODEV;
> +	}
> +
> +	mutex_lock(&lpm_priv->mutex);

This mutex is documented as the 'open/close' mutex and you use it
to prevent concurrent execution of the open and close functions.
However, it's unclear what data structures are actually protected
by it.

I think this is the result of unusual lifetime rules for the lpm_priv
object, which I already mentioned above.

	Arnd <><
