Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 9802BB7CE2
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 18:53:28 +1100 (EST)
Date: Tue, 26 Jan 2010 08:53:20 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 03/11] powerpc/mpc5121: Add machine restart support
Message-ID: <20100126085320.29126050@wker>
In-Reply-To: <20100120112843.GE5041@pengutronix.de>
References: <1263932653-3634-1-git-send-email-agust@denx.de>
	<1263932653-3634-4-git-send-email-agust@denx.de>
	<20100120112843.GE5041@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de,
	Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 20 Jan 2010 12:28:43 +0100
Wolfram Sang <w.sang@pengutronix.de> wrote:

> > +static void __iomem *reset_module_base;
> 
> type here also?

Ok.

> > +
> > +static int __init mpc512x_restart_init(void)
> > +{
> > +	struct device_node *np;
> > +
> > +	np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-reset");
> > +	if (!np)
> > +		return -1;
> > +
> > +	reset_module_base = of_iomap(np, 0);
> > +	of_node_put(np);
> > +
> > +	return 0;
> > +}
> > +
> 
> Drop this empty line?

Ok.

> > +	} else {
> > +		printk(KERN_ERR ": Restart module not mapped.\n");
> 
> The colon is a leftover?

Yes, will fix for using pr_error() and resubmit.

Thanks,
Anatolij
