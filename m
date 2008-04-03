Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 668ADDDEF0
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 06:11:34 +1100 (EST)
Date: Thu, 3 Apr 2008 23:09:43 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC: MPIC ack interrupts at mpic_teardown_this_cpu()
Message-ID: <20080403190943.GA16446@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: olof@lixom.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We really need to ack interrupts at mpic_teardown, since
not all platforms reset mpic at kernel start-up. For example,
kexec'ed kernel hangs on P.A. Semi if mpic_eoi() isn't called.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/sysdev/mpic.c |    6 +-----
 1 files changed, 1 insertion(+), 5 deletions(-)

--- powerpc/arch/powerpc/sysdev/mpic.c	2008-02-26 15:56:57.000000000 +0300
+++ linux-2.6.new/arch/powerpc/sysdev/mpic.c	2008-04-03 23:00:45.000000000 +0400
@@ -1410,11 +1410,6 @@ void mpic_cpu_set_priority(int prio)
 	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), prio);
 }
 
-/*
- * XXX: someone who knows mpic should check this.
- * do we need to eoi the ipi including for kexec cpu here (see xics comments)?
- * or can we reset the mpic in the new kernel?
- */
 void mpic_teardown_this_cpu(int secondary)
 {
 	struct mpic *mpic = mpic_primary;
@@ -1434,6 +1429,7 @@ void mpic_teardown_this_cpu(int secondar
 
 	/* Set current processor priority to max */
 	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0xf);
+	mpic_eoi(mpic);
 
 	spin_unlock_irqrestore(&mpic_lock, flags);
 }
