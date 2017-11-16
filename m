Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yctln5N5qzDqsT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 18:53:24 +1100 (AEDT)
Received: from [192.168.1.139] (ppp-188-174-80-201.dynamic.mnet-online.de
 [188.174.80.201]) by smtp.strato.de (RZmta 42.9 DYNA|AUTH)
 with ESMTPSA id m08e38tAG7l9oAg
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate)
 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 16 Nov 2017 08:47:09 +0100 (CET)
To: linuxppc-dev@lists.ozlabs.org
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [PATCH] SB600 for the Nemo board has non-zero devices on non-root bus
Message-ID: <f3513294-6da0-456f-0f98-1f8c3bac90c9@xenosoft.de>
Date: Thu, 16 Nov 2017 08:47:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

Just a small patch for the P.A. Semi Nemo board:

-----

diff -rupN a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c    2017-11-16 08:18:40.504012010 +0100
+++ b/drivers/pci/probe.c    2017-11-16 08:17:22.044368405 +0100
@@ -2219,6 +2219,8 @@ static int only_one_child(struct pci_bus

      if (!parent || !pci_is_pcie(parent))
          return 0;
+    #ifndef CONFIG_PPC_PASEMI_NEMO
+    // SB600 for the Nemo board has non-zero devices on non-root bus.
      if (pci_pcie_type(parent) == PCI_EXP_TYPE_ROOT_PORT)
          return 1;

@@ -2231,6 +2233,7 @@ static int only_one_child(struct pci_bus
      if (parent->has_secondary_link &&
          !pci_has_flag(PCI_SCAN_ALL_PCIE_DEVS))
          return 1;
+    #endif
      return 0;
  }

----

This is my first patch on this mailing list. Sorry if it isn't in a good 
quality. I am still learning. I hope you can add it.

Thanks,
Christian
