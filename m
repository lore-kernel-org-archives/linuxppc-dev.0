Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191])
	by ozlabs.org (Postfix) with ESMTP id BEE1FDDE29
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 06:51:23 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1405469rvf
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Nov 2007 11:51:22 -0800 (PST)
Message-ID: <9e4733910711051151p18311586h133ac70917714466@mail.gmail.com>
Date: Mon, 5 Nov 2007 14:51:22 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
In-Reply-To: <472F6D5D.3030804@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
	<472F6D5D.3030804@genesi-usa.com>
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

On 11/5/07, Matt Sealey <matt@genesi-usa.com> wrote:
> Jon Smirl wrote:
>
> > i2c@3d40 {
> >       device_type = "i2c";
> >       compatible = "mpc5200b-i2c\0mpc5200-i2c\0fsl-i2c";
> >       cell-index = <1>;
> >       reg = <3d40 40>;
> >       interrupts = <2 10 0>;
> >       interrupt-parent = <&mpc5200_pic>;
> >       fsl5200-clocking;
> >
> >       rtc@32 {
> >               device_type = "rtc";
> >               compatible = "epson,pcf8564";
> >               reg = <51>;
> >       };
> > };
>
> My only comment would be that the fsl5200-clocking property is
> totally redundant.
>
> Drivers can look at the compatible property (mpc5200b-i2c and
> mpc5200-i2c) to match up what special needs the driver may need.
> Even if it was just fsl-i2c, it could/should be implicit that
> this device is the onboard i2c and the parent node is ostensibly
> going to be marked as an MPC52xx SoC.. or it can look for the
> mpc5200-cdm node. There is no reason to invent a property just
> so you can do a property search when it replaces code of the
> same size to do a node or compatible search..

fsl5200-clocking is used to set FSL_I2C_DEV_CLOCK_5200

	} else if (i2c->flags & FSL_I2C_DEV_CLOCK_5200)
		writeb(0x3f, i2c->base + MPC_I2C_FDR);
	else
		writel(0x1031, i2c->base + MPC_I2C_FDR);

I can change it to remove fsl5200-clocking if someone can tell me if
this is only needed on the mpc5200b. This driver also supports the
MPC107/Tsi107/MPC8240/MPC8245 and           MPC85xx/MPC8641. Do any of
these other chips need fsl5200-clocking?

-- 
Jon Smirl
jonsmirl@gmail.com
