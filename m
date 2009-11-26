Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 569EA1007DB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 16:19:03 +1100 (EST)
Subject: Re: [RFC PATCH 11/19] powerpc: gamecube/wii: flipper interrupt
	controller support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40911221528y1980a95bw1dc8aa75a86c061e@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Nov 2009 16:18:56 +1100
Message-ID: <1259212736.16367.271.camel@pasglop>
Mime-Version: 1.0
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2009-11-22 at 16:28 -0700, Grant Likely wrote:
> > +unsigned int flipper_pic_get_irq(void)
> > +{
> > +       void __iomem *io_base = flipper_irq_host->host_data;
> > +       int irq;
> > +       u32 irq_status;
> > +
> > +       irq_status = in_be32(io_base + FLIPPER_ICR) &
> > +                    in_be32(io_base + FLIPPER_IMR);
> > +       if (irq_status == 0)
> > +               return -1;      /* no more IRQs pending */
> 
> NO_IRQ_IGNORE 

Why no just 0 ? (aka NO_IRQ)

Or do you know you are getting lots of spurrious that you don't want to
account ?

Cheers,
Ben.
