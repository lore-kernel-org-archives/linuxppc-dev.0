Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C520DDDDE4
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 06:19:49 +1100 (EST)
Message-ID: <472F6D5D.3030804@genesi-usa.com>
Date: Mon, 05 Nov 2007 19:22:05 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
In-Reply-To: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Tjernlund <tjernlund@tjernlund.se>, linuxppc-dev@ozlabs.org,
	Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

> i2c@3d40 {
> 	device_type = "i2c";
> 	compatible = "mpc5200b-i2c\0mpc5200-i2c\0fsl-i2c";
> 	cell-index = <1>;
> 	reg = <3d40 40>;
> 	interrupts = <2 10 0>;
> 	interrupt-parent = <&mpc5200_pic>;
> 	fsl5200-clocking;
> 
> 	rtc@32 {
> 		device_type = "rtc";
> 		compatible = "epson,pcf8564";
> 		reg = <51>;
> 	};
> };

My only comment would be that the fsl5200-clocking property is
totally redundant.

Drivers can look at the compatible property (mpc5200b-i2c and
mpc5200-i2c) to match up what special needs the driver may need.
Even if it was just fsl-i2c, it could/should be implicit that
this device is the onboard i2c and the parent node is ostensibly
going to be marked as an MPC52xx SoC.. or it can look for the
mpc5200-cdm node. There is no reason to invent a property just
so you can do a property search when it replaces code of the
same size to do a node or compatible search..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
