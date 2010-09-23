Return-Path: <mikpe@it.uu.se>
Received: from fanny.its.uu.se (fanny.its.uu.se [130.238.4.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A82E3B70CE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Sep 2010 22:17:13 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19611.16302.262307.129176@pilspetsen.it.uu.se>
Date: Thu, 23 Sep 2010 13:53:18 +0200
From: Mikael Pettersson <mikpe@it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [BUG 2.6.36-rc5] of_i2c.ko <-> i2c-core.ko dependency loop
Cc: linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Running modules_install from a newly built 2.6.36-rc5 kernel
on my 32-bit PowerMac results in:

WARNING: Module /lib/modules/2.6.36-rc5/kernel/drivers/i2c/busses/i2c-powermac.ko ignored, due to loop
WARNING: Loop detected: /lib/modules/2.6.36-rc5/kernel/drivers/i2c/i2c-core.ko needs of_i2c.ko which needs i2c-core.ko again!
WARNING: Module /lib/modules/2.6.36-rc5/kernel/drivers/i2c/i2c-core.ko ignored, due to loop
WARNING: Module /lib/modules/2.6.36-rc5/kernel/drivers/i2c/i2c-dev.ko ignored, due to loop
WARNING: Module /lib/modules/2.6.36-rc5/kernel/drivers/of/of_i2c.ko ignored, due to loop
WARNING: Module /lib/modules/2.6.36-rc5/kernel/sound/ppc/snd-powermac.ko ignored, due to loop

> grep '.*I2C.*=' .config
CONFIG_OF_I2C=m
CONFIG_I2C=m
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_POWERMAC=m

I can't say exactly when this started, haven't built kernels on this
box in a while.

/Mikael
