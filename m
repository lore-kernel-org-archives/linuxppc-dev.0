Return-Path: <goudard@esrf.fr>
Received: from out.esrf.fr (firewall.ill.fr [193.49.43.1])
	by ozlabs.org (Postfix) with ESMTP id 5FC4567B9B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Nov 2006 00:17:28 +1100 (EST)
Subject: mhs files + xparameters<xxx>.h
From: Olivier Goudard <goudard@esrf.fr>
To: akonovalov@ru.mvista.com, linuxppc-embedded@ozlabs.org
Content-Type: multipart/mixed; boundary="=-4Bfe/x4KTBl/v5g0W2Pn"
Date: Mon, 27 Nov 2006 14:15:24 +0100
Message-Id: <1164633324.14559.5.camel@l-cb312-1>
Mime-Version: 1.0
Cc: andy.gotz@esrf.fr
Reply-To: goudard@esrf.fr
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-4Bfe/x4KTBl/v5g0W2Pn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello Andrei,

Here are the files you need to have a better understanding of our
design.
For the IP we are using with xilinx_char_lcd, I checked in IP catalog of
xps, but didn't see nothing about xilinx_char_lcd.

In the meantime I have modified the xilinx_lcd.c and excluded the access
to the lcd. Now I can boot sometimes. There seems to be a problem with
the network still. Sometimes we get a kernel panic after a while and
other times we do not boot at all. Here is an example of the output at
boottime :

loaded at:     00400000 004B61E4
board data at: 004B313C 004B3154
relocated to:  0040564C 00405664
zimage at:     00405C17 004B2022
avail ram:     004B7000 04000000

