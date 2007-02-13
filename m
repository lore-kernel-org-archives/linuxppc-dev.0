Return-Path: <laurent.pinchart@technotrade.biz>
Received: from outmx019.isp.belgacom.be (outmx019.isp.belgacom.be
	[195.238.4.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B21FEDDECD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Feb 2007 02:09:11 +1100 (EST)
Received: from outmx019.isp.belgacom.be (localhost [127.0.0.1])
	by outmx019.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1DF8vLL005882
	for <linuxppc-embedded@ozlabs.org>; Tue, 13 Feb 2007 16:08:57 +0100
	(envelope-from <laurent.pinchart@technotrade.biz>)
Received: from mail.technotrade.biz (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx019.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1DF8uYF005869
	for <linuxppc-embedded@ozlabs.org>; Tue, 13 Feb 2007 16:08:56 +0100
	(envelope-from <laurent.pinchart@technotrade.biz>)
Received: from mail.technotrade.biz (localhost [127.0.0.1])
	by mail.technotrade.biz (Postfix) with ESMTP id 8E9191BA9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Feb 2007 16:08:56 +0100 (CET)
Received: from pclaurent.technotrade.biz (pclaurent.technotrade.biz
	[192.168.1.47])
	by mail.technotrade.biz (Postfix) with ESMTP id 7B3B8F34
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Feb 2007 16:08:56 +0100 (CET)
From: Laurent Pinchart <laurent.pinchart@technotrade.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Best way to define flash partitions for an MPC8248
Date: Tue, 13 Feb 2007 16:08:55 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200702131608.55630.laurent.pinchart@technotrade.biz>
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

I'm running Linux 2.6.20 on an MPC8248 using arch/ppc/.

The system flash is divided in 5 partitions, which are currently defined in 
both U-Boot and in the Linux kernel (hardcoded in platform specific code in 
arch/ppc/platforms/). This is error prone, as modifying partition information 
requires a change to the U-Boot environment variables and a recompilation of 
the Linux kernel.

I would like to get rid of partition data in the kernel. I found 3 ways for 
the Linux kernel to get those data from elsewhere:

- command line parsing (using the mtdparts argument)
- redboot partition table parsing
- OF device tree (drivers/mtd/maps/physmap_of.c)

What is the best suited method ? I don't really like the redboot partition 
table, is I haven't found any way to write it from U-Boot. Do I need to 
switch to arch/powerpc/ to use the OF device tree ? If so, is it possible 
today for the MPC8248 processor, or is it still badly supported in 
arch/powerpc/ ? Last but not least, is it possible to change the OF device 
tree from U-Boot at runtime to resize partitions ?

Best regards,

Laurent Pinchart
