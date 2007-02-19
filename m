Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/3] zImage: Cleanup and improve zImage entry point
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <45DA0AA4.3020107@am.sony.com>
References: <20070216062739.6DFDBDDD05@ozlabs.org>
	<45D7AA50.3090408@am.sony.com>
	<1171915022.18571.50.camel@localhost.localdomain>
	<45DA0AA4.3020107@am.sony.com>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 07:50:06 +1100
Message-Id: <1171918206.18571.66.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-02-19 at 12:37 -0800, Geoff Levand wrote:
> Benjamin Herrenschmidt wrote:
> >> This messed me up a bit since I had two stacks in the bss, one for each
> >> processor thread.  By the time this was called on the primary thread the
> >> secondary thread could already be using its stack.  I changed the secondary
> >> thread to use a small stack in the data section, so this seems OK.
> > 
> > The secondary thread(s) don't need a stack to loop in secondary hold,
> > right ? So maybe we could go all the way without using a stack. Do we
> > need C code at all for them ? We just need to hold them until we make
> > them branch to the kernel.
> 
> I thought it would be nice to be able to use printf() in there so you
> see the following.  Its handy for debugging.
> 
> smp_secondary_hold:307: released cpu (1)

The problem is if your secondary CPUs start using printf etc... that
means you probably need to get in some locking primitives and make
various bits of the zImage wrapper SMP safe... pretty scary don't you
think ? :-)

I'd rather leave all non-0 CPUs in an asm holding loop. However, you can
still print some status. One of the ideas is to have them fill up a
byte-map of present CPUs when they get in the holding loop, then the
main CPU can "see" them coming in and print something.

Ben.
