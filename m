Message-ID: <412CC13A.2050009@eircom.net>
Date: Wed, 25 Aug 2004 17:41:30 +0100
From: Conor McLoughlin <cml3227@eircom.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Cc: Conor McLoughlin <cml3227@eircom.net>
Subject: Anyone with MPC82xx PCI on kernel 2.6?
References: <4124E315.9090009@eircom.net>
In-Reply-To: <4124E315.9090009@eircom.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to bring up a custom board which contains an MPC8250, a
three-port PCI-PCI bridge and a few pci devices. I am using kernel
2.6.8.1. I am having a number of problems.

Currently I have just four devices hanging off one secondary bus of the
pci-pci bridge. Apart from the bridge, I have no other devices hanging
off bus 0.  I have nothing yet hanging off bus 2.

                 | bus 0
                 |
     ------------------
     |                |
   ============      ============
   |bridge     |     | bridge    |
   |device 0x10|     |device 0x10|
   |function 0 |     |function 1 |
   ============      ============
       |bus 1             |bus 2
       |                  |
   ---------------------
   |         |         |
  device 1   device 2 device 3

Initially, the bios initialization would not assign resources to my
devices on bus 1. The reason appeared to be that in
pci_read_bridge_bases it reads the memory base and limit registers
from the bridge. As these are initially zero, it sets a limit
of 1MB for the resources assigned to bus 1.
My devices (DSP processors) look for a lot more memory space that that.
I modified the function to assign sufficient resources for my needs
and it now appears to assign memory resources to the devices correctly.

First question: Should the memory limit register be set in the bridge
becore pci_read_bridge_bases? Is it perhaps assumed that the bios (boot
code) sets this up?

I still have an issue with I/O resources that I am ignoring for now.
My primary concern right now is verifying the hardware.

Now I try to access the devices on bus 1. I can read the configuration
space no problem, but get bus error if I read the pci memory space.
Checking everything obvious, I see that the the command register of
the pci-pci bridge does not have the memory or I/O space bits set.
Setting these bits eliminates the bus error.

Second question: What function should set the command register for
the pci-pci bridge to enable access to the secondary bus for
memory and I/O cycles?

Now I am at the stage where I don't get a bus error, but I read all FFs
no matter where I read from bus 1. It doesn't appear to matter if a
device is configured at the address or not.

Next question: What should I look at now?  How do I tell if
the device responded to the pci access?

Any help would be much appreciated.
Conor

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
