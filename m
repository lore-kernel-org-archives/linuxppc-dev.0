Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B0382B7B6D
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Sep 2009 15:02:03 +1000 (EST)
Received: from bzq-82-81-138-186.red.bezeqint.net ([82.81.138.186]:50799
	helo=felix-laptop.lan)
	by vega.surpasshosting.com with esmtpa (Exim 4.69)
	(envelope-from <felix@embedded-sol.com>) id 1Mo8R2-00049e-0e
	for linuxppc-dev@ozlabs.org; Thu, 17 Sep 2009 00:17:32 -0400
Message-ID: <4AB1B84F.8080606@embedded-sol.com>
Date: Thu, 17 Sep 2009 07:17:19 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: FPGA access over PCI-E on MPC8536
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On my custom MPC8536 based board running 2.6.31 kernel
FPGA is connected via x2 PCI-E lane. FPGA is identified
during PCI scan and is visible via lspci.

0000:01:00.0 Class ff00: Altera Corporation Unknown device 0004 (rev 01)
         Subsystem: Altera Corporation Unknown device 0004
         Flags: fast devsel, IRQ 16
         Memory at 98000000 (32-bit, non-prefetchable) [disabled] [size=1M]
         Capabilities: [50] Message Signalled Interrupts: Mask+ 64bit+ 
Queue=0/5 Enable-
         Capabilities: [78] Power Management version 3
         Capabilities: [80] Express Endpoint IRQ 0
         Capabilities: [100] Virtual Channel


However when I attempt to access FPGA memory my mmapping it in userspace 
the read hangs. The same happens in kernel space. Does it happen because 
FPGA memory is marked as disabled, or because FPGA code is doing 
something wrong ?

Another question is what can cause PCI device memory be marked as
disabled.

Thanks a lot.

Felix.
