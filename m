Date: Wed, 12 Dec 2001 19:00:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Peter Bergner <bergner@brule.borg.umn.edu>
Cc: Adam C Powell IV <hazelsct@mit.edu>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Why require CONFIG_BOOTX_TEXT for so much of offb?
Message-ID: <20011213020019.GC28967@cpe-24-221-152-185.az.sprintbbd.net>
References: <3C158758.5020608@mit.edu> <20011212130522.A238707@brule.borg.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011212130522.A238707@brule.borg.umn.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Dec 12, 2001 at 01:05:22PM -0600, Peter Bergner wrote:
>
> : So here are my questions:
> :
> :     * Is there a way around this?
> :     * Is the test for BootX at the start of offb_init() somehow
> :       insufficient, such that all of this code must be eliminated if
> :       non-BootX booting is to work?
> :     * Or is there in fact a hard dependency of that code on other stuff
> :       provided by CONFIG_BOOTX_TEXT?
> :     * Is there some way of separating the two, so a single kernel can
> :       work with BootX and with all versions of OpenFirmware?
> :     * What's the point of offb without this section of code?
>
> I believe I'm the person responsible for adding the #ifdef CONFIG_BOOTX_TEXT
> to the code.   IIRC (it's been a while), the problem with that code is that
> when compiling the ppc64 kernel, you get a compile error when building that
> file:
>
>     offb.c:38:23: asm/bootx.h: No such file or directory
>
> Given that bootx doesn't exist in ppc64 and the code seemed to be used
> _only_ for bootx, I wrapped it with the "#ifdef CONFIG_BOOTX_TEXT".
> Since it's a problem for you, replacing the uses of "#ifdef CONFIG_BOOTX_TEXT"
> (there are 3 uses of it) with "#ifndef CONFIG_PPC64" instead would probably
> work for me and fix your problem too.

BOOTX_TEXT != BootX now tho.  It's for writing on the screen early on.
Perhaps some name changing, define moving and a new header for ppc64?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
