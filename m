Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Subject: Re: 2.6.29-rc6-git6 defconfig build failure 
In-reply-to: <49ACFD4E.8060506@in.ibm.com> 
References: <49ACFD4E.8060506@in.ibm.com>
Date: Tue, 03 Mar 2009 22:50:02 +1100
Message-ID: <17031.1236081002@neuling.org>
Sender: mikey@neuling.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sachin,

2450cf51a1bdba7037e91b1bcc494b01c58aaf66 fixes this.  Already upstream.

Mikey

In message <49ACFD4E.8060506@in.ibm.com> you wrote:
> 2.6.29-rc6-git6 ppc64_defconfig build fails with 
> 
> arch/powerpc/kernel/built-in.o: In function `.of_pci_phb_probe':
> of_platform.c:(.devinit.text+0xe0): undefined reference to `.pcibios_claim_on
e_bus'
> arch/powerpc/platforms/built-in.o: In function `.remove_phb_dynamic':
> (.text+0x120fc): undefined reference to `.pcibios_unmap_io_space'
> arch/powerpc/platforms/built-in.o: In function `.pcibios_add_pci_devices':
> (.text+0x12338): undefined reference to `.pcibios_finish_adding_to_bus'
> arch/powerpc/platforms/built-in.o: In function `.init_phb_dynamic':
> (.devinit.text+0x6ec): undefined reference to `.pcibios_finish_adding_to_bus'
> make: *** [.tmp_vmlinux1] Error 1
> 
> git5 did not have this problem as CONFIG_HOTPLUG was set with ppc64_defconfig
.
> With git6 defconfig there is no CONFIG_HOTPLUG
> 
> # grep CONFIG_HOTPLUG linux-2.6.29-rc6-git6/.config
> # 
> 
> # grep CONFIG_HOTPLUG linux-2.6.29-rc6-git5/.config
> CONFIG_HOTPLUG=y
> CONFIG_HOTPLUG_CPU=y
> CONFIG_HOTPLUG_PCI=m
> # CONFIG_HOTPLUG_PCI_FAKE is not set
> # CONFIG_HOTPLUG_PCI_CPCI is not set
> # CONFIG_HOTPLUG_PCI_SHPC is not set
> CONFIG_HOTPLUG_PCI_RPA=m
> CONFIG_HOTPLUG_PCI_RPA_DLPAR=m
> 
> Thanks
> -Sachin
> 
> -- 
> 
> ---------------------------------
> Sachin Sant
> IBM Linux Technology Center
> India Systems and Technology Labs
> Bangalore, India
> ---------------------------------
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
