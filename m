Return-Path: <mzucca@verizon.net>
Received: from vms044pub.verizon.net (vms044pub.verizon.net [206.46.252.44])
	by ozlabs.org (Postfix) with ESMTP id 46AF867BDF
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 02:34:28 +1000 (EST)
Received: from vms069.mailsrvcs.net ([192.168.1.2])
	by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-4.02
	(built Sep
	9 2005)) with ESMTPA id <0J7L009LHHUXXR4F@vms044.mailsrvcs.net> for
	linuxppc-dev@ozlabs.org; Mon, 23 Oct 2006 10:32:57 -0500 (CDT)
Date: Mon, 23 Oct 2006 10:32:57 -0500 (CDT)
From: "Michael R. Zucca" <mzucca@verizon.net>
Subject: Re: RE: [PATCH] qe_ic: Do a sync when masking interrupts.
To: Li Yang-r58472 <LeoLi@freescale.com>, Paul Mackerras <paulus@samba.org>,
	Wood Scott-B07421 <scottwood@freescale.com>
Message-id: <25462872.4323541161617577705.JavaMail.root@vms069.mailsrvcs.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
Reply-To: mrz5149@acm.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From: Li Yang-r58472 <LeoLi@freescale.com>
>
>But an i/o read will be considerably slower than a sync, and it is in
>the critical path of interrupt.  I have tested the patch under
>relatively heavy Ethernet load, and there is no spurious interrupt.
>Maybe it is because the device is an SOC device and MMIO store completes
>faster.  I'm wondering if there is a standard test method to show if the
>faster approach is sufficient or not.

All a sync tells you is that an I/O made it out of the CPU. The problem is, there may be other places a write could get hung up. For instance, sometimes devices sit behind a bridge with a write FIFO. In such a scenario, you can't be sure a write has made it to the device until you do a read to flush the FIFO.

If you're trying to figure out the minimum thing to do (eieio, sync, read-back, etc.) you have to understand what your system is doing between the store and the bits going into the register.

It may be that a sync is enough, but you won't know until you fully understand the system's bus/bridge topolgy between the CPU and the device.
