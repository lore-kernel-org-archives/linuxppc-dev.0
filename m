Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 5511EDDE37
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Dec 2006 07:07:09 +1100 (EST)
Received: from lyakh (helo=localhost)
	by poirot.grange with local-esmtp (Exim 3.36 #1 (Debian))
	id 1Gyw6J-0001J0-00
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Dec 2006 21:07:11 +0100
Date: Mon, 25 Dec 2006 21:07:11 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: Chenging 2 bits in MSR in ppc6xx_idle() with 1 command?
Message-ID: <Pine.LNX.4.60.0612252053410.3424@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

Here's a code fragment from ppc6xx_idle(), which should send the CPU into 
a powersaving mode (DOZE or NAP) and re-enable interrupts after a 
local_irq_disable():

	mfmsr	r7
	ori	r7,r7,MSR_EE
	oris	r7,r7,MSR_POW@h
1:	sync
	mtmsr	r7
	isync
	b	1b

Whereas MPC8245's user manual says, that when setting the MSR_POW bit in 
the MSR one may not set any other bit in it with the same instruction. 
Does this mean that the above does not actually work on those (and 
similar) CPUs or does it work because of the loop?

Thanks
Guennadi
---
Guennadi Liakhovetski
