Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CE3C8B6F77
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Jul 2011 12:47:48 +1000 (EST)
Subject: Re: pci_pcie_cap invalid on AER/EEH enabled PPC?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Richard A Lary <rlary@linux.vnet.ibm.com>
In-Reply-To: <4E13A8F0.80700@linux.vnet.ibm.com>
References: <BANLkTinZSeq5H=K4K4s_cuC2tOwsTZEDJg@mail.gmail.com>
	<4E0E1253.1000909@linux.vnet.ibm.com>
	<BANLkTinTEk2SgBwVUHc49cDLEwH_a-XsJg@mail.gmail.com>
	<4E0E274C.4000402@linux.vnet.ibm.com>	<4E1330A3.8080004@linux.vnet.ibm.com>
	<CAPoiz9wArpezPaovSwKVCX3whGRmbAcYjywKX_dUng7wSeW7KQ@mail.gmail.com>
	<4E13486C.3000409@linux.vnet.ibm.com>
	<4E137558.7030204@linux.vnet.ibm.com>
	<4E13A8F0.80700@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 06 Jul 2011 12:47:27 +1000
Message-ID: <1309920447.14501.288.camel@pasglop>
Mime-Version: 1.0
Cc: James Smart <james.smart@emulex.com>, linux-pci@vger.kernel.org,
	Anton Blanchard <anton@au1.ibm.com>,
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

On Tue, 2011-07-05 at 17:14 -0700, Richard A Lary wrote:

> I applied the debug patches mentioned above along with the lpfc patch
> http://marc.info/?l=linux-scsi&m=130919648513685&w=2
> to linux 3.0-rc6 kernel.
> 
> The debug patches show that pci_dev members "is_pcie, pci_cap and pcie_type" are 
> now all being set to correct values now that 'of_create_pci_dev()' calls 
> 'set_pcie_port_type()'.  I was not able to determine when this patch went in.

git is good for that :-)

bb209c8287d2d55ec4a67e3933346e0a3ee0da76:

Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>  2010-01-27 04:10:03
Committer: Benjamin Herrenschmidt <benh@kernel.crashing.org>  2010-01-29 16:51:10
Parent: 4406c56d0a4da7a37b9180abeaece6cd00bcc874 (Merge branch 'linux-next' of git://git.kernel.org/pub/scm/linux/kernel/git/jbarnes/pci-2.6)
Child:  26b4a0ca46985ae9586c194f7859f3838b1230f8 (powerpc/pci: Add missing hookup to pci_slot)
Branches: many (38)
Follows: v2.6.33-rc5
Precedes: v2.6.33-rc7

    powerpc/pci: Add calls to set_pcie_port_type() and set_pcie_hotplug_bridge()
    
    We are missing these when building the pci_dev from scratch off
    the Open Firmware device-tree
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>

We should probably backport it to .32-stable. Any volunteer ?

You might also want to consider for backport:
26b4a0ca46985ae9586c194f7859f3838b1230f8 and
94afc008e1e6fbadfac0b75fcf193b6d7074b2f1

> My tests show that lpfc driver now recovers from injected PCIe bus errors
> using test the 'if (pci_is_pcie(pdev))' for PCIe adapter type.
> 
> I did not apply the test patch which changed the location of 
> set_pcie_port_type(dev) in of_create_pci_dev().  I can apply and test
> this change if you think it is necessary?

No I think we call it in the right place, which mirrors
pci_setup_device(), that is before the early quirk.

> Based upon these results, I will ACK the change to the lpfc driver for
> "[PATCH 03/19] lpfc: remove unnecessary read of PCI_CAP_ID_EXP".
> I suspect that other drivers which are modified to use 'if (pci_is_pcie(pdev))'
> will work on Power PC as well, but I did not test any drivers other than lpfc.

Cheers,
Ben.
