Return-Path: <olof@lixom.net>
Date: Sat, 14 Jan 2006 12:40:40 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Better machine descriptions and kill magic
	numbers
Message-ID: <20060114184040.GR2491@pb15.lixom.net>
References: <1137217531.4854.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1137217531.4854.39.camel@localhost.localdomain>
From: Olof Johansson <olof@lixom.net>
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

On Sat, Jan 14, 2006 at 04:45:30PM +1100, Benjamin Herrenschmidt wrote:

>  - Machines/Platforms magic numbers are gone, _machine is gone too, you
> can now use the machine_is(name) macro to check if you are running on a
> givem board, this macro works by testing which of the machine
> descriptions was selected at boot.

Nice! Overall I like this. It removes some of the kexec limitations of
having to play with platform numbers when booting a newer kernel that
detects platforms differently (or renumbered) too.

I do have a couple of comments on the implementation:

I got complaints when I did this for cpu features, where I first used
a cpu_has_feature(<x>) syntax instead of cpu_has_feature(CPU_FTR_<x>).
I think I agree with some of the reasoning for that too: someone searching
for "powermac" when looking for the "machine_is(powermac)" logic won't
find it.

Because of this, I suggest keeping the mach_ part in the syntax, i.e,
to use:

machine_is(mach_powermac) instead, and not do preprocessor mangling of
the label name. The same would go for define_machine().

It would seem to make some sense to keep the platform types looking
like defines (i.e. MACH_POWERMAC instead of mach_powermac) to keep it
consistent with the CPU and firmware feature testing, but the way it's
implemented that doesn't make much sense. That's a bit of a shame.

In the probe loop, ppc_md is copied over for each probe, that seems
wasteful. Shouldn't the probe routines use and modify their own
machdep_calls instead of ppc_md, so the copying can be done only once,
after a match is found?


-Olof
