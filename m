Message-ID: <003b01c38321$81114d20$c50aa8c0@ksshin>
From: =?ks_c_5601-1987?B?vcWw5rz2?= <ksshin@essetel.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <009501c37dba$0f462470$c50aa8c0@ksshin> <3F723C33.9030003@mvista.com>
Subject: Re: PCI DMA in GT64260
Date: Thu, 25 Sep 2003 13:57:21 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you for your response.

Well, Instead of giving my all code, I give the register lists and the value
related to address decoding. please check the register and the value.

The memory map of my board is like below
Internal Reg Base : 0xF800 0000
SCS0 : SDRAM 0x0000 0000 ~ 0x07FF FFFF
CS0   : Flash 0xF100 0000 ~ 0xF1FF FFFF
CS1   : not use 0xF200 0000 ~ 0xF1FF FFFF
CS2   : not Use 0xF300 0000 ~ 0xF1FF FFFF
CS3   : not use 0xF400 0000 ~ 0xF1FF FFFF
bootCS : 0xFF00 0000 ~ 0xFFFF FFFF
PCI_0 : not use
PCI_1 : One Device

pci device is L2/L3 switching chip, and when try to tx/rx packet data,
pci device use pci dma as pci master.
I check that pci device asserts PIC_REQ* signal, and 64260 asserts
PCI_GNT* signal, after that in pci device the pci bus error occurred...

please help me...

