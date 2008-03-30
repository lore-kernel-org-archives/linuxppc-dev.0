Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound2-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 212FCDDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Mar 2008 03:02:39 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C89287.D6DF51FB"
Subject: RE: Xilinx LLTEMAC driver issues
Date: Sun, 30 Mar 2008 10:02:30 -0700
References: <20080329125416.B09261AD8051@mail119-sin.bigfish.com><20080329135813.B3832DE8062@mail60-sin.bigfish.com>
	<1206802234.5247.19.camel@magnus-desktop>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Magnus Hjorth" <mh@omnisys.se>,
	"John Linn" <linnj@xilinx.com>
Message-Id: <20080330170232.4E9A8170807D@mail190-dub.bigfish.com>
Cc: git <git@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C89287.D6DF51FB
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


I did have trouble with the 1.00 versions of the core,  if you can get =
EDK 10.1 with version 1.01a of the ll_temac core, that's probably worth =
a try.

Steve

-----Original Message-----
From: Magnus Hjorth [mailto:mh@omnisys.se]
Sent: Sat 3/29/2008 7:50 AM
To: John Linn
Cc: git; linuxppc-embedded@ozlabs.org
Subject: RE: Xilinx LLTEMAC driver issues
=20
Hi John,

Thanks for the very fast reply! Right now I'm not at work so I don't
have the board or EDK here to test anything.=20

I'm using checksum offload, but I don't know if DRE is enabled or not. I
can't recall seeing any setting to enable/disable DRE..=20

A few things that crossed my mind:

Last year I did a design with EDK 8.2, back then there was an issue with
the ML403 boards having an old revision of the FPGA which wasn't
compatible with some versions of the IP core. There are no such version
issues with the xps_ll_temac?=20

I don't think that I had phy-addr set in the DTS file. Will test that on
Monday.=20

Best regards,
Magnus


