Return-Path: <cbouatmailru@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.188])
	by ozlabs.org (Postfix) with ESMTP id 30D2BDDDF4
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 11:08:28 +1100 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so860835fkz.9
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 16:08:26 -0800 (PST)
Date: Sat, 22 Dec 2007 02:58:02 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/4] [POWERPC] CPM2: implement GPIO API
Message-ID: <20071221235802.GA3651@zarina>
References: <20071221202824.GA4607@localhost.localdomain>
	<20071221203123.GC4633@localhost.localdomain>
	<200712212216.32922.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200712212216.32922.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 21, 2007 at 10:16:32PM +0100, Arnd Bergmann wrote:
> On Friday 21 December 2007, Anton Vorontsov wrote:
> >  
> > +static spinlock_t cpm2_port_lock = __SPIN_LOCK_UNLOCKED(cpm2_port_lock);
> 
> This needs to be
> 
> static DEFINE_SPINLOCK(cpm2_port_lock);

These are equivalents.

#define DEFINE_SPINLOCK(x)      spinlock_t x = __SPIN_LOCK_UNLOCKED(x)

> I think at least lockdep doesn't work the way you do it here.

Is it anyhow special regarding what exact macro is used?..

spinlocks.txt says:

SPIN_LOCK_UNLOCKED and RW_LOCK_UNLOCKED defeat lockdep state tracking and
are hence deprecated.

Please use DEFINE_SPINLOCK()/DEFINE_RWLOCK() or
__SPIN_LOCK_UNLOCKED()/__RW_LOCK_UNLOCKED() as appropriate for static
initialization.
-

..should be equivalent, though I prefer open-coded version, until
it fits 80 column width. ;-)

> > +int cpm2_init_par_io(void)
> > +{
> > +	struct device_node *np;
> > +	const u32 *num_ports;
> > +
> > +	np = of_find_compatible_node(NULL, NULL, "fsl,cpm2-pario");
> > +	if (!np)
> > +		return -ENOENT;
> > +
> > +	num_ports = of_get_property(np, "num-ports", NULL);
> > +	if (!num_ports) {
> > +		of_node_put(np);
> > +		return -ENOENT;
> > +	}
> > +	cpm2_num_ports = *num_ports;
> > +
> > +	np->data = &of_gpio_chip;
> > +
> > +	return 0;
> > +}
> 
> This function should also do the call to of_iomap, so you don't
> need to pull the address out of the cpm2_immr, which I believe
> we're trying to get rid of.

Yup, thanks!

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
