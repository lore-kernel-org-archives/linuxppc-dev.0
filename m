Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 2915ADDE07
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 06:37:27 +1100 (EST)
Date: Wed, 23 Jan 2008 22:37:12 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: mpc8568e-mds: pci-e is broken
Message-ID: <20080123193712.GA12037@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Benjamin, Kumar,

Using galak/powerpc.git's e4a0d8a1f7e6a9741ec46 head, MPC8568E-MDS
is oopsing during PCI-E probe, like this:

- - - -
Found FSL PCI host bridge at 0x00000000e0008000. Firmware bus number: 0->255
PCI host bridge /pci@e0008000 (primary) ranges:
 MEM 0x0000000080000000..0x000000009fffffff -> 0x0000000080000000
  IO 0x00000000e2000000..0x00000000e27fffff -> 0x0000000000000000
Found FSL PCI host bridge at 0x00000000e000a000. Firmware bus number: 0->255
PCI host bridge /pcie@e000a000  ranges:
 MEM 0x00000000a0000000..0x00000000afffffff -> 0x00000000a0000000
  IO 0x00000000e2800000..0x00000000e2ffffff -> 0x0000000000000000

[...]

PCI: Probing PCI hardware
PCI: 0001:01:00.0: class b20 doesn't match header type 01. Ignoring class.
PCI: Closing bogus Apple Firmware region 1 on bus 0x02
PCI: Closing bogus Apple Firmware region 2 on bus 0x02
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc0142760
Oops: Kernel access of bad area, sig: 11 [#1]
MPC85xx MDS
Modules linked in:
NIP: c0142760 LR: c01427a8 CTR: 00000000
REGS: df823dc0 TRAP: 0300   Not tainted  (2.6.24-rc8-g146f2dc2-dirty)
MSR: 00029000 <EE,ME>  CR: 42044082  XER: 00000000
DEAR: 00000000, ESR: 00000000
TASK = df820000[1] 'swapper' THREAD: df822000
GPR00: 00000000 df823e70 df820000 df800380 000000d0 00000200 00000004 c028aa6c
GPR08: df81c200 00000007 00000000 df809a44 22044024 48fdafc9 1fff4e00 c02276ec
GPR16: c0227760 df823f98 c0227748 c0284efc c0227774 c0227788 c023e5b0 c02a9200
GPR24: df8098d8 df823eac df809800 b6db6db7 00000000 00000008 00000000 df8098e0
Call Trace:
[df823e70] [c01427a8]  (unreliable)
[df823ea0] [c0143c9c]
[df823f00] [c027a338]
[df823f20] [c026e38c]
[df823f30] [c026df08]
[df823f60] [c02641ec]
[df823ff0] [c000dc08]
Instruction dump:
39290001 2f9d0006 7d4a4f5e 7f3ccb78 48000020 812b0004 800b0000 39290001
7c004850 7f805040 419c0044 7fdcf378 <83dc0000> 38000000 2f9e0000 41beffe8
---[ end trace 8640abe69a316dee ]---
Kernel panic - not syncing: Attempted to kill init!
Rebooting in 180 seconds..
- - - -


It seems like be8cbcd8896670a01ead7a29e33ff is at "fault".

static void __devinit __pcibios_fixup_bus(struct pci_bus *bus)
{
...
		if (i >= 3 && bus->self->transparent)
			continue;
...
}

That new check doesn't work, here bus->self->transparent == 0.
Could it be that the message below is the root cause?

PCI: 0001:01:00.0: class b20 doesn't match header type 01. Ignoring class.

I.e. drivers/pci/probe.c just don't setting transparent flag.
I wonder if we need use quirk_transparent_bridge() here or
we can fix it other way?

Just in case, I'm observing that message for a long long time, and
it didn't tell upon any functionality till now.


Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
