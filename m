Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f203.google.com (mail-iw0-f203.google.com
	[209.85.223.203]) by ozlabs.org (Postfix) with ESMTP id CCBFFB7D56
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 04:28:36 +1100 (EST)
Received: by iwn41 with SMTP id 41so2861139iwn.9
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Feb 2010 09:28:35 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100205205045.GC4178@oksana.dev.rtsoft.ru>
References: <20100205204949.GA2575@oksana.dev.rtsoft.ru>
	<20100205205045.GC4178@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 9 Feb 2010 10:28:15 -0700
Message-ID: <fa686aa41002090928o6911d095ydca1e1e670a0fc22@mail.gmail.com>
Subject: Re: [PATCH 3/3] of/gpio: Introduce of_put_gpio(), add ref counting
	for OF GPIO chips
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michal Simek <monstr@monstr.eu>,
	David Brownell <dbrownell@users.sourceforge.net>,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 5, 2010 at 1:50 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> OF GPIO infrastructure is using dynamic GPIO bases, so it is possible
> that of_get_gpio()'s returned GPIO number will be no longer valid, or
> worse, it may point to an unexpected GPIO controller.
>
> This scenario is possible:
>
> driver A: =A0 =A0 =A0 =A0 =A0 =A0 =A0 driver B: =A0 =A0 =A0 =A0 =A0 =A0 =
=A0driver C:
> --------- =A0 =A0 =A0 =A0 =A0 =A0 =A0 --------- =A0 =A0 =A0 =A0 =A0 =A0 =
=A0---------
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpiochip_add()
> gpio =3D of_get_gpio()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpiochip_remove()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 gpiochip_add()
> gpio_request(gpio);
> gpio_set_value(gpio);
>
> That is, driver A assumes that it is working with GPIO from driver B,
> but in practice it may disappear and driver C will take its GPIO base
> number, so it will provide the same GPIO numbers.
>
> With this patch that situation is no longer possible. Though drivers
> will need to learn to put GPIOs back, so that GPIO controllers could
> be removed.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Rather than having a lock at the device tree data pointer level which
mixes usage with potentially many other drivers; wouldn't it make more
sense to use a mutex at the of_gc subsystem context?

g.
