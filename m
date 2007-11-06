Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 14EC6DDE0D
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 05:36:58 +1100 (EST)
Message-ID: <4730B27B.8000505@freescale.com>
Date: Tue, 06 Nov 2007 12:29:15 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>	<472F7247.9070106@freescale.com>	<9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>	<472F8267.8070106@freescale.com>	<20071106182953.3c1a57e3@hyperion.delvare>	<4730A617.9040502@freescale.com>
	<20071106191039.37cd7053@hyperion.delvare>
In-Reply-To: <20071106191039.37cd7053@hyperion.delvare>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Tjernlund <tjernlund@tjernlund.se>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jean Delvare wrote:
> Sorry, I've not been completely clear. Yes, you can use
> i2c_new_device() on an adapter that has been added with
> i2c_add_adapter(). However, this requires that you have a reference to
> that i2c_adapter, which is usually not the case with system-wide I2C
> buses.

But it is the case here, because the i2c driver knows about the device 
tree, and thus can pass the device tree node and the adapter struct to 
the enumeration function.

The driver should still do i2c_add_numbered_adapter() when using the 
non-OF platform device binding, in which case it gets the bus number 
from the platform data.

-Scott
