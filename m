Date: Wed, 30 Aug 2000 13:44:49 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: mlan@cpu.lu
cc: iain@sandoe.co.uk, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] via-cuda (CUDA_COMBINED_FORMAT_IIC)
In-Reply-To: <200008300922.LAA09244@mcp.cpu.lu>
Message-ID: <Pine.LNX.4.10.10008301338100.570-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 30 Aug 2000, Michel Lanners wrote:
> > Yes, there are different implementations for i2c on different models...
> > CUDA, PMU (PlanB and other mac-IO implementations).... and on the newer
> > machines "cereal" (and multiple i2c busses)...  if the ability to probe the
> > i2c bus is useful, I guess we'll have a few more drivers to update... :-)
>
> We could even provide a generic I2C interface (isn't that available on i386
> already?)... Give the different buses numbers, ala PCI, have a list of
> devices found on the bus, etc... Wouldn't that be a nice overkill? ;-))

The generic i2c subsystem works (at least `used to work') on PPC as well. I
once wrote an i2c `driver' (something that can read from and write to 2 signal
lines, very very complex :-) for the Hydra Mac I/O and was able to read the SPD
(Serial Presence Detect) EEPROMs on my DIMMs. The code is not present in the
standard kernel tree, but it's part of the LM Sensors project (sorry, no URL
for it in my bookmarks file here).

Actually the generic i2c subsystem is quite powerful and layered nicely: it
supports all kind of i2c hardware, ranging from simple hardware banging
control lines to more intelligent dedicated i2c hardware. I'm quite sure a
driver for CUDA or PMU would easily fit in it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
