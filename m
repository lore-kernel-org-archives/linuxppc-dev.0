Return-Path: <apw@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D750C67B7B
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jul 2006 09:16:05 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6KNG183011341
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 19:16:01 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6KNG1Yv246104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 19:16:01 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6KNG1PZ018051
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 19:16:01 -0400
Received: from kvasir.watson.ibm.com (kvasir.watson.ibm.com [9.2.218.19])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6KNG1fS018017
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 19:16:01 -0400
Received: from apw by kvasir.watson.ibm.com with local (Exim 4.52)
	id 1G3hkQ-0000xh-1O
	for linuxppc-dev@ozlabs.org; Thu, 20 Jul 2006 19:16:02 -0400
Date: Thu, 20 Jul 2006 19:16:01 -0400
To: linuxppc-dev@ozlabs.org
Subject: mpic discovery on JS20
Message-ID: <20060720231601.GA24736@kvasir.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Amos Waterland <apw@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Current Linus and Paulus trees do this on JS20 blades with SLOF:

 Failed to locate the MPIC interrupt controller
 PID hash table entries: 4096 (order: 12, 32768 bytes)
 Maple: Found RTC at IO 0x1070
 cpu 0x0: Vector: 700 (Program Check) at [c00000007ef83ab0]
     pc: c00000000002e0c8: .mpic_request_ipis+0x34/0xc8
     lr: c00000000036b484: .smp_mpic_probe+0x3c/0x58
     sp: c00000007ef83d30
    msr: 9000000000029032
   current = 0xc00000000194d610
   paca    = 0xc00000000038f180
     pid   = 1, comm = swapper
 kernel BUG in mpic_request_ipis at arch/powerpc/sysdev/mpic.c:1132!

Doing a git-bisect produces this:

 0ebfff1491ef85d41ddf9c633834838be144f69f is first bad commit
 Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
 Date:   Mon Jul 3 21:36:01 2006 +1000

    [POWERPC] Add new interrupt mapping core and change platforms to use it
    
    This adds the new irq remapper core and removes the old one.  Because
    there are some fundamental conflicts with the old code, like the value
    of NO_IRQ which I'm now setting to 0 (as per discussions with Linus),
    etc..., this commit also changes the relevant platform and driver code
    over to use the new remapper (so as not to cause difficulties later
    in bisecting).
    
    This patch removes the old pre-parsing of the open firmware interrupt
    tree along with all the bogus assumptions it made to try to renumber
    interrupts according to the platform. This is all to be handled by the
    new code now.
    
    For the pSeries XICS interrupt controller, a single remapper host is
    created for the whole machine regardless of how many interrupt
    presentation and source controllers are found, and it's set to match
    any device node that isn't a 8259.  That works fine on pSeries and
    avoids having to deal with some of the complexities of split source
    controllers vs. presentation controllers in the pSeries device trees.
    
    The powerpc i8259 PIC driver now always requests the legacy interrupt
    range. It also has the feature of being able to match any device node
    (including NULL) if passed no device node as an input. That will help
    porting over platforms with broken device-trees like Pegasos who don't
    have a proper interrupt tree.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
