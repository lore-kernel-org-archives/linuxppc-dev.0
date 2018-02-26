Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqyJX0RSVzDr5C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 10:11:53 +1100 (AEDT)
Subject: PASEMI: PCI_SCAN_ALL_PCIE_DEVS
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <ccafbcca-172b-11ae-7916-8bcd4bfa419c@bitbybitsoftwaregroup.com>
 <DB3PR0402MB3849C70D5760C3F21F881074EC170@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <d7478110-68ae-34b3-51c5-487bb3e12527@bitbybitsoftwaregroup.com>
 <DB3PR0402MB3849C1D81C867CF2D5A65D0EECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Olof Johansson <olof@lixom.net>
Message-ID: <050d3183-51db-844f-453d-ad0224ab071c@xenosoft.de>
Date: Tue, 27 Feb 2018 00:11:45 +0100
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB3849C1D81C867CF2D5A65D0EECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
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

Could you please add Olof's patch?

---

arch/powerpc/platforms/pasemi/pci.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pasemi/pci.c 
b/arch/powerpc/platforms/pasemi/pci.c
index 5ff6108..ea54ed2 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -224,6 +224,8 @@ void __init pas_pci_init(void)
          return;
      }

+    pci_set_flags(PCI_SCAN_ALL_PCIE_DEVS);
+
      for (np = NULL; (np = of_get_next_child(root, np)) != NULL;)
          if (np->name && !strcmp(np->name, "pxp") && !pas_add_bridge(np))
              of_node_get(np);

---

Thanks,
Christian
