Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401P3w2yzvzF09V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 18:48:42 +1100 (AEDT)
Subject: PASEMI: PCI_SCAN_ALL_PCIE_DEVS
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: linuxppc-dev@lists.ozlabs.org, Olof Johansson <olof@lixom.net>
References: <BD2DFDC2-07CF-41A8-9AAE-9D990EFF6360@xenosoft.de>
Message-ID: <95560a8d-a75b-4ce1-8939-d2999e57e8fc@xenosoft.de>
Date: Wed, 14 Mar 2018 08:48:34 +0100
MIME-Version: 1.0
In-Reply-To: <BD2DFDC2-07CF-41A8-9AAE-9D990EFF6360@xenosoft.de>
Content-Type: multipart/mixed; boundary="------------9ED0271E1EEED8E60AA1655B"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------9ED0271E1EEED8E60AA1655B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

Please find attached the current pci.c patch. We use this patch on our 
P.A. Semi boards because we don't need to add 'pci=pcie_scan_all' to the 
kernel boot arguments.

Please add this patch to the official kernel source code.

Thanks,
Christian

--------------9ED0271E1EEED8E60AA1655B
Content-Type: text/x-patch;
 name="pci.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pci.c.patch"

arch/powerpc/platforms/pasemi/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index 5ff6108..ea54ed2 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -224,6 +224,8 @@ void __init pas_pci_init(void)
 		return;
 	}
 
+	pci_set_flags(PCI_SCAN_ALL_PCIE_DEVS);
+
 	for (np = NULL; (np = of_get_next_child(root, np)) != NULL;)
 		if (np->name && !strcmp(np->name, "pxp") && !pas_add_bridge(np))
 			of_node_get(np);

--------------9ED0271E1EEED8E60AA1655B--
