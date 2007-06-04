Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 04 Jun 2007 15:15:55 +1000
Subject: [PATCH 20/21] powerpc: remove #ifdef around set_dabr in signal code
In-Reply-To: <1180934134.603289.870346178920.qpush@grosgo>
Message-Id: <20070604051600.2501BDDF23@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

set_dabr() and thread.dabr exist on 32 bits as well nowadays (they
actually may do something even, depending on what CPU you have).

So remove the ifdef

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/signal.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-cell/arch/powerpc/kernel/signal.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/signal.c	2007-06-04 13:08:24.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/signal.c	2007-06-04 13:08:30.000000000 +1000
@@ -145,7 +145,6 @@ int do_signal(sigset_t *oldset, struct p
 		return 0;               /* no signals delivered */
 	}
 
-#ifdef CONFIG_PPC64
         /*
 	 * Reenable the DABR before delivering the signal to
 	 * user space. The DABR will have been cleared if it
@@ -153,7 +152,6 @@ int do_signal(sigset_t *oldset, struct p
 	 */
 	if (current->thread.dabr)
 		set_dabr(current->thread.dabr);
-#endif
 
 	if (is32) {
         	if (ka.sa.sa_flags & SA_SIGINFO)
