Return-Path: <joe@perches.com>
Message-ID: <c83bb5ddf36b419c4c01e20384c7b532c9a48cd4.camel@perches.com>
Subject: Re: [PATCH 00/21] i2c: make use of i2c_8bit_addr_from_msg
From: Joe Perches <joe@perches.com>
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Cc: Brendan Higgins <brendanhiggins@google.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@aj.id.au>, Guenter Roeck <linux@roeck-us.net>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>,  Peter Korsgaard <jacmet@sunsite.dk>,
 Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-i2c@vger.kernel.org,
 openbmc@lists.ozlabs.org,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org,  linuxppc-dev@lists.ozlabs.org,
 linux-arm-msm@vger.kernel.org,  linux-soc@vger.kernel.org
Date: Mon, 14 May 2018 09:11:57 -0700
In-Reply-To: <20180514145330.4857-1-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-05-14 at 16:53 +0200, Peter Rosin wrote:
> Hi!
> 
> The nice little inline i2c_8bit_addr_from_msg is not getting
> enough use. This series improves the situation and drops a
> bunch of lines in the process.

Perhaps the inline should test for I2C_M_REV_DIR_ADDR
as there is at least one use like

-               addr = msg->addr << 1;
-               if (flags & I2C_M_RD)
-                       addr |= 1;
+               addr = i2c_8bit_addr_from_msg(msg);
                if (flags & I2C_M_REV_DIR_ADDR)
                        addr ^= 1;

which look odd

Do any of these changes now no longer need
the temporary flags variable?
