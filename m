Return-Path: <jason@lakedaemon.net>
Received: from pmta2.delivery5.ore.mailhop.org
 (pmta2.delivery5.ore.mailhop.org [54.186.218.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkQCQ6JHzzDqps
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 23:46:26 +1000 (AEST)
Date: Tue, 5 Jul 2016 13:45:20 +0000
From: Jason Cooper <jason@lakedaemon.net>
To: Qiang Zhao <qiang.zhao@nxp.com>
Cc: "oss@buserror.net" <oss@buserror.net>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Xiaobo Xie <xiaobo.xie@nxp.com>
Subject: Re: [PATCH 2/2] qe/ic: refactor qe_ic to simplify
Message-ID: <20160705134520.GC3348@io.lakedaemon.net>
References: <1467683219-29326-1-git-send-email-qiang.zhao@nxp.com>
 <1467683219-29326-2-git-send-email-qiang.zhao@nxp.com>
 <20160705035100.GB3348@io.lakedaemon.net>
 <AM3PR04MB1185882FDBB659CD433F9EBB91390@AM3PR04MB1185.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AM3PR04MB1185882FDBB659CD433F9EBB91390@AM3PR04MB1185.eurprd04.prod.outlook.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Morning!

On Tue, Jul 05, 2016 at 07:38:49AM +0000, Qiang Zhao wrote:
> On 07/05/2016 11:51 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> > On Tue, Jul 05, 2016 at 09:46:59AM +0800, Zhao Qiang wrote:
...
> > >
> > > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> > > ---
> > >  drivers/irqchip/qe_ic.c    | 83 +++++++++++++++++++++++++------------------
> > ---
> > >  include/soc/fsl/qe/qe_ic.h |  7 ----
> > >  2 files changed, 45 insertions(+), 45 deletions(-)
> > >
> > > diff --git a/drivers/irqchip/qe_ic.c b/drivers/irqchip/qe_ic.c index
> > > f7f9a81..46652c0 100644
> > > --- a/drivers/irqchip/qe_ic.c
> > > +++ b/drivers/irqchip/qe_ic.c
...
> > > -	printk(KERN_DEBUG "Registering qe_ic with sysfs...\n");
> > > +	ret = qe_ic_init(0);
> > 
> > Sorry, build machine is down atm.  How was qe_ic_init() called previously?  Is
> > that removed?
> 
> Sorry, I don't understand, could you please explain?

-ENOSLEEP when I wrote that.  :)  *My* build machine, with my copies of
the kernel tree was down, so I had no easy way to dig into the source.

And ....

> > > -static int __init qeic_of_init(void)
> > > -{
> > > -	struct device_node *np;
> > > -
> > > -	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> > > -	if (np) {
> > > -		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
> > > -			   qe_ic_cascade_high_mpic);
> > > -		of_node_put(np);
> > > -	}
> > >  	return 0;
> > >  }
> > >
> > > -subsys_initcall(qeic_of_init);

this block is what I missed last night. :-/  Sorry for the noise.

thx,

Jason.
