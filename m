Return-Path: <tnt@246tNt.com>
Received: from outmx004.isp.belgacom.be (outmx004.isp.belgacom.be
	[195.238.2.101]) by ozlabs.org (Postfix) with ESMTP id 40E5F2BF0E
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Dec 2004 01:17:48 +1100 (EST)
Received: from outmx004.isp.belgacom.be (localhost [127.0.0.1])
	by outmx004.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id iBGEHgGm024620
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Dec 2004 15:17:42 +0100
	(envelope-from <tnt@246tNt.com>)
Received: from ayanami.246tNt.com (238.232-200-80.adsl.skynet.be
	[80.200.232.238])
	by outmx004.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id iBGEHemr024610
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Dec 2004 15:17:41 +0100
	(envelope-from <tnt@246tNt.com>)
Received: from [10.0.0.245] (246tNt-laptop.lan.ayanami.246tNt.com [10.0.0.245])
	by ayanami.246tNt.com (Postfix) with ESMTP id 765F51649A4
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Dec 2004 15:16:38 +0100 (CET)
Message-ID: <41C19905.6070300@246tNt.com>
Date: Thu, 16 Dec 2004 15:17:41 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Linux PPC Dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [PATCH] Add __iomem qualifier to cfg_{addr,data} fields in stuct
 pci_controller
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

The patch below add the __iomem qualifier to the fields containing
addresses to access the PCI config space. It seems right to add them
since they're gonna be used with {in,out}_{le,be} that requires them
not to produce sparse warning.


    Sylvain





ppc32: Add __iomem qualifier to cfg_{addr,data} fields in stuct 
pci_controller

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>

===== include/asm-ppc/pci-bridge.h 1.13 vs edited =====
--- 1.13/include/asm-ppc/pci-bridge.h   2004-11-11 09:25:52 +01:00
+++ edited/include/asm-ppc/pci-bridge.h 2004-12-16 15:07:14 +01:00
@@ -57,8 +57,8 @@
        unsigned long pci_mem_offset;
 
        struct pci_ops *ops;
-       volatile unsigned int *cfg_addr;
-       volatile unsigned char *cfg_data;
+       volatile unsigned int __iomem *cfg_addr;
+       volatile unsigned char __iomem *cfg_data;
        /*
         * If set, indirect method will set the cfg_type bit as
         * needed to generate type 1 configuration transactions.
