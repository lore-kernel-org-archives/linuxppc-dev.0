Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2752C2C030F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 07:40:22 +1000 (EST)
Message-ID: <1373492413.19894.29.camel@pasglop>
Subject: Re: Inbound PCI and Memory Corruption
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter LaDow <petela@gocougs.wsu.edu>
Date: Thu, 11 Jul 2013 07:40:13 +1000
In-Reply-To: <CAN8Q1EetHpVkWFmbDGCE-3J4H7oJm0zE66SAdJyvtDb7OBc-gg@mail.gmail.com>
References: <CAN8Q1EdnN9+kKGy+voF3=EyPfbHv04Emfz=uA6XKMJEAkvLpAA@mail.gmail.com>
 <CAN8Q1Ed9Lpg1Sog5tQODe+jqCRXBBH3d_UeR5usdc23CD7vwjg@mail.gmail.com>
 <1371945647.3944.106.camel@pasglop>
 <CAN8Q1EetHpVkWFmbDGCE-3J4H7oJm0zE66SAdJyvtDb7OBc-gg@mail.gmail.com>
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

On Wed, 2013-07-10 at 14:06 -0700, Peter LaDow wrote:
> I have a bit more information, but I'm not sure of the impact.  So far
> I have been dump lots of debugging output trying to determine where
> this memory corruption could be coming from.  I've sprinkled the
> driver with wmb() (near every DMA function and the hardware IO), loads
> of printk's to get the DMA addresses, and lots and lots of PCI traces.
>
> One things that I noticed is that the addresses programmed into the
> descriptor ring for the E1000 are not 32-bit aligned.  The E1000 part
> is aligning the transfers, and use the BE's to mask off bytes.  Is
> there an issue with the PPC (notably the MPC8349) with incoming PCI
> transactions that are 32-bit word aligned but write less than a full
> word?

Well, it should work, but it's possible that there is some subtle bug on
this specific Freescale SoC.... Did you correlate the corruption with
one such packet ?

Did you get any traces that show the flow that happens around a case of
corruption ?

Ben.

> In looking at the PCI trace, all the DMA's of packets from the E1000
> start at a 32-bit aligned address, but the first and last words are
> not full word writes.  For example (probably need a fixed font to
> view):
> 
> Command | Address  |  Data     | /BE
> Mem Wr  | 2950D180 |           |
>                      FFFF0000  | 0011
>                      FFFFFFFF  | 0000
>                      DBA24DF0  | 0000
>                      00085F19  | 0000
>                      24000024  | 0000
>                      0000C530  | 0000
>                      80D81180  | 0000
>                      F10DCA0A  | 0000
>                      FF0DCA0A  | 0000
>                      CF06CC06  | 0000
>                      A1BA1000  | 0000
>                      01400BC5  | 0000
>                      F1001000  | 0000
>                      00000000  | 0000
>                      00000000  | 0000
>                      68730000  | 0000
>                      00000F22  | 1100
> 
> Note that the first word is only a 16-bit transfer (in the upper half)
> and the last is only 16-bits (in the lower half).  And I dumped the
> descriptors and here's what is read (via DMA):
> 
> Command | Address  |  Data     | /BE
> Mem Rd  | 2A2A72F0 |           |
>                      2950D812  | 0000
>                      00000000  | 0000
>                      C8C70040  | 0000
>                      00000000  | 0000
> 
> Note that the descriptor programmed into the part has a DMA address
> that is not word aligned.  And the E1000 part sets the proper byte
> enables and does a write to the aligned address of 0x2850D180.
> 
> Is there any traction on this idea?
> 
> Thanks,
> Pete
