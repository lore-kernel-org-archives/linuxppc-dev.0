Date: Tue, 5 Feb 2002 12:42:14 -0700
From: Val Henson <val@nmt.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Highmem on PPC?
Message-ID: <20020205124214.H6834@boardwalk>
References: <20020205115618.D6834@boardwalk> <20020205193316.19866@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020205193316.19866@smtp.wanadoo.fr>; from benh@kernel.crashing.org on Tue, Feb 05, 2002 at 08:33:16PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 05, 2002 at 08:33:16PM +0100, Benjamin Herrenschmidt wrote:
>
> >I'm currently getting hard crashes on the dual 7410 with highmem.  Not
> >even the SMI starts xmon.  I'm not sure that it's a software bug,
> >which is why I'm getting the dual 7450.
>
> Interesting. I have similar reports about dual 800s with 1.5G of RAM.
> I don't personally have a machine with that much RAM, so it makes things
> a bit difficult to debug. All I noticed so far is that
> enabling interrupt distribution will cause occasional lockups on my
> dual 7400 at work (not related to highmem). So if you plan to chase
> this highmem bug, start by disabling that option to avoid mixing
> problems.

I don't use interrupt distribution.

I triggered the absolute hard hang with my usual tests: 5 or 6 of the
following running in the background:

find /mnt/cdrom -exec cat {} \; > /dev/null 2>&1 &
find /usr -exec cat {} \; > /dev/null 2>&1 &

And a make -j8 zImage in the foreground.  I didn't even start the
flood ping before it hung. :)

> Just in case it's a spinlock bug (who knows...) you may want to hack
> the spinlock debug output to use the btext engine (basically #define
> printf to xmon_printf in the spinlock code and hack xmon/start.c to
> force use_screen).

This is actually over serial console, but I'll keep that in mind when
I get the apple.

> And let me know if you find something ;)

:) You bet.  You're sure you're not seeing these hangs?  What are you
using, dual 7400 with 1 GB RAM?

-VAL

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
