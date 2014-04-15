Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0187.outbound.protection.outlook.com [207.46.163.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 93BA21400D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Apr 2014 07:06:14 +1000 (EST)
Message-ID: <1397595963.20280.279.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/2] fsl/mpic_timer: make mpic_timer to support deep
 sleep feature
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <Dongsheng.Wang@freescale.com>
Date: Tue, 15 Apr 2014 16:06:03 -0500
In-Reply-To: <b1be56f51f4c4985af837685450f4eb2@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1397442250-14886-1-git-send-email-dongsheng.wang@freescale.com>
 <1397442250-14886-2-git-send-email-dongsheng.wang@freescale.com>
 <1397518552.20280.235.camel@snotra.buserror.net>
 <b1be56f51f4c4985af837685450f4eb2@BN1PR03MB188.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui-B35336 <chenhui.zhao@freescale.com>,
 Jin Zhengxiong-R64188 <Jason.Jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-04-14 at 22:23 -0500, Wang Dongsheng-B40534 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, April 15, 2014 7:36 AM
> > To: Wang Dongsheng-B40534
> > Cc: Jin Zhengxiong-R64188; Li Yang-Leo-R58472; Zhao Chenhui-B35336; linuxppc-
> > dev@lists.ozlabs.org
> > Subject: Re: [PATCH 2/2] fsl/mpic_timer: make mpic_timer to support deep sleep
> > feature
> > 
> > On Mon, 2014-04-14 at 10:24 +0800, Dongsheng Wang wrote:
> > > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > >
> > > At T104x platfrom the timer clock will be changed when system going to
> > > deep sleep.
> > 
> > Could you elaborate on what is changing and why?
> > 
> 
> Okay.
> 
> > > +#include <asm/mpc85xx.h>
> > >  #include <asm/mpic_timer.h>
> > 
> > So much for, "The driver currently is only tested on fsl chip, but it can
> > potentially support other global timers complying to OpenPIC standard."
> > 
> > >  #define FSL_GLOBAL_TIMER		0x1
> > > @@ -71,8 +74,10 @@ struct timer_group_priv {
> > >  	struct timer_regs __iomem	*regs;
> > >  	struct mpic_timer		timer[TIMERS_PER_GROUP];
> > >  	struct list_head		node;
> > > +	unsigned long			idle;
> > >  	unsigned int			timerfreq;
> > > -	unsigned int			idle;
> > 
> > Why?
> > 
> 
> Um... It shouldn't be happened...i will remove this.
> 
> > > +	unsigned int			suspended_timerfreq;
> > > +	unsigned int			resume_timerfreq;
> > >  	unsigned int			flags;
> > >  	spinlock_t			lock;
> > >  	void __iomem			*group_tcr;
> > > @@ -88,6 +93,7 @@ static struct cascade_priv cascade_timer[] = {  };
> > >
> > >  static LIST_HEAD(timer_group_list);
> > > +static int switch_freq_flag;
> > 
> > Needs documentation, and based on "_flag" it should probably be a bool.
> > 
> 
> Okay.
> 
> > >  static void convert_ticks_to_time(struct timer_group_priv *priv,
> > >  		const u64 ticks, struct timeval *time) @@ -423,6 +429,33 @@ struct
> > > mpic_timer *mpic_request_timer(irq_handler_t fn, void *dev,  }
> > > EXPORT_SYMBOL(mpic_request_timer);
> > >
> > > +static void timer_group_get_suspended_freq(struct timer_group_priv
> > > +*priv) {
> > > +	struct device_node *np;
> > > +
> > > +	np = of_find_compatible_node(NULL, NULL, "fsl,qoriq-clockgen-2.0");
> > > +	if (!np) {
> > > +		pr_err("mpic timer: Missing clockgen device node.\n");
> > 
> > Why is it an error to not have a 2.0 QorIQ clockgen?
> > 
> 
> This will affect the accuracy of the timer. But not means the timer cannot work.
> Maybe you are right, this pr_err should be a pr_warn.

What I mean is, what if the mpic timer driver is used with deep sleep on
a different chip such as mpc8536?

> > > +		return;
> > > +	}
> > > +
> > > +	of_property_read_u32(np, "clock-frequency", &priv->suspended_timerfreq);
> > > +	of_node_put(np);
> > 
> > Shouldn't this go through the clock API?
> > 
> 
> Sorry, I'm not clear about clock API, you mean fsl_get_sys_freq()? Or ?

No, I mean drivers/clk/

Though I suppose manually reading clock-frequency is OK, as the
clock-frequency on the clockgen node predated the introduction of clock
bindings to the device tree.

Don't use fsl_get_sys_freq().

> The timer operates on sys_ref_clk frequency during deep sleep. And The timer runs on
> platform clock/2 during normal operation.

Sigh...  I wish hardware people would consult us before doing screwy
things like this.  If the platform clock is unavailable in deep sleep
(Can that really be true?  Surely there are other wakeup sources that
need it), why not run it at sys_ref_clk all the time?

Where is this documented?

> > > +static int need_to_switch_freq(void)
> > > +{
> > > +	u32 svr;
> > > +
> > > +	svr = mfspr(SPRN_SVR);
> > > +	if (SVR_SOC_VER(svr) == SVR_T1040 ||
> > > +			SVR_SOC_VER(svr) == SVR_T1042)
> > > +		return 1;
> > 
> > Explain why this is specific to T104x.
> > 
> 
> Mpic timer freq will be change when system going to deep sleep. So we need to recalculate the time.

Do any other chips with deep sleep have this problem?

-Scott
