Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0248.outbound.messaging.microsoft.com [213.199.154.248])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 00F642C00DE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 09:04:13 +1000 (EST)
Message-ID: <1378940642.12204.427.camel@snotra.buserror.net>
Subject: Re: [PATCH v3 4/4] powerpc/85xx: add sysfs for pw20 state and
 altivec idle
From: Scott Wood <scottwood@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Date: Wed, 11 Sep 2013 18:04:02 -0500
In-Reply-To: <1378879004-2446-4-git-send-email-dongsheng.wang@freescale.com>
References: <1378879004-2446-1-git-send-email-dongsheng.wang@freescale.com>
 <1378879004-2446-4-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-09-11 at 13:56 +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Add a sys interface to enable/diable pw20 state or altivec idle, and
> control the wait entry time.
> 
> Enable/Disable interface:
> 0, disable. 1, enable.
> /sys/devices/system/cpu/cpuX/pw20_state
> /sys/devices/system/cpu/cpuX/altivec_idle
> 
> Set wait entry bit interface:
> bit value range 0~63, 0 bit is Mintime, 63 bit is Maxtime.
> /sys/devices/system/cpu/cpuX/pw20_wait_entry_bit
> /sys/devices/system/cpu/cpuX/altivec_idle_wait_entry_bit

I'm no fan of the way powerpc does bit numbering, but don't flip it
around here -- you'll just cause confusion.

Better yet, this interface should take real time units rather than a
timebase bit.

Also, you disable the power saving mode if the maximum interval is
selected, but the documentation doesn't say that -- and the
documentation should be in the code (or other easily findable place),
not just in the commit message.

> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> index 7389d49..7395d79 100644
> --- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> +++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> @@ -53,6 +53,21 @@ _GLOBAL(__e500_dcache_setup)
>  	isync
>  	blr
> 
> +_GLOBAL(has_pw20_altivec_idle)
> +	/* 0 false, 1 true */
> +	li	r3, 0
> +
> +	/* PW20 & AltiVec idle feature only exists for E6500 */
> +	mfspr	r0, SPRN_PVR
> +	rlwinm	r4, r0, 16, 16, 31
> +	lis	r12, 0
> +	ori	r12, r12, PVR_VER_E6500@l
> +	cmpw	r4, r12
> +	bne	2f
> +	li	r3, 1
> +2:
> +	blr

Why is this in asm?  And shouldn't this go in the cputable somehow?

> +static void query_pwrmgtcr0(void *val)
> +{
> +	u32 *value = val;
> +
> +	*value = mfspr(SPRN_PWRMGTCR0);
> +}
> +
> +static ssize_t show_pw20_state(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	u32 value;
> +	unsigned int cpu = dev->id;
> +
> +	smp_call_function_single(cpu, query_pwrmgtcr0, &value, 1);
> +
> +	value &= PWRMGTCR0_PW20_WAIT;
> +
> +	return sprintf(buf, "%u\n", value ? 1 : 0);
> +}
> +
> +static void control_pw20_state(void *val)
> +{
> +	u32 *value = val;
> +	u32 pw20_state;
> +
> +	pw20_state = mfspr(SPRN_PWRMGTCR0);
> +
> +	if (*value)
> +		pw20_state |= PWRMGTCR0_PW20_WAIT;
> +	else
> +		pw20_state &= ~PWRMGTCR0_PW20_WAIT;
> +
> +	mtspr(SPRN_PWRMGTCR0, pw20_state);
> +}
> +
> +static ssize_t store_pw20_state(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)

The difference between query/show and control/store is a bit awkward...
I'd s/query/do_show/ and s/control/do_store/ (or local_ or other
appropriate prefix).

> +static ssize_t show_altivec_idle_wait_entry_bit(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	u32 value;
> +	unsigned int cpu = dev->id;
> +
> +	smp_call_function_single(cpu, query_pwrmgtcr0, &value, 1);
> +
> +	value = MAX_BIT - ((value & PWRMGTCR0_AV_IDLE_CNT) >>
> +				PWRMGTCR0_AV_IDLE_CNT_SHIFT);
> +
> +	return sprintf(buf, "wait entry bit is %u\n", value);
> +}

Reading a sysfs value should just return the value, not a human-readable
string.

> +static DEVICE_ATTR(pw20_state, 0644, show_pw20_state, store_pw20_state);
> +static DEVICE_ATTR(pw20_wait_entry_bit, 0644, show_pw20_wait_entry_bit,
> +						store_pw20_wait_entry_bit);
> +
> +static DEVICE_ATTR(altivec_idle, 0644, show_altivec_idle, store_altivec_idle);
> +static DEVICE_ATTR(altivec_idle_wait_entry_bit, 0644,
> +			show_altivec_idle_wait_entry_bit,
> +			store_altivec_idle_wait_entry_bit);

I'd make these 0600, given their ability to spam other CPUs with IPIs
even on read.

> +static int __init create_pw20_altivec_sysfs(void)
> +{
> +	int i;
> +	struct device *cpu_dev;
> +
> +	if (!has_pw20_altivec_idle())
> +		return -ENODEV;
> +
> +	for_each_possible_cpu(i) {
> +		cpu_dev = get_cpu_device(i);
> +		device_create_file(cpu_dev, &dev_attr_pw20_state);
> +		device_create_file(cpu_dev, &dev_attr_pw20_wait_entry_bit);
> +
> +		device_create_file(cpu_dev, &dev_attr_altivec_idle);
> +		device_create_file(cpu_dev,
> +					&dev_attr_altivec_idle_wait_entry_bit);
> +	}
> +
> +	return 0;
> +}
> +device_initcall(create_pw20_altivec_sysfs);

I think I said this earlier, but it'd be nice to have a "late cpu setup"
cputable callback -- but failing that, this should be called from
register_cpu_online() which is where other CPU sysfs attributes are
created.

-Scott
