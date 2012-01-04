Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
 [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 4C14B1007D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2012 07:41:12 +1100 (EST)
Received: from mail47-am1 (localhost [127.0.0.1])	by mail47-am1-R.bigfish.com
 (Postfix) with ESMTP id BFCDB700113	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2012 20:41:06 +0000 (UTC)
Received: from AM1EHSMHS013.bigfish.com (unknown [10.3.201.252])	by
 mail47-am1.bigfish.com (Postfix) with ESMTP id 877DB1802F2	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2012 20:41:06 +0000 (UTC)
Message-ID: <4F04B95F.8000808@freescale.com>
Date: Wed, 4 Jan 2012 14:41:03 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui-B35336 <B35336@freescale.com>
Subject: Re: [PATCH v3] powerpc/85xx: add support to JOG feature using cpufreq
 interface
References: <1324985129-26219-1-git-send-email-chenhui.zhao@freescale.com>
 <4F037DB8.4080207@freescale.com>
 <BD213C8CF658C24091429A9C376C468D0C6268@039-SN1MPN1-005.039d.mgd.msft.net>
In-Reply-To: <BD213C8CF658C24091429A9C376C468D0C6268@039-SN1MPN1-005.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Huang Changming-R66093 <r66093@freescale.com>,
 Liu Dave-R63238 <r63238@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/04/2012 03:34 AM, Zhao Chenhui-B35336 wrote:
>> On 12/27/2011 05:25 AM, Zhao Chenhui wrote:
>>>  * The driver doesn't support MPC8536 Rev 1.0 due to a JOG erratum.
>>>    Subsequent revisions of MPC8536 have corrected the erratum.
>>
>> Where do you check for this?
>=20
> Nowhere. I just notify this patch don't support MPC8536 Rev 1.0.

Is mpc8536 rev 1.0 supported by the kernel in general?  If so, and this
code doesn't work with it, it needs to check for that revision and not
register the cpufreq handler if found.

>>> +#define POWMGTCSR_LOSSLESS_MASK	0x00400000
>>> +#define POWMGTCSR_JOG_MASK	0x00200000
>>
>> Are these really masks, or just values to use?
>=20
> They are masks.

They're bits.  Sometimes you use it additively, to set this bit along
with others.  Sometimes you use it subtractively, to test whether the
bit has cleared -- you could argue that it's used as a mask in that
context, but I don't think adding _MASK to the name really adds anything
here (likewise for things like PMJCR_CORE0_SPD_MASK).

>>> +static int p1022_set_pll(unsigned int cpu, unsigned int pll)
>>> +{
>>> +	int index, hw_cpu =3D get_hard_smp_processor_id(cpu);
>>> +	int shift;
>>> +	u32 corefreq, val, mask =3D 0;
>>> +	unsigned int cur_pll =3D get_pll(hw_cpu);
>>> +	unsigned long flags;
>>> +	int ret =3D 0;
>>> +
>>> +	if (pll =3D=3D cur_pll)
>>> +		return 0;
>>> +
>>> +	shift =3D hw_cpu * CORE_RATIO_BITS + CORE0_RATIO_SHIFT;
>>> +	val =3D (pll & CORE_RATIO_MASK) << shift;
>>> +
>>> +	corefreq =3D sysfreq * pll / 2;
>>> +	/*
>>> +	 * Set the COREx_SPD bit if the requested core frequency
>>> +	 * is larger than the threshold frequency.
>>> +	 */
>>> +	if (corefreq > FREQ_533MHz)
>>> +		val |=3D PMJCR_CORE0_SPD_MASK << hw_cpu;
>>
>> P1022 manual says the threshold is 500 MHz (but doesn't say how to set
>> the bit if the frequency is exactly 500 MHz).  Where did 533340000 com=
e
>> from?
>=20
> Please refer to Chapter 25 "25.4.1.11 Power Management Jog Control Regi=
ster (PMJCR)".

You seem to have a different version of the p1022 manual than I (and the
FSL docs website) do.  In my copy 25.4.1 is "Performance Monitor
Interrupt" and it has no subsections.

PMJCR is described in 26.4.1.11 and for CORE0_SPD says:

> 0 Core0 frequency at 400=E2=80=93500 MHz
> 1 Core0 frequency at 500=E2=80=931067 MHz

>>> +	local_irq_save(flags);
>>> +	mb();
>>> +	/* Wait for the other core to wake. */
>>> +	while (in_jog_process !=3D 1)
>>> +		mb();
>>
>> Timeout?  And more unnecessary mb()s.
>>
>> Might be nice to support more than two cores, even if this code isn't
>> currently expected to be used on such hardware (it's just a generic
>> "hold other cpus" loop; might as well make it reusable).  You could do
>> this by using an atomic count for other cores to check in and out of t=
he
>> spin loop.
>=20
> This is just for P1022, a dual-core chip. A separate patch will
> support multi-core chips, such as P4080, etc.

My point was that this specific function isn't really doing anything
p1022-specific, it's just a way to get other CPUs in the system to halt
until signalled to continue.  I thought it would be nice to just write
it generically from the start, but it's up to you.

>>> +	out_be32(guts + POWMGTCSR, POWMGTCSR_JOG_MASK |
>> P1022_POWMGTCSR_MSK);
>>> +
>>> +	if (!spin_event_timeout(((in_be32(guts + POWMGTCSR) &
>>> +	    POWMGTCSR_JOG_MASK) =3D=3D 0), 10000, 10)) {
>>> +		pr_err("%s: Fail to switch the core frequency.\n", __func__);
>>> +		ret =3D -EFAULT;
>>> +	}
>>> +
>>> +	clrbits32(guts + POWMGTCSR, P1022_POWMGTCSR_MSK);
>>> +	in_jog_process =3D 0;
>>> +	mb();
>>
>> This mb() (or better, a readback of POWMGTCSR) should be before you
>> clear in_jog_process.  For clarity of its purpose, the clearing of
>> POWMGTCSR should go in the failure branch of spin_event_timeout().
>=20
> According to the manual, P1022_POWMGTCSR_MSK should be reset
> by software regardless of failure or success.

OK, I missed that you're clearing more bits than you checked in
spin_event_timeout().  Could you rename P1022_POWMGTCSR_MSK to something
more meaningful (especially since you use _MASK all over the place to
mean something else)?

-Scott
