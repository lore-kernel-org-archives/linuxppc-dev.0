Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1770FDDECF
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 04:16:25 +1100 (EST)
Date: Tue, 11 Dec 2007 20:19:35 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC][RFC] MPC8360E-RDK: Device tree and board file
Message-ID: <20071211171935.GA18003@localhost.localdomain>
References: <20071210202934.GA32046@localhost.localdomain>
	<20071211113027.bee17bc0.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071211113027.bee17bc0.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 11, 2007 at 11:30:27AM +1100, Stephen Rothwell wrote:
> On Mon, 10 Dec 2007 23:29:34 +0300 Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> >
> > +++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
> > +
> > +static void __init mpc836x_rdk_setup_arch(void)
> > +{
> > +	struct device_node *np;
> > +
> > +	if (ppc_md.progress)
> > +		ppc_md.progress("mpc836x_rdk_setup_arch()", 0);
> > +
> > +#ifdef CONFIG_QUICC_ENGINE
> > +	qe_reset();
> > +
> > +	np = of_find_node_by_name(NULL, "par_io");
> > +	if (np)
> > +		par_io_init(np);
> > +	else
> > +		pr_warning("QE PIO not initialized!\n");
> 
> of_node_put(np); ?
> 
> > +static int __init mpc836x_rdk_probe(void)
> > +{
> > +	unsigned long root = of_get_flat_dt_root();
> > +
> > +	return of_flat_dt_is_compatible(root, "MPC836xRDK");
> 
> You need to include asm/prom.h to use the flattened device tree accessors.

Will fix. Much thanks for looking into this.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
