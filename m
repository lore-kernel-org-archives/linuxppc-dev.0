Date: Wed, 30 Aug 2000 14:29:29 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Dänzer <daenzerm@student.ethz.ch>,
        Tony Mantler <nicoya@apia.dhs.org>,
        Tom Rini <trini@kernel.crashing.org>, Dan Malek <dan@netx4.com>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Platform configuration (was: Re: CONFIG_PPC != Mac)
In-Reply-To: <Pine.LNX.4.10.10007301642120.810-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.10.10008301334570.570-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 30 Jul 2000, Geert Uytterhoeven wrote:
> On Sun, 30 Jul 2000, Michel [iso-8859-1] Dänzer wrote:
> > Where does APUS fit in there?
>
> APUS is something different (CONFIG_APUS, cfr. arch/ppc/config.in). Currently
> it's not possible to build one kernel that supports both APUS and any other
> machine type anyway.
>
> So currently you have to compile a kernel for _either_
>
>     PowerMac/PReP/MTX/CHRP (CONFIG_ALL_PPC)
>  or Gemini (CONFIG_GEMINI)
>  or EST8260 (CONFIG_EST8260)
>  or APUS (CONFIG_APUS)
>
> Personally I'd more like a configuration where you can select whatever you
> want of
>
>   - PowerMac (CONFIG_PMAC)
>   - PReP (CONFIG_PREP)
>   - MTX (CONFIG_MTX)
>   - CHRP (CONFIG_CHRP)
>   - Gemini (CONFIG_GEMINI)
>   - EST8260 (CONFIG_EST8260)
>   - APUS (CONFIG_APUS)
>
> with of course some extra logic to prevent illegal combinations.

So what about this?

--- linux-2.4.0-test8-pre1/arch/ppc/config.in.orig	Wed Aug 23 18:52:20 2000
+++ linux-2.4.0-test8-pre1/arch/ppc/config.in	Wed Aug 30 14:23:38 2000
@@ -82,6 +82,10 @@
 fi

 if [ "$CONFIG_ALL_PPC" != "y" ];then
+  bool 'PowerMac support' CONFIG_PMAC
+  bool 'PReP support' CONFIG_PREP
+  bool 'MTX support' CONFIG_MTX
+  bool 'CHRP support' CONFIG_CHRP
   define_bool CONFIG_MACH_SPECIFIC y
 fi

and replace all tests for CONFIG_ALL_PPC by a suitable combination of tests
for CONFIG_PMAC/CONFIG_PREP/CONFIG_MTX/CONFIG_CHRP? (BTW, there are still some
relics of CONFIG_PREP around in config.in)

This clearly indicates that you can
 1. still compile one kernel that can run on all of PowerMac/PReP/MTX/CHRP,
    while
 2. it allows to fine tune the kernel to your specific machine and
 3. protect against illegal combinations with other machine types.
And if it ever will be possible to compile a generic kernel that runs on e.g.
APUS as well, CONFIG_APUS can be included in CONFIG_ALL_PPC (or better, rename
it to CONFIG_GENERIC_PPC) as well.

I'm willing to work on a first patch, but I don't have a PPC cross-compiler at
hand and am unable to use bitkeeper, so I have to base it on plain
2.4.0-test8-pre1 and leave it untested. Whoever owns whatever machine can
smooth the rough edges for his/her platform afterwards.

What do you think?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
