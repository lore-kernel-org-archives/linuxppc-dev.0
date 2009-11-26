Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3E5E11007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 08:12:33 +1100 (EST)
Subject: Re: [RFC PATCH 11/19] powerpc: gamecube/wii: flipper interrupt
	controller support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <4B0E9FBC.1090900@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221528y1980a95bw1dc8aa75a86c061e@mail.gmail.com>
	<1259212736.16367.271.camel@pasglop>  <4B0E9FBC.1090900@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 27 Nov 2009 08:12:28 +1100
Message-ID: <1259269948.18084.26.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-11-26 at 16:33 +0100, Albert Herranz wrote:
> Benjamin Herrenschmidt wrote:
> > On Sun, 2009-11-22 at 16:28 -0700, Grant Likely wrote:
> >>> +unsigned int flipper_pic_get_irq(void)
> >>> +{
> >>> +       void __iomem *io_base = flipper_irq_host->host_data;
> >>> +       int irq;
> >>> +       u32 irq_status;
> >>> +
> >>> +       irq_status = in_be32(io_base + FLIPPER_ICR) &
> >>> +                    in_be32(io_base + FLIPPER_IMR);
> >>> +       if (irq_status == 0)
> >>> +               return -1;      /* no more IRQs pending */
> >> NO_IRQ_IGNORE 
> > 
> > Why no just 0 ? (aka NO_IRQ)
> > 
> 
> I didn't know about 0 (I thought that was another valid interrupt).

0 is a valid hw number. It's not a valid linux "virq" number. In fact,
that's part of the reason why we generalized the whole virq thingy :-)
Because back then, Linus made the statement that 0 should never be a
valid IRQ number in linux. That also allowed us to make sure that 1..15
are never allocated to anything but a legacy 8259 to avoid all sorts of
problems with crackpot legacy x86 originated drivers who hard coded some
of these interrupts.

> I was used to -1 to tell that no IRQs were pending (at least from the
> ARCH=ppc days) :)

Yup, we changed that :-)

> > Or do you know you are getting lots of spurrious that you don't want to
> > account ?
> > 
> 
> No, this is not the case here.

Cheers,
Ben.

> > Cheers,
> > Ben.
> > 
> 
> Thanks,
> Albert
