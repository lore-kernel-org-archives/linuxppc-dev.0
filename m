Date: Wed, 23 Aug 2000 13:58:07 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Monro <davidm@amberdata.demon.co.uk>
cc: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: prep problems - a couple of questions
In-Reply-To: <39A36A26.1291926E@amberdata.demon.co.uk>
Message-ID: <Pine.LNX.4.10.10008231355010.380-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 23 Aug 2000, David Monro wrote:
> I'm encountering a couple of problems with 2.4.0-test3+ on PReP systems.
> I've finally traced the major one down to the following: calling
> request_region() in prep_setup_arch() causes the machine to stop.
> Tracing it a little deeper, it is the call to kmalloc() inside
> request_region() which actually fails. I'm guessing this is caused by
> the changes to the slab allocator in 2.4.0-test3.
>
> So it looks like we can't afford to call request_region() this early in
> the game. Can anybody tell me when it is first safe to use it?

Change all early calls to `request_region(...)' to calls to
`request_resource(&ioport_resource, ...)', also passing pointers to your own
preinitialized `struct resource's.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
