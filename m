Date: Mon, 8 Apr 2002 08:20:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linux/PPC BK repository <linuxppc@helium.Harhan.ORG>
Cc: linuxppc-commit@source.mvista.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Incoming to helium.harhan.org:/home/linuxppc/linuxppc_2_4_alt
Message-ID: <20020408152026.GG2716@opus.bloom.county>
References: <200204060739.g367duV18841@helium.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200204060739.g367duV18841@helium.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[Just some code comments for now, actual comments in another mail]

> ChangeSet
>   1.925 02/04/05 23:09:25 msokolov@helium.harhan.org +60 -0
[snip]
>   arch/ppc/kernel/setup.c
>     1.105 02/04/01 00:01:18 msokolov@helium.harhan.org +49 -5
>     Add generic PPC32 config

We shouldn't be #ifdef'ing externs, since it doesn't matter.  The
pmac/prep/chrp ones were hidden just because the line above was, iirc.

And the one downside to the GENERIC_PPC32 platform_init, is that we're
back to adding:
#ifdef CONFIG_x
 case _MACH_x:
  x_init(...);
  break;
#endif

Which I think Paul was happy to see die :)

[snip]
>   arch/ppc/config.in
>     1.127 02/03/31 23:58:43 msokolov@helium.harhan.org +18 -21
>     Add generic PPC32 config, implemented for
>     Adirondack, EV-64260A, and K2

Do any of these boards actually have an ISA slot?  IIRC, CONFIG_ISA is
used for stuff which could be plugged into an ISA slot, not so much
things that could be on the ISA bus.  Right now it's an ALL_PPC-only
option because it's actually needed for sound on some PReP boxes..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
