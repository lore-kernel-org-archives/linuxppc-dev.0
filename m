Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 73019DDDFC
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 16:08:32 +1100 (EST)
Date: Tue, 20 Nov 2007 06:08:26 +0100
From: Nick Piggin <npiggin@suse.de>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [patch] xmon bitlock fix
Message-ID: <20071120050826.GA18332@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(sorry, untested for lack of hardware)
--
xmon uses a bit lock spinlock but doesn't close the critical section
when releasing it. It doesn't seem like a big deal because it will
eventually break out of the lock anyway, but presumably that's only
in exceptional cases where some error is tolerated, while the lack of a memory
barrier could allow incorrect results during normal functioning operation
as well.

Convert it to use a regular spinlock instead.

Signed-off-by: Nick Piggin <npiggin@suse.de>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
Index: linux-2.6/arch/ppc/xmon/start.c
===================================================================
--- linux-2.6.orig/arch/ppc/xmon/start.c
+++ linux-2.6/arch/ppc/xmon/start.c
@@ -92,16 +92,14 @@ xmon_write(void *handle, void *ptr, int 
 {
 	char *p = ptr;
 	int i, c, ct;
-
-#ifdef CONFIG_SMP
-	static unsigned long xmon_write_lock;
+	static DEFINE_SPINLOCK(xmon_write_lock);
 	int lock_wait = 1000000;
 	int locked;
 
-	while ((locked = test_and_set_bit(0, &xmon_write_lock)) != 0)
+	while (!(locked = spin_trylock(&xmon_write_lock))) {
 		if (--lock_wait == 0)
 			break;
-#endif
+	}
 
 	if (!scc_initialized)
 		xmon_init_scc();
@@ -122,10 +120,9 @@ xmon_write(void *handle, void *ptr, int 
 		eieio();
 	}
 
-#ifdef CONFIG_SMP
-	if (!locked)
-		clear_bit(0, &xmon_write_lock);
-#endif
+	if (locked)
+		spin_unlock(&xmon_write_lock);
+
 	return nb;
 }
 
