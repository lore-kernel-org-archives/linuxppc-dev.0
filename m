Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 19A1ADE3F0
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 01:51:57 +1000 (EST)
Message-ID: <48480BA0.2060500@scram.de>
Date: Thu, 05 Jun 2008 17:52:00 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
References: <200806041706.21557.sr@denx.de>
	<4846B39F.3010601@freescale.com>	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>	<20080604211942.2bddc860@zod.rchland.ibm.com>	<4848028B.5060105@freescale.com>
	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>
In-Reply-To: <fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grant,

> if you need explicit indexing then use an alias.  My opinion however
> is that explicit indexing is unnecessary and is just an artifact of
> current i2c subsystem internals.  There is already enough information
> in the device tree to match i2c devices with i2c busses without
> resorting to indexes.

True. However, there are currently drivers which need platform data for
its initialisation (like drivers/gpio/pca953x.c). Unless these drivers
are rewritten, they can't be loaded just by parsing the device tree, so
they must be loaded from platform init code and here the adapter index
is needed to attach the driver.

Thanks,
Jochen
