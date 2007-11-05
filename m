Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id B83B9DDE27
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 07:11:41 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d23so235192and
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Nov 2007 12:11:40 -0800 (PST)
Message-ID: <fa686aa40711051211q3629af50n92e79107520ec10d@mail.gmail.com>
Date: Mon, 5 Nov 2007 13:11:40 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
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

Yeah, I agree.  Drop the fsl-clocking property.  The hardware is
adequately described without it.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
