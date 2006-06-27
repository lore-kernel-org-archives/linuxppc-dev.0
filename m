Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 365D567A42
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 09:48:30 +1000 (EST)
Date: Tue, 27 Jun 2006 16:48:01 -0700
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Do a bit more cpu init cleanups
Message-ID: <20060627234801.GD5130@pb15.lixom.net>
References: <20060627192206.GB5130@pb15.lixom.net>
	<1151446849.2350.95.camel@localhost.localdomain>
	<20060627225401.GC5130@pb15.lixom.net>
	<1151449661.2350.106.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1151449661.2350.106.camel@localhost.localdomain>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 28, 2006 at 09:07:41AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2006-06-27 at 15:54 -0700, Olof Johansson wrote:
> > On Wed, Jun 28, 2006 at 08:20:48AM +1000, Benjamin Herrenschmidt wrote:
> > > On Tue, 2006-06-27 at 12:22 -0700, Olof Johansson wrote:
> > > > Cleanup CPU inits a bit more, Geoff Levand already did some earlier.
> > > > 
> > > > * Rename cpu_setup_power4.S to cpu_setup_ppc970.S
> > > 
> > > > * Move CPU state save to cpu_setup, since cpu_setup is only ever done
> > > >   on cpu 0 on 64-bit.
> > > 
> > > Nah, keep that one separate, will be needed as soon as we start doing
> > > some sleep/wake stuff for ppc64
> > 
> > Why? I can see having to restore the settings on wake, but not doing a
> > brand new cpu_setup.
> 
> No, a new save, not setup.

I prefer to join them for now. I'm not convinced resaving is the best way
to go for sleep/wake, HID defaults are saved during boot. If other bits
have been flipped, chances are there's higher-level code that needs to
be aware and do things on resume anyway, and they can just set the bit
again there (i.e. platform suspend/resume handlers).

So, I prefer to keep the change as-is until there's code that shows the
neccessity of having it the other way.

> > > > * Rename __restore_cpu_setup to __restore_cpu_setup_ppc970 since it's
> > > >   only actually doing anything there, and check before calling instead
> > > >   of in the function (no check needed on powermac).
> > > 
> > > I'd like to keep a generic save/restore.. that or we put then in
> > > cputable.
> > 
> > Keep? There never was one. :)
> 
> There is one for 32 bits :)

I didn't change any 32-bit code, so it's still there! :)  (see below)

> > Since restore is called very first thing in smp secondary init, we don't
> > have cputable available.
> 
> We could easily

Yeah, on second look it wouldn't be hard. I'll add it to the cputable
and use those pointers. It'll get rid of one of the PVR checks too.


-Olof
