Return-Path: <dgibson@ozlabs.org>
Date: Tue, 18 Nov 2008 11:40:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: powerpc: udbg based backend for hvc_console
Message-ID: <20081118004005.GC26336@yookeroo.seuss>
References: <20081024035434.GF4267@yookeroo.seuss>
	<ed82fe3e0811171204y4e8de21dy18f5b332b7f05f1f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ed82fe3e0811171204y4e8de21dy18f5b332b7f05f1f@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 17, 2008 at 02:04:38PM -0600, Timur Tabi wrote:
> On Thu, Oct 23, 2008 at 9:54 PM, David Gibson
> <david@gibson.dropbear.id.au> wrote:
> 
> > This can be used to quickly implement a userspace usable console while
> > you're working on a proper driver for whatever console I/O device the
> > hardware has.  Or, it can be used to avoid writing a full blown
> > tty/console driver entirely for quick-and-dirty I/O hardware that will
> > later be replaced by something else.
> 
> Ok, I think I understand this better now.
> 
> Your approach seems backwards to me.  HVC console client drivers
> already have simple put/get functions.  You've written an hvc driver
> that makes udbg calls.  Wouldn't it have been better to make a udbg
> driver that makes hvc calls?  That way, you effectively give udbg
> support to all hvc drivers in one shot.

Well, except that hvc calls aren't necessarily safe in the context
that udbg calls are made.  The idea here is that you want to implement
udbg during bringup anyway, to get really early debug info.  This
means that you can then use that udbg support to get a full console.

> In order to support udbg in my hvc driver, I have to add udbg calls.
> In fact, now that I've thought about it, I don't understand what your
> driver does.  You take hvc callbacks and route them through udbg, but
> this only works on drivers that have udbg callbacks in the first
> place.  In that case, why would these drivers need an hvc middle-man?

Because the udbg console works for kernel messages, but doesn't
support a full tty interface, so you can't run userspace with only a
udbg console.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
