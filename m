Return-Path: <lethal@linux-sh.org>
Received: from mx.gate01.com (mta23.gyao.ne.jp [125.63.38.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9B16DDE21D
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 04:55:36 +1100 (EST)
Date: Sat, 11 Oct 2008 02:55:17 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Message-ID: <20081010175516.GD10579@linux-sh.org>
References: <20081006172653.GA26427@oksana.dev.rtsoft.ru>
	<48EA77EF.6080502@genesi-usa.com>
	<20081006213209.GA13072@oksana.dev.rtsoft.ru>
	<48EABBD3.1010401@kernel.org>
	<20081007103723.0224671e@lxorguk.ukuu.org.uk>
	<1223455254.3145.143.camel@macbook.infradead.org>
	<20081008100025.1c535401@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.64.0810081159240.24611@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0810081159240.24611@vixen.sonytel.be>
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Li Yang <leoli@freescale.com>,
	David Woodhouse <dwmw2@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Wang Jian <lark@linux.net.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 08, 2008 at 11:59:59AM +0200, Geert Uytterhoeven wrote:
> On Wed, 8 Oct 2008, Alan Cox wrote:
> > On Wed, 08 Oct 2008 09:40:54 +0100
> > David Woodhouse <dwmw2@infradead.org> wrote:
> > 
> > > On Tue, 2008-10-07 at 10:37 +0100, Alan Cox wrote:
> > > > Zero means no IRQ. Any platform with bits of code left over exposing IRQ
> > > > 0 is already not supported by lots of driver code including libata.
> > > 
> > > ...and must implement some kind of interrupt remapping crap just to work
> > > around this bogus design decision.
> > 
> > I'll leave you to argue with Linus about that, but since that was the
> > decision back in 2005 (for good C reasons) we can safely rely on it.
> 
> `git grep NO_IRQ include arch/*/include' is still quite enlightening...
> 
In the case of PCI where IRQ is unsigned int, that's certainly bogus. The
problem originates on platforms where a 1:1 mapping between vector and
IRQ exists, where 0 is a valid value. This then needs to be remapped in
to an IRQ cookie that has a non-0 value in order to be assigned to
dev->irq. Despite whether this is bogus or not, there's not much to be
done about it. Those of us with vectored IRQ platforms generally have
enough sources that the use of IRQ-0 doesn't matter, and it's not worth
the headache of setting up the remapping crap.

As an example, on SH, IRQ-0 is mapped to vector 0x200. It is '0' for
symbolic reasons only. It's just as easy to pad out irq_desc and treat it
as an off-by-1 to work around all of code that assumes NO_IRQ == 0. There
is enough code in the kernel today that makes the non-zero IRQ cookie
assumption that platforms that do otherwise are simply broken.
