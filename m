Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7BC972C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 03:57:06 +1000 (EST)
Received: from mail141-va3 (localhost [127.0.0.1])	by
 mail141-va3-R.bigfish.com (Postfix) with ESMTP id A65AF440150	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 17:57:01 +0000 (UTC)
Received: from VA3EHSMHS008.bigfish.com (unknown [10.7.14.248])	by
 mail141-va3.bigfish.com (Postfix) with ESMTP id 01DD910004C	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 17:56:59 +0000 (UTC)
Message-ID: <1380131815.24959.185.camel@snotra.buserror.net>
Subject: Re: [PATCH v4 4/4] powerpc/85xx: add sysfs for pw20 state and
 altivec idle
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Date: Wed, 25 Sep 2013 12:56:55 -0500
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F154392590108FF41@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1380014925-23300-2-git-send-email-dongsheng.wang@freescale.com>
 <1380014925-23300-4-git-send-email-dongsheng.wang@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0717F8F9@039-SN2MPN1-011.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F154392590108FF41@039-SN2MPN1-021.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Bhushan Bharat-R65777 <R65777@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-09-25 at 03:10 -0500, Wang Dongsheng-B40534 wrote:
> 
> > -----Original Message-----
> > From: Bhushan Bharat-R65777
> > Sent: Wednesday, September 25, 2013 2:23 PM
> > To: Wang Dongsheng-B40534; Wood Scott-B07421
> > Cc: linuxppc-dev@lists.ozlabs.org; Wang Dongsheng-B40534
> > Subject: RE: [PATCH v4 4/4] powerpc/85xx: add sysfs for pw20 state and
> > altivec idle
> > 
> > 
> > 
> > > -----Original Message-----
> > > From: Linuxppc-dev [mailto:linuxppc-dev-
> > > bounces+bharat.bhushan=freescale.com@lists.ozlabs.org] On Behalf Of
> > > bounces+Dongsheng
> > > Wang
> > > Sent: Tuesday, September 24, 2013 2:59 PM
> > > To: Wood Scott-B07421
> > > Cc: linuxppc-dev@lists.ozlabs.org; Wang Dongsheng-B40534
> > > Subject: [PATCH v4 4/4] powerpc/85xx: add sysfs for pw20 state and
> > > altivec idle
> > >
> > > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > >
> > > Add a sys interface to enable/diable pw20 state or altivec idle, and
> > > control the wait entry time.
> > >
> > > Enable/Disable interface:
> > > 0, disable. 1, enable.
> > > /sys/devices/system/cpu/cpuX/pw20_state
> > > /sys/devices/system/cpu/cpuX/altivec_idle
> > >
> > > Set wait time interface:(Nanosecond)
> > > /sys/devices/system/cpu/cpuX/pw20_wait_time
> > > /sys/devices/system/cpu/cpuX/altivec_idle_wait_time
> > > Example: Base on TBfreq is 41MHZ.
> > > 1~47(ns): TB[63]
> > > 48~95(ns): TB[62]
> > > 96~191(ns): TB[61]
> > > 192~383(ns): TB[62]
> > > 384~767(ns): TB[60]
> > > ...
> > >
> > > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > > ---
> > > *v4:
> > > Move code from 85xx/common.c to kernel/sysfs.c.
> > >
> > > Remove has_pw20_altivec_idle function.
> > >
> > > Change wait "entry_bit" to wait time.
> > >
> > >  arch/powerpc/kernel/sysfs.c | 291
> > > ++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 291 insertions(+)
> > >
> > > diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> > > index 27a90b9..23fece6 100644
> > > --- a/arch/powerpc/kernel/sysfs.c
> > > +++ b/arch/powerpc/kernel/sysfs.c
> > > @@ -85,6 +85,279 @@ __setup("smt-snooze-delay=",
> > > setup_smt_snooze_delay);
> > >
> > >  #endif /* CONFIG_PPC64 */
> > >
> > > +#ifdef CONFIG_FSL_SOC
> > > +#define MAX_BIT		63
> > > +
> > > +static u64 pw20_wt;
> > > +static u64 altivec_idle_wt;
> > > +
> > > +static unsigned int get_idle_ticks_bit(u64 ns) {
> > > +	u64 cycle;
> > > +
> > > +	cycle = div_u64(ns, 1000 / tb_ticks_per_usec);
> > 
> > When tb_ticks_per_usec  > 1000 (timebase frequency > 1GHz) then this will
> > always be ns, which is not correct, no?

Actually it'll be a divide by zero in that case.

> "1000 / tb_ticks_per_usec" means nsec_ticks_per_tb
> 
> If timebase frequency > 1GHz, this should be "tb_ticks_per_usec / 1000" and to get tb_ticks_per_nsec.
> This should be changed to "cycle = ns * tb_ticks_per_nsec;"
> 
> But at present we do not have such a platform that timebase frequency
> more than 1GHz. And I think it is not need to support such a situation.
> Because we have no environment to test it.

You can test it by hacking a wrong timebase frequency in and seeing what
the calculation does.

Or do something like this:

	if (ns >= 10000)
		cycle = ((ns + 500) / 1000) * tb_ticks_per_usec;
	else
		cycle = div_u64((u64)ns * tb_ticks_per_usec, 1000);

...which can be tested just by varying ns.

> If later there will be more than 1GHZ platform at that time to add this support.

There almost certainly won't be timebases that run that fast, but divide
by zero is a rather nasty way of responding if such a thing does happen.

-Scott
