Date: Thu, 10 Apr 2003 23:53:47 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: patch arch/ppc/mm/pgtable.c
To: linuxppc-dev@lists.linuxppc.org
Reply-To: tglx@linutronix.de
Message-id: <200304102353.47791.tglx@linutronix.de>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


If HAVE_BATS is not defined, compile stop later as total_lowmem is undefined.

--
Thomas
________________________________________________________________________
linutronix - competence in embedded & realtime linux
http://www.linutronix.de
mail: tglx@linutronix.de

diff -urN linux-2.4.20-ppc/arch/ppc/mm/pgtable.c
linux-2.4.20-ppc-work/arch/ppc/mm/pgtable.c
--- linux-2.4.20-ppc/arch/ppc/mm/pgtable.c	Tue Apr  1 19:39:25 2003
+++ linux-2.4.20-ppc-work/arch/ppc/mm/pgtable.c	Tue Apr  1 21:02:20 2003
@@ -199,11 +199,11 @@
 adjust_total_lowmem(void)
 {
 	unsigned long max_low_mem = MAX_LOW_MEM;
+	unsigned long ram = total_lowmem;

 #ifdef HAVE_BATS
 	unsigned long bat_max = 0x10000000;
 	unsigned long align;
-	unsigned long ram = total_lowmem;
 	int is601 = 0;

 	/* 601s have smaller BATs */


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
