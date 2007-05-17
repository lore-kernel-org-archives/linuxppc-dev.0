Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 22881DDE34
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 18:56:29 +1000 (EST)
Received: from lyakh (helo=localhost)
	by poirot.grange with local-esmtp (Exim 3.36 #1 (Debian))
	id 1Hobmi-0002Ah-00
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 10:56:32 +0200
Date: Thu, 17 May 2007 10:56:32 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] don't link timer.o for powerpc systems using generic rtc
Message-ID: <Pine.LNX.4.60.0705171021550.5029@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With both generic rtc and powerpc timer suspend / resume code now in the 
(powerpc.git) tree, powerpc platforms using the generic timer and enabling 
power management will have timer.o linked in the kernel, which they don't 
need. Moreover, it will likely WARN_ON(!ppc_md.get_rtc_time), save 
zero-time and return no error on suspend...

As a possible solution we can choose not to build timer.o when RTC_CLASS 
is enabled. However, I can imagine systems with 2 rtc's, one served by the 
ppc-rtc, another one generic built as a module, in which case using the 
ppc-rtc for suspend / resume will be impossible. Not to say, that such a 
configuration would be ugly...

Signed-off-by: G. Liakhovetski <g.liakhovetski@gmx.de>

diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index c3ce0bd..31da3b3 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -20,7 +20,9 @@ mv64x60-$(CONFIG_PCI)		+= mv64x60_pci.o
 obj-$(CONFIG_MV64X60)		+= $(mv64x60-y) mv64x60_pic.o mv64x60_dev.o
 
 # contains only the suspend handler for time
+ifeq ($(CONFIG_RTC_CLASS),)
 obj-$(CONFIG_PM)		+= timer.o
+endif
 
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
