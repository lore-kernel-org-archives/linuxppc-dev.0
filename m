Date: Wed, 28 Nov 2001 16:51:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Dan Malek <dan@embeddededge.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: include/asm-ppc/platforms/
Message-ID: <20011128165132.G29541@cpe-24-221-152-185.az.sprintbbd.net>
References: <15363.31192.101536.919771@gargle.gargle.HOWL> <3C2B376F.9070508@embeddededge.com> <15364.32906.728532.676746@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15364.32906.728532.676746@gargle.gargle.HOWL>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 28, 2001 at 05:13:30PM +1100, Paul Mackerras wrote:
>
> Dan Malek writes:
>
> > That's a pretty good idea, and I have another one.  Name the
> > directory include/asm-ppc/ppc-platforms or something, then
> > have a symbolic link
> > 	include/asm/platform -> include/asm-ppc/ppc-platforms/<board-file>
> >
> > That way we can just #include <platform.h> instead of having lots
> > of ifdefs in upper level files to determine which one is needed.  If
> > we are moving files around, let's have some effect on actually making
> > it easier to use them, too.
>
> I have figured out a way to do this without too much pain.  The idea
> is that we will have platform.h and platform-serial.h be symlinks to
> files in include/asm-ppc/platforms/.  The way that I am suggesting
> that we do this is to have special comments in those files (the ones
> in include/asm-ppc/platforms) that say what should be symlinked, like
> this, from include/asm-ppc/platforms/all_ppc_serial.h:

The one thing I don't like about this is that there's a handfull of
platforms which would use the 'all_ppc_serial.h' file.

> The patch below does all this.  It does mean that we will need a
> platform header for every platform, and a platform_serial header for
> every platform where we want to use the standard serial driver.  As an
> example, I have made an all_ppc_serial.h that contains most of what
> was in serial.h before.  In fact, with a bit of care we could make
> serial.h be the symlink.

Well, if I read that mess if #ifdefs, they already are a whole
'serial.h', so lets just do it in one go. :)

Aside from that it looks good.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
