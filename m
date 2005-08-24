Return-Path: <flar@pants.nu>
Date: Wed, 24 Aug 2005 13:44:33 -0700
From: Brad Boyer <flar@allandria.com>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050824204433.GB23118@pants.nu>
References: <20050822141235.GA7110@austin.ibm.com>
	<E470B224-F0FB-48D7-9A04-E42247B11554@freescale.com>
	<20050824182020.GB15735@smtp.west.cox.net>
	<200508242203.27210.arnd@arndb.de>
	<20050824201332.GD15735@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050824201332.GD15735@smtp.west.cox.net>
Cc: Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
	linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnd Bergmann <arnd@arndb.de>, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH 3/3] Move all the very similar files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 24, 2005 at 01:13:32PM -0700, Tom Rini wrote:
> On Wed, Aug 24, 2005 at 10:03:26PM +0200, Arnd Bergmann wrote:
> > On Middeweken 24 August 2005 20:20, Tom Rini wrote:
> > > No it doesn't.  You can easily make the drivers get the includes from
> > > <platforms/pmac/foo.h>, arch/$(ARCH) is already always in the search
> > > path, I believe (if not, it's easy to add Makefile things to get it).
> > 
> > I don't think any architecture except ppc32 has traditionally had
> > arch/$ARCH in its include path, and it would probably come as a surprise
> > to many kernel developers if this were used more.
> 
> True, but it's possible that the pmac drivers could also be converted to
> use something else to pass around infos, register IO and such so the
> headers can still live in arch/powerpc/platforms/pmac/

These days, the macio bus is a real device-model bus. The code still
lives in drivers/macintosh, but it will be used by more than just
pmac machines whenever I get the 68k mac support finished. It seems
like we really should have an include/linux/macio.h, and make the
whole thing act more like a normal bus. I would like to abstract out
more of it anyway, particularly the DMA support. That way we wouldn't
have several different drivers for the same chip due to bus interface
differences (see mace.c and macmace.c for an example of current practice).
This would eliminate at least macio.h and dbdma.h. Hopefully it would
get most of the mac specific code organized in a more logical fashion.
Any comments/requirements/suggestions?

	Brad Boyer
	flar@allandria.com
