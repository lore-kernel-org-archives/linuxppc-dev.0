Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 3A084DDEE2
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 16:33:18 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 25 Apr 2007 23:33:16 -0700
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/13] powerpc: Add arch/powerpc mv64x60 PCI setup
Message-ID: <20070426063315.GE2030@xyzzy.farnsworth.org>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070426000107.GL4046@mag.az.mvista.com>
	<200704260225.27740.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200704260225.27740.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 26, 2007 at 12:25:27AM +0000, Arnd Bergmann wrote:
> On Thursday 26 April 2007, Mark A. Greer wrote:
> > +void __init mv64x60_pci_init(void)
> > +{
> > +	struct device_node *np = NULL;
> > +
> > +	ppc_md.pci_exclude_device = mv64x60_exclude_device;
> > +
> > +	while ((np = of_find_compatible_node(np, "pci", "mv64x60-pci")))
> > +		mv64x60_add_bridge(np);
> > +}
> 
> This is a similar mistake to the previous two, but somewhat different:
> 
> You actually duplicate code that is already present in of_platform.c.
> AFAICS, all you should need to do is implement the ppc_md.pci_setup_phb()
> function instead of your own handmade device tree scanning.

I find this comment in of_platform.c troubling:
> /* The probing of PCI controllers from of_platform is currently
>  * 64 bits only, mostly due to gratuitous differences between
>  * the 32 and 64 bits PCI code on PowerPC and the 32 bits one
>  * lacking some bits needed here.
>  */

Is this comment incorrect?

I agree that this is more code duplication than I like, and we could
benefit from some refactoring.  However, I find 15 other places in
arch/powerpc that largely duplicate this pci initialization code.
That doesn't make a 16th right, but at least I'm in good company. :)

-Dale
