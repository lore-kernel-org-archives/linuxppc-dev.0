Date: Thu, 11 Apr 02 08:40:29 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0204111540.AA28629@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Let's do it first in 2.5, we can backport it once we are satisfied

Bleah. 2.5 == never to me. It doesn't help me with my goal of getting support
for my boards in 2.4. I work on stable kernels and not development ones because
I'm not a Linux developer, I'm just a HW engineer trying to make Linux
(existing stable one) support my boards at least as well as it does those from
my competitors (IBM, Sun, etc).

I guess I'll just have to convince Debian to make a package from
linuxppc_2_4_alt to support HEC PPCStar machines and show all these exchanges
as evidence that the PPC MAINTAINERS are not intent on allowing new machine
support into 2.4 any time soon.

> Well.. you forget pmac here ;)
>
> The problem is that pmac has it's own serial HW with a different driver,
> but still may need serial.o for PCI serial cards or pcmcia modems.

But then a PMac doesn't need anything in rs_table!

If in addition to PMacs a CONFIG_GENERIC_PPC32 kernel supports other machines
with serial consoles, the serial driver must be compiled in. If no machines
other than PMac are selected, you can compile without the serial driver in
there as the PMac port won't care about rs_table and won't call
early_serial_setup. Then if you load it as a module, you'll have no fixed ports
will get all PCI, PCMCIA, etc. ones, which is exactly what you need here.

So I don't see a problem.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
