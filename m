Date: Mon, 8 Apr 2002 11:57:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: benh@kernel.crashing.org
Cc: Linux/PPC BK repository <linuxppc@helium.Harhan.ORG>,
	linuxppc-commit@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: Incoming to helium.harhan.org:/home/linuxppc/linuxppc_2_4_alt
Message-ID: <20020408185758.GA21725@opus.bloom.county>
References: <20020408152026.GG2716@opus.bloom.county> <20020408175806.9080@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020408175806.9080@mailhost.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Apr 08, 2002 at 06:58:06PM +0100, benh@kernel.crashing.org wrote:
> >We shouldn't be #ifdef'ing externs, since it doesn't matter.  The
> >pmac/prep/chrp ones were hidden just because the line above was, iirc.
> >
> >And the one downside to the GENERIC_PPC32 platform_init, is that we're
> >back to adding:
> >#ifdef CONFIG_x
> > case _MACH_x:
> >  x_init(...);
> >  break;
> >#endif
> >
> >Which I think Paul was happy to see die :)
>
> No, in the version I'm implementing for 2.5, the ppc_md structure of
> each board will be statically defined and contain the init function.
> A global array will contain ppc_md pointers indexed by machine.

Won't that still lead to an:
#ifdef CONFIG_x
 ... set thingsup for CONFIG_X since this will only exist on CONFIG_x...
#endif

Or am I missing something?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
