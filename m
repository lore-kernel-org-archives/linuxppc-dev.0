Return-Path: <B40534@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 582152C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 16:52:02 +1100 (EST)
Received: from mail22-tx2 (localhost [127.0.0.1])	by mail22-tx2-R.bigfish.com
 (Postfix) with ESMTP id 447C6420124	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,
 17 Oct 2013 05:51:58 +0000 (UTC)
Received: from TX2EHSMHS035.bigfish.com (unknown [10.9.14.238])	by
 mail22-tx2.bigfish.com (Postfix) with ESMTP id A7510260031	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 05:51:55 +0000 (UTC)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Bhushan Bharat-R65777 <R65777@freescale.com>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state and
 altivec idle
Date: Thu, 17 Oct 2013 05:51:51 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259010B189E@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1381828871-17110-1-git-send-email-dongsheng.wang@freescale.com>
 <1381828871-17110-4-git-send-email-dongsheng.wang@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071C08E4@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010B1799@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071C3279@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D071C3279@039-SN2MPN1-013.039d.mgd.msft.net>
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
> From: Bhushan Bharat-R65777
> Sent: Thursday, October 17, 2013 11:20 AM
> To: Wang Dongsheng-B40534; Wood Scott-B07421
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: RE: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state and
> altivec idle
>=20
>=20
>=20
> > -----Original Message-----
> > From: Wang Dongsheng-B40534
> > Sent: Thursday, October 17, 2013 8:16 AM
> > To: Bhushan Bharat-R65777; Wood Scott-B07421
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Subject: RE: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state and
> > altivec idle
> >
> >
> >
> > > -----Original Message-----
> > > From: Bhushan Bharat-R65777
> > > Sent: Thursday, October 17, 2013 1:01 AM
> > > To: Wang Dongsheng-B40534; Wood Scott-B07421
> > > Cc: linuxppc-dev@lists.ozlabs.org
> > > Subject: RE: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state
> > > and altivec idle
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Wang Dongsheng-B40534
> > > > Sent: Tuesday, October 15, 2013 2:51 PM
> > > > To: Wood Scott-B07421
> > > > Cc: Bhushan Bharat-R65777; linuxppc-dev@lists.ozlabs.org; Wang
> > > Dongsheng-B40534
> > > > Subject: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state and
> > > altivec idle
> > > >
> > > > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > > >
> > > > Add a sys interface to enable/diable pw20 state or altivec idle,
> > > > and
> > > control the
> > > > wait entry time.
> > > >
> > > > Enable/Disable interface:
> > > > 0, disable. 1, enable.
> > > > /sys/devices/system/cpu/cpuX/pw20_state
> > > > /sys/devices/system/cpu/cpuX/altivec_idle
> > > >
> > > > Set wait time interface:(Nanosecond)
> > > > /sys/devices/system/cpu/cpuX/pw20_wait_time
> > > > /sys/devices/system/cpu/cpuX/altivec_idle_wait_time
> > > > Example: Base on TBfreq is 41MHZ.
> > > > 1~48(ns): TB[63]
> > > > 49~97(ns): TB[62]
> > > > 98~195(ns): TB[61]
> > > > 196~390(ns): TB[60]
> > > > 391~780(ns): TB[59]
> > > > 781~1560(ns): TB[58]
> > > > ...
> > > >
> > > > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > > > ---
> > > > *v5:
> > > > Change get_idle_ticks_bit function implementation.
> > > >
> > > > *v4:
> > > > Move code from 85xx/common.c to kernel/sysfs.c.
> > > >
> > > > Remove has_pw20_altivec_idle function.
> > > >
> > > > Change wait "entry_bit" to wait time.
> > > >
> > > > diff --git a/arch/powerpc/kernel/sysfs.c
> > > > b/arch/powerpc/kernel/sysfs.c
> > > index
> > > > 27a90b9..10d1128 100644
> > > > --- a/arch/powerpc/kernel/sysfs.c
> > > > +++ b/arch/powerpc/kernel/sysfs.c
> > > > @@ -85,6 +85,284 @@ __setup("smt-snooze-delay=3D",
> > > setup_smt_snooze_delay);
> > > >
> > > >  #endif /* CONFIG_PPC64 */
> > > >
> > > > +#ifdef CONFIG_FSL_SOC
> > > > +#define MAX_BIT				63
> > > > +
> > > > +static u64 pw20_wt;
> > > > +static u64 altivec_idle_wt;
> > > > +
> > > > +static unsigned int get_idle_ticks_bit(u64 ns) {
> > > > +	u64 cycle;
> > > > +
> > > > +	if (ns >=3D 10000)
> > > > +		cycle =3D div_u64(ns + 500, 1000) * tb_ticks_per_usec;
> > > > +	else
> > > > +		cycle =3D div_u64(ns * tb_ticks_per_usec, 1000);
> > > > +
> > > > +	if (!cycle)
> > > > +		return 0;
> > > > +
> > > > +	return ilog2(cycle);
> > > > +}
> > > > +
> > > > +static void do_show_pwrmgtcr0(void *val) {
> > > > +	u32 *value =3D val;
> > > > +
> > > > +	*value =3D mfspr(SPRN_PWRMGTCR0);
> > > > +}
> > > > +
> > > > +static ssize_t show_pw20_state(struct device *dev,
> > > > +				struct device_attribute *attr, char *buf) {
> > > > +	u32 value;
> > > > +	unsigned int cpu =3D dev->id;
> > > > +
> > > > +	smp_call_function_single(cpu, do_show_pwrmgtcr0, &value, 1);
> > > > +
> > > > +	value &=3D PWRMGTCR0_PW20_WAIT;
> > > > +
> > > > +	return sprintf(buf, "%u\n", value ? 1 : 0); }
> > > > +
> > > > +static void do_store_pw20_state(void *val) {
> > > > +	u32 *value =3D val;
> > > > +	u32 pw20_state;
> > > > +
> > > > +	pw20_state =3D mfspr(SPRN_PWRMGTCR0);
> > > > +
> > > > +	if (*value)
> > > > +		pw20_state |=3D PWRMGTCR0_PW20_WAIT;
> > > > +	else
> > > > +		pw20_state &=3D ~PWRMGTCR0_PW20_WAIT;
> > > > +
> > > > +	mtspr(SPRN_PWRMGTCR0, pw20_state); }
> > > > +
> > > > +static ssize_t store_pw20_state(struct device *dev,
> > > > +				struct device_attribute *attr,
> > > > +				const char *buf, size_t count) {
> > > > +	u32 value;
> > > > +	unsigned int cpu =3D dev->id;
> > > > +
> > > > +	if (kstrtou32(buf, 0, &value))
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (value > 1)
> > > > +		return -EINVAL;
> > > > +
> > > > +	smp_call_function_single(cpu, do_store_pw20_state, &value, 1);
> > > > +
> > > > +	return count;
> > > > +}
> > > > +
> > > > +static ssize_t show_pw20_wait_time(struct device *dev,
> > > > +				struct device_attribute *attr, char *buf) {
> > > > +	u32 value;
> > > > +	u64 tb_cycle;
> > > > +	s64 time;
> > > > +
> > > > +	unsigned int cpu =3D dev->id;
> > > > +
> > > > +	if (!pw20_wt) {
> > > > +		smp_call_function_single(cpu, do_show_pwrmgtcr0, &value,
> 1);
> > > > +		value =3D (value & PWRMGTCR0_PW20_ENT) >>
> > > > +					PWRMGTCR0_PW20_ENT_SHIFT;
> > > > +
> > > > +		tb_cycle =3D (1 << (MAX_BIT - value)) * 2;
> > >
> > > Is value =3D 0 and value =3D 1 legal? These will make tb_cycle =3D 0,
> > >
> > > > +		time =3D div_u64(tb_cycle * 1000, tb_ticks_per_usec) - 1;
> > >
> > > And time =3D -1;
> > >
> > Please look at the end of the function, :)
> >
> > "return sprintf(buf, "%llu\n", time > 0 ? time : 0);"
>=20
> I know you return 0 if value =3D 0/1, my question was that, is this corre=
ct
> as per specification?
>=20
> Ahh, also for "value" upto 7 you will return 0, no?
>=20
If value =3D 0, MAX_BIT - value =3D 63
tb_cycle =3D 0xffffffff_ffffffff, tb_cycle * 1000 will overflow, but this s=
ituation is not possible.
Because if the "value =3D 0" means this feature will be "disable".
Now The default wait bit is 50(MAX_BIT - value, value =3D 13), the PW20/Alt=
ivec Idle wait entry time is about 1ms, this time is very long for wait idl=
e time, and it's cannot be increased(means (MAX_BIT - value) cannot greater=
 than 50).
=09
If (MAX_BIT-value) =3D 0, tb_cycle =3D 2,
div_u64(tb_cycle * 1000, tb_ticks_per_usec) - 1 =3D ((2 * 1000) / 41) - 1 =
=3D 48 - 1 =3D 47

the return value is 47

> -Bharat
>=20
> >
> > -dongsheng
> >
> > >
> > > > +	} else {
> > > > +		time =3D pw20_wt;
> > > > +	}
> > > > +
> > > > +	return sprintf(buf, "%llu\n", time > 0 ? time : 0);
> > > > }
> > > > +
