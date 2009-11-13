Return-Path: <bones@secretlab.ca>
Received: from mail-bw0-f223.google.com (mail-bw0-f223.google.com
	[209.85.218.223]) by ozlabs.org (Postfix) with ESMTP id D2D93B6F1E
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Nov 2009 09:15:32 +1100 (EST)
Received: by bwz23 with SMTP id 23so3967524bwz.9
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 14:15:30 -0800 (PST)
Subject: mpc5200 ata driver question
From: John Bonesio <bones@secretlab.ca>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Fri, 13 Nov 2009 14:13:36 -0800
Message-Id: <1258150416.19600.16.camel@riker>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I have seen an intermittent problem in the driver:
	drivers/ata/pata_mpc52xx.c

The intermittent error is that the bestcomm dma engine gets stuck. I
don't believe the driver itself is causing the dma error. However, I do
want to enhance the driver so that it can recover from the dma error and
continue operation.

I haven't been able to find much information on the ata driver layer
other than the code. I've looked through and run some test code. The ata
layer will call either the driver's softreset() or hardreset() operation
if an error is detected.

I'm thinking about adding one or both of these reset routines, but I'm
not sure if this is the right approach since the error isn't with the
ata device itself. An alternative could be to recover dma from
mpc52xx_bmdma_status() - when the error is detected and reported.

How is error recovery supposed to work in the ata layer, and what is the
best approach for recovering from a dma error (as opposed to a drive
error)?

What is supposed to be the difference between the softreset() and
hardreset() routines? If recovering from the dma error, would one of
these routines be better to use?

Thanks for your help,

- John
