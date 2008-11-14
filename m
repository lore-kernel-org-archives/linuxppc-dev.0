Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id B0B1DDDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Nov 2008 06:09:55 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so666916ywh.39
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 11:09:53 -0800 (PST)
Message-ID: <fa686aa40811141109v2892236fj5f8f85a64537cbb3@mail.gmail.com>
Date: Fri, 14 Nov 2008 12:09:53 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "=?ISO-8859-1?Q?Ren=E9_B=FCrgel?=" <r.buergel@unicontrol.de>
Subject: Re: [PATCH V4] workaround for mpc52xx erratum #364 (serial may not be
	reset in break state)
In-Reply-To: <4912A69B.6020707@unicontrol.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <490F51E7.3020309@unicontrol.de>
	<fa686aa40811031255w3d9a065dgb0eb7ad4b26c9651@mail.gmail.com>
	<4910274E.5030305@unicontrol.de>
	<20081104111545.GB17864@pengutronix.de>
	<4910A519.3030701@unicontrol.de>
	<20081104212152.GC28064@pengutronix.de>
	<4912A69B.6020707@unicontrol.de>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 6, 2008 at 1:11 AM, Ren=E9 B=FCrgel <r.buergel@unicontrol.de> w=
rote:
> This patch is a workaround for bug #364 found in the MPC52xx processor.
> The errata document can be found under
> http://www.freescale.com/files/32bit/doc/errata/MPC5200E.pdf?fpsp=3D1&WT_=
TYPE=3DErrata&WT_VENDOR=3DFREESCALE&WT_FILE_FORMAT=3Dpdf&WT_ASSET=3DDocumen=
tation
>
> When a device with a low baudrate is connected to the serial port, but th=
e
> processor "listens" on a higher baudrate, it might falsely receive breaks
> from the controller. During a break, the serial controller may not be res=
et.
> The appended patch provides a workaround for that situation by lowering t=
he
> baudrate without resetting the controller and waiting until no break is
> received anymore.
>

I'm still don't like the state of this patch for two reasons:
1. It is enabled/disabled by a #ifdef.  It is quite possible that we
will eventually be able to build a multiplaform kernel that boots on
both mpc5200 and mpc5121.  The workaround needs to be detected and
enabled at runtime based on the data in the device tree (ie. if the
compatible property is "fsl,mpc5200-psc-uart").

2. I'm do not like the mdelay() busywait loop.  The long busy wait
just wastes CPU time.  Doing it with IRQs off means that irq latencies
become unbounded while this is happening.  This needs to be reworked
to use a workqueue or something similar.

Also, I'm not convinced that this is the best fix.  It doesn't
actually solve the problem, it just makes it less likely to occur.
What happens if you instead manipulate portconfig to change the PSC
pins to GPIO?  I wonder if that will disconnect the RX pin from the
PSC entirely.  If it does, then that might be a suitable method to
eliminate the break condition entirely.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
