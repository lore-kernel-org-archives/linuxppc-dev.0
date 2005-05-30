Return-Path: <roger.larsson@norran.net>
Received: from ns.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id 2D5F967A00
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 May 2005 03:47:35 +1000 (EST)
Received: from icd.localnet (131.net95.skekraft.net [213.199.95.131])
	by ns.skekraft.net (Postfix) with ESMTP id 77FFFA400C
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 May 2005 19:47:33 +0200 (CEST)
From: Roger Larsson <roger.larsson@norran.net>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 30 May 2005 19:47:40 +0200
References: <000001c564fd$aa5aad60$5201a8c0@GEG2400>
In-Reply-To: <000001c564fd$aa5aad60$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200505301947.40195.roger.larsson@norran.net>
Subject: Re: Embedded PowerPC with more than 2Go of RAM.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 30 May 2005 11.55, Laurent Lagrange wrote:
> Hi all,
>
> We want to design a PCI host embedded PowerPC board with a 3Go local RAM
> memory.
> This processor is a MPC74xx with an internal 32 bits and an external 36
> bits address bus.

In that case it should have some a mechanism for mapping virtual address range
(32 bits) to physical (36 bits).

>
> Usually, the mapping is :
   physical, only using 32 bits
> 0x00000000-0x80000000 : physical RAM
> 0x80000000-0xc0000000 : PCI memory access
> 0xc0000000-0xf0000000 : kernel virtual memory
> 0xf0000000-0xffffffff : IO area access

First attempt: I would try to put the PCI memory range at
0x100000000-140000000 (above 32 bits addressable)

But this will require the drivers to doing things correctly...

Second attempt: Do you need all RAM to be directly usable by user application?
Or would it be enough to be able to use it as a RAM disk? (with that amount
of memory my guess is that this is what you really want!) Should it be nice to 
have it persistant over reboots?
In that case put the RAM disk part above 32 bits addressable, only that RAM
disk driver needs to handle the specific nature of this memory (DMA memory
to memory). And several years ago I saw some ramdisk driver that could were
persistent (BIOS and linux RAM memory init was set not to touch it).
Add some standby power to it and it will be persistent over power failures 
too..
Then ask yourself - does it need to be memory mapped? Or would a IDE like
interface be enough???

/RogerL
