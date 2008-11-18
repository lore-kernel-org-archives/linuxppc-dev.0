Return-Path: <dgibson@ozlabs.org>
Date: Tue, 18 Nov 2008 16:14:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: powerpc: udbg based backend for hvc_console
Message-ID: <20081118051408.GM26336@yookeroo.seuss>
References: <20081024035434.GF4267@yookeroo.seuss>
	<ed82fe3e0811171204y4e8de21dy18f5b332b7f05f1f@mail.gmail.com>
	<20081118004005.GC26336@yookeroo.seuss>
	<ed82fe3e0811172042r1d4887f8n76682e0b21555372@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ed82fe3e0811172042r1d4887f8n76682e0b21555372@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 17, 2008 at 10:42:46PM -0600, Timur Tabi wrote:
> On Mon, Nov 17, 2008 at 6:40 PM, David Gibson
> <david@gibson.dropbear.id.au> wrote:
> 
> > Because the udbg console works for kernel messages, but doesn't
> > support a full tty interface, so you can't run userspace with only a
> > udbg console.
> 
> I still don't understand the point of your driver.  You're just
> routing hcalls to a udbg back-end.  So if you have a driver that
> supports udbg but not standard console or TTY, then you can use your
> driver to get console/tty I/O.  Is there a platform where such a setup
> exists?  All HVC drivers support console and TTY, as do all serial
> drivers.  So what platform would use your driver?

Like I said, it's a bringup hack.  If you have hardware that's
supported by an existing console driver, there's no reason you'd want
it.

For example, I've used it on a bringup prototype platform whose only
I/O is a weird FPGA-implemented UART (not 8250 compatible, or even
close).  I implemented udbg callbacks as one of the first things I
did, to get the early debugging.  But eventually I got userspace up,
and discovered that it wouldn't work on the udbg consoleuserspace
won't work with the udbg console.  I didn't really want to write
another, more complex, driver for this strange UART, so I glued
hvconsole to my existing udbg callbacks, giving me a userspace-capable
console.

Given the variety of strange I/O configurations in prototype and
embedded platforms, I can't imagine this was a unique situation.  So
I've pushed my patch out, so anyone else in a similar situation can
immediately turn their little udbg methods for whatever strange I/O
they have into a fully-functional console.  Maybe it's not something
you'd want to go to release with, but it certainly simplifies life
during bringup.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
