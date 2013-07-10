Return-Path: <pladow@gmail.com>
Received: from mail-lb0-x22e.google.com (mail-lb0-x22e.google.com
 [IPv6:2a00:1450:4010:c04::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 279932C02F6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 07:06:34 +1000 (EST)
Received: by mail-lb0-f174.google.com with SMTP id x10so6061890lbi.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 14:06:29 -0700 (PDT)
MIME-Version: 1.0
Sender: pladow@gmail.com
In-Reply-To: <1371945647.3944.106.camel@pasglop>
References: <CAN8Q1EdnN9+kKGy+voF3=EyPfbHv04Emfz=uA6XKMJEAkvLpAA@mail.gmail.com>
 <CAN8Q1Ed9Lpg1Sog5tQODe+jqCRXBBH3d_UeR5usdc23CD7vwjg@mail.gmail.com>
 <1371945647.3944.106.camel@pasglop>
Date: Wed, 10 Jul 2013 14:06:28 -0700
Message-ID: <CAN8Q1EetHpVkWFmbDGCE-3J4H7oJm0zE66SAdJyvtDb7OBc-gg@mail.gmail.com>
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

I have a bit more information, but I'm not sure of the impact.  So far
I have been dump lots of debugging output trying to determine where
this memory corruption could be coming from.  I've sprinkled the
driver with wmb() (near every DMA function and the hardware IO), loads
of printk's to get the DMA addresses, and lots and lots of PCI traces.

One things that I noticed is that the addresses programmed into the
descriptor ring for the E1000 are not 32-bit aligned.  The E1000 part
is aligning the transfers, and use the BE's to mask off bytes.  Is
there an issue with the PPC (notably the MPC8349) with incoming PCI
transactions that are 32-bit word aligned but write less than a full
word?

In looking at the PCI trace, all the DMA's of packets from the E1000
start at a 32-bit aligned address, but the first and last words are
not full word writes.  For example (probably need a fixed font to
view):

Command | Address  |  Data     | /BE
Mem Wr  | 2950D180 |           |
                     FFFF0000  | 0011
                     FFFFFFFF  | 0000
                     DBA24DF0  | 0000
                     00085F19  | 0000
                     24000024  | 0000
                     0000C530  | 0000
                     80D81180  | 0000
                     F10DCA0A  | 0000
                     FF0DCA0A  | 0000
                     CF06CC06  | 0000
                     A1BA1000  | 0000
                     01400BC5  | 0000
                     F1001000  | 0000
                     00000000  | 0000
                     00000000  | 0000
                     68730000  | 0000
                     00000F22  | 1100

Note that the first word is only a 16-bit transfer (in the upper half)
and the last is only 16-bits (in the lower half).  And I dumped the
descriptors and here's what is read (via DMA):

Command | Address  |  Data     | /BE
Mem Rd  | 2A2A72F0 |           |
                     2950D812  | 0000
                     00000000  | 0000
                     C8C70040  | 0000
                     00000000  | 0000

Note that the descriptor programmed into the part has a DMA address
that is not word aligned.  And the E1000 part sets the proper byte
enables and does a write to the aligned address of 0x2850D180.

Is there any traction on this idea?

Thanks,
Pete