On Sat, 2008-03-29 at 07:58 -0600, John Linn wrote:
> Hi Magnus,
>=20
> Sorry to hear you're having problems with it.
>=20
> I am doing testing on an ML405 which is the same board but with a =
bigger FPGA, but with ppc arch and I don't see this issue. I have done =
limited testing with powerpc arch and the LL TEMAC, but I didn't see =
this issue there either.  Powerpc arch is definitely less mature in my =
experience than the ppc arch. I'll do a quick test with my powerpc arch =
and make sure again I'm not seeing it.
>=20
> My kernel is from the Xilinx Git tree, but there have been a number of =
changes we have pushed out so I don't know how long ago you pulled from =
the Git tree.
>=20
> My EDK project is 10.1 so it's a little newer. I am using LL TEMAC =
1.01a so it's a little newer.  I reviewed the change log for the LL =
TEMAC and don't see any big problems that were fixed in the newer =
versions, more new features.  I'll check with some others here to see if =
I missed something there.
>=20
> I am using DMA also, but no DRE or checksum offload.  You didn't say =
anything about those. I'm going to insert my mhs file that describes my =
system to let you compare your system configuration. It's not clear to =
me yet if you have a h/w or s/w problem. =20
>=20
> I'll also insert some of my device tree with the LL TEMAC so you can =
compare (ignore 16550 stuff as we are still working on that).
>=20
> Since you can't ping reliably I would probably focus on that since =
it's simpler than the other issues you're seeing.
>=20
> Thanks,
> John
>=20
>=20
>=20
> # =
#########################################################################=
#####
> # Created by Base System Builder Wizard for Xilinx EDK 10.1.1 Build =
EDK_K_SP1.1
> # Thu Feb 14 14:11:12 2008
> # Target Board:  Xilinx Virtex 4 ML405 Evaluation Platform Rev 1
> # Family:    virtex4
> # Device:    xc4vfx20
> # Package:   ff672
> # Speed Grade:  -10
> # Processor: ppc405_0
> # Processor clock frequency: 300.00 MHz
> # Bus clock frequency: 100.00 MHz
> # On Chip Memory :   8 KB
> # Total Off Chip Memory : 128 MB
> # - DDR_SDRAM =3D 128 MB
> # =
#########################################################################=
#####
>  PARAMETER VERSION =3D 2.1.0
>=20
>=20
>  PORT fpga_0_RS232_Uart_sin_pin =3D fpga_0_RS232_Uart_sin, DIR =3D I
>  PORT fpga_0_RS232_Uart_sout_pin =3D fpga_0_RS232_Uart_sout, DIR =3D O
>  PORT fpga_0_LEDs_4Bit_GPIO_IO_pin =3D fpga_0_LEDs_4Bit_GPIO_IO, DIR =
=3D IO, VEC =3D [0:3]
>  PORT fpga_0_IIC_EEPROM_Scl_pin =3D fpga_0_IIC_EEPROM_Scl, DIR =3D IO
>  PORT fpga_0_IIC_EEPROM_Sda_pin =3D fpga_0_IIC_EEPROM_Sda, DIR =3D IO
>  PORT fpga_0_SysACE_CompactFlash_SysACE_CLK_pin =3D =
fpga_0_SysACE_CompactFlash_SysACE_CLK, DIR =3D I
>  PORT fpga_0_SysACE_CompactFlash_SysACE_MPA_pin =3D =
fpga_0_SysACE_CompactFlash_SysACE_MPA, DIR =3D O, VEC =3D [6:1]
>  PORT fpga_0_SysACE_CompactFlash_SysACE_MPD_pin =3D =
fpga_0_SysACE_CompactFlash_SysACE_MPD, DIR =3D IO, VEC =3D [15:0]
>  PORT fpga_0_SysACE_CompactFlash_SysACE_CEN_pin =3D =
fpga_0_SysACE_CompactFlash_SysACE_CEN, DIR =3D O
>  PORT fpga_0_SysACE_CompactFlash_SysACE_OEN_pin =3D =
fpga_0_SysACE_CompactFlash_SysACE_OEN, DIR =3D O
>  PORT fpga_0_SysACE_CompactFlash_SysACE_WEN_pin =3D =
fpga_0_SysACE_CompactFlash_SysACE_WEN, DIR =3D O
>  PORT fpga_0_SysACE_CompactFlash_SysACE_MPIRQ_pin =3D =
fpga_0_SysACE_CompactFlash_SysACE_MPIRQ, DIR =3D I
>  PORT fpga_0_DDR_SDRAM_DDR_Clk_pin =3D fpga_0_DDR_SDRAM_DDR_Clk, DIR =
=3D O
>  PORT fpga_0_DDR_SDRAM_DDR_Clk_n_pin =3D fpga_0_DDR_SDRAM_DDR_Clk_n, =
DIR =3D O
>  PORT fpga_0_DDR_SDRAM_DDR_Addr_pin =3D fpga_0_DDR_SDRAM_DDR_Addr, DIR =
=3D O, VEC =3D [12:0]
>  PORT fpga_0_DDR_SDRAM_DDR_BankAddr_pin =3D =
fpga_0_DDR_SDRAM_DDR_BankAddr, DIR =3D O, VEC =3D [1:0]
>  PORT fpga_0_DDR_SDRAM_DDR_CAS_n_pin =3D fpga_0_DDR_SDRAM_DDR_CAS_n, =
DIR =3D O
>  PORT fpga_0_DDR_SDRAM_DDR_CE_pin =3D fpga_0_DDR_SDRAM_DDR_CE, DIR =3D =
O
>  PORT fpga_0_DDR_SDRAM_DDR_CS_n_pin =3D fpga_0_DDR_SDRAM_DDR_CS_n, DIR =
=3D O
>  PORT fpga_0_DDR_SDRAM_DDR_RAS_n_pin =3D fpga_0_DDR_SDRAM_DDR_RAS_n, =
DIR =3D O
>  PORT fpga_0_DDR_SDRAM_DDR_WE_n_pin =3D fpga_0_DDR_SDRAM_DDR_WE_n, DIR =
=3D O
>  PORT fpga_0_DDR_SDRAM_DDR_DM_pin =3D fpga_0_DDR_SDRAM_DDR_DM, DIR =3D =
O, VEC =3D [3:0]
>  PORT fpga_0_DDR_SDRAM_DDR_DQS =3D fpga_0_DDR_SDRAM_DDR_DQS, DIR =3D =
IO, VEC =3D [3:0]
>  PORT fpga_0_DDR_SDRAM_DDR_DQ =3D fpga_0_DDR_SDRAM_DDR_DQ, DIR =3D IO, =
VEC =3D [31:0]
>  PORT fpga_0_TriMode_MAC_GMII_GMII_TXD_0_pin =3D =
fpga_0_TriMode_MAC_GMII_GMII_TXD_0, DIR =3D O, VEC =3D [7:0]
>  PORT fpga_0_TriMode_MAC_GMII_GMII_TX_EN_0_pin =3D =
fpga_0_TriMode_MAC_GMII_GMII_TX_EN_0, DIR =3D O
>  PORT fpga_0_TriMode_MAC_GMII_GMII_TX_ER_0_pin =3D =
fpga_0_TriMode_MAC_GMII_GMII_TX_ER_0, DIR =3D O
>  PORT fpga_0_TriMode_MAC_GMII_GMII_TX_CLK_0_pin =3D =
fpga_0_TriMode_MAC_GMII_GMII_TX_CLK_0, DIR =3D O
>  PORT fpga_0_TriMode_MAC_GMII_GMII_RXD_0_pin =3D =
fpga_0_TriMode_MAC_GMII_GMII_RXD_0, DIR =3D I, VEC =3D [7:0]
>  PORT fpga_0_TriMode_MAC_GMII_GMII_RX_DV_0_pin =3D =
fpga_0_TriMode_MAC_GMII_GMII_RX_DV_0, DIR =3D I
>  PORT fpga_0_TriMode_MAC_GMII_GMII_RX_ER_0_pin =3D =
fpga_0_TriMode_MAC_GMII_GMII_RX_ER_0, DIR =3D I
>  PORT fpga_0_TriMode_MAC_GMII_GMII_RX_CLK_0_pin =3D =
fpga_0_TriMode_MAC_GMII_GMII_RX_CLK_0, DIR =3D I
>  PORT fpga_0_TriMode_MAC_GMII_MII_TX_CLK_0_pin =3D =
fpga_0_TriMode_MAC_GMII_MII_TX_CLK_0, DIR =3D I
>  PORT fpga_0_TriMode_MAC_GMII_MDIO_0_pin =3D =
fpga_0_TriMode_MAC_GMII_MDIO_0, DIR =3D IO
>  PORT fpga_0_TriMode_MAC_GMII_MDC_0_pin =3D =
fpga_0_TriMode_MAC_GMII_MDC_0, DIR =3D O
>  PORT fpga_0_TriMode_MAC_GMII_TemacPhy_RST_n_pin =3D =
fpga_0_TriMode_MAC_GMII_TemacPhy_RST_n, DIR =3D O
>  PORT sys_clk_pin =3D dcm_clk_s, DIR =3D I, SIGIS =3D CLK, CLK_FREQ =
=3D 100000000
>  PORT sys_rst_pin =3D sys_rst_s, DIR =3D I, RST_POLARITY =3D 0, SIGIS =
=3D RST
>=20
>=20
> BEGIN ppc405_virtex4
>  PARAMETER INSTANCE =3D ppc405_0
>  PARAMETER HW_VER =3D 2.01.a
>  PARAMETER C_FASTEST_PLB_CLOCK =3D DPLB1
>  PARAMETER C_IDCR_BASEADDR =3D 0b0100000000
>  PARAMETER C_IDCR_HIGHADDR =3D 0b0111111111
>  BUS_INTERFACE JTAGPPC =3D jtagppc_0_0
>  BUS_INTERFACE IPLB0 =3D plb
>  BUS_INTERFACE DPLB0 =3D plb
>  BUS_INTERFACE IPLB1 =3D ppc405_0_iplb1
>  BUS_INTERFACE DPLB1 =3D ppc405_0_dplb1
>  BUS_INTERFACE RESETPPC =3D ppc_reset_bus
>  PORT CPMC405CLOCK =3D proc_clk_s
>  PORT EICC405EXTINPUTIRQ =3D EICC405EXTINPUTIRQ
> END
>=20
> BEGIN jtagppc_cntlr
>  PARAMETER INSTANCE =3D jtagppc_0
>  PARAMETER HW_VER =3D 2.01.a
>  BUS_INTERFACE JTAGPPC0 =3D jtagppc_0_0
> END
>=20
> BEGIN plb_v46
>  PARAMETER INSTANCE =3D plb
>  PARAMETER C_DCR_INTFCE =3D 0
>  PARAMETER C_NUM_CLK_PLB2OPB_REARB =3D 100
>  PARAMETER HW_VER =3D 1.02.a
>  PORT PLB_Clk =3D sys_clk_s
>  PORT SYS_Rst =3D sys_bus_reset
> END
>=20
> BEGIN xps_bram_if_cntlr
>  PARAMETER INSTANCE =3D xps_bram_if_cntlr_1
>  PARAMETER HW_VER =3D 1.00.a
>  PARAMETER C_SPLB_NATIVE_DWIDTH =3D 64
>  PARAMETER C_BASEADDR =3D 0xffffe000
>  PARAMETER C_HIGHADDR =3D 0xffffffff
>  BUS_INTERFACE SPLB =3D plb
>  BUS_INTERFACE PORTA =3D xps_bram_if_cntlr_1_port
> END
>=20
> BEGIN bram_block
>  PARAMETER INSTANCE =3D plb_bram_if_cntlr_1_bram
>  PARAMETER HW_VER =3D 1.00.a
>  BUS_INTERFACE PORTA =3D xps_bram_if_cntlr_1_port
> END
>=20
> BEGIN xps_uart16550
>  PARAMETER INSTANCE =3D RS232_Uart
>  PARAMETER HW_VER =3D 2.00.a
>  PARAMETER C_IS_A_16550 =3D 1
>  PARAMETER C_BASEADDR =3D 0x83e00000
>  PARAMETER C_HIGHADDR =3D 0x83e0ffff
>  BUS_INTERFACE SPLB =3D plb
>  PORT sin =3D fpga_0_RS232_Uart_sin
>  PORT sout =3D fpga_0_RS232_Uart_sout
>  PORT IP2INTC_Irpt =3D RS232_Uart_IP2INTC_Irpt
> END
>=20
> BEGIN xps_gpio
>  PARAMETER INSTANCE =3D LEDs_4Bit
>  PARAMETER HW_VER =3D 1.00.a
>  PARAMETER C_INTERRUPT_PRESENT =3D 1
>  PARAMETER C_GPIO_WIDTH =3D 4
>  PARAMETER C_IS_DUAL =3D 0
>  PARAMETER C_IS_BIDIR =3D 1
>  PARAMETER C_ALL_INPUTS =3D 0
>  PARAMETER C_BASEADDR =3D 0x81400000
>  PARAMETER C_HIGHADDR =3D 0x8140ffff
>  BUS_INTERFACE SPLB =3D plb
>  PORT GPIO_IO =3D fpga_0_LEDs_4Bit_GPIO_IO
>  PORT IP2INTC_Irpt =3D LEDs_4Bit_IP2INTC_Irpt
> END
>=20
> BEGIN xps_iic
>  PARAMETER INSTANCE =3D IIC_EEPROM
>  PARAMETER HW_VER =3D 2.00.a
>  PARAMETER C_CLK_FREQ =3D 100000000
>  PARAMETER C_IIC_FREQ =3D 100000
>  PARAMETER C_TEN_BIT_ADR =3D 0
>  PARAMETER C_BASEADDR =3D 0x81600000
>  PARAMETER C_HIGHADDR =3D 0x8160ffff
>  BUS_INTERFACE SPLB =3D plb
>  PORT Scl =3D fpga_0_IIC_EEPROM_Scl
>  PORT Sda =3D fpga_0_IIC_EEPROM_Sda
>  PORT IIC2INTC_Irpt =3D IIC_EEPROM_IIC2INTC_Irpt
> END
>=20
> BEGIN xps_sysace
>  PARAMETER INSTANCE =3D SysACE_CompactFlash
>  PARAMETER HW_VER =3D 1.00.a
>  PARAMETER C_MEM_WIDTH =3D 16
>  PARAMETER C_BASEADDR =3D 0x83600000
>  PARAMETER C_HIGHADDR =3D 0x8360ffff
>  BUS_INTERFACE SPLB =3D plb
>  PORT SysACE_CLK =3D fpga_0_SysACE_CompactFlash_SysACE_CLK
>  PORT SysACE_MPA =3D fpga_0_SysACE_CompactFlash_SysACE_MPA_split
>  PORT SysACE_MPD =3D fpga_0_SysACE_CompactFlash_SysACE_MPD
>  PORT SysACE_CEN =3D fpga_0_SysACE_CompactFlash_SysACE_CEN
>  PORT SysACE_OEN =3D fpga_0_SysACE_CompactFlash_SysACE_OEN
>  PORT SysACE_WEN =3D fpga_0_SysACE_CompactFlash_SysACE_WEN
>  PORT SysACE_MPIRQ =3D fpga_0_SysACE_CompactFlash_SysACE_MPIRQ
>  PORT SysACE_IRQ =3D SysACE_CompactFlash_SysACE_IRQ
> END
>=20
> BEGIN mpmc
>  PARAMETER INSTANCE =3D DDR_SDRAM
>  PARAMETER HW_VER =3D 4.00.a
>  PARAMETER C_NUM_PORTS =3D 3
>  PARAMETER C_MEM_PARTNO =3D HYB25D512160BE-5
>  PARAMETER C_MEM_DATA_WIDTH =3D 32
>  PARAMETER C_MEM_DQS_WIDTH =3D 4
>  PARAMETER C_MEM_DM_WIDTH =3D 4
>  PARAMETER C_MEM_TYPE =3D DDR
>  PARAMETER C_NUM_IDELAYCTRL =3D 2
>  PARAMETER C_IDELAYCTRL_LOC =3D IDELAYCTRL_X0Y3-IDELAYCTRL_X0Y2
>  PARAMETER C_PIM0_BASETYPE =3D 2
>  PARAMETER C_PIM1_BASETYPE =3D 2
>  PARAMETER C_PIM2_BASETYPE =3D 3
>  PARAMETER C_MPMC_CLK0_PERIOD_PS =3D 10000
>  PARAMETER C_SDMA2_PI2LL_CLK_RATIO =3D 1
>  PARAMETER C_MPMC_BASEADDR =3D 0x00000000
>  PARAMETER C_MPMC_HIGHADDR =3D 0x07ffffff
>  PARAMETER C_SDMA_CTRL_BASEADDR =3D 0x84600000
>  PARAMETER C_SDMA_CTRL_HIGHADDR =3D 0x8460ffff
>  BUS_INTERFACE SPLB0 =3D ppc405_0_iplb1
>  BUS_INTERFACE SPLB1 =3D ppc405_0_dplb1
>  BUS_INTERFACE SDMA_LL2 =3D TriMode_MAC_GMII_LLINK0
>  BUS_INTERFACE SDMA_CTRL2 =3D plb
>  PORT DDR_Addr =3D fpga_0_DDR_SDRAM_DDR_Addr
>  PORT DDR_BankAddr =3D fpga_0_DDR_SDRAM_DDR_BankAddr
>  PORT DDR_CAS_n =3D fpga_0_DDR_SDRAM_DDR_CAS_n
>  PORT DDR_CE =3D fpga_0_DDR_SDRAM_DDR_CE
>  PORT DDR_CS_n =3D fpga_0_DDR_SDRAM_DDR_CS_n
>  PORT DDR_RAS_n =3D fpga_0_DDR_SDRAM_DDR_RAS_n
>  PORT DDR_WE_n =3D fpga_0_DDR_SDRAM_DDR_WE_n
>  PORT DDR_DM =3D fpga_0_DDR_SDRAM_DDR_DM
>  PORT DDR_DQS =3D fpga_0_DDR_SDRAM_DDR_DQS
>  PORT DDR_DQ =3D fpga_0_DDR_SDRAM_DDR_DQ
>  PORT DDR_Clk =3D fpga_0_DDR_SDRAM_DDR_Clk
>  PORT DDR_Clk_n =3D fpga_0_DDR_SDRAM_DDR_Clk_n
>  PORT MPMC_Clk0 =3D sys_clk_s
>  PORT MPMC_Clk90 =3D DDR_SDRAM_mpmc_clk_90_s
>  PORT SDMA2_Clk =3D sys_clk_s
>  PORT MPMC_Clk_200MHz =3D clk_200mhz_s
>  PORT MPMC_Rst =3D sys_periph_reset
>  PORT SDMA2_Rx_IntOut =3D DDR_SDRAM_SDMA2_Rx_IntOut
>  PORT SDMA2_Tx_IntOut =3D DDR_SDRAM_SDMA2_Tx_IntOut
> END
>=20
> BEGIN xps_ll_temac
>  PARAMETER INSTANCE =3D TriMode_MAC_GMII
>  PARAMETER HW_VER =3D 1.01.a
>  PARAMETER C_SPLB_CLK_PERIOD_PS =3D 10000
>  PARAMETER C_PHY_TYPE =3D 1
>  PARAMETER C_NUM_IDELAYCTRL =3D 4
>  PARAMETER C_IDELAYCTRL_LOC =3D =
IDELAYCTRL_X1Y1-IDELAYCTRL_X1Y3-IDELAYCTRL_X2Y2-IDELAYCTRL_X2Y3
>  PARAMETER C_TEMAC_TYPE =3D 1
>  PARAMETER C_BUS2CORE_CLK_RATIO =3D 1
>  PARAMETER C_BASEADDR =3D 0x81c00000
>  PARAMETER C_HIGHADDR =3D 0x81c0ffff
>  BUS_INTERFACE SPLB =3D plb
>  BUS_INTERFACE LLINK0 =3D TriMode_MAC_GMII_LLINK0
>  PORT GMII_TXD_0 =3D fpga_0_TriMode_MAC_GMII_GMII_TXD_0
>  PORT GMII_TX_EN_0 =3D fpga_0_TriMode_MAC_GMII_GMII_TX_EN_0
>  PORT GMII_TX_ER_0 =3D fpga_0_TriMode_MAC_GMII_GMII_TX_ER_0
>  PORT GMII_TX_CLK_0 =3D fpga_0_TriMode_MAC_GMII_GMII_TX_CLK_0
>  PORT GMII_RXD_0 =3D fpga_0_TriMode_MAC_GMII_GMII_RXD_0
>  PORT GMII_RX_DV_0 =3D fpga_0_TriMode_MAC_GMII_GMII_RX_DV_0
>  PORT GMII_RX_ER_0 =3D fpga_0_TriMode_MAC_GMII_GMII_RX_ER_0
>  PORT GMII_RX_CLK_0 =3D fpga_0_TriMode_MAC_GMII_GMII_RX_CLK_0
>  PORT MII_TX_CLK_0 =3D fpga_0_TriMode_MAC_GMII_MII_TX_CLK_0
>  PORT MDIO_0 =3D fpga_0_TriMode_MAC_GMII_MDIO_0
>  PORT MDC_0 =3D fpga_0_TriMode_MAC_GMII_MDC_0
>  PORT TemacPhy_RST_n =3D fpga_0_TriMode_MAC_GMII_TemacPhy_RST_n
>  PORT GTX_CLK_0 =3D temac_clk_s
>  PORT REFCLK =3D clk_200mhz_s
>  PORT LlinkTemac0_CLK =3D sys_clk_s
>  PORT TemacIntc0_Irpt =3D TriMode_MAC_GMII_TemacIntc0_Irpt
> END
>=20
> BEGIN util_bus_split
>  PARAMETER INSTANCE =3D SysACE_CompactFlash_util_bus_split_0
>  PARAMETER HW_VER =3D 1.00.a
>  PARAMETER C_SIZE_IN =3D 7
>  PARAMETER C_LEFT_POS =3D 0
>  PARAMETER C_SPLIT =3D 6
>  PORT Sig =3D fpga_0_SysACE_CompactFlash_SysACE_MPA_split
>  PORT Out1 =3D fpga_0_SysACE_CompactFlash_SysACE_MPA
> END
>=20
> BEGIN plb_v46
>  PARAMETER INSTANCE =3D ppc405_0_iplb1
>  PARAMETER HW_VER =3D 1.02.a
>  PORT PLB_Clk =3D sys_clk_s
>  PORT SYS_Rst =3D sys_bus_reset
> END
>=20
> BEGIN plb_v46
>  PARAMETER INSTANCE =3D ppc405_0_dplb1
>  PARAMETER HW_VER =3D 1.02.a
>  PORT PLB_Clk =3D sys_clk_s
>  PORT SYS_Rst =3D sys_bus_reset
> END
>=20
> BEGIN clock_generator
>  PARAMETER INSTANCE =3D clock_generator_0
>  PARAMETER HW_VER =3D 2.00.a
>  PARAMETER C_EXT_RESET_HIGH =3D 1
>  PARAMETER C_CLKIN_FREQ =3D 100000000
>  PARAMETER C_CLKOUT0_FREQ =3D 100000000
>  PARAMETER C_CLKOUT0_BUF =3D TRUE
>  PARAMETER C_CLKOUT0_PHASE =3D 0
>  PARAMETER C_CLKOUT0_GROUP =3D DCM0
>  PARAMETER C_CLKOUT1_FREQ =3D 100000000
>  PARAMETER C_CLKOUT1_BUF =3D TRUE
>  PARAMETER C_CLKOUT1_PHASE =3D 90
>  PARAMETER C_CLKOUT1_GROUP =3D DCM0
>  PARAMETER C_CLKOUT2_FREQ =3D 300000000
>  PARAMETER C_CLKOUT2_BUF =3D TRUE
>  PARAMETER C_CLKOUT2_PHASE =3D 0
>  PARAMETER C_CLKOUT2_GROUP =3D DCM0
>  PARAMETER C_CLKOUT3_FREQ =3D 200000000
>  PARAMETER C_CLKOUT3_BUF =3D TRUE
>  PARAMETER C_CLKOUT3_PHASE =3D 0
>  PARAMETER C_CLKOUT3_GROUP =3D NONE
>  PARAMETER C_CLKOUT4_FREQ =3D 125000000
>  PARAMETER C_CLKOUT4_BUF =3D TRUE
>  PARAMETER C_CLKOUT4_PHASE =3D 0
>  PARAMETER C_CLKOUT4_GROUP =3D NONE
>  PORT CLKOUT0 =3D sys_clk_s
>  PORT CLKOUT1 =3D DDR_SDRAM_mpmc_clk_90_s
>  PORT CLKOUT2 =3D proc_clk_s
>  PORT CLKOUT3 =3D clk_200mhz_s
>  PORT CLKOUT4 =3D temac_clk_s
>  PORT CLKIN =3D dcm_clk_s
>  PORT LOCKED =3D Dcm_all_locked
>  PORT RST =3D net_gnd
> END
>=20
> BEGIN proc_sys_reset
>  PARAMETER INSTANCE =3D proc_sys_reset_0
>  PARAMETER HW_VER =3D 2.00.a
>  PARAMETER C_EXT_RESET_HIGH =3D 0
>  BUS_INTERFACE RESETPPC0 =3D ppc_reset_bus
>  PORT Slowest_sync_clk =3D sys_clk_s
>  PORT Dcm_locked =3D Dcm_all_locked
>  PORT Ext_Reset_In =3D sys_rst_s
>  PORT Bus_Struct_Reset =3D sys_bus_reset
>  PORT Peripheral_Reset =3D sys_periph_reset
> END
>=20
> BEGIN xps_intc
>  PARAMETER INSTANCE =3D xps_intc_0
>  PARAMETER HW_VER =3D 1.00.a
>  PARAMETER C_BASEADDR =3D 0x81800000
>  PARAMETER C_HIGHADDR =3D 0x8180ffff
>  BUS_INTERFACE SPLB =3D plb
>  PORT Irq =3D EICC405EXTINPUTIRQ
>  PORT Intr =3D RS232_Uart_IP2INTC_Irpt & LEDs_4Bit_IP2INTC_Irpt & =
IIC_EEPROM_IIC2INTC_Irpt & SysACE_CompactFlash_SysACE_IRQ & =
TriMode_MAC_GMII_TemacIntc0_Irpt & DDR_SDRAM_SDMA2_Rx_IntOut & =
DDR_SDRAM_SDMA2_Tx_IntOut
> END
>=20
>=20
>=20
> 	#address-cells =3D <1>;
> 	#size-cells =3D <1>;
> 	compatible =3D "xlnx,virtex";
> 	model =3D "testing";
> 	DDR_SDRAM: memory@0 {
> 		device_type =3D "memory";
> 		reg =3D < 0 8000000 >;
> 	} ;
> 	chosen {
> 		bootargs =3D "console=3DttyS0,9600 ip=3Don =
nfsroot=3D172.16.40.76:/v2pclients/jhl26,tcp";=20
> 		linux,stdout-path =3D "/plb@0/serial@83e00000";
> 	} ;
> 	cpus {
> 		#address-cells =3D <1>;
> 		#cpus =3D <1>;
> 		#size-cells =3D <0>;
> 		ppc405_0: cpu@0 {
> 			clock-frequency =3D <11e1a300>;
> 			compatible =3D "PowerPC,405", "ibm,ppc405";
> 			d-cache-line-size =3D <20>;
> 			d-cache-size =3D <4000>;
> 			device_type =3D "cpu";
> 			i-cache-line-size =3D <20>;
> 			i-cache-size =3D <4000>;
> 			model =3D "PowerPC,405";
> 			reg =3D <0>;
> 			timebase-frequency =3D <11e1a300>;
> 			xlnx,apu-control =3D <de00>;
> 			xlnx,apu-udi-1 =3D <a18983>;
> 			xlnx,apu-udi-2 =3D <a38983>;
> 			xlnx,apu-udi-3 =3D <a589c3>;
> 			xlnx,apu-udi-4 =3D <a789c3>;
> 			xlnx,apu-udi-5 =3D <a98c03>;
> 			xlnx,apu-udi-6 =3D <ab8c03>;
> 			xlnx,apu-udi-7 =3D <ad8c43>;
> 			xlnx,apu-udi-8 =3D <af8c43>;
> 			xlnx,deterministic-mult =3D <0>;
> 			xlnx,disable-operand-forwarding =3D <1>;
> 			xlnx,fastest-plb-clock =3D "DPLB0";
> 			xlnx,generate-plb-timespecs =3D <1>;
> 			xlnx,mmu-enable =3D <1>;
> 			xlnx,pvr-high =3D <0>;
> 			xlnx,pvr-low =3D <0>;
> 		} ;
> 	} ;
> 	plb: plb@0 {
> 		#address-cells =3D <1>;
> 		#size-cells =3D <1>;
> 		compatible =3D "xlnx,plb-v46-1.02.a";
> 		ranges ;
> 		IIC_EEPROM: i2c@81600000 {
> 			compatible =3D "xlnx,xps-iic-2.00.a";
> 			interrupt-parent =3D <&xps_intc_0>;
> 			interrupts =3D < 4 2 >;
> 			reg =3D < 81600000 10000 >;
> 			xlnx,clk-freq =3D <5f5e100>;
> 			xlnx,family =3D "virtex4";
> 			xlnx,gpo-width =3D <1>;
> 			xlnx,iic-freq =3D <186a0>;
> 			xlnx,scl-inertial-delay =3D <0>;
> 			xlnx,sda-inertial-delay =3D <0>;
> 			xlnx,ten-bit-adr =3D <0>;
> 		} ;
> 		LEDs_4Bit: gpio@81400000 {
> 			compatible =3D "xlnx,xps-gpio-1.00.a";
> 			interrupt-parent =3D <&xps_intc_0>;
> 			interrupts =3D < 5 2 >;
> 			reg =3D < 81400000 10000 >;
> 			xlnx,all-inputs =3D <0>;
> 			xlnx,all-inputs-2 =3D <0>;
> 			xlnx,dout-default =3D <0>;
> 			xlnx,dout-default-2 =3D <0>;
> 			xlnx,family =3D "virtex4";
> 			xlnx,gpio-width =3D <4>;
> 			xlnx,interrupt-present =3D <1>;
> 			xlnx,is-bidir =3D <1>;
> 			xlnx,is-bidir-2 =3D <1>;
> 			xlnx,is-dual =3D <0>;
> 			xlnx,tri-default =3D <ffffffff>;
> 			xlnx,tri-default-2 =3D <ffffffff>;
> 		} ;
> 		RS232_Uart: serial@83e00000 {
> 			compatible =3D "xlnx,xps-uart16550-2.00.a";
> //			compatible =3D "ns16550";=20
> 			device_type =3D "serial";
> 			interrupt-parent =3D <&xps_intc_0>;=20
> 			interrupts =3D < 6 2 >;=20
> 			reg =3D < 83e00000 10000 >;
> 			current-speed =3D <d#9600>;
> 			clock-frequency =3D <d#100000000>;  /* added by jhl */
> 			reg-shift =3D <2>;
> 			xlnx,family =3D "virtex4";
> 			xlnx,has-external-rclk =3D <0>;
> 			xlnx,has-external-xin =3D <0>;
> 			xlnx,is-a-16550 =3D <1>;
> 		} ;
> 		SysACE_CompactFlash: sysace@83600000 {
> 			compatible =3D "xlnx,xps-sysace-1.00.a";
> 			interrupt-parent =3D <&xps_intc_0>;
> 			interrupts =3D < 3 2 >;
> 			reg =3D < 83600000 10000 >;
> 			xlnx,family =3D "virtex4";
> 			xlnx,mem-width =3D <10>;
> 		} ;
> 		TriMode_MAC_GMII: xps-ll-temac@81c00000 {
> 			#address-cells =3D <1>;
> 			#size-cells =3D <1>;
> 			compatible =3D "xlnx,compound";
> 			ethernet@81c00000 {
> 				compatible =3D "xlnx,xps-ll-temac-1.01.a";
> 				device_type =3D "network";
> 				interrupt-parent =3D <&xps_intc_0>;
> 				interrupts =3D < 2 2 >;
> 				llink-connected =3D <&PIM2>;
> 				local-mac-address =3D [ 02 00 00 00 00 01 ];
> 				reg =3D < 81c00000 40 >;
> 				xlnx,bus2core-clk-ratio =3D <1>;
> 				xlnx,phy-type =3D <1>;
> 				xlnx,phyaddr =3D <1>;
> 				xlnx,rxcsum =3D <0>;
> 				xlnx,rxfifo =3D <1000>;
> 				xlnx,temac-type =3D <1>;
> 				xlnx,txcsum =3D <0>;
> 				xlnx,txfifo =3D <1000>;
> 			} ;
> 		} ;
> 		mpmc@0 {
> 			#address-cells =3D <1>;
> 			#size-cells =3D <1>;
> 			compatible =3D "xlnx,mpmc-4.00.a";
> 			PIM2: sdma@84600100 {
> 				compatible =3D "xlnx,ll-dma-1.00.a";
> 				interrupt-parent =3D <&xps_intc_0>;
> 				interrupts =3D < 1 2 0 2 >;
> 				reg =3D < 84600100 80 >;
> 			} ;
> 		} ;
> 		xps_bram_if_cntlr_1: xps-bram-if-cntlr@ffffe000 {
> 			compatible =3D "xlnx,xps-bram-if-cntlr-1.00.a";
> 			reg =3D < ffffe000 2000 >;
> 			xlnx,family =3D "virtex4";
> 		} ;
> 		xps_intc_0: interrupt-controller@81800000 {
> 			#interrupt-cells =3D <2>;
> 			compatible =3D "xlnx,xps-intc-1.00.a";
> 			interrupt-controller ;
> 			reg =3D < 81800000 10000 >;
> 			xlnx,num-intr-inputs =3D <7>;
> 		} ;
> 	} ;
> 	ppc405_0_dplb1: plb@1 {
> 		#address-cells =3D <1>;
> 		#size-cells =3D <1>;
> 		compatible =3D "xlnx,plb-v46-1.02.a";
> 		ranges ;
> 	} ;
> }  ;
>=20
>=20
>=20
> -----Original Message-----
> From: Magnus Hjorth [mailto:mh@omnisys.se]=20
> Sent: Saturday, March 29, 2008 6:54 AM
> To: git
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Xilinx LLTEMAC driver issues
>=20
> Hi,
>=20
> I'm having some networking troubles with the Xilinx LLTEMAC driver =
from the
> Xilinx Linux git tree (powerpc arch) on an ML403 board. EDK9.2SP2,
> xps_ll_temac v1.00.b=20
>=20
> The weird thing is, that it sort of half works. It successfully makes =
a DHCP
> request and gets its IP address. I tried setting up a tftpd server, =
and I can
> see UDP requests coming in but the response doesn't seem to come out. =
I also
> tried running a TCP server on the board, and it can see and accept =
incoming
> connections but after that no data seems to get through. I can ping =
out and
> get around 40% packet loss.
>=20
> Looking at /proc/interrupts, I can see both TxDma interrupts and RxDma
> interrupts. No eth0 interrupts but that seems to be OK judging by the =
driver
> source comments. Ifconfig shows no collistions, no dropped packets, no =
errors,
> so the system seems to think that everything is OK.=20
>=20
> Clues anyone? I'm starting to run out of ideas...
>=20
> Best regards,
> Magnus
>=20
>=20
> --
>=20
> Magnus Hjorth, M.Sc.
> Omnisys Instruments AB
> Gruvgatan 8
> SE-421 30  V=E4stra Fr=F6lunda, SWEDEN
> Phone: +46 31 734 34 09
> Fax: +46 31 734 34 29
> http://www.omnisys.se




