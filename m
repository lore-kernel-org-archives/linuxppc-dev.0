Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2ED39B7B84
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2009 09:43:23 +1000 (EST)
Subject: Re: [PATCH] [V1] USB: Add support for Xilinx USB host controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090921225612.GA32278@oksana.dev.rtsoft.ru>
References: <20090921193821.CB9DF1620046@mail78-sin.bigfish.com>
	<1253566180.7103.147.camel@pasglop>
	<20090921225612.GA32278@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Tue, 22 Sep 2009 09:43:16 +1000
Message-Id: <1253576596.7103.166.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Julie Zhu <julie.zhu@xilinx.com>,
	linux-usb@vger.kernel.org, john.linn@xilinx.com, greg@kroah.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-09-22 at 02:56 +0400, Anton Vorontsov wrote:
> On Tue, Sep 22, 2009 at 06:49:40AM +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2009-09-21 at 13:38 -0600, Julie Zhu wrote:
> > 
> > > +	iounmap(hcd->regs);
> > > +err_ioremap:
> > > +	irq_dispose_mapping(irq);
> > 
> > You missed that one too :-)
> > 
> > I'm actually considering making irq_dispose_mapping() a private
> > API and rename it to something like __irq_dispose_mapping() :-)
> 
> I.e. turning irq_dispose_mapping() into nop, and __-prefixed
> (private) variant would actually dispose irq mapping?
> 
> The nop part is important, because otherwise having no cleanup
> variant of an allocation/mapping routine feels odd and might raise
> questions by non-ppc people (e.g. subsystem maintainers when they
> see no cleanup path for such a call).
> 
> And if we'll want to refcount irq mappings in the future, some
> drivers will be ready without modifications, i.e. the ones that
> got irq_dispose_mapping() wrong:

Yup. I agree. I'll look into it

Ben.
