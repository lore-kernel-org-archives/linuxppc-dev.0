Return-Path: <kato.takeharu@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id B337267A80
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Mar 2005 00:27:16 +1100 (EST)
Message-ID: <42231C26.7020508@jp.fujitsu.com>
Date: Mon, 28 Feb 2005 22:27:02 +0900
From: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
References: <421CD2B3.4020805@ybb.ne.jp>
	<421CD669.1040002@ybb.ne.jp>	<20050223142720.C13087@cox.net>
	<421F7DF5.3000608@ybb.ne.jp>
In-Reply-To: <421F7DF5.3000608@ybb.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 3/3] PowerPC4xx/E500 WatchDogTimerDriver(exception handler
 part)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Matt and all:

This is PowerPC405 exception handling part.
This patch consist of two parts.

I create this just in case, if you think that this is not needed,
please ignore them.

1) WatchDogException vector routine for ppc4xx.
    It cause Oops with MachineCheckException as other PPC4xx do.
2) Trivial bug fix in head_booke.h
    Trivial bug fix of CRITICAL_EXCEPTION macro.

Signed-off-by: Takeharu KATO <kato.takeharu@jp.fujitsu.com>


diff -uprN linux-2.6.11-rc5.orig/arch/ppc/kernel/head_4xx.S 
linux-2.6.11-rc5-ppc4xx/arch/ppc/kernel/head_4xx.S
--- linux-2.6.11-rc5.orig/arch/ppc/kernel/head_4xx.S	2005-02-27 15:30:39.000000000 +0900
+++ linux-2.6.11-rc5-ppc4xx/arch/ppc/kernel/head_4xx.S	2005-02-28 21:47:42.531317912 +0900
@@ -484,11 +484,11 @@ label:
  */
  	STND_EXCEPTION(0x1010,	FITException,		UnknownException)

+#endif
  /* 0x1020 - Watchdog Timer (WDT) Exception
  */

  	CRITICAL_EXCEPTION(0x1020, WDTException, UnknownException)
-#endif

  /* 0x1100 - Data TLB Miss Exception
   * As the name implies, translation is not in the MMU, so search the
diff -uprN linux-2.6.11-rc5.orig/arch/ppc/kernel/head_booke.h 
linux-2.6.11-rc5-ppc4xx/arch/ppc/kernel/head_booke.h
--- linux-2.6.11-rc5.orig/arch/ppc/kernel/head_booke.h	2005-02-27 15:27:12.000000000 +0900
+++ linux-2.6.11-rc5-ppc4xx/arch/ppc/kernel/head_booke.h	2005-02-28 21:50:05.060650160 +0900
@@ -194,8 +194,8 @@ label:
  	CRITICAL_EXCEPTION_PROLOG;				\
  	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
  	EXC_XFER_TEMPLATE(hdlr, n+2, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
-			  NOCOPY, transfer_to_handler_full, \
-			  ret_from_except_full)
+			  NOCOPY, crit_transfer_to_handler, \
+			  ret_from_crit_exc)

  #define MCHECK_EXCEPTION(n, label, hdlr)			\
  	START_EXCEPTION(label);					\
