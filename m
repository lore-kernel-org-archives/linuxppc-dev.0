Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C307EB6F71
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 02:38:27 +1100 (EST)
Received: from mail157-ch1 (localhost.localdomain [127.0.0.1])	by
 mail157-ch1-R.bigfish.com (Postfix) with ESMTP id 4E8AFC802A2	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 15:38:11 +0000 (UTC)
Received: from CH1EHSMHS027.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.254])	by mail157-ch1.bigfish.com (Postfix) with ESMTP id
 171671580051	for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 15:38:09
 +0000 (UTC)
Date: Wed, 9 Nov 2011 09:38:13 -0600
From: Scott Wood <scottwood@freescale.com>
To: Zang Roy-R61911 <r61911@freescale.com>
Subject: Re: [PATCH] powerpc/p1023: set IRQ[4:6, 11] to high level sensitive
 for PCIe
Message-ID: <20111109153813.GA7839@schlenkerla.am.freescale.net>
References: <1320654778-3294-1-git-send-email-tie-fei.zang@freescale.com>
 <4EB826F1.50402@freescale.com>
 <2239AC579C7D3646A720227A37E0268120D5C5@039-SN1MPN1-004.039d.mgd.msft.net>
 <4EB95EBC.8010808@freescale.com>
 <2239AC579C7D3646A720227A37E0268120EC83@039-SN1MPN1-004.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <2239AC579C7D3646A720227A37E0268120EC83@039-SN1MPN1-004.039d.mgd.msft.net>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 09, 2011 at 09:27:02AM -0600, Zang Roy-R61911 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, November 09, 2011 0:54 AM
> > To: Zang Roy-R61911
> > Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH] powerpc/p1023: set IRQ[4:6, 11] to high level sensitive for
> > PCIe
> > 
> > Just a note that there's magic to allow the PCIe block to output these
> > interrupts as either active-high or active-low, depending on how they're
> > configured at the mpic.
> I do not think there is any magic.
> On the contrary, it is the mpic/device tree needs to comply with the hardware setting for the interrupt polarity.

The magic is that the PCIe block can generate the interrupt in either
polarity depending on the MPIC setting (or perhaps it bases it on
sampling the pin status during/after reset, but that seems fragile).

> > > IRQ 4,5,6, 11 are internally tie to low by silicon. To use these interrupts
> > for PCIe, they need to set high level sensitive.
> > > It is clear enough for this patch.
> > 
> > It's odd enough that I felt the need to go reading through the docs to
> > see why such a thing would work at all.
> If you consider the normal case, the shared irq pulls up, the PCIe interrupt set to low level sensitive. Anything odd?

The oddity is that active-high works at all for a PCI interrupt, and that
not all the PCIe interrupts have the same polarity.

-Scott
