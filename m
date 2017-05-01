Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGsyc4zWjzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 May 2017 04:14:48 +1000 (AEST)
Message-ID: <1493662461.25397.29.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 01 May 2017 13:14:21 -0500
In-Reply-To: <b0129071-0b09-a357-d262-19cf335f8224@c-s.fr>
References: <20170309094204.ACF5567992@localhost.localdomain>
 <20170430064826.fags33gcyvpqigah@home.buserror.net>
 <b0129071-0b09-a357-d262-19cf335f8224@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: powerpc/8xx: Adding support of IRQ in MPC8xx GPIO
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-05-01 at 09:46 +0200, christophe leroy wrote:
> 
> Le 30/04/2017 à 08:48, Scott Wood a écrit :
> > On Thu, Mar 09, 2017 at 10:42:04AM +0100, Christophe Leroy wrote:
> > > 
> > > @@ -625,6 +641,14 @@ int cpm1_gpiochip_add16(struct device_node *np)
> > > 
> > >  	spin_lock_init(&cpm1_gc->lock);
> > > 
> > > +	if (!of_property_read_u16(np, "interrupts-mask", &mask)) {
> > > +		int i, j;
> > > +
> > > +		for (i = 0, j = 0; i < 16; i++)
> > > +			if (mask & (1 << (15 - i)))
> > > +				cpm1_gc->irq[i] =
> > > irq_of_parse_and_map(np, j++);
> > > +	}
> > 
> > Do we really need to use MSB-first bit numbering here?
> 
> Well, I think it is better to keep the GPIOs in the same order as in the 
> CPM1 registers, like everywhere else in that driver, isn't it ?
> 
> The registers have GPIO 0 in the MSB and GPIO15 in the LSB.

OK, if there's a specific register this is reflecting that's reasonable.

-Scott
