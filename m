Return-Path: <robherring2@gmail.com>
Received: from mail-io0-f195.google.com (mail-io0-f195.google.com
 [209.85.223.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7fT93wGpzDqFJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 10:12:45 +1000 (AEST)
Received: by mail-io0-f195.google.com with SMTP id h41so9231892ioi.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 17:12:45 -0700 (PDT)
Date: Wed, 19 Apr 2017 19:12:42 -0500
From: Rob Herring <robh@kernel.org>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
 =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
 Stuart Yoder <stuart.yoder@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
 David Lechner <david@lechnology.com>, linux-i2c@vger.kernel.org,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Peter Rosin <peda@axentia.se>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Jackson <mpfj@newflow.co.uk>, Fabio Estevam <fabio.estevam@nxp.com>,
 Simon Horman <horms@verge.net.au>, Michal Simek <michal.simek@xilinx.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Shawn Guo <shawnguo@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Florian Larysch <fl@n621.de>, Magnus Damm <magnus.damm@gmail.com>,
 devicetree@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Sekhar Nori <nsekhar@ti.com>, Scott Wood <oss@buserror.net>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Joachim Eastwood <manabian@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jason Cooper <jason@lakedaemon.net>,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-renesas-soc@vger.kernel.org,
 Hongtao Jia <hongtao.jia@nxp.com>, Tony Lindgren <tony@atomide.com>,
 Paul Mackerras <paulus@samba.org>, Mark Rutland <mark.rutland@arm.com>,
 Dinh Nguyen <dinguyen@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Subject: Re: [PATCH v3 00/21] eeprom: at24: Add OF device ID table
Message-ID: <20170420001242.vl3sga2bd65jlaoi@rob-hp-laptop>
References: <20170414010445.21727-1-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170414010445.21727-1-javier@osg.samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 13, 2017 at 10:04:24PM -0300, Javier Martinez Canillas wrote:
> Hello Wolfram,
> 
> This series is a follow-up to patch [0] that added an OF device ID table
> to the at24 EEPROM driver. As you suggested [1], this version instead of
> adding entries for every used <vendor,device> tuple, only adds a single
> entry for each chip type using the "atmel" vendor as a generic fallback.
> 
> The first patch adds the OF device ID table for the at24 driver and the
> next patches adds a generic fallback compatible string to each DTS that
> defines a compatible I2C EEPROM device node.
> 
> Patches can be applied independently since the DTS change without the
> driver change is a no-op and the OF device table won't be used without
> the DTS changes.
> 
> [0]: https://lkml.org/lkml/2017/3/14/589

I don't have this patch in my inbox, but the i2c core will still match 
on compatibles with no vendor prefix? If not, those need to be added to 
the match table too.

Rob
