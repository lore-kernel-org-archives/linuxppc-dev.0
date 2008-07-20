Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 32D3DDDEE8
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 04:55:33 +1000 (EST)
Message-ID: <488385A7.4010509@s5r6.in-berlin.de>
Date: Sun, 20 Jul 2008 20:36:23 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: dma_alloc_coherent() on PPC32: physical addresses above 2G possible?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I have to implement a workaround for a PCI device which gets into 
trouble if descriptors are located at 32bit addresses, while 31bit 
addresses are fine.  I would like to avoid this workaround on machines 
on which dma_alloc_coherent() won't ever go at memory above 2 GB.

Is defined(CONFIG_PPC32) a safe test for this?  I'm under the impression 
that defined(CONFIG_X86_32) is safe.

Are there any other means to detect when the workaround can be omitted, 
at compile time or at runtime?

PS:  I don't want to set the DMA mask of this device to DMA_31BIT_MASK 
because that would be detrimental to other functions of the device. It's 
a TI TSB43AB22A FireWire controller.
-- 
Stefan Richter
-=====-==--- -=== =-=--
http://arcgraph.de/sr/
