Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id DFE62DDF4E
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 07:53:07 +1100 (EST)
Date: Mon, 23 Mar 2009 23:53:05 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/57] microblaze_v7: Open firmware files
Message-ID: <20090323205305.GA10576@oksana.dev.rtsoft.ru>
References: <1237408284-8674-1-git-send-email-monstr@monstr.eu>
	<4b5aee01d11fc790c7842838ea63a82ee3273003.1237407249.git.monstr@monstr.eu>
	<af309ba8e95f503b7990461384d9f8453f45dbbd.1237407249.git.monstr@monstr.eu>
	<200903231951.23902.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200903231951.23902.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, monstr@monstr.eu, linux-kernel@vger.kernel.org,
	john.williams@petalogix.com
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 23, 2009 at 07:51:23PM +0100, Arnd Bergmann wrote:
> On Wednesday 18 March 2009, monstr@monstr.eu wrote:
> > From: Michal Simek <monstr@monstr.eu>
> > 
> > 
> > Signed-off-by: Michal Simek <monstr@monstr.eu>
> > ---
> >  arch/microblaze/include/asm/of_device.h   |   45 ++
> >  arch/microblaze/include/asm/of_platform.h |   64 ++
> >  arch/microblaze/include/asm/prom.h        |  313 ++++++++
> >  arch/microblaze/kernel/of_device.c        |  115 +++
> >  arch/microblaze/kernel/of_platform.c      |  201 +++++
> >  arch/microblaze/kernel/prom.c             | 1147 +++++++++++++++++++++++++++++
> >  arch/microblaze/kernel/prom_parse.c       | 1025 ++++++++++++++++++++++++++
> >  7 files changed, 2910 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/microblaze/include/asm/of_device.h
> >  create mode 100644 arch/microblaze/include/asm/of_platform.h
> >  create mode 100644 arch/microblaze/include/asm/prom.h
> >  create mode 100644 arch/microblaze/kernel/of_device.c
> >  create mode 100644 arch/microblaze/kernel/of_platform.c
> >  create mode 100644 arch/microblaze/kernel/prom.c
> >  create mode 100644 arch/microblaze/kernel/prom_parse.c
> 
> Since these files are derived from the powerpc versions, what is the
> plan on them? IIRC, you had them in a common directory in an earlier
> version. Are you planning to merge them at some point in the future
> or do you intend to maintain a fork?

Actually, it's trivial to factor out all the common code out of
arch/powerpc/ to drivers/of/.

It took me approx. 4 hours to factor out the code and make a
proof-of-concept FDT support for a little-endian ARM platform. ;-)
(The device tree was only describing a cpu and a nor flash, though.
No support for interrupt- and gpio-controllers. And no support for
U-Boot, I just built the dtb file into the kernel).

I never got around to clean it up and send though, but for sure,
there is absolutely no reason to duplicate the code across the
platforms.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
