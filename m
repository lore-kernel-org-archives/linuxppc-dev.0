From: Cort Dougan <cort@fsmlabs.com>
Date: Fri, 28 Jun 2002 12:35:55 -0600
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] Fix pcore build in latest linuxppc_2_4_devel
Message-ID: <20020628123555.F3851@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


If anyone wants the BK patch, drop me a note.

diff -Nru a/BitKeeper/etc/logging_ok b/BitKeeper/etc/logging_ok
--- a/BitKeeper/etc/logging_ok	Fri Jun 28 12:34:45 2002
+++ b/BitKeeper/etc/logging_ok	Fri Jun 28 12:34:45 2002
@@ -50,3 +50,4 @@
 trini@entropy.crashing.org
 trini@opus.bloom.county
 trini@stevedallas.bloom.county
+cort@host110.fsmlabs.com
diff -Nru a/arch/ppc/platforms/pcore_setup.c b/arch/ppc/platforms/pcore_setup.c
--- a/arch/ppc/platforms/pcore_setup.c	Fri Jun 28 12:34:45 2002
+++ b/arch/ppc/platforms/pcore_setup.c	Fri Jun 28 12:34:45 2002
@@ -167,13 +167,13 @@
 	for ( i = 0 ; i < 16 ; i++ )
 		irq_desc[i].handler = &i8259_pic;

-	i8259_init(NULL);
+	i8259_init(0);
 }

 static int
 pcore_get_irq(struct pt_regs *regs)
 {
-	return i8259_poll();
+	return i8259_poll(regs);
 }

 /*

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
