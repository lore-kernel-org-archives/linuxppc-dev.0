Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 09E2BDDF8F
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 20:50:09 +1100 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id n239mrGU004539
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Mar 2009 20:48:53 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n239oP0m332072
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Mar 2009 20:50:25 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n239o7Dr002849
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Mar 2009 20:50:07 +1100
Message-ID: <49ACFD4E.8060506@in.ibm.com>
Date: Tue, 03 Mar 2009 15:20:06 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: 2.6.29-rc6-git6 defconfig build failure
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2.6.29-rc6-git6 ppc64_defconfig build fails with 

arch/powerpc/kernel/built-in.o: In function `.of_pci_phb_probe':
of_platform.c:(.devinit.text+0xe0): undefined reference to `.pcibios_claim_one_bus'
arch/powerpc/platforms/built-in.o: In function `.remove_phb_dynamic':
(.text+0x120fc): undefined reference to `.pcibios_unmap_io_space'
arch/powerpc/platforms/built-in.o: In function `.pcibios_add_pci_devices':
(.text+0x12338): undefined reference to `.pcibios_finish_adding_to_bus'
arch/powerpc/platforms/built-in.o: In function `.init_phb_dynamic':
(.devinit.text+0x6ec): undefined reference to `.pcibios_finish_adding_to_bus'
make: *** [.tmp_vmlinux1] Error 1

git5 did not have this problem as CONFIG_HOTPLUG was set with ppc64_defconfig.
With git6 defconfig there is no CONFIG_HOTPLUG

# grep CONFIG_HOTPLUG linux-2.6.29-rc6-git6/.config
# 

# grep CONFIG_HOTPLUG linux-2.6.29-rc6-git5/.config
CONFIG_HOTPLUG=y
CONFIG_HOTPLUG_CPU=y
CONFIG_HOTPLUG_PCI=m
# CONFIG_HOTPLUG_PCI_FAKE is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set
CONFIG_HOTPLUG_PCI_RPA=m
CONFIG_HOTPLUG_PCI_RPA_DLPAR=m

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
