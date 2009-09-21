Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id ED46FB70B3
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2009 08:56:14 +1000 (EST)
Date: Tue, 22 Sep 2009 02:56:12 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [V1] USB: Add support for Xilinx USB host controller
Message-ID: <20090921225612.GA32278@oksana.dev.rtsoft.ru>
References: <20090921193821.CB9DF1620046@mail78-sin.bigfish.com>
	<1253566180.7103.147.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1253566180.7103.147.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Julie Zhu <julie.zhu@xilinx.com>,
	linux-usb@vger.kernel.org, john.linn@xilinx.com, greg@kroah.com
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 22, 2009 at 06:49:40AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2009-09-21 at 13:38 -0600, Julie Zhu wrote:
> 
> > +	iounmap(hcd->regs);
> > +err_ioremap:
> > +	irq_dispose_mapping(irq);
> 
> You missed that one too :-)
> 
> I'm actually considering making irq_dispose_mapping() a private
> API and rename it to something like __irq_dispose_mapping() :-)

I.e. turning irq_dispose_mapping() into nop, and __-prefixed
(private) variant would actually dispose irq mapping?

The nop part is important, because otherwise having no cleanup
variant of an allocation/mapping routine feels odd and might raise
questions by non-ppc people (e.g. subsystem maintainers when they
see no cleanup path for such a call).

And if we'll want to refcount irq mappings in the future, some
drivers will be ready without modifications, i.e. the ones that
got irq_dispose_mapping() wrong:

$ git grep irq_dispose drivers/ | wc -l
42

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
