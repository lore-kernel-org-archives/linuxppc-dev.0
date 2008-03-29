Return-Path: <mh@omnisys.se>
Received: from ch-smtp02.sth.basefarm.net (ch-smtp02.sth.basefarm.net
	[80.76.149.213])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6C5FFDDEDC
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 30 Mar 2008 02:05:55 +1100 (EST)
Subject: RE: Xilinx LLTEMAC driver issues
From: Magnus Hjorth <mh@omnisys.se>
To: John Linn <John.Linn@xilinx.com>
In-Reply-To: <20080329135813.B3832DE8062@mail60-sin.bigfish.com>
References: <20080329125416.B09261AD8051@mail119-sin.bigfish.com>
	<20080329135813.B3832DE8062@mail60-sin.bigfish.com>
Content-Type: text/plain; charset=utf-8
Date: Sat, 29 Mar 2008 15:50:34 +0100
Message-Id: <1206802234.5247.19.camel@magnus-desktop>
Mime-Version: 1.0
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

Hi John,

Thanks for the very fast reply! Right now I'm not at work so I don't
have the board or EDK here to test anything. 

I'm using checksum offload, but I don't know if DRE is enabled or not. I
can't recall seeing any setting to enable/disable DRE.. 

A few things that crossed my mind:

Last year I did a design with EDK 8.2, back then there was an issue with
the ML403 boards having an old revision of the FPGA which wasn't
compatible with some versions of the IP core. There are no such version
issues with the xps_ll_temac? 

I don't think that I had phy-addr set in the DTS file. Will test that on
Monday. 

Best regards,
Magnus


