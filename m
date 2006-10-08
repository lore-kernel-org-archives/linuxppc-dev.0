Return-Path: <olaf@ibook.aepfle.de>
Received: from natblert.rzone.de (natblert.rzone.de [81.169.145.181])
	by ozlabs.org (Postfix) with ESMTP id 1122767C25
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Oct 2006 18:33:01 +1000 (EST)
Date: Sun, 8 Oct 2006 10:32:53 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] fix PReP SMP build
Message-ID: <20061008083253.GA19269@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


  CC      arch/ppc/kernel/smp.o
arch/ppc/kernel/smp.c:88: error: conflicting types for 'smp_message_recv'
include2/asm/smp.h:42: error: previous declaration of 'smp_message_recv' was here
make[2]: *** [arch/ppc/kernel/smp.o] Error 1

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 arch/ppc/kernel/smp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/ppc/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/ppc/kernel/smp.c
+++ linux-2.6/arch/ppc/kernel/smp.c
@@ -84,7 +84,7 @@ smp_message_pass(int target, int msg)
 /*
  * Common functions
  */
-void smp_message_recv(int msg, struct pt_regs *regs)
+void smp_message_recv(int msg)
 {
 	atomic_inc(&ipi_recv);
 
