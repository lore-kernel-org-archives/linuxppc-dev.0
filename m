Return-Path: <cbouatmailru@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by ozlabs.org (Postfix) with ESMTP id 64961DDF52
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 12:03:12 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so437769nfd.9
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 17:03:11 -0800 (PST)
Date: Thu, 13 Dec 2007 03:53:45 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH/RFC] CPM1: implement GPIO API
Message-ID: <20071213005345.GA1577@zarina>
References: <47600F5E.8060907@scram.de> <200712122316.34354.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200712122316.34354.arnd@arndb.de>
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

On Wed, Dec 12, 2007 at 11:16:33PM +0100, Arnd Bergmann wrote:
> On Wednesday 12 December 2007, Jochen Friedrich wrote:
> 
> > +static spinlock_t *cpm1_port_locks;
> > +static int cpm1_num_ports;
> 
> Having an array of spinlocks is rather unusual and normally not necessary.
> Did you measure a significant performance impact by using a global lock
> for all ports?
> If not, I would recommend simplifying this.

I disagree. Why should we force bank A to stomp on bank B, if we can
prevent this in few lines of trivial code? It doesn't need any measuring
or simplifying IMO, what's so complexing in array of spinlocks guarding
array of banks?

But, you can repeat that you really want to get rid of this array --
and I'll silently remove it. Not because I gave up, but mostly because
with gpiolib we'll able to embed spinlock into per-bank gpio_chip
structure, thus eventually they will come back. :-))

> > +EXPORT_SYMBOL_GPL(gpio_request);
> > +EXPORT_SYMBOL_GPL(gpio_direction_input);
> > +EXPORT_SYMBOL_GPL(gpio_direction_output);
> > +EXPORT_SYMBOL_GPL(gpio_get_value);
> > +EXPORT_SYMBOL_GPL(gpio_set_value);
> 
> All these function names are rather generic identifiers, but you export them
> from a platform specific file. I'd say they should either have a more specific
> name space (e.g. cpm1_gpio_request), or should be implemented in a more
> generic way.

No. This is how gpio api is working currently. With gpiolib[1], most of
these functions will be controller-specific. IIRC, gpiolib is still in
early development stage, so, for now, we have to limit us to one gpio
chip controller.

This works great for us: CPM, CPM2 and QE shouldn't appear on the single
crystal.

I'm not sure if gpiolib will hit 2.6.25, really. Maybe not. So I'd rather
stick with limited gpio api, and later convert it to gpiolib -- it will be
really trivial. Just rename functions and wrap them around gpio_chip
structure.

The bright side of smooth transition is that API itself isn't changing,
GPIO API/GPIOLIB API is fully interchangeable, their differences are
in implementation details.

[1] http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.24-rc4/2.6.24-rc4-mm1/broken-out/generic-gpio-gpio_chip-support.patch

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
