Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1713EDDE21
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Feb 2007 20:51:21 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HJo7x-0004Pg-GY
	for linuxppc-embedded@ozlabs.org; Wed, 21 Feb 2007 10:51:09 +0100
Received: from rusfw02.rohde-schwarz.com ([80.246.32.40])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 21 Feb 2007 10:51:09 +0100
Received: from euphoria by rusfw02.rohde-schwarz.com with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 21 Feb 2007 10:51:09 +0100
To: linuxppc-embedded@ozlabs.org
From: Florian Boelstler <euphoria@arcor.de>
Subject: Undestanding ioread32() / readl() and friends
Date: Wed, 21 Feb 2007 10:50:58 +0100
Message-ID: <erh4m0$n83$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: news <news@sea.gmane.org>
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

I just came across include/asm-ppc/io.h, which revealed that ioread32() 
maps to readl(), which in turn maps to in_le32() (when CONFIG_APUS and 
CONFIG_8260_PCI9 are both not defined).
in_le32() uses a asm instruction lwbrx to do byte swapping.

I don't really get why ioread32() effectively returns a little-endian 
value on a big-endian PPCs.

Is this a sort of general rule that ioread32() always returns 
little-endian values on all architectures?

BTW, "Linux Device Drivers, 3rd edition" by Corbet et al states that 
ioread32() does not perform any endian conversion.
May be they are based on x86...

Thanks,

   Florian
