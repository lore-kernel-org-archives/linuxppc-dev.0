In-Reply-To: <19991123121629.A16956@hq.fsmlabs.com>
Date: Tue, 23 Nov 1999 20:35:57 +0100
To: linuxppc-dev@lists.linuxppc.org, geert@linux-m68k.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: bootloader & head.S weirdness (patch)
Message-Id: <19991123203557.015084@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 23, 1999, Cort Dougan <cort@fsmlabs.com> wrote:

>Do you keep the list around after the initialization?  We do something
>similar with the prep residual data but after we grab what we want we free
>the RAM. 

As I just wrote to Cort, we already have something for that on PPC, it's
the device tree. Having a tagged data structure _and_ a device tree looks
to me like having twice the same things (humm .. almost).

If we remove all the prom_init stuff from the kernel, we can simplify
kernel entry by always entering the kernel with a known MMU state (let's
say OFF) and with one parameter: the offset from _start to the device
tree image.

Non-OF machines can easily build a very simple tree with the various
residual datas from the bootloader and Mac/CHRP machines can have the
kernel image appended to a bootloader that fills the device tree from OF
and adds whatever supplementary stuffs we need (initrd, cmd_line, ...) to
the tree in a given node.

There are two things not yet clear to me with this scheme:

 - We'll need to have RTAS instanciated at a fixed address choosen by the
bootloader. I don't think it's a problem if the bootloader puts it as
high as possible in memory, but it would have been better to have the
kernel have control on it. But we can live with this limitation

 - on SMP machines, the other CPUs must be started by OF code. That means
that the bootloader must also start them in an idle loop. I beleive the
code for the idle loop can be in the device tree too with all the infos
required by the kernel to take over.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
