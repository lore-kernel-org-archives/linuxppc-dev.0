Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404rR507ljzF0wc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 09:32:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <helgaas@kernel.org>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Olof Johansson <olof@lixom.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/1] PCI set flag PCI_SCAN_ALL_PCIE_DEVS for P.A. Semi
 boards
In-Reply-To: <20180319191310.GG77194@bhelgaas-glaptop.roam.corp.google.com>
References: <4cfe3cc0-7fe3-9774-7d20-1b7fcb7aa910@xenosoft.de>
 <CAErSpo55Q8Q=5p6_+uu7ahnw+53ibVDNRXxrzRV9QnUr_9EUfw@mail.gmail.com>
 <28b43e1a-3643-9edb-7123-be1cb0dc846a@xenosoft.de>
 <CAErSpo7fup7+doD6A7RKh8kdE8HQaQrEh=gq35+nC-dBeOQ1uA@mail.gmail.com>
 <527175f7-8a13-37a1-9f0a-0b918aeebd64@xenosoft.de>
 <20171130224243.GB19640@bhelgaas-glaptop.roam.corp.google.com>
 <406ba7c4-7305-4069-227f-81afed202e47@xenosoft.de>
 <20171201232716.GA18780@bhelgaas-glaptop.roam.corp.google.com>
 <dc228918-652a-e24c-ce7b-8d1b30153d3b@xenosoft.de>
 <639e975f-1b3a-4f85-9a40-13fe2473fc28@xenosoft.de>
 <20180319191310.GG77194@bhelgaas-glaptop.roam.corp.google.com>
Date: Tue, 20 Mar 2018 09:32:14 +1100
Message-ID: <87tvtbg0i9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Fri, Mar 16, 2018 at 01:55:36PM +0100, Christian Zigotzky wrote:
>> Bjorn Helgaas created a patch for making PCI_SCAN_ALL_PCIE_DEVS work for
>> Root Ports as well as Downstream. Previously PCI_SCAN_ALL_PCIE_DEVS (set=
 by
>> quirks or the "pci=3Dpcie_scan_all"
>> kernel parameter) only affected Switch Downstream Ports, not Root Ports.=
 The
>> problem is, that we have to add always the boot argument "pci=3Dpcie_sca=
n_all"
>> for using Bjorn's improvements. Without the boot argument
>> "pci=3Dpcie_scan_all", the kernel doesn't boot on P.A. Semi boards with =
SB600
>> chipset (SB600 chipset is connected via PCIe x4 to the P.A. Semi=E2=80=
=99s
>> PA6T-1682M System-on-a-Chip) because the kernel can't find any drives
>> connected to the SB600 anymore. Olof Johansson has created a patch for
>> executing "pci=3Dpcie_scan_all" automatically on P.A. Semi boards. With =
his
>> patch, we don't need to add 'pci=3Dpcie_scan_all' to the kernel boot arg=
uments
>> anymore.
>
> The patch looks fine, but I need a signed-off-by line before I can apply
> it.  See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it/tree/Documentation/process/submitting-patches.rst

I'm happy to take it, I've been meaning to check if Olof sent a SOB in
his original mail but haven't got to it.

...

Yes, he did, see below.

So I'll merge that, I'll add a Tested-by for you Christian.

Christian please don't remove any of the tags when submitting other
peoples' patches in future.

cheers


>From a3b390277627b0342c8ccfc16e58679e0d8abdde Mon Sep 17 00:00:00 2001
From: Olof Johansson <olof@lixom.net>
Date: Sat, 2 Dec 2017 14:56:36 -0800
Subject: [PATCH] powerpc/pasemi: set PCI_SCAN_ALL_PCI_DEVS

Needed on Amiga X1000 with SB600.

Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/powerpc/platforms/pasemi/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/p=
asemi/pci.c
index 5ff6108..ea54ed2 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -224,6 +224,8 @@ void __init pas_pci_init(void)
		return;
	}

+	pci_set_flag(PCI_SCAN_ALL_PCIE_DEVS):
+
	for (np =3D NULL; (np =3D of_get_next_child(root, np)) !=3D NULL;)
		if (np->name && !strcmp(np->name, "pxp") && !pas_add_bridge(np))
			of_node_get(np);
