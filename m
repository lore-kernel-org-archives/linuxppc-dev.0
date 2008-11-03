Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9EFE1DDE03
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 10:54:52 +1100 (EST)
Received: from [10.52.0.27] (natec.xes-mad.com [10.52.0.27])
	by xes-mad.com (8.13.8/8.13.8) with ESMTP id mA3Nsktn021067
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Nov 2008 17:54:46 -0600
Subject: Passing I2C platform_data from device tree to i2c driver
From: Nate Case <ncase@xes-inc.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 03 Nov 2008 17:54:46 -0600
Message-Id: <1225756486.27415.258.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is there a plan for providing a way to set pdata for an I2C chip in a
way that could be shared across all OF platforms?

For example, the pca953x I2C GPIO driver requires that pdata != NULL so
it can get the gpio_base field.  It can also take in a default 'invert'
value to initialize a chip register with.  Currently, there's no obvious
way to get this to work on PowerPC without hardcoding things in the
arch/powerpc/platforms/*.c file.

On ARM platforms, they currently handle this by declaring
I2C_BOARD_INFO() in their board-specific files.  For OF platforms, I
think the obvious choice would be to specify platform data in the device
tree.  We already register I2C devices automatically as found in the
device tree (see drivers/of/of_i2c.c), but this registration method does
not provide any way to set platform_data.

Of course, I could put some code in my board specific file to parse the
device tree properties and set pdata accordingly, but this hardly seems
ideal.  After all, the device tree bindings -> pdata translation itself
does not have to be board-specific.

Basically, I think we need to have some common code somewhere that does
the task of populating platform_data for a specific I2C chip based on a
device tree node -- similarly to how we register the I2C devices
already.  Is anyone working on this?  Did anyone have anything else in
mind?

-- 
Nate Case <ncase@xes-inc.com>