------_=_NextPart_001_01C89287.D6DF51FB
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DISO-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>RE: Xilinx LLTEMAC driver issues</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>I did have trouble with the 1.00 versions of the =
core,&nbsp; if you can get EDK 10.1 with version 1.01a of the ll_temac =
core, that's probably worth a try.<BR>
<BR>
Steve<BR>
<BR>
-----Original Message-----<BR>
From: Magnus Hjorth [<A =
HREF=3D"mailto:mh@omnisys.se">mailto:mh@omnisys.se</A>]<BR>
Sent: Sat 3/29/2008 7:50 AM<BR>
To: John Linn<BR>
Cc: git; linuxppc-embedded@ozlabs.org<BR>
Subject: RE: Xilinx LLTEMAC driver issues<BR>
<BR>
Hi John,<BR>
<BR>
Thanks for the very fast reply! Right now I'm not at work so I don't<BR>
have the board or EDK here to test anything.<BR>
<BR>
I'm using checksum offload, but I don't know if DRE is enabled or not. =
I<BR>
can't recall seeing any setting to enable/disable DRE..<BR>
<BR>
A few things that crossed my mind:<BR>
<BR>
Last year I did a design with EDK 8.2, back then there was an issue =
with<BR>
the ML403 boards having an old revision of the FPGA which wasn't<BR>
compatible with some versions of the IP core. There are no such =
version<BR>
issues with the xps_ll_temac?<BR>
<BR>
I don't think that I had phy-addr set in the DTS file. Will test that =
on<BR>
Monday.<BR>
<BR>
Best regards,<BR>
Magnus<BR>
<BR>
<BR>
On Sat, 2008-03-29 at 07:58 -0600, John Linn wrote:<BR>
&gt; Hi Magnus,<BR>
&gt;<BR>
&gt; Sorry to hear you're having problems with it.<BR>
&gt;<BR>
&gt; I am doing testing on an ML405 which is the same board but with a =
bigger FPGA, but with ppc arch and I don't see this issue. I have done =
limited testing with powerpc arch and the LL TEMAC, but I didn't see =
this issue there either.&nbsp; Powerpc arch is definitely less mature in =
my experience than the ppc arch. I'll do a quick test with my powerpc =
arch and make sure again I'm not seeing it.<BR>
&gt;<BR>
&gt; My kernel is from the Xilinx Git tree, but there have been a number =
of changes we have pushed out so I don't know how long ago you pulled =
from the Git tree.<BR>
&gt;<BR>
&gt; My EDK project is 10.1 so it's a little newer. I am using LL TEMAC =
1.01a so it's a little newer.&nbsp; I reviewed the change log for the LL =
TEMAC and don't see any big problems that were fixed in the newer =
versions, more new features.&nbsp; I'll check with some others here to =
see if I missed something there.<BR>
&gt;<BR>
&gt; I am using DMA also, but no DRE or checksum offload.&nbsp; You =
didn't say anything about those. I'm going to insert my mhs file that =
describes my system to let you compare your system configuration. It's =
not clear to me yet if you have a h/w or s/w problem.&nbsp;<BR>
&gt;<BR>
&gt; I'll also insert some of my device tree with the LL TEMAC so you =
can compare (ignore 16550 stuff as we are still working on that).<BR>
&gt;<BR>
&gt; Since you can't ping reliably I would probably focus on that since =
it's simpler than the other issues you're seeing.<BR>
&gt;<BR>
&gt; Thanks,<BR>
&gt; John<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt; # =
#########################################################################=
#####<BR>
&gt; # Created by Base System Builder Wizard for Xilinx EDK 10.1.1 Build =
EDK_K_SP1.1<BR>
&gt; # Thu Feb 14 14:11:12 2008<BR>
&gt; # Target Board:&nbsp; Xilinx Virtex 4 ML405 Evaluation Platform Rev =
1<BR>
&gt; # Family:&nbsp;&nbsp;&nbsp; virtex4<BR>
&gt; # Device:&nbsp;&nbsp;&nbsp; xc4vfx20<BR>
&gt; # Package:&nbsp;&nbsp; ff672<BR>
&gt; # Speed Grade:&nbsp; -10<BR>
&gt; # Processor: ppc405_0<BR>
&gt; # Processor clock frequency: 300.00 MHz<BR>
&gt; # Bus clock frequency: 100.00 MHz<BR>
&gt; # On Chip Memory :&nbsp;&nbsp; 8 KB<BR>
&gt; # Total Off Chip Memory : 128 MB<BR>
&gt; # - DDR_SDRAM =3D 128 MB<BR>
&gt; # =
#########################################################################=
#####<BR>
&gt;&nbsp; PARAMETER VERSION =3D 2.1.0<BR>
&gt;<BR>
&gt;<BR>
&gt;&nbsp; PORT fpga_0_RS232_Uart_sin_pin =3D fpga_0_RS232_Uart_sin, DIR =
=3D I<BR>
&gt;&nbsp; PORT fpga_0_RS232_Uart_sout_pin =3D fpga_0_RS232_Uart_sout, =
DIR =3D O<BR>
&gt;&nbsp; PORT fpga_0_LEDs_4Bit_GPIO_IO_pin =3D =
fpga_0_LEDs_4Bit_GPIO_IO, DIR =3D IO, VEC =3D [0:3]<BR>
&gt;&nbsp; PORT fpga_0_IIC_EEPROM_Scl_pin =3D fpga_0_IIC_EEPROM_Scl, DIR =
=3D IO<BR>
&gt;&nbsp; PORT fpga_0_IIC_EEPROM_Sda_pin =3D fpga_0_IIC_EEPROM_Sda, DIR =
=3D IO<BR>
&gt;&nbsp; PORT fpga_0_SysACE_CompactFlash_SysACE_CLK_pin =3D =
fpga_0_SysACE_CompactFlash_SysACE_CLK, DIR =3D I<BR>
&gt;&nbsp; PORT fpga_0_SysACE_CompactFlash_SysACE_MPA_pin =3D =
fpga_0_SysACE_CompactFlash_SysACE_MPA, DIR =3D O, VEC =3D [6:1]<BR>
&gt;&nbsp; PORT fpga_0_SysACE_CompactFlash_SysACE_MPD_pin =3D =
fpga_0_SysACE_CompactFlash_SysACE_MPD, DIR =3D IO, VEC =3D [15:0]<BR>
&gt;&nbsp; PORT fpga_0_SysACE_CompactFlash_SysACE_CEN_pin =3D =
fpga_0_SysACE_CompactFlash_SysACE_CEN, DIR =3D O<BR>
&gt;&nbsp; PORT fpga_0_SysACE_CompactFlash_SysACE_OEN_pin =3D =
fpga_0_SysACE_CompactFlash_SysACE_OEN, DIR =3D O<BR>
&gt;&nbsp; PORT fpga_0_SysACE_CompactFlash_SysACE_WEN_pin =3D =
fpga_0_SysACE_CompactFlash_SysACE_WEN, DIR =3D O<BR>
&gt;&nbsp; PORT fpga_0_SysACE_CompactFlash_SysACE_MPIRQ_pin =3D =
fpga_0_SysACE_CompactFlash_SysACE_MPIRQ, DIR =3D I<BR>
&gt;&nbsp; PORT fpga_0_DDR_SDRAM_DDR_Clk_pin =3D =
fpga_0_DDR_SDRAM_DDR_Clk, DIR =3D O<BR>
&gt;&nbsp; PORT fpga_0_DDR_SDRAM_DDR_Clk_n_pin =3D =
fpga_0_DDR_SDRAM_DDR_Clk_n, DIR =3D O<BR>
&gt;&nbsp; PORT fpga_0_DDR_SDRAM_DDR_Addr_pin =3D =
fpga_0_DDR_SDRAM_DDR_Addr, DIR =3D O, VEC =3D [12:0]<BR>
&gt;&nbsp; PORT fpga_0_DDR_SDRAM_DDR_BankAddr_pin =3D =
fpga_0_DDR_SDRAM_DDR_BankAddr, DIR =3D O, VEC =3D [1:0]<BR>
&gt;&nbsp; PORT fpga_0_DDR_SDRAM_DDR_CAS_n_pin =3D =
fpga_0_DDR_SDRAM_DDR_CAS_n, DIR =3D O<BR>
&gt;&nbsp; PORT fpga_0_DDR_SDRAM_DDR_CE_pin =3D fpga_0_DDR_SDRAM_DDR_CE, =
DIR =3D O<BR>
&gt;&nbsp; PORT fpga_0_DDR_SDRAM_DDR_CS_n_pin =3D =
fpga_0_DDR_SDRAM_DDR_CS_n, DIR =3D O<BR>
&gt;&nbsp; PORT fpga_0_DDR_SDRAM_DDR_RAS_n_pin =3D =
fpga_0_DDR_SDRAM_DDR_RAS_n, DIR =3D O<BR>
&gt;&nbsp; PORT fpga_0_DDR_SDRAM_DDR_WE_n_pin =3D =
fpga_0_DDR_SDRAM_DDR_WE_n, DIR =3D O<BR>
&gt;&nbsp; PORT fpga_0_DDR_SDRAM_DDR_DM_pin =3D fpga_0_DDR_SDRAM_DDR_DM, =
DIR =3D O, VEC =3D [3:0]<BR>
&gt;&nbsp; PORT fpga_0_DDR_SDRAM_DDR_DQS =3D fpga_0_DDR_SDRAM_DDR_DQS, =
DIR =3D IO, VEC =3D [3:0]<BR>
&gt;&nbsp; PORT fpga_0_DDR_SDRAM_DDR_DQ =3D fpga_0_DDR_SDRAM_DDR_DQ, DIR =
=3D IO, VEC =3D [31:0]<BR>
&gt;&nbsp; PORT fpga_0_TriMode_MAC_GMII_GMII_TXD_0_pin =3D =
fpga_0_TriMode_MAC_GMII_GMII_TXD_0, DIR =3D O, VEC =3D [7:0]<BR>
&gt;&nbsp; PORT fpga_0_TriMode_MAC_GMII_GMII_TX_EN_0_pin =3D =
fpga_0_TriMode_MAC_GMII_GMII_TX_EN_0, DIR =3D O<BR>
&gt;&nbsp; PORT fpga_0_TriMode_MAC_GMII_GMII_TX_ER_0_pin =3D =
fpga_0_TriMode_MAC_GMII_GMII_TX_ER_0, DIR =3D O<BR>
&gt;&nbsp; PORT fpga_0_TriMode_MAC_GMII_GMII_TX_CLK_0_pin =3D =
fpga_0_TriMode_MAC_GMII_GMII_TX_CLK_0, DIR =3D O<BR>
&gt;&nbsp; PORT fpga_0_TriMode_MAC_GMII_GMII_RXD_0_pin =3D =
fpga_0_TriMode_MAC_GMII_GMII_RXD_0, DIR =3D I, VEC =3D [7:0]<BR>
&gt;&nbsp; PORT fpga_0_TriMode_MAC_GMII_GMII_RX_DV_0_pin =3D =
fpga_0_TriMode_MAC_GMII_GMII_RX_DV_0, DIR =3D I<BR>
&gt;&nbsp; PORT fpga_0_TriMode_MAC_GMII_GMII_RX_ER_0_pin =3D =
fpga_0_TriMode_MAC_GMII_GMII_RX_ER_0, DIR =3D I<BR>
&gt;&nbsp; PORT fpga_0_TriMode_MAC_GMII_GMII_RX_CLK_0_pin =3D =
fpga_0_TriMode_MAC_GMII_GMII_RX_CLK_0, DIR =3D I<BR>
&gt;&nbsp; PORT fpga_0_TriMode_MAC_GMII_MII_TX_CLK_0_pin =3D =
fpga_0_TriMode_MAC_GMII_MII_TX_CLK_0, DIR =3D I<BR>
&gt;&nbsp; PORT fpga_0_TriMode_MAC_GMII_MDIO_0_pin =3D =
fpga_0_TriMode_MAC_GMII_MDIO_0, DIR =3D IO<BR>
&gt;&nbsp; PORT fpga_0_TriMode_MAC_GMII_MDC_0_pin =3D =
fpga_0_TriMode_MAC_GMII_MDC_0, DIR =3D O<BR>
&gt;&nbsp; PORT fpga_0_TriMode_MAC_GMII_TemacPhy_RST_n_pin =3D =
fpga_0_TriMode_MAC_GMII_TemacPhy_RST_n, DIR =3D O<BR>
&gt;&nbsp; PORT sys_clk_pin =3D dcm_clk_s, DIR =3D I, SIGIS =3D CLK, =
CLK_FREQ =3D 100000000<BR>
&gt;&nbsp; PORT sys_rst_pin =3D sys_rst_s, DIR =3D I, RST_POLARITY =3D =
0, SIGIS =3D RST<BR>
&gt;<BR>
&gt;<BR>
&gt; BEGIN ppc405_virtex4<BR>
&gt;&nbsp; PARAMETER INSTANCE =3D ppc405_0<BR>
&gt;&nbsp; PARAMETER HW_VER =3D 2.01.a<BR>
&gt;&nbsp; PARAMETER C_FASTEST_PLB_CLOCK =3D DPLB1<BR>
&gt;&nbsp; PARAMETER C_IDCR_BASEADDR =3D 0b0100000000<BR>
&gt;&nbsp; PARAMETER C_IDCR_HIGHADDR =3D 0b0111111111<BR>
&gt;&nbsp; BUS_INTERFACE JTAGPPC =3D jtagppc_0_0<BR>
&gt;&nbsp; BUS_INTERFACE IPLB0 =3D plb<BR>
&gt;&nbsp; BUS_INTERFACE DPLB0 =3D plb<BR>
&gt;&nbsp; BUS_INTERFACE IPLB1 =3D ppc405_0_iplb1<BR>
&gt;&nbsp; BUS_INTERFACE DPLB1 =3D ppc405_0_dplb1<BR>
&gt;&nbsp; BUS_INTERFACE RESETPPC =3D ppc_reset_bus<BR>
&gt;&nbsp; PORT CPMC405CLOCK =3D proc_clk_s<BR>
&gt;&nbsp; PORT EICC405EXTINPUTIRQ =3D EICC405EXTINPUTIRQ<BR>
&gt; END<BR>
&gt;<BR>
&gt; BEGIN jtagppc_cntlr<BR>
&gt;&nbsp; PARAMETER INSTANCE =3D jtagppc_0<BR>
&gt;&nbsp; PARAMETER HW_VER =3D 2.01.a<BR>
&gt;&nbsp; BUS_INTERFACE JTAGPPC0 =3D jtagppc_0_0<BR>
&gt; END<BR>
&gt;<BR>
&gt; BEGIN plb_v46<BR>
&gt;&nbsp; PARAMETER INSTANCE =3D plb<BR>
&gt;&nbsp; PARAMETER C_DCR_INTFCE =3D 0<BR>
&gt;&nbsp; PARAMETER C_NUM_CLK_PLB2OPB_REARB =3D 100<BR>
&gt;&nbsp; PARAMETER HW_VER =3D 1.02.a<BR>
&gt;&nbsp; PORT PLB_Clk =3D sys_clk_s<BR>
&gt;&nbsp; PORT SYS_Rst =3D sys_bus_reset<BR>
&gt; END<BR>
&gt;<BR>
&gt; BEGIN xps_bram_if_cntlr<BR>
&gt;&nbsp; PARAMETER INSTANCE =3D xps_bram_if_cntlr_1<BR>
&gt;&nbsp; PARAMETER HW_VER =3D 1.00.a<BR>
&gt;&nbsp; PARAMETER C_SPLB_NATIVE_DWIDTH =3D 64<BR>
&gt;&nbsp; PARAMETER C_BASEADDR =3D 0xffffe000<BR>
&gt;&nbsp; PARAMETER C_HIGHADDR =3D 0xffffffff<BR>
&gt;&nbsp; BUS_INTERFACE SPLB =3D plb<BR>
&gt;&nbsp; BUS_INTERFACE PORTA =3D xps_bram_if_cntlr_1_port<BR>
&gt; END<BR>
&gt;<BR>
&gt; BEGIN bram_block<BR>
&gt;&nbsp; PARAMETER INSTANCE =3D plb_bram_if_cntlr_1_bram<BR>
&gt;&nbsp; PARAMETER HW_VER =3D 1.00.a<BR>
&gt;&nbsp; BUS_INTERFACE PORTA =3D xps_bram_if_cntlr_1_port<BR>
&gt; END<BR>
&gt;<BR>
&gt; BEGIN xps_uart16550<BR>
&gt;&nbsp; PARAMETER INSTANCE =3D RS232_Uart<BR>
&gt;&nbsp; PARAMETER HW_VER =3D 2.00.a<BR>
&gt;&nbsp; PARAMETER C_IS_A_16550 =3D 1<BR>
&gt;&nbsp; PARAMETER C_BASEADDR =3D 0x83e00000<BR>
&gt;&nbsp; PARAMETER C_HIGHADDR =3D 0x83e0ffff<BR>
&gt;&nbsp; BUS_INTERFACE SPLB =3D plb<BR>
&gt;&nbsp; PORT sin =3D fpga_0_RS232_Uart_sin<BR>
&gt;&nbsp; PORT sout =3D fpga_0_RS232_Uart_sout<BR>
&gt;&nbsp; PORT IP2INTC_Irpt =3D RS232_Uart_IP2INTC_Irpt<BR>
&gt; END<BR>
&gt;<BR>
&gt; BEGIN xps_gpio<BR>
&gt;&nbsp; PARAMETER INSTANCE =3D LEDs_4Bit<BR>
&gt;&nbsp; PARAMETER HW_VER =3D 1.00.a<BR>
&gt;&nbsp; PARAMETER C_INTERRUPT_PRESENT =3D 1<BR>
&gt;&nbsp; PARAMETER C_GPIO_WIDTH =3D 4<BR>
&gt;&nbsp; PARAMETER C_IS_DUAL =3D 0<BR>
&gt;&nbsp; PARAMETER C_IS_BIDIR =3D 1<BR>
&gt;&nbsp; PARAMETER C_ALL_INPUTS =3D 0<BR>
&gt;&nbsp; PARAMETER C_BASEADDR =3D 0x81400000<BR>
&gt;&nbsp; PARAMETER C_HIGHADDR =3D 0x8140ffff<BR>
&gt;&nbsp; BUS_INTERFACE SPLB =3D plb<BR>
&gt;&nbsp; PORT GPIO_IO =3D fpga_0_LEDs_4Bit_GPIO_IO<BR>
&gt;&nbsp; PORT IP2INTC_Irpt =3D LEDs_4Bit_IP2INTC_Irpt<BR>
&gt; END<BR>
&gt;<BR>
&gt; BEGIN xps_iic<BR>
&gt;&nbsp; PARAMETER INSTANCE =3D IIC_EEPROM<BR>
&gt;&nbsp; PARAMETER HW_VER =3D 2.00.a<BR>
&gt;&nbsp; PARAMETER C_CLK_FREQ =3D 100000000<BR>
&gt;&nbsp; PARAMETER C_IIC_FREQ =3D 100000<BR>
&gt;&nbsp; PARAMETER C_TEN_BIT_ADR =3D 0<BR>
&gt;&nbsp; PARAMETER C_BASEADDR =3D 0x81600000<BR>
&gt;&nbsp; PARAMETER C_HIGHADDR =3D 0x8160ffff<BR>
&gt;&nbsp; BUS_INTERFACE SPLB =3D plb<BR>
&gt;&nbsp; PORT Scl =3D fpga_0_IIC_EEPROM_Scl<BR>
&gt;&nbsp; PORT Sda =3D fpga_0_IIC_EEPROM_Sda<BR>
&gt;&nbsp; PORT IIC2INTC_Irpt =3D IIC_EEPROM_IIC2INTC_Irpt<BR>
&gt; END<BR>
&gt;<BR>
&gt; BEGIN xps_sysace<BR>
&gt;&nbsp; PARAMETER INSTANCE =3D SysACE_CompactFlash<BR>
&gt;&nbsp; PARAMETER HW_VER =3D 1.00.a<BR>
&gt;&nbsp; PARAMETER C_MEM_WIDTH =3D 16<BR>
&gt;&nbsp; PARAMETER C_BASEADDR =3D 0x83600000<BR>
&gt;&nbsp; PARAMETER C_HIGHADDR =3D 0x8360ffff<BR>
&gt;&nbsp; BUS_INTERFACE SPLB =3D plb<BR>
&gt;&nbsp; PORT SysACE_CLK =3D fpga_0_SysACE_CompactFlash_SysACE_CLK<BR>
&gt;&nbsp; PORT SysACE_MPA =3D =
fpga_0_SysACE_CompactFlash_SysACE_MPA_split<BR>
&gt;&nbsp; PORT SysACE_MPD =3D fpga_0_SysACE_CompactFlash_SysACE_MPD<BR>
&gt;&nbsp; PORT SysACE_CEN =3D fpga_0_SysACE_CompactFlash_SysACE_CEN<BR>
&gt;&nbsp; PORT SysACE_OEN =3D fpga_0_SysACE_CompactFlash_SysACE_OEN<BR>
&gt;&nbsp; PORT SysACE_WEN =3D fpga_0_SysACE_CompactFlash_SysACE_WEN<BR>
&gt;&nbsp; PORT SysACE_MPIRQ =3D =
fpga_0_SysACE_CompactFlash_SysACE_MPIRQ<BR>
&gt;&nbsp; PORT SysACE_IRQ =3D SysACE_CompactFlash_SysACE_IRQ<BR>
&gt; END<BR>
&gt;<BR>
&gt; BEGIN mpmc<BR>
&gt;&nbsp; PARAMETER INSTANCE =3D DDR_SDRAM<BR>
&gt;&nbsp; PARAMETER HW_VER =3D 4.00.a<BR>
&gt;&nbsp; PARAMETER C_NUM_PORTS =3D 3<BR>
&gt;&nbsp; PARAMETER C_MEM_PARTNO =3D HYB25D512160BE-5<BR>
&gt;&nbsp; PARAMETER C_MEM_DATA_WIDTH =3D 32<BR>
&gt;&nbsp; PARAMETER C_MEM_DQS_WIDTH =3D 4<BR>
&gt;&nbsp; PARAMETER C_MEM_DM_WIDTH =3D 4<BR>
&gt;&nbsp; PARAMETER C_MEM_TYPE =3D DDR<BR>
&gt;&nbsp; PARAMETER C_NUM_IDELAYCTRL =3D 2<BR>
&gt;&nbsp; PARAMETER C_IDELAYCTRL_LOC =3D =
IDELAYCTRL_X0Y3-IDELAYCTRL_X0Y2<BR>
&gt;&nbsp; PARAMETER C_PIM0_BASETYPE =3D 2<BR>
&gt;&nbsp; PARAMETER C_PIM1_BASETYPE =3D 2<BR>
&gt;&nbsp; PARAMETER C_PIM2_BASETYPE =3D 3<BR>
&gt;&nbsp; PARAMETER C_MPMC_CLK0_PERIOD_PS =3D 10000<BR>
&gt;&nbsp; PARAMETER C_SDMA2_PI2LL_CLK_RATIO =3D 1<BR>
&gt;&nbsp; PARAMETER C_MPMC_BASEADDR =3D 0x00000000<BR>
&gt;&nbsp; PARAMETER C_MPMC_HIGHADDR =3D 0x07ffffff<BR>
&gt;&nbsp; PARAMETER C_SDMA_CTRL_BASEADDR =3D 0x84600000<BR>
&gt;&nbsp; PARAMETER C_SDMA_CTRL_HIGHADDR =3D 0x8460ffff<BR>
&gt;&nbsp; BUS_INTERFACE SPLB0 =3D ppc405_0_iplb1<BR>
&gt;&nbsp; BUS_INTERFACE SPLB1 =3D ppc405_0_dplb1<BR>
&gt;&nbsp; BUS_INTERFACE SDMA_LL2 =3D TriMode_MAC_GMII_LLINK0<BR>
&gt;&nbsp; BUS_INTERFACE SDMA_CTRL2 =3D plb<BR>
&gt;&nbsp; PORT DDR_Addr =3D fpga_0_DDR_SDRAM_DDR_Addr<BR>
&gt;&nbsp; PORT DDR_BankAddr =3D fpga_0_DDR_SDRAM_DDR_BankAddr<BR>
&gt;&nbsp; PORT DDR_CAS_n =3D fpga_0_DDR_SDRAM_DDR_CAS_n<BR>
&gt;&nbsp; PORT DDR_CE =3D fpga_0_DDR_SDRAM_DDR_CE<BR>
&gt;&nbsp; PORT DDR_CS_n =3D fpga_0_DDR_SDRAM_DDR_CS_n<BR>
&gt;&nbsp; PORT DDR_RAS_n =3D fpga_0_DDR_SDRAM_DDR_RAS_n<BR>
&gt;&nbsp; PORT DDR_WE_n =3D fpga_0_DDR_SDRAM_DDR_WE_n<BR>
&gt;&nbsp; PORT DDR_DM =3D fpga_0_DDR_SDRAM_DDR_DM<BR>
&gt;&nbsp; PORT DDR_DQS =3D fpga_0_DDR_SDRAM_DDR_DQS<BR>
&gt;&nbsp; PORT DDR_DQ =3D fpga_0_DDR_SDRAM_DDR_DQ<BR>
&gt;&nbsp; PORT DDR_Clk =3D fpga_0_DDR_SDRAM_DDR_Clk<BR>
&gt;&nbsp; PORT DDR_Clk_n =3D fpga_0_DDR_SDRAM_DDR_Clk_n<BR>
&gt;&nbsp; PORT MPMC_Clk0 =3D sys_clk_s<BR>
&gt;&nbsp; PORT MPMC_Clk90 =3D DDR_SDRAM_mpmc_clk_90_s<BR>
&gt;&nbsp; PORT SDMA2_Clk =3D sys_clk_s<BR>
&gt;&nbsp; PORT MPMC_Clk_200MHz =3D clk_200mhz_s<BR>
&gt;&nbsp; PORT MPMC_Rst =3D sys_periph_reset<BR>
&gt;&nbsp; PORT SDMA2_Rx_IntOut =3D DDR_SDRAM_SDMA2_Rx_IntOut<BR>
&gt;&nbsp; PORT SDMA2_Tx_IntOut =3D DDR_SDRAM_SDMA2_Tx_IntOut<BR>
&gt; END<BR>
&gt;<BR>
&gt; BEGIN xps_ll_temac<BR>
&gt;&nbsp; PARAMETER INSTANCE =3D TriMode_MAC_GMII<BR>
&gt;&nbsp; PARAMETER HW_VER =3D 1.01.a<BR>
&gt;&nbsp; PARAMETER C_SPLB_CLK_PERIOD_PS =3D 10000<BR>
&gt;&nbsp; PARAMETER C_PHY_TYPE =3D 1<BR>
&gt;&nbsp; PARAMETER C_NUM_IDELAYCTRL =3D 4<BR>
&gt;&nbsp; PARAMETER C_IDELAYCTRL_LOC =3D =
IDELAYCTRL_X1Y1-IDELAYCTRL_X1Y3-IDELAYCTRL_X2Y2-IDELAYCTRL_X2Y3<BR>
&gt;&nbsp; PARAMETER C_TEMAC_TYPE =3D 1<BR>
&gt;&nbsp; PARAMETER C_BUS2CORE_CLK_RATIO =3D 1<BR>
&gt;&nbsp; PARAMETER C_BASEADDR =3D 0x81c00000<BR>
&gt;&nbsp; PARAMETER C_HIGHADDR =3D 0x81c0ffff<BR>
&gt;&nbsp; BUS_INTERFACE SPLB =3D plb<BR>
&gt;&nbsp; BUS_INTERFACE LLINK0 =3D TriMode_MAC_GMII_LLINK0<BR>
&gt;&nbsp; PORT GMII_TXD_0 =3D fpga_0_TriMode_MAC_GMII_GMII_TXD_0<BR>
&gt;&nbsp; PORT GMII_TX_EN_0 =3D =
fpga_0_TriMode_MAC_GMII_GMII_TX_EN_0<BR>
&gt;&nbsp; PORT GMII_TX_ER_0 =3D =
fpga_0_TriMode_MAC_GMII_GMII_TX_ER_0<BR>
&gt;&nbsp; PORT GMII_TX_CLK_0 =3D =
fpga_0_TriMode_MAC_GMII_GMII_TX_CLK_0<BR>
&gt;&nbsp; PORT GMII_RXD_0 =3D fpga_0_TriMode_MAC_GMII_GMII_RXD_0<BR>
&gt;&nbsp; PORT GMII_RX_DV_0 =3D =
fpga_0_TriMode_MAC_GMII_GMII_RX_DV_0<BR>
&gt;&nbsp; PORT GMII_RX_ER_0 =3D =
fpga_0_TriMode_MAC_GMII_GMII_RX_ER_0<BR>
&gt;&nbsp; PORT GMII_RX_CLK_0 =3D =
fpga_0_TriMode_MAC_GMII_GMII_RX_CLK_0<BR>
&gt;&nbsp; PORT MII_TX_CLK_0 =3D =
fpga_0_TriMode_MAC_GMII_MII_TX_CLK_0<BR>
&gt;&nbsp; PORT MDIO_0 =3D fpga_0_TriMode_MAC_GMII_MDIO_0<BR>
&gt;&nbsp; PORT MDC_0 =3D fpga_0_TriMode_MAC_GMII_MDC_0<BR>
&gt;&nbsp; PORT TemacPhy_RST_n =3D =
fpga_0_TriMode_MAC_GMII_TemacPhy_RST_n<BR>
&gt;&nbsp; PORT GTX_CLK_0 =3D temac_clk_s<BR>
&gt;&nbsp; PORT REFCLK =3D clk_200mhz_s<BR>
&gt;&nbsp; PORT LlinkTemac0_CLK =3D sys_clk_s<BR>
&gt;&nbsp; PORT TemacIntc0_Irpt =3D TriMode_MAC_GMII_TemacIntc0_Irpt<BR>
&gt; END<BR>
&gt;<BR>
&gt; BEGIN util_bus_split<BR>
&gt;&nbsp; PARAMETER INSTANCE =3D =
SysACE_CompactFlash_util_bus_split_0<BR>
&gt;&nbsp; PARAMETER HW_VER =3D 1.00.a<BR>
&gt;&nbsp; PARAMETER C_SIZE_IN =3D 7<BR>
&gt;&nbsp; PARAMETER C_LEFT_POS =3D 0<BR>
&gt;&nbsp; PARAMETER C_SPLIT =3D 6<BR>
&gt;&nbsp; PORT Sig =3D fpga_0_SysACE_CompactFlash_SysACE_MPA_split<BR>
&gt;&nbsp; PORT Out1 =3D fpga_0_SysACE_CompactFlash_SysACE_MPA<BR>
&gt; END<BR>
&gt;<BR>
&gt; BEGIN plb_v46<BR>
&gt;&nbsp; PARAMETER INSTANCE =3D ppc405_0_iplb1<BR>
&gt;&nbsp; PARAMETER HW_VER =3D 1.02.a<BR>
&gt;&nbsp; PORT PLB_Clk =3D sys_clk_s<BR>
&gt;&nbsp; PORT SYS_Rst =3D sys_bus_reset<BR>
&gt; END<BR>
&gt;<BR>
&gt; BEGIN plb_v46<BR>
&gt;&nbsp; PARAMETER INSTANCE =3D ppc405_0_dplb1<BR>
&gt;&nbsp; PARAMETER HW_VER =3D 1.02.a<BR>
&gt;&nbsp; PORT PLB_Clk =3D sys_clk_s<BR>
&gt;&nbsp; PORT SYS_Rst =3D sys_bus_reset<BR>
&gt; END<BR>
&gt;<BR>
&gt; BEGIN clock_generator<BR>
&gt;&nbsp; PARAMETER INSTANCE =3D clock_generator_0<BR>
&gt;&nbsp; PARAMETER HW_VER =3D 2.00.a<BR>
&gt;&nbsp; PARAMETER C_EXT_RESET_HIGH =3D 1<BR>
&gt;&nbsp; PARAMETER C_CLKIN_FREQ =3D 100000000<BR>
&gt;&nbsp; PARAMETER C_CLKOUT0_FREQ =3D 100000000<BR>
&gt;&nbsp; PARAMETER C_CLKOUT0_BUF =3D TRUE<BR>
&gt;&nbsp; PARAMETER C_CLKOUT0_PHASE =3D 0<BR>
&gt;&nbsp; PARAMETER C_CLKOUT0_GROUP =3D DCM0<BR>
&gt;&nbsp; PARAMETER C_CLKOUT1_FREQ =3D 100000000<BR>
&gt;&nbsp; PARAMETER C_CLKOUT1_BUF =3D TRUE<BR>
&gt;&nbsp; PARAMETER C_CLKOUT1_PHASE =3D 90<BR>
&gt;&nbsp; PARAMETER C_CLKOUT1_GROUP =3D DCM0<BR>
&gt;&nbsp; PARAMETER C_CLKOUT2_FREQ =3D 300000000<BR>
&gt;&nbsp; PARAMETER C_CLKOUT2_BUF =3D TRUE<BR>
&gt;&nbsp; PARAMETER C_CLKOUT2_PHASE =3D 0<BR>
&gt;&nbsp; PARAMETER C_CLKOUT2_GROUP =3D DCM0<BR>
&gt;&nbsp; PARAMETER C_CLKOUT3_FREQ =3D 200000000<BR>
&gt;&nbsp; PARAMETER C_CLKOUT3_BUF =3D TRUE<BR>
&gt;&nbsp; PARAMETER C_CLKOUT3_PHASE =3D 0<BR>
&gt;&nbsp; PARAMETER C_CLKOUT3_GROUP =3D NONE<BR>
&gt;&nbsp; PARAMETER C_CLKOUT4_FREQ =3D 125000000<BR>
&gt;&nbsp; PARAMETER C_CLKOUT4_BUF =3D TRUE<BR>
&gt;&nbsp; PARAMETER C_CLKOUT4_PHASE =3D 0<BR>
&gt;&nbsp; PARAMETER C_CLKOUT4_GROUP =3D NONE<BR>
&gt;&nbsp; PORT CLKOUT0 =3D sys_clk_s<BR>
&gt;&nbsp; PORT CLKOUT1 =3D DDR_SDRAM_mpmc_clk_90_s<BR>
&gt;&nbsp; PORT CLKOUT2 =3D proc_clk_s<BR>
&gt;&nbsp; PORT CLKOUT3 =3D clk_200mhz_s<BR>
&gt;&nbsp; PORT CLKOUT4 =3D temac_clk_s<BR>
&gt;&nbsp; PORT CLKIN =3D dcm_clk_s<BR>
&gt;&nbsp; PORT LOCKED =3D Dcm_all_locked<BR>
&gt;&nbsp; PORT RST =3D net_gnd<BR>
&gt; END<BR>
&gt;<BR>
&gt; BEGIN proc_sys_reset<BR>
&gt;&nbsp; PARAMETER INSTANCE =3D proc_sys_reset_0<BR>
&gt;&nbsp; PARAMETER HW_VER =3D 2.00.a<BR>
&gt;&nbsp; PARAMETER C_EXT_RESET_HIGH =3D 0<BR>
&gt;&nbsp; BUS_INTERFACE RESETPPC0 =3D ppc_reset_bus<BR>
&gt;&nbsp; PORT Slowest_sync_clk =3D sys_clk_s<BR>
&gt;&nbsp; PORT Dcm_locked =3D Dcm_all_locked<BR>
&gt;&nbsp; PORT Ext_Reset_In =3D sys_rst_s<BR>
&gt;&nbsp; PORT Bus_Struct_Reset =3D sys_bus_reset<BR>
&gt;&nbsp; PORT Peripheral_Reset =3D sys_periph_reset<BR>
&gt; END<BR>
&gt;<BR>
&gt; BEGIN xps_intc<BR>
&gt;&nbsp; PARAMETER INSTANCE =3D xps_intc_0<BR>
&gt;&nbsp; PARAMETER HW_VER =3D 1.00.a<BR>
&gt;&nbsp; PARAMETER C_BASEADDR =3D 0x81800000<BR>
&gt;&nbsp; PARAMETER C_HIGHADDR =3D 0x8180ffff<BR>
&gt;&nbsp; BUS_INTERFACE SPLB =3D plb<BR>
&gt;&nbsp; PORT Irq =3D EICC405EXTINPUTIRQ<BR>
&gt;&nbsp; PORT Intr =3D RS232_Uart_IP2INTC_Irpt &amp; =
LEDs_4Bit_IP2INTC_Irpt &amp; IIC_EEPROM_IIC2INTC_Irpt &amp; =
SysACE_CompactFlash_SysACE_IRQ &amp; TriMode_MAC_GMII_TemacIntc0_Irpt =
&amp; DDR_SDRAM_SDMA2_Rx_IntOut &amp; DDR_SDRAM_SDMA2_Tx_IntOut<BR>
&gt; END<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D &lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D &lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;xlnx,virtex&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; model =3D &quot;testing&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DDR_SDRAM: memory@0 {<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D =
&quot;memory&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt; 0 8000000 =
&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } ;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chosen {<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bootargs =3D =
&quot;console=3DttyS0,9600 ip=3Don =
nfsroot=3D172.16.40.76:/v2pclients/jhl26,tcp&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; linux,stdout-path =3D =
&quot;/plb@0/serial@83e00000&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } ;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpus {<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D =
&lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #cpus =3D &lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D =
&lt;0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ppc405_0: cpu@0 {<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock-frequency =3D =
&lt;11e1a300&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;PowerPC,405&quot;, &quot;ibm,ppc405&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d-cache-line-size =3D =
&lt;20&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d-cache-size =3D =
&lt;4000&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D =
&quot;cpu&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i-cache-line-size =3D =
&lt;20&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i-cache-size =3D =
&lt;4000&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; model =3D =
&quot;PowerPC,405&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timebase-frequency =3D =
&lt;11e1a300&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,apu-control =3D =
&lt;de00&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,apu-udi-1 =3D =
&lt;a18983&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,apu-udi-2 =3D =
&lt;a38983&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,apu-udi-3 =3D =
&lt;a589c3&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,apu-udi-4 =3D =
&lt;a789c3&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,apu-udi-5 =3D =
&lt;a98c03&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,apu-udi-6 =3D =
&lt;ab8c03&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,apu-udi-7 =3D =
&lt;ad8c43&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,apu-udi-8 =3D =
&lt;af8c43&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,deterministic-mult =3D =
&lt;0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
xlnx,disable-operand-forwarding =3D &lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,fastest-plb-clock =3D =
&quot;DPLB0&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,generate-plb-timespecs =
=3D &lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,mmu-enable =3D =
&lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,pvr-high =3D =
&lt;0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,pvr-low =3D =
&lt;0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } ;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } ;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plb: plb@0 {<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D =
&lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D =
&lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;xlnx,plb-v46-1.02.a&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges ;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IIC_EEPROM: i2c@81600000 =
{<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;xlnx,xps-iic-2.00.a&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent =3D =
&lt;&amp;xps_intc_0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D &lt; 4 2 =
&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt; 81600000 10000 =
&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,clk-freq =3D =
&lt;5f5e100&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,family =3D =
&quot;virtex4&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,gpo-width =3D =
&lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,iic-freq =3D =
&lt;186a0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,scl-inertial-delay =3D =
&lt;0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,sda-inertial-delay =3D =
&lt;0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,ten-bit-adr =3D =
&lt;0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } ;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LEDs_4Bit: gpio@81400000 =
{<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;xlnx,xps-gpio-1.00.a&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent =3D =
&lt;&amp;xps_intc_0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D &lt; 5 2 =
&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt; 81400000 10000 =
&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,all-inputs =3D =
&lt;0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,all-inputs-2 =3D =
&lt;0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,dout-default =3D =
&lt;0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,dout-default-2 =3D =
&lt;0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,family =3D =
&quot;virtex4&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,gpio-width =3D =
&lt;4&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,interrupt-present =3D =
&lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,is-bidir =3D =
&lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,is-bidir-2 =3D =
&lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,is-dual =3D =
&lt;0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,tri-default =3D =
&lt;ffffffff&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,tri-default-2 =3D =
&lt;ffffffff&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } ;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RS232_Uart: serial@83e00000 =
{<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;xlnx,xps-uart16550-2.00.a&quot;;<BR>
&gt; //&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;ns16550&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D =
&quot;serial&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent =3D =
&lt;&amp;xps_intc_0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D &lt; 6 2 =
&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt; 83e00000 10000 =
&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; current-speed =3D =
&lt;d#9600&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock-frequency =3D =
&lt;d#100000000&gt;;&nbsp; /* added by jhl */<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg-shift =3D &lt;2&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,family =3D =
&quot;virtex4&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,has-external-rclk =3D =
&lt;0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,has-external-xin =3D =
&lt;0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,is-a-16550 =3D =
&lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } ;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SysACE_CompactFlash: =
sysace@83600000 {<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;xlnx,xps-sysace-1.00.a&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent =3D =
&lt;&amp;xps_intc_0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D &lt; 3 2 =
&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt; 83600000 10000 =
&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,family =3D =
&quot;virtex4&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,mem-width =3D =
&lt;10&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } ;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TriMode_MAC_GMII: =
xps-ll-temac@81c00000 {<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D =
&lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D =
&lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;xlnx,compound&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ethernet@81c00000 {<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;xlnx,xps-ll-temac-1.01.a&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D =
&quot;network&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent =3D =
&lt;&amp;xps_intc_0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D &lt; 2 2 =
&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; llink-connected =3D =
&lt;&amp;PIM2&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; local-mac-address =3D [ 02 00 =
00 00 00 01 ];<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt; 81c00000 40 =
&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,bus2core-clk-ratio =3D =
&lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,phy-type =3D =
&lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,phyaddr =3D =
&lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,rxcsum =3D =
&lt;0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,rxfifo =3D =
&lt;1000&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,temac-type =3D =
&lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,txcsum =3D =
&lt;0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,txfifo =3D =
&lt;1000&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } ;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } ;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpmc@0 {<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D =
&lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D =
&lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;xlnx,mpmc-4.00.a&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PIM2: sdma@84600100 {<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;xlnx,ll-dma-1.00.a&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent =3D =
&lt;&amp;xps_intc_0&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D &lt; 1 2 0 2 =
&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt; 84600100 80 =
&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } ;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } ;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xps_bram_if_cntlr_1: =
xps-bram-if-cntlr@ffffe000 {<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;xlnx,xps-bram-if-cntlr-1.00.a&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt; ffffe000 2000 =
&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,family =3D =
&quot;virtex4&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } ;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xps_intc_0: =
interrupt-controller@81800000 {<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #interrupt-cells =3D =
&lt;2&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;xlnx,xps-intc-1.00.a&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-controller ;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt; 81800000 10000 =
&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xlnx,num-intr-inputs =3D =
&lt;7&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } ;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } ;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ppc405_0_dplb1: plb@1 {<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D =
&lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D =
&lt;1&gt;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;xlnx,plb-v46-1.02.a&quot;;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges ;<BR>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } ;<BR>
&gt; }&nbsp; ;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt; -----Original Message-----<BR>
&gt; From: Magnus Hjorth [<A =
HREF=3D"mailto:mh@omnisys.se">mailto:mh@omnisys.se</A>]<BR>
&gt; Sent: Saturday, March 29, 2008 6:54 AM<BR>
&gt; To: git<BR>
&gt; Cc: linuxppc-embedded@ozlabs.org<BR>
&gt; Subject: Xilinx LLTEMAC driver issues<BR>
&gt;<BR>
&gt; Hi,<BR>
&gt;<BR>
&gt; I'm having some networking troubles with the Xilinx LLTEMAC driver =
from the<BR>
&gt; Xilinx Linux git tree (powerpc arch) on an ML403 board. =
EDK9.2SP2,<BR>
&gt; xps_ll_temac v1.00.b<BR>
&gt;<BR>
&gt; The weird thing is, that it sort of half works. It successfully =
makes a DHCP<BR>
&gt; request and gets its IP address. I tried setting up a tftpd server, =
and I can<BR>
&gt; see UDP requests coming in but the response doesn't seem to come =
out. I also<BR>
&gt; tried running a TCP server on the board, and it can see and accept =
incoming<BR>
&gt; connections but after that no data seems to get through. I can ping =
out and<BR>
&gt; get around 40% packet loss.<BR>
&gt;<BR>
&gt; Looking at /proc/interrupts, I can see both TxDma interrupts and =
RxDma<BR>
&gt; interrupts. No eth0 interrupts but that seems to be OK judging by =
the driver<BR>
&gt; source comments. Ifconfig shows no collistions, no dropped packets, =
no errors,<BR>
&gt; so the system seems to think that everything is OK.<BR>
&gt;<BR>
&gt; Clues anyone? I'm starting to run out of ideas...<BR>
&gt;<BR>
&gt; Best regards,<BR>
&gt; Magnus<BR>
&gt;<BR>
&gt;<BR>
&gt; --<BR>
&gt;<BR>
&gt; Magnus Hjorth, M.Sc.<BR>
&gt; Omnisys Instruments AB<BR>
&gt; Gruvgatan 8<BR>
&gt; SE-421 30&nbsp; V=E4stra Fr=F6lunda, SWEDEN<BR>
&gt; Phone: +46 31 734 34 09<BR>
&gt; Fax: +46 31 734 34 29<BR>
&gt; <A HREF=3D"http://www.omnisys.se">http://www.omnisys.se</A><BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C89287.D6DF51FB--
