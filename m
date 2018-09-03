Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ua1-f67.google.com (mail-ua1-f67.google.com
 [209.85.222.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 423sfm310vzF37g
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 00:24:31 +1000 (AEST)
Received: by mail-ua1-f67.google.com with SMTP id u11-v6so517827uan.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Sep 2018 07:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180831225616.29221-1-jmkrzyszt@gmail.com>
 <20180902120144.6855-1-jmkrzyszt@gmail.com>
 <20180902120144.6855-2-jmkrzyszt@gmail.com>
 <20180903043129.GA17856@bombadil.infradead.org>
In-Reply-To: <20180903043129.GA17856@bombadil.infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Sep 2018 16:24:16 +0200
Message-ID: <CAMuHMdXU394+E3Z3tR-6iRSiWVDWUpxPLZdxg8zdgWxW5+SOOg@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
To: Matthew Wilcox <willy@infradead.org>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
 peter.korsgaard@barco.com, Peter Rosin <peda@axentia.se>,
 Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Greg KH <gregkh@linuxfoundation.org>,
 Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 Jiri Slaby <jslaby@suse.com>,
 Willy Tarreau <w@1wt.eu>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Linux I2C <linux-i2c@vger.kernel.org>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>, linux-iio@vger.kernel.org,
 driverdevel <devel@driverdev.osuosl.org>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 sebastien.bourdelin@savoirfairelinux.com,
 Lukas Wunner <lukas@wunner.de>, Rojhalat Ibrahim <imr@rtschenk.de>,
 Russell King <rmk+kernel@armlinux.org.uk>, ext Tony Lindgren <tony@atomide.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 3, 2018 at 6:31 AM Matthew Wilcox <willy@infradead.org> wrote:
> > +++ b/drivers/auxdisplay/hd44780.c
> > @@ -62,17 +62,12 @@ static void hd44780_strobe_gpio(struct hd44780 *hd)
> >  /* write to an LCD panel register in 8 bit GPIO mode */
> >  static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
> >  {
> > -     int values[10]; /* for DATA[0-7], RS, RW */
> > -     unsigned int i, n;
> > -
> > -     for (i = 0; i < 8; i++)
> > -             values[PIN_DATA0 + i] = !!(val & BIT(i));
> > -     values[PIN_CTRL_RS] = rs;
> > -     n = 9;
> > -     if (hd->pins[PIN_CTRL_RW]) {
> > -             values[PIN_CTRL_RW] = 0;
> > -             n++;
> > -     }
> > +     DECLARE_BITMAP(values, 10); /* for DATA[0-7], RS, RW */
> > +     unsigned int n;
> > +
> > +     *values = val;
> > +     __assign_bit(8, values, rs);
> > +     n = hd->pins[PIN_CTRL_RW] ? 10 : 9;
>
> Doesn't this assume little endian bitmaps?  Has anyone tested this on
> big-endian machines?

include/linux/bitops.h:

static __always_inline void __assign_bit(long nr, volatile unsigned long *addr,
                                         bool value)
{
        if (value)
                __set_bit(nr, addr);
        else
                __clear_bit(nr, addr);
}

include/asm-generic/bitops/non-atomic.h:

static inline void __set_bit(int nr, volatile unsigned long *addr)
{
        unsigned long mask = BIT_MASK(nr);
        unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);

        *p  |= mask;
}

include/linux/bits.h:

#define BIT_MASK(nr)            (1UL << ((nr) % BITS_PER_LONG))

Looks like native endianness to me.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
