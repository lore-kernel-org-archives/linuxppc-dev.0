Message-Id: <200103152158.WAA00851@piglet.grunz.lu>
Date: Thu, 15 Mar 2001 22:58:05 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Multiple PCI buses in 2.4?
To: bob@kunk.jriver.com
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010315193345.17142.qmail@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  15 Mar, this message from bob@kunk.jriver.com echoed through cyberspace:
> I'm wondering what the state of support for multiple pci buses on
> PowerMacs is in 2.4? I see by looking at the code and reading the
> lists that work is being done on it since 2.4.1.

Multiple PCI busses should work just fine, with one exception: the
chaos-based second bus in the 7x00/8x00 machines.

> The 7X00/8X00 has 2 bridge devices both of which are recognized by
> 2.42 in the  boot messages but an lspci only shows one bus.

Yes, this is because the chaos-based bus cannot be probed for device sin
the traditional way, but will die in flames if you do that. Therefore
probing it is disabled for now, and hence lspci doesn't show it.

> The planb video4linux device is on the other bus and upon attempting to
> load the planb module I get the following...
>
> Linux video capture interface: v1.00
> PlanB: Found on bus 1, dev 13, func 0, membase 0x90000000 (base reg. 0x10)
> PlanB: cannot find PCI device!

Now this is my fault, so to speak ;-) I've modified planb to use the PCI
device structure, but since that isn't available in the current 2.4
kernels, you're out of luck.

However, I'm working right now on patches tha fix the detection of the
chaos bus and its devices; so that this problem should be solved soon.

I'll send you some patches by private mail, containing my current
working sources.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
