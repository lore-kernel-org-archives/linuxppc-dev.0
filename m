Return-Path: <mohan@in.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 21525679E0
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Sep 2006 22:23:30 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8CCNRgU012035
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Sep 2006 08:23:27 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8CCNR9K278282
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Sep 2006 06:23:27 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8CCNQXG025340
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Sep 2006 06:23:27 -0600
Date: Tue, 12 Sep 2006 17:48:21 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: linuxppc-dev@ozlabs.org, fastboot@osdl.org, mingo@elte.hu,
	torvalds@osdl.org, paulus@samba.org
Subject: Fix interrupt clearing in kdump shutdown sequence
Message-ID: <20060912121821.GB20606@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Some times HVC console on a PPC machine may have pending interrupts and
in this case kdump shutdown sequence created problem by calling
chip->end. This should be chip->eoi(). The attached patch fixes this
issue. Tested on POWER5 box.

Patch generated on 2.6.18-rc6-git4.

It will be helpful if this patch is included in 2.6.18.

Regards,
Mohan.



Call chip->eoi(irq) to clear any pending interrupt in case of kdump shutdown
sequence. chip->end(irq) does not solve this purpose.


Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---

 linux-2.6.18-rc6-git4/arch/powerpc/kernel/crash.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN linux-2.6.18-rc6-git4/arch/powerpc/kernel/crash.c~kdump-irq-fix linux-2.6.18-rc6-git4/arch/powerpc/kernel/crash.c
--- kernel/linux-2.6.18-rc6-git4/arch/powerpc/kernel/crash.c~kdump-irq-fix	2006-09-12 17:20:39.000000000 +0530
+++ kernel-mohan/linux-2.6.18-rc6-git4/arch/powerpc/kernel/crash.c	2006-09-12 17:20:51.000000000 +0530
@@ -295,7 +295,7 @@ void default_machine_crash_shutdown(stru
 		struct irq_desc *desc = irq_desc + irq;
 
 		if (desc->status & IRQ_INPROGRESS)
-			desc->chip->end(irq);
+			desc->chip->eoi(irq);
 
 		if (!(desc->status & IRQ_DISABLED))
 			desc->chip->disable(irq);
_
