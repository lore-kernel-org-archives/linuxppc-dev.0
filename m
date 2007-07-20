Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 30049DDE39
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 12:59:14 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6K2xAlr016867
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 22:59:10 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6K2xASv257430
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 20:59:10 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6K2xAFl032109
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 20:59:10 -0600
Date: Thu, 19 Jul 2007 22:11:10 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Fix ARCH=ppc builds
Message-ID: <20070720031110.GP3925@crusty.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The recent signal rework broke ARCH=ppc builds with the following error:

CC      arch/powerpc/kernel/signal.o
arch/powerpc/kernel/signal.c: In function ‘do_signal’:
arch/powerpc/kernel/signal.c:142: error: implicit declaration of function ‘set_dabr’
make[1]: *** [arch/powerpc/kernel/signal.o] Error 1

The patch below fixes it by including a function prototype in
asm-ppc/system.h

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

diff --git a/include/asm-ppc/system.h b/include/asm-ppc/system.h
index f1311a8..cc45780 100644
--- a/include/asm-ppc/system.h
+++ b/include/asm-ppc/system.h
@@ -54,6 +54,7 @@ extern void show_regs(struct pt_regs * regs);
 extern void flush_instruction_cache(void);
 extern void hard_reset_now(void);
 extern void poweroff_now(void);
+extern int set_dabr(unsigned long dabr);
 #ifdef CONFIG_6xx
 extern long _get_L2CR(void);
 extern long _get_L3CR(void);