*********************************************
 CPU Address Decoding Regs ...
 *********************************************
 CPU_SCS_DECODE_0_BOT(0xf8000008) : 0x00000000
 CPU_SCS_DECODE_0_TOP(0xf8000010) : 0x0000007f
 CPU_SCS_DECODE_1_BOT(0xf8000208) : 0x00000fff
 CPU_SCS_DECODE_1_TOP(0xf8000210) : 0x00000000
 CPU_SCS_DECODE_2_BOT(0xf8000018) : 0x00000fff
 CPU_SCS_DECODE_2_TOP(0xf8000020) : 0x00000000
 CPU_SCS_DECODE_3_BOT(0xf8000218) : 0x00000fff
 CPU_SCS_DECODE_3_TOP(0xf8000220) : 0x00000000
 CPU_CS_DECODE_0_BOT(0xf8000028) : 0x00000f10
 CPU_CS_DECODE_0_TOP(0xf8000030) : 0x00000f1f
 CPU_CS_DECODE_1_BOT(0xf8000228) : 0x00000f20
 CPU_CS_DECODE_1_TOP(0xf8000230) : 0x00000f2f
 CPU_CS_DECODE_2_BOT(0xf8000248) : 0x00000f30
 CPU_CS_DECODE_2_TOP(0xf8000250) : 0x00000f3f
 CPU_CS_DECODE_3_BOT(0xf8000038) : 0x00000f40
 CPU_CS_DECODE_3_TOP(0xf8000040) : 0x00000f4f
 CPU_BOOT_CS_DECODE_0_BOT(0xf8000238) : 0x00000ff0
 CPU_PCI_0_IO_DECODE_BOT(0xf8000048) : 0x01000a00
 CPU_PCI_0_IO_DECODE_TOP(0xf8000050) : 0x00000a0f
 CPU_PCI_0_MEM_0_DECODE_BOT(0xf8000058) : 0x01000800
 CPU_PCI_0_MEM_0_DECODE_TOP(0xf8000060) : 0x000008ff
 CPU_PCI_0_MEM_1_DECODE_BOT(0xf8000080) : 0x00000fff
 CPU_PCI_0_MEM_1_DECODE_TOP(0xf8000088) : 0x00000000
 CPU_PCI_0_MEM_2_DECODE_BOT(0xf8000258) : 0x00000fff
 CPU_PCI_0_MEM_2_DECODE_TOP(0xf8000260) : 0x00000000
 CPU_PCI_0_MEM_3_DECODE_BOT(0xf8000280) : 0x00000fff
 CPU_PCI_0_MEM_3_DECODE_TOP(0xf8000288) : 0x00000000
 CPU_PCI_0_IO_REMAP(0xf80000f0) : 0x00000000
 CPU_PCI_0_MEM_0_REMAP_LO(0xf80000f8) : 0x00000800
 CPU_PCI_0_MEM_0_REMAP_HI(0xf8000320) : 0x00000000
 CPU_PCI_0_MEM_1_REMAP_LO(0xf8000100) : 0x00000000
 CPU_PCI_0_MEM_1_REMAP_HI(0xf8000328) : 0x00000000
 CPU_PCI_0_MEM_2_REMAP_LO (0xf80002f8) : 0x00000000
 CPU_PCI_0_MEM_2_REMAP_HI(0xf8000330) : 0x00000000
 CPU_PCI_0_MEM_3_REMAP_LO(0xf8000300) : 0x00000000
 CPU_PCI_0_MEM_3_REMAP_HI(0xf8000338) : 0x00000000
 CPU_PCI_1_IO_DECODE_BOT(0xf8000090) : 0x01000a10
 CPU_PCI_1_IO_DECODE_TOP(0xf8000098) : 0x00000a1f
 CPU_PCI_1_MEM_0_DECODE_BOT(0xf80000a0) : 0x01000900
 CPU_PCI_1_MEM_0_DECODE_TOP(0xf80000a8) : 0x000009ff
 CPU_PCI_1_MEM_1_DECODE_BOT(0xf80000b0) : 0x00000fff
 CPU_PCI_1_MEM_1_DECODE_TOP(0xf80000b8) : 0x00000000
 CPU_PCI_1_MEM_2_DECODE_BOT(0xf80002a0) : 0x00000fff
 CPU_PCI_1_MEM_2_DECODE_TOP(0xf80002a8) : 0x00000000
 CPU_PCI_1_MEM_3_DECODE_BOT(0xf80002b0) : 0x00000fff
 CPU_PCI_1_MEM_3_DECODE_TOP(0xf80002b8) : 0x00000000
 CPU_PCI_1_IO_REMAP(0xf8000108) : 0x00000010
 CPU_PCI_1_MEM_0_REMAP_LO(0xf8000110) : 0x00000900
 CPU_PCI_1_MEM_0_REMAP_HI(0xf8000340) : 0x00000000
 CPU_PCI_1_MEM_1_REMAP_LO(0xf8000118) : 0x00000000
 CPU_PCI_1_MEM_1_REMAP_HI(0xf8000348) : 0x00000000
 CPU_PCI_1_MEM_2_REMAP_LO(0xf8000310) : 0x00000000
 CPU_PCI_1_MEM_2_REMAP_HI(0xf8000350) : 0x00000000
 CPU_PCI_1_MEM_3_REMAP_LO(0xf8000318) : 0x00000000
 CPU_PCI_1_MEM_3_REMAP_HI(0xf8000358) : 0x00000000
 *********************************************
 PCI Address Decoding Regs ...
 *********************************************
 PCI_0_SLAVE_SCS_0_SIZE(0xf8000c08) : 0x07fff000
 PCI_0_SLAVE_SCS_1_SIZE(0xf8000d08) : 0x007ff000
 PCI_0_SLAVE_SCS_2_SIZE(0xf8000c0c) : 0x007ff000
 PCI_0_SLAVE_SCS_3_SIZE(0xf8000d0c) : 0x007ff000
 PCI_0_SLAVE_CS_0_SIZE(0xf8000c10) : 0x007ff000
 PCI_0_SLAVE_CS_1_SIZE(0xf8000d10) : 0x007ff000
 PCI_0_SLAVE_CS_2_SIZE(0xf8000d18) : 0x00fff000
 PCI_0_SLAVE_CS_3_SIZE(0xf8000c14) : 0x007ff000
 PCI_0_SLAVE_BOOT_SIZE(0xf8000d14) : 0x007ff000
 PCI_0_SLAVE_P2P_MEM_0_SIZE(0xf8000d1c) : 0x01fff000
 PCI_0_SLAVE_P2P_MEM_1_SIZE(0xf8000d20) : 0x01fff000
 PCI_0_SLAVE_P2P_IO_SIZE(0xf8000d24) : 0x01fff000
 PCI_0_SLAVE_CPU_SIZE(0xf8000d28) : 0x01fff000
 PCI_0_SLAVE_DAC_SCS_0_SIZE(0xf8000e00) : 0x007ff000
 PCI_0_SLAVE_DAC_SCS_1_SIZE(0xf8000e04) : 0x007ff000
 PCI_0_SLAVE_DAC_SCS_2_SIZE(0xf8000e08) : 0x007ff000
 PCI_0_SLAVE_DAC_SCS_3_SIZE(0xf8000e0c) : 0x007ff000
 PCI_0_SLAVE_DAC_CS_0_SIZE(0xf8000e10) : 0x007ff000
 PCI_0_SLAVE_DAC_CS_1_SIZE(0xf8000e14) : 0x007ff000
 PCI_0_SLAVE_DAC_CS_2_SIZE(0xf8000e18) : 0x00fff000
 PCI_0_SLAVE_DAC_CS_3_SIZE(0xf8000e1c) : 0x007ff000
 PCI_0_SLAVE_DAC_BOOT_SIZE(0xf8000e20) : 0x007ff000
 PCI_0_SLAVE_DAC_P2P_MEM_0_SIZE(0xf8000e24) : 0x01fff000
 PCI_0_SLAVE_DAC_P2P_MEM_1_SIZE(0xf8000e28) : 0x01fff000
 PCI_0_SLAVE_DAC_CPU_SIZE(0xf8000e2c) : 0x01fff000
 PCI_0_SLAVE_BAR_REG_ENABLES(0xf8000c3c) : 0xfffffdfe
 PCI_0_SLAVE_SCS_0_REMAP(0xf8000c48) : 0x00000000
 PCI_0_SLAVE_SCS_1_REMAP(0xf8000d48) : 0x00800000
 PCI_0_SLAVE_SCS_2_REMAP(0xf8000c4c) : 0x01000000
 PCI_0_SLAVE_SCS_3_REMAP(0xf8000d4c) : 0x01800000
 PCI_0_SLAVE_CS_0_REMAP(0xf8000c50) : 0x1c000000
 PCI_0_SLAVE_CS_1_REMAP(0xf8000d50) : 0x1c800000
 PCI_0_SLAVE_CS_2_REMAP(0xf8000d58) : 0x1d000000
 PCI_0_SLAVE_CS_3_REMAP(0xf8000c54) : 0xff000000
 PCI_0_SLAVE_BOOT_REMAP(0xf8000d54) : 0xff800000
 PCI_0_SLAVE_P2P_MEM_0_REMAP_LO(0xf8000d5c) : 0x22000000
 PCI_0_SLAVE_P2P_MEM_0_REMAP_HI(0xf8000d60) : 0x00000000
 PCI_0_SLAVE_P2P_MEM_1_REMAP_LO(0xf8000d64) : 0x24000000
 PCI_0_SLAVE_P2P_MEM_1_REMAP_HI(0xf8000d68) : 0x00000000
 PCI_0_SLAVE_P2P_IO_REMAP(0xf8000d6c) : 0x20000000
 PCI_0_SLAVE_CPU_REMAP(0xf8000d70) : 0x40000000
 PCI_0_SLAVE_DAC_SCS_0_REMAP(0xf8000f00) : 0x00000000
 PCI_0_SLAVE_DAC_SCS_1_REMAP(0xf8000f04) : 0x00800000
 PCI_0_SLAVE_DAC_SCS_2_REMAP(0xf8000f08) : 0x01000000
 PCI_0_SLAVE_DAC_SCS_3_REMAP(0xf8000f0c) : 0x01800000
 PCI_0_SLAVE_DAC_CS_0_REMAP(0xf8000f10) : 0x1c000000
 PCI_0_SLAVE_DAC_CS_1_REMAP(0xf8000f14) : 0x1c800000
 PCI_0_SLAVE_DAC_CS_2_REMAP(0xf8000f18) : 0x1d000000
 PCI_0_SLAVE_DAC_CS_3_REMAP(0xf8000f1c) : 0xff000000
 PCI_0_SLAVE_DAC_BOOT_REMAP(0xf8000f20) : 0xff800000
 PCI_0_SLAVE_DAC_P2P_MEM_0_REMAP_LO(0xf8000f24) : 0x26000000
 PCI_0_SLAVE_DAC_P2P_MEM_0_REMAP_HI(0xf8000f28) : 0x00000000
 PCI_0_SLAVE_DAC_P2P_MEM_1_REMAP_LO(0xf8000f2c) : 0x28000000
 PCI_0_SLAVE_DAC_P2P_MEM_1_REMAP_HI(0xf8000f30) : 0x00000000
 PCI_0_SLAVE_DAC_CPU_REMAP(0xf8000f34) : 0x42000000
 PCI_0_SLAVE_EXP_ROM_REMAP(0xf8000f38) : 0xff000000
 PCI_0_SLAVE_PCI_DECODE_CNTL(0xf8000d3c) : 0x00000009
 PCI_1_SLAVE_SCS_0_SIZE(0xf8000c88) : 0x07fff000
 PCI_1_SLAVE_SCS_1_SIZE(0xf8000d88) : 0x007ff000
 PCI_1_SLAVE_SCS_2_SIZE(0xf8000c8c) : 0x007ff000
 PCI_1_SLAVE_SCS_3_SIZE(0xf8000d8c) : 0x007ff000
 PCI_1_SLAVE_CS_0_SIZE(0xf8000c90) : 0x007ff000
 PCI_1_SLAVE_CS_1_SIZE(0xf8000d90) : 0x007ff000
 PCI_1_SLAVE_CS_2_SIZE(0xf8000d98) : 0x00fff000
 PCI_1_SLAVE_CS_3_SIZE(0xf8000c94) : 0x007ff000
 PCI_1_SLAVE_BOOT_SIZE(0xf8000d94) : 0x007ff000
 PCI_1_SLAVE_P2P_MEM_0_SIZE(0xf8000d9c) : 0x01fff000
 PCI_1_SLAVE_P2P_MEM_1_SIZE(0xf8000da0) : 0x01fff000
 PCI_1_SLAVE_P2P_IO_SIZE(0xf8000da4) : 0x01fff000
 PCI_1_SLAVE_CPU_SIZE(0xf8000da8) : 0x01fff000
 PCI_1_SLAVE_DAC_SCS_0_SIZE(0xf8000e80) : 0x007ff000
 PCI_1_SLAVE_DAC_SCS_1_SIZE(0xf8000e84) : 0x007ff000
 PCI_1_SLAVE_DAC_SCS_2_SIZE(0xf8000e88) : 0x007ff000
 PCI_1_SLAVE_DAC_SCS_3_SIZE(0xf8000e8c) : 0x007ff000
 PCI_1_SLAVE_DAC_CS_0_SIZE(0xf8000e90) : 0x007ff000
 PCI_1_SLAVE_DAC_CS_1_SIZE(0xf8000e94) : 0x007ff000
 PCI_1_SLAVE_DAC_CS_2_SIZE(0xf8000e98) : 0x00fff000
 PCI_1_SLAVE_DAC_CS_3_SIZE(0xf8000e9c) : 0x007ff000
 PCI_1_SLAVE_DAC_BOOT_SIZE(0xf8000ea0) : 0x007ff000
 PCI_1_SLAVE_DAC_P2P_MEM_0_SIZE(0xf8000ea4) : 0x01fff000
 PCI_1_SLAVE_DAC_P2P_MEM_1_SIZE(0xf8000ea8) : 0x01fff000
 PCI_1_SLAVE_DAC_CPU_SIZE(0xf8000eac) : 0x01fff000
 PCI_1_SLAVE_BAR_REG_ENABLES(0xf8000cbc) : 0xfffffdfe
 PCI_1_SLAVE_SCS_0_REMAP(0xf8000cc8) : 0x00000000
 PCI_1_SLAVE_SCS_1_REMAP(0xf8000dc8) : 0x00800000
 PCI_1_SLAVE_SCS_2_REMAP(0xf8000ccc) : 0x01000000
 PCI_1_SLAVE_SCS_3_REMAP(0xf8000dcc) : 0x01800000
 PCI_1_SLAVE_CS_0_REMAP(0xf8000cd0) : 0x1c000000
 PCI_1_SLAVE_CS_1_REMAP(0xf8000dd0) : 0x1c800000
 PCI_1_SLAVE_CS_2_REMAP(0xf8000dd8) : 0x1d000000
 PCI_1_SLAVE_CS_3_REMAP(0xf8000cd4) : 0xff000000
 PCI_1_SLAVE_BOOT_REMAP(0xf8000dd4) : 0xff800000
 PCI_1_SLAVE_P2P_MEM_0_REMAP_LO(0xf8000ddc) : 0x12000000
 PCI_1_SLAVE_P2P_MEM_0_REMAP_HI(0xf8000de0) : 0x00000000
 PCI_1_SLAVE_P2P_MEM_1_REMAP_LO(0xf8000de4) : 0xf2000000
 PCI_1_SLAVE_P2P_MEM_1_REMAP_HI(0xf8000de8) : 0x00000000
 PCI_1_SLAVE_P2P_IO_REMAP(0xf8000dec) : 0x10000000
 PCI_1_SLAVE_CPU_REMAP(0xf8000df0) : 0x40000000
 PCI_1_SLAVE_DAC_SCS_0_REMAP(0xf8000f80) : 0x00000000
 PCI_1_SLAVE_DAC_SCS_1_REMAP(0xf8000f84) : 0x00800000
 PCI_1_SLAVE_DAC_SCS_2_REMAP(0xf8000f88) : 0x01000000
 PCI_1_SLAVE_DAC_SCS_3_REMAP(0xf8000f8c) : 0x01800000
 PCI_1_SLAVE_DAC_CS_0_REMAP(0xf8000f90) : 0x1c000000
 PCI_1_SLAVE_DAC_CS_1_REMAP(0xf8000f94) : 0x1c800000
 PCI_1_SLAVE_DAC_CS_2_REMAP(0xf8000f98) : 0x1d000000
 PCI_1_SLAVE_DAC_CS_3_REMAP(0xf8000f9c) : 0xff000000
 PCI_1_SLAVE_DAC_BOOT_REMAP(0xf8000fa0) : 0xff800000
 PCI_1_SLAVE_DAC_P2P_MEM_0_REMAP_LO(0xf8000fa4) : 0xf4000000
 PCI_1_SLAVE_DAC_P2P_MEM_0_REMAP_HI(0xf8000fa8) : 0x00000000
 PCI_1_SLAVE_DAC_P2P_MEM_1_REMAP_LO(0xf8000fac) : 0xf6000000
 PCI_1_SLAVE_DAC_P2P_MEM_1_REMAP_HI(0xf8000fb0) : 0x00000000
 PCI_1_SLAVE_DAC_CPU_REMAP(0xf8000fb4) : 0x42000000
 PCI_1_SLAVE_EXP_ROM_REMAP(0xf8000fb8) : 0xff000000
 PCI_1_SLAVE_PCI_DECODE_CNTL(0xf8000dbc) : 0x00000009
 Starting PCI Scanning ...
 ***************************************************
 BusNum : 0, DevNum : 0, FuncNum : 0, ID : 0x643011ab
 ***************************************************

 PCI Info ...
 Config Addr(0x10) : 0x00000008
 Config Addr(0x14) : 0x00800008
 Config Addr(0x18) : 0x01000008
 Config Addr(0x1c) : 0x01800008
 Config Addr(0x20) : 0x14000000
 Config Addr(0x24) : 0x14000001
 Config Addr(0x28) : 0x00000000
 ***************************************************
 BusNum : 0, DevNum : 0, FuncNum : 1, ID : 0x643011ab
 ***************************************************

 PCI Info ...
 Config Addr(0x10) : 0x1c000000
 Config Addr(0x14) : 0x1c800000
 Config Addr(0x18) : 0x1d000000
 Config Addr(0x1c) : 0xff000000
 Config Addr(0x20) : 0xff800000
 Config Addr(0x24) : 0x00000000
 Config Addr(0x28) : 0x00000000
 ***************************************************
 BusNum : 0, DevNum : 0, FuncNum : 2, ID : 0x643011ab
 ***************************************************

 PCI Info ...
 Config Addr(0x10) : 0x22000008
 Config Addr(0x14) : 0x24000008
 Config Addr(0x18) : 0x20000001
 Config Addr(0x1c) : 0x40000008
 Config Addr(0x20) : 0x00000000
 Config Addr(0x24) : 0x00000000
 Config Addr(0x28) : 0x00000000
 ***************************************************
 BusNum : 0, DevNum : 0, FuncNum : 3, ID : 0x643011ab
 ***************************************************

 PCI Info ...
 Config Addr(0x10) : 0x00000000
 Config Addr(0x14) : 0x00000000
 Config Addr(0x18) : 0x00000000
 Config Addr(0x1c) : 0x00000000
 Config Addr(0x20) : 0x00000000
 Config Addr(0x24) : 0x00000000
 Config Addr(0x28) : 0x00000000
 ***************************************************
 BusNum : 0, DevNum : 0, FuncNum : 4, ID : 0x643011ab
 ***************************************************

 PCI Info ...
 Config Addr(0x10) : 0x0000000c
 Config Addr(0x14) : 0x00000000
 Config Addr(0x18) : 0x0080000c
 Config Addr(0x1c) : 0x00000000
 Config Addr(0x20) : 0x2600000c
 Config Addr(0x24) : 0x00000000
 Config Addr(0x28) : 0x00000000
 ***************************************************
 BusNum : 0, DevNum : 0, FuncNum : 5, ID : 0x643011ab
 ***************************************************

 PCI Info ...
 Config Addr(0x10) : 0x0100000c
 Config Addr(0x14) : 0x00000000
 Config Addr(0x18) : 0x0180000c
 Config Addr(0x1c) : 0x00000000
 Config Addr(0x20) : 0x2800000c
 Config Addr(0x24) : 0x00000000
 Config Addr(0x28) : 0x00000000
 ***************************************************
 BusNum : 0, DevNum : 0, FuncNum : 6, ID : 0x643011ab
 ***************************************************

 PCI Info ...
 Config Addr(0x10) : 0x1c000004
 Config Addr(0x14) : 0x00000000
 Config Addr(0x18) : 0x1c800004
 Config Addr(0x1c) : 0x00000000
 Config Addr(0x20) : 0x1d000004
 Config Addr(0x24) : 0x00000000
 Config Addr(0x28) : 0x00000000
 ***************************************************
 BusNum : 0, DevNum : 0, FuncNum : 7, ID : 0x643011ab
 ***************************************************

 PCI Info ...
 Config Addr(0x10) : 0xff000004
 Config Addr(0x14) : 0x00000000
 Config Addr(0x18) : 0xff800004
 Config Addr(0x1c) : 0x00000000
 Config Addr(0x20) : 0x4200000c
 Config Addr(0x24) : 0x00000000
 Config Addr(0x28) : 0x00000000
 ***************************************************
 BusNum : 1, DevNum : 0, FuncNum : 0, ID : 0x643011ab
 ***************************************************

 PCI Info ...
 Config Addr(0x10) : 0x00000008
 Config Addr(0x14) : 0x00800008
 Config Addr(0x18) : 0x01000008
 Config Addr(0x1c) : 0x01800008
 Config Addr(0x20) : 0x14000000
 Config Addr(0x24) : 0x14000001
 Config Addr(0x28) : 0x00000000
 ***************************************************
 BusNum : 1, DevNum : 0, FuncNum : 1, ID : 0x643011ab
 ***************************************************

 PCI Info ...
 Config Addr(0x10) : 0x1c000000
 Config Addr(0x14) : 0x1c800000
 Config Addr(0x18) : 0x1d000000
 Config Addr(0x1c) : 0xff000000
 Config Addr(0x20) : 0xff800000
 Config Addr(0x24) : 0x00000000
 Config Addr(0x28) : 0x00000000
 ***************************************************
 BusNum : 1, DevNum : 0, FuncNum : 2, ID : 0x643011ab
 ***************************************************

 PCI Info ...
 Config Addr(0x10) : 0x12000008
 Config Addr(0x14) : 0xf2000008
 Config Addr(0x18) : 0x10000001
 Config Addr(0x1c) : 0x40000008
 Config Addr(0x20) : 0x00000000
 Config Addr(0x24) : 0x00000000
 Config Addr(0x28) : 0x00000000
 ***************************************************
 BusNum : 1, DevNum : 0, FuncNum : 3, ID : 0x643011ab
 ***************************************************

 PCI Info ...
 Config Addr(0x10) : 0x00000000
 Config Addr(0x14) : 0x00000000
 Config Addr(0x18) : 0x00000000
 Config Addr(0x1c) : 0x00000000
 Config Addr(0x20) : 0x00000000
 Config Addr(0x24) : 0x00000000
 Config Addr(0x28) : 0x00000000
 ***************************************************
 BusNum : 1, DevNum : 0, FuncNum : 4, ID : 0x643011ab
 ***************************************************

 PCI Info ...
 Config Addr(0x10) : 0x0000000c
 Config Addr(0x14) : 0x00000000
 Config Addr(0x18) : 0x0080000c
 Config Addr(0x1c) : 0x00000000
 Config Addr(0x20) : 0xf400000c
 Config Addr(0x24) : 0x00000000
 Config Addr(0x28) : 0x00000000
 ***************************************************
 BusNum : 1, DevNum : 0, FuncNum : 5, ID : 0x643011ab
 ***************************************************

 PCI Info ...
 Config Addr(0x10) : 0x0100000c
 Config Addr(0x14) : 0x00000000
 Config Addr(0x18) : 0x0180000c
 Config Addr(0x1c) : 0x00000000
 Config Addr(0x20) : 0xf600000c
 Config Addr(0x24) : 0x00000000
 Config Addr(0x28) : 0x00000000
 ***************************************************
 BusNum : 1, DevNum : 0, FuncNum : 6, ID : 0x643011ab
 ***************************************************

 PCI Info ...
 Config Addr(0x10) : 0x1c000004
 Config Addr(0x14) : 0x00000000
 Config Addr(0x18) : 0x1c800004
 Config Addr(0x1c) : 0x00000000
 Config Addr(0x20) : 0x1d000004
 Config Addr(0x24) : 0x00000000
 Config Addr(0x28) : 0x00000000
 ***************************************************
 BusNum : 1, DevNum : 0, FuncNum : 7, ID : 0x643011ab
 ***************************************************

 PCI Info ...
 Config Addr(0x10) : 0xff000004
 Config Addr(0x14) : 0x00000000
 Config Addr(0x18) : 0xff800004
 Config Addr(0x1c) : 0x00000000
 Config Addr(0x20) : 0x4200000c
 Config Addr(0x24) : 0x00000000
 Config Addr(0x28) : 0x00000000
