Message-ID: <3EFAE8C6.2070809@gmx.net>
Date: Thu, 26 Jun 2003 14:36:22 +0200
From: Oliver Amft <oam@gmx.net>
MIME-Version: 1.0
To: chris@cryptoapps.com, wd@denx.de
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCI DMA memory problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The problem was a wrong PCI configuration of the 405 with two colliding
PCI target mappings (PTM1 and PTM2).

Oliver

>> To map the data buffers from skb the driver uses pci_map_single().
>> When starting the kernel with SDRAM size configurations other
>> than 32MByte the device is unable to transfer data (currupted
>> data) - descriptor dword read/write-back works (set up with
>> pci_alloc_consistent()). For the kernel start option mem=32MB
>> everything is fine (descriptor + correct data).
>
> My first thought is -- is/are the SDRAM bank(s) configured correctly?
>
> I don't know that it'd necessarily be related, but for the 405GP,
> PPCBoot 1.2.0 doesn't have the PCI bridge setup quite right for all
> PCI devices (eg. 82559 won't work). I have code to fix the bridge
> setup if you need it -- although I'm not even certain they exist in
> the GPR.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
