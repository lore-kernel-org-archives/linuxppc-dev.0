Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: ppcboot 8260 LXT971A
Date: Mon, 30 Jun 2003 10:46:57 +0200
Message-ID: <30C145E544071F4FB8B627789F7910BD32BE35@csy-exchange1.giat.intra>
From: "ARIBAUD Albert" <A.ARIBAUD@giat-industries.fr>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Hi,
> I installed a ppcboot and a linux 2.4 on a MPC8260ADS card.
>
> Now, I am working on a custom card such as an MPC8260ADS
> card. The difference between those two cards is the ethernet:
> my custom card has two ethernet port, and uses two LXT971A.
>
> So, I compile a ppcboot for 8260ads. PPCBOOT can't download a
> kernel with tftp. Is someone has a source code to support the LXT971?
>
> I compile a new kernel, which support LXT971A. PPCBOOT can
> run it from memory. But the kernel doesn't have network.
>
> please can someone help me?

Hi,

My own experience was with a TQM855L-like setup, using an LX971A, so it's an 8xx, not an 82xx context.

However : I had no problem with PPCBoot (and U-Boot now), but at first the kernel would not work with Ethernet. I traced that down to the MPC8XX CPM Options : once the "use MDIO for PHY configuration" option was UNSET (but "Support LXT971 PHY" was SET, of course), everything worked OK.

My problem had something to do with MII state change interrupts not being detected properly, so the Ethernet driver was not told when the line went up after autonegociation, and thus never sent any packet.

Maybe with your 8260 you hit the same kind of problems?

HTH,

Albert.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
