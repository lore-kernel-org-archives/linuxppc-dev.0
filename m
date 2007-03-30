Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Implement check_legacy_ioport() on PS3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070330014542.GA28342@lixom.net>
References: <1175212972.3122.87.camel@pmac.infradead.org>
	<20070330014542.GA28342@lixom.net>
Content-Type: text/plain
Date: Fri, 30 Mar 2007 11:45:37 +1000
Message-Id: <1175219137.28116.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-03-29 at 20:45 -0500, Olof Johansson wrote:
> On Fri, Mar 30, 2007 at 01:02:52AM +0100, David Woodhouse wrote:
> > It doesn't like it when we poke at legacy I/O ports like the i8042. We
> > should probably change the _default_ to return -ENODEV, and let any
> > strange platform which wants to allow unfettered access provide its own
> > function for that.
> 
> I ran into the very same thing earlier myself and had exactly the same
> idea. However, it turned out then that it would have meant adding more
> cases of ioport being allowed than it would have removed the opposite. It
> might have changed since then. Either way it's annoying.

I was thinking that we could have one single helper shared by most
platforms who allow that legacy ISA crap which checks the device-tree
for known ISA devices. That would cover PREP, CHRP and pSeries at
least...

Ben.
