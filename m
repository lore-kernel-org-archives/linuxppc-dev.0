Return-Path: <biswa.nayak@wipro.com>
Received: from wipro-blr-out01.wipro.com (wipro-blr-out01.wipro.com
	[203.91.198.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E690CDDD0D
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 04:14:09 +1100 (EST)
Received: from blr-ec-bh02.wipro.com (unknown [10.201.50.92])
	by wipro-blr-out01.wipro.com (Symantec Mail Security) with ESMTP id
	13AE74E4005
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 22:33:04 +0530 (IST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Wrong IRQ assigned on MPC8349EMDS board
Date: Thu, 28 Feb 2008 21:38:36 +0530
Message-ID: <4F36B0A4CDAD6F46A61B2B32C33DC69C05C579C0@BLR-EC-MBX03.wipro.com>
From: <biswa.nayak@wipro.com>
To: <linuxppc-dev@ozlabs.org>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello list
I am trying to bring up MPC8349EMDS board with linux-2.6.18 kernel with
ramfs enabled.
I am passing a device tree binary (dtb) compiled from the corresponding
dts file found from the 'arch/powerpc/boot/dts' directory and compiled
with the device tree compiler.
 
I found that the IRQ lines assigned to different peripherals are
completely wrong.
My serial ports are connected to pin 9 and 10, but in this kernel the
IRQs assigned are 16 and 17. 

On a little investigation I found that the base address assigned to the
IPIC chip is '0xFDDFB700'

If I compile the linux version with 'ARCH=3Dppc' and boot then my IPIC
base address
is getting assigned as 0xFE000700, which I think is the correct
behaviour. 

I checked in the dts file and found that the IPIC offset is mentioned as
700 and size as 100,
which are correct as per the manual. 
Even the IRQ lines mentioned for the Serial ports in the DTS are '9' and
'A'.

Does this wrong assignment is due to the wrong base address of the IPIC
chip?
With IRQs 16 and 17, how the serial console is working fine?

When I tried hard coding the IPIC base value to '0xfe000700' then the
system refuses to boot up.

I kept the IPIC base as 0xfddfb700 and hard coded the irq lines for
serial ports as 9 and 10
and in that case the 'request_irq' call fails with the error number as
'-38',
which translates to '-ENOSYS'. 

The changes in the dts never gets reflected in the kernel, 
no matter what lines I set for serial line in the dts, the request
always goes for line 16 and 17.

Please let me know if you need any more information regarding the same.
Any help in this will be highly appreciated.

Thanks
Biswa

The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and may=
 contain proprietary, confidential or privileged information. If you are not=
 the intended recipient, you should not disseminate, distribute or copy this=
 e-mail. Please notify the sender immediately and destroy all copies of this=
 message and any attachments. 

WARNING: Computer viruses can be transmitted via email. The recipient should=
 check this email and any attachments for the presence of viruses. The compa=
ny accepts no liability for any damage caused by any virus transmitted by th=
is email.

www.wipro.com
