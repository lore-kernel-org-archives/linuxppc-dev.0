Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mpic: don't reset affinity for secondary MPIC
	on boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200811211540.03281.arnd@arndb.de>
References: <200811191450.59361.arnd@arndb.de>
	<200811201823.25263.arnd@arndb.de> <1227235450.7185.214.camel@pasglop>
	<200811211540.03281.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 22 Nov 2008 09:33:00 +1100
Message-Id: <1227306780.7185.249.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kexec@lists.infradead.org,
	cbe-oss-dev@ozlabs.org, Max Krasnyansky <maxk@qualcomm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-11-21 at 15:40 +0100, Arnd Bergmann wrote:
> On Friday 21 November 2008, Benjamin Herrenschmidt wrote:
> > Oh just that for powermac for example, I know I'm resetting the thing,
> > so can't rely on init values, and on some BML embedded boxes too, while
> > on things like cell I don't off hand know what the right CPU number is
> > to hit the right C3PO interrupt, so I'm better off reading what SLOF
> > did :-)
> 
> The current code will always use destination 0 for any MPIC, because
> mpic_init is run befew smp_init and it currently uses the local CPU.
> 
> If an SMP powermac requires a specific destination setting in the
> secondary MPIC, either the current mpic_init code is broken there
> in the same way as on cell, or more broken if it requires something
> other than destination 0.
> 
> > But if you think on Cell we can just hard wire in the platform code,
> > then I'm ok.
> 
> On cell, I know that destination 0 is always correct because of the wiring
> inside of Axon.

Ok so -all- existing instances only care about destination 0, we may
just hard code that in MPIC for now :-)

Cheers,
Ben.
