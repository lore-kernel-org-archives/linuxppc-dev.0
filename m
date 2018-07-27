Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ck7X0TJtzF0kx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 08:25:43 +1000 (AEST)
Date: Fri, 27 Jul 2018 17:25:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Hari Vyas <hari.vyas@broadcom.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, ray.jui@broadcom.com,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] PCI: Data corruption happening due to race condition
Message-ID: <20180727222540.GH173328@bhelgaas-glaptop.roam.corp.google.com>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
 <1530608741-30664-2-git-send-email-hari.vyas@broadcom.com>
 <20180718232904.GJ128988@bhelgaas-glaptop.roam.corp.google.com>
 <65dd986d0b8b2ebe5132b365dabb2dbaaed9177f.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <65dd986d0b8b2ebe5132b365dabb2dbaaed9177f.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 19, 2018 at 02:18:09PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2018-07-18 at 18:29 -0500, Bjorn Helgaas wrote:
> > [+cc Paul, Michael, linuxppc-dev]
> > 
> 
>    ..../...
> 
> > > Debugging revealed a race condition between pcie core driver
> > > enabling is_added bit(pci_bus_add_device()) and nvme driver
> > > reset work-queue enabling is_busmaster bit (by pci_set_master()).
> > > As both fields are not handled in atomic manner and that clears
> > > is_added bit.
> > > 
> > > Fix moves device addition is_added bit to separate private flag
> > > variable and use different atomic functions to set and retrieve
> > > device addition state. As is_added shares different memory
> > > location so race condition is avoided.
> > 
> > Really nice bit of debugging!
> 
> Indeed. However I'm not fan of the solution. Shouldn't we instead have
> some locking for the content of pci_dev ? I've always been wary of us
> having other similar races in there.
> 
> As for the powerpc bits, I'm probably the one who wrote them, however,
> I'm on vacation this week and right now, no bandwidth to context switch
> all that back in :-) So give me a few days and/or ping me next week.

OK, here's a ping :)

Some powerpc cleanup would be ideal, but I'd like to fix the race for
v4.19, so I'm fine with this patch as-is.  But I'd definitely want
your ack before inserting the ugly #include path in the powerpc code.

> The powerpc PCI code contains a lot of cruft coming from the depth of
> history, including rather nasty assumptions. We want to progressively
> clean it up, starting with EEH, but it will take time.
> 
> Cheers,
> Ben.
> 
> > > Signed-off-by: Hari Vyas <hari.vyas@broadcom.com>
> > > ---
> > >  arch/powerpc/kernel/pci-common.c          |  4 +++-
> > >  arch/powerpc/platforms/powernv/pci-ioda.c |  3 ++-
> > >  arch/powerpc/platforms/pseries/setup.c    |  3 ++-
> > >  drivers/pci/bus.c                         |  6 +++---
> > >  drivers/pci/hotplug/acpiphp_glue.c        |  2 +-
> > >  drivers/pci/pci.h                         | 11 +++++++++++
> > >  drivers/pci/probe.c                       |  4 ++--
> > >  drivers/pci/remove.c                      |  5 +++--
> > >  include/linux/pci.h                       |  1 -
> > >  9 files changed, 27 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> > > index fe9733f..471aac3 100644
> > > --- a/arch/powerpc/kernel/pci-common.c
> > > +++ b/arch/powerpc/kernel/pci-common.c
> > > @@ -42,6 +42,8 @@
> > >  #include <asm/ppc-pci.h>
> > >  #include <asm/eeh.h>
> > >  
> > > +#include "../../../drivers/pci/pci.h"
> > 
> > I see why you need it, but this include path is really ugly.  Outside
> > of bootloaders and tools, there are very few instances of includes
> > like this that reference a different top-level directory, and I'm not
> > very keen about adding more.
