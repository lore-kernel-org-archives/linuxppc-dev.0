Return-Path: <pladow@gmail.com>
Received: from mail-la0-x233.google.com (mail-la0-x233.google.com
 [IPv6:2a00:1450:4010:c03::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5540A2C02F1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 08:16:40 +1000 (EST)
Received: by mail-la0-f51.google.com with SMTP id fq12so6254343lab.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 15:16:35 -0700 (PDT)
MIME-Version: 1.0
Sender: pladow@gmail.com
In-Reply-To: <1373492413.19894.29.camel@pasglop>
References: <CAN8Q1EdnN9+kKGy+voF3=EyPfbHv04Emfz=uA6XKMJEAkvLpAA@mail.gmail.com>
 <CAN8Q1Ed9Lpg1Sog5tQODe+jqCRXBBH3d_UeR5usdc23CD7vwjg@mail.gmail.com>
 <1371945647.3944.106.camel@pasglop>
 <CAN8Q1EetHpVkWFmbDGCE-3J4H7oJm0zE66SAdJyvtDb7OBc-gg@mail.gmail.com>
 <1373492413.19894.29.camel@pasglop>
Date: Wed, 10 Jul 2013 15:16:34 -0700
Message-ID: <CAN8Q1EeR62=W_Uxz6MdFs9ZBFxZP_Kb1r2f=w9OnOvouF12Tfg@mail.gmail.com>
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

On Wed, Jul 10, 2013 at 2:40 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Well, it should work, ....

I tried forcing NET_IP_ALIGN to 0, and I did see the DMA accesses
align on 32-bit boundaries with all the byte enables set.  However,
the memory corruption still occurred.

> but it's possible that there is some subtle bug on this specific Freescale SoC....

I looked through the Freescale errata
(http://www.freescale.com/files/32bit/doc/errata/MPC8349ECE.pdf) and
only 2 seem relevant:  PCI19 and DMA2 (the rest are either fixed in
our core version 3.1).

PCI19:  When using a dual-address cycle for inbound write accesses
with then IOS is full, the PCI overwrites the address for the IOS with
the new address from the bus.

DMA2: There can be corruption of the DMA data.  Examples are DAHTS is
8 bytes and the source port is a 32-bit PCI bus or the source memory
space i son the PCI bus and is not prefetchable.

I don't think PCI19 applies since no dual-address cycles are
generated.  From what I've seen, all the DMA addresses in the RX ring
descriptors are in the lower 32-bit address space.

I don't think DMA2 applies because it is for the DMA controller
specific to the 8349.  And since these transactions are not setup or
managed by the DMA controller...  At least I don't think they are
(unless dma_alloc and dma_map_single do something related to this).
My understanding is that in this case the PCI inbound registers are
configured and the DMA controller is not used.

> ...Did you correlate the corruption with one such packet ?
>
> Did you get any traces that show the flow that happens around a case of
> corruption ?

Not yet.  I'm having a difficult time syncing the PCI trace with the
kernel debug output.  And since the corruption may be detected well
after the actual corruption occurs, determine which DMA transfer
caused a corruption is difficult.

I'm still trying to gather more information.

Thanks,
Pete
