Date: Tue, 9 Oct 2001 10:49:12 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Lanners <mlan@cpu.lu>
Cc: benh@kernel.crashing.org,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Crash with BenH's 2.4.10/2.4.11-pre on 7600
In-Reply-To: <200110081944.VAA00811@piglet.grunz.lu>
Message-ID: <Pine.GSO.4.21.0110091048150.13627-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 8 Oct 2001, Michel Lanners wrote:
> The problem is that request_OF_resource (which calls kmalloc() ) is
> called from probe_sccs, which in turn is called for the serial console,
> i.e _very_ early in the boot process. At that time, the kmem system is
> not yet initialized.

We had a similar problem on Amiga with the Chip RAM allocator, which uses the
generic resoruce system now.

Look at amiga_chip_alloc{,_res}() in arch/m68k/amiga/chipram.c for a solution.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
