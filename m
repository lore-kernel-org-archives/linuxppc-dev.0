Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F3758DE066
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 10:27:36 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n4F0RGh6019641
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 17:27:27 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n4F0RE4V012633
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 19:27:15 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Does U-BOOT (MPC8560) support Micron MT18VDD12872DG
Date: Fri, 15 May 2009 08:27:15 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB120893484DB@zch01exm21.fsl.freescale.net>
In-Reply-To: <20090514070132.M24973@cdotd.ernet.in>
References: <20090514070132.M24973@cdotd.ernet.in>
From: "Liu Dave-R63238" <DaveLiu@freescale.com>
To: "Deepak Gaur" <dgaur@cdotd.ernet.in>, <linuxppc-dev@ozlabs.org>,
	<u-boot@lists.denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I have a custom board similar to MPC8560ADS board with 1GB=20
> DDR SDRAM. The DDR SDRAM Make
> is MT18VDDF12872DG-335D3. In U-BOOT (2009.01) config file I=20
> have enabled CONFIG_SPD_EEPROM
> so U-boot configures MPC8560ADS DDR controller with the=20
> values read from SPD_EEPROM (i2c
> address 0x51)=20
>=20
> After card reset U-BOOT runs from BOOT Flash and debug prints=20
> start coming on SCC1 port
> But after configuring the MPC8560 DDR controller the U-BOOT=20
> HANGS when it tries to run
> from RAM locations after relocation from BOOT Flash.=20
>=20
> Somewhere I read that it is due to failure of Burst Mode=20
> access of RAM. But DDR SDRAM=20
> inherently work in Burst Mode only. Moreover U-BBOT =20
> initialized the DDR SDRAM Mode
> config register using SPD EEPROM values . The value indicate=20
> that SDRAM is in Burst Mode
>=20
> MPC8560 CPU Version is 2.0.2
>=20
> Please help in understanding the issue here
>=20
> The U-BOOT Details are
> --------------------------------------------------------------
> ---------------------------
> U-Boot 2009.01 (Apr 27 2009 - 14:17:09)
>=20
>=20
> CPU:   8560, Version: 2.0, (0x80700020)
> Core:  E500, Version: 2.0, (0x80200020)
> Clock Configuration:
>        CPU:660  MHz, CCB:264  MHz,
>        DDR:132  MHz (264 MT/s data rate), LBC:66   MHz
> CPM:   264 MHz
> L1:    D-cache 32 kB enabled
>        I-cache 32 kB enabled
> Board: ADS
>     PCI1: 32 bit, 33 MHz (compiled)
> I2C:   ready
> DRAM:  Initializing
> SDRAM SPD EEPROM
> starting at step 1 (STEP_GET_SPD)
>=20
>  MEM TYPE 0x7DDR: DDR I rank density =3D 0x20000000
> mclk_ps =3D 7580
> i=3D0, x =3D 0, lowest_tCKmin_found =3D 0
> i=3D1, x =3D 7500, lowest_tCKmin_found =3D 0
> i=3D2, x =3D 6000, lowest_tCKmin_found =3D 7500
> i=3D3, x =3D 5000, lowest_tCKmin_found =3D 7500
> lowest_tCKmin_CL =3D 2
> Computing lowest common DIMM parameters for memctl=3D0
> using mclk_ps =3D 7580
> checking common caslat =3D 3
> CL =3D 3 ok on DIMM 0 at tCK=3D7580 ps with its tCKmin_X_ps of 6000
> checking common caslat =3D 2
> CL =3D 2 ok on DIMM 0 at tCK=3D7580 ps with its=20
> tCKmin_X_minus_1_ps of 7500
> lowest common SPD-defined CAS latency =3D 2
> highest common dereated CAS latency =3D 2
> all DIMMs ECC capable
> Reloading memory controller configuration options for memctl=3D0
> mclk_ps =3D 7580 ps
> FSL Memory ctrl cg register computation
> FSLDDR: cs[0]_bnds =3D 0x0000001f
> FSLDDR: cs[0]_config =3D 0x80010103
> FSLDDR: cs[0]_config_2 =3D 0x00000000
> FSLDDR: cs[1]_bnds =3D 0x0020003f
> FSLDDR: cs[1]_config =3D 0x80010103
> FSLDDR: cs[1]_config_2 =3D 0x00000000
> FSLDDR: timing_cfg_3 =3D 0x00000000
> FSLDDR: timing_cfg_1 =3D 0x36332422
> FSLDDR: timing_cfg_2 =3D 0x00006482
> FSLDDR: ddr_sdram_cfg =3D 0xe2000000
> FSLDDR: ddr_sdram_cfg_2 =3D 0x20401000
> FSLDDR: ddr_sdram_mode =3D 0x00000022
> FSLDDR: ddr_sdram_mode_2 =3D 0x00000000
> FSLDDR: ddr_sdram_interval =3D 0x04060100
> FSLDDR: timing_cfg_4 =3D 0x00000000
> FSLDDR: timing_cfg_5 =3D 0x00000000
>=20
> ...
> ...
> Some stack location related prints=20
> ...
> <hangs> here   <---- checked with emulator its somewhere in=20
> RAM but no prints coming

Have a try change clk_adjust, cpo_override, write_data_delay
in the board/freescale/mpc8560ads/ddr.c for your DIMMs.

Thanks, Dave
