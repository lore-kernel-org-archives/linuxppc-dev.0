Return-Path: <FVoegel@partner.ime-actia.de>
Received: from fw.ime-actia.de (fw.ime-actia.de [217.6.67.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B1032B6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Apr 2011 20:07:55 +1000 (EST)
Subject: Re: Where is CONFIG_BOOT_LOAD ?
From: Florian =?ISO-8859-1?Q?V=F6gel?= <fvoegel@partner.ime-actia.de>
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
In-Reply-To: <201104081128.37906.dargaud@lpsc.in2p3.fr>
References: <201104081128.37906.dargaud@lpsc.in2p3.fr>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 08 Apr 2011 11:42:21 +0200
Message-ID: <1302255741.5359.7.camel@flotop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Fri, 2011-04-08 at 11:28 +0200, Guillaume Dargaud wrote:
> Hello all,
> I don't see this option in the .config and in the menuconfig / Advanced Setup I don't see a [Set the boot link/load 
> address]:
> 
> [*] Prompt for advanced kernel configuration options
> [ ]   Set maximum low memory
> [ ]   Set custom page offset address
> [ ]   Set custom kernel base address
> [ ] Set custom user task size
> [ ] Set custom consistent memory pool size

Isn't that blackfin specific?

linux-next # find -name Kconfig -exec grep -H "BOOT_LOAD" \{\} \;
./arch/blackfin/Kconfig:config BOOT_LOAD

linux-next # find -exec grep -H "CONFIG_BOOT_LOAD" \{\} \;
./arch/blackfin/boot/Makefile:UIMAGE_OPTS-$(CONFIG_RAMKERNEL) += -a
$(CONFIG_BOOT_LOAD)
./arch/blackfin/kernel/vmlinux.lds.S:   . = CONFIG_BOOT_LOAD;
./arch/blackfin/kernel/vmlinux.lds.S:   . = CONFIG_BOOT_LOAD;
./arch/blackfin/kernel/trace.c: } else if (address < CONFIG_BOOT_LOAD) {
./arch/blackfin/kernel/setup.c: _rambase = CONFIG_BOOT_LOAD;
./arch/blackfin/configs/SRV1_defconfig:CONFIG_BOOT_LOAD=0x400000
./arch/blackfin/configs/BF527-TLL6527M_defconfig:CONFIG_BOOT_LOAD=0x400000
./arch/blackfin/mach-common/arch_checks.c:#if CONFIG_BOOT_LOAD <
FIXED_CODE_END
./arch/blackfin/mach-common/arch_checks.c:#if (CONFIG_BOOT_LOAD & 0x3)
./arch/blackfin/mach-common/arch_checks.c:#if ((0xffffffff -
L1_CODE_START + 1) + CONFIG_BOOT_LOAD) > 0x1000000

-Florian
