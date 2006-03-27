Return-Path: <meyerlau@fr.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A163A67A77
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 00:05:01 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.12.10/8.12.10) with ESMTP id k2R9bn7i154922
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Mar 2006 09:37:49 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2R9cQ9V181318
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Mar 2006 11:38:26 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2R9bnl2010160
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Mar 2006 11:37:49 +0200
Subject: [PATCH] sigaltstack bad behavior on powerpc64
From: Laurent MEYER <meyerlau@fr.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="=-YW6DYW4OCgzhok4QSi7A"
Date: Mon, 27 Mar 2006 11:37:41 +0200
Message-Id: <1143452261.3911.16.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-YW6DYW4OCgzhok4QSi7A
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

I may have found a bug in powerpc64 arch specific code.

*) When setting a sighandler using sigaction() call, if the flag
SA_ONSTACK is set and no alternate stack is provided via sigaltstack(),
the kernel still try to install the alternate stack. This behavior is
the opposite of the one which is documented in Single Unix
Specifications V3.

*) Also when setting an alternate stack using sigaltstack() with the flag SS_DISABLE, 
the kernel try to install the alternate stack on signal delivery.

These two use cases makes the process crash at signal delivery.

I wrote a small patch to add a condition in get_sigframe().

Hope that is relevant and helpfull.

Regards,
Laurent MEYER.

Signed-off-by: Laurent Meyer <meyerlau@fr.ibm.com>

--=-YW6DYW4OCgzhok4QSi7A
Content-Disposition: attachment; filename=sigaltstack.fix.patch
Content-Type: text/x-patch; name=sigaltstack.fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6.16-mcr/arch/powerpc/kernel/signal_64.c
===================================================================
--- linux-2.6.16-mcr.orig/arch/powerpc/kernel/signal_64.c	2006-03-27 11:09:02.000000000 +0200
+++ linux-2.6.16-mcr/arch/powerpc/kernel/signal_64.c	2006-03-27 11:14:16.986879573 +0200
@@ -213,7 +213,7 @@
         /* Default to using normal stack */
         newsp = regs->gpr[1];
 
-	if (ka->sa.sa_flags & SA_ONSTACK) {
+	if ((ka->sa.sa_flags & SA_ONSTACK) && current->sas_ss_size) {
 		if (! on_sig_stack(regs->gpr[1]))
 			newsp = (current->sas_ss_sp + current->sas_ss_size);
 	}

--=-YW6DYW4OCgzhok4QSi7A--
