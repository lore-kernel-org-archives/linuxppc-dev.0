Message-ID: <20030908213638.4000.qmail@web40910.mail.yahoo.com>
Date: Mon, 8 Sep 2003 14:36:38 -0700 (PDT)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: virt_to_phys() on 440
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I think the virt_to_phys() function is incorrect for
PPC440.  It should call iopa for all 4xx, not only the
405.  By chance, it happens to work currently if the
address is in SDRAM, but is always incorrect for
ioremapped addresses.  virt_to_bus() does the right
thing.

Also, to be correct, shouldn't this function return a
phys_addr_t rather than an unsigned long, as the
physical address is >32 bits on 44x?

Regards,
Brian

--- include/asm/io.h.new   Thu Aug 28 14:30:33 2003
+++ include/asm/io.h    Mon Sep  8 14:21:08 2003
@@ -309,7 +309,7 @@
  */
 extern inline unsigned long virt_to_phys(volatile
void * address)
 {
-#if defined(CONFIG_APUS) || defined(CONFIG_8xx) ||
defined(CONFIG_40x)
+#if defined(CONFIG_APUS) || defined(CONFIG_8xx) ||
defined(CONFIG_4xx)
        return iopa ((unsigned long) address);
 #else
        return (unsigned long) address - KERNELBASE;


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
