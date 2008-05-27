Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 72817DE071
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 01:35:28 +1000 (EST)
Message-ID: <483C2A33.1020309@scram.de>
Date: Tue, 27 May 2008 17:35:15 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: How to set device's platform_data field for OF-described I2C
	devices ?
References: <200805271348.06470.laurentp@cse-semaphore.com>
In-Reply-To: <200805271348.06470.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org, Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Laurent,

> I'm running into a small issue with the pca953x I2C GPIO driver. The driver 
> requires platform data (to set the GPIO base number among other information). 
> As the device is automatically instantiated from the OF device tree, I can't 
> find a way to add platform data in the process.

Platform data really is a problem for devices loaded by OF device trees (see the
discussion at http://ozlabs.org/pipermail/linuxppc-dev/2008-May/056728.html and
in particular http://ozlabs.org/pipermail/linuxppc-dev/2008-May/056752.html).

In case of this particular chip it might be feasible to support the new libgpio
API to get a GPIO base number dynamically and use some defaults for the other
platform data to enable the chip to be used without platform data.

Otherwise, you could only bypass the OF bindings totally and add the device
manually from platform code with the platform data filled in.

> What's the best way to specify platform data for OF-described I2C devices ?

This depends on the data. For example function pointers can't be described in the
device tree, at all.

Thanks,
Jochen
