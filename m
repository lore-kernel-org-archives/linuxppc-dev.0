Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Implement check_legacy_ioport() on PS3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1175219000.5241.6.camel@concordia.ozlabs.ibm.com>
References: <1175212972.3122.87.camel@pmac.infradead.org>
	<20070330014542.GA28342@lixom.net>
	<1175219000.5241.6.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 30 Mar 2007 11:47:40 +1000
Message-Id: <1175219260.28116.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-03-30 at 11:43 +1000, Michael Ellerman wrote:
> On Thu, 2007-03-29 at 20:45 -0500, Olof Johansson wrote:
> > On Fri, Mar 30, 2007 at 01:02:52AM +0100, David Woodhouse wrote:
> > > It doesn't like it when we poke at legacy I/O ports like the i8042. We
> > > should probably change the _default_ to return -ENODEV, and let any
> > > strange platform which wants to allow unfettered access provide its own
> > > function for that.
> > 
> > I ran into the very same thing earlier myself and had exactly the same
> > idea. However, it turned out then that it would have meant adding more
> > cases of ioport being allowed than it would have removed the opposite. It
> > might have changed since then. Either way it's annoying.
> 
> No I just looked at it too. We have 19 platforms, 7 define
> check_legacy_ioport(), 6 of those return ENODEV, one does something
> useful. Which leaves 12 platforms that get the default "return 0"
> behaviour.
> 
> I still don't like it though, having to opt _out_ of random io port
> poking is not nice.

Well, we need to do what I suggested I think, that is have a default
helper that checks the device-tree. Only platforms that do have legacy
ISA crap -and- don't have them properly in the device-tree would then
need to provide their own.

Ben.
