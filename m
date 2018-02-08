Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zcs6n2SnRzF18h
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 08:40:01 +1100 (AEDT)
Date: Thu, 8 Feb 2018 15:39:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@ozlabs.org>, Rob Herring <robh@kernel.org>,
 Alistair Popple <alistair@popple.id.au>, linux-pci@vger.kernel.org
Subject: Re: [PATCH kernel] powerpc/pci: Fix broken INTx configuration via OF
Message-ID: <20180208213956.GC98765@bhelgaas-glaptop.roam.corp.google.com>
References: <20180208053354.41725-1-aik@ozlabs.ru>
 <CAErSpo7S7vJTKBrxuzH-G0y-U2Z15jKpPJDZEEuhh7vAs0hjOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo7S7vJTKBrxuzH-G0y-U2Z15jKpPJDZEEuhh7vAs0hjOA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 08, 2018 at 01:20:04PM -0600, Bjorn Helgaas wrote:
> [+cc linux-pci]
> 
> The original commit was merged via PCI, and I think it's a good idea
> to merge fixes to it the same way.  I'll try to merge this in time for
> v4.16-rc1.
> 
> On Wed, Feb 7, 2018 at 11:33 PM, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > Commit 59f47eff03a0 ("powerpc/pci: Use of_irq_parse_and_map_pci() helper")
> > correctly states that of_irq_parse_and_map_pci() does the same thing as
> > of_irq_parse_pci() does as it simply calls
> > of_irq_parse_pci() and irq_create_of_mapping().
> >
> > However of_irq_parse_and_map_pci() not only returns 0 for success and
> > negative value for an error but also a positive virq value from
> > irq_create_of_mapping() which the mentioned commit ignores and
> > INTx config fails.
> >
> > This fixes the of_irq_parse_and_map_pci() return value handling.
> >
> > Fixes: 59f47eff03a0 "powerpc/pci: Use of_irq_parse_and_map_pci() helper"
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >
> > Found it on POWER9 + powernv system - almost all devices suddenly lost
> > INTx support.
> > ---
> >  arch/powerpc/kernel/pci-common.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> > index ae2ede4..acbb44f2 100644
> > --- a/arch/powerpc/kernel/pci-common.c
> > +++ b/arch/powerpc/kernel/pci-common.c
> > @@ -370,7 +370,8 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
> >         memset(&oirq, 0xff, sizeof(oirq));
> >  #endif
> >         /* Try to get a mapping from the device-tree */
> > -       if (!of_irq_parse_and_map_pci(pci_dev, 0, 0)) {
> > +       virq = of_irq_parse_and_map_pci(pci_dev, 0, 0);
> > +       if (virq <= 0) {

I don't understand how this fix works.  We used to check the result of
of_irq_parse_and_map_pci() and entered the block if it was zero.

Now you enter the block if it is zero or less than zero, but:

  static int pci_read_irq_line(...)
  {
    unsigned int virq = 0;     /* unnecessarily initialized, BTW */

    virq = of_irq_parse_and_map_pci(pci_dev, 0, 0);
    if (virq <= 0) {
      ...

virq is unsigned, so "virq < 0" can never be true.  So how does this
change anything?

Bjorn
