Date: Sun, 30 Jul 2000 16:56:02 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: Tony Mantler <nicoya@apia.dhs.org>, Tom Rini <trini@kernel.crashing.org>,
        Dan Malek <dan@netx4.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
In-Reply-To: <39842797.3EDD80B6@student.ethz.ch>
Message-ID: <Pine.LNX.4.10.10007301642120.810-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 30 Jul 2000, Michel [iso-8859-1] Dänzer wrote:
> Geert Uytterhoeven wrote:
> > The Master PPC Penguin decided to no longer allow to build machine specific
> > kernels, but treat PowerMac/PReP/MTX/CHRP as one big machine type
> > (`CONFIG_ALL_PPC').
>
> Where does APUS fit in there?

APUS is something different (CONFIG_APUS, cfr. arch/ppc/config.in). Currently
it's not possible to build one kernel that supports both APUS and any other
machine type anyway.

So currently you have to compile a kernel for _either_

    PowerMac/PReP/MTX/CHRP (CONFIG_ALL_PPC)
 or Gemini (CONFIG_GEMINI)
 or EST8260 (CONFIG_EST8260)
 or APUS (CONFIG_APUS)

Personally I'd more like a configuration where you can select whatever you
want of

  - PowerMac (CONFIG_PMAC)
  - PReP (CONFIG_PREP)
  - MTX (CONFIG_MTX)
  - CHRP (CONFIG_CHRP)
  - Gemini (CONFIG_GEMINI)
  - EST8260 (CONFIG_EST8260)
  - APUS (CONFIG_APUS)

with of course some extra logic to prevent illegal combinations.

The main reason why the Master PPC Penguin chose for the CONFIG_ALL_PPC option
was to be able to compile one kernel that would run on all his machines,
instead of having to compile multiple kernels, one for each machine.
I don't understand why he didn't want the flexibele scheme above, since it
would support anything you want, including his favorite configuration.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
