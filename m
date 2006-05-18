Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx021.isp.belgacom.be (outmx021.isp.belgacom.be
	[195.238.4.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DC7EA67A79
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 May 2006 22:32:38 +1000 (EST)
Received: from outmx021.isp.belgacom.be (localhost [127.0.0.1])
	by outmx021.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4ICWVJp009969
	for <linuxppc-embedded@ozlabs.org>; Thu, 18 May 2006 14:32:31 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx021.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4ICWSD4009936
	for <linuxppc-embedded@ozlabs.org>; Thu, 18 May 2006 14:32:28 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: I2C bus issues on MPC8248
Date: Thu, 18 May 2006 14:33:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200605181433.58481.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody,

I'm trying to use the MPC8248 hardware I2C bus in a 2.6.16 kernel. The mailing 
list archives mention a driver for the MPC8260 
(http://ozlabs.org/pipermail/linuxppc-embedded/2006-May/022837.html) which I 
modified to reflect the memory map differences between the MPC8260 and the 
MPC8248, as mentionned in the e-mail.

The good news is that the driver works. The bad news is that it doesn't work 
correctly.

The Linux I2C layer probes the I2C bus for peripherals when drivers are 
loaded. The probing function writes a single byte with the device address and 
check if the data is acked. I monitored the SCL and SDA lines using an 
oscilloscope, and found out that 5 bytes are written to the device (address + 
4 data bytes) instead of a single one. The first 4 bytes are acked, the last 
isn't. After further investigation, I found out that the cpm_iic_write() 
function in drivers/i2c/busses/i2c-mpc8260.c fills two buffer descriptors, 
the second one having cbd_datlen set to zero:

tbdf[0].cbd_bufaddr = __pa(tb);
tbdf[0].cbd_datlen = 1;
tbdf[0].cbd_sc = BD_SC_READY | BD_IIC_START;

tbdf[1].cbd_bufaddr = __pa(buf);
tbdf[1].cbd_datlen = count;
tbdf[1].cbd_sc = BD_SC_READY | BD_SC_INTRPT | BD_SC_LAST | BD_SC_WRAP;

Still, 5 bytes are sent on the bus. I suspected a CPM bug when cbd_datlen is 
equal to zero, so I modified the first buffer descriptor to set the 
BD_SC_LAST in cbd_sc when count is zero:

tbdf[0].cbd_bufaddr = __pa(tb);
tbdf[0].cbd_datlen = 1;
tbdf[0].cbd_sc = count ? BD_SC_READY | BD_IIC_START :
                 BD_SC_READY | BD_IIC_START | BD_SC_INTRPT |
                 BD_SC_LAST | BD_SC_WRAP;

Using that code, no data is sent on the bus, the BD_SC_READY bit is never 
cleared and no interrupt is generated. Once again I suspected a CPM bug when 
writing a single byte on the bus, so I increased cbd_datlen to 2:

tbdf[0].cbd_bufaddr = __pa(tb);
tbdf[0].cbd_datlen = 2;
tbdf[0].cbd_sc = count ? BD_SC_READY | BD_IIC_START :
                 BD_SC_READY | BD_IIC_START | BD_SC_INTRPT |
                 BD_SC_LAST | BD_SC_WRAP;

This worked, and two bytes were written on the bus, leading me to believe that 
the CPM was at fault.

Has anyone noticed the same behaviour ? Is there a workaround available ? I 
tried searching Freescale's website for CPM microcode updates but haven't 
found anything related to the I2C controller.

Laurent Pinchart
