Return-Path: <mgreer@mvista.com>
Date: Thu, 25 Oct 2007 18:06:23 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/2] powerpc: prpmc2800 - Add MTD support
Message-ID: <20071026010623.GA12823@mag.az.mvista.com>
References: <20071025233948.GA22703@mag.az.mvista.com>
	<20071026102353.b837423b.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071026102353.b837423b.sfr@canb.auug.org.au>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 26, 2007 at 10:23:53AM +1000, Stephen Rothwell wrote:
> Hi Mark,
> 
> On Thu, 25 Oct 2007 16:39:48 -0700 "Mark A. Greer" <mgreer@mvista.com> wrote:
> >
> > +static int __init prpmc2800_register_mtd(void)
> > +{
> > +	struct device_node *np = NULL;
>                               ^^^^^^^
> Not needed if you use for_each_compatible_node().
> 
> > +
> > +	while ((np = of_find_compatible_node(np, NULL, "cfi-flash")) != NULL)
> 
> 	for_each_compatible_node(np, NULL, "cfi-flash")
> 
> > +		of_platform_device_create(np, NULL, NULL);
> > +
> > +	of_node_put(np);
> 
> Not needed as np must be NULL when you get here.

Ah, yes, true on all points.  Thanks Stephen.
Update coming shortly...

Mark
