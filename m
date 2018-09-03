Return-Path: <willy@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 423d0D5zJvzF399
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Sep 2018 14:53:48 +1000 (AEST)
Date: Sun, 2 Sep 2018 21:31:29 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
 Peter Korsgaard <peter.korsgaard@barco.com>,
 Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
 Lukas Wunner <lukas@wunner.de>, Rojhalat Ibrahim <imr@rtschenk.de>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Tony Lindgren <tony@atomide.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v7 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
Message-ID: <20180903043129.GA17856@bombadil.infradead.org>
References: <20180831225616.29221-1-jmkrzyszt@gmail.com>
 <20180902120144.6855-1-jmkrzyszt@gmail.com>
 <20180902120144.6855-2-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180902120144.6855-2-jmkrzyszt@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +++ b/drivers/auxdisplay/hd44780.c
> @@ -62,17 +62,12 @@ static void hd44780_strobe_gpio(struct hd44780 *hd)
>  /* write to an LCD panel register in 8 bit GPIO mode */
>  static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
>  {
> -	int values[10];	/* for DATA[0-7], RS, RW */
> -	unsigned int i, n;
> -
> -	for (i = 0; i < 8; i++)
> -		values[PIN_DATA0 + i] = !!(val & BIT(i));
> -	values[PIN_CTRL_RS] = rs;
> -	n = 9;
> -	if (hd->pins[PIN_CTRL_RW]) {
> -		values[PIN_CTRL_RW] = 0;
> -		n++;
> -	}
> +	DECLARE_BITMAP(values, 10); /* for DATA[0-7], RS, RW */
> +	unsigned int n;
> +
> +	*values = val;
> +	__assign_bit(8, values, rs);
> +	n = hd->pins[PIN_CTRL_RW] ? 10 : 9;

Doesn't this assume little endian bitmaps?  Has anyone tested this on
big-endian machines?
