Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CDE9B1007D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Mar 2011 08:08:51 +1100 (EST)
Date: Wed, 2 Mar 2011 21:48:03 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org,
	Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>,
	uclinux-dist-devel@blackfin.uclinux.org, linux-ia64@vger.kernel.org,
	linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Mike Frysinger <vapier@gentoo.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: about MISC_DEVICES not being enabled in many defconfigs
Message-ID: <20110302204803.GI22310@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: kernel@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

while working on an defconfig (arm/mx27) I noticed that just updating
it[1] results in removing CONFIG_EEPROM_AT24=y.  The reason is that
since commit

	v2.6.36-5965-g5f2365d (misc devices: do not enable by default)

MISC_DEVICES isn't enabled anymore by default.  So all defconfigs that
have CONFIG_SOME_SYMBOL=y (or =m) (with SOME_SYMBOL depending on
MISC_DEVICES) but not CONFIG_MISC_DEVICES=y suffer from the same
problem.

As a defconfig that was reduced before 5f2365d obviously didn't have
CONFIG_MISC_DEVICES=y many defconfigs have that problem.

I did the following to (hopefully) find all affected defconfigs:

	$ git describe
	v2.6.38-rc7
	$ git ls-files drivers/misc | grep Kconfig | xargs grep -h ^config | sed 's/config \(.*\)/CONFIG_\1=/' > miscsymbols
	$ git ls-files *defconfig | xargs grep -L CONFIG_MISC_DEVICES= | xargs grep -F -f miscsymbols
	arch/arm/configs/afeb9260_defconfig:CONFIG_ATMEL_SSC=y
	arch/arm/configs/afeb9260_defconfig:CONFIG_EEPROM_AT24=y
	arch/arm/configs/at572d940hfek_defconfig:CONFIG_ATMEL_TCLIB=y
	arch/arm/configs/at572d940hfek_defconfig:CONFIG_ATMEL_SSC=m
	arch/arm/configs/at572d940hfek_defconfig:CONFIG_SENSORS_TSL2550=m
	arch/arm/configs/at572d940hfek_defconfig:CONFIG_DS1682=m
	arch/arm/configs/at91cap9adk_defconfig:CONFIG_ATMEL_SSC=y
	arch/arm/configs/at91rm9200_defconfig:CONFIG_ATMEL_TCLIB=y
	arch/arm/configs/at91rm9200_defconfig:CONFIG_EEPROM_LEGACY=m
	arch/arm/configs/at91sam9260ek_defconfig:CONFIG_ATMEL_SSC=y
	arch/arm/configs/at91sam9261ek_defconfig:CONFIG_ATMEL_SSC=y
	arch/arm/configs/at91sam9263ek_defconfig:CONFIG_ATMEL_SSC=y
	arch/arm/configs/at91sam9g20ek_defconfig:CONFIG_ATMEL_SSC=y
	arch/arm/configs/at91sam9rlek_defconfig:CONFIG_ATMEL_SSC=y
	arch/arm/configs/da8xx_omapl_defconfig:CONFIG_EEPROM_AT24=y
	arch/arm/configs/davinci_all_defconfig:CONFIG_EEPROM_AT24=y
	arch/arm/configs/ep93xx_defconfig:CONFIG_EEPROM_LEGACY=y
	arch/arm/configs/ixp2000_defconfig:CONFIG_EEPROM_LEGACY=y
	arch/arm/configs/ixp23xx_defconfig:CONFIG_EEPROM_LEGACY=y
	arch/arm/configs/ixp4xx_defconfig:CONFIG_EEPROM_LEGACY=y
	arch/arm/configs/mini2440_defconfig:CONFIG_SENSORS_TSL2550=m
	arch/arm/configs/mx27_defconfig:CONFIG_EEPROM_AT24=y
	arch/arm/configs/mx3_defconfig:CONFIG_EEPROM_AT24=y
	arch/arm/configs/neocore926_defconfig:CONFIG_ATMEL_PWM=y
	arch/arm/configs/neocore926_defconfig:CONFIG_ATMEL_TCLIB=y
	arch/arm/configs/omap2plus_defconfig:CONFIG_EEPROM_LEGACY=y
	arch/arm/configs/pcontrol_g20_defconfig:CONFIG_ATMEL_TCLIB=y
	arch/arm/configs/pcontrol_g20_defconfig:CONFIG_EEPROM_AT24=m
	arch/arm/configs/pnx4008_defconfig:CONFIG_EEPROM_LEGACY=m
	arch/arm/configs/raumfeld_defconfig:CONFIG_ISL29003=y
	arch/arm/configs/raumfeld_defconfig:CONFIG_TI_DAC7512=y
	arch/arm/configs/realview-smp_defconfig:CONFIG_ARM_CHARLCD=y
	arch/arm/configs/realview_defconfig:CONFIG_ARM_CHARLCD=y
	arch/arm/configs/s3c2410_defconfig:CONFIG_EEPROM_AT25=m
	arch/arm/configs/s3c2410_defconfig:CONFIG_EEPROM_LEGACY=m
	arch/arm/configs/s3c2410_defconfig:CONFIG_EEPROM_93CX6=m
	arch/arm/configs/s3c6400_defconfig:CONFIG_EEPROM_AT24=y
	arch/arm/configs/s5pc100_defconfig:CONFIG_EEPROM_AT24=y
	arch/arm/configs/versatile_defconfig:CONFIG_EEPROM_LEGACY=m
	arch/arm/configs/zeus_defconfig:CONFIG_EEPROM_AT24=m
	arch/avr32/configs/atngw100_mrmt_defconfig:CONFIG_ATMEL_PWM=y
	arch/avr32/configs/favr-32_defconfig:CONFIG_ATMEL_PWM=m
	arch/avr32/configs/favr-32_defconfig:CONFIG_ATMEL_TCLIB=y
	arch/avr32/configs/favr-32_defconfig:CONFIG_ATMEL_SSC=m
	arch/avr32/configs/hammerhead_defconfig:CONFIG_ATMEL_TCLIB=y
	arch/avr32/configs/merisc_defconfig:CONFIG_ATMEL_PWM=y
	arch/avr32/configs/merisc_defconfig:CONFIG_ATMEL_SSC=y
	arch/avr32/configs/mimc200_defconfig:CONFIG_ATMEL_TCLIB=y
	arch/avr32/configs/mimc200_defconfig:CONFIG_EEPROM_AT24=y
	arch/avr32/configs/mimc200_defconfig:CONFIG_EEPROM_AT25=y
	arch/blackfin/configs/BlackStamp_defconfig:CONFIG_EEPROM_AT25=y
	arch/blackfin/configs/H8606_defconfig:CONFIG_EEPROM_AT25=y
	arch/blackfin/configs/SRV1_defconfig:CONFIG_EEPROM_AT25=m
	arch/ia64/configs/generic_defconfig:CONFIG_SGI_IOC4=y
	arch/ia64/configs/generic_defconfig:CONFIG_SGI_XP=m
	arch/ia64/configs/gensparse_defconfig:CONFIG_SGI_IOC4=y
	arch/mips/configs/bigsur_defconfig:CONFIG_SGI_IOC4=m
	arch/mips/configs/bigsur_defconfig:CONFIG_EEPROM_LEGACY=y
	arch/mips/configs/bigsur_defconfig:CONFIG_EEPROM_MAX6875=y
	arch/mips/configs/gpr_defconfig:CONFIG_TIFM_CORE=m
	arch/mips/configs/ip32_defconfig:CONFIG_SGI_IOC4=y
	arch/mips/configs/markeins_defconfig:CONFIG_SGI_IOC4=m
	arch/mips/configs/pnx8550-jbs_defconfig:CONFIG_SGI_IOC4=m
	arch/mips/configs/rm200_defconfig:CONFIG_SGI_IOC4=m
	arch/mips/configs/sb1250-swarm_defconfig:CONFIG_SGI_IOC4=m
	arch/mips/configs/wrppmc_defconfig:CONFIG_SGI_IOC4=m
	arch/mips/configs/yosemite_defconfig:CONFIG_SGI_IOC4=m
	arch/powerpc/configs/44x/warp_defconfig:CONFIG_EEPROM_AT24=y
	arch/powerpc/configs/52xx/motionpro_defconfig:CONFIG_EEPROM_LEGACY=y
	arch/powerpc/configs/86xx/gef_ppc9a_defconfig:CONFIG_DS1682=y
	arch/powerpc/configs/86xx/gef_sbc310_defconfig:CONFIG_DS1682=y
	arch/powerpc/configs/86xx/gef_sbc610_defconfig:CONFIG_DS1682=y
	arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig:CONFIG_EEPROM_LEGACY=y
	arch/powerpc/configs/e55xx_smp_defconfig:CONFIG_EEPROM_LEGACY=y
	arch/powerpc/configs/linkstation_defconfig:CONFIG_EEPROM_LEGACY=m
	arch/powerpc/configs/mpc512x_defconfig:CONFIG_EEPROM_AT24=y
	arch/powerpc/configs/mpc5200_defconfig:CONFIG_EEPROM_AT24=y
	arch/powerpc/configs/mpc85xx_defconfig:CONFIG_EEPROM_LEGACY=y
	arch/powerpc/configs/mpc85xx_smp_defconfig:CONFIG_EEPROM_LEGACY=y
	arch/powerpc/configs/mpc86xx_defconfig:CONFIG_EEPROM_LEGACY=y
	arch/powerpc/configs/pasemi_defconfig:CONFIG_EEPROM_LEGACY=y
	arch/powerpc/configs/ppc6xx_defconfig:CONFIG_ENCLOSURE_SERVICES=m
	arch/powerpc/configs/ppc6xx_defconfig:CONFIG_SENSORS_TSL2550=m
	arch/powerpc/configs/ppc6xx_defconfig:CONFIG_EEPROM_AT24=m
	arch/powerpc/configs/ppc6xx_defconfig:CONFIG_EEPROM_LEGACY=m
	arch/powerpc/configs/ppc6xx_defconfig:CONFIG_EEPROM_MAX6875=m
	arch/powerpc/configs/ppc6xx_defconfig:CONFIG_EEPROM_93CX6=m
	arch/sh/configs/se7206_defconfig:CONFIG_EEPROM_93CX6=y

(For those wondering about the commands above: A line 

	arch/$arch/configs/xyz_defconfig:CONFIG_SOME_DEVICE=y

means here, that running

	make ARCH=$arch xyz_defconfig

results in a config without SOME_DEVICE.

I don't know if that bothers you, but if it does, you should add

	CONFIG_MISC_DEVICES=y

to your defconfig.

Just to let you know ...

Best regards
Uwe

[1] make mx27_defconfig
    make savedefconfig
    mv defconfig arch/arm/configs/mx27_defconfig

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
