Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zcthl3SrjzF0XX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 09:51:03 +1100 (AEDT)
Message-ID: <1518130243.2312.221.camel@kernel.crashing.org>
Subject: Re: [PATCH kernel] powerpc/pci: Fix broken INTx configuration via OF
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>, Rob
 Herring <robh@kernel.org>,
 Alistair Popple <alistair@popple.id.au>, linux-pci@vger.kernel.org
Date: Fri, 09 Feb 2018 09:50:43 +1100
In-Reply-To: <20180208224205.GA206223@bhelgaas-glaptop.roam.corp.google.com>
References: <20180208053354.41725-1-aik@ozlabs.ru>
 <CAErSpo7S7vJTKBrxuzH-G0y-U2Z15jKpPJDZEEuhh7vAs0hjOA@mail.gmail.com>
 <20180208213956.GC98765@bhelgaas-glaptop.roam.corp.google.com>
 <1518128503.2312.219.camel@kernel.crashing.org>
 <20180208224205.GA206223@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-02-08 at 16:42 -0600, Bjorn Helgaas wrote:
> On Fri, Feb 09, 2018 at 09:21:43AM +1100, Benjamin Herrenschmidt wrote:
> > On Thu, 2018-02-08 at 15:39 -0600, Bjorn Helgaas wrote:
> > > I don't understand how this fix works.  We used to check the result of
> > > of_irq_parse_and_map_pci() and entered the block if it was zero.
> > > 
> > > Now you enter the block if it is zero or less than zero, but:
> > > 
> > >   static int pci_read_irq_line(...)
> > >   {
> > >     unsigned int virq = 0;     /* unnecessarily initialized, BTW */
> > > 
> > >     virq = of_irq_parse_and_map_pci(pci_dev, 0, 0);
> > >     if (virq <= 0) {
> > >       ...
> > > 
> > > virq is unsigned, so "virq < 0" can never be true.  So how does this
> > > change anything?
> > 
> > Yes it does:
> > 
> > So the unsigned thing is a second bug in the original patch that Alexey
> > isn't fixing, we need to fix it too.
> > 
> > However, the actual bug Alexey is fixing is that we lost the actual
> > value of virq. IE, without his fix, we test it for 0 but we don't
> > actually return it if it's positive.
> 
> Ah, I see, the bug is that we discarded the non-zero virq value when
> we actually need it.  I'm going to wait for a new patch with a
> changelog that says that and doesn't test an unsigned value for < 0.
> 
> > So he fixes the normal case but there's still a bug in the error case,
> > we need to make virq signed.
> 
> I looked through the of_irq_parse_and_map_pci() path and I do not see
> a case where it can return a negative value.  It either returns zero
> or one of these:
> 
>   virq = irq_find_mapping(...)
>   virq = irq_create_mapping(...)
> 
> Both of these functions return unsigned values.

Ok so the test is just wrong then. Aleey, can you respin ?

Cheers,
Ben.
