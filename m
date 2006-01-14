Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Better machine descriptions and kill magic
	numbers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20060114184040.GR2491@pb15.lixom.net>
References: <1137217531.4854.39.camel@localhost.localdomain>
	<20060114184040.GR2491@pb15.lixom.net>
Content-Type: text/plain
Date: Sun, 15 Jan 2006 08:04:46 +1100
Message-Id: <1137272686.4855.17.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Because of this, I suggest keeping the mach_ part in the syntax, i.e,
> to use:
> 
> machine_is(mach_powermac) instead, and not do preprocessor mangling of
> the label name. The same would go for define_machine().
> 
> It would seem to make some sense to keep the platform types looking
> like defines (i.e. MACH_POWERMAC instead of mach_powermac) to keep it
> consistent with the CPU and firmware feature testing, but the way it's
> implemented that doesn't make much sense. That's a bit of a shame.

I'm not sure about these ... I'm definitely not fan of going uppercase (and
it makes no sense vs. the implementation as it's not macros). I also don't
get your problem with grep... the "mach_" construct is totally invisible,
so people wouldn't grep for it, but for "powermac" alone.

Or do you mean a grep on "powermac" might return too many things unrelated ?

It should be easy enough in this case to grep for machine_is(powermac) instead
then, after all, that's the only possible use...

> In the probe loop, ppc_md is copied over for each probe, that seems
> wasteful. 

I changed that from the old way indeed to allow the probe() function to
override things in ppc_md.

> Shouldn't the probe routines use and modify their own
> machdep_calls instead of ppc_md, so the copying can be done only once,
> after a match is found?

I don't like modifying their own machdep calls because the name of the
structure is hidden. In general, I prefer that things continue to only
access ppc_md. and not their own machine structure that goes away. That
means that the code "patching" it can be moved away etc... without
special case instead of having a special case in probe() that has to
reference the machine specific copy...

I doubt the memcpy per machine at boot will cause any kind of
significant performance issue ...

Ben.
