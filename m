Return-Path: <joakim.tjernlund@transmode.se>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 20FD0B7089
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 06:00:01 +1000 (EST)
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5C08CDDDE6
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2009 05:59:58 +1000 (EST)
In-Reply-To: <20090713173455.GA9866@oksana.dev.rtsoft.ru>
References: <20090713151911.GA28114@oksana.dev.rtsoft.ru>
	<OFF188389D.68E638A2-ONC12575F2.00568C5B-C12575F2.0057FC95@transmode.se>
	<20090713173455.GA9866@oksana.dev.rtsoft.ru>
Subject: Re: [PATCH 0/2] Setting GPIOs simultaneously
To: avorontsov@ru.mvista.com
Message-ID: <OF9378E65D.FBBCCFD5-ONC12575F2.006B28D5-C12575F2.006DDAE5@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 13 Jul 2009 21:59:54 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Vorontsov <avorontsov@ru.mvista.com> wrote on 13/07/2009 19:34:55:
>
> On Mon, Jul 13, 2009 at 06:01:02PM +0200, Joakim Tjernlund wrote:
> >
> > Anton Vorontsov <avorontsov@ru.mvista.com> wrote on 13/07/2009 17:19:11:
> > >
> > > Hi all,
> > >
> > > I've been sitting on these patches for some time, but now it appears
> > > that the set_sync() feature is needed elsewhere. So here are the
> > > patches.
> > >
> > > Joakim, I think this is what you need.
> >
> > Yes, it sure looks so :) I will have to look closer later as
> > I will be traveling the next few days.
> >
> > Question though, have you considered using a bitmask instead of
> > an array:
> > static void qe_gpio_set_sync(struct gpio_chip *gc, unsigned int num,
> >                 unsigned int gpio_mask, unsigned int vals)
> > If you want to set bit 0, 3 and 8 you would set positions 0, 3 and 8 in gpio_mask
> > to ones. Similarly in vals, set bit positions 0, 3 and 8 to requested value.
>
> Yeah, I thought about it. We could do the u64 masks (to handle up
> to 64 bits parallel IO buses).
>
> It's all easy with dumb memory-mapped GPIO controllers, because
> we have a 8/16/32/64 bits registers with linear bit<->gpio mapping.

Yes, this is gpio ..

>
> But some gpio controllers aren't that easy. I know at least one
> (FPGA-based) gpio controller that won't change any GPIO lines
> for real unless changes are "commited". The controller has several
> banks (registers) of PIOs (total count > 64 bits), but you can commit
> all the changes to the banks at once (synchronously). This isn't
> because the controller is uber-cool, it's just the controller has
> sequential IO. So with masks approach you won't able to use _sync()
> calls that easily for all GPIOs range.

.. but this one I am not sure qualify as gpio. Feels more like
its own device that should have its own driver.

>
> But OK, if we throw away the special cases, I can't imagine any
> clear api for this approach, all I can think of is something
> along these lines:
>
> int num = 3;
> u32 gpios[3];
> u64 shifts[3];
>
> /* this implies checks whether we can use _sync() */
> if (!gpio_get_shifts(num, gpios, shifts))
>    return -EINVAL;
>
> gpio_set_values_sync(chip, 1 << shifts[0] | 1 << shifts[1],
>            val0 << shifts[0] | val1 << shifts[1]).
>
> We can implement it, if that's acceptable. But that's a bit
> ugly, I think.

I see, that doesn't look good that either.

>
> > While being at it, the reason for me needing this is that the spi_mpc83xx driver
> > was recently converted to a OF only driver so I have no way of defining my own
> > CS function anymore. While OF is good I don't feel that OF drivers should
> block the native
> > method, OF should be a layer on top of the native methods.
>
> Um, I don't get it. You have a mux, which is a sort of GPIO controller.
> All you need to do is to write "of-gpio-mux" driver, that will get all
> the needed gpios from the underlaying GPIO controller.

Well, I already have a mux controller that is using the native spi methods. I
don't want to write a new one, far more complicated than what I got now.
While the OF system is very powerful and flexible I still think that
one should be able to use native SPI methods too. Why can they not
co-exist?

>
> In the device tree it'll look like this:

I must admit that I just started to look at the GPIO subsystem, but
I do wonder if mpc83xx_spi_cs_control() can do this muxing
without any change.

Very good example BTW.

      Jocke
