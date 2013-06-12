Return-Path: <scinteeb@gmail.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EB7BE2C007C
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Jun 2013 20:10:54 +1000 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <scinteeb@gmail.com>) id 1UmhjM-0004QE-2g
 for linuxppc-dev@ozlabs.org; Wed, 12 Jun 2013 02:52:40 -0700
Date: Wed, 12 Jun 2013 02:52:40 -0700 (PDT)
From: scinteeb <scinteeb@gmail.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1371030759660-72284.post@n7.nabble.com>
Subject: help with PCI RTL8139 on mpc5200
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



    Hello,

  First of all I want to mention that I am quite new on the development at
this level on the mpc5200 based boards. It might be that I'll ask dumb or
wrong questions so I want to apologize for this. 
  I am using a custom board based on icecube 5200 reference card but with an
additional PCI RTL8139 network interface.
1. I did compile the latest u-boot and at that level the PCI is detecting
the interface and the u-boot is adding it in the network list as I can see
as interfaces FEC and RTL8139#0.

2. I have compiled the latest released kernel 3.9.4 which is having support
for mpc5200 based devices. The kernel is able to identify the RTL8139
interface, is loading properly the 8139too driver, I can change the settings
of the interface, but when I am trying to setup the IP address I am getting
an SIOCSIFFLAGS error.
The investigations showed that the reason for the error is that the IRQ 0
that is detected by the system as being used by the interface cannot be
used. The request_irq function in the rtl8139 is failing because the
can_request_irq is returning 0.

The interesting boot messages that I found while booting the kernel and
might be helpful are:
[    0.226240] mpc52xx_irqhost_map: Critical IRQ #3 is unsupported! Nopping
it.
...
[    1.404745] 8139too 0000:01:0c.0 eth1: RealTek RTL8139 at 0xca086000,
00:e0:4c:00:00:08, IRQ 0

Any idea on how to address the situation?

Thanks in advance,
Bogdan.




--
View this message in context: http://linuxppc.10917.n7.nabble.com/help-with-PCI-RTL8139-on-mpc5200-tp72284.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
