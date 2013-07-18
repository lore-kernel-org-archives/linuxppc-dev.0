Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7DFD32C0099
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2013 06:33:43 +1000 (EST)
Date: Thu, 18 Jul 2013 21:33:24 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v2 18/24] i2c: mpc: OF clock lookup for MPC512x
Message-ID: <20130718203324.GB24642@n2100.arm.linux.org.uk>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374178858-8683-4-git-send-email-gsi@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374178858-8683-4-git-send-email-gsi@denx.de>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>,
 Mark Brown <broonie@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Wolfgang Grandegger <wg@grandegger.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 18, 2013 at 10:20:52PM +0200, Gerhard Sittig wrote:
> +	/* enable clock for the I2C peripheral (non fatal) */
> +	clk = of_clk_get_by_name(node, "per");
> +	if (!IS_ERR(clk)) {
> +		clk_prepare_enable(clk);
> +		clk_put(clk);
> +	}
> +

This kind of hacked up approach to the clk API is exactly the thing I
really don't like seeing.  I don't know what it is... is the clk API
somehow difficult to use or what's the problem with doing stuff correctly?

1. Get the clock in your probe function.
2. Prepare it at the appropriate time.
3. Enable it appropriately.  (or if you want to combine 2 and 3, use
   clk_prepare_enable().)
4. Ensure that enables/disables and prepares/unprepares are appropriately
   balanced.
5. 'put' the clock in your remove function.

Certainly do not get-enable-put a clock.  You're supposed to hold on to
the clock all the time that you're actually using it.

Final point - if you want to make it non-fatal, don't play games like:

	clk = clk_get(whatever);
	if (IS_ERR(clk))
		clk = NULL;

	...
	if (clk)
		clk_prepare(clk);

Do this instead:

	clk = clk_get(whatever);
	...

	if (!IS_ERR(clk))
		clk_prepare(clk);
etc.

(And on this subject, I'm considering whether to make a change to the
clk API where clk_prepare() and clk_enable() return zero when passed
an error pointer - this means drivers with optional clocks don't have
to burden themselves with these kinds of checks.)
