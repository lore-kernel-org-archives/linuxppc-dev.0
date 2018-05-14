Return-Path: <peda@axentia.se>
Subject: Re: [PATCH 00/21] i2c: make use of i2c_8bit_addr_from_msg
To: Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc: Brendan Higgins <brendanhiggins@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Peter Korsgaard <jacmet@sunsite.dk>, Andy Gross <andy.gross@linaro.org>,
 David Brown <david.brown@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-i2c@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
References: <20180514145330.4857-1-peda@axentia.se>
 <c83bb5ddf36b419c4c01e20384c7b532c9a48cd4.camel@perches.com>
From: Peter Rosin <peda@axentia.se>
Message-ID: <29558f7d-1b80-8c6b-cd26-58cab6bc3ee1@axentia.se>
Date: Mon, 14 May 2018 19:01:23 +0200
MIME-Version: 1.0
In-Reply-To: <c83bb5ddf36b419c4c01e20384c7b532c9a48cd4.camel@perches.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2018-05-14 18:11, Joe Perches wrote:
> On Mon, 2018-05-14 at 16:53 +0200, Peter Rosin wrote:
>> Hi!
>>
>> The nice little inline i2c_8bit_addr_from_msg is not getting
>> enough use. This series improves the situation and drops a
>> bunch of lines in the process.
> 
> Perhaps the inline should test for I2C_M_REV_DIR_ADDR
> as there is at least one use like
> 
> -               addr = msg->addr << 1;
> -               if (flags & I2C_M_RD)
> -                       addr |= 1;
> +               addr = i2c_8bit_addr_from_msg(msg);
>                 if (flags & I2C_M_REV_DIR_ADDR)
>                         addr ^= 1;
> 
> which look odd

I say no, because the driver has to also indicate support with
I2C_FUNC_PROTOCOL_MANGLING and I don't see a sane way to check
that part of the contract. But what do I know. Seems orthogonal.

> Do any of these changes now no longer need
> the temporary flags variable?

Right, I thought I had made any obvious further simplification made
possible by these changes, but I overlooked that one. The flags
variable is certainly over-engineered in i2c-algo-pcf.c and would
be a good candidate for removal. But that's only patch 3/21.

I'll wait for a bit with an update, and Wolfram can adjust this on
the way in if he feels like it.

Cheers,
Peter
