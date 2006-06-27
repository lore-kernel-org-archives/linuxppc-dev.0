Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 78A8867A60
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 08:58:10 +1000 (EST)
Date: Tue, 27 Jun 2006 15:54:01 -0700
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Do a bit more cpu init cleanups
Message-ID: <20060627225401.GC5130@pb15.lixom.net>
References: <20060627192206.GB5130@pb15.lixom.net>
	<1151446849.2350.95.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1151446849.2350.95.camel@localhost.localdomain>
From: Olof Johansson <olof@lixom.net>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 28, 2006 at 08:20:48AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2006-06-27 at 12:22 -0700, Olof Johansson wrote:
> > Cleanup CPU inits a bit more, Geoff Levand already did some earlier.
> > 
> > * Rename cpu_setup_power4.S to cpu_setup_ppc970.S
> 
> > * Move CPU state save to cpu_setup, since cpu_setup is only ever done
> >   on cpu 0 on 64-bit.
> 
> Nah, keep that one separate, will be needed as soon as we start doing
> some sleep/wake stuff for ppc64

Why? I can see having to restore the settings on wake, but not doing a
brand new cpu_setup.

> > * Rename __restore_cpu_setup to __restore_cpu_setup_ppc970 since it's
> >   only actually doing anything there, and check before calling instead
> >   of in the function (no check needed on powermac).
> 
> I'd like to keep a generic save/restore.. that or we put then in
> cputable.

Keep? There never was one. :)

Since restore is called very first thing in smp secondary init, we don't
have cputable available.

> > * Same for __970_cpu_preinit
> > * Rename pSeries_secondary_smp_init to generic_secondary_smp_init since
> >   everyone but powermac and iSeries use it.
> 
> Ok.


-Olof
