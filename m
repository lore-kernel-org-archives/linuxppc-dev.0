Return-Path: <rbelaire@ciena.com>
Received: from mdmxm02.ciena.com (LIN1-118-39-27.ciena.com [63.118.39.27])
	by ozlabs.org (Postfix) with ESMTP id 665E4679E2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 May 2006 02:13:27 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: I2C bus issues on MPC8248
Date: Wed, 24 May 2006 12:00:52 -0400
Message-ID: <2C9CFFBFF7E53D4A9B1343C338550498019F663D@onmxm01.ciena.com>
From: "Belaire, Ron" <rbelaire@ciena.com>
To: "Laurent Pinchart" <laurent.pinchart@tbox.biz>,
	<hs@denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm also attempting to use the i2c patch on a MPC8247 and have a couple
of questions:

Is i2c-core.c still used with this patch since it appears to be using
the platform bus?

I'm enabling MPC82xx_CPM_I2C and setting platform_notify but never get a
callback.  What triggers the callback?

I get /sys/bus/platform/fsl-cpm-i2c appearing but fsl_ic2_probe is never
called.  What triggers the probe?

I'm obviously new to the platform bus and think that I am missing
something, so anything would help.

Best regards,

Ron Belaire

-----Original Message-----
From: linuxppc-embedded-bounces+rbelaire=3Dciena.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+rbelaire=3Dciena.com@ozlabs.org] On
Behalf Of Laurent Pinchart
Sent: May 22, 2006 5:06 AM
To: hs@denx.de
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: I2C bus issues on MPC8248

Hi Heiko,

> > I'm trying to use the MPC8248 hardware I2C bus in a 2.6.16 kernel.=20
> > The mailing list archives mention a driver for the MPC8260
> > (http://ozlabs.org/pipermail/linuxppc-embedded/2006-May/022837.html)
> > which I modified to reflect the memory map differences between the=20
> > MPC8260 and the MPC8248, as mentionned in the e-mail.
> >
> > The good news is that the driver works. The bad news is that it=20
> > doesn't work
>
> OK.
>
> > correctly.
> >
> :-(
> :
> > The Linux I2C layer probes the I2C bus for peripherals when drivers=20
> > are loaded. The probing function writes a single byte with the=20
> > device address and check if the data is acked. I monitored the SCL=20
> > and SDA lines using an
>
> [...]
>
> > Using that code, no data is sent on the bus, the BD_SC_READY bit is=20
> > never cleared and no interrupt is generated. Once again I suspected=20
> > a CPM bug when writing a single byte on the bus, so I increased
cbd_datlen to 2:
> >
> > tbdf[0].cbd_bufaddr =3D __pa(tb);
> > tbdf[0].cbd_datlen =3D 2;
> > tbdf[0].cbd_sc =3D count ? BD_SC_READY | BD_IIC_START :
> >                  BD_SC_READY | BD_IIC_START | BD_SC_INTRPT |
> >                  BD_SC_LAST | BD_SC_WRAP;
> >
> > This worked, and two bytes were written on the bus, leading me to=20
> > believe that the CPM was at fault.
>
> I don t know, if this is a CPM Bug, but it seems so to me ...

I've contacted Freescale's technical support about that issue. They
answered that 0-byte buffer descriptors are not legal (even though no
documentation states so), and that the address byte is output on the I2C
bus when the next byte is written to the internal TX FIFO, making it
impossible to send a single byte on the bus. Basically, that's a
"feature", and they don't intend to fix it.

> > Has anyone noticed the same behaviour ? Is there a workaround
available ?
> > I tried searching Freescale's website for CPM microcode updates but=20
> > haven't found anything related to the I2C controller.
>
> Yes, Holger Speck had the same problem. He solved it by doing the
> following:
>
> If the cpm_iic_write is called with count =3D 0. He made a read with=20
> count =3D
> 1
>
> I think this is safer than writing 2 Bytes to the Slave.
> Could you try this?

I've tried that with success. The I2C bus still gets stuck from time to
time, I'll try to investigate that.

Thanks for your help.

Best regards,

Laurent Pinchart
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