On Sat, 2008-03-29 at 07:58 -0600, John Linn wrote:
> Hi Magnus,
> 
> Sorry to hear you're having problems with it.
> 
> I am doing testing on an ML405 which is the same board but with a bigger FPGA, but with ppc arch and I don't see this issue. I have done limited testing with powerpc arch and the LL TEMAC, but I didn't see this issue there either.  Powerpc arch is definitely less mature in my experience than the ppc arch. I'll do a quick test with my powerpc arch and make sure again I'm not seeing it.
> 
> My kernel is from the Xilinx Git tree, but there have been a number of changes we have pushed out so I don't know how long ago you pulled from the Git tree.
> 
> My EDK project is 10.1 so it's a little newer. I am using LL TEMAC 1.01a so it's a little newer.  I reviewed the change log for the LL TEMAC and don't see any big problems that were fixed in the newer versions, more new features.  I'll check with some others here to see if I missed something there.
> 
> I am using DMA also, but no DRE or checksum offload.  You didn't say anything about those. I'm going to insert my mhs file that describes my system to let you compare your system configuration. It's not clear to me yet if you have a h/w or s/w problem.  
> 
> I'll also insert some of my device tree with the LL TEMAC so you can compare (ignore 16550 stuff as we are still working on that).
> 
> Since you can't ping reliably I would probably focus on that since it's simpler than the other issues you're seeing.
> 
> Thanks,
> John
> 
> 
> 
> # ##############################################################################
> # Created by Base System Builder Wizard for Xilinx EDK 10.1.1 Build EDK_K_SP1.1
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
> # - DDR_SDRAM = 128 MB
> # ##############################################################################
>  PARAMETER VERSION = 2.1.0
> 
> 
>  PORT fpga_0_RS232_Uart_sin_pin = fpga_0_RS232_Uart_sin, DIR = I
>  PORT fpga_0_RS232_Uart_sout_pin = fpga_0_RS232_Uart_sout, DIR = O
>  PORT fpga_0_LEDs_4Bit_GPIO_IO_pin = fpga_0_LEDs_4Bit_GPIO_IO, DIR = IO, VEC = [0:3]
>  PORT fpga_0_IIC_EEPROM_Scl_pin = fpga_0_IIC_EEPROM_Scl, DIR = IO
>  PORT fpga_0_IIC_EEPROM_Sda_pin = fpga_0_IIC_EEPROM_Sda, DIR = IO
>  PORT fpga_0_SysACE_CompactFlash_SysACE_CLK_pin = fpga_0_SysACE_CompactFlash_SysACE_CLK, DIR = I
>  PORT fpga_0_SysACE_CompactFlash_SysACE_MPA_pin = fpga_0_SysACE_CompactFlash_SysACE_MPA, DIR = O, VEC = [6:1]
>  PORT fpga_0_SysACE_CompactFlash_SysACE_MPD_pin = fpga_0_SysACE_CompactFlash_SysACE_MPD, DIR = IO, VEC = [15:0]
>  PORT fpga_0_SysACE_CompactFlash_SysACE_CEN_pin = fpga_0_SysACE_CompactFlash_SysACE_CEN, DIR = O
>  PORT fpga_0_SysACE_CompactFlash_SysACE_OEN_pin = fpga_0_SysACE_CompactFlash_SysACE_OEN, DIR = O
>  PORT fpga_0_SysACE_CompactFlash_SysACE_WEN_pin = fpga_0_SysACE_CompactFlash_SysACE_WEN, DIR = O
>  PORT fpga_0_SysACE_CompactFlash_SysACE_MPIRQ_pin = fpga_0_SysACE_CompactFlash_SysACE_MPIRQ, DIR = I
>  PORT fpga_0_DDR_SDRAM_DDR_Clk_pin = fpga_0_DDR_SDRAM_DDR_Clk, DIR = O
>  PORT fpga_0_DDR_SDRAM_DDR_Clk_n_pin = fpga_0_DDR_SDRAM_DDR_Clk_n, DIR = O
>  PORT fpga_0_DDR_SDRAM_DDR_Addr_pin = fpga_0_DDR_SDRAM_DDR_Addr, DIR = O, VEC = [12:0]
>  PORT fpga_0_DDR_SDRAM_DDR_BankAddr_pin = fpga_0_DDR_SDRAM_DDR_BankAddr, DIR = O, VEC = [1:0]
>  PORT fpga_0_DDR_SDRAM_DDR_CAS_n_pin = fpga_0_DDR_SDRAM_DDR_CAS_n, DIR = O
>  PORT fpga_0_DDR_SDRAM_DDR_CE_pin = fpga_0_DDR_SDRAM_DDR_CE, DIR = O
>  PORT fpga_0_DDR_SDRAM_DDR_CS_n_pin = fpga_0_DDR_SDRAM_DDR_CS_n, DIR = O
>  PORT fpga_0_DDR_SDRAM_DDR_RAS_n_pin = fpga_0_DDR_SDRAM_DDR_RAS_n, DIR = O
>  PORT fpga_0_DDR_SDRAM_DDR_WE_n_pin = fpga_0_DDR_SDRAM_DDR_WE_n, DIR = O
>  PORT fpga_0_DDR_SDRAM_DDR_DM_pin = fpga_0_DDR_SDRAM_DDR_DM, DIR = O, VEC = [3:0]
>  PORT fpga_0_DDR_SDRAM_DDR_DQS = fpga_0_DDR_SDRAM_DDR_DQS, DIR = IO, VEC = [3:0]
>  PORT fpga_0_DDR_SDRAM_DDR_DQ = fpga_0_DDR_SDRAM_DDR_DQ, DIR = IO, VEC = [31:0]
>  PORT fpga_0_TriMode_MAC_GMII_GMII_TXD_0_pin = fpga_0_TriMode_MAC_GMII_GMII_TXD_0, DIR = O, VEC = [7:0]
>  PORT fpga_0_TriMode_MAC_GMII_GMII_TX_EN_0_pin = fpga_0_TriMode_MAC_GMII_GMII_TX_EN_0, DIR = O
>  PORT fpga_0_TriMode_MAC_GMII_GMII_TX_ER_0_pin = fpga_0_TriMode_MAC_GMII_GMII_TX_ER_0, DIR = O
>  PORT fpga_0_TriMode_MAC_GMII_GMII_TX_CLK_0_pin = fpga_0_TriMode_MAC_GMII_GMII_TX_CLK_0, DIR = O
>  PORT fpga_0_TriMode_MAC_GMII_GMII_RXD_0_pin = fpga_0_TriMode_MAC_GMII_GMII_RXD_0, DIR = I, VEC = [7:0]
>  PORT fpga_0_TriMode_MAC_GMII_GMII_RX_DV_0_pin = fpga_0_TriMode_MAC_GMII_GMII_RX_DV_0, DIR = I
>  PORT fpga_0_TriMode_MAC_GMII_GMII_RX_ER_0_pin = fpga_0_TriMode_MAC_GMII_GMII_RX_ER_0, DIR = I
>  PORT fpga_0_TriMode_MAC_GMII_GMII_RX_CLK_0_pin = fpga_0_TriMode_MAC_GMII_GMII_RX_CLK_0, DIR = I
>  PORT fpga_0_TriMode_MAC_GMII_MII_TX_CLK_0_pin = fpga_0_TriMode_MAC_GMII_MII_TX_CLK_0, DIR = I
>  PORT fpga_0_TriMode_MAC_GMII_MDIO_0_pin = fpga_0_TriMode_MAC_GMII_MDIO_0, DIR = IO
>  PORT fpga_0_TriMode_MAC_GMII_MDC_0_pin = fpga_0_TriMode_MAC_GMII_MDC_0, DIR = O
>  PORT fpga_0_TriMode_MAC_GMII_TemacPhy_RST_n_pin = fpga_0_TriMode_MAC_GMII_TemacPhy_RST_n, DIR = O
>  PORT sys_clk_pin = dcm_clk_s, DIR = I, SIGIS = CLK, CLK_FREQ = 100000000
>  PORT sys_rst_pin = sys_rst_s, DIR = I, RST_POLARITY = 0, SIGIS = RST
> 
> 
> BEGIN ppc405_virtex4
>  PARAMETER INSTANCE = ppc405_0
>  PARAMETER HW_VER = 2.01.a
>  PARAMETER C_FASTEST_PLB_CLOCK = DPLB1
>  PARAMETER C_IDCR_BASEADDR = 0b0100000000
>  PARAMETER C_IDCR_HIGHADDR = 0b0111111111
>  BUS_INTERFACE JTAGPPC = jtagppc_0_0
>  BUS_INTERFACE IPLB0 = plb
>  BUS_INTERFACE DPLB0 = plb
>  BUS_INTERFACE IPLB1 = ppc405_0_iplb1
>  BUS_INTERFACE DPLB1 = ppc405_0_dplb1
>  BUS_INTERFACE RESETPPC = ppc_reset_bus
>  PORT CPMC405CLOCK = proc_clk_s
>  PORT EICC405EXTINPUTIRQ = EICC405EXTINPUTIRQ
> END
> 
> BEGIN jtagppc_cntlr
>  PARAMETER INSTANCE = jtagppc_0
>  PARAMETER HW_VER = 2.01.a
>  BUS_INTERFACE JTAGPPC0 = jtagppc_0_0
> END
> 
> BEGIN plb_v46
>  PARAMETER INSTANCE = plb
>  PARAMETER C_DCR_INTFCE = 0
>  PARAMETER C_NUM_CLK_PLB2OPB_REARB = 100
>  PARAMETER HW_VER = 1.02.a
>  PORT PLB_Clk = sys_clk_s
>  PORT SYS_Rst = sys_bus_reset
> END
> 
> BEGIN xps_bram_if_cntlr
>  PARAMETER INSTANCE = xps_bram_if_cntlr_1
>  PARAMETER HW_VER = 1.00.a
>  PARAMETER C_SPLB_NATIVE_DWIDTH = 64
>  PARAMETER C_BASEADDR = 0xffffe000
>  PARAMETER C_HIGHADDR = 0xffffffff
>  BUS_INTERFACE SPLB = plb
>  BUS_INTERFACE PORTA = xps_bram_if_cntlr_1_port
> END
> 
> BEGIN bram_block
>  PARAMETER INSTANCE = plb_bram_if_cntlr_1_bram
>  PARAMETER HW_VER = 1.00.a
>  BUS_INTERFACE PORTA = xps_bram_if_cntlr_1_port
> END
> 
> BEGIN xps_uart16550
>  PARAMETER INSTANCE = RS232_Uart
>  PARAMETER HW_VER = 2.00.a
>  PARAMETER C_IS_A_16550 = 1
>  PARAMETER C_BASEADDR = 0x83e00000
>  PARAMETER C_HIGHADDR = 0x83e0ffff
>  BUS_INTERFACE SPLB = plb
>  PORT sin = fpga_0_RS232_Uart_sin
>  PORT sout = fpga_0_RS232_Uart_sout
>  PORT IP2INTC_Irpt = RS232_Uart_IP2INTC_Irpt
> END
> 
> BEGIN xps_gpio
>  PARAMETER INSTANCE = LEDs_4Bit
>  PARAMETER HW_VER = 1.00.a
>  PARAMETER C_INTERRUPT_PRESENT = 1
>  PARAMETER C_GPIO_WIDTH = 4
>  PARAMETER C_IS_DUAL = 0
>  PARAMETER C_IS_BIDIR = 1
>  PARAMETER C_ALL_INPUTS = 0
>  PARAMETER C_BASEADDR = 0x81400000
>  PARAMETER C_HIGHADDR = 0x8140ffff
>  BUS_INTERFACE SPLB = plb
>  PORT GPIO_IO = fpga_0_LEDs_4Bit_GPIO_IO
>  PORT IP2INTC_Irpt = LEDs_4Bit_IP2INTC_Irpt
> END
> 
> BEGIN xps_iic
>  PARAMETER INSTANCE = IIC_EEPROM
>  PARAMETER HW_VER = 2.00.a
>  PARAMETER C_CLK_FREQ = 100000000
>  PARAMETER C_IIC_FREQ = 100000
>  PARAMETER C_TEN_BIT_ADR = 0
>  PARAMETER C_BASEADDR = 0x81600000
>  PARAMETER C_HIGHADDR = 0x8160ffff
>  BUS_INTERFACE SPLB = plb
>  PORT Scl = fpga_0_IIC_EEPROM_Scl
>  PORT Sda = fpga_0_IIC_EEPROM_Sda
>  PORT IIC2INTC_Irpt = IIC_EEPROM_IIC2INTC_Irpt
> END
> 
> BEGIN xps_sysace
>  PARAMETER INSTANCE = SysACE_CompactFlash
>  PARAMETER HW_VER = 1.00.a
>  PARAMETER C_MEM_WIDTH = 16
>  PARAMETER C_BASEADDR = 0x83600000
>  PARAMETER C_HIGHADDR = 0x8360ffff
>  BUS_INTERFACE SPLB = plb
>  PORT SysACE_CLK = fpga_0_SysACE_CompactFlash_SysACE_CLK
>  PORT SysACE_MPA = fpga_0_SysACE_CompactFlash_SysACE_MPA_split
>  PORT SysACE_MPD = fpga_0_SysACE_CompactFlash_SysACE_MPD
>  PORT SysACE_CEN = fpga_0_SysACE_CompactFlash_SysACE_CEN
>  PORT SysACE_OEN = fpga_0_SysACE_CompactFlash_SysACE_OEN
>  PORT SysACE_WEN = fpga_0_SysACE_CompactFlash_SysACE_WEN
>  PORT SysACE_MPIRQ = fpga_0_SysACE_CompactFlash_SysACE_MPIRQ
>  PORT SysACE_IRQ = SysACE_CompactFlash_SysACE_IRQ
> END
> 
> BEGIN mpmc
>  PARAMETER INSTANCE = DDR_SDRAM
>  PARAMETER HW_VER = 4.00.a
>  PARAMETER C_NUM_PORTS = 3
>  PARAMETER C_MEM_PARTNO = HYB25D512160BE-5
>  PARAMETER C_MEM_DATA_WIDTH = 32
>  PARAMETER C_MEM_DQS_WIDTH = 4
>  PARAMETER C_MEM_DM_WIDTH = 4
>  PARAMETER C_MEM_TYPE = DDR
>  PARAMETER C_NUM_IDELAYCTRL = 2
>  PARAMETER C_IDELAYCTRL_LOC = IDELAYCTRL_X0Y3-IDELAYCTRL_X0Y2
>  PARAMETER C_PIM0_BASETYPE = 2
>  PARAMETER C_PIM1_BASETYPE = 2
>  PARAMETER C_PIM2_BASETYPE = 3
>  PARAMETER C_MPMC_CLK0_PERIOD_PS = 10000
>  PARAMETER C_SDMA2_PI2LL_CLK_RATIO = 1
>  PARAMETER C_MPMC_BASEADDR = 0x00000000
>  PARAMETER C_MPMC_HIGHADDR = 0x07ffffff
>  PARAMETER C_SDMA_CTRL_BASEADDR = 0x84600000
>  PARAMETER C_SDMA_CTRL_HIGHADDR = 0x8460ffff
>  BUS_INTERFACE SPLB0 = ppc405_0_iplb1
>  BUS_INTERFACE SPLB1 = ppc405_0_dplb1
>  BUS_INTERFACE SDMA_LL2 = TriMode_MAC_GMII_LLINK0
>  BUS_INTERFACE SDMA_CTRL2 = plb
>  PORT DDR_Addr = fpga_0_DDR_SDRAM_DDR_Addr
>  PORT DDR_BankAddr = fpga_0_DDR_SDRAM_DDR_BankAddr
>  PORT DDR_CAS_n = fpga_0_DDR_SDRAM_DDR_CAS_n
>  PORT DDR_CE = fpga_0_DDR_SDRAM_DDR_CE
>  PORT DDR_CS_n = fpga_0_DDR_SDRAM_DDR_CS_n
>  PORT DDR_RAS_n = fpga_0_DDR_SDRAM_DDR_RAS_n
>  PORT DDR_WE_n = fpga_0_DDR_SDRAM_DDR_WE_n
>  PORT DDR_DM = fpga_0_DDR_SDRAM_DDR_DM
>  PORT DDR_DQS = fpga_0_DDR_SDRAM_DDR_DQS
>  PORT DDR_DQ = fpga_0_DDR_SDRAM_DDR_DQ
>  PORT DDR_Clk = fpga_0_DDR_SDRAM_DDR_Clk
>  PORT DDR_Clk_n = fpga_0_DDR_SDRAM_DDR_Clk_n
>  PORT MPMC_Clk0 = sys_clk_s
>  PORT MPMC_Clk90 = DDR_SDRAM_mpmc_clk_90_s
>  PORT SDMA2_Clk = sys_clk_s
>  PORT MPMC_Clk_200MHz = clk_200mhz_s
>  PORT MPMC_Rst = sys_periph_reset
>  PORT SDMA2_Rx_IntOut = DDR_SDRAM_SDMA2_Rx_IntOut
>  PORT SDMA2_Tx_IntOut = DDR_SDRAM_SDMA2_Tx_IntOut
> END
> 
> BEGIN xps_ll_temac
>  PARAMETER INSTANCE = TriMode_MAC_GMII
>  PARAMETER HW_VER = 1.01.a
>  PARAMETER C_SPLB_CLK_PERIOD_PS = 10000
>  PARAMETER C_PHY_TYPE = 1
>  PARAMETER C_NUM_IDELAYCTRL = 4
>  PARAMETER C_IDELAYCTRL_LOC = IDELAYCTRL_X1Y1-IDELAYCTRL_X1Y3-IDELAYCTRL_X2Y2-IDELAYCTRL_X2Y3
>  PARAMETER C_TEMAC_TYPE = 1
>  PARAMETER C_BUS2CORE_CLK_RATIO = 1
>  PARAMETER C_BASEADDR = 0x81c00000
>  PARAMETER C_HIGHADDR = 0x81c0ffff
>  BUS_INTERFACE SPLB = plb
>  BUS_INTERFACE LLINK0 = TriMode_MAC_GMII_LLINK0
>  PORT GMII_TXD_0 = fpga_0_TriMode_MAC_GMII_GMII_TXD_0
>  PORT GMII_TX_EN_0 = fpga_0_TriMode_MAC_GMII_GMII_TX_EN_0
>  PORT GMII_TX_ER_0 = fpga_0_TriMode_MAC_GMII_GMII_TX_ER_0
>  PORT GMII_TX_CLK_0 = fpga_0_TriMode_MAC_GMII_GMII_TX_CLK_0
>  PORT GMII_RXD_0 = fpga_0_TriMode_MAC_GMII_GMII_RXD_0
>  PORT GMII_RX_DV_0 = fpga_0_TriMode_MAC_GMII_GMII_RX_DV_0
>  PORT GMII_RX_ER_0 = fpga_0_TriMode_MAC_GMII_GMII_RX_ER_0
>  PORT GMII_RX_CLK_0 = fpga_0_TriMode_MAC_GMII_GMII_RX_CLK_0
>  PORT MII_TX_CLK_0 = fpga_0_TriMode_MAC_GMII_MII_TX_CLK_0
>  PORT MDIO_0 = fpga_0_TriMode_MAC_GMII_MDIO_0
>  PORT MDC_0 = fpga_0_TriMode_MAC_GMII_MDC_0
>  PORT TemacPhy_RST_n = fpga_0_TriMode_MAC_GMII_TemacPhy_RST_n
>  PORT GTX_CLK_0 = temac_clk_s
>  PORT REFCLK = clk_200mhz_s
>  PORT LlinkTemac0_CLK = sys_clk_s
>  PORT TemacIntc0_Irpt = TriMode_MAC_GMII_TemacIntc0_Irpt
> END
> 
> BEGIN util_bus_split
>  PARAMETER INSTANCE = SysACE_CompactFlash_util_bus_split_0
>  PARAMETER HW_VER = 1.00.a
>  PARAMETER C_SIZE_IN = 7
>  PARAMETER C_LEFT_POS = 0
>  PARAMETER C_SPLIT = 6
>  PORT Sig = fpga_0_SysACE_CompactFlash_SysACE_MPA_split
>  PORT Out1 = fpga_0_SysACE_CompactFlash_SysACE_MPA
> END
> 
> BEGIN plb_v46
>  PARAMETER INSTANCE = ppc405_0_iplb1
>  PARAMETER HW_VER = 1.02.a
>  PORT PLB_Clk = sys_clk_s
>  PORT SYS_Rst = sys_bus_reset
> END
> 
> BEGIN plb_v46
>  PARAMETER INSTANCE = ppc405_0_dplb1
>  PARAMETER HW_VER = 1.02.a
>  PORT PLB_Clk = sys_clk_s
>  PORT SYS_Rst = sys_bus_reset
> END
> 
> BEGIN clock_generator
>  PARAMETER INSTANCE = clock_generator_0
>  PARAMETER HW_VER = 2.00.a
>  PARAMETER C_EXT_RESET_HIGH = 1
>  PARAMETER C_CLKIN_FREQ = 100000000
>  PARAMETER C_CLKOUT0_FREQ = 100000000
>  PARAMETER C_CLKOUT0_BUF = TRUE
>  PARAMETER C_CLKOUT0_PHASE = 0
>  PARAMETER C_CLKOUT0_GROUP = DCM0
>  PARAMETER C_CLKOUT1_FREQ = 100000000
>  PARAMETER C_CLKOUT1_BUF = TRUE
>  PARAMETER C_CLKOUT1_PHASE = 90
>  PARAMETER C_CLKOUT1_GROUP = DCM0
>  PARAMETER C_CLKOUT2_FREQ = 300000000
>  PARAMETER C_CLKOUT2_BUF = TRUE
>  PARAMETER C_CLKOUT2_PHASE = 0
>  PARAMETER C_CLKOUT2_GROUP = DCM0
>  PARAMETER C_CLKOUT3_FREQ = 200000000
>  PARAMETER C_CLKOUT3_BUF = TRUE
>  PARAMETER C_CLKOUT3_PHASE = 0
>  PARAMETER C_CLKOUT3_GROUP = NONE
>  PARAMETER C_CLKOUT4_FREQ = 125000000
>  PARAMETER C_CLKOUT4_BUF = TRUE
>  PARAMETER C_CLKOUT4_PHASE = 0
>  PARAMETER C_CLKOUT4_GROUP = NONE
>  PORT CLKOUT0 = sys_clk_s
>  PORT CLKOUT1 = DDR_SDRAM_mpmc_clk_90_s
>  PORT CLKOUT2 = proc_clk_s
>  PORT CLKOUT3 = clk_200mhz_s
>  PORT CLKOUT4 = temac_clk_s
>  PORT CLKIN = dcm_clk_s
>  PORT LOCKED = Dcm_all_locked
>  PORT RST = net_gnd
> END
> 
> BEGIN proc_sys_reset
>  PARAMETER INSTANCE = proc_sys_reset_0
>  PARAMETER HW_VER = 2.00.a
>  PARAMETER C_EXT_RESET_HIGH = 0
>  BUS_INTERFACE RESETPPC0 = ppc_reset_bus
>  PORT Slowest_sync_clk = sys_clk_s
>  PORT Dcm_locked = Dcm_all_locked
>  PORT Ext_Reset_In = sys_rst_s
>  PORT Bus_Struct_Reset = sys_bus_reset
>  PORT Peripheral_Reset = sys_periph_reset
> END
> 
> BEGIN xps_intc
>  PARAMETER INSTANCE = xps_intc_0
>  PARAMETER HW_VER = 1.00.a
>  PARAMETER C_BASEADDR = 0x81800000
>  PARAMETER C_HIGHADDR = 0x8180ffff
>  BUS_INTERFACE SPLB = plb
>  PORT Irq = EICC405EXTINPUTIRQ
>  PORT Intr = RS232_Uart_IP2INTC_Irpt & LEDs_4Bit_IP2INTC_Irpt & IIC_EEPROM_IIC2INTC_Irpt & SysACE_CompactFlash_SysACE_IRQ & TriMode_MAC_GMII_TemacIntc0_Irpt & DDR_SDRAM_SDMA2_Rx_IntOut & DDR_SDRAM_SDMA2_Tx_IntOut
> END
> 
> 
> 
> 	#address-cells = <1>;
> 	#size-cells = <1>;
> 	compatible = "xlnx,virtex";
> 	model = "testing";
> 	DDR_SDRAM: memory@0 {
> 		device_type = "memory";
> 		reg = < 0 8000000 >;
> 	} ;
> 	chosen {
> 		bootargs = "console=ttyS0,9600 ip=on nfsroot=172.16.40.76:/v2pclients/jhl26,tcp"; 
> 		linux,stdout-path = "/plb@0/serial@83e00000";
> 	} ;
> 	cpus {
> 		#address-cells = <1>;
> 		#cpus = <1>;
> 		#size-cells = <0>;
> 		ppc405_0: cpu@0 {
> 			clock-frequency = <11e1a300>;
> 			compatible = "PowerPC,405", "ibm,ppc405";
> 			d-cache-line-size = <20>;
> 			d-cache-size = <4000>;
> 			device_type = "cpu";
> 			i-cache-line-size = <20>;
> 			i-cache-size = <4000>;
> 			model = "PowerPC,405";
> 			reg = <0>;
> 			timebase-frequency = <11e1a300>;
> 			xlnx,apu-control = <de00>;
> 			xlnx,apu-udi-1 = <a18983>;
> 			xlnx,apu-udi-2 = <a38983>;
> 			xlnx,apu-udi-3 = <a589c3>;
> 			xlnx,apu-udi-4 = <a789c3>;
> 			xlnx,apu-udi-5 = <a98c03>;
> 			xlnx,apu-udi-6 = <ab8c03>;
> 			xlnx,apu-udi-7 = <ad8c43>;
> 			xlnx,apu-udi-8 = <af8c43>;
> 			xlnx,deterministic-mult = <0>;
> 			xlnx,disable-operand-forwarding = <1>;
> 			xlnx,fastest-plb-clock = "DPLB0";
> 			xlnx,generate-plb-timespecs = <1>;
> 			xlnx,mmu-enable = <1>;
> 			xlnx,pvr-high = <0>;
> 			xlnx,pvr-low = <0>;
> 		} ;
> 	} ;
> 	plb: plb@0 {
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		compatible = "xlnx,plb-v46-1.02.a";
> 		ranges ;
> 		IIC_EEPROM: i2c@81600000 {
> 			compatible = "xlnx,xps-iic-2.00.a";
> 			interrupt-parent = <&xps_intc_0>;
> 			interrupts = < 4 2 >;
> 			reg = < 81600000 10000 >;
> 			xlnx,clk-freq = <5f5e100>;
> 			xlnx,family = "virtex4";
> 			xlnx,gpo-width = <1>;
> 			xlnx,iic-freq = <186a0>;
> 			xlnx,scl-inertial-delay = <0>;
> 			xlnx,sda-inertial-delay = <0>;
> 			xlnx,ten-bit-adr = <0>;
> 		} ;
> 		LEDs_4Bit: gpio@81400000 {
> 			compatible = "xlnx,xps-gpio-1.00.a";
> 			interrupt-parent = <&xps_intc_0>;
> 			interrupts = < 5 2 >;
> 			reg = < 81400000 10000 >;
> 			xlnx,all-inputs = <0>;
> 			xlnx,all-inputs-2 = <0>;
> 			xlnx,dout-default = <0>;
> 			xlnx,dout-default-2 = <0>;
> 			xlnx,family = "virtex4";
> 			xlnx,gpio-width = <4>;
> 			xlnx,interrupt-present = <1>;
> 			xlnx,is-bidir = <1>;
> 			xlnx,is-bidir-2 = <1>;
> 			xlnx,is-dual = <0>;
> 			xlnx,tri-default = <ffffffff>;
> 			xlnx,tri-default-2 = <ffffffff>;
> 		} ;
> 		RS232_Uart: serial@83e00000 {
> 			compatible = "xlnx,xps-uart16550-2.00.a";
> //			compatible = "ns16550"; 
> 			device_type = "serial";
> 			interrupt-parent = <&xps_intc_0>; 
> 			interrupts = < 6 2 >; 
> 			reg = < 83e00000 10000 >;
> 			current-speed = <d#9600>;
> 			clock-frequency = <d#100000000>;  /* added by jhl */
> 			reg-shift = <2>;
> 			xlnx,family = "virtex4";
> 			xlnx,has-external-rclk = <0>;
> 			xlnx,has-external-xin = <0>;
> 			xlnx,is-a-16550 = <1>;
> 		} ;
> 		SysACE_CompactFlash: sysace@83600000 {
> 			compatible = "xlnx,xps-sysace-1.00.a";
> 			interrupt-parent = <&xps_intc_0>;
> 			interrupts = < 3 2 >;
> 			reg = < 83600000 10000 >;
> 			xlnx,family = "virtex4";
> 			xlnx,mem-width = <10>;
> 		} ;
> 		TriMode_MAC_GMII: xps-ll-temac@81c00000 {
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 			compatible = "xlnx,compound";
> 			ethernet@81c00000 {
> 				compatible = "xlnx,xps-ll-temac-1.01.a";
> 				device_type = "network";
> 				interrupt-parent = <&xps_intc_0>;
> 				interrupts = < 2 2 >;
> 				llink-connected = <&PIM2>;
> 				local-mac-address = [ 02 00 00 00 00 01 ];
> 				reg = < 81c00000 40 >;
> 				xlnx,bus2core-clk-ratio = <1>;
> 				xlnx,phy-type = <1>;
> 				xlnx,phyaddr = <1>;
> 				xlnx,rxcsum = <0>;
> 				xlnx,rxfifo = <1000>;
> 				xlnx,temac-type = <1>;
> 				xlnx,txcsum = <0>;
> 				xlnx,txfifo = <1000>;
> 			} ;
> 		} ;
> 		mpmc@0 {
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 			compatible = "xlnx,mpmc-4.00.a";
> 			PIM2: sdma@84600100 {
> 				compatible = "xlnx,ll-dma-1.00.a";
> 				interrupt-parent = <&xps_intc_0>;
> 				interrupts = < 1 2 0 2 >;
> 				reg = < 84600100 80 >;
> 			} ;
> 		} ;
> 		xps_bram_if_cntlr_1: xps-bram-if-cntlr@ffffe000 {
> 			compatible = "xlnx,xps-bram-if-cntlr-1.00.a";
> 			reg = < ffffe000 2000 >;
> 			xlnx,family = "virtex4";
> 		} ;
> 		xps_intc_0: interrupt-controller@81800000 {
> 			#interrupt-cells = <2>;
> 			compatible = "xlnx,xps-intc-1.00.a";
> 			interrupt-controller ;
> 			reg = < 81800000 10000 >;
> 			xlnx,num-intr-inputs = <7>;
> 		} ;
> 	} ;
> 	ppc405_0_dplb1: plb@1 {
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		compatible = "xlnx,plb-v46-1.02.a";
> 		ranges ;
> 	} ;
> }  ;
> 
> 
> 
> -----Original Message-----
> From: Magnus Hjorth [mailto:mh@omnisys.se] 
> Sent: Saturday, March 29, 2008 6:54 AM
> To: git
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Xilinx LLTEMAC driver issues
> 
> Hi,
> 
> I'm having some networking troubles with the Xilinx LLTEMAC driver from the
> Xilinx Linux git tree (powerpc arch) on an ML403 board. EDK9.2SP2,
> xps_ll_temac v1.00.b 
> 
> The weird thing is, that it sort of half works. It successfully makes a DHCP
> request and gets its IP address. I tried setting up a tftpd server, and I can
> see UDP requests coming in but the response doesn't seem to come out. I also
> tried running a TCP server on the board, and it can see and accept incoming
> connections but after that no data seems to get through. I can ping out and
> get around 40% packet loss.
> 
> Looking at /proc/interrupts, I can see both TxDma interrupts and RxDma
> interrupts. No eth0 interrupts but that seems to be OK judging by the driver
> source comments. Ifconfig shows no collistions, no dropped packets, no errors,
> so the system seems to think that everything is OK. 
> 
> Clues anyone? I'm starting to run out of ideas...
> 
> Best regards,
> Magnus
> 
> 
> --
> 
> Magnus Hjorth, M.Sc.
> Omnisys Instruments AB
> Gruvgatan 8
> SE-421 30  Västra Frölunda, SWEDEN
> Phone: +46 31 734 34 09
> Fax: +46 31 734 34 29
> http://www.omnisys.se
