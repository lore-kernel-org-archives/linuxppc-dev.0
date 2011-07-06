Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DD5C4B6F64
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Jul 2011 12:43:09 +1000 (EST)
Subject: Re: pci_pcie_cap invalid on AER/EEH enabled PPC?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Richard A Lary <rlary@linux.vnet.ibm.com>
In-Reply-To: <4E1330A3.8080004@linux.vnet.ibm.com>
References: <BANLkTinZSeq5H=K4K4s_cuC2tOwsTZEDJg@mail.gmail.com>
	<4E0E1253.1000909@linux.vnet.ibm.com>
	<BANLkTinTEk2SgBwVUHc49cDLEwH_a-XsJg@mail.gmail.com>
	<4E0E274C.4000402@linux.vnet.ibm.com>
	<4E1330A3.8080004@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 06 Jul 2011 12:42:50 +1000
Message-ID: <1309920170.14501.284.camel@pasglop>
Mime-Version: 1.0
Cc: James Smart <james.smart@emulex.com>, linux-pci@vger.kernel.org,
	Richard Lary <rlary@us.ibm.com>, Jon Mason <jdmason@kudzu.us>,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> On Power PC platforms, set_pcie_port_type() is not called.  On Power PC,
> pci_dev structure is initialized by of_create_pci_dev().  However, the
> structure member pcie_cap is NOT computed nor set in this function.

Just a quick correction here, please don't say "On Power PC platforms"
such generic statements that only apply to IBM pSeries platforms running
under pHyp :-)

There's plenty of other platforms supported in arch/powerpc that have
very different characteristics and use more "generic" code to build
their PCI layout.

> The information used to populate pci_dev comes from the Power PC
> device_tree passed to the OS by Open Firmware.
> 
> Based upon standing Power PC design, we cannot support patches
> which replace pci_find_capability(pdef, PCI_CAP_ID_EXP) with
> pci_is_pcie(pdev) on Power PC platforms.

No, that isn't correct. We can (and should) fix our arch code to do the
right thing. There is no reason why those two wouldn't be equivalent.

If we are missing a call to set_pcie_port_type() then we should add it,
however if I look at our upstream code, pci_of_scan.c seems to be
calling that, so it could be a missing backport ?

Can you try with an upstream kernel ?

Cheers,
Ben.
