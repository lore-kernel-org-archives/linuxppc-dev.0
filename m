Return-Path: <benh@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F034D2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 08:08:47 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Thu, 25 Jul 2013 19:04:01 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 006E83578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 08:08:44 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6OLrJM78389072
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 07:53:19 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r6OM8hi4004518
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 08:08:43 +1000
Message-ID: <1374703722.6142.5.camel@pasglop>
Subject: Re: Inbound PCI and Memory Corruption
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Peter LaDow <petela@gocougs.wsu.edu>
Date: Thu, 25 Jul 2013 08:08:42 +1000
In-Reply-To: <CAN8Q1EdAA6ZfYSdTJ6ieZxjuqTF7Cr9Bt6fo2qejbtXoZ=ce6g@mail.gmail.com>
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
 <CAN8Q1EdAA6ZfYSdTJ6ieZxjuqTF7Cr9Bt6fo2qejbtXoZ=ce6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-07-24 at 08:39 -0700, Peter LaDow wrote:
> A bit of history that may help.  We were using an e100 (an 82559)
> part, but Intel EOL'd that part so we picked up the 82540EP (which
> they have also recently EOL'd).  The e100 driver uses a different DMA
> model.  It uses pci_map_single/pci_unmap_single along with
> pci_dma_sync_single_for* calls (as well as other PCI calls).  The
> e1000 driver, however, does not use the pci_* calls.  We have never
> had a problem with the e100 parts.  I don't suppose the use of
> pci_map_* vs dma_map_* makes a difference does it?

No, they resolve to the same thing under the hood. Did you do other
changes ? Could it be another unrelated kernel bug causing something
like use-after-free of network buffer or similar oddity unrelated to the
network driver ?

Have you tried with different kernel versions ?

Cheers,
Ben.
