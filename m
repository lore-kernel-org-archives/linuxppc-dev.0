Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C4DAA2C008C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2013 23:46:25 +1000 (EST)
Date: Fri, 19 Jul 2013 15:46:15 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Peter LaDow <petela@gocougs.wsu.edu>
Subject: Re: Inbound PCI and Memory Corruption
Message-ID: <20130719134615.GR7080@book.gsilab.sittig.org>
References: <CAN8Q1EdnN9+kKGy+voF3=EyPfbHv04Emfz=uA6XKMJEAkvLpAA@mail.gmail.com>
 <CAN8Q1Ed9Lpg1Sog5tQODe+jqCRXBBH3d_UeR5usdc23CD7vwjg@mail.gmail.com>
 <1371945647.3944.106.camel@pasglop>
 <CAN8Q1EetHpVkWFmbDGCE-3J4H7oJm0zE66SAdJyvtDb7OBc-gg@mail.gmail.com>
 <1373492413.19894.29.camel@pasglop>
 <CAN8Q1EdVVw3ofg9O3o=WThsKpcfMBXe_C7JsSSx9DdRZULW17Q@mail.gmail.com>
 <CAN8Q1EeKCTCB30N50iA8-QB=0aoNtS1U3nNLGVoz7sHG-Qg26A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAN8Q1EeKCTCB30N50iA8-QB=0aoNtS1U3nNLGVoz7sHG-Qg26A@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 18, 2013 at 14:30 -0700, Peter LaDow wrote:
> 
> We are still stumped on this one, but during a review of the system
> setup one thing came up that we aren't sure about is the device tree
> and the DMA engine.
> 
> It does seem that for incoming PCI transactions the Freescale DMA
> engine is not used.  And in our device tree we have the DMA engine
> commented out.  That is, the "fsl,mpc8349-dma" and "fsl,elo-dma"
> compatible items are not present in the FDT.
> 
> I don't suppose this could be a problem?

Can't tell whether it helps or whether I'm telling you what's
already known, but here we go:

Some Freescale SoC's don't have "_the_ DMA", but instead several
of them.  Many peripherals have a DMA engine of their own, which
you won't notice as a separate entity from the software POV
(typically ethernet, USB, PCI, partially video in and out, even
coprocessor may have dedicated DMA engines which they might take
care of themselves).

The thing that you do see (in the device tree, as a software
controllable entity) is the "general purpose DMA" with user
servicable channels.  This one is may be used for serial
communication via UART or SPI, or SDHC/MMC, or peripherals
attached to the EMB.  Sometimes it's called "DMA2" to reflect
that there are others as well.

So:  No, not having to fiddle with DMA stuff when doing PCI need
not be a problem, it's actually expected.  But since a DMA engine
might be involved (that's just not under your command), the
accompanying problems may arise.  You may need to flush CPU
provided data upon write before telling an external entity to
access it, and may need to invalidate caches (to have data
re-fetched) before the CPU accesses what an external entity did
manipulate.  And this applies to both payload data as well as
management data (descriptors) if the latter apply to the former.

HTH


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
