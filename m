Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 07 May 2008 10:00:56 +1000
Subject: [PATCH 2/2] [POWERPC] Document when printk is useable
Message-Id: <20080507000237.1A37CDDE26@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When debugging early boot problems, it's common to sprinkle printk's
all over the place. However, on powerpc 64 bits, this can lead to
memory corruption if done too early due to the PACA pointer and
lockdep core not being initialized.

This adds some comments to early_setup() that document when it is
safe to do so in order to save time to whoever has to debug that
stuff next.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/setup_64.c |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-work.orig/arch/powerpc/kernel/setup_64.c	2008-05-07 09:54:52.000000000 +1000
+++ linux-work/arch/powerpc/kernel/setup_64.c	2008-05-07 09:56:31.000000000 +1000
@@ -170,6 +170,8 @@ void __init setup_paca(int cpu)
 
 void __init early_setup(unsigned long dt_ptr)
 {
+	/* -------- printk is _NOT_ safe to use here ! ------- */
+
 	/* Fill in any unititialised pacas */
 	initialise_pacas();
 
@@ -185,6 +187,8 @@ void __init early_setup(unsigned long dt
 	/* Initialize lockdep early or else spinlocks will blow */
 	lockdep_init();
 
+	/* -------- printk is now safe to use ------- */
+
  	DBG(" -> early_setup(), dt_ptr: 0x%lx\n", dt_ptr);
 
 	/*
