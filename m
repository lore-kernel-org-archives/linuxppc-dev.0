Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402knd1HhNzDq82
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 23:10:58 +1100 (AEDT)
Subject: [PATCH 0/1] PCI set flag PCI_SCAN_ALL_PCIE_DEVS for P.A. Semi boards
To: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Olof Johansson <olof@lixom.net>
References: <f3513294-6da0-456f-0f98-1f8c3bac90c9@xenosoft.de>
 <87tvxl15qx.fsf@concordia.ellerman.id.au>
 <4cfe3cc0-7fe3-9774-7d20-1b7fcb7aa910@xenosoft.de>
 <CAErSpo55Q8Q=5p6_+uu7ahnw+53ibVDNRXxrzRV9QnUr_9EUfw@mail.gmail.com>
 <28b43e1a-3643-9edb-7123-be1cb0dc846a@xenosoft.de>
 <CAErSpo7fup7+doD6A7RKh8kdE8HQaQrEh=gq35+nC-dBeOQ1uA@mail.gmail.com>
 <527175f7-8a13-37a1-9f0a-0b918aeebd64@xenosoft.de>
 <20171130224243.GB19640@bhelgaas-glaptop.roam.corp.google.com>
 <406ba7c4-7305-4069-227f-81afed202e47@xenosoft.de>
 <20171201232716.GA18780@bhelgaas-glaptop.roam.corp.google.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <dc228918-652a-e24c-ce7b-8d1b30153d3b@xenosoft.de>
Date: Fri, 16 Mar 2018 13:10:43 +0100
MIME-Version: 1.0
In-Reply-To: <20171201232716.GA18780@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02 December 2017 at 00:27PM, Bjorn Helgaas wrote:
 > On Fri, Dec 01, 2017 at 11:08:46PM +0100, Christian Zigotzky wrote:
 >> On 30.11.2017 23:42, Bjorn Helgaas wrote:
 >>>
 >>> 00:11.0 claims to be a PCIe Root Port leading to [bus 05-06]. That
 >>> means there's a Link (presumably this A-Link II Express thing), and the
 >>> downstream end of the Link *should* be a PCIe Upstream Port on bus 05,
 >>> but no such device is visible.  I suppose the SB600 does implement
 >>> some sort of PCIe Port there, but keeps it invisible to software, and
 >>> at the same time, contains an invisible bridge that connects the Link
 >>> to all the conventional PCI devices on bus 05.
 >>>
 >>> When we scan bus 05, we do this:
 >>>
 >>>    pci_scan_child_bus_extend(bus=05)
 >>>      for (devfn = 0; devfn < 0x100; devfn += 8)
 >>>        pci_scan_slot(05, 00.0)
 >>>          pci_scan_single_device
 >>>            pci_scan_device(05, 00.0)           # fails; no 05:00.0
 >>>        pci_scan_slot(05, 01.0)
 >>>          only_one_child(bus=05)
 >>>            parent = 00:11.0
 >>>            pci_pcie_type(00:11.0) == ROOT_PORT # returns true
 >>>
 >>> Since only_one_child() sees that 00:11.0 is a Root Port, we give up
 >>> before we even get to the PCI_SCAN_ALL_PCIE_DEVS test.
 >>>
 >>> I *think* something like the patch below should make this work if you
 >>> use the "pci=pcie_scan_all" parameter.  We have some x86 DMI quirks
 >>> that set PCI_SCAN_ALL_PCIE_DEVS automatically.  I don't know how to do
 >>> something similar on powerpc, but maybe you do?
 >>>
 >>
 >> Hi Bjorn,
 >>
 >> I tested your new patch today. It boots with the boot argument
 >> "pci=pcie_scan_all". Well done! :-)
 >>
 >> It doesn't boot without the boot argument "pci=pcie_scan_all".
 >
 > Thanks for testing that.  I'll merge a similar patch for v4.16.
 >
 > I don't think using "pci=pcie_scan_all" is really an acceptable
 > long-term answer for you, though.  Is there some way we can identify
 > at run-time whether we're on a Nemo system?  If so, we can make this
 > happen automatically.
 >
 > Bjorn
 >

Hi Bjorn,
Hi All,

Olof Johansson has created a patch for us. With this patch, 
"pci=pcie_scan_all" executes automatically on P.A. Semi boards. We don't 
need to add 'pci=pcie_scan_all' to the
kernel boot arguments anymore. Could you please add Olof's patch to the 
official kernel source code?

arch/powerpc/platforms/pasemi/pci.c | 2 ++
  1 file changed, 2 insertions(+)

Thanks,
Christian
