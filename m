Date: Thu, 28 Mar 2002 04:04:42 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: DST flag in NVRAM revisited (was: Re: NVRAM stuck in DST?)
Message-ID: <20020328040442.V26309@plato.local.lan>
References: <20011207213804.7802@smtp.wanadoo.fr> <E16qY53-0000Iw-00@piglet.grunz.lu>
Mime-Version: 1.0
In-Reply-To: <E16qY53-0000Iw-00@piglet.grunz.lu>; from mlan@cpu.lu on Thu, Mar 28, 2002 at 12:28:27PM +0100
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 28, 2002 at 12:28:27PM +0100, Michel Lanners wrote:
>
> In arch/ppc/kernel/time.c, kernel time is set from the RTC, implicitly
> taking RTC for GMT time. Under MacOS, however, it's localtime. On pmac,
> we use the GMT offset MacOS stores in nvram to correct this, and correct
> kernel time to real GMT. We also set kernel timezone info, but it's use
> is discouraged (have a look at man settimeofday).

this is broken.  the kernel should just use the time stored in nvram
and ignore the crap macos is keeping there regarding time zones.

the solution to the `windows controls the hardware clock' problem was
made many years ago, hwclock can be told whether the RTC is in
localtime or GMT, just about every distro asks you this on install (at
least on x86 debian does on powerpc too).

we should just deal with the RTC exactly how its delt with on x86, if
you have windows (or in our case MacOS) you tell hwclock the RTC is in
localtime and let it deal with it, if you don't have MacOS/windows you
tell it you have the RTC in GMT like its supposed to be and all is well.

> Now, when this offset is wrong (like when DST switched and you didn't
> boot MacOS since), your intial kernel time will be wrong. However, the

which demonstrates exactly why this crap in the kernel trying to be
like macos is just plain wrong and broken.

> The question, of course, is whether Linux should maintain this GMT
> offset in nvram, since it uses it's information. If so, then who should
> maintain it where?

no it should not.  the kernel should NOT know or care what the
timezone is, that belongs in userspace not kernel space.  period.

the feilds macos sets should be ignored entirely by linux, not read,
not written.

> My proposition would be to correct this everytime that the RTC is
> updated (since the GMT offset belongs logicaly to the RTC function
> block). Debian does this on every system shutdown.

please don't forget systems that don't have legacy MacOS, these
systems will keep the RTC in GMT like its supposed to be.

> Obviously, the easiest thing to do is do nothing and entirely rely on
> the bootup scripts to set the correct time.

this is of course the correct solution, this problem was met and
solved YEARS ago on x86 its stupid that powerpc is fooling around with
it when there is already a well established and working solution.

> Comments anyone?

see above, in short this `lets pretend we are MacOS!!' crap in the
kernel should be *REMOVED* the kernel should not know or care about
timezones or DST, it should just read the RTC and ignore these macos
fields.  the standard bootup scripts running hwclock will pass --utc
or --localtime depending on how the user configured it and all will be
fine, just like on x86 for dealing with windows.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
