Return-Path: <B38951@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
 [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 15CB31007D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 17:18:36 +1100 (EST)
Received: from mail75-am1 (localhost [127.0.0.1])	by mail75-am1-R.bigfish.com
 (Postfix) with ESMTP id 64F954C046A	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 22 Nov 2011 06:17:28 +0000 (UTC)
Received: from AM1EHSMHS020.bigfish.com (unknown [10.3.201.243])	by
 mail75-am1.bigfish.com (Postfix) with ESMTP id 3D8446C0045	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 06:17:28 +0000 (UTC)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Gala Kumar-B11780 <B11780@freescale.com>
Subject: RE: [PATCH] Do not hide resource for pci/pcie when configured as
 Agent/EP
Date: Tue, 22 Nov 2011 06:18:25 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5DFD4DA0@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1319789280-12091-1-git-send-email-B38951@freescale.com>
In-Reply-To: <1319789280-12091-1-git-send-email-B38951@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,
We want more comments on this patch to speed up the pushing-to-kernel progr=
ess.
Thanks.

-----Original Message-----
From: Jia Hongtao-B38951=20
Sent: Friday, October 28, 2011 4:08 PM
To: linuxppc-dev@lists.ozlabs.org
Cc: Li Yang-R58472; Gala Kumar-B11780; Jia Hongtao-B38951
Subject: [PATCH] Do not hide resource for pci/pcie when configured as Agent=
/EP

From: Jason Jin <Jason.jin@freescale.com>

Current pci/pcie init code will hide the pci/pcie host resource.
But did not judge it is host/RC or agent/EP. If configured as agent/EP, we =
should avoid hiding its resource in the host side.

In PCI system, the Programing Interface can be used to judge the host/agent=
 status:
Programing Interface =3D 0: host
Programing Interface =3D 1: Agent

In PCIE system, both the Programing Interface and Header type can be used t=
o judge the RC/EP status.
Header Type =3D 0: EP
Header Type =3D 1: RC

Signed-off-by: Jason Jin <Jason.jin@freescale.com>
Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/kernel/pci-common.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-com=
mon.c
index 4f134132c..bc61a69 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1732,10 +1732,13 @@ void __devinit pcibios_scan_phb(struct pci_controll=
er *hose)  static void fixup_hide_host_resource_fsl(struct pci_dev *dev)  {
 	int i, class =3D dev->class >> 8;
+	/* When configured as agent, programing interface =3D 1 */
+	int prog_if =3D dev->class & 0xf;
=20
 	if ((class =3D=3D PCI_CLASS_PROCESSOR_POWERPC ||
 	     class =3D=3D PCI_CLASS_BRIDGE_OTHER) &&
 		(dev->hdr_type =3D=3D PCI_HEADER_TYPE_NORMAL) &&
+		(prog_if =3D=3D 0) &&
 		(dev->bus->parent =3D=3D NULL)) {
 		for (i =3D 0; i < DEVICE_COUNT_RESOURCE; i++) {
 			dev->resource[i].start =3D 0;
--
1.7.5.1