Linux/PPC load: console=ttyS0,9600 ip=on
nfsroot=192.168.219.54:/root/myDesign/rootfs rw
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.20_mvl31-2vp7fg456_rev4 (root@l-cb312-1) (gcc version
3.3.1 (MontaVista 3.3.1-3.0.106Memec Virtex-II Pro Development Board
Port (C) 2002-2004 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 ip=on
nfsroot=192.168.219.54:/root/myDesign/rootfs rw
Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000
hr_time_init: arch_to_nsec = 20971520, nsec_to_arch = 429496729
Calibrating delay loop... 99.73 BogoMIPS
Memory: 63072k available (1228k kernel code, 400k data, 60k init, 0k
highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
OCP uart ver 1.6.2 init complete
LSP Revision 28
ikconfig 0.5 with /proc/ikconfig
Starting kswapd
Disabling the Out Of Memory Killer
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.1. (C) 2001, 2002 Red Hat, Inc., designed by Axis
Communications AB.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with no serial options enabled
ttyS00 at 0xfdfff003 (irq = 26) is a 16450
xgpio #0 at 0x40000000 mapped to 0xC507D000
xgpio #1 at 0x40020000 mapped to 0xC508E000
xgpio #2 at 0x40040000 mapped to 0xC509F000
xgpio #3 at 0xC00BCA10 mapped to 0xC50B0A10
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
eth0: using fifo mode.
eth0: Xilinx EMAC #0 at 0x80400000 mapped to 0xC50C2000, irq=31
eth0: id 2.0a; block id 0, type 8
physmap flash device: 400000 at ff800000
NO QRY response
NO QRY response
CFI: Found no phys_mapped_flash device at location zero
kmod: failed to exec /sbin/modprobe -s -k jedec_probe, errno = 2
kmod: failed to exec /sbin/modprobe -s -k map_rom, errno = 2
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
Sending DHCP requests .<6>eth0: Link carrier lost.
..<3>eth0: Could not read PHY control register; error 1003
eth0: Terminating link monitoring.
...

Here is an example of a crash while trying to a dd default route entry :

$ busybox route add default gw 192.168.219.55Oops: Exception in kernel
mode, sig: 4
NIP: C03C9804 XER: 00000000 LR: C03C9800 SP: C0159DD0 REGS: c0159d20
TRAP: 0700    Not tainted
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0158020[0] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: C03C9800 C0159DD0 C0158020 00009030 00001030 00000102 C0180000
C01629F0
GPR08: C018250C C018250C C018250C 00000001 84002022 1002AB30 00000000
00000000
GPR16: 00000000 00000000 00000000 C0180000 68300001 00000000 C0180000
C0180000
GPR24: C0180000 C0180000 00000329 00005AC6 C0181E0C 00000000 C00E7960
00000000
Call backtrace:
C03C9800 C001B81C C001B698 C001B364 C0005FF4 C00047CC C002790C
C0005D88 C0005D9C C0002428 C016A5CC C0002328
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 <0>Rebooting in 180 seconds..

I you can shed some light on this problem, we would be yet again very
grateful 8-)

Best regards,
Olivier

--=-4Bfe/x4KTBl/v5g0W2Pn
Content-Disposition: attachment; filename=system.mhs
Content-Type: text/plain; name=system.mhs; charset=UTF-8
Content-Transfer-Encoding: 7bit

# ##############################################################################
# Created by Base System Builder Wizard for Xilinx EDK 8.1.02 Build EDK_I.20.4
# Fri Nov 24 09:51:11 2006
# Target Board:  Memec Virtex-4 FX12 LC Development Board Rev 1
# Family:	 virtex4
# Device:	 XC4VFX12
# Package:	 FF668
# Speed Grade:	 -10
# Processor: PPC 405
# Processor clock frequency: 100.000000 MHz
# Bus clock frequency: 100.000000 MHz
# Debug interface: FPGA JTAG
# On Chip Memory :  32 KB
# Total Off Chip Memory :  68 MB
# - FLASH2Mx16 =   4 MB
# - DDR_SDRAM_32Mx16 =  64 MB
# ##############################################################################


 PARAMETER VERSION = 2.1.0


 PORT fpga_0_RS232_sin_pin = fpga_0_RS232_sin, DIR = I
 PORT fpga_0_RS232_sout_pin = fpga_0_RS232_sout, DIR = O
 PORT fpga_0_RS232_rtsN_pin = fpga_0_RS232_rtsN, DIR = O
 PORT fpga_0_LEDs_4Bit_GPIO_d_out_pin = fpga_0_LEDs_4Bit_GPIO_d_out, DIR = O, VEC = [0:3]
 PORT fpga_0_Push_Buttons_3Bit_GPIO_in_pin = fpga_0_Push_Buttons_3Bit_GPIO_in, DIR = I, VEC = [0:2]
 PORT fpga_0_DIP_Switches_8Bit_GPIO_in_pin = fpga_0_DIP_Switches_8Bit_GPIO_in, DIR = I, VEC = [0:7]
 PORT fpga_0_DDR_SDRAM_32Mx16_DDR_Clk_pin = fpga_0_DDR_SDRAM_32Mx16_DDR_Clk, DIR = O
 PORT fpga_0_DDR_SDRAM_32Mx16_DDR_Clkn_pin = fpga_0_DDR_SDRAM_32Mx16_DDR_Clkn, DIR = O
 PORT fpga_0_DDR_SDRAM_32Mx16_DDR_Addr_pin = fpga_0_DDR_SDRAM_32Mx16_DDR_Addr, DIR = O, VEC = [0:12]
 PORT fpga_0_DDR_SDRAM_32Mx16_DDR_BankAddr_pin = fpga_0_DDR_SDRAM_32Mx16_DDR_BankAddr, DIR = O, VEC = [0:1]
 PORT fpga_0_DDR_SDRAM_32Mx16_DDR_CASn_pin = fpga_0_DDR_SDRAM_32Mx16_DDR_CASn, DIR = O
 PORT fpga_0_DDR_SDRAM_32Mx16_DDR_CKE_pin = fpga_0_DDR_SDRAM_32Mx16_DDR_CKE, DIR = O
 PORT fpga_0_DDR_SDRAM_32Mx16_DDR_CSn_pin = fpga_0_DDR_SDRAM_32Mx16_DDR_CSn, DIR = O
 PORT fpga_0_DDR_SDRAM_32Mx16_DDR_RASn_pin = fpga_0_DDR_SDRAM_32Mx16_DDR_RASn, DIR = O
 PORT fpga_0_DDR_SDRAM_32Mx16_DDR_WEn_pin = fpga_0_DDR_SDRAM_32Mx16_DDR_WEn, DIR = O
 PORT fpga_0_DDR_SDRAM_32Mx16_DDR_DM_pin = fpga_0_DDR_SDRAM_32Mx16_DDR_DM, DIR = O, VEC = [0:1]
 PORT fpga_0_DDR_SDRAM_32Mx16_DDR_DQS_pin = fpga_0_DDR_SDRAM_32Mx16_DDR_DQS, DIR = IO, VEC = [0:1]
 PORT fpga_0_DDR_SDRAM_32Mx16_DDR_DQ_pin = fpga_0_DDR_SDRAM_32Mx16_DDR_DQ, DIR = IO, VEC = [0:15]
 PORT fpga_0_FLASH_2Mx16_Mem_A_pin = fpga_0_FLASH_2Mx16_Mem_A, DIR = O, VEC = [10:30]
 PORT fpga_0_FLASH_2Mx16_Mem_DQ_pin = fpga_0_FLASH_2Mx16_Mem_DQ, DIR = IO, VEC = [0:15]
 PORT fpga_0_FLASH_2Mx16_Mem_OEN_pin = fpga_0_FLASH_2Mx16_Mem_OEN, DIR = O, VEC = [0:0]
 PORT fpga_0_Flash_And_Gate_Res_pin = fpga_0_Flash_And_Gate_Res, DIR = O
 PORT fpga_0_FLASH_2Mx16_Mem_WEN_pin = fpga_0_FLASH_2Mx16_Mem_WEN, DIR = O
 PORT fpga_0_FLASH_2Mx16_vpp_dummy_pin = net_vcc, DIR = O
 PORT fpga_0_FLASH_2Mx16_Mem_RPN_pin = fpga_0_FLASH_2Mx16_Mem_RPN, DIR = O
 PORT fpga_0_FLASH_READY_GPIO_in_pin = fpga_0_FLASH_READY_GPIO_in, DIR = I, VEC = [0:0]
 PORT fpga_0_Ethernet_MAC_PHY_tx_er_pin = fpga_0_Ethernet_MAC_PHY_tx_er, DIR = O
 PORT fpga_0_Ethernet_MAC_PHY_tx_clk_pin = fpga_0_Ethernet_MAC_PHY_tx_clk, DIR = I
 PORT fpga_0_Ethernet_MAC_PHY_rx_clk_pin = fpga_0_Ethernet_MAC_PHY_rx_clk, DIR = I
 PORT fpga_0_Ethernet_MAC_PHY_crs_pin = fpga_0_Ethernet_MAC_PHY_crs, DIR = I
 PORT fpga_0_Ethernet_MAC_PHY_dv_pin = fpga_0_Ethernet_MAC_PHY_dv, DIR = I
 PORT fpga_0_Ethernet_MAC_PHY_rx_data_pin = fpga_0_Ethernet_MAC_PHY_rx_data, DIR = I, VEC = [3:0]
 PORT fpga_0_Ethernet_MAC_PHY_col_pin = fpga_0_Ethernet_MAC_PHY_col, DIR = I
 PORT fpga_0_Ethernet_MAC_PHY_rx_er_pin = fpga_0_Ethernet_MAC_PHY_rx_er, DIR = I
 PORT fpga_0_Ethernet_MAC_PHY_tx_en_pin = fpga_0_Ethernet_MAC_PHY_tx_en, DIR = O
 PORT fpga_0_Ethernet_MAC_PHY_tx_data_pin = fpga_0_Ethernet_MAC_PHY_tx_data, DIR = O, VEC = [3:0]
 PORT fpga_0_Ethernet_MAC_PHY_Mii_clk_pin = fpga_0_Ethernet_MAC_PHY_Mii_clk, DIR = IO
 PORT fpga_0_Ethernet_MAC_PHY_rst_n_pin = fpga_0_Ethernet_MAC_PHY_rst_n, DIR = O
 PORT fpga_0_Ethernet_MAC_PHY_Mii_data_pin = fpga_0_Ethernet_MAC_PHY_Mii_data, DIR = IO
 PORT fpga_0_DDR_CLK_FB = ddr_feedback_s, DIR = I, SIGIS = DCMCLK
 PORT sys_clk_pin = dcm_clk_s, DIR = I, SIGIS = DCMCLK
 PORT sys_rst_pin = sys_rst_s, DIR = I


BEGIN ppc405_virtex4
 PARAMETER INSTANCE = ppc405_0
 PARAMETER HW_VER = 1.01.a
 BUS_INTERFACE JTAGPPC = jtagppc_0_0
 BUS_INTERFACE IPLB = plb
 BUS_INTERFACE DPLB = plb
 PORT PLBCLK = sys_clk_s
 PORT C405RSTCHIPRESETREQ = C405RSTCHIPRESETREQ
 PORT C405RSTCORERESETREQ = C405RSTCORERESETREQ
 PORT C405RSTSYSRESETREQ = C405RSTSYSRESETREQ
 PORT RSTC405RESETCHIP = RSTC405RESETCHIP
 PORT RSTC405RESETCORE = RSTC405RESETCORE
 PORT RSTC405RESETSYS = RSTC405RESETSYS
 PORT EICC405EXTINPUTIRQ = EICC405EXTINPUTIRQ
 PORT CPMC405CLOCK = sys_clk_s
END

BEGIN jtagppc_cntlr
 PARAMETER INSTANCE = jtagppc_0
 PARAMETER HW_VER = 2.00.a
 BUS_INTERFACE JTAGPPC0 = jtagppc_0_0
END

BEGIN proc_sys_reset
 PARAMETER INSTANCE = reset_block
 PARAMETER HW_VER = 1.00.a
 PARAMETER C_EXT_RESET_HIGH = 0
 PORT Ext_Reset_In = sys_rst_s
 PORT Slowest_sync_clk = sys_clk_s
 PORT Chip_Reset_Req = C405RSTCHIPRESETREQ
 PORT Core_Reset_Req = C405RSTCORERESETREQ
 PORT System_Reset_Req = C405RSTSYSRESETREQ
 PORT Rstc405resetchip = RSTC405RESETCHIP
 PORT Rstc405resetcore = RSTC405RESETCORE
 PORT Rstc405resetsys = RSTC405RESETSYS
 PORT Bus_Struct_Reset = sys_bus_reset
 PORT Dcm_locked = dcm_1_lock
END

BEGIN plb_v34
 PARAMETER INSTANCE = plb
 PARAMETER HW_VER = 1.02.a
 PARAMETER C_DCR_INTFCE = 0
 PARAMETER C_EXT_RESET_HIGH = 1
 PORT SYS_Rst = sys_bus_reset
 PORT PLB_Clk = sys_clk_s
END

BEGIN opb_v20
 PARAMETER INSTANCE = opb
 PARAMETER HW_VER = 1.10.c
 PARAMETER C_EXT_RESET_HIGH = 1
 PORT SYS_Rst = sys_bus_reset
 PORT OPB_Clk = sys_clk_s
END

BEGIN plb2opb_bridge
 PARAMETER INSTANCE = plb2opb
 PARAMETER HW_VER = 1.01.a
 PARAMETER C_DCR_INTFCE = 0
 PARAMETER C_NUM_ADDR_RNG = 1
 PARAMETER C_RNG0_BASEADDR = 0x00000000
 PARAMETER C_RNG0_HIGHADDR = 0x7fffffff
 BUS_INTERFACE SPLB = plb
 BUS_INTERFACE MOPB = opb
 PORT PLB_Clk = sys_clk_s
 PORT OPB_Clk = sys_clk_s
END

BEGIN opb_uart16550
 PARAMETER INSTANCE = RS232
 PARAMETER HW_VER = 1.00.d
 PARAMETER C_IS_A_16550 = 0
 PARAMETER C_BASEADDR = 0x40400000
 PARAMETER C_HIGHADDR = 0x4040ffff
 BUS_INTERFACE SOPB = opb
 PORT OPB_Clk = sys_clk_s
 PORT IP2INTC_Irpt = RS232_IP2INTC_Irpt
 PORT sin = fpga_0_RS232_sin
 PORT sout = fpga_0_RS232_sout
 PORT rtsN = fpga_0_RS232_rtsN
END

BEGIN plb_ethernet
 PARAMETER INSTANCE = Ethernet_MAC
 PARAMETER HW_VER = 1.01.a
 PARAMETER C_DMA_PRESENT = 1
 PARAMETER C_IPIF_FIFO_DEPTH = 32768
 PARAMETER C_PLB_CLK_PERIOD_PS = 10000
 PARAMETER C_BASEADDR = 0x80400000
 PARAMETER C_HIGHADDR = 0x8040ffff
 BUS_INTERFACE SPLB = plb
 PORT PLB_Clk = sys_clk_s
 PORT IP2INTC_Irpt = Ethernet_MAC_IP2INTC_Irpt
 PORT PHY_tx_er = fpga_0_Ethernet_MAC_PHY_tx_er
 PORT PHY_tx_clk = fpga_0_Ethernet_MAC_PHY_tx_clk
 PORT PHY_rx_clk = fpga_0_Ethernet_MAC_PHY_rx_clk
 PORT PHY_crs = fpga_0_Ethernet_MAC_PHY_crs
 PORT PHY_dv = fpga_0_Ethernet_MAC_PHY_dv
 PORT PHY_rx_data = fpga_0_Ethernet_MAC_PHY_rx_data
 PORT PHY_col = fpga_0_Ethernet_MAC_PHY_col
 PORT PHY_rx_er = fpga_0_Ethernet_MAC_PHY_rx_er
 PORT PHY_tx_en = fpga_0_Ethernet_MAC_PHY_tx_en
 PORT PHY_tx_data = fpga_0_Ethernet_MAC_PHY_tx_data
 PORT PHY_Mii_clk = fpga_0_Ethernet_MAC_PHY_Mii_clk
 PORT PHY_rst_n = fpga_0_Ethernet_MAC_PHY_rst_n
 PORT PHY_Mii_data = fpga_0_Ethernet_MAC_PHY_Mii_data
END

BEGIN opb_gpio
 PARAMETER INSTANCE = LEDs_4Bit
 PARAMETER HW_VER = 3.01.b
 PARAMETER C_INTERRUPT_PRESENT = 1
 PARAMETER C_GPIO_WIDTH = 4
 PARAMETER C_IS_DUAL = 0
 PARAMETER C_ALL_INPUTS = 0
 PARAMETER C_IS_BIDIR = 0
 PARAMETER C_BASEADDR = 0x40000000
 PARAMETER C_HIGHADDR = 0x4000ffff
 BUS_INTERFACE SOPB = opb
 PORT OPB_Clk = sys_clk_s
 PORT IP2INTC_Irpt = LEDs_4Bit_IP2INTC_Irpt
 PORT GPIO_d_out = fpga_0_LEDs_4Bit_GPIO_d_out
END

BEGIN opb_gpio
 PARAMETER INSTANCE = Push_Buttons_3Bit
 PARAMETER HW_VER = 3.01.b
 PARAMETER C_INTERRUPT_PRESENT = 1
 PARAMETER C_GPIO_WIDTH = 3
 PARAMETER C_IS_DUAL = 0
 PARAMETER C_IS_BIDIR = 0
 PARAMETER C_ALL_INPUTS = 1
 PARAMETER C_BASEADDR = 0x40020000
 PARAMETER C_HIGHADDR = 0x4002ffff
 BUS_INTERFACE SOPB = opb
 PORT OPB_Clk = sys_clk_s
 PORT IP2INTC_Irpt = Push_Buttons_3Bit_IP2INTC_Irpt
 PORT GPIO_in = fpga_0_Push_Buttons_3Bit_GPIO_in
END

BEGIN opb_gpio
 PARAMETER INSTANCE = DIP_Switches_8Bit
 PARAMETER HW_VER = 3.01.b
 PARAMETER C_INTERRUPT_PRESENT = 1
 PARAMETER C_GPIO_WIDTH = 8
 PARAMETER C_IS_DUAL = 0
 PARAMETER C_IS_BIDIR = 0
 PARAMETER C_ALL_INPUTS = 1
 PARAMETER C_BASEADDR = 0x40040000
 PARAMETER C_HIGHADDR = 0x4004ffff
 BUS_INTERFACE SOPB = opb
 PORT OPB_Clk = sys_clk_s
 PORT IP2INTC_Irpt = DIP_Switches_8Bit_IP2INTC_Irpt
 PORT GPIO_in = fpga_0_DIP_Switches_8Bit_GPIO_in
END

BEGIN opb_gpio
 PARAMETER INSTANCE = FLASH_READY
 PARAMETER HW_VER = 3.01.b
 PARAMETER C_INTERRUPT_PRESENT = 1
 PARAMETER C_GPIO_WIDTH = 1
 PARAMETER C_IS_DUAL = 0
 PARAMETER C_ALL_INPUTS = 1
 PARAMETER C_IS_BIDIR = 0
 PARAMETER C_BASEADDR = 0x40060000
 PARAMETER C_HIGHADDR = 0x4006ffff
 BUS_INTERFACE SOPB = opb
 PORT OPB_Clk = sys_clk_s
 PORT IP2INTC_Irpt = FLASH_READY_IP2INTC_Irpt
 PORT GPIO_in = fpga_0_FLASH_READY_GPIO_in
END

BEGIN plb_emc
 PARAMETER INSTANCE = FLASH_2Mx16
 PARAMETER HW_VER = 2.00.a
 PARAMETER C_PLB_CLK_PERIOD_PS = 10000
 PARAMETER C_NUM_BANKS_MEM = 1
 PARAMETER C_INCLUDE_DATAWIDTH_MATCHING_0 = 1
 PARAMETER C_INCLUDE_BURST_CACHELN_SUPPORT = 1
 PARAMETER C_SYNCH_MEM_0 = 0
 PARAMETER C_MEM0_WIDTH = 16
 PARAMETER C_MAX_MEM_WIDTH = 16
 PARAMETER C_TCEDV_PS_MEM_0 = 90000
 PARAMETER C_TWC_PS_MEM_0 = 40000
 PARAMETER C_TAVDV_PS_MEM_0 = 90000
 PARAMETER C_TWP_PS_MEM_0 = 40000
 PARAMETER C_THZCE_PS_MEM_0 = 10000
 PARAMETER C_TLZWE_PS_MEM_0 = 10000
 PARAMETER C_MEM0_BASEADDR = 0xff800000
 PARAMETER C_MEM0_HIGHADDR = 0xffbfffff
 BUS_INTERFACE SPLB = plb
 PORT PLB_Clk = sys_clk_s
 PORT Mem_A = fpga_0_FLASH_2Mx16_Mem_A_split
 PORT Mem_DQ = fpga_0_FLASH_2Mx16_Mem_DQ
 PORT Mem_WEN = fpga_0_FLASH_2Mx16_Mem_WEN
 PORT Mem_OEN = fpga_0_FLASH_2Mx16_Mem_OEN
 PORT Mem_BEN = FLASH_2Mx16_Mem_BEN_Flash_And_Gate_Op1
 PORT Mem_RPN = fpga_0_FLASH_2Mx16_Mem_RPN
END

BEGIN opb_ddr
 PARAMETER INSTANCE = DDR_SDRAM_32Mx16
 PARAMETER HW_VER = 2.00.b
 PARAMETER C_OPB_CLK_PERIOD_PS = 10000
 PARAMETER C_REG_DIMM = 0
 PARAMETER C_DDR_TMRD = 15000
 PARAMETER C_DDR_TWR = 15000
 PARAMETER C_DDR_TWTR = 1
 PARAMETER C_DDR_TRAS = 40000
 PARAMETER C_DDR_TRC = 65000
 PARAMETER C_DDR_TRFC = 75000
 PARAMETER C_DDR_TRCD = 20000
 PARAMETER C_DDR_TRRD = 15000
 PARAMETER C_DDR_TRP = 20000
 PARAMETER C_DDR_TREFC = 70300
 PARAMETER C_DDR_TREFI = 7800000
 PARAMETER C_DDR_DWIDTH = 16
 PARAMETER C_DDR_AWIDTH = 13
 PARAMETER C_DDR_COL_AWIDTH = 10
 PARAMETER C_DDR_BANK_AWIDTH = 2
 PARAMETER C_MEM0_BASEADDR = 0x00000000
 PARAMETER C_MEM0_HIGHADDR = 0x03ffffff
 BUS_INTERFACE SOPB = opb
 PORT OPB_Clk = sys_clk_s
 PORT DDR_Clk = fpga_0_DDR_SDRAM_32Mx16_DDR_Clk
 PORT DDR_Clkn = fpga_0_DDR_SDRAM_32Mx16_DDR_Clkn
 PORT DDR_Addr = fpga_0_DDR_SDRAM_32Mx16_DDR_Addr
 PORT DDR_BankAddr = fpga_0_DDR_SDRAM_32Mx16_DDR_BankAddr
 PORT DDR_CASn = fpga_0_DDR_SDRAM_32Mx16_DDR_CASn
 PORT DDR_CKE = fpga_0_DDR_SDRAM_32Mx16_DDR_CKE
 PORT DDR_CSn = fpga_0_DDR_SDRAM_32Mx16_DDR_CSn
 PORT DDR_RASn = fpga_0_DDR_SDRAM_32Mx16_DDR_RASn
 PORT DDR_WEn = fpga_0_DDR_SDRAM_32Mx16_DDR_WEn
 PORT DDR_DM = fpga_0_DDR_SDRAM_32Mx16_DDR_DM
 PORT DDR_DQS = fpga_0_DDR_SDRAM_32Mx16_DDR_DQS
 PORT DDR_DQ = fpga_0_DDR_SDRAM_32Mx16_DDR_DQ
 PORT Device_Clk90_in = clk_90_s
 PORT Device_Clk90_in_n = clk_90_n_s
 PORT Device_Clk = sys_clk_s
 PORT Device_Clk_n = sys_clk_n_s
 PORT DDR_Clk90_in = ddr_clk_90_s
 PORT DDR_Clk90_in_n = ddr_clk_90_n_s
END

BEGIN plb_bram_if_cntlr
 PARAMETER INSTANCE = plb_bram_if_cntlr_1
 PARAMETER HW_VER = 1.00.b
 PARAMETER c_plb_clk_period_ps = 10000
 PARAMETER c_baseaddr = 0xffff8000
 PARAMETER c_highaddr = 0xffffffff
 BUS_INTERFACE SPLB = plb
 BUS_INTERFACE PORTA = plb_bram_if_cntlr_1_port
 PORT PLB_Clk = sys_clk_s
END

BEGIN bram_block
 PARAMETER INSTANCE = plb_bram_if_cntlr_1_bram
 PARAMETER HW_VER = 1.00.a
 BUS_INTERFACE PORTA = plb_bram_if_cntlr_1_port
END

BEGIN opb_intc
 PARAMETER INSTANCE = opb_intc_0
 PARAMETER HW_VER = 1.00.c
 PARAMETER C_BASEADDR = 0x41200000
 PARAMETER C_HIGHADDR = 0x4120ffff
 BUS_INTERFACE SOPB = opb
 PORT Irq = EICC405EXTINPUTIRQ
 PORT Intr = RS232_IP2INTC_Irpt & LEDs_4Bit_IP2INTC_Irpt & Push_Buttons_3Bit_IP2INTC_Irpt & DIP_Switches_8Bit_IP2INTC_Irpt & FLASH_READY_IP2INTC_Irpt & Ethernet_MAC_IP2INTC_Irpt
END

BEGIN util_reduced_logic
 PARAMETER INSTANCE = Flash_And_Gate
 PARAMETER HW_VER = 1.00.a
 PARAMETER C_OPERATION = and
 PARAMETER C_SIZE = 2
 PORT Op1 = FLASH_2Mx16_Mem_BEN_Flash_And_Gate_Op1
 PORT Res = fpga_0_Flash_And_Gate_Res
END

BEGIN util_bus_split
 PARAMETER INSTANCE = FLASH_2Mx16_util_bus_split_0
 PARAMETER HW_VER = 1.00.a
 PARAMETER C_SIZE_IN = 32
 PARAMETER C_LEFT_POS = 10
 PARAMETER C_SPLIT = 31
 PORT Sig = fpga_0_FLASH_2Mx16_Mem_A_split
 PORT Out1 = fpga_0_FLASH_2Mx16_Mem_A
END

BEGIN util_vector_logic
 PARAMETER INSTANCE = sysclk_inv
 PARAMETER HW_VER = 1.00.a
 PARAMETER C_SIZE = 1
 PARAMETER C_OPERATION = not
 PORT Op1 = sys_clk_s
 PORT Res = sys_clk_n_s
END

BEGIN util_vector_logic
 PARAMETER INSTANCE = clk90_inv
 PARAMETER HW_VER = 1.00.a
 PARAMETER C_SIZE = 1
 PARAMETER C_OPERATION = not
 PORT Op1 = clk_90_s
 PORT Res = clk_90_n_s
END

BEGIN util_vector_logic
 PARAMETER INSTANCE = ddr_clk90_inv
 PARAMETER HW_VER = 1.00.a
 PARAMETER C_SIZE = 1
 PARAMETER C_OPERATION = not
 PORT Op1 = ddr_clk_90_s
 PORT Res = ddr_clk_90_n_s
END

BEGIN dcm_module
 PARAMETER INSTANCE = dcm_0
 PARAMETER HW_VER = 1.00.a
 PARAMETER C_CLK0_BUF = TRUE
 PARAMETER C_CLK90_BUF = TRUE
 PARAMETER C_CLKIN_PERIOD = 10.000000
 PARAMETER C_CLK_FEEDBACK = 1X
 PARAMETER C_DLL_FREQUENCY_MODE = LOW
 PARAMETER C_EXT_RESET_HIGH = 1
 PORT CLKIN = dcm_clk_s
 PORT CLK0 = sys_clk_s
 PORT CLK90 = clk_90_s
 PORT CLKFB = sys_clk_s
 PORT RST = net_gnd
 PORT LOCKED = dcm_0_lock
END

BEGIN dcm_module
 PARAMETER INSTANCE = dcm_1
 PARAMETER HW_VER = 1.00.a
 PARAMETER C_CLK0_BUF = TRUE
 PARAMETER C_CLK90_BUF = TRUE
 PARAMETER C_CLKIN_PERIOD = 10.000000
 PARAMETER C_CLK_FEEDBACK = 1X
 PARAMETER C_DLL_FREQUENCY_MODE = LOW
 PARAMETER C_EXT_RESET_HIGH = 0
 PORT CLKIN = ddr_feedback_s
 PORT CLK90 = ddr_clk_90_s
 PORT CLK0 = dcm_1_FB
 PORT CLKFB = dcm_1_FB
 PORT RST = dcm_0_lock
 PORT LOCKED = dcm_1_lock
END


--=-4Bfe/x4KTBl/v5g0W2Pn
Content-Disposition: attachment; filename=xparameters.h
Content-Type: text/x-chdr; name=xparameters.h; charset=UTF-8
Content-Transfer-Encoding: 7bit

/*
 * xparameters.h
 *
 * This file includes the correct xparameters.h for the CONFIG'ed board
 *
 * Author: MontaVista Software, Inc.
 *         source@mvista.com
 *
 * 2002 (c) MontaVista, Software, Inc.  This file is licensed under the terms
 * of the GNU General Public License version 2.  This program is licensed
 * "as is" without any warranty of any kind, whether express or implied.
 */

#include <linux/config.h>

#if defined(CONFIG_XILINX_ML300)
#include "xparameters_ml300.h"
#endif

#if defined(CONFIG_MEMEC_2VPX)
#include "xparameters_2vpx.h"
#endif

--=-4Bfe/x4KTBl/v5g0W2Pn
Content-Disposition: attachment; filename=xparameters_2vpx.h
Content-Type: text/x-chdr; name=xparameters_2vpx.h; charset=UTF-8
Content-Transfer-Encoding: 7bit


/*******************************************************************
*
* CAUTION: This file is automatically generated by libgen.
* Version: Xilinx EDK 8.1.02 EDK_I.20.4
* DO NOT EDIT.
*
* Copyright (c) 2005 Xilinx, Inc.  All rights reserved. 
* 
* Description: Driver parameters
*
*******************************************************************/

#define XPAR_XPLBARB_NUM_INSTANCES 1
#define XPAR_PLB_BASEADDR 0x00000000
#define XPAR_PLB_HIGHADDR 0x00000000
#define XPAR_PLB_DEVICE_ID 0
#define XPAR_PLB_PLB_NUM_MASTERS 2

/******************************************************************/

#define XPAR_XOPBARB_NUM_INSTANCES 1
#define XPAR_OPB_BASEADDR 0xFFFFFFFF
#define XPAR_OPB_HIGHADDR 0x00000000
#define XPAR_OPB_DEVICE_ID 0
#define XPAR_OPB_NUM_MASTERS 1

/******************************************************************/

#define XPAR_XUARTNS550_NUM_INSTANCES 1
#define XPAR_XUARTNS550_CLOCK_HZ 100000000
#define XPAR_RS232_BASEADDR 0x40400000
#define XPAR_RS232_HIGHADDR 0x4040FFFF
#define XPAR_RS232_DEVICE_ID 0

/******************************************************************/

#define XPAR_XGPIO_NUM_INSTANCES 4
#define XPAR_LEDS_4BIT_BASEADDR 0x40000000
#define XPAR_LEDS_4BIT_HIGHADDR 0x4000FFFF
#define XPAR_LEDS_4BIT_DEVICE_ID 0
#define XPAR_PUSH_BUTTONS_3BIT_BASEADDR 0x40020000
#define XPAR_PUSH_BUTTONS_3BIT_HIGHADDR 0x4002FFFF
#define XPAR_PUSH_BUTTONS_3BIT_DEVICE_ID 1
#define XPAR_DIP_SWITCHES_8BIT_BASEADDR 0x40040000
#define XPAR_DIP_SWITCHES_8BIT_HIGHADDR 0x4004FFFF
#define XPAR_DIP_SWITCHES_8BIT_DEVICE_ID 2
#define XPAR_FLASH_READY_BASEADDR 0x40060000
#define XPAR_FLASH_READY_HIGHADDR 0x4006FFFF
#define XPAR_FLASH_READY_DEVICE_ID 3

/******************************************************************/

#define XPAR_DDR_SDRAM_32MX16_MEM0_BASEADDR 0x00000000
#define XPAR_DDR_SDRAM_32MX16_MEM0_HIGHADDR 0x03FFFFFF

/******************************************************************/

#define XPAR_INTC_MAX_NUM_INTR_INPUTS 6
#define XPAR_XINTC_HAS_IPR 1
#define XPAR_XINTC_USE_DCR 0
#define XPAR_XINTC_NUM_INSTANCES 1
#define XPAR_OPB_INTC_0_BASEADDR 0x41200000
#define XPAR_OPB_INTC_0_HIGHADDR 0x4120FFFF
#define XPAR_OPB_INTC_0_DEVICE_ID 0
#define XPAR_OPB_INTC_0_KIND_OF_INTR 0x00000000

/******************************************************************/

#define XPAR_INTC_SINGLE_BASEADDR 0x41200000
#define XPAR_INTC_SINGLE_HIGHADDR 0x4120FFFF
#define XPAR_INTC_SINGLE_DEVICE_ID XPAR_OPB_INTC_0_DEVICE_ID
#define XPAR_ETHERNET_MAC_IP2INTC_IRPT_MASK 0X000001
#define XPAR_OPB_INTC_0_ETHERNET_MAC_IP2INTC_IRPT_INTR 0
#define XPAR_FLASH_READY_IP2INTC_IRPT_MASK 0X000002
#define XPAR_OPB_INTC_0_FLASH_READY_IP2INTC_IRPT_INTR 1
#define XPAR_DIP_SWITCHES_8BIT_IP2INTC_IRPT_MASK 0X000004
#define XPAR_OPB_INTC_0_DIP_SWITCHES_8BIT_IP2INTC_IRPT_INTR 2
#define XPAR_PUSH_BUTTONS_3BIT_IP2INTC_IRPT_MASK 0X000008
#define XPAR_OPB_INTC_0_PUSH_BUTTONS_3BIT_IP2INTC_IRPT_INTR 3
#define XPAR_LEDS_4BIT_IP2INTC_IRPT_MASK 0X000010
#define XPAR_OPB_INTC_0_LEDS_4BIT_IP2INTC_IRPT_INTR 4
#define XPAR_RS232_IP2INTC_IRPT_MASK 0X000020
#define XPAR_OPB_INTC_0_RS232_IP2INTC_IRPT_INTR 5

/******************************************************************/

#define XPAR_XEMAC_NUM_INSTANCES 1
#define XPAR_ETHERNET_MAC_BASEADDR 0x80400000
#define XPAR_ETHERNET_MAC_HIGHADDR 0x8040FFFF
#define XPAR_ETHERNET_MAC_DEVICE_ID 0
#define XPAR_ETHERNET_MAC_ERR_COUNT_EXIST 1
#define XPAR_ETHERNET_MAC_DMA_PRESENT 1
#define XPAR_ETHERNET_MAC_MII_EXIST 1

/******************************************************************/

#define XPAR_FLASH_2MX16_NUM_BANKS_MEM 1

/* copied from xparameters_2vpx.h.orig file */

#define XPAR_XEMC_NUM_INSTANCES 1
#define XPAR_FLASH_2MX32_BASEADDR 0xFE804000
#define XPAR_FLASH_2MX32_HIGHADDR 0xFE80401F
#define XPAR_FLASH_2MX32_DEVICE_ID 0
#define XPAR_FLASH_2MX32_NUM_BANKS_MEM 1

/******************************************************************/

#define XPAR_FLASH_2MX16_MEM0_BASEADDR 0xFF800000
#define XPAR_FLASH_2MX16_MEM0_HIGHADDR 0xFFBFFFFF

/******************************************************************/

#define XPAR_PLB_BRAM_IF_CNTLR_1_BASEADDR 0xffff8000
#define XPAR_PLB_BRAM_IF_CNTLR_1_HIGHADDR 0xffffffff

/******************************************************************/

#define XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ 100000000

/******************************************************************/


/******************************************************************/

/* Linux Redefines */

/******************************************************************/

#define XPAR_UARTNS550_0_BASEADDR (XPAR_RS232_BASEADDR+0x1000)
#define XPAR_UARTNS550_0_HIGHADDR XPAR_RS232_HIGHADDR
#define XPAR_UARTNS550_0_CLOCK_FREQ_HZ XPAR_XUARTNS550_CLOCK_HZ
#define XPAR_UARTNS550_0_DEVICE_ID XPAR_RS232_DEVICE_ID

/******************************************************************/

#define XPAR_EMAC_0_BASEADDR XPAR_ETHERNET_MAC_BASEADDR
#define XPAR_EMAC_0_HIGHADDR XPAR_ETHERNET_MAC_HIGHADDR
#define XPAR_EMAC_0_DMA_PRESENT XPAR_ETHERNET_MAC_DMA_PRESENT
#define XPAR_EMAC_0_MII_EXIST XPAR_ETHERNET_MAC_MII_EXIST
#define XPAR_EMAC_0_ERR_COUNT_EXIST XPAR_ETHERNET_MAC_ERR_COUNT_EXIST
#define XPAR_EMAC_0_DEVICE_ID XPAR_ETHERNET_MAC_DEVICE_ID

/******************************************************************/

#define XPAR_GPIO_0_BASEADDR XPAR_LEDS_4BIT_BASEADDR
#define XPAR_GPIO_0_HIGHADDR XPAR_LEDS_4BIT_HIGHADDR
#define XPAR_GPIO_0_DEVICE_ID XPAR_LEDS_4BIT_DEVICE_ID
#define XPAR_GPIO_1_BASEADDR XPAR_PUSH_BUTTONS_3BIT_BASEADDR
#define XPAR_GPIO_1_HIGHADDR XPAR_PUSH_BUTTONS_3BIT_HIGHADDR
#define XPAR_GPIO_1_DEVICE_ID XPAR_PUSH_BUTTONS_3BIT_DEVICE_ID
#define XPAR_GPIO_2_BASEADDR XPAR_DIP_SWITCHES_8BIT_BASEADDR
#define XPAR_GPIO_2_HIGHADDR XPAR_DIP_SWITCHES_8BIT_HIGHADDR
#define XPAR_GPIO_2_DEVICE_ID XPAR_DIP_SWITCHES_8BIT_DEVICE_ID
#define XPAR_GPIO_3_BASEADDR XPAR_FLASH_READY_BASEADDR
#define XPAR_GPIO_3_HIGHADDR XPAR_FLASH_READY_HIGHADDR
#define XPAR_GPIO_3_DEVICE_ID XPAR_FLASH_READY_DEVICE_ID

/******************************************************************/

#define XPAR_INTC_0_BASEADDR XPAR_OPB_INTC_0_BASEADDR
#define XPAR_INTC_0_HIGHADDR XPAR_OPB_INTC_0_HIGHADDR
#define XPAR_INTC_0_KIND_OF_INTR XPAR_OPB_INTC_0_KIND_OF_INTR
#define XPAR_INTC_0_DEVICE_ID XPAR_OPB_INTC_0_DEVICE_ID

/******************************************************************/

#define XPAR_INTC_0_EMAC_0_VEC_ID XPAR_OPB_INTC_0_ETHERNET_MAC_IP2INTC_IRPT_INTR
#define XPAR_INTC_0_GPIO_3_VEC_ID XPAR_OPB_INTC_0_FLASH_READY_IP2INTC_IRPT_INTR
#define XPAR_INTC_0_GPIO_2_VEC_ID XPAR_OPB_INTC_0_DIP_SWITCHES_8BIT_IP2INTC_IRPT_INTR
#define XPAR_INTC_0_GPIO_1_VEC_ID XPAR_OPB_INTC_0_PUSH_BUTTONS_3BIT_IP2INTC_IRPT_INTR
#define XPAR_INTC_0_GPIO_0_VEC_ID XPAR_OPB_INTC_0_LEDS_4BIT_IP2INTC_IRPT_INTR
#define XPAR_INTC_0_UARTNS550_0_VEC_ID XPAR_OPB_INTC_0_RS232_IP2INTC_IRPT_INTR

/******************************************************************/

#define XPAR_PLB_CLOCK_FREQ_HZ 100000000
#define XPAR_CORE_CLOCK_FREQ_HZ XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ
#define XPAR_DDR_0_SIZE 0x4000000

/******************************************************************/

#define XPAR_PERSISTENT_0_IIC_0_BASEADDR 0x00000400
#define XPAR_PERSISTENT_0_IIC_0_HIGHADDR 0x000007FF
#define XPAR_PERSISTENT_0_IIC_0_EEPROMADDR 0xA0

/******************************************************************/

#define XPAR_PCI_0_CLOCK_FREQ_HZ    0

/******************************************************************/

/******************************************************************/
/*added by oliv*/
/*#define XPAR_OPB_LCD_INTERFACE_0_BASEADDR 0xFE804800
#define XPAR_OPB_LCD_INTERFACE_0_HIGHADDR 0xFE8048FF

#define XPAR_FLASH_2MX32_MEM0_BASEADDR 0xFE000000
#define XPAR_FLASH_2MX32_MEM0_HIGHADDR 0xFE7FFFFF*/
/******************************************************************/


--=-4Bfe/x4KTBl/v5g0W2Pn
Content-Disposition: attachment; filename=xparameters_2vpx.h.orig
Content-Type: text/plain; name=xparameters_2vpx.h.orig; charset=UTF-8
Content-Transfer-Encoding: 7bit

/******************************************************************/
/* xparameters.h file for ank_demo_010 design                     */
/******************************************************************/

/*******************************************************************
*
* CAUTION: This file is automatically generated by libgen.
* Version: Xilinx EDK 6.2.1 EDK_Gm.12.3
* DO NOT EDIT.
*
* Copyright (c) 2003 Xilinx, Inc.  All rights reserved. 
* 
* Description: Driver parameters
*
*******************************************************************/

#define XPAR_XUARTNS550_NUM_INSTANCES 2
#define XPAR_XUARTNS550_CLOCK_HZ 100000000
#define XPAR_RS232_BASEADDR 0xFE800000
#define XPAR_RS232_HIGHADDR 0xFE801FFF
#define XPAR_RS232_DEVICE_ID 0
#define XPAR_RS232_P160_BASEADDR 0xFE802000
#define XPAR_RS232_P160_HIGHADDR 0xFE803FFF
#define XPAR_RS232_P160_DEVICE_ID 1

/******************************************************************/

#define XPAR_XEMC_NUM_INSTANCES 1
#define XPAR_FLASH_2MX32_BASEADDR 0xFE804000
#define XPAR_FLASH_2MX32_HIGHADDR 0xFE80401F
#define XPAR_FLASH_2MX32_DEVICE_ID 0
#define XPAR_FLASH_2MX32_NUM_BANKS_MEM 1

/******************************************************************/

#define XPAR_FLASH_2MX32_MEM0_BASEADDR 0xFE000000
#define XPAR_FLASH_2MX32_MEM0_HIGHADDR 0xFE7FFFFF

/******************************************************************/

#define XPAR_XGPIO_NUM_INSTANCES 3
#define XPAR_LEDS_4BIT_BASEADDR 0xFE804200
#define XPAR_LEDS_4BIT_HIGHADDR 0xFE8043FF
#define XPAR_LEDS_4BIT_DEVICE_ID 0
#define XPAR_PUSH_BUTTONS_3BIT_BASEADDR 0xFE804400
#define XPAR_PUSH_BUTTONS_3BIT_HIGHADDR 0xFE8045FF
#define XPAR_PUSH_BUTTONS_3BIT_DEVICE_ID 1
#define XPAR_DIP_SWITCHES_8BIT_BASEADDR 0xFE804600
#define XPAR_DIP_SWITCHES_8BIT_HIGHADDR 0xFE8047FF
#define XPAR_DIP_SWITCHES_8BIT_DEVICE_ID 2

/******************************************************************/

#define XPAR_INTC_MAX_NUM_INTR_INPUTS 3
#define XPAR_XINTC_HAS_IPR 1
#define XPAR_XINTC_USE_DCR 0
#define XPAR_XINTC_NUM_INSTANCES 1
#define XPAR_OPB_INTC_0_BASEADDR 0xFE804020
#define XPAR_OPB_INTC_0_HIGHADDR 0xFE80403F
#define XPAR_OPB_INTC_0_DEVICE_ID 0
#define XPAR_OPB_INTC_0_KIND_OF_INTR 0x00000000

/******************************************************************/

#define XPAR_INTC_SINGLE_BASEADDR 0xFE804020
#define XPAR_INTC_SINGLE_HIGHADDR 0xFE80403F
#define XPAR_INTC_SINGLE_DEVICE_ID XPAR_OPB_INTC_0_DEVICE_ID
#define XPAR_ETHERNET_MAC_IP2INTC_IRPT_MASK 0X000001
#define XPAR_OPB_INTC_0_ETHERNET_MAC_IP2INTC_IRPT_INTR 0
#define XPAR_RS232_P160_IP2INTC_IRPT_MASK 0X000002
#define XPAR_OPB_INTC_0_RS232_P160_IP2INTC_IRPT_INTR 1
#define XPAR_RS232_IP2INTC_IRPT_MASK 0X000004
#define XPAR_OPB_INTC_0_RS232_IP2INTC_IRPT_INTR 2

/******************************************************************/

#define XPAR_OPB_LCD_INTERFACE_0_BASEADDR 0xFE804800
#define XPAR_OPB_LCD_INTERFACE_0_HIGHADDR 0xFE8048FF

/******************************************************************/

#define XPAR_XEMAC_NUM_INSTANCES 1
#define XPAR_ETHERNET_MAC_BASEADDR 0xFFFF0000
#define XPAR_ETHERNET_MAC_HIGHADDR 0xFFFF3FFF
#define XPAR_ETHERNET_MAC_DEVICE_ID 0
#define XPAR_ETHERNET_MAC_ERR_COUNT_EXIST 1
#define XPAR_ETHERNET_MAC_DMA_PRESENT 3
#define XPAR_ETHERNET_MAC_MII_EXIST 1

/******************************************************************/

#define XPAR_SDRAM_8MX32_BASEADDR 0x00000000
#define XPAR_SDRAM_8MX32_HIGHADDR 0x01FFFFFF

/******************************************************************/

#define XPAR_PLB_BRAM_IF_CNTLR_1_BASEADDR 0xFFFFC000
#define XPAR_PLB_BRAM_IF_CNTLR_1_HIGHADDR 0xFFFFFFFF

/******************************************************************/

#define XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ 300000000

/******************************************************************/


/******************************************************************/

/* Linux Redefines */

/******************************************************************/

#define XPAR_UARTNS550_0_BASEADDR (XPAR_RS232_BASEADDR+0x1000)
#define XPAR_UARTNS550_0_HIGHADDR XPAR_RS232_HIGHADDR
#define XPAR_UARTNS550_0_CLOCK_FREQ_HZ XPAR_XUARTNS550_CLOCK_HZ
#define XPAR_UARTNS550_0_DEVICE_ID XPAR_RS232_DEVICE_ID
#define XPAR_UARTNS550_1_BASEADDR (XPAR_RS232_P160_BASEADDR+0x1000)
#define XPAR_UARTNS550_1_HIGHADDR XPAR_RS232_P160_HIGHADDR
#define XPAR_UARTNS550_1_CLOCK_FREQ_HZ XPAR_XUARTNS550_CLOCK_HZ
#define XPAR_UARTNS550_1_DEVICE_ID XPAR_RS232_P160_DEVICE_ID

/******************************************************************/

#define XPAR_EMAC_0_BASEADDR XPAR_ETHERNET_MAC_BASEADDR
#define XPAR_EMAC_0_HIGHADDR XPAR_ETHERNET_MAC_HIGHADDR
#define XPAR_EMAC_0_DMA_PRESENT XPAR_ETHERNET_MAC_DMA_PRESENT
#define XPAR_EMAC_0_MII_EXIST XPAR_ETHERNET_MAC_MII_EXIST
#define XPAR_EMAC_0_ERR_COUNT_EXIST XPAR_ETHERNET_MAC_ERR_COUNT_EXIST
#define XPAR_EMAC_0_DEVICE_ID XPAR_ETHERNET_MAC_DEVICE_ID

/******************************************************************/

#define XPAR_GPIO_0_BASEADDR XPAR_LEDS_4BIT_BASEADDR
#define XPAR_GPIO_0_HIGHADDR XPAR_LEDS_4BIT_HIGHADDR
#define XPAR_GPIO_0_DEVICE_ID XPAR_LEDS_4BIT_DEVICE_ID
#define XPAR_GPIO_1_BASEADDR XPAR_PUSH_BUTTONS_3BIT_BASEADDR
#define XPAR_GPIO_1_HIGHADDR XPAR_PUSH_BUTTONS_3BIT_HIGHADDR
#define XPAR_GPIO_1_DEVICE_ID XPAR_PUSH_BUTTONS_3BIT_DEVICE_ID
#define XPAR_GPIO_2_BASEADDR XPAR_DIP_SWITCHES_8BIT_BASEADDR
#define XPAR_GPIO_2_HIGHADDR XPAR_DIP_SWITCHES_8BIT_HIGHADDR
#define XPAR_GPIO_2_DEVICE_ID XPAR_DIP_SWITCHES_8BIT_DEVICE_ID

/******************************************************************/

#define XPAR_INTC_0_BASEADDR XPAR_OPB_INTC_0_BASEADDR
#define XPAR_INTC_0_HIGHADDR XPAR_OPB_INTC_0_HIGHADDR
#define XPAR_INTC_0_KIND_OF_INTR XPAR_OPB_INTC_0_KIND_OF_INTR
#define XPAR_INTC_0_DEVICE_ID XPAR_OPB_INTC_0_DEVICE_ID

/******************************************************************/

#define XPAR_INTC_0_EMAC_0_VEC_ID XPAR_OPB_INTC_0_ETHERNET_MAC_IP2INTC_IRPT_INTR
#define XPAR_INTC_0_UARTNS550_1_VEC_ID XPAR_OPB_INTC_0_RS232_P160_IP2INTC_IRPT_INTR
#define XPAR_INTC_0_UARTNS550_0_VEC_ID XPAR_OPB_INTC_0_RS232_IP2INTC_IRPT_INTR

/******************************************************************/

#define XPAR_PLB_CLOCK_FREQ_HZ 100000000
#define XPAR_CORE_CLOCK_FREQ_HZ XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ
#define XPAR_DDR_0_SIZE 0x2000000

/******************************************************************/

#define XPAR_PCI_0_CLOCK_FREQ_HZ    0

/******************************************************************/


--=-4Bfe/x4KTBl/v5g0W2Pn
Content-Disposition: attachment; filename=xparameters_ml300.h
Content-Type: text/x-chdr; name=xparameters_ml300.h; charset=UTF-8
Content-Transfer-Encoding: 7bit


/*******************************************************************
*
* CAUTION: This file is automatically generated by libgen.
* Version: Xilinx EDK 8.1.02 EDK_I.20.4
* DO NOT EDIT.
*
* Copyright (c) 2005 Xilinx, Inc.  All rights reserved. 
* 
* Description: Driver parameters
*
*******************************************************************/

#define XPAR_XPLBARB_NUM_INSTANCES 1
#define XPAR_PLB_BASEADDR 0x00000000
#define XPAR_PLB_HIGHADDR 0x00000000
#define XPAR_PLB_DEVICE_ID 0
#define XPAR_PLB_PLB_NUM_MASTERS 2

/******************************************************************/

#define XPAR_XOPBARB_NUM_INSTANCES 1
#define XPAR_OPB_BASEADDR 0xFFFFFFFF
#define XPAR_OPB_HIGHADDR 0x00000000
#define XPAR_OPB_DEVICE_ID 0
#define XPAR_OPB_NUM_MASTERS 1

/******************************************************************/

#define XPAR_XUARTNS550_NUM_INSTANCES 1
#define XPAR_XUARTNS550_CLOCK_HZ 100000000
#define XPAR_RS232_BASEADDR 0x40400000
#define XPAR_RS232_HIGHADDR 0x4040FFFF
#define XPAR_RS232_DEVICE_ID 0

/******************************************************************/

#define XPAR_XGPIO_NUM_INSTANCES 4
#define XPAR_LEDS_4BIT_BASEADDR 0x40000000
#define XPAR_LEDS_4BIT_HIGHADDR 0x4000FFFF
#define XPAR_LEDS_4BIT_DEVICE_ID 0
#define XPAR_PUSH_BUTTONS_3BIT_BASEADDR 0x40020000
#define XPAR_PUSH_BUTTONS_3BIT_HIGHADDR 0x4002FFFF
#define XPAR_PUSH_BUTTONS_3BIT_DEVICE_ID 1
#define XPAR_DIP_SWITCHES_8BIT_BASEADDR 0x40040000
#define XPAR_DIP_SWITCHES_8BIT_HIGHADDR 0x4004FFFF
#define XPAR_DIP_SWITCHES_8BIT_DEVICE_ID 2
#define XPAR_FLASH_READY_BASEADDR 0x40060000
#define XPAR_FLASH_READY_HIGHADDR 0x4006FFFF
#define XPAR_FLASH_READY_DEVICE_ID 3

/******************************************************************/

#define XPAR_DDR_SDRAM_32MX16_MEM0_BASEADDR 0x00000000
#define XPAR_DDR_SDRAM_32MX16_MEM0_HIGHADDR 0x03FFFFFF

/******************************************************************/

#define XPAR_INTC_MAX_NUM_INTR_INPUTS 6
#define XPAR_XINTC_HAS_IPR 1
#define XPAR_XINTC_USE_DCR 0
#define XPAR_XINTC_NUM_INSTANCES 1
#define XPAR_OPB_INTC_0_BASEADDR 0x41200000
#define XPAR_OPB_INTC_0_HIGHADDR 0x4120FFFF
#define XPAR_OPB_INTC_0_DEVICE_ID 0
#define XPAR_OPB_INTC_0_KIND_OF_INTR 0x00000000

/******************************************************************/

#define XPAR_INTC_SINGLE_BASEADDR 0x41200000
#define XPAR_INTC_SINGLE_HIGHADDR 0x4120FFFF
#define XPAR_INTC_SINGLE_DEVICE_ID XPAR_OPB_INTC_0_DEVICE_ID
#define XPAR_ETHERNET_MAC_IP2INTC_IRPT_MASK 0X000001
#define XPAR_OPB_INTC_0_ETHERNET_MAC_IP2INTC_IRPT_INTR 0
#define XPAR_FLASH_READY_IP2INTC_IRPT_MASK 0X000002
#define XPAR_OPB_INTC_0_FLASH_READY_IP2INTC_IRPT_INTR 1
#define XPAR_DIP_SWITCHES_8BIT_IP2INTC_IRPT_MASK 0X000004
#define XPAR_OPB_INTC_0_DIP_SWITCHES_8BIT_IP2INTC_IRPT_INTR 2
#define XPAR_PUSH_BUTTONS_3BIT_IP2INTC_IRPT_MASK 0X000008
#define XPAR_OPB_INTC_0_PUSH_BUTTONS_3BIT_IP2INTC_IRPT_INTR 3
#define XPAR_LEDS_4BIT_IP2INTC_IRPT_MASK 0X000010
#define XPAR_OPB_INTC_0_LEDS_4BIT_IP2INTC_IRPT_INTR 4
#define XPAR_RS232_IP2INTC_IRPT_MASK 0X000020
#define XPAR_OPB_INTC_0_RS232_IP2INTC_IRPT_INTR 5

/******************************************************************/

#define XPAR_XEMAC_NUM_INSTANCES 1
#define XPAR_ETHERNET_MAC_BASEADDR 0x80400000
#define XPAR_ETHERNET_MAC_HIGHADDR 0x8040FFFF
#define XPAR_ETHERNET_MAC_DEVICE_ID 0
#define XPAR_ETHERNET_MAC_ERR_COUNT_EXIST 1
#define XPAR_ETHERNET_MAC_DMA_PRESENT 1
#define XPAR_ETHERNET_MAC_MII_EXIST 1

/******************************************************************/

#define XPAR_FLASH_2MX16_NUM_BANKS_MEM 1

/******************************************************************/

#define XPAR_FLASH_2MX16_MEM0_BASEADDR 0xFF800000
#define XPAR_FLASH_2MX16_MEM0_HIGHADDR 0xFFBFFFFF

/******************************************************************/

#define XPAR_PLB_BRAM_IF_CNTLR_1_BASEADDR 0xffff8000
#define XPAR_PLB_BRAM_IF_CNTLR_1_HIGHADDR 0xffffffff

/******************************************************************/

#define XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ 100000000

/******************************************************************/


/******************************************************************/

/* Linux Redefines */

/******************************************************************/

#define XPAR_UARTNS550_0_BASEADDR (XPAR_RS232_BASEADDR+0x1000)
#define XPAR_UARTNS550_0_HIGHADDR XPAR_RS232_HIGHADDR
#define XPAR_UARTNS550_0_CLOCK_FREQ_HZ XPAR_XUARTNS550_CLOCK_HZ
#define XPAR_UARTNS550_0_DEVICE_ID XPAR_RS232_DEVICE_ID

/******************************************************************/

#define XPAR_EMAC_0_BASEADDR XPAR_ETHERNET_MAC_BASEADDR
#define XPAR_EMAC_0_HIGHADDR XPAR_ETHERNET_MAC_HIGHADDR
#define XPAR_EMAC_0_DMA_PRESENT XPAR_ETHERNET_MAC_DMA_PRESENT
#define XPAR_EMAC_0_MII_EXIST XPAR_ETHERNET_MAC_MII_EXIST
#define XPAR_EMAC_0_ERR_COUNT_EXIST XPAR_ETHERNET_MAC_ERR_COUNT_EXIST
#define XPAR_EMAC_0_DEVICE_ID XPAR_ETHERNET_MAC_DEVICE_ID

/******************************************************************/

#define XPAR_GPIO_0_BASEADDR XPAR_LEDS_4BIT_BASEADDR
#define XPAR_GPIO_0_HIGHADDR XPAR_LEDS_4BIT_HIGHADDR
#define XPAR_GPIO_0_DEVICE_ID XPAR_LEDS_4BIT_DEVICE_ID
#define XPAR_GPIO_1_BASEADDR XPAR_PUSH_BUTTONS_3BIT_BASEADDR
#define XPAR_GPIO_1_HIGHADDR XPAR_PUSH_BUTTONS_3BIT_HIGHADDR
#define XPAR_GPIO_1_DEVICE_ID XPAR_PUSH_BUTTONS_3BIT_DEVICE_ID
#define XPAR_GPIO_2_BASEADDR XPAR_DIP_SWITCHES_8BIT_BASEADDR
#define XPAR_GPIO_2_HIGHADDR XPAR_DIP_SWITCHES_8BIT_HIGHADDR
#define XPAR_GPIO_2_DEVICE_ID XPAR_DIP_SWITCHES_8BIT_DEVICE_ID
#define XPAR_GPIO_3_BASEADDR XPAR_FLASH_READY_BASEADDR
#define XPAR_GPIO_3_HIGHADDR XPAR_FLASH_READY_HIGHADDR
#define XPAR_GPIO_3_DEVICE_ID XPAR_FLASH_READY_DEVICE_ID

/******************************************************************/

#define XPAR_INTC_0_BASEADDR XPAR_OPB_INTC_0_BASEADDR
#define XPAR_INTC_0_HIGHADDR XPAR_OPB_INTC_0_HIGHADDR
#define XPAR_INTC_0_KIND_OF_INTR XPAR_OPB_INTC_0_KIND_OF_INTR
#define XPAR_INTC_0_DEVICE_ID XPAR_OPB_INTC_0_DEVICE_ID

/******************************************************************/

#define XPAR_INTC_0_EMAC_0_VEC_ID XPAR_OPB_INTC_0_ETHERNET_MAC_IP2INTC_IRPT_INTR
#define XPAR_INTC_0_GPIO_3_VEC_ID XPAR_OPB_INTC_0_FLASH_READY_IP2INTC_IRPT_INTR
#define XPAR_INTC_0_GPIO_2_VEC_ID XPAR_OPB_INTC_0_DIP_SWITCHES_8BIT_IP2INTC_IRPT_INTR
#define XPAR_INTC_0_GPIO_1_VEC_ID XPAR_OPB_INTC_0_PUSH_BUTTONS_3BIT_IP2INTC_IRPT_INTR
#define XPAR_INTC_0_GPIO_0_VEC_ID XPAR_OPB_INTC_0_LEDS_4BIT_IP2INTC_IRPT_INTR
#define XPAR_INTC_0_UARTNS550_0_VEC_ID XPAR_OPB_INTC_0_RS232_IP2INTC_IRPT_INTR

/******************************************************************/

#define XPAR_PLB_CLOCK_FREQ_HZ 100000000
#define XPAR_CORE_CLOCK_FREQ_HZ XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ
#define XPAR_DDR_0_SIZE 0x4000000

/******************************************************************/

#define XPAR_PERSISTENT_0_IIC_0_BASEADDR 0x00000400
#define XPAR_PERSISTENT_0_IIC_0_HIGHADDR 0x000007FF
#define XPAR_PERSISTENT_0_IIC_0_EEPROMADDR 0xA0

/******************************************************************/

#define XPAR_PCI_0_CLOCK_FREQ_HZ    0

/******************************************************************/


--=-4Bfe/x4KTBl/v5g0W2Pn--
