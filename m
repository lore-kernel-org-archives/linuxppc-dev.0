Return-Path: <adrian@humboldt.co.uk>
Received: from mail.humboldt.co.uk (mail.humboldt.co.uk [80.68.93.146])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C231F67BE5
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Nov 2006 03:21:20 +1100 (EST)
Received: from newt.humboldt.co.uk ([81.2.65.19] helo=[192.168.78.155])
	by mail.humboldt.co.uk with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.50) id 1GndnS-0005RH-St
	for linuxppc-dev@ozlabs.org; Fri, 24 Nov 2006 16:21:03 +0000
Subject: Worst case performance of up()
From: Adrian Cox <adrian@humboldt.co.uk>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Fri, 24 Nov 2006 16:21:02 +0000
Message-Id: <1164385262.11292.76.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

First the background: I've been investigating poor performance of a
Firewire capture application, running on a dual-7450 board with a 2.6.17
kernel. The kernel is based on a slightly earlier version of the
mpc7448hpc2 board port, using arch/powerpc, which I've not yet updated
to reflect the changes made when the board support entered the
mainstream kernel. 

The application runs smoothly on a single processor. On the dual
processor machine, the application sometimes suffers a drop in
frame-rate, simultaneous with high CPU usage by the Firewire kernel
thread.

Further investigation reveals that the kernel thread spends most of the
time in one line: up(&fi->complete_sem) in __queue_complete_req() in
drivers/iee1394/raw1394.c.  It seems that whenever the userspace thread
calling raw1394_read() is scheduled on the opposite CPU to the kernel
thread, the kernel thread takes much longer to execute up() - typically
10000 times longer.

Does anybody have any ideas what could make up() take so long in this
circumstance? I'd expect cache transfers to make the operation about 100
times slower, but this looks like repeated cache ping-pong between the
two CPUs.

-- 
Adrian Cox <adrian@humboldt.co.uk>
