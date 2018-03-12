Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4005vd2kd1zDrC6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 16:22:01 +1100 (AEDT)
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Date: Mon, 12 Mar 2018 06:21:53 +0100
Subject: PASEMI: PCI_SCAN_ALL_PCIE_DEVS
Message-Id: <BD2DFDC2-07CF-41A8-9AAE-9D990EFF6360@xenosoft.de>
To: linuxppc-dev@lists.ozlabs.org, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

Could you please add Olof=E2=80=98s patch. Without this patch, we have to al=
ways add 'pci=3Dpcie_scan_all' to the kernel boot arguments. Please add it.

Olof's patch for P.A. Semi boards:

---

arch/powerpc/platforms/pasemi/pci.c | 2 ++
1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pa=
semi/pci.c
index 5ff6108..ea54ed2 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -224,6 +224,8 @@ void __init pas_pci_init(void)
return;
}

+ pci_set_flags(PCI_SCAN_ALL_PCIE_DEVS);
+
for (np =3D NULL; (np =3D of_get_next_child(root, np)) !=3D NULL;)
if (np->name && !strcmp(np->name, "pxp") && !pas_add_bridge(np))
of_node_get(np);

---

Thanks,
Christian=
