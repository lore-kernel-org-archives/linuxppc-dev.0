Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zct3F3NtpzF18r
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 09:22:01 +1100 (AEDT)
Message-ID: <1518128503.2312.219.camel@kernel.crashing.org>
Subject: Re: [PATCH kernel] powerpc/pci: Fix broken INTx configuration via OF
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@ozlabs.org>, Rob Herring <robh@kernel.org>, Alistair
 Popple <alistair@popple.id.au>, linux-pci@vger.kernel.org
Date: Fri, 09 Feb 2018 09:21:43 +1100
In-Reply-To: <20180208213956.GC98765@bhelgaas-glaptop.roam.corp.google.com>
References: <20180208053354.41725-1-aik@ozlabs.ru>
 <CAErSpo7S7vJTKBrxuzH-G0y-U2Z15jKpPJDZEEuhh7vAs0hjOA@mail.gmail.com>
 <20180208213956.GC98765@bhelgaas-glaptop.roam.corp.google.com>
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

On Thu, 2018-02-08 at 15:39 -0600, Bjorn Helgaas wrote:
> I don't understand how this fix works.  We used to check the result of
> of_irq_parse_and_map_pci() and entered the block if it was zero.
> 
> Now you enter the block if it is zero or less than zero, but:
> 
>   static int pci_read_irq_line(...)
>   {
>     unsigned int virq = 0;     /* unnecessarily initialized, BTW */
> 
>     virq = of_irq_parse_and_map_pci(pci_dev, 0, 0);
>     if (virq <= 0) {
>       ...
> 
> virq is unsigned, so "virq < 0" can never be true.  So how does this
> change anything?

Yes it does:

So the unsigned thing is a second bug in the original patch that Alexey
isn't fixing, we need to fix it too.

However, the actual bug Alexey is fixing is that we lost the actual
value of virq. IE, without his fix, we test it for 0 but we don't
actually return it if it's positive.

So he fixes the normal case but there's still a bug in the error case,
we need to make virq signed.

Cheers,
Ben.
