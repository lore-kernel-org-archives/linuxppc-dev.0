Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 24 Jun 2003 14:19:35 -0500
From: Chris Zimman <chris@cryptoapps.com>
To: Oliver Amft <oam@gmx.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCI DMA memory problem
Message-ID: <20030624191935.GA9845@dingdong.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <3EF8A001.2090603@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3EF8A001.2090603@gmx.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jun 24, 2003 at 09:01:21PM +0200, Oliver Amft wrote:
>
> I am implementing a network driver for a DMA device on a custom
> 405GP/GPr based board. The networking device is attached over PCI bus.
> Kernel is currently 2.4.21. BIOS is PPCBoot 1.2.0.
>
> To map the data buffers from skb the driver uses pci_map_single(). When
> starting the kernel with SDRAM size configurations other than 32MByte
> the device is unable to transfer data (currupted data) - descriptor
> dword read/write-back works (set up with pci_alloc_consistent()). For
> the kernel start option mem=32MB everything is fine (descriptor +
> correct data).

My first thought is -- is/are the SDRAM bank(s) configured correctly?

I don't know that it'd necessarily be related, but for the 405GP,
PPCBoot 1.2.0 doesn't have the PCI bridge setup quite right for all
PCI devices (eg. 82559 won't work).  I have code to fix the bridge
setup if you need it -- although I'm not even certain they exist in
the GPR.

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