***************************************************
 BusNum : 1, DevNum : 21, FuncNum : 0
 ***************************************************

 PCI Info ...
 Config Addr(0x10) : 0x9f000000
 Config Addr(0x14) : 0x00000000
 Config Addr(0x18) : 0xff000001
 Config Addr(0x1c) : 0x00000000
 Config Addr(0x20) : 0x00000000
 Config Addr(0x24) : 0x00000000
 Config Addr(0x28) : 0x00000000


----- Original Message -----
From: "Mark A. Greer" <mgreer@mvista.com>
To: "신경수" <ksshin@essetel.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Thursday, September 25, 2003 9:52 AM
Subject: Re: PCI DMA in GT64260


>
> Well there are a lot of things that could be wrong. I'd have to actually
> see your code to figure out what's wrong. Use
> arch/ppc/platforms/ev64260.c as an example, if you haven't already.
> Sorry I can't help more but there are simply too many possibilities and
> not enough info to narrow down the possibilities to suggest anything.
>
> Mark
> --
>
> 신경수 wrote:
>
> >Dear all.
> >
> >I have a board that consisted of mpc7410+gt64260+pci_device,
> >and I have already success to read/write the pci_device.
> >After init the pci_device, I command to the pci_device
> >that read data from main memory(sdram),
> >but, the pci_device does not operate and return only fail...
> >
> >I think that this is the DMA Problem...
> >so I want to know that how to set the register of gt64260 to do
> >DMA operation.
> >
> >I already set PCI SCS[0] Size Reg, PCI SCS[0] Base Addr Remap Reg,
> >and PCI Base Address Enable Reg. what I omitted? or ...
> >
> >please help me...
> >
> >Thanks everybody.
> >
> >
> >
> >
> >
> >
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
