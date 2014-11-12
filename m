Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B59AE1A0060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 10:09:13 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 164F7140082
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 10:09:12 +1100 (AEDT)
Message-ID: <1415833725.5124.53.camel@kernel.crashing.org>
Subject: Re: [PATCH]  of/base: Fix PowerPC address parsing hack
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 13 Nov 2014 10:08:45 +1100
In-Reply-To: <20141113091036.4e9ec43d@canb.auug.org.au>
References: <1415771461.5124.33.camel@kernel.crashing.org>
 <20141113091036.4e9ec43d@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Olof Johansson <olof@lixom.net>, Rob Herring <robherring2@gmail.com>,
 Grant Likely <grant.likely@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-11-13 at 09:10 +1100, Stephen Rothwell wrote:
> Hi Ben,
> 
> Urk!  :-)
> 
> How about:
> 
> On Wed, 12 Nov 2014 16:51:01 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index e371825..e37f017 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -7,6 +7,10 @@
> >  #include <linux/pci_regs.h>
> >  #include <linux/string.h>
> >  
> > +#ifdef CONFIG_PPC
> > +#include <asm/machdep.h>
> 
> #define IS_PMAC	machine_is(pmac)
> #else
> #define IS_PMAC	(0)

I'll just do an of machine compatible check instead, so there's no ifdef
at all, I'll send a new patch later today.

> > +#endif
> > +
> >  /* Max address size we deal with */
> >  #define OF_MAX_ADDR_CELLS	4
> >  #define OF_CHECK_ADDR_COUNT(na)	((na) > 0 && (na) <= OF_MAX_ADDR_CELLS)
> > @@ -428,12 +432,13 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
> >  	 * This code is only enabled on powerpc. --gcl
> >  	 */
> >  	ranges = of_get_property(parent, rprop, &rlen);
> > -#if !defined(CONFIG_PPC)
> > +#if defined(CONFIG_PPC)
> > +	if (!machine_is(powermac))
> > +#endif /* defined(CONFIG_PPC) */
> >  	if (ranges == NULL) {
> 
> if ((!IS_PMAC) && (ranges == NULL)) {
> 
> > -		pr_err("OF: no ranges; cannot translate\n");
> > +		pr_debug("OF: no ranges; cannot translate\n");
> >  		return 1;
> >  	}
> > -#endif /* !defined(CONFIG_PPC) */
> >  	if (ranges == NULL || rlen == 0) {
> >  		offset = of_read_number(addr, na);
> >  		memset(addr, 0, pna * 4);
> 
> There might be a better identifier than IS_PMAC ...
> 
