Message-ID: <40E4618A.902@mvista.com>
Date: Thu, 01 Jul 2004 12:10:02 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-emb <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mv6360 support in mv64x60.c (was Re: GT64260_eth (Ethernet)	Driver)
References: <40E1E94B.9060204@mvista.com> <1088691201.14216.2977.camel@hades.cambridge.redhat.com>
In-Reply-To: <1088691201.14216.2977.camel@hades.cambridge.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Woodhouse wrote:

>More progress... the IRQ code works a bit better if it's ic_bh->v_addr
>is at offset zero in the chip instead of the 0xc18 which is correct only
>for the GT64260.
>
Yep.  Added to the list.

> The host bridge itself appears on the bus as device #3,
>which is why we couldn't autodetect it by looking at vendor/device of
>device #0.
>
Ah, I see the problem.  PCI regs are being accessed before
mv64x60_enumerate_buses() is called which sets the hose bus & device
numbers.  Actually, I never expected fw to ever change the dev number
from zero so I was only really concerned about setting the bus number in
that routine.  For some reason, your firmware must be changing it to 3.

FYI, look at the "PCI P2P Configuration" register
(MV64x60_PCI[01]_P2P_CONFIG (0x1d14/0x1d94)).  Apparently your firmware
sets the device number of your hoses to 3 for some reason (default is 0
for PCI, 0x1f for PCI-X).

Added to the list.

>
>∃ an Ethernet driver for the MV64340 (the MIPS version of the chip). It
>doesn't use OCP though -- there's no OCP on MIPS. Can someone explain
>why OCP is used instead of the generic platform_device functionality
>provided by the kernel? Should we convert MIPS to OCP?
>
>
>
I think Matt answered this one.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
