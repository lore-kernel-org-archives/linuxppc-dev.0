Return-Path: <m.fortini@selcomgroup.com>
Received: from xseries02.selcomgroup.com (mail.selcomgroup.com [85.18.34.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1A670DDD04
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 02:27:26 +1100 (EST)
Received: from [172.26.6.74] ([172.26.6.74]) (authenticated bits=0)
	by xseries02.selcomgroup.com (8.13.4/8.13.4) with ESMTP id
	mB3F76AN016726
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Dec 2008 16:07:06 +0100
Message-ID: <4936A0A8.6000108@selcomgroup.com>
Date: Wed, 03 Dec 2008 16:07:20 +0100
From: Matteo Fortini <m.fortini@selcomgroup.com>
MIME-Version: 1.0
To: linux-ppc list <linuxppc-dev@ozlabs.org>
Subject: MPC512x: fsldma for UART FIFO
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm trying to use DMA to take data from the rx FIFO of a PSC and store 
it in a buffer.

I had to change the off_to_size function, because it assumed that if 
offset would be 0, then size would be 32bits, while I need to read 8 
bits at a time, otherwise the FIFO wouldn't work correctly.

Has anyone worked with MPC512x DMA? Unfortunately, the other DMA 
drivers, which are IDE and PCM sound, both use 32bits accesses.

Changing fsldma to use 0 size works, but DMA seems to give back wrong data.

Thanks,
M
