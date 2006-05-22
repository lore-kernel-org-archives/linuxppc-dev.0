Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx021.isp.belgacom.be (outmx021.isp.belgacom.be
	[195.238.4.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 592E2679E0
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 May 2006 19:04:53 +1000 (EST)
Received: from outmx021.isp.belgacom.be (localhost [127.0.0.1])
	by outmx021.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4M94hCC032679
	for <linuxppc-embedded@ozlabs.org>; Mon, 22 May 2006 11:04:43 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: hs@denx.de
Subject: Re: I2C bus issues on MPC8248
Date: Mon, 22 May 2006 11:06:13 +0200
References: <1148056646.5943.20.camel@Zeus.EmbLux>
In-Reply-To: <1148056646.5943.20.camel@Zeus.EmbLux>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605221106.13214.laurent.pinchart@tbox.biz>
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

Hi Heiko,

> > I'm trying to use the MPC8248 hardware I2C bus in a 2.6.16 kernel. The
> > mailing
> > list archives mention a driver for the MPC8260
> > (http://ozlabs.org/pipermail/linuxppc-embedded/2006-May/022837.html)
> > which I modified to reflect the memory map differences between the
> > MPC8260 and the MPC8248, as mentionned in the e-mail.
> >
> > The good news is that the driver works. The bad news is that it doesn't
> > work
>
> OK.
>
> > correctly.
> >
> :-(
> :
> > The Linux I2C layer probes the I2C bus for peripherals when drivers are
> > loaded. The probing function writes a single byte with the device address
> > and check if the data is acked. I monitored the SCL and SDA lines using
> > an
>
> [...]
>
> > Using that code, no data is sent on the bus, the BD_SC_READY bit is never
> > cleared and no interrupt is generated. Once again I suspected a CPM bug
> > when writing a single byte on the bus, so I increased cbd_datlen to 2:
> >
> > tbdf[0].cbd_bufaddr = __pa(tb);
> > tbdf[0].cbd_datlen = 2;
> > tbdf[0].cbd_sc = count ? BD_SC_READY | BD_IIC_START :
> >                  BD_SC_READY | BD_IIC_START | BD_SC_INTRPT |
> >                  BD_SC_LAST | BD_SC_WRAP;
> >
> > This worked, and two bytes were written on the bus, leading me to believe
> > that the CPM was at fault.
>
> I don t know, if this is a CPM Bug, but it seems so to me ...

I've contacted Freescale's technical support about that issue. They answered 
that 0-byte buffer descriptors are not legal (even though no documentation 
states so), and that the address byte is output on the I2C bus when the next 
byte is written to the internal TX FIFO, making it impossible to send a 
single byte on the bus. Basically, that's a "feature", and they don't intend 
to fix it.

> > Has anyone noticed the same behaviour ? Is there a workaround available ?
> > I tried searching Freescale's website for CPM microcode updates but
> > haven't found anything related to the I2C controller.
>
> Yes, Holger Speck had the same problem. He solved it by doing the
> following:
>
> If the cpm_iic_write is called with count = 0. He made a read with count =
> 1
>
> I think this is safer than writing 2 Bytes to the Slave.
> Could you try this?

I've tried that with success. The I2C bus still gets stuck from time to time, 
I'll try to investigate that.

Thanks for your help.

Best regards,

Laurent Pinchart
