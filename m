Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 80E46DDDFA
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 00:29:17 +1100 (EST)
Date: Thu, 24 Jan 2008 16:29:01 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] MPC8360E-RDK: device tree,
	board file and defconfig
Message-ID: <20080124132900.GA25982@localhost.localdomain>
References: <20080123204507.GA12973@localhost.localdomain>
	<20080124132201.c3086756.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080124132201.c3086756.sfr@canb.auug.org.au>
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

On Thu, Jan 24, 2008 at 01:22:01PM +1100, Stephen Rothwell wrote:
> On Wed, 23 Jan 2008 23:45:07 +0300 Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> >
> > +++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
> > +static int __init mpc836x_rdk_declare_of_platform_devices(void)
> > +{
> > +	const struct of_device_id mpc836x_rdk_ids[] = {
> 
> Please change this to static, __initdata and not const, thanks. These
> arrays are usually defined outside a function, but that is not really a
> problem.

Pity... we don't need these _ids anywhere outside that function. But
looking into objdump output I see the problem now.

Will change this back, thanks.

> > +static void __init mpc836x_rdk_setup_arch(void)
> > +{
> > +	struct device_node *np;
> 
> !defined(CONFIG_PCI) && !defined(CONFIG_QUICC_ENGINE) will produce a
> warning here.

Good catch, thanks.

> > +	if (ppc_md.progress)
> > +		ppc_md.progress("mpc836x_rdk_setup_arch()", 0);
> > +
> > +#ifdef CONFIG_PCI
> > +	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
> > +		mpc83xx_add_bridge(np);
> > +#endif
> > +
> > +#ifdef CONFIG_QUICC_ENGINE
> > +	qe_reset();
> > +
> > +	np = of_find_compatible_node(NULL, NULL, "fsl,qe-pario");
> > +	if (!np) {
> > +		pr_warning("QE PIO not initialized!\n");
> > +		return;
> 
> You need an of_node_put(np) before the return.

Hm, really? I think I don't. But if you insist... :-)

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
