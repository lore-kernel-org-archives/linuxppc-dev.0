Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysG2h1N1LzDrJP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 22:04:08 +1100 (AEDT)
Subject: [PATCH] SB600 for the Nemo board has non-zero devices on non-root bus
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Olof Johansson <olof@lixom.net>, Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Darren Stevens <darren@stevens-zone.net>, Bjorn Helgaas
 <helgaas@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <87tvxl15qx.fsf@concordia.ellerman.id.au>
 <4cfe3cc0-7fe3-9774-7d20-1b7fcb7aa910@xenosoft.de>
 <CAErSpo55Q8Q=5p6_+uu7ahnw+53ibVDNRXxrzRV9QnUr_9EUfw@mail.gmail.com>
 <28b43e1a-3643-9edb-7123-be1cb0dc846a@xenosoft.de>
 <CAErSpo7fup7+doD6A7RKh8kdE8HQaQrEh=gq35+nC-dBeOQ1uA@mail.gmail.com>
 <527175f7-8a13-37a1-9f0a-0b918aeebd64@xenosoft.de>
 <20171130224243.GB19640@bhelgaas-glaptop.roam.corp.google.com>
 <406ba7c4-7305-4069-227f-81afed202e47@xenosoft.de>
 <20171201232716.GA18780@bhelgaas-glaptop.roam.corp.google.com>
 <6d2505ab-a985-bdb0-ad3a-e7659cc2c54d@xenosoft.de>
 <20171202230052.34y2ivxgpgr3osct@localhost>
 <CAOesGMhfMpt+xG1vhVHU+O5o4W5y2S5mZyn9tp+CPn9G6XrNVA@mail.gmail.com>
 <4CEE49CE-68F3-457F-B302-54BA8550F36A@xenosoft.de>
 <1d5276c3-1d29-114a-c868-6f022eee58e7@xenosoft.de>
Message-ID: <99f78122-cd53-100f-4f58-be5bf7927d4e@xenosoft.de>
Date: Wed, 6 Dec 2017 12:03:52 +0100
MIME-Version: 1.0
In-Reply-To: <1d5276c3-1d29-114a-c868-6f022eee58e7@xenosoft.de>
Content-Type: multipart/mixed; boundary="------------0BBDA8D34A1E0146826A8C89"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------0BBDA8D34A1E0146826A8C89
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06 December 2017 at 09:37AM, Christian Zigotzky wrote:
 > On 03 December 2017 at 10:43AM, Christian Zigotzky wrote:
 > >
 > > On 3. Dec 2017, at 00:02, Olof Johansson <olof@lixom.net> wrote:
 > >>
 > >> Typo, should be ';', not ':'. I obviously didn't even try 
compiling this. :)
 > >>
 > >>
 > >> -Olof
 > >
 > > Hi Olof,
 > >
 > > Thanks a lot for your patch! I will test it on Wednesday.
 > >
 > > Cheers,
 > > Christian
 >
 >
 > Hi Olof,
 >
 > I tested your patch today. Unfortunately the kernel 4.15-rc2 doesn't 
compile with your patch.
 >
 > Error messages:
 >
 >                        ^~~~~~~~~
 > arch/powerpc/platforms/pasemi/pci.c: In function ‘pas_pci_init’:
 > arch/powerpc/platforms/pasemi/pci.c:298:2: error: implicit 
declaration of function ‘pci_set_flag’ 
[-Werror=implicit-function-declaration]
 >   pci_set_flag(PCI_SCAN_ALL_PCIE_DEVS);
 >   ^~~~~~~~~~~~
 > cc1: some warnings being treated as errors
 >
 > ---
 >
 > I figured out that we need 'pci_set_flags' instead of 'pci_set_flag'. 
I modified your patch and after that the kernel compiles. Please find 
attached the new patch.
 >
 > Cheers,
 > Christian

Hi Olof,

Many thanks for your patch! :-) The RC2 of kernel 4.15 boots without any 
problems on my P.A. Semi Nemo board (A-EON AmigaOne X1000). I don’t need 
the additional boot argument 'pci=pcie_scan_all' anymore.

Is it possible to merge it via the powerpc tree?

Thanks,
Christian





--------------0BBDA8D34A1E0146826A8C89
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

--------------0BBDA8D34A1E0146826A8C89--
