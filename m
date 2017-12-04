Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yqsjH5qGzzDrbr
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Dec 2017 15:44:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: [PATCH v1] PCI: Make PCI_SCAN_ALL_PCIE_DEVS work for Root as well
 as Downstream Ports
In-Reply-To: <20171202191827.GB18780@bhelgaas-glaptop.roam.corp.google.com>
References: <20171202002710.17686.21340.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171202191827.GB18780@bhelgaas-glaptop.roam.corp.google.com>
Date: Mon, 04 Dec 2017 15:44:15 +1100
Message-ID: <87k1y33xwg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Fri, Dec 01, 2017 at 06:27:10PM -0600, Bjorn Helgaas wrote:
>> From: Bjorn Helgaas <bhelgaas@google.com>
>> 
>> PCIe Downstream Ports normally have only a Device 0 below them.  To
>> optimize enumeration, we don't scan for other devices *unless* the
>> PCI_SCAN_ALL_PCIE_DEVS flag is set by set by quirks or the
>> "pci=pcie_scan_all" kernel parameter.
>> 
>> Previously PCI_SCAN_ALL_PCIE_DEVS only affected scanning below Switch
>> Downstream Ports, not Root Ports.
>> 
>> But the "Nemo" system, also known as the AmigaOne X1000, has a PA Semi Root
>> Port whose link leads to an AMD/ATI SB600 South Bridge.  The Root Port is a
>> PCIe device, of course, but the SB600 contains only conventional PCI
>> devices with no visible PCIe port.
>> 
>> Simplify and restructure only_one_child() so that we scan for all possible
>> devices below Root Ports as well as Switch Downstream Ports when
>> PCI_SCAN_ALL_PCIE_DEVS is set.
>> 
>> This is enough to make Nemo work with "pci=pcie_scan_all".  We would also
>> like to add a quirk to set PCI_SCAN_ALL_PCIE_DEVS automatically on Nemo so
>> users wouldn't have to use the "pci=pcie_scan_all" parameter, but we don't
>> have that yet.
>> 
>> Link: https://lkml.kernel.org/r/CAErSpo55Q8Q=5p6_+uu7ahnw+53ibVDNRXxrzRV9QnUr_9EUfw@mail.gmail.com
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=198057
>> Reported-and-Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Applied to pci/enumeration for v4.16.

Thanks Bjorn.

cheers
