Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ADD9C2C0146
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jul 2013 19:18:32 +1000 (EST)
Date: Thu, 18 Jul 2013 10:17:35 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v1 05/24] clk: wrap I/O access for improved portability
Message-ID: <20130718091735.GW24642@n2100.arm.linux.org.uk>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1373914074-20889-6-git-send-email-gsi@denx.de>
 <20130715193829.GS14452@pengutronix.de>
 <20130718070402.GO7080@book.gsilab.sittig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130718070402.GO7080@book.gsilab.sittig.org>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <rob.herring@calxeda.com>,
 David Woodhouse <dwmw2@infradead.org>, Mark Brown <broonie@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-arm-kernel@lists.infradead.org,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 devicetree-discuss@lists.ozlabs.org, Wolfgang Grandegger <wg@grandegger.com>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 18, 2013 at 09:04:02AM +0200, Gerhard Sittig wrote:
> The common clock API assumes (it's part of the contract) that
> there are potentially expensive operations like get, put, prepare
> and unprepare, as well as swift and non-blocking operations like
> enable and disable.

Let's get something straight here, because what you've said above is
wrong.

1. clk_get() and clk_put() are NOT part of the common clock API.
   They're separate - they're part of the clk API, and the infrastructure
   behind that is clkdev, which is a separately owned thing (by me.)

2. The "contract" of the clk API is defined by the clk API, not by some
   random implementation like the common clock API.  The clk API is
   maintained by myself, and is described in include/linux/clk.h

3. clk_prepare() and clk_unprepare() are functions MUST only be called
   from contexts where sleeping is permitted.  These functions MAY sleep
   for whatever reason they require to, and as long as they require to.
   (This is the whole reason these two functions were created in the
   first place.)

4. clk_enable() and clk_disable() MAY be called from any context, but
   MUST never sleep.  If you need to talk over a non-atomic bus for these,
   then these functions should be no-ops, and the code which does that
   must be executed from the clk_prepare()/clk_unprepare() operations.

That is the "clk API" contract.  The CCF has no bearing on this; if it
disagrees, then the CCF is buggy and is non-conformant.
