Return-Path: <teodori.serge@gmail.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 692452C0088
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2012 07:21:04 +1000 (EST)
Received: by wibhm2 with SMTP id hm2so3053232wib.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Sep 2012 14:20:59 -0700 (PDT)
From: Teodori Serge <teodori.serge@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/1] drivers/char/mem.c
Date: Sat, 22 Sep 2012 23:20:12 +0200
Message-Id: <1348348812-17201-1-git-send-email-teodori.serge@hotmail.com>
In-Reply-To: <Teodori Serge <teodori.serge@hotmail.com>
References: <Teodori Serge <teodori.serge@hotmail.com>
Cc: Teodori Serge <teodori.serge@hotmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

replace 'arch_has_dev_port()' to 'CONFIG_DEVPORT'

modified:   arch/powerpc/include/asm/io.h
modified:   drivers/char/mem.c
modified:   include/linux/io.h

why do we need 'arch_has_dev_port()' if we have a 'CONFIG_DEVPORT'?

Signed-off-by: Teodori Serge <teodori.serge@hotmail.com>
---
 arch/powerpc/include/asm/io.h |    2 +-
 drivers/char/mem.c            |    6 ------
 include/linux/io.h            |    9 ---------
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index f94ef42..cb8b663 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -25,7 +25,7 @@ extern struct pci_dev *isa_bridge_pcidev;
 /*
  * has legacy ISA devices ?
  */
-#define arch_has_dev_port()	(isa_bridge_pcidev != NULL)
+#define CONFIG_DEVPORT	(isa_bridge_pcidev != NULL)
 #endif
 
 #include <linux/device.h>
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index e5eedfa..7251a67 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -897,12 +897,6 @@ static int __init chr_dev_init(void)
 		if (!devlist[minor].name)
 			continue;
 
-		/*
-		 * Create /dev/port? 
-		 */
-		if ((minor == DEVPORT_MINOR) && !arch_has_dev_port())
-			continue;
-
 		device_create(mem_class, NULL, MKDEV(MEM_MAJOR, minor),
 			      NULL, devlist[minor].name);
 	}
diff --git a/include/linux/io.h b/include/linux/io.h
index 069e407..7fd2d21 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -67,13 +67,4 @@ int check_signature(const volatile void __iomem *io_addr,
 			const unsigned char *signature, int length);
 void devm_ioremap_release(struct device *dev, void *res);
 
-/*
- * Some systems do not have legacy ISA devices.
- * /dev/port is not a valid interface on these systems.
- * So for those archs, <asm/io.h> should define the following symbol.
- */
-#ifndef arch_has_dev_port
-#define arch_has_dev_port()     (1)
-#endif
-
 #endif /* _LINUX_IO_H */
-- 
1.7.9.5
