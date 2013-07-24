Return-Path: <pladow@gmail.com>
Received: from mail-wi0-x230.google.com (mail-wi0-x230.google.com
 [IPv6:2a00:1450:400c:c05::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B44362C00C5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 14:22:25 +1000 (EST)
Received: by mail-wi0-f176.google.com with SMTP id ey16so3773522wid.15
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 21:22:18 -0700 (PDT)
MIME-Version: 1.0
Sender: pladow@gmail.com
In-Reply-To: <20130719134615.GR7080@book.gsilab.sittig.org>
References: <CAN8Q1EdnN9+kKGy+voF3=EyPfbHv04Emfz=uA6XKMJEAkvLpAA@mail.gmail.com>
 <CAN8Q1Ed9Lpg1Sog5tQODe+jqCRXBBH3d_UeR5usdc23CD7vwjg@mail.gmail.com>
 <1371945647.3944.106.camel@pasglop>
 <CAN8Q1EetHpVkWFmbDGCE-3J4H7oJm0zE66SAdJyvtDb7OBc-gg@mail.gmail.com>
 <1373492413.19894.29.camel@pasglop>
 <CAN8Q1EdVVw3ofg9O3o=WThsKpcfMBXe_C7JsSSx9DdRZULW17Q@mail.gmail.com>
 <CAN8Q1EeKCTCB30N50iA8-QB=0aoNtS1U3nNLGVoz7sHG-Qg26A@mail.gmail.com>
 <20130719134615.GR7080@book.gsilab.sittig.org>
Date: Tue, 23 Jul 2013 21:22:18 -0700
Message-ID: <CAN8Q1EeRWOD1ktGztsaY91VwDYTJmAgwo6XR2baQNb_f7p=FLA@mail.gmail.com>
Subject: Re: Inbound PCI and Memory Corruption
From: Peter LaDow <petela@gocougs.wsu.edu>
To: Peter LaDow <petela@gocougs.wsu.edu>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 19, 2013 at 6:46 AM, Gerhard Sittig <gsi@denx.de> wrote:
> So:  No, not having to fiddle with DMA stuff when doing PCI need
> not be a problem, it's actually expected.  But since a DMA engine
> might be involved (that's just not under your command), the
> accompanying problems may arise.  You may need to flush CPU
> provided data upon write before telling an external entity to
> access it, and may need to invalidate caches (to have data
> re-fetched) before the CPU accesses what an external entity did
> manipulate.  And this applies to both payload data as well as
> management data (descriptors) if the latter apply to the former.

This is something I've been exploring today.  But what is unclear is
_how_ to flush/invalidate the caches'.  I was going to tweak the
driver to setup the descriptors, flush the cache, then enable the
hardware (and when taking the device down, disable the hardware, flush
the cache, then deallocate the descriptors).  But this is in the
network code and it isn't obvious how to make this happen.

I think I figured something out.  Basically, in the receive interrupt,
prior to reading the data in the descriptor, I call
dma_sync_single_for_cpu().  Then the driver can continue to process
the data, then unmap the DMA region (with dma_unmap_single() ).  When
setting up the descriptors, after calling dma_map_single(),
configuring the descriptor, I then call dma_sync_single_for_device().
Does this look correct?

However, on the PPC platforms, these calls (dma_sync_*) are NOPs
unless CONFIG_NOT_COHERENT_CACHE is defined (which it doesn't appear
to be for the 8349).  So I tweaked the Kconfig to enable
CONFIG_NOT_COHERENT.  Things built ok, but I'm not sure if this is
sufficient to invoke the cache flush necessary.

Am I on the right track?

Thanks,
Pete
