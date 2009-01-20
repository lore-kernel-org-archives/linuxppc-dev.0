Return-Path: <tom.d.arbuckle@gmail.com>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.235])
	by ozlabs.org (Postfix) with ESMTP id 2C9DCDDE25
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 06:17:53 +1100 (EST)
Received: by qb-out-0506.google.com with SMTP id a16so1742498qbd.39
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 11:17:51 -0800 (PST)
Message-ID: <e86dc2bc0901201117u3359c561pd1d8567484a8a17b@mail.gmail.com>
Date: Tue, 20 Jan 2009 19:17:50 +0000
From: "Tom Arbuckle" <tom.d.arbuckle@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC PATCH] "multifunc-device": fix IRQ assignment by also
	scanning dummy nodes
In-Reply-To: <e86dc2bc0901051200l1a111022o8842c2f66135da11@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e86dc2bc0901051200l1a111022o8842c2f66135da11@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Did anybody pick up on this patch necessary to have OF understand
so-called "multifunc-devices". I received no feedback on it.

I note that the problem persists with 2.6.28.1 (although it was
introduced by the PCI reorg for 2.6.20). File pci_32.c is unchanged in
the latest release.

Regards,


Tom Arbuckle

Homepage: http://www.ece.ul.ie/homepage/Tom_Arbuckle/
LinkedIn: http://www.linkedin.com/in/tomarbuckle


---------- Original message ----------

Kernel: 2.6.28; function: scan_OF_pci_childs; file: arch/powerpc/kernel/pci_32.c
Quoting from line 206 : 'some OFs create a parent node "multifunc-device" as a
fake root for all functions of a multi-function device. we go down
them as well.'

Function scan_OF_for_pci_dev (line 225) also needs to be taught about
these dummy nodes to prevent misallocation/non-allocation of IRQs for
this class of devices.

Why RFC? I have chosen to scan all 'unusual' nodes as possible
multifunc-devices. Is this too many?

Bug seen when using a bt878 multimedia controller card on a G3 Powermac.
This PCI card has separate audio and video nodes and was not being properly
assigned interrupts. (Either 'cannot grab irq 0' or type of assigned
interrupt wrt 'edge/level' was incorrect).

Signed off by: Tom Arbuckle <tom.d.arbuckle (at) gmail.com>


--- linux-2.6.28/arch/powerpc/kernel/pci_32.c.orig      2008-12-27
16:32:48.000000000 +0000
+++ linux-2.6.28/arch/powerpc/kernel/pci_32.c   2008-12-27
16:36:15.000000000 +0000
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
