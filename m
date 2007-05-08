Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 8E8AFDDE3D
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 05:15:52 +1000 (EST)
Date: Tue, 8 May 2007 14:17:58 -0500
To: linuxppc-dev@ozlabs.org
Subject: Current powerpc.git build failures
Message-ID: <20070508191758.GA26879@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@lixom.net (Olof Johansson)
Cc: paulus@samba.org, jdl@jdl.com, arnd@ardnb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Just for fun I tried building all powerpc defconfigs. Fallout as below.


powerpc.cell_defconfig:
ERROR: ".cpufreq_set_policy" [arch/powerpc/platforms/cell/cbe_cpufreq.ko] undefined!
(Should cell move to similar Kconfig options as the other platforms for cpufreq?)

powerpc.mpc8641_hpcn_defconfig:
In file included from include/asm-generic/pgtable-nopmd.h:6,
                 from include/asm/pgtable-ppc32.h:4,
                 from include/asm/pgtable.h:8,
                 from arch/powerpc/platforms/86xx/mpc86xx_smp.c:18:
include/asm-generic/pgtable-nopud.h:13: error: expected specifier-qualifier-list before 'pgd_t'
include/asm-generic/pgtable-nopud.h:25: error: expected ')' before 'pgd'
include/asm-generic/pgtable-nopud.h:26: error: expected ')' before 'pgd'
include/asm-generic/pgtable-nopud.h:27: error: expected ')' before 'pgd'
include/asm-generic/pgtable-nopud.h:28: error: expected ')' before '*' token
include/asm-generic/pgtable-nopud.h:38: error: expected ')' before '*' token
  CC      init/calibrate.o
In file included from include/asm/pgtable.h:12,
                 from arch/powerpc/platforms/86xx/mpc86xx_smp.c:18:
include/asm-generic/pgtable.h: In function 'pgd_none_or_clear_bad':
include/asm-generic/pgtable.h:243: warning: implicit declaration of function 'pgd_none'
include/asm-generic/pgtable.h:245: warning: implicit declaration of function 'pgd_bad'
include/asm-generic/pgtable.h: In function 'pmd_none_or_clear_bad':
include/asm-generic/pgtable.h:265: error: 'pud_t' has no member named 'pgd'
include/asm-generic/pgtable.h:267: error: 'pud_t' has no member named 'pgd'
In file included from include/asm/dma-mapping.h:14,
                 from include/linux/dma-mapping.h:34,
                 from include/asm/pci.h:15,
                 from include/linux/pci.h:755,
                 from include/asm-ppc/pci-bridge.h:6,
                 from include/asm/pci-bridge.h:6,
                 from arch/powerpc/platforms/86xx/mpc86xx_smp.c:20:
include/linux/mm.h: In function 'pud_alloc':
include/linux/mm.h:906: warning: implicit declaration of function 'pud_offset'
include/linux/mm.h:906: warning: pointer/integer type mismatch in conditional expression
arch/powerpc/mm/ppc_mmu_32.c: In function 'hash_preload':
arch/powerpc/mm/ppc_mmu_32.c:188: warning: passing argument 1 of 'pmd_offset' from incompatible pointer type
(Maybe this is already fixed by some of the 32-bit mmu patches posted the last few days)

powerpc.mpc866_ads_defconfig:
arch/powerpc/sysdev/mpc8xx_pic.c:98: error: static declaration of 'mpc8xx_pic' follows non-static declaration
arch/powerpc/sysdev/mpc8xx_pic.h:7: error: previous declaration of 'mpc8xx_pic' was here

powerpc.mpc885_ads_defconfig:
arch/powerpc/sysdev/mpc8xx_pic.c:98: error: static declaration of 'mpc8xx_pic' follows non-static declaration
arch/powerpc/sysdev/mpc8xx_pic.h:7: error: previous declaration of 'mpc8xx_pic' was here

powerpc.ppc64_defconfig:
drivers/pci/hotplug/rpadlpar_sysfs.c:132: error: unknown field 'subsys' specified in initializer
drivers/pci/hotplug/rpadlpar_sysfs.c:132: warning: initialization from incompatible pointer type

powerpc.pseries_defconfig:
drivers/net/ehea/ehea_main.c: In function 'ehea_hash_skb':
drivers/net/ehea/ehea_main.c:1806: error: 'struct sk_buff' has no member named 'nh'
drivers/net/ehea/ehea_main.c:1807: error: 'struct sk_buff' has no member named 'nh'
drivers/net/ehea/ehea_main.c:1807: error: 'struct sk_buff' has no member named 'nh'
drivers/net/ehea/ehea_main.c:1809: error: 'struct sk_buff' has no member named 'nh'
(I believe a fix for this is already on it's way in through jgarzik)
