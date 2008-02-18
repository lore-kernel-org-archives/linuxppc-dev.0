Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26FF2DDE4A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Feb 2008 21:42:23 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JR3Ry-00014l-SE
	for linuxppc-embedded@ozlabs.org; Mon, 18 Feb 2008 02:42:18 -0800
Message-ID: <15542516.post@talk.nabble.com>
Date: Mon, 18 Feb 2008 02:42:18 -0800 (PST)
From: sunil dutt <sunil.d@redpinesignals.com>
To: linuxppc-embedded@ozlabs.org
Subject: EBC configuration for mmio
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,
We are working on the MMIO interface and are struck up at sending the data
over the interface on PPC405EXr.The following are the configurations done by
us to use EBC Bank3.

EBC0_B3CR = 0x80018000 /*Base address 0x800 size 1MB Read/Write set */
EBC0_B3AP = 0x07840f80
                                                                                                                           
We have configured GPIO pin 10 (PER_CS3) for the chip select.The following
is the configuration for the CS .
OSRL : 00aa54aa
TSRL : 00aa54aa
ISR1L: XX(Dont care)
                                                                                                                           
Here are our observations while doing the data transfer.
1.When the data of one byte is sent continuously we have observed that the
second write blocks and the chip select is not triggered for the second
transfer.
                                                                                                                           
2.When one byte is sent and immediately we read the data over the interface
the read blocks and we also see that chip select is not triggered for the
read.
                                                                                                                           
3.The point 2 mentioned above is not consistent.We some times read the value
from the interface though the chip select is not triggered.
                                                                                                                           
Please could you verify our configurations.Please let us know if there is
any thing additional to be done.

Thanks and Regards,
Sunil
-- 
View this message in context: http://www.nabble.com/EBC-configuration-for-mmio-tp15542516p15542516.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
