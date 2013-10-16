Return-Path: <R65777@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 04CE62C0079
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 04:01:35 +1100 (EST)
Received: from mail63-db8 (localhost [127.0.0.1])	by mail63-db8-R.bigfish.com
 (Postfix) with ESMTP id CAD77620052	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 16 Oct 2013 17:01:29 +0000 (UTC)
Received: from DB8EHSMHS003.bigfish.com (unknown [10.174.8.236])	by
 mail63-db8.bigfish.com (Postfix) with ESMTP id 52220480041	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Oct 2013 17:01:27 +0000 (UTC)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Wang Dongsheng-B40534 <B40534@freescale.com>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state and
 altivec idle
Date: Wed, 16 Oct 2013 17:01:25 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D071C08E4@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1381828871-17110-1-git-send-email-dongsheng.wang@freescale.com>
 <1381828871-17110-4-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1381828871-17110-4-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wang Dongsheng-B40534
> Sent: Tuesday, October 15, 2013 2:51 PM
> To: Wood Scott-B07421
> Cc: Bhushan Bharat-R65777; linuxppc-dev@lists.ozlabs.org; Wang Dongsheng-=
B40534
> Subject: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state and altive=
c idle
>=20
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>=20
> Add a sys interface to enable/diable pw20 state or altivec idle, and cont=
rol the
> wait entry time.
>=20
> Enable/Disable interface:
> 0, disable. 1, enable.
> /sys/devices/system/cpu/cpuX/pw20_state
> /sys/devices/system/cpu/cpuX/altivec_idle
>=20
> Set wait time interface:(Nanosecond)
> /sys/devices/system/cpu/cpuX/pw20_wait_time
> /sys/devices/system/cpu/cpuX/altivec_idle_wait_time
> Example: Base on TBfreq is 41MHZ.
> 1~48(ns): TB[63]
> 49~97(ns): TB[62]
> 98~195(ns): TB[61]
> 196~390(ns): TB[60]
> 391~780(ns): TB[59]
> 781~1560(ns): TB[58]
> ...
>=20
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> *v5:
> Change get_idle_ticks_bit function implementation.
>=20
> *v4:
> Move code from 85xx/common.c to kernel/sysfs.c.
>=20
> Remove has_pw20_altivec_idle function.
>=20
> Change wait "entry_bit" to wait time.
>=20
> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c in=
dex
> 27a90b9..10d1128 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -85,6 +85,284 @@ __setup("smt-snooze-delay=3D", setup_smt_snooze_delay=
);
>=20
>  #endif /* CONFIG_PPC64 */
>=20
> +#ifdef CONFIG_FSL_SOC
> +#define MAX_BIT				63
> +
> +static u64 pw20_wt;
> +static u64 altivec_idle_wt;
> +
> +static unsigned int get_idle_ticks_bit(u64 ns) {
> +	u64 cycle;
> +
> +	if (ns >=3D 10000)
> +		cycle =3D div_u64(ns + 500, 1000) * tb_ticks_per_usec;
> +	else
> +		cycle =3D div_u64(ns * tb_ticks_per_usec, 1000);
> +
> +	if (!cycle)
> +		return 0;
> +
> +	return ilog2(cycle);
> +}
> +
> +static void do_show_pwrmgtcr0(void *val) {
> +	u32 *value =3D val;
> +
> +	*value =3D mfspr(SPRN_PWRMGTCR0);
> +}
> +
> +static ssize_t show_pw20_state(struct device *dev,
> +				struct device_attribute *attr, char *buf) {
> +	u32 value;
> +	unsigned int cpu =3D dev->id;
> +
> +	smp_call_function_single(cpu, do_show_pwrmgtcr0, &value, 1);
> +
> +	value &=3D PWRMGTCR0_PW20_WAIT;
> +
> +	return sprintf(buf, "%u\n", value ? 1 : 0); }
> +
> +static void do_store_pw20_state(void *val) {
> +	u32 *value =3D val;
> +	u32 pw20_state;
> +
> +	pw20_state =3D mfspr(SPRN_PWRMGTCR0);
> +
> +	if (*value)
> +		pw20_state |=3D PWRMGTCR0_PW20_WAIT;
> +	else
> +		pw20_state &=3D ~PWRMGTCR0_PW20_WAIT;
> +
> +	mtspr(SPRN_PWRMGTCR0, pw20_state);
> +}
> +
> +static ssize_t store_pw20_state(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	u32 value;
> +	unsigned int cpu =3D dev->id;
> +
> +	if (kstrtou32(buf, 0, &value))
> +		return -EINVAL;
> +
> +	if (value > 1)
> +		return -EINVAL;
> +
> +	smp_call_function_single(cpu, do_store_pw20_state, &value, 1);
> +
> +	return count;
> +}
> +
> +static ssize_t show_pw20_wait_time(struct device *dev,
> +				struct device_attribute *attr, char *buf) {
> +	u32 value;
> +	u64 tb_cycle;
> +	s64 time;
> +
> +	unsigned int cpu =3D dev->id;
> +
> +	if (!pw20_wt) {
> +		smp_call_function_single(cpu, do_show_pwrmgtcr0, &value, 1);
> +		value =3D (value & PWRMGTCR0_PW20_ENT) >>
> +					PWRMGTCR0_PW20_ENT_SHIFT;
> +
> +		tb_cycle =3D (1 << (MAX_BIT - value)) * 2;

Is value =3D 0 and value =3D 1 legal? These will make tb_cycle =3D 0,

> +		time =3D div_u64(tb_cycle * 1000, tb_ticks_per_usec) - 1;

And time =3D -1;


> +	} else {
> +		time =3D pw20_wt;
> +	}
> +
> +	return sprintf(buf, "%llu\n", time > 0 ? time : 0);
> }
> +
> +static void set_pw20_wait_entry_bit(void *val) {
> +	u32 *value =3D val;
> +	u32 pw20_idle;
> +
> +	pw20_idle =3D mfspr(SPRN_PWRMGTCR0);
> +
> +	/* Set Automatic PW20 Core Idle Count */
> +	/* clear count */
> +	pw20_idle &=3D ~PWRMGTCR0_PW20_ENT;
> +
> +	/* set count */
> +	pw20_idle |=3D ((MAX_BIT - *value) << PWRMGTCR0_PW20_ENT_SHIFT);
> +
> +	mtspr(SPRN_PWRMGTCR0, pw20_idle);
> +}
> +
> +static ssize_t store_pw20_wait_time(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	u32 entry_bit;
> +	u64 value;
> +
> +	unsigned int cpu =3D dev->id;
> +
> +	if (kstrtou64(buf, 0, &value))
> +		return -EINVAL;
> +
> +	if (!value)
> +		return -EINVAL;
> +
> +	entry_bit =3D get_idle_ticks_bit(value);
> +	if (entry_bit > MAX_BIT)
> +		return -EINVAL;
> +
> +	pw20_wt =3D value;
> +	smp_call_function_single(cpu, set_pw20_wait_entry_bit,
> +				&entry_bit, 1);
> +
> +	return count;
> +}
> +
> +static ssize_t show_altivec_idle(struct device *dev,
> +				struct device_attribute *attr, char *buf) {
> +	u32 value;
> +	unsigned int cpu =3D dev->id;
> +
> +	smp_call_function_single(cpu, do_show_pwrmgtcr0, &value, 1);
> +
> +	value &=3D PWRMGTCR0_AV_IDLE_PD_EN;
> +
> +	return sprintf(buf, "%u\n", value ? 1 : 0); }
> +
> +static void do_store_altivec_idle(void *val) {
> +	u32 *value =3D val;
> +	u32 altivec_idle;
> +
> +	altivec_idle =3D mfspr(SPRN_PWRMGTCR0);
> +
> +	if (*value)
> +		altivec_idle |=3D PWRMGTCR0_AV_IDLE_PD_EN;
> +	else
> +		altivec_idle &=3D ~PWRMGTCR0_AV_IDLE_PD_EN;
> +
> +	mtspr(SPRN_PWRMGTCR0, altivec_idle);
> +}
> +
> +static ssize_t store_altivec_idle(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	u32 value;
> +	unsigned int cpu =3D dev->id;
> +
> +	if (kstrtou32(buf, 0, &value))
> +		return -EINVAL;
> +
> +	if (value > 1)
> +		return -EINVAL;
> +
> +	smp_call_function_single(cpu, do_store_altivec_idle, &value, 1);
> +
> +	return count;
> +}
> +
> +static ssize_t show_altivec_idle_wait_time(struct device *dev,
> +				struct device_attribute *attr, char *buf) {
> +	u32 value;
> +	u64 tb_cycle;
> +	s64 time;
> +
> +	unsigned int cpu =3D dev->id;
> +
> +	if (!altivec_idle_wt) {
> +		smp_call_function_single(cpu, do_show_pwrmgtcr0, &value, 1);
> +		value =3D (value & PWRMGTCR0_AV_IDLE_CNT) >>
> +					PWRMGTCR0_AV_IDLE_CNT_SHIFT;
> +
> +		tb_cycle =3D (1 << (MAX_BIT - value)) * 2;
> +		time =3D div_u64(tb_cycle * 1000, tb_ticks_per_usec) - 1;

Likewise

Thanks
-Bharat

> +	} else {
> +		time =3D altivec_idle_wt;
> +	}
> +
> +	return sprintf(buf, "%llu\n", time > 0 ? time : 0); }
> +
> +static void set_altivec_idle_wait_entry_bit(void *val) {
> +	u32 *value =3D val;
> +	u32 altivec_idle;
> +
> +	altivec_idle =3D mfspr(SPRN_PWRMGTCR0);
> +
> +	/* Set Automatic AltiVec Idle Count */
> +	/* clear count */
> +	altivec_idle &=3D ~PWRMGTCR0_AV_IDLE_CNT;
> +
> +	/* set count */
> +	altivec_idle |=3D ((MAX_BIT - *value) << PWRMGTCR0_AV_IDLE_CNT_SHIFT);
> +
> +	mtspr(SPRN_PWRMGTCR0, altivec_idle);
> +}
> +
> +static ssize_t store_altivec_idle_wait_time(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	u32 entry_bit;
> +	u64 value;
> +
> +	unsigned int cpu =3D dev->id;
> +
> +	if (kstrtou64(buf, 0, &value))
> +		return -EINVAL;
> +
> +	if (!value)
> +		return -EINVAL;
> +
> +	entry_bit =3D get_idle_ticks_bit(value);
> +	if (entry_bit > MAX_BIT)
> +		return -EINVAL;
> +
> +	altivec_idle_wt =3D value;
> +	smp_call_function_single(cpu, set_altivec_idle_wait_entry_bit,
> +				&entry_bit, 1);
> +
> +	return count;
> +}
> +
> +/*
> + * Enable/Disable interface:
> + * 0, disable. 1, enable.
> + */
> +static DEVICE_ATTR(pw20_state, 0600, show_pw20_state,
> +store_pw20_state); static DEVICE_ATTR(altivec_idle, 0600,
> +show_altivec_idle, store_altivec_idle);
> +
> +/*
> + * Set wait time interface:(Nanosecond)
> + * Example: Base on TBfreq is 41MHZ.
> + * 1~48(ns): TB[63]
> + * 49~97(ns): TB[62]
> + * 98~195(ns): TB[61]
> + * 196~390(ns): TB[60]
> + * 391~780(ns): TB[59]
> + * 781~1560(ns): TB[58]
> + * ...
> + */
> +static DEVICE_ATTR(pw20_wait_time, 0600,
> +			show_pw20_wait_time,
> +			store_pw20_wait_time);
> +static DEVICE_ATTR(altivec_idle_wait_time, 0600,
> +			show_altivec_idle_wait_time,
> +			store_altivec_idle_wait_time);
> +#endif
> +
>  /*
>   * Enabling PMCs will slow partition context switch times so we only do
>   * it the first time we write to the PMCs.
> @@ -407,6 +685,15 @@ static void register_cpu_online(unsigned int cpu)
>  		device_create_file(s, &dev_attr_pir);  #endif /* CONFIG_PPC64 */
>=20
> +#ifdef CONFIG_FSL_SOC
> +	if (PVR_VER(cur_cpu_spec->pvr_value) =3D=3D PVR_VER_E6500) {
> +		device_create_file(s, &dev_attr_pw20_state);
> +		device_create_file(s, &dev_attr_pw20_wait_time);
> +
> +		device_create_file(s, &dev_attr_altivec_idle);
> +		device_create_file(s, &dev_attr_altivec_idle_wait_time);
> +	}
> +#endif
>  	cacheinfo_cpu_online(cpu);
>  }
>=20
> @@ -479,6 +766,15 @@ static void unregister_cpu_online(unsigned int cpu)
>  		device_remove_file(s, &dev_attr_pir);  #endif /* CONFIG_PPC64 */
>=20
> +#ifdef CONFIG_FSL_SOC
> +	if (PVR_VER(cur_cpu_spec->pvr_value) =3D=3D PVR_VER_E6500) {
> +		device_remove_file(s, &dev_attr_pw20_state);
> +		device_remove_file(s, &dev_attr_pw20_wait_time);
> +
> +		device_remove_file(s, &dev_attr_altivec_idle);
> +		device_remove_file(s, &dev_attr_altivec_idle_wait_time);
> +	}
> +#endif
>  	cacheinfo_cpu_offline(cpu);
>  }
>=20
> --
> 1.8.0
