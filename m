Return-Path: <pladow@gmail.com>
Received: from mail-la0-x230.google.com (mail-la0-x230.google.com
 [IPv6:2a00:1450:4010:c03::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4815E2C007B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 01:39:09 +1000 (EST)
Received: by mail-la0-f48.google.com with SMTP id hi8so444259lab.21
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 08:39:02 -0700 (PDT)
MIME-Version: 1.0
Sender: pladow@gmail.com
In-Reply-To: <1374640044.3916.109.camel@pasglop>
References: <CAN8Q1EdnN9+kKGy+voF3=EyPfbHv04Emfz=uA6XKMJEAkvLpAA@mail.gmail.com>
 <CAN8Q1Ed9Lpg1Sog5tQODe+jqCRXBBH3d_UeR5usdc23CD7vwjg@mail.gmail.com>
 <1371945647.3944.106.camel@pasglop>
 <CAN8Q1EetHpVkWFmbDGCE-3J4H7oJm0zE66SAdJyvtDb7OBc-gg@mail.gmail.com>
 <1373492413.19894.29.camel@pasglop>
 <CAN8Q1EdVVw3ofg9O3o=WThsKpcfMBXe_C7JsSSx9DdRZULW17Q@mail.gmail.com>
 <CAN8Q1EeKCTCB30N50iA8-QB=0aoNtS1U3nNLGVoz7sHG-Qg26A@mail.gmail.com>
 <20130719134615.GR7080@book.gsilab.sittig.org>
 <CAN8Q1EeRWOD1ktGztsaY91VwDYTJmAgwo6XR2baQNb_f7p=FLA@mail.gmail.com>
 <1374640044.3916.109.camel@pasglop>
Date: Wed, 24 Jul 2013 08:39:02 -0700
Message-ID: <CAN8Q1EdAA6ZfYSdTJ6ieZxjuqTF7Cr9Bt6fo2qejbtXoZ=ce6g@mail.gmail.com>
Subject: Re: Inbound PCI and Memory Corruption
From: Peter LaDow <petela@gocougs.wsu.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 23, 2013 at 9:27 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> CONFIG_NOT_COHERENT_CACHE will do it for you (in
> arch/powerpc/kernel/dma.c) provided the driver does the right things vs.
> the DMA accessors but afaik e1000 does.

Well, when I went to make the changes I noted a few things.  First,
the e1000 driver does a dma_unmap_single() prior to processing the
descriptor.  So it would seem that the dma_sync_single_for_cpu() isn't
necessary in that case.  And when allocating descriptors, it does
dma_map_single() after setting up the descriptor, so
dma_sync_single_for_device() probably isn't necessary either.

But regardless, I put in the dma_sync_single_* calls and we still get
the same behavior.  So, even with CONFIG_NOT_COHERENT_CACHE we are
getting this error.

> If that helps, that might hint at either a missing barrier or some kind
> of HW (or HW configuration) bug with cache coherency.

And unfortunately it didn't help.  We have a few other things we are
trying, but I'm not hopeful that any will change the behavior.

A bit of history that may help.  We were using an e100 (an 82559)
part, but Intel EOL'd that part so we picked up the 82540EP (which
they have also recently EOL'd).  The e100 driver uses a different DMA
model.  It uses pci_map_single/pci_unmap_single along with
pci_dma_sync_single_for* calls (as well as other PCI calls).  The
e1000 driver, however, does not use the pci_* calls.  We have never
had a problem with the e100 parts.  I don't suppose the use of
pci_map_* vs dma_map_* makes a difference does it?

Thanks,
Pete
