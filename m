Return-Path: <michal.simek@petalogix.com>
Received: from mail-bw0-f223.google.com (mail-bw0-f223.google.com
	[209.85.218.223]) by ozlabs.org (Postfix) with ESMTP id 5CBA7B7C90
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2010 02:25:39 +1100 (EST)
Received: by bwz23 with SMTP id 23so15233461bwz.9
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jan 2010 07:25:35 -0800 (PST)
Message-ID: <4B4DE58D.10008@petalogix.com>
Date: Wed, 13 Jan 2010 16:23:57 +0100
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
	benh@kernel.crashing.org, thunderbird2k@gmx.net,
	John Williams <john.williams@petalogix.com>,
	Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>
Subject: xilinx-pci driver and pci in general
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: michal.simek@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi guys,

We (John and partially I) did initial support for pci on Microblaze.
It is based on powerpc files and almost everything is the same.
There are some small differences which could be easily removed that's 
why I think that will be good to move that file to any generic location.
That's why I would like to know your opinion about this step.
If you don't like or prefer we will add that modified versions to 
arch/microblaze and in future we can merge them and move to any other 
location.

Affected files: xilinx-pci.c, pci_32.c pci-common.c, indirect_pci.c and 
some headers.


The main problems are:
ppc use ppc_md struct which we don't have it on Microblaze.
xilinx-pci driver uses exclude_device function. This function is used in 
indirect_pci.c too. There could be a way to move that function directly 
to pci_controller structure which could be useful for other controllers 
too. What do you think?

Then there are some other ppc_md. calling like pcibios_after_init which
if I see correctly not used for ppc too.

The next thing is that some files contains asm/machdep.h which could be 
added to asm/pci-bridge.h and the same is for asm/ppc-pci.h

Files contains CONFIG_PPC_OF and we would like to use only CONFIG_OF.
I remember any discuss around but not sure what was the conclusion on 
powerpc.

Part of headers are the same that's why there will be a space to move 
them to asm-generic.
Anyway: I look at your dma-mapping.h and you can use 
asm-generic/dma-mapping-common.h as I am using.


Then I have some question about EARLY_PCI_OP in ppc_32.c. Is there any 
reason to use early_##rw##_config_##size fucntions instead of proper 
pci_bus_##rw##_config_##size functions?
There is one comment that these functions are used before PCI scanning 
is done but there are used the same function as are in driver/pci/access.c.
Is there any "secret" reason to do it in this way?


Thanks for this early discuss. I would like to hear your opinion and 
then I will choose solution how to add our pci support to mainline.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663
