Return-Path: <tony@bakeyournoodle.com>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 869C4DE0C4
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 15:33:40 +1000 (EST)
To: <linux-kernel@vger.kernel.org>, <linuxppc-dev@ozlabs.org>
Message-Id: <aea82416ed6c6805412a2631fe8a8be6420c5c9d.1239687192.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 1/1] Fix build failure drivers/parport/parport_pc.c for powerpc
Date: Tue, 14 Apr 2009 15:33:40 +1000 (EST)
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In commit 51dcdfec6a274afc1c6fce180d582add9ff512c0 (parport: Use the PCI
IRQ if offered) parport_pc_probe_port() gained an irqflags arg.  This
isn't being supplied on powerpc.  This patch make powerpc fallback to
the old behaviour, that is using "0" for irqflags.

Fixes build failure:
In file included from drivers/parport/parport_pc.c:68:
arch/powerpc/include/asm/parport.h: In function 'parport_pc_find_nonpci_ports':
arch/powerpc/include/asm/parport.h:32: error: too few arguments to function 'parport_pc_probe_port'
arch/powerpc/include/asm/parport.h:32: error: too few arguments to function 'parport_pc_probe_port'
arch/powerpc/include/asm/parport.h:32: error: too few arguments to function 'parport_pc_probe_port'
make[3]: *** [drivers/parport/parport_pc.o] Error 1

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
Resend due to MUA badness

 arch/powerpc/include/asm/parport.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/parport.h b/arch/powerpc/include/asm/parport.h
index 414c50e..94942d6 100644
--- a/arch/powerpc/include/asm/parport.h
+++ b/arch/powerpc/include/asm/parport.h
@@ -29,7 +29,7 @@ static int __devinit parport_pc_find_nonpci_ports (int autoirq, int autodma)
 		prop = of_get_property(np, "interrupts", NULL);
 		if (!prop)
 			continue;
-		if (parport_pc_probe_port(io1, io2, prop[0], autodma, NULL) != NULL)
+		if (parport_pc_probe_port(io1, io2, prop[0], autodma, NULL, 0) != NULL)
 			count++;
 	}
 	return count;
-- 
1.6.0.6
