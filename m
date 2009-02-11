Return-Path: <tom.d.arbuckle@gmail.com>
Received: from mail-ew0-f21.google.com (mail-ew0-f21.google.com
	[209.85.219.21]) by ozlabs.org (Postfix) with ESMTP id B9CCEDDDAA
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 07:41:56 +1100 (EST)
Received: by ewy14 with SMTP id 14so506008ewy.9
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 12:41:54 -0800 (PST)
Date: Wed, 11 Feb 2009 20:41:48 -0000
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] "multifunc-device": fix IRQ assignment by also scanning dummy
	nodes
From: Tom Arbuckle <tom.d.arbuckle@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
MIME-Version: 1.0
Message-ID: <op.uo7fryg3fq1scd@kams>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, Ben.


I've regenerated this patch against 2.6.28.4.

______

Kernel: 2.6.28.4; function: scan_OF_pci_childs; file: arch/powerpc/kernel/pci_32.c
Quoting from line 206 : 'some OFs create a parent node "multifunc-device" as a
fake root for all functions of a multi-function device. we go down them as well.'

Function scan_OF_for_pci_dev (line 225) also needs to be taught about
these dummy nodes to prevent misallocation/non-allocation of IRQs for
this class of devices.

Bug seen when using a bt878 multimedia controller card on a G3 Powermac.
This PCI card has separate audio and video nodes and was not being properly
assigned interrupts. (Either 'cannot grab irq 0' or type of assigned
interrupt wrt 'edge/level' was incorrect).

Signed off by: Tom Arbuckle <tom.d.arbuckle (at) gmail.com>

______

Regards,


Tom Arbuckle

Homepage: http://www.ece.ul.ie/homepage/Tom_Arbuckle/
LinkedIn: http://www.linkedin.com/in/tomarbuckle


--- linux-2.6.28.4/arch/powerpc/kernel/pci_32.c.orig    2009-02-06 21:47:45.000000000 +0000
+++ linux-2.6.28.4/arch/powerpc/kernel/pci_32.c 2009-02-07 16:37:04.000000000 +0000
@@ -226,15 +226,21 @@ static struct device_node *scan_OF_for_p
                                               unsigned int devfn)
 {
        struct device_node *np;
+       struct device_node *np_sub = NULL;
        const u32 *reg;
        unsigned int psize;
 
        for_each_child_of_node(parent, np) {
                reg = of_get_property(np, "reg", &psize);
-               if (reg == NULL || psize < 4)
-                       continue;
-               if (((reg[0] >> 8) & 0xff) == devfn)
-                       return np;
+               if (reg && psize >= 4) {
+                       if (((reg[0] >> 8) & 0xff) == devfn)
+                               return np;
+               }
+               if (!strcmp(np->name, "multifunc-device")) {
+                       np_sub = scan_OF_for_pci_dev(np, devfn);
+                       if (np_sub)
+                               return np_sub;
+               }
        }
        return NULL;
 }
