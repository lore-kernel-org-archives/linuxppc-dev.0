Return-Path: <johaahn@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by ozlabs.org (Postfix) with ESMTP id A40FDDDF08
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Apr 2008 18:20:45 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 25so2455767wfa.15
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 02 Apr 2008 00:20:44 -0700 (PDT)
Message-ID: <7e0dd21a0804020020s66a091ferfbbf4142adcd84ae@mail.gmail.com>
Date: Wed, 2 Apr 2008 07:20:43 +0000
From: "Johann Baudy" <johaahn@gmail.com>
To: "Magnus Hjorth" <mh@omnisys.se>
Subject: Re: Xilinx LLTEMAC driver issues
In-Reply-To: <000601c8931f$e1d549a0$a57fdce0$@se>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_49_25935075.1207120843991"
References: <20080329125416.B09261AD8051@mail119-sin.bigfish.com>
	<20080329135813.B3832DE8062@mail60-sin.bigfish.com>
	<1206802234.5247.19.camel@magnus-desktop>
	<47F0AB74.4070802@so-logic.net> <000601c8931f$e1d549a0$a57fdce0$@se>
Cc: linuxppc-embedded@ozlabs.org, John Linn <John.Linn@xilinx.com>,
	git <git@xilinx.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_49_25935075.1207120843991
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I've solved this checksum offloading issue with this below patch.
It may help, if you need performance. It certainly needs review but it work=
s
on my side.

--- xilinxgit/drivers/net/xilinx_lltemac/xlltemac_main.c.orig    2008-03-21
09:11:43.000000000 +0100
+++ xilinxgit/drivers/net/xilinx_lltemac/xlltemac_main.c    2008-03-21
09:24:23.000000000 +0100
@@ -133,7 +133,7 @@
         (XLlDma_mBdRead((BdPtr), XLLDMA_BD_STSCTRL_USR0_OFFSET)) &
0xFFFFFFFE )

 #define BdCsumSetup(BdPtr, Start, Insert) \
-    XLlDma_mBdWrite((BdPtr), XLLDMA_BD_USR1_OFFSET, (Start) << 16 |
(Insert))
+    XLlDma_mBdWrite((BdPtr), XLLDMA_BD_USR1_OFFSET, ((Start) << 16) |
(Insert))

 /* Used for debugging */
 #define BdCsumInsert(BdPtr) \
@@ -1540,7 +1541,7 @@ static int xenet_DmaSend_internal(struct
     /*
      * if tx checksum offloading is enabled, when the ethernet stack
      * wants us to perform the checksum in hardware,
-     * skb->ip_summed is CHECKSUM_COMPLETE. Otherwise skb->ip_summed is
+     * skb->ip_summed is CHECKSUM_PARTIAL. Otherwise skb->ip_summed is
      * CHECKSUM_NONE, meaning the checksum is already done, or
      * CHECKSUM_UNNECESSARY, meaning checksumming is turned off (e.g.
      * loopback interface)
@@ -1565,9 +1566,11 @@ static int xenet_DmaSend_internal(struct
      * skb_transport_header(skb) points to the beginning of the ip header
      *
      */
-    if (skb->ip_summed =3D=3D CHECKSUM_COMPLETE) {
+    if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
+
+        unsigned int csum_start_off =3D skb_transport_offset(skb);
+        unsigned int csum_index_off =3D csum_start_off + skb->csum_offset;

-        unsigned char *raw =3D skb_transport_header(skb);
 #if 0
         {
             unsigned int csum =3D _xenet_tx_csum(skb);
@@ -1578,9 +1581,8 @@ static int xenet_DmaSend_internal(struct
         }
 #else
         BdCsumEnable(bd_ptr);
-        BdCsumSetup(bd_ptr, raw - skb->data,
-                (raw - skb->data) + skb->csum);
-
+        BdCsumSetup(bd_ptr, csum_start_off,
+                csum_index_off);
 #endif
         lp->tx_hw_csums++;
     }
@@ -3277,7 +3279,7 @@ static int __devinit xtenet_of_probe(str
     struct resource *r_irq =3D &r_irq_struct;    /* Interrupt resources */
     struct resource *r_mem =3D &r_mem_struct;    /* IO mem resources */
     struct xlltemac_platform_data *pdata =3D &pdata_struct;
-        void *mac_address;
+        const void *mac_address;
     int rc =3D 0;
     const phandle *llink_connected_handle;
     struct device_node *llink_connected_node;


On Mon, Mar 31, 2008 at 11:10 AM, Magnus Hjorth <mh@omnisys.se> wrote:

> Deactivating checksum offloading helped a lot! I still have some packet
> loss and not the best performance (TFTP transfer about 100 kbyte/s) but a=
t
> least it works.
>
> Thanks!
>
> //Magnus
>
> > -----Original Message-----
> > From: rza1 [mailto:rza1@so-logic.net]
> > Sent: den 31 mars 2008 11:14
> > To: Magnus Hjorth
> > Cc: John Linn; git; linuxppc-embedded@ozlabs.org
> > Subject: Re: Xilinx LLTEMAC driver issues
> >
> > Hi Magnus,
> >
> > 1.
> > I am using nearly the same versions then you and got the same problems
> > too ;-).
> > I think there are some problems with the checksum offloading.
> > Try to sniff the some packages (e.g. wireshark)...
> > For me ICMP (ping) worked but udp and tcp not (because off a wrong
> > checksum in the transport layer).
> > A quick solution is to just deactivate checksum offloading.
> >
> > 2.
> > I remember some problems with Virtex-4 presamples too.
> > There where problems with the hard-temac wrapper. You had to use 1.00.a
> > and not b version.
> > But I don't have these problems with the EDK 9.2sp2/ISE9.2sp3 anymore.
> >
> > all the best,
> > Robert
> >
> > Magnus Hjorth wrote:
> > > Hi John,
> > >
> > > Thanks for the very fast reply! Right now I'm not at work so I don't
> > > have the board or EDK here to test anything.
> > >
> > > I'm using checksum offload, but I don't know if DRE is enabled or not=
.
> I
> > > can't recall seeing any setting to enable/disable DRE..
> > >
> > > A few things that crossed my mind:
> > >
> > > Last year I did a design with EDK 8.2, back then there was an issue
> with
> > > the ML403 boards having an old revision of the FPGA which wasn't
> > > compatible with some versions of the IP core. There are no such
> version
> > > issues with the xps_ll_temac?
> > >
> > > I don't think that I had phy-addr set in the DTS file. Will test that
> on
> > > Monday.
> > >
> > > Best regards,
> > > Magnus
> > >
> > >
> > > On Sat, 2008-03-29 at 07:58 -0600, John Linn wrote:
> > >
> > >> Hi Magnus,
> > >>
> > >> Sorry to hear you're having problems with it.
> > >>
> > >> I am doing testing on an ML405 which is the same board but with a
> bigger
> > FPGA, but with ppc arch and I don't see this issue. I have done limited
> testing
> > with powerpc arch and the LL TEMAC, but I didn't see this issue there
> either.
> > Powerpc arch is definitely less mature in my experience than the ppc
> arch. I'll
> > do a quick test with my powerpc arch and make sure again I'm not seeing
> it.
> > >>
> > >> My kernel is from the Xilinx Git tree, but there have been a number
> of
> > changes we have pushed out so I don't know how long ago you pulled from
> the Git
> > tree.
> > >>
> > >> My EDK project is 10.1 so it's a little newer. I am using LL TEMAC
> 1.01a so
> > it's a little newer.  I reviewed the change log for the LL TEMAC and
> don't see
> > any big problems that were fixed in the newer versions, more new
> features.  I'll
> > check with some others here to see if I missed something there.
> > >>
> > >> I am using DMA also, but no DRE or checksum offload.  You didn't say
> anything
> > about those. I'm going to insert my mhs file that describes my system t=
o
> let you
> > compare your system configuration. It's not clear to me yet if you have
> a h/w or
> > s/w problem.
> > >>
> > >> I'll also insert some of my device tree with the LL TEMAC so you can
> compare
> > (ignore 16550 stuff as we are still working on that).
> > >>
> > >> Since you can't ping reliably I would probably focus on that since
> it's
> > simpler than the other issues you're seeing.
> > >>
> > >> Thanks,
> > >> John
> > >>
> > >>
> > >>
> > >> #
> >
> #########################################################################=
#####
> > >> # Created by Base System Builder Wizard for Xilinx EDK 10.1.1 Build
> > EDK_K_SP1.1
> > >> # Thu Feb 14 14:11:12 2008
> > >> # Target Board:  Xilinx Virtex 4 ML405 Evaluation Platform Rev 1
> > >> # Family:    virtex4
> > >> # Device:    xc4vfx20
> > >> # Package:   ff672
> > >> # Speed Grade:  -10
> > >> # Processor: ppc405_0
> > >> # Processor clock frequency: 300.00 MHz
> > >> # Bus clock frequency: 100.00 MHz
> > >> # On Chip Memory :   8 KB
> > >> # Total Off Chip Memory : 128 MB
> > >> # - DDR_SDRAM =3D 128 MB
> > >> #
> >
> #########################################################################=
#####
> > >>  PARAMETER VERSION =3D 2.1.0
> > >>
> > >>
> > >>  PORT fpga_0_RS232_Uart_sin_pin =3D fpga_0_RS232_Uart_sin, DIR =3D I
> > >>  PORT fpga_0_RS232_Uart_sout_pin =3D fpga_0_RS232_Uart_sout, DIR =3D=
 O
> > >>  PORT fpga_0_LEDs_4Bit_GPIO_IO_pin =3D fpga_0_LEDs_4Bit_GPIO_IO, DIR=
 =3D
> IO, VEC
> > =3D [0:3]
> > >>  PORT fpga_0_IIC_EEPROM_Scl_pin =3D fpga_0_IIC_EEPROM_Scl, DIR =3D I=
O
> > >>  PORT fpga_0_IIC_EEPROM_Sda_pin =3D fpga_0_IIC_EEPROM_Sda, DIR =3D I=
O
> > >>  PORT fpga_0_SysACE_CompactFlash_SysACE_CLK_pin =3D
> > fpga_0_SysACE_CompactFlash_SysACE_CLK, DIR =3D I
> > >>  PORT fpga_0_SysACE_CompactFlash_SysACE_MPA_pin =3D
> > fpga_0_SysACE_CompactFlash_SysACE_MPA, DIR =3D O, VEC =3D [6:1]
> > >>  PORT fpga_0_SysACE_CompactFlash_SysACE_MPD_pin =3D
> > fpga_0_SysACE_CompactFlash_SysACE_MPD, DIR =3D IO, VEC =3D [15:0]
> > >>  PORT fpga_0_SysACE_CompactFlash_SysACE_CEN_pin =3D
> > fpga_0_SysACE_CompactFlash_SysACE_CEN, DIR =3D O
> > >>  PORT fpga_0_SysACE_CompactFlash_SysACE_OEN_pin =3D
> > fpga_0_SysACE_CompactFlash_SysACE_OEN, DIR =3D O
> > >>  PORT fpga_0_SysACE_CompactFlash_SysACE_WEN_pin =3D
> > fpga_0_SysACE_CompactFlash_SysACE_WEN, DIR =3D O
> > >>  PORT fpga_0_SysACE_CompactFlash_SysACE_MPIRQ_pin =3D
> > fpga_0_SysACE_CompactFlash_SysACE_MPIRQ, DIR =3D I
> > >>  PORT fpga_0_DDR_SDRAM_DDR_Clk_pin =3D fpga_0_DDR_SDRAM_DDR_Clk, DIR=
 =3D
> O
> > >>  PORT fpga_0_DDR_SDRAM_DDR_Clk_n_pin =3D fpga_0_DDR_SDRAM_DDR_Clk_n,
> DIR =3D O
> > >>  PORT fpga_0_DDR_SDRAM_DDR_Addr_pin =3D fpga_0_DDR_SDRAM_DDR_Addr, D=
IR
> =3D O, VEC
> > =3D [12:0]
> > >>  PORT fpga_0_DDR_SDRAM_DDR_BankAddr_pin =3D
> fpga_0_DDR_SDRAM_DDR_BankAddr, DIR
> > =3D O, VEC =3D [1:0]
> > >>  PORT fpga_0_DDR_SDRAM_DDR_CAS_n_pin =3D fpga_0_DDR_SDRAM_DDR_CAS_n,
> DIR =3D O
> > >>  PORT fpga_0_DDR_SDRAM_DDR_CE_pin =3D fpga_0_DDR_SDRAM_DDR_CE, DIR =
=3D O
> > >>  PORT fpga_0_DDR_SDRAM_DDR_CS_n_pin =3D fpga_0_DDR_SDRAM_DDR_CS_n, D=
IR
> =3D O
> > >>  PORT fpga_0_DDR_SDRAM_DDR_RAS_n_pin =3D fpga_0_DDR_SDRAM_DDR_RAS_n,
> DIR =3D O
> > >>  PORT fpga_0_DDR_SDRAM_DDR_WE_n_pin =3D fpga_0_DDR_SDRAM_DDR_WE_n, D=
IR
> =3D O
> > >>  PORT fpga_0_DDR_SDRAM_DDR_DM_pin =3D fpga_0_DDR_SDRAM_DDR_DM, DIR =
=3D O,
> VEC =3D
> > [3:0]
> > >>  PORT fpga_0_DDR_SDRAM_DDR_DQS =3D fpga_0_DDR_SDRAM_DDR_DQS, DIR =3D=
 IO,
> VEC =3D
> > [3:0]
> > >>  PORT fpga_0_DDR_SDRAM_DDR_DQ =3D fpga_0_DDR_SDRAM_DDR_DQ, DIR =3D I=
O,
> VEC =3D
> > [31:0]
> > >>  PORT fpga_0_TriMode_MAC_GMII_GMII_TXD_0_pin =3D
> > fpga_0_TriMode_MAC_GMII_GMII_TXD_0, DIR =3D O, VEC =3D [7:0]
> > >>  PORT fpga_0_TriMode_MAC_GMII_GMII_TX_EN_0_pin =3D
> > fpga_0_TriMode_MAC_GMII_GMII_TX_EN_0, DIR =3D O
> > >>  PORT fpga_0_TriMode_MAC_GMII_GMII_TX_ER_0_pin =3D
> > fpga_0_TriMode_MAC_GMII_GMII_TX_ER_0, DIR =3D O
> > >>  PORT fpga_0_TriMode_MAC_GMII_GMII_TX_CLK_0_pin =3D
> > fpga_0_TriMode_MAC_GMII_GMII_TX_CLK_0, DIR =3D O
> > >>  PORT fpga_0_TriMode_MAC_GMII_GMII_RXD_0_pin =3D
> > fpga_0_TriMode_MAC_GMII_GMII_RXD_0, DIR =3D I, VEC =3D [7:0]
> > >>  PORT fpga_0_TriMode_MAC_GMII_GMII_RX_DV_0_pin =3D
> > fpga_0_TriMode_MAC_GMII_GMII_RX_DV_0, DIR =3D I
> > >>  PORT fpga_0_TriMode_MAC_GMII_GMII_RX_ER_0_pin =3D
> > fpga_0_TriMode_MAC_GMII_GMII_RX_ER_0, DIR =3D I
> > >>  PORT fpga_0_TriMode_MAC_GMII_GMII_RX_CLK_0_pin =3D
> > fpga_0_TriMode_MAC_GMII_GMII_RX_CLK_0, DIR =3D I
> > >>  PORT fpga_0_TriMode_MAC_GMII_MII_TX_CLK_0_pin =3D
> > fpga_0_TriMode_MAC_GMII_MII_TX_CLK_0, DIR =3D I
> > >>  PORT fpga_0_TriMode_MAC_GMII_MDIO_0_pin =3D
> fpga_0_TriMode_MAC_GMII_MDIO_0,
> > DIR =3D IO
> > >>  PORT fpga_0_TriMode_MAC_GMII_MDC_0_pin =3D
> fpga_0_TriMode_MAC_GMII_MDC_0, DIR
> > =3D O
> > >>  PORT fpga_0_TriMode_MAC_GMII_TemacPhy_RST_n_pin =3D
> > fpga_0_TriMode_MAC_GMII_TemacPhy_RST_n, DIR =3D O
> > >>  PORT sys_clk_pin =3D dcm_clk_s, DIR =3D I, SIGIS =3D CLK, CLK_FREQ =
=3D
> 100000000
> > >>  PORT sys_rst_pin =3D sys_rst_s, DIR =3D I, RST_POLARITY =3D 0, SIGI=
S =3D RST
> > >>
> > >>
> > >> BEGIN ppc405_virtex4
> > >>  PARAMETER INSTANCE =3D ppc405_0
> > >>  PARAMETER HW_VER =3D 2.01.a
> > >>  PARAMETER C_FASTEST_PLB_CLOCK =3D DPLB1
> > >>  PARAMETER C_IDCR_BASEADDR =3D 0b0100000000
> > >>  PARAMETER C_IDCR_HIGHADDR =3D 0b0111111111
> > >>  BUS_INTERFACE JTAGPPC =3D jtagppc_0_0
> > >>  BUS_INTERFACE IPLB0 =3D plb
> > >>  BUS_INTERFACE DPLB0 =3D plb
> > >>  BUS_INTERFACE IPLB1 =3D ppc405_0_iplb1
> > >>  BUS_INTERFACE DPLB1 =3D ppc405_0_dplb1
> > >>  BUS_INTERFACE RESETPPC =3D ppc_reset_bus
> > >>  PORT CPMC405CLOCK =3D proc_clk_s
> > >>  PORT EICC405EXTINPUTIRQ =3D EICC405EXTINPUTIRQ
> > >> END
> > >>
> > >> BEGIN jtagppc_cntlr
> > >>  PARAMETER INSTANCE =3D jtagppc_0
> > >>  PARAMETER HW_VER =3D 2.01.a
> > >>  BUS_INTERFACE JTAGPPC0 =3D jtagppc_0_0
> > >> END
> > >>
> > >> BEGIN plb_v46
> > >>  PARAMETER INSTANCE =3D plb
> > >>  PARAMETER C_DCR_INTFCE =3D 0
> > >>  PARAMETER C_NUM_CLK_PLB2OPB_REARB =3D 100
> > >>  PARAMETER HW_VER =3D 1.02.a
> > >>  PORT PLB_Clk =3D sys_clk_s
> > >>  PORT SYS_Rst =3D sys_bus_reset
> > >> END
> > >>
> > >> BEGIN xps_bram_if_cntlr
> > >>  PARAMETER INSTANCE =3D xps_bram_if_cntlr_1
> > >>  PARAMETER HW_VER =3D 1.00.a
> > >>  PARAMETER C_SPLB_NATIVE_DWIDTH =3D 64
> > >>  PARAMETER C_BASEADDR =3D 0xffffe000
> > >>  PARAMETER C_HIGHADDR =3D 0xffffffff
> > >>  BUS_INTERFACE SPLB =3D plb
> > >>  BUS_INTERFACE PORTA =3D xps_bram_if_cntlr_1_port
> > >> END
> > >>
> > >> BEGIN bram_block
> > >>  PARAMETER INSTANCE =3D plb_bram_if_cntlr_1_bram
> > >>  PARAMETER HW_VER =3D 1.00.a
> > >>  BUS_INTERFACE PORTA =3D xps_bram_if_cntlr_1_port
> > >> END
> > >>
> > >> BEGIN xps_uart16550
> > >>  PARAMETER INSTANCE =3D RS232_Uart
> > >>  PARAMETER HW_VER =3D 2.00.a
> > >>  PARAMETER C_IS_A_16550 =3D 1
> > >>  PARAMETER C_BASEADDR =3D 0x83e00000
> > >>  PARAMETER C_HIGHADDR =3D 0x83e0ffff
> > >>  BUS_INTERFACE SPLB =3D plb
> > >>  PORT sin =3D fpga_0_RS232_Uart_sin
> > >>  PORT sout =3D fpga_0_RS232_Uart_sout
> > >>  PORT IP2INTC_Irpt =3D RS232_Uart_IP2INTC_Irpt
> > >> END
> > >>
> > >> BEGIN xps_gpio
> > >>  PARAMETER INSTANCE =3D LEDs_4Bit
> > >>  PARAMETER HW_VER =3D 1.00.a
> > >>  PARAMETER C_INTERRUPT_PRESENT =3D 1
> > >>  PARAMETER C_GPIO_WIDTH =3D 4
> > >>  PARAMETER C_IS_DUAL =3D 0
> > >>  PARAMETER C_IS_BIDIR =3D 1
> > >>  PARAMETER C_ALL_INPUTS =3D 0
> > >>  PARAMETER C_BASEADDR =3D 0x81400000
> > >>  PARAMETER C_HIGHADDR =3D 0x8140ffff
> > >>  BUS_INTERFACE SPLB =3D plb
> > >>  PORT GPIO_IO =3D fpga_0_LEDs_4Bit_GPIO_IO
> > >>  PORT IP2INTC_Irpt =3D LEDs_4Bit_IP2INTC_Irpt
> > >> END
> > >>
> > >> BEGIN xps_iic
> > >>  PARAMETER INSTANCE =3D IIC_EEPROM
> > >>  PARAMETER HW_VER =3D 2.00.a
> > >>  PARAMETER C_CLK_FREQ =3D 100000000
> > >>  PARAMETER C_IIC_FREQ =3D 100000
> > >>  PARAMETER C_TEN_BIT_ADR =3D 0
> > >>  PARAMETER C_BASEADDR =3D 0x81600000
> > >>  PARAMETER C_HIGHADDR =3D 0x8160ffff
> > >>  BUS_INTERFACE SPLB =3D plb
> > >>  PORT Scl =3D fpga_0_IIC_EEPROM_Scl
> > >>  PORT Sda =3D fpga_0_IIC_EEPROM_Sda
> > >>  PORT IIC2INTC_Irpt =3D IIC_EEPROM_IIC2INTC_Irpt
> > >> END
> > >>
> > >> BEGIN xps_sysace
> > >>  PARAMETER INSTANCE =3D SysACE_CompactFlash
> > >>  PARAMETER HW_VER =3D 1.00.a
> > >>  PARAMETER C_MEM_WIDTH =3D 16
> > >>  PARAMETER C_BASEADDR =3D 0x83600000
> > >>  PARAMETER C_HIGHADDR =3D 0x8360ffff
> > >>  BUS_INTERFACE SPLB =3D plb
> > >>  PORT SysACE_CLK =3D fpga_0_SysACE_CompactFlash_SysACE_CLK
> > >>  PORT SysACE_MPA =3D fpga_0_SysACE_CompactFlash_SysACE_MPA_split
> > >>  PORT SysACE_MPD =3D fpga_0_SysACE_CompactFlash_SysACE_MPD
> > >>  PORT SysACE_CEN =3D fpga_0_SysACE_CompactFlash_SysACE_CEN
> > >>  PORT SysACE_OEN =3D fpga_0_SysACE_CompactFlash_SysACE_OEN
> > >>  PORT SysACE_WEN =3D fpga_0_SysACE_CompactFlash_SysACE_WEN
> > >>  PORT SysACE_MPIRQ =3D fpga_0_SysACE_CompactFlash_SysACE_MPIRQ
> > >>  PORT SysACE_IRQ =3D SysACE_CompactFlash_SysACE_IRQ
> > >> END
> > >>
> > >> BEGIN mpmc
> > >>  PARAMETER INSTANCE =3D DDR_SDRAM
> > >>  PARAMETER HW_VER =3D 4.00.a
> > >>  PARAMETER C_NUM_PORTS =3D 3
> > >>  PARAMETER C_MEM_PARTNO =3D HYB25D512160BE-5
> > >>  PARAMETER C_MEM_DATA_WIDTH =3D 32
> > >>  PARAMETER C_MEM_DQS_WIDTH =3D 4
> > >>  PARAMETER C_MEM_DM_WIDTH =3D 4
> > >>  PARAMETER C_MEM_TYPE =3D DDR
> > >>  PARAMETER C_NUM_IDELAYCTRL =3D 2
> > >>  PARAMETER C_IDELAYCTRL_LOC =3D IDELAYCTRL_X0Y3-IDELAYCTRL_X0Y2
> > >>  PARAMETER C_PIM0_BASETYPE =3D 2
> > >>  PARAMETER C_PIM1_BASETYPE =3D 2
> > >>  PARAMETER C_PIM2_BASETYPE =3D 3
> > >>  PARAMETER C_MPMC_CLK0_PERIOD_PS =3D 10000
> > >>  PARAMETER C_SDMA2_PI2LL_CLK_RATIO =3D 1
> > >>  PARAMETER C_MPMC_BASEADDR =3D 0x00000000
> > >>  PARAMETER C_MPMC_HIGHADDR =3D 0x07ffffff
> > >>  PARAMETER C_SDMA_CTRL_BASEADDR =3D 0x84600000
> > >>  PARAMETER C_SDMA_CTRL_HIGHADDR =3D 0x8460ffff
> > >>  BUS_INTERFACE SPLB0 =3D ppc405_0_iplb1
> > >>  BUS_INTERFACE SPLB1 =3D ppc405_0_dplb1
> > >>  BUS_INTERFACE SDMA_LL2 =3D TriMode_MAC_GMII_LLINK0
> > >>  BUS_INTERFACE SDMA_CTRL2 =3D plb
> > >>  PORT DDR_Addr =3D fpga_0_DDR_SDRAM_DDR_Addr
> > >>  PORT DDR_BankAddr =3D fpga_0_DDR_SDRAM_DDR_BankAddr
> > >>  PORT DDR_CAS_n =3D fpga_0_DDR_SDRAM_DDR_CAS_n
> > >>  PORT DDR_CE =3D fpga_0_DDR_SDRAM_DDR_CE
> > >>  PORT DDR_CS_n =3D fpga_0_DDR_SDRAM_DDR_CS_n
> > >>  PORT DDR_RAS_n =3D fpga_0_DDR_SDRAM_DDR_RAS_n
> > >>  PORT DDR_WE_n =3D fpga_0_DDR_SDRAM_DDR_WE_n
> > >>  PORT DDR_DM =3D fpga_0_DDR_SDRAM_DDR_DM
> > >>  PORT DDR_DQS =3D fpga_0_DDR_SDRAM_DDR_DQS
> > >>  PORT DDR_DQ =3D fpga_0_DDR_SDRAM_DDR_DQ
> > >>  PORT DDR_Clk =3D fpga_0_DDR_SDRAM_DDR_Clk
> > >>  PORT DDR_Clk_n =3D fpga_0_DDR_SDRAM_DDR_Clk_n
> > >>  PORT MPMC_Clk0 =3D sys_clk_s
> > >>  PORT MPMC_Clk90 =3D DDR_SDRAM_mpmc_clk_90_s
> > >>  PORT SDMA2_Clk =3D sys_clk_s
> > >>  PORT MPMC_Clk_200MHz =3D clk_200mhz_s
> > >>  PORT MPMC_Rst =3D sys_periph_reset
> > >>  PORT SDMA2_Rx_IntOut =3D DDR_SDRAM_SDMA2_Rx_IntOut
> > >>  PORT SDMA2_Tx_IntOut =3D DDR_SDRAM_SDMA2_Tx_IntOut
> > >> END
> > >>
> > >> BEGIN xps_ll_temac
> > >>  PARAMETER INSTANCE =3D TriMode_MAC_GMII
> > >>  PARAMETER HW_VER =3D 1.01.a
> > >>  PARAMETER C_SPLB_CLK_PERIOD_PS =3D 10000
> > >>  PARAMETER C_PHY_TYPE =3D 1
> > >>  PARAMETER C_NUM_IDELAYCTRL =3D 4
> > >>  PARAMETER C_IDELAYCTRL_LOC =3D IDELAYCTRL_X1Y1-IDELAYCTRL_X1Y3-
> > IDELAYCTRL_X2Y2-IDELAYCTRL_X2Y3
> > >>  PARAMETER C_TEMAC_TYPE =3D 1
> > >>  PARAMETER C_BUS2CORE_CLK_RATIO =3D 1
> > >>  PARAMETER C_BASEADDR =3D 0x81c00000
> > >>  PARAMETER C_HIGHADDR =3D 0x81c0ffff
> > >>  BUS_INTERFACE SPLB =3D plb
> > >>  BUS_INTERFACE LLINK0 =3D TriMode_MAC_GMII_LLINK0
> > >>  PORT GMII_TXD_0 =3D fpga_0_TriMode_MAC_GMII_GMII_TXD_0
> > >>  PORT GMII_TX_EN_0 =3D fpga_0_TriMode_MAC_GMII_GMII_TX_EN_0
> > >>  PORT GMII_TX_ER_0 =3D fpga_0_TriMode_MAC_GMII_GMII_TX_ER_0
> > >>  PORT GMII_TX_CLK_0 =3D fpga_0_TriMode_MAC_GMII_GMII_TX_CLK_0
> > >>  PORT GMII_RXD_0 =3D fpga_0_TriMode_MAC_GMII_GMII_RXD_0
> > >>  PORT GMII_RX_DV_0 =3D fpga_0_TriMode_MAC_GMII_GMII_RX_DV_0
> > >>  PORT GMII_RX_ER_0 =3D fpga_0_TriMode_MAC_GMII_GMII_RX_ER_0
> > >>  PORT GMII_RX_CLK_0 =3D fpga_0_TriMode_MAC_GMII_GMII_RX_CLK_0
> > >>  PORT MII_TX_CLK_0 =3D fpga_0_TriMode_MAC_GMII_MII_TX_CLK_0
> > >>  PORT MDIO_0 =3D fpga_0_TriMode_MAC_GMII_MDIO_0
> > >>  PORT MDC_0 =3D fpga_0_TriMode_MAC_GMII_MDC_0
> > >>  PORT TemacPhy_RST_n =3D fpga_0_TriMode_MAC_GMII_TemacPhy_RST_n
> > >>  PORT GTX_CLK_0 =3D temac_clk_s
> > >>  PORT REFCLK =3D clk_200mhz_s
> > >>  PORT LlinkTemac0_CLK =3D sys_clk_s
> > >>  PORT TemacIntc0_Irpt =3D TriMode_MAC_GMII_TemacIntc0_Irpt
> > >> END
> > >>
> > >> BEGIN util_bus_split
> > >>  PARAMETER INSTANCE =3D SysACE_CompactFlash_util_bus_split_0
> > >>  PARAMETER HW_VER =3D 1.00.a
> > >>  PARAMETER C_SIZE_IN =3D 7
> > >>  PARAMETER C_LEFT_POS =3D 0
> > >>  PARAMETER C_SPLIT =3D 6
> > >>  PORT Sig =3D fpga_0_SysACE_CompactFlash_SysACE_MPA_split
> > >>  PORT Out1 =3D fpga_0_SysACE_CompactFlash_SysACE_MPA
> > >> END
> > >>
> > >> BEGIN plb_v46
> > >>  PARAMETER INSTANCE =3D ppc405_0_iplb1
> > >>  PARAMETER HW_VER =3D 1.02.a
> > >>  PORT PLB_Clk =3D sys_clk_s
> > >>  PORT SYS_Rst =3D sys_bus_reset
> > >> END
> > >>
> > >> BEGIN plb_v46
> > >>  PARAMETER INSTANCE =3D ppc405_0_dplb1
> > >>  PARAMETER HW_VER =3D 1.02.a
> > >>  PORT PLB_Clk =3D sys_clk_s
> > >>  PORT SYS_Rst =3D sys_bus_reset
> > >> END
> > >>
> > >> BEGIN clock_generator
> > >>  PARAMETER INSTANCE =3D clock_generator_0
> > >>  PARAMETER HW_VER =3D 2.00.a
> > >>  PARAMETER C_EXT_RESET_HIGH =3D 1
> > >>  PARAMETER C_CLKIN_FREQ =3D 100000000
> > >>  PARAMETER C_CLKOUT0_FREQ =3D 100000000
> > >>  PARAMETER C_CLKOUT0_BUF =3D TRUE
> > >>  PARAMETER C_CLKOUT0_PHASE =3D 0
> > >>  PARAMETER C_CLKOUT0_GROUP =3D DCM0
> > >>  PARAMETER C_CLKOUT1_FREQ =3D 100000000
> > >>  PARAMETER C_CLKOUT1_BUF =3D TRUE
> > >>  PARAMETER C_CLKOUT1_PHASE =3D 90
> > >>  PARAMETER C_CLKOUT1_GROUP =3D DCM0
> > >>  PARAMETER C_CLKOUT2_FREQ =3D 300000000
> > >>  PARAMETER C_CLKOUT2_BUF =3D TRUE
> > >>  PARAMETER C_CLKOUT2_PHASE =3D 0
> > >>  PARAMETER C_CLKOUT2_GROUP =3D DCM0
> > >>  PARAMETER C_CLKOUT3_FREQ =3D 200000000
> > >>  PARAMETER C_CLKOUT3_BUF =3D TRUE
> > >>  PARAMETER C_CLKOUT3_PHASE =3D 0
> > >>  PARAMETER C_CLKOUT3_GROUP =3D NONE
> > >>  PARAMETER C_CLKOUT4_FREQ =3D 125000000
> > >>  PARAMETER C_CLKOUT4_BUF =3D TRUE
> > >>  PARAMETER C_CLKOUT4_PHASE =3D 0
> > >>  PARAMETER C_CLKOUT4_GROUP =3D NONE
> > >>  PORT CLKOUT0 =3D sys_clk_s
> > >>  PORT CLKOUT1 =3D DDR_SDRAM_mpmc_clk_90_s
> > >>  PORT CLKOUT2 =3D proc_clk_s
> > >>  PORT CLKOUT3 =3D clk_200mhz_s
> > >>  PORT CLKOUT4 =3D temac_clk_s
> > >>  PORT CLKIN =3D dcm_clk_s
> > >>  PORT LOCKED =3D Dcm_all_locked
> > >>  PORT RST =3D net_gnd
> > >> END
> > >>
> > >> BEGIN proc_sys_reset
> > >>  PARAMETER INSTANCE =3D proc_sys_reset_0
> > >>  PARAMETER HW_VER =3D 2.00.a
> > >>  PARAMETER C_EXT_RESET_HIGH =3D 0
> > >>  BUS_INTERFACE RESETPPC0 =3D ppc_reset_bus
> > >>  PORT Slowest_sync_clk =3D sys_clk_s
> > >>  PORT Dcm_locked =3D Dcm_all_locked
> > >>  PORT Ext_Reset_In =3D sys_rst_s
> > >>  PORT Bus_Struct_Reset =3D sys_bus_reset
> > >>  PORT Peripheral_Reset =3D sys_periph_reset
> > >> END
> > >>
> > >> BEGIN xps_intc
> > >>  PARAMETER INSTANCE =3D xps_intc_0
> > >>  PARAMETER HW_VER =3D 1.00.a
> > >>  PARAMETER C_BASEADDR =3D 0x81800000
> > >>  PARAMETER C_HIGHADDR =3D 0x8180ffff
> > >>  BUS_INTERFACE SPLB =3D plb
> > >>  PORT Irq =3D EICC405EXTINPUTIRQ
> > >>  PORT Intr =3D RS232_Uart_IP2INTC_Irpt & LEDs_4Bit_IP2INTC_Irpt &
> > IIC_EEPROM_IIC2INTC_Irpt & SysACE_CompactFlash_SysACE_IRQ &
> > TriMode_MAC_GMII_TemacIntc0_Irpt & DDR_SDRAM_SDMA2_Rx_IntOut &
> > DDR_SDRAM_SDMA2_Tx_IntOut
> > >> END
> > >>
> > >>
> > >>
> > >>    #address-cells =3D <1>;
> > >>    #size-cells =3D <1>;
> > >>    compatible =3D "xlnx,virtex";
> > >>    model =3D "testing";
> > >>    DDR_SDRAM: memory@0 {
> > >>            device_type =3D "memory";
> > >>            reg =3D < 0 8000000 >;
> > >>    } ;
> > >>    chosen {
> > >>            bootargs =3D "console=3DttyS0,9600 ip=3Don
> > nfsroot=3D172.16.40.76:/v2pclients/jhl26,tcp";
> > >>            linux,stdout-path =3D "/plb@0/serial@83e00000";
> > >>    } ;
> > >>    cpus {
> > >>            #address-cells =3D <1>;
> > >>            #cpus =3D <1>;
> > >>            #size-cells =3D <0>;
> > >>            ppc405_0: cpu@0 {
> > >>                    clock-frequency =3D <11e1a300>;
> > >>                    compatible =3D "PowerPC,405", "ibm,ppc405";
> > >>                    d-cache-line-size =3D <20>;
> > >>                    d-cache-size =3D <4000>;
> > >>                    device_type =3D "cpu";
> > >>                    i-cache-line-size =3D <20>;
> > >>                    i-cache-size =3D <4000>;
> > >>                    model =3D "PowerPC,405";
> > >>                    reg =3D <0>;
> > >>                    timebase-frequency =3D <11e1a300>;
> > >>                    xlnx,apu-control =3D <de00>;
> > >>                    xlnx,apu-udi-1 =3D <a18983>;
> > >>                    xlnx,apu-udi-2 =3D <a38983>;
> > >>                    xlnx,apu-udi-3 =3D <a589c3>;
> > >>                    xlnx,apu-udi-4 =3D <a789c3>;
> > >>                    xlnx,apu-udi-5 =3D <a98c03>;
> > >>                    xlnx,apu-udi-6 =3D <ab8c03>;
> > >>                    xlnx,apu-udi-7 =3D <ad8c43>;
> > >>                    xlnx,apu-udi-8 =3D <af8c43>;
> > >>                    xlnx,deterministic-mult =3D <0>;
> > >>                    xlnx,disable-operand-forwarding =3D <1>;
> > >>                    xlnx,fastest-plb-clock =3D "DPLB0";
> > >>                    xlnx,generate-plb-timespecs =3D <1>;
> > >>                    xlnx,mmu-enable =3D <1>;
> > >>                    xlnx,pvr-high =3D <0>;
> > >>                    xlnx,pvr-low =3D <0>;
> > >>            } ;
> > >>    } ;
> > >>    plb: plb@0 {
> > >>            #address-cells =3D <1>;
> > >>            #size-cells =3D <1>;
> > >>            compatible =3D "xlnx,plb-v46-1.02.a";
> > >>            ranges ;
> > >>            IIC_EEPROM: i2c@81600000 {
> > >>                    compatible =3D "xlnx,xps-iic-2.00.a";
> > >>                    interrupt-parent =3D <&xps_intc_0>;
> > >>                    interrupts =3D < 4 2 >;
> > >>                    reg =3D < 81600000 10000 >;
> > >>                    xlnx,clk-freq =3D <5f5e100>;
> > >>                    xlnx,family =3D "virtex4";
> > >>                    xlnx,gpo-width =3D <1>;
> > >>                    xlnx,iic-freq =3D <186a0>;
> > >>                    xlnx,scl-inertial-delay =3D <0>;
> > >>                    xlnx,sda-inertial-delay =3D <0>;
> > >>                    xlnx,ten-bit-adr =3D <0>;
> > >>            } ;
> > >>            LEDs_4Bit: gpio@81400000 {
> > >>                    compatible =3D "xlnx,xps-gpio-1.00.a";
> > >>                    interrupt-parent =3D <&xps_intc_0>;
> > >>                    interrupts =3D < 5 2 >;
> > >>                    reg =3D < 81400000 10000 >;
> > >>                    xlnx,all-inputs =3D <0>;
> > >>                    xlnx,all-inputs-2 =3D <0>;
> > >>                    xlnx,dout-default =3D <0>;
> > >>                    xlnx,dout-default-2 =3D <0>;
> > >>                    xlnx,family =3D "virtex4";
> > >>                    xlnx,gpio-width =3D <4>;
> > >>                    xlnx,interrupt-present =3D <1>;
> > >>                    xlnx,is-bidir =3D <1>;
> > >>                    xlnx,is-bidir-2 =3D <1>;
> > >>                    xlnx,is-dual =3D <0>;
> > >>                    xlnx,tri-default =3D <ffffffff>;
> > >>                    xlnx,tri-default-2 =3D <ffffffff>;
> > >>            } ;
> > >>            RS232_Uart: serial@83e00000 {
> > >>                    compatible =3D "xlnx,xps-uart16550-2.00.a";
> > >> //                 compatible =3D "ns16550";
> > >>                    device_type =3D "serial";
> > >>                    interrupt-parent =3D <&xps_intc_0>;
> > >>                    interrupts =3D < 6 2 >;
> > >>                    reg =3D < 83e00000 10000 >;
> > >>                    current-speed =3D <d#9600>;
> > >>                    clock-frequency =3D <d#100000000>;  /* added
> > by jhl */
> > >>                    reg-shift =3D <2>;
> > >>                    xlnx,family =3D "virtex4";
> > >>                    xlnx,has-external-rclk =3D <0>;
> > >>                    xlnx,has-external-xin =3D <0>;
> > >>                    xlnx,is-a-16550 =3D <1>;
> > >>            } ;
> > >>            SysACE_CompactFlash: sysace@83600000 {
> > >>                    compatible =3D "xlnx,xps-sysace-1.00.a";
> > >>                    interrupt-parent =3D <&xps_intc_0>;
> > >>                    interrupts =3D < 3 2 >;
> > >>                    reg =3D < 83600000 10000 >;
> > >>                    xlnx,family =3D "virtex4";
> > >>                    xlnx,mem-width =3D <10>;
> > >>            } ;
> > >>            TriMode_MAC_GMII: xps-ll-temac@81c00000 {
> > >>                    #address-cells =3D <1>;
> > >>                    #size-cells =3D <1>;
> > >>                    compatible =3D "xlnx,compound";
> > >>                    ethernet@81c00000 {
> > >>                            compatible =3D "xlnx,xps-ll-temac-
> > 1.01.a";
> > >>                            device_type =3D "network";
> > >>                            interrupt-parent =3D
> > <&xps_intc_0>;
> > >>                            interrupts =3D < 2 2 >;
> > >>                            llink-connected =3D <&PIM2>;
> > >>                            local-mac-address =3D [ 02 00 00
> > 00 00 01 ];
> > >>                            reg =3D < 81c00000 40 >;
> > >>                            xlnx,bus2core-clk-ratio =3D <1>;
> > >>                            xlnx,phy-type =3D <1>;
> > >>                            xlnx,phyaddr =3D <1>;
> > >>                            xlnx,rxcsum =3D <0>;
> > >>                            xlnx,rxfifo =3D <1000>;
> > >>                            xlnx,temac-type =3D <1>;
> > >>                            xlnx,txcsum =3D <0>;
> > >>                            xlnx,txfifo =3D <1000>;
> > >>                    } ;
> > >>            } ;
> > >>            mpmc@0 {
> > >>                    #address-cells =3D <1>;
> > >>                    #size-cells =3D <1>;
> > >>                    compatible =3D "xlnx,mpmc-4.00.a";
> > >>                    PIM2: sdma@84600100 {
> > >>                            compatible =3D "xlnx,ll-dma-
> > 1.00.a";
> > >>                            interrupt-parent =3D
> > <&xps_intc_0>;
> > >>                            interrupts =3D < 1 2 0 2 >;
> > >>                            reg =3D < 84600100 80 >;
> > >>                    } ;
> > >>            } ;
> > >>            xps_bram_if_cntlr_1: xps-bram-if-cntlr@ffffe000 {
> > >>                    compatible =3D "xlnx,xps-bram-if-cntlr-
> > 1.00.a";
> > >>                    reg =3D < ffffe000 2000 >;
> > >>                    xlnx,family =3D "virtex4";
> > >>            } ;
> > >>            xps_intc_0: interrupt-controller@81800000 {
> > >>                    #interrupt-cells =3D <2>;
> > >>                    compatible =3D "xlnx,xps-intc-1.00.a";
> > >>                    interrupt-controller ;
> > >>                    reg =3D < 81800000 10000 >;
> > >>                    xlnx,num-intr-inputs =3D <7>;
> > >>            } ;
> > >>    } ;
> > >>    ppc405_0_dplb1: plb@1 {
> > >>            #address-cells =3D <1>;
> > >>            #size-cells =3D <1>;
> > >>            compatible =3D "xlnx,plb-v46-1.02.a";
> > >>            ranges ;
> > >>    } ;
> > >> }  ;
> > >>
> > >>
> > >>
> > >> -----Original Message-----
> > >> From: Magnus Hjorth [mailto:mh@omnisys.se]
> > >> Sent: Saturday, March 29, 2008 6:54 AM
> > >> To: git
> > >> Cc: linuxppc-embedded@ozlabs.org
> > >> Subject: Xilinx LLTEMAC driver issues
> > >>
> > >> Hi,
> > >>
> > >> I'm having some networking troubles with the Xilinx LLTEMAC driver
> from the
> > >> Xilinx Linux git tree (powerpc arch) on an ML403 board. EDK9.2SP2,
> > >> xps_ll_temac v1.00.b
> > >>
> > >> The weird thing is, that it sort of half works. It successfully make=
s
> a DHCP
> > >> request and gets its IP address. I tried setting up a tftpd server,
> and I can
> > >> see UDP requests coming in but the response doesn't seem to come out=
.
> I also
> > >> tried running a TCP server on the board, and it can see and accept
> incoming
> > >> connections but after that no data seems to get through. I can ping
> out and
> > >> get around 40% packet loss.
> > >>
> > >> Looking at /proc/interrupts, I can see both TxDma interrupts and
> RxDma
> > >> interrupts. No eth0 interrupts but that seems to be OK judging by th=
e
> driver
> > >> source comments. Ifconfig shows no collistions, no dropped packets,
> no
> > errors,
> > >> so the system seems to think that everything is OK.
> > >>
> > >> Clues anyone? I'm starting to run out of ideas...
> > >>
> > >> Best regards,
> > >> Magnus
> > >>
> > >>
> > >> --
> > >>
> > >> Magnus Hjorth, M.Sc.
> > >> Omnisys Instruments AB
> > >> Gruvgatan 8
> > >> SE-421 30  V=E4stra Fr=F6lunda, SWEDEN
> > >> Phone: +46 31 734 34 09
> > >> Fax: +46 31 734 34 29
> > >> http://www.omnisys.se
> > >>
> > >
> > > _______________________________________________
> > > Linuxppc-embedded mailing list
> > > Linuxppc-embedded@ozlabs.org
> > > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>



--=20
Johann Baudy
johaahn@gmail.com

------=_Part_49_25935075.1207120843991
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I&#39;ve solved this checksum offloading issue with this below patch.<br>It=
 may help, if you need performance. It certainly needs review but it works =
on my side.<br><br>--- xilinxgit/drivers/net/xilinx<div id=3D"1fiv" class=
=3D"ArwC7c ckChnd">
_lltemac/xlltemac_main.c.orig&nbsp;&nbsp; &nbsp;2008-03-21 09:11:43.0000000=
00 +0100<br>
+++ xilinxgit/drivers/net/xilinx_lltemac/xlltemac_main.c&nbsp;&nbsp; &nbsp;=
2008-03-21 09:24:23.000000000 +0100<br>@@ -133,7 +133,7 @@<br>&nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp; &nbsp;(XLlDma_mBdRead((BdPtr), XLLDMA_BD_STSCTRL_U=
SR0_OFFSET)) &amp; 0xFFFFFFFE )<br>&nbsp;<br>&nbsp;#define BdCsumSetup(BdPt=
r, Start, Insert) \<br>

-&nbsp;&nbsp;&nbsp; XLlDma_mBdWrite((BdPtr), XLLDMA_BD_USR1_OFFSET, (Start)=
 &lt;&lt; 16 | (Insert))<br>+&nbsp;&nbsp;&nbsp; XLlDma_mBdWrite((BdPtr), XL=
LDMA_BD_USR1_OFFSET, ((Start) &lt;&lt; 16) | (Insert))<br>&nbsp;<br>&nbsp;/=
* Used for debugging */<br>&nbsp;#define BdCsumInsert(BdPtr) \<br>
@@ -1540,7 +1541,7 @@ static int xenet_DmaSend_internal(struct<br>&nbsp;&nb=
sp;&nbsp;&nbsp; /*<br>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;* if tx checksum offlo=
ading is enabled, when the ethernet stack<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;* wants us to perform the checksum in hardwa=
re,<br>-&nbsp;&nbsp;&nbsp; &nbsp;* skb-&gt;ip_summed is CHECKSUM_COMPLETE. =
Otherwise skb-&gt;ip_summed is<br>+&nbsp;&nbsp;&nbsp; &nbsp;* skb-&gt;ip_su=
mmed is CHECKSUM_PARTIAL. Otherwise skb-&gt;ip_summed is<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;* CHECKSUM_NONE, meaning the checksum is alr=
eady done, or<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;* CHECKSUM_UNNECESSARY, meaning checksumming=
 is turned off (e.g.<br>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;* loopback interface=
)<br>@@ -1565,9 +1566,11 @@ static int xenet_DmaSend_internal(struct<br>&nb=
sp;&nbsp;&nbsp;&nbsp; &nbsp;* skb_transport_header(skb) points to the begin=
ning of the ip header<br>

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;*<br>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;*/<br>-&=
nbsp;&nbsp;&nbsp; if (skb-&gt;ip_summed =3D=3D CHECKSUM_COMPLETE) {<br>+&nb=
sp;&nbsp;&nbsp; if (skb-&gt;ip_summed =3D=3D CHECKSUM_PARTIAL) {<br>+<br>+&=
nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; unsigned int csum_start_off =3D skb_tr=
ansport_offset(skb);<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; unsigned int=
 csum_index_off =3D csum_start_off + skb-&gt;csum_offset;<br>

&nbsp;<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; unsigned char *raw =3D skb=
_transport_header(skb);<br>&nbsp;#if 0<br>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; unsigned int csum =3D _xenet_tx_csum(skb);<br>@@ -1578,9 +1581,8 @@ sta=
tic int xenet_DmaSend_internal(struct<br>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; }<br>

&nbsp;#else<br>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; BdCsumEnable(bd_=
ptr);<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; BdCsumSetup(bd_ptr, raw - s=
kb-&gt;data,<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; (raw - skb-&gt;data) + skb-&gt;csum);<br>-<br>+&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; BdCsumSetup(bd_ptr, csum_start_off,<br>+&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; csum_i=
ndex_off);<br>

&nbsp;#endif<br>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; lp-&gt;tx_hw_cs=
ums++;<br>&nbsp;&nbsp;&nbsp;&nbsp; }<br>@@ -3277,7 +3279,7 @@ static int __=
devinit xtenet_of_probe(str<br>&nbsp;&nbsp;&nbsp;&nbsp; struct resource *r_=
irq =3D &amp;r_irq_struct;&nbsp;&nbsp;&nbsp; /* Interrupt resources */<br>&=
nbsp;&nbsp;&nbsp;&nbsp; struct resource *r_mem =3D &amp;r_mem_struct;&nbsp;=
&nbsp;&nbsp; /* IO mem resources */<br>

&nbsp;&nbsp;&nbsp;&nbsp; struct xlltemac_platform_data *pdata =3D &amp;pdat=
a_struct;<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *mac_address;=
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const void *mac_address;<br=
>&nbsp;&nbsp;&nbsp;&nbsp; int rc =3D 0;<br>&nbsp;&nbsp;&nbsp;&nbsp; const p=
handle *llink_connected_handle;<br>&nbsp;&nbsp;&nbsp;&nbsp; struct device_n=
ode *llink_connected_node;</div>
<br><br><div class=3D"gmail_quote">On Mon, Mar 31, 2008 at 11:10 AM, Magnus=
 Hjorth &lt;<a href=3D"mailto:mh@omnisys.se">mh@omnisys.se</a>&gt; wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204=
, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Deactivating checksum offloading helped a lot! I still have some packet los=
s and not the best performance (TFTP transfer about 100 kbyte/s) but at lea=
st it works.<br>
<br>
Thanks!<br>
<font color=3D"#888888"><br>
//Magnus<br>
</font><div><div></div><div class=3D"Wj3C7c"><br>
&gt; -----Original Message-----<br>
&gt; From: rza1 [mailto:<a href=3D"mailto:rza1@so-logic.net">rza1@so-logic.=
net</a>]<br>
&gt; Sent: den 31 mars 2008 11:14<br>
&gt; To: Magnus Hjorth<br>
&gt; Cc: John Linn; git; <a href=3D"mailto:linuxppc-embedded@ozlabs.org">li=
nuxppc-embedded@ozlabs.org</a><br>
&gt; Subject: Re: Xilinx LLTEMAC driver issues<br>
&gt;<br>
&gt; Hi Magnus,<br>
&gt;<br>
&gt; 1.<br>
&gt; I am using nearly the same versions then you and got the same problems=
<br>
&gt; too ;-).<br>
&gt; I think there are some problems with the checksum offloading.<br>
&gt; Try to sniff the some packages (e.g. wireshark)...<br>
&gt; For me ICMP (ping) worked but udp and tcp not (because off a wrong<br>
&gt; checksum in the transport layer).<br>
&gt; A quick solution is to just deactivate checksum offloading.<br>
&gt;<br>
&gt; 2.<br>
&gt; I remember some problems with Virtex-4 presamples too.<br>
&gt; There where problems with the hard-temac wrapper. You had to use 1.00.=
a<br>
&gt; and not b version.<br>
&gt; But I don&#39;t have these problems with the EDK 9.2sp2/ISE9.2sp3 anym=
ore.<br>
&gt;<br>
&gt; all the best,<br>
&gt; Robert<br>
&gt;<br>
&gt; Magnus Hjorth wrote:<br>
&gt; &gt; Hi John,<br>
&gt; &gt;<br>
&gt; &gt; Thanks for the very fast reply! Right now I&#39;m not at work so =
I don&#39;t<br>
&gt; &gt; have the board or EDK here to test anything.<br>
&gt; &gt;<br>
&gt; &gt; I&#39;m using checksum offload, but I don&#39;t know if DRE is en=
abled or not. I<br>
&gt; &gt; can&#39;t recall seeing any setting to enable/disable DRE..<br>
&gt; &gt;<br>
&gt; &gt; A few things that crossed my mind:<br>
&gt; &gt;<br>
&gt; &gt; Last year I did a design with EDK 8.2, back then there was an iss=
ue with<br>
&gt; &gt; the ML403 boards having an old revision of the FPGA which wasn&#3=
9;t<br>
&gt; &gt; compatible with some versions of the IP core. There are no such v=
ersion<br>
&gt; &gt; issues with the xps_ll_temac?<br>
&gt; &gt;<br>
&gt; &gt; I don&#39;t think that I had phy-addr set in the DTS file. Will t=
est that on<br>
&gt; &gt; Monday.<br>
&gt; &gt;<br>
&gt; &gt; Best regards,<br>
&gt; &gt; Magnus<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On Sat, 2008-03-29 at 07:58 -0600, John Linn wrote:<br>
&gt; &gt;<br>
&gt; &gt;&gt; Hi Magnus,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Sorry to hear you&#39;re having problems with it.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I am doing testing on an ML405 which is the same board but wi=
th a bigger<br>
&gt; FPGA, but with ppc arch and I don&#39;t see this issue. I have done li=
mited testing<br>
&gt; with powerpc arch and the LL TEMAC, but I didn&#39;t see this issue th=
ere either.<br>
&gt; Powerpc arch is definitely less mature in my experience than the ppc a=
rch. I&#39;ll<br>
&gt; do a quick test with my powerpc arch and make sure again I&#39;m not s=
eeing it.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; My kernel is from the Xilinx Git tree, but there have been a =
number of<br>
&gt; changes we have pushed out so I don&#39;t know how long ago you pulled=
 from the Git<br>
&gt; tree.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; My EDK project is 10.1 so it&#39;s a little newer. I am using=
 LL TEMAC 1.01a so<br>
&gt; it&#39;s a little newer. &nbsp;I reviewed the change log for the LL TE=
MAC and don&#39;t see<br>
&gt; any big problems that were fixed in the newer versions, more new featu=
res. &nbsp;I&#39;ll<br>
&gt; check with some others here to see if I missed something there.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I am using DMA also, but no DRE or checksum offload. &nbsp;Yo=
u didn&#39;t say anything<br>
&gt; about those. I&#39;m going to insert my mhs file that describes my sys=
tem to let you<br>
&gt; compare your system configuration. It&#39;s not clear to me yet if you=
 have a h/w or<br>
&gt; s/w problem.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I&#39;ll also insert some of my device tree with the LL TEMAC=
 so you can compare<br>
&gt; (ignore 16550 stuff as we are still working on that).<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Since you can&#39;t ping reliably I would probably focus on t=
hat since it&#39;s<br>
&gt; simpler than the other issues you&#39;re seeing.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thanks,<br>
&gt; &gt;&gt; John<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; #<br>
&gt; ######################################################################=
########<br>
&gt; &gt;&gt; # Created by Base System Builder Wizard for Xilinx EDK 10.1.1=
 Build<br>
&gt; EDK_K_SP1.1<br>
&gt; &gt;&gt; # Thu Feb 14 14:11:12 2008<br>
&gt; &gt;&gt; # Target Board: &nbsp;Xilinx Virtex 4 ML405 Evaluation Platfo=
rm Rev 1<br>
&gt; &gt;&gt; # Family: &nbsp; &nbsp;virtex4<br>
&gt; &gt;&gt; # Device: &nbsp; &nbsp;xc4vfx20<br>
&gt; &gt;&gt; # Package: &nbsp; ff672<br>
&gt; &gt;&gt; # Speed Grade: &nbsp;-10<br>
&gt; &gt;&gt; # Processor: ppc405_0<br>
&gt; &gt;&gt; # Processor clock frequency: 300.00 MHz<br>
&gt; &gt;&gt; # Bus clock frequency: 100.00 MHz<br>
&gt; &gt;&gt; # On Chip Memory : &nbsp; 8 KB<br>
&gt; &gt;&gt; # Total Off Chip Memory : 128 MB<br>
&gt; &gt;&gt; # - DDR_SDRAM =3D 128 MB<br>
&gt; &gt;&gt; #<br>
&gt; ######################################################################=
########<br>
&gt; &gt;&gt; &nbsp;PARAMETER VERSION =3D 2.1.0<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_RS232_Uart_sin_pin =3D fpga_0_RS232_Uart_si=
n, DIR =3D I<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_RS232_Uart_sout_pin =3D fpga_0_RS232_Uart_s=
out, DIR =3D O<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_LEDs_4Bit_GPIO_IO_pin =3D fpga_0_LEDs_4Bit_=
GPIO_IO, DIR =3D IO, VEC<br>
&gt; =3D [0:3]<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_IIC_EEPROM_Scl_pin =3D fpga_0_IIC_EEPROM_Sc=
l, DIR =3D IO<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_IIC_EEPROM_Sda_pin =3D fpga_0_IIC_EEPROM_Sd=
a, DIR =3D IO<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_SysACE_CompactFlash_SysACE_CLK_pin =3D<br>
&gt; fpga_0_SysACE_CompactFlash_SysACE_CLK, DIR =3D I<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_SysACE_CompactFlash_SysACE_MPA_pin =3D<br>
&gt; fpga_0_SysACE_CompactFlash_SysACE_MPA, DIR =3D O, VEC =3D [6:1]<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_SysACE_CompactFlash_SysACE_MPD_pin =3D<br>
&gt; fpga_0_SysACE_CompactFlash_SysACE_MPD, DIR =3D IO, VEC =3D [15:0]<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_SysACE_CompactFlash_SysACE_CEN_pin =3D<br>
&gt; fpga_0_SysACE_CompactFlash_SysACE_CEN, DIR =3D O<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_SysACE_CompactFlash_SysACE_OEN_pin =3D<br>
&gt; fpga_0_SysACE_CompactFlash_SysACE_OEN, DIR =3D O<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_SysACE_CompactFlash_SysACE_WEN_pin =3D<br>
&gt; fpga_0_SysACE_CompactFlash_SysACE_WEN, DIR =3D O<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_SysACE_CompactFlash_SysACE_MPIRQ_pin =3D<br=
>
&gt; fpga_0_SysACE_CompactFlash_SysACE_MPIRQ, DIR =3D I<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_DDR_SDRAM_DDR_Clk_pin =3D fpga_0_DDR_SDRAM_=
DDR_Clk, DIR =3D O<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_DDR_SDRAM_DDR_Clk_n_pin =3D fpga_0_DDR_SDRA=
M_DDR_Clk_n, DIR =3D O<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_DDR_SDRAM_DDR_Addr_pin =3D fpga_0_DDR_SDRAM=
_DDR_Addr, DIR =3D O, VEC<br>
&gt; =3D [12:0]<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_DDR_SDRAM_DDR_BankAddr_pin =3D fpga_0_DDR_S=
DRAM_DDR_BankAddr, DIR<br>
&gt; =3D O, VEC =3D [1:0]<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_DDR_SDRAM_DDR_CAS_n_pin =3D fpga_0_DDR_SDRA=
M_DDR_CAS_n, DIR =3D O<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_DDR_SDRAM_DDR_CE_pin =3D fpga_0_DDR_SDRAM_D=
DR_CE, DIR =3D O<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_DDR_SDRAM_DDR_CS_n_pin =3D fpga_0_DDR_SDRAM=
_DDR_CS_n, DIR =3D O<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_DDR_SDRAM_DDR_RAS_n_pin =3D fpga_0_DDR_SDRA=
M_DDR_RAS_n, DIR =3D O<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_DDR_SDRAM_DDR_WE_n_pin =3D fpga_0_DDR_SDRAM=
_DDR_WE_n, DIR =3D O<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_DDR_SDRAM_DDR_DM_pin =3D fpga_0_DDR_SDRAM_D=
DR_DM, DIR =3D O, VEC =3D<br>
&gt; [3:0]<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_DDR_SDRAM_DDR_DQS =3D fpga_0_DDR_SDRAM_DDR_=
DQS, DIR =3D IO, VEC =3D<br>
&gt; [3:0]<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_DDR_SDRAM_DDR_DQ =3D fpga_0_DDR_SDRAM_DDR_D=
Q, DIR =3D IO, VEC =3D<br>
&gt; [31:0]<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_TriMode_MAC_GMII_GMII_TXD_0_pin =3D<br>
&gt; fpga_0_TriMode_MAC_GMII_GMII_TXD_0, DIR =3D O, VEC =3D [7:0]<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_TriMode_MAC_GMII_GMII_TX_EN_0_pin =3D<br>
&gt; fpga_0_TriMode_MAC_GMII_GMII_TX_EN_0, DIR =3D O<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_TriMode_MAC_GMII_GMII_TX_ER_0_pin =3D<br>
&gt; fpga_0_TriMode_MAC_GMII_GMII_TX_ER_0, DIR =3D O<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_TriMode_MAC_GMII_GMII_TX_CLK_0_pin =3D<br>
&gt; fpga_0_TriMode_MAC_GMII_GMII_TX_CLK_0, DIR =3D O<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_TriMode_MAC_GMII_GMII_RXD_0_pin =3D<br>
&gt; fpga_0_TriMode_MAC_GMII_GMII_RXD_0, DIR =3D I, VEC =3D [7:0]<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_TriMode_MAC_GMII_GMII_RX_DV_0_pin =3D<br>
&gt; fpga_0_TriMode_MAC_GMII_GMII_RX_DV_0, DIR =3D I<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_TriMode_MAC_GMII_GMII_RX_ER_0_pin =3D<br>
&gt; fpga_0_TriMode_MAC_GMII_GMII_RX_ER_0, DIR =3D I<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_TriMode_MAC_GMII_GMII_RX_CLK_0_pin =3D<br>
&gt; fpga_0_TriMode_MAC_GMII_GMII_RX_CLK_0, DIR =3D I<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_TriMode_MAC_GMII_MII_TX_CLK_0_pin =3D<br>
&gt; fpga_0_TriMode_MAC_GMII_MII_TX_CLK_0, DIR =3D I<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_TriMode_MAC_GMII_MDIO_0_pin =3D fpga_0_TriM=
ode_MAC_GMII_MDIO_0,<br>
&gt; DIR =3D IO<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_TriMode_MAC_GMII_MDC_0_pin =3D fpga_0_TriMo=
de_MAC_GMII_MDC_0, DIR<br>
&gt; =3D O<br>
&gt; &gt;&gt; &nbsp;PORT fpga_0_TriMode_MAC_GMII_TemacPhy_RST_n_pin =3D<br>
&gt; fpga_0_TriMode_MAC_GMII_TemacPhy_RST_n, DIR =3D O<br>
&gt; &gt;&gt; &nbsp;PORT sys_clk_pin =3D dcm_clk_s, DIR =3D I, SIGIS =3D CL=
K, CLK_FREQ =3D 100000000<br>
&gt; &gt;&gt; &nbsp;PORT sys_rst_pin =3D sys_rst_s, DIR =3D I, RST_POLARITY=
 =3D 0, SIGIS =3D RST<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; BEGIN ppc405_virtex4<br>
&gt; &gt;&gt; &nbsp;PARAMETER INSTANCE =3D ppc405_0<br>
&gt; &gt;&gt; &nbsp;PARAMETER HW_VER =3D 2.01.a<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_FASTEST_PLB_CLOCK =3D DPLB1<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_IDCR_BASEADDR =3D 0b0100000000<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_IDCR_HIGHADDR =3D 0b0111111111<br>
&gt; &gt;&gt; &nbsp;BUS_INTERFACE JTAGPPC =3D jtagppc_0_0<br>
&gt; &gt;&gt; &nbsp;BUS_INTERFACE IPLB0 =3D plb<br>
&gt; &gt;&gt; &nbsp;BUS_INTERFACE DPLB0 =3D plb<br>
&gt; &gt;&gt; &nbsp;BUS_INTERFACE IPLB1 =3D ppc405_0_iplb1<br>
&gt; &gt;&gt; &nbsp;BUS_INTERFACE DPLB1 =3D ppc405_0_dplb1<br>
&gt; &gt;&gt; &nbsp;BUS_INTERFACE RESETPPC =3D ppc_reset_bus<br>
&gt; &gt;&gt; &nbsp;PORT CPMC405CLOCK =3D proc_clk_s<br>
&gt; &gt;&gt; &nbsp;PORT EICC405EXTINPUTIRQ =3D EICC405EXTINPUTIRQ<br>
&gt; &gt;&gt; END<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; BEGIN jtagppc_cntlr<br>
&gt; &gt;&gt; &nbsp;PARAMETER INSTANCE =3D jtagppc_0<br>
&gt; &gt;&gt; &nbsp;PARAMETER HW_VER =3D 2.01.a<br>
&gt; &gt;&gt; &nbsp;BUS_INTERFACE JTAGPPC0 =3D jtagppc_0_0<br>
&gt; &gt;&gt; END<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; BEGIN plb_v46<br>
&gt; &gt;&gt; &nbsp;PARAMETER INSTANCE =3D plb<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_DCR_INTFCE =3D 0<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_NUM_CLK_PLB2OPB_REARB =3D 100<br>
&gt; &gt;&gt; &nbsp;PARAMETER HW_VER =3D 1.02.a<br>
&gt; &gt;&gt; &nbsp;PORT PLB_Clk =3D sys_clk_s<br>
&gt; &gt;&gt; &nbsp;PORT SYS_Rst =3D sys_bus_reset<br>
&gt; &gt;&gt; END<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; BEGIN xps_bram_if_cntlr<br>
&gt; &gt;&gt; &nbsp;PARAMETER INSTANCE =3D xps_bram_if_cntlr_1<br>
&gt; &gt;&gt; &nbsp;PARAMETER HW_VER =3D 1.00.a<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_SPLB_NATIVE_DWIDTH =3D 64<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_BASEADDR =3D 0xffffe000<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_HIGHADDR =3D 0xffffffff<br>
&gt; &gt;&gt; &nbsp;BUS_INTERFACE SPLB =3D plb<br>
&gt; &gt;&gt; &nbsp;BUS_INTERFACE PORTA =3D xps_bram_if_cntlr_1_port<br>
&gt; &gt;&gt; END<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; BEGIN bram_block<br>
&gt; &gt;&gt; &nbsp;PARAMETER INSTANCE =3D plb_bram_if_cntlr_1_bram<br>
&gt; &gt;&gt; &nbsp;PARAMETER HW_VER =3D 1.00.a<br>
&gt; &gt;&gt; &nbsp;BUS_INTERFACE PORTA =3D xps_bram_if_cntlr_1_port<br>
&gt; &gt;&gt; END<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; BEGIN xps_uart16550<br>
&gt; &gt;&gt; &nbsp;PARAMETER INSTANCE =3D RS232_Uart<br>
&gt; &gt;&gt; &nbsp;PARAMETER HW_VER =3D 2.00.a<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_IS_A_16550 =3D 1<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_BASEADDR =3D 0x83e00000<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_HIGHADDR =3D 0x83e0ffff<br>
&gt; &gt;&gt; &nbsp;BUS_INTERFACE SPLB =3D plb<br>
&gt; &gt;&gt; &nbsp;PORT sin =3D fpga_0_RS232_Uart_sin<br>
&gt; &gt;&gt; &nbsp;PORT sout =3D fpga_0_RS232_Uart_sout<br>
&gt; &gt;&gt; &nbsp;PORT IP2INTC_Irpt =3D RS232_Uart_IP2INTC_Irpt<br>
&gt; &gt;&gt; END<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; BEGIN xps_gpio<br>
&gt; &gt;&gt; &nbsp;PARAMETER INSTANCE =3D LEDs_4Bit<br>
&gt; &gt;&gt; &nbsp;PARAMETER HW_VER =3D 1.00.a<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_INTERRUPT_PRESENT =3D 1<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_GPIO_WIDTH =3D 4<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_IS_DUAL =3D 0<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_IS_BIDIR =3D 1<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_ALL_INPUTS =3D 0<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_BASEADDR =3D 0x81400000<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_HIGHADDR =3D 0x8140ffff<br>
&gt; &gt;&gt; &nbsp;BUS_INTERFACE SPLB =3D plb<br>
&gt; &gt;&gt; &nbsp;PORT GPIO_IO =3D fpga_0_LEDs_4Bit_GPIO_IO<br>
&gt; &gt;&gt; &nbsp;PORT IP2INTC_Irpt =3D LEDs_4Bit_IP2INTC_Irpt<br>
&gt; &gt;&gt; END<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; BEGIN xps_iic<br>
&gt; &gt;&gt; &nbsp;PARAMETER INSTANCE =3D IIC_EEPROM<br>
&gt; &gt;&gt; &nbsp;PARAMETER HW_VER =3D 2.00.a<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_CLK_FREQ =3D 100000000<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_IIC_FREQ =3D 100000<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_TEN_BIT_ADR =3D 0<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_BASEADDR =3D 0x81600000<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_HIGHADDR =3D 0x8160ffff<br>
&gt; &gt;&gt; &nbsp;BUS_INTERFACE SPLB =3D plb<br>
&gt; &gt;&gt; &nbsp;PORT Scl =3D fpga_0_IIC_EEPROM_Scl<br>
&gt; &gt;&gt; &nbsp;PORT Sda =3D fpga_0_IIC_EEPROM_Sda<br>
&gt; &gt;&gt; &nbsp;PORT IIC2INTC_Irpt =3D IIC_EEPROM_IIC2INTC_Irpt<br>
&gt; &gt;&gt; END<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; BEGIN xps_sysace<br>
&gt; &gt;&gt; &nbsp;PARAMETER INSTANCE =3D SysACE_CompactFlash<br>
&gt; &gt;&gt; &nbsp;PARAMETER HW_VER =3D 1.00.a<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_MEM_WIDTH =3D 16<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_BASEADDR =3D 0x83600000<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_HIGHADDR =3D 0x8360ffff<br>
&gt; &gt;&gt; &nbsp;BUS_INTERFACE SPLB =3D plb<br>
&gt; &gt;&gt; &nbsp;PORT SysACE_CLK =3D fpga_0_SysACE_CompactFlash_SysACE_C=
LK<br>
&gt; &gt;&gt; &nbsp;PORT SysACE_MPA =3D fpga_0_SysACE_CompactFlash_SysACE_M=
PA_split<br>
&gt; &gt;&gt; &nbsp;PORT SysACE_MPD =3D fpga_0_SysACE_CompactFlash_SysACE_M=
PD<br>
&gt; &gt;&gt; &nbsp;PORT SysACE_CEN =3D fpga_0_SysACE_CompactFlash_SysACE_C=
EN<br>
&gt; &gt;&gt; &nbsp;PORT SysACE_OEN =3D fpga_0_SysACE_CompactFlash_SysACE_O=
EN<br>
&gt; &gt;&gt; &nbsp;PORT SysACE_WEN =3D fpga_0_SysACE_CompactFlash_SysACE_W=
EN<br>
&gt; &gt;&gt; &nbsp;PORT SysACE_MPIRQ =3D fpga_0_SysACE_CompactFlash_SysACE=
_MPIRQ<br>
&gt; &gt;&gt; &nbsp;PORT SysACE_IRQ =3D SysACE_CompactFlash_SysACE_IRQ<br>
&gt; &gt;&gt; END<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; BEGIN mpmc<br>
&gt; &gt;&gt; &nbsp;PARAMETER INSTANCE =3D DDR_SDRAM<br>
&gt; &gt;&gt; &nbsp;PARAMETER HW_VER =3D 4.00.a<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_NUM_PORTS =3D 3<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_MEM_PARTNO =3D HYB25D512160BE-5<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_MEM_DATA_WIDTH =3D 32<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_MEM_DQS_WIDTH =3D 4<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_MEM_DM_WIDTH =3D 4<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_MEM_TYPE =3D DDR<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_NUM_IDELAYCTRL =3D 2<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_IDELAYCTRL_LOC =3D IDELAYCTRL_X0Y3-IDELAYCT=
RL_X0Y2<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_PIM0_BASETYPE =3D 2<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_PIM1_BASETYPE =3D 2<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_PIM2_BASETYPE =3D 3<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_MPMC_CLK0_PERIOD_PS =3D 10000<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_SDMA2_PI2LL_CLK_RATIO =3D 1<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_MPMC_BASEADDR =3D 0x00000000<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_MPMC_HIGHADDR =3D 0x07ffffff<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_SDMA_CTRL_BASEADDR =3D 0x84600000<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_SDMA_CTRL_HIGHADDR =3D 0x8460ffff<br>
&gt; &gt;&gt; &nbsp;BUS_INTERFACE SPLB0 =3D ppc405_0_iplb1<br>
&gt; &gt;&gt; &nbsp;BUS_INTERFACE SPLB1 =3D ppc405_0_dplb1<br>
&gt; &gt;&gt; &nbsp;BUS_INTERFACE SDMA_LL2 =3D TriMode_MAC_GMII_LLINK0<br>
&gt; &gt;&gt; &nbsp;BUS_INTERFACE SDMA_CTRL2 =3D plb<br>
&gt; &gt;&gt; &nbsp;PORT DDR_Addr =3D fpga_0_DDR_SDRAM_DDR_Addr<br>
&gt; &gt;&gt; &nbsp;PORT DDR_BankAddr =3D fpga_0_DDR_SDRAM_DDR_BankAddr<br>
&gt; &gt;&gt; &nbsp;PORT DDR_CAS_n =3D fpga_0_DDR_SDRAM_DDR_CAS_n<br>
&gt; &gt;&gt; &nbsp;PORT DDR_CE =3D fpga_0_DDR_SDRAM_DDR_CE<br>
&gt; &gt;&gt; &nbsp;PORT DDR_CS_n =3D fpga_0_DDR_SDRAM_DDR_CS_n<br>
&gt; &gt;&gt; &nbsp;PORT DDR_RAS_n =3D fpga_0_DDR_SDRAM_DDR_RAS_n<br>
&gt; &gt;&gt; &nbsp;PORT DDR_WE_n =3D fpga_0_DDR_SDRAM_DDR_WE_n<br>
&gt; &gt;&gt; &nbsp;PORT DDR_DM =3D fpga_0_DDR_SDRAM_DDR_DM<br>
&gt; &gt;&gt; &nbsp;PORT DDR_DQS =3D fpga_0_DDR_SDRAM_DDR_DQS<br>
&gt; &gt;&gt; &nbsp;PORT DDR_DQ =3D fpga_0_DDR_SDRAM_DDR_DQ<br>
&gt; &gt;&gt; &nbsp;PORT DDR_Clk =3D fpga_0_DDR_SDRAM_DDR_Clk<br>
&gt; &gt;&gt; &nbsp;PORT DDR_Clk_n =3D fpga_0_DDR_SDRAM_DDR_Clk_n<br>
&gt; &gt;&gt; &nbsp;PORT MPMC_Clk0 =3D sys_clk_s<br>
&gt; &gt;&gt; &nbsp;PORT MPMC_Clk90 =3D DDR_SDRAM_mpmc_clk_90_s<br>
&gt; &gt;&gt; &nbsp;PORT SDMA2_Clk =3D sys_clk_s<br>
&gt; &gt;&gt; &nbsp;PORT MPMC_Clk_200MHz =3D clk_200mhz_s<br>
&gt; &gt;&gt; &nbsp;PORT MPMC_Rst =3D sys_periph_reset<br>
&gt; &gt;&gt; &nbsp;PORT SDMA2_Rx_IntOut =3D DDR_SDRAM_SDMA2_Rx_IntOut<br>
&gt; &gt;&gt; &nbsp;PORT SDMA2_Tx_IntOut =3D DDR_SDRAM_SDMA2_Tx_IntOut<br>
&gt; &gt;&gt; END<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; BEGIN xps_ll_temac<br>
&gt; &gt;&gt; &nbsp;PARAMETER INSTANCE =3D TriMode_MAC_GMII<br>
&gt; &gt;&gt; &nbsp;PARAMETER HW_VER =3D 1.01.a<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_SPLB_CLK_PERIOD_PS =3D 10000<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_PHY_TYPE =3D 1<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_NUM_IDELAYCTRL =3D 4<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_IDELAYCTRL_LOC =3D IDELAYCTRL_X1Y1-IDELAYCT=
RL_X1Y3-<br>
&gt; IDELAYCTRL_X2Y2-IDELAYCTRL_X2Y3<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_TEMAC_TYPE =3D 1<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_BUS2CORE_CLK_RATIO =3D 1<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_BASEADDR =3D 0x81c00000<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_HIGHADDR =3D 0x81c0ffff<br>
&gt; &gt;&gt; &nbsp;BUS_INTERFACE SPLB =3D plb<br>
&gt; &gt;&gt; &nbsp;BUS_INTERFACE LLINK0 =3D TriMode_MAC_GMII_LLINK0<br>
&gt; &gt;&gt; &nbsp;PORT GMII_TXD_0 =3D fpga_0_TriMode_MAC_GMII_GMII_TXD_0<=
br>
&gt; &gt;&gt; &nbsp;PORT GMII_TX_EN_0 =3D fpga_0_TriMode_MAC_GMII_GMII_TX_E=
N_0<br>
&gt; &gt;&gt; &nbsp;PORT GMII_TX_ER_0 =3D fpga_0_TriMode_MAC_GMII_GMII_TX_E=
R_0<br>
&gt; &gt;&gt; &nbsp;PORT GMII_TX_CLK_0 =3D fpga_0_TriMode_MAC_GMII_GMII_TX_=
CLK_0<br>
&gt; &gt;&gt; &nbsp;PORT GMII_RXD_0 =3D fpga_0_TriMode_MAC_GMII_GMII_RXD_0<=
br>
&gt; &gt;&gt; &nbsp;PORT GMII_RX_DV_0 =3D fpga_0_TriMode_MAC_GMII_GMII_RX_D=
V_0<br>
&gt; &gt;&gt; &nbsp;PORT GMII_RX_ER_0 =3D fpga_0_TriMode_MAC_GMII_GMII_RX_E=
R_0<br>
&gt; &gt;&gt; &nbsp;PORT GMII_RX_CLK_0 =3D fpga_0_TriMode_MAC_GMII_GMII_RX_=
CLK_0<br>
&gt; &gt;&gt; &nbsp;PORT MII_TX_CLK_0 =3D fpga_0_TriMode_MAC_GMII_MII_TX_CL=
K_0<br>
&gt; &gt;&gt; &nbsp;PORT MDIO_0 =3D fpga_0_TriMode_MAC_GMII_MDIO_0<br>
&gt; &gt;&gt; &nbsp;PORT MDC_0 =3D fpga_0_TriMode_MAC_GMII_MDC_0<br>
&gt; &gt;&gt; &nbsp;PORT TemacPhy_RST_n =3D fpga_0_TriMode_MAC_GMII_TemacPh=
y_RST_n<br>
&gt; &gt;&gt; &nbsp;PORT GTX_CLK_0 =3D temac_clk_s<br>
&gt; &gt;&gt; &nbsp;PORT REFCLK =3D clk_200mhz_s<br>
&gt; &gt;&gt; &nbsp;PORT LlinkTemac0_CLK =3D sys_clk_s<br>
&gt; &gt;&gt; &nbsp;PORT TemacIntc0_Irpt =3D TriMode_MAC_GMII_TemacIntc0_Ir=
pt<br>
&gt; &gt;&gt; END<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; BEGIN util_bus_split<br>
&gt; &gt;&gt; &nbsp;PARAMETER INSTANCE =3D SysACE_CompactFlash_util_bus_spl=
it_0<br>
&gt; &gt;&gt; &nbsp;PARAMETER HW_VER =3D 1.00.a<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_SIZE_IN =3D 7<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_LEFT_POS =3D 0<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_SPLIT =3D 6<br>
&gt; &gt;&gt; &nbsp;PORT Sig =3D fpga_0_SysACE_CompactFlash_SysACE_MPA_spli=
t<br>
&gt; &gt;&gt; &nbsp;PORT Out1 =3D fpga_0_SysACE_CompactFlash_SysACE_MPA<br>
&gt; &gt;&gt; END<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; BEGIN plb_v46<br>
&gt; &gt;&gt; &nbsp;PARAMETER INSTANCE =3D ppc405_0_iplb1<br>
&gt; &gt;&gt; &nbsp;PARAMETER HW_VER =3D 1.02.a<br>
&gt; &gt;&gt; &nbsp;PORT PLB_Clk =3D sys_clk_s<br>
&gt; &gt;&gt; &nbsp;PORT SYS_Rst =3D sys_bus_reset<br>
&gt; &gt;&gt; END<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; BEGIN plb_v46<br>
&gt; &gt;&gt; &nbsp;PARAMETER INSTANCE =3D ppc405_0_dplb1<br>
&gt; &gt;&gt; &nbsp;PARAMETER HW_VER =3D 1.02.a<br>
&gt; &gt;&gt; &nbsp;PORT PLB_Clk =3D sys_clk_s<br>
&gt; &gt;&gt; &nbsp;PORT SYS_Rst =3D sys_bus_reset<br>
&gt; &gt;&gt; END<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; BEGIN clock_generator<br>
&gt; &gt;&gt; &nbsp;PARAMETER INSTANCE =3D clock_generator_0<br>
&gt; &gt;&gt; &nbsp;PARAMETER HW_VER =3D 2.00.a<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_EXT_RESET_HIGH =3D 1<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_CLKIN_FREQ =3D 100000000<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_CLKOUT0_FREQ =3D 100000000<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_CLKOUT0_BUF =3D TRUE<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_CLKOUT0_PHASE =3D 0<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_CLKOUT0_GROUP =3D DCM0<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_CLKOUT1_FREQ =3D 100000000<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_CLKOUT1_BUF =3D TRUE<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_CLKOUT1_PHASE =3D 90<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_CLKOUT1_GROUP =3D DCM0<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_CLKOUT2_FREQ =3D 300000000<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_CLKOUT2_BUF =3D TRUE<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_CLKOUT2_PHASE =3D 0<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_CLKOUT2_GROUP =3D DCM0<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_CLKOUT3_FREQ =3D 200000000<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_CLKOUT3_BUF =3D TRUE<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_CLKOUT3_PHASE =3D 0<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_CLKOUT3_GROUP =3D NONE<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_CLKOUT4_FREQ =3D 125000000<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_CLKOUT4_BUF =3D TRUE<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_CLKOUT4_PHASE =3D 0<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_CLKOUT4_GROUP =3D NONE<br>
&gt; &gt;&gt; &nbsp;PORT CLKOUT0 =3D sys_clk_s<br>
&gt; &gt;&gt; &nbsp;PORT CLKOUT1 =3D DDR_SDRAM_mpmc_clk_90_s<br>
&gt; &gt;&gt; &nbsp;PORT CLKOUT2 =3D proc_clk_s<br>
&gt; &gt;&gt; &nbsp;PORT CLKOUT3 =3D clk_200mhz_s<br>
&gt; &gt;&gt; &nbsp;PORT CLKOUT4 =3D temac_clk_s<br>
&gt; &gt;&gt; &nbsp;PORT CLKIN =3D dcm_clk_s<br>
&gt; &gt;&gt; &nbsp;PORT LOCKED =3D Dcm_all_locked<br>
&gt; &gt;&gt; &nbsp;PORT RST =3D net_gnd<br>
&gt; &gt;&gt; END<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; BEGIN proc_sys_reset<br>
&gt; &gt;&gt; &nbsp;PARAMETER INSTANCE =3D proc_sys_reset_0<br>
&gt; &gt;&gt; &nbsp;PARAMETER HW_VER =3D 2.00.a<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_EXT_RESET_HIGH =3D 0<br>
&gt; &gt;&gt; &nbsp;BUS_INTERFACE RESETPPC0 =3D ppc_reset_bus<br>
&gt; &gt;&gt; &nbsp;PORT Slowest_sync_clk =3D sys_clk_s<br>
&gt; &gt;&gt; &nbsp;PORT Dcm_locked =3D Dcm_all_locked<br>
&gt; &gt;&gt; &nbsp;PORT Ext_Reset_In =3D sys_rst_s<br>
&gt; &gt;&gt; &nbsp;PORT Bus_Struct_Reset =3D sys_bus_reset<br>
&gt; &gt;&gt; &nbsp;PORT Peripheral_Reset =3D sys_periph_reset<br>
&gt; &gt;&gt; END<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; BEGIN xps_intc<br>
&gt; &gt;&gt; &nbsp;PARAMETER INSTANCE =3D xps_intc_0<br>
&gt; &gt;&gt; &nbsp;PARAMETER HW_VER =3D 1.00.a<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_BASEADDR =3D 0x81800000<br>
&gt; &gt;&gt; &nbsp;PARAMETER C_HIGHADDR =3D 0x8180ffff<br>
&gt; &gt;&gt; &nbsp;BUS_INTERFACE SPLB =3D plb<br>
&gt; &gt;&gt; &nbsp;PORT Irq =3D EICC405EXTINPUTIRQ<br>
&gt; &gt;&gt; &nbsp;PORT Intr =3D RS232_Uart_IP2INTC_Irpt &amp; LEDs_4Bit_I=
P2INTC_Irpt &amp;<br>
&gt; IIC_EEPROM_IIC2INTC_Irpt &amp; SysACE_CompactFlash_SysACE_IRQ &amp;<br=
>
&gt; TriMode_MAC_GMII_TemacIntc0_Irpt &amp; DDR_SDRAM_SDMA2_Rx_IntOut &amp;=
<br>
&gt; DDR_SDRAM_SDMA2_Tx_IntOut<br>
&gt; &gt;&gt; END<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &nbsp; &nbsp;#address-cells =3D &lt;1&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp;#size-cells =3D &lt;1&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp;compatible =3D &quot;xlnx,virtex&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp;model =3D &quot;testing&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp;DDR_SDRAM: memory@0 {<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;device_type =3D &quo=
t;memory&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;reg =3D &lt; 0 80000=
00 &gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp;} ;<br>
&gt; &gt;&gt; &nbsp; &nbsp;chosen {<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bootargs =3D &quot;c=
onsole=3DttyS0,9600 ip=3Don<br>
&gt; nfsroot=3D172.16.40.76:/v2pclients/jhl26,tcp&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;linux,stdout-path =
=3D &quot;/plb@0/serial@83e00000&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp;} ;<br>
&gt; &gt;&gt; &nbsp; &nbsp;cpus {<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#address-cells =3D &=
lt;1&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#cpus =3D &lt;1&gt;;=
<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#size-cells =3D &lt;=
0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ppc405_0: cpu@0 {<br=
>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;clock-frequency =3D &lt;11e1a300&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;compatible =3D &quot;PowerPC,405&quot;, &quot;ibm,ppc405&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;d-cache-line-size =3D &lt;20&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;d-cache-size =3D &lt;4000&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;device_type =3D &quot;cpu&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;i-cache-line-size =3D &lt;20&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;i-cache-size =3D &lt;4000&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;model =3D &quot;PowerPC,405&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;reg =3D &lt;0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;timebase-frequency =3D &lt;11e1a300&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,apu-control =3D &lt;de00&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,apu-udi-1 =3D &lt;a18983&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,apu-udi-2 =3D &lt;a38983&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,apu-udi-3 =3D &lt;a589c3&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,apu-udi-4 =3D &lt;a789c3&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,apu-udi-5 =3D &lt;a98c03&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,apu-udi-6 =3D &lt;ab8c03&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,apu-udi-7 =3D &lt;ad8c43&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,apu-udi-8 =3D &lt;af8c43&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,deterministic-mult =3D &lt;0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,disable-operand-forwarding =3D &lt;1&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,fastest-plb-clock =3D &quot;DPLB0&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,generate-plb-timespecs =3D &lt;1&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,mmu-enable =3D &lt;1&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,pvr-high =3D &lt;0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,pvr-low =3D &lt;0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;} ;<br>
&gt; &gt;&gt; &nbsp; &nbsp;} ;<br>
&gt; &gt;&gt; &nbsp; &nbsp;plb: plb@0 {<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#address-cells =3D &=
lt;1&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#size-cells =3D &lt;=
1&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;compatible =3D &quot=
;xlnx,plb-v46-1.02.a&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ranges ;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;IIC_EEPROM: i2c@8160=
0000 {<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;compatible =3D &quot;xlnx,xps-iic-2.00.a&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;interrupt-parent =3D &lt;&amp;xps_intc_0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;interrupts =3D &lt; 4 2 &gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;reg =3D &lt; 81600000 10000 &gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,clk-freq =3D &lt;5f5e100&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,family =3D &quot;virtex4&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,gpo-width =3D &lt;1&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,iic-freq =3D &lt;186a0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,scl-inertial-delay =3D &lt;0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,sda-inertial-delay =3D &lt;0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,ten-bit-adr =3D &lt;0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;} ;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;LEDs_4Bit: gpio@8140=
0000 {<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;compatible =3D &quot;xlnx,xps-gpio-1.00.a&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;interrupt-parent =3D &lt;&amp;xps_intc_0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;interrupts =3D &lt; 5 2 &gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;reg =3D &lt; 81400000 10000 &gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,all-inputs =3D &lt;0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,all-inputs-2 =3D &lt;0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,dout-default =3D &lt;0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,dout-default-2 =3D &lt;0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,family =3D &quot;virtex4&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,gpio-width =3D &lt;4&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,interrupt-present =3D &lt;1&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,is-bidir =3D &lt;1&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,is-bidir-2 =3D &lt;1&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,is-dual =3D &lt;0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,tri-default =3D &lt;ffffffff&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,tri-default-2 =3D &lt;ffffffff&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;} ;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;RS232_Uart: serial@8=
3e00000 {<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;compatible =3D &quot;xlnx,xps-uart16550-2.00.a&quot;;<br>
&gt; &gt;&gt; // &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; co=
mpatible =3D &quot;ns16550&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;device_type =3D &quot;serial&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;interrupt-parent =3D &lt;&amp;xps_intc_0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;interrupts =3D &lt; 6 2 &gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;reg =3D &lt; 83e00000 10000 &gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;current-speed =3D &lt;d#9600&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;clock-frequency =3D &lt;d#100000000&gt;; &nbsp;/* added<br>
&gt; by jhl */<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;reg-shift =3D &lt;2&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,family =3D &quot;virtex4&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,has-external-rclk =3D &lt;0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,has-external-xin =3D &lt;0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,is-a-16550 =3D &lt;1&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;} ;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;SysACE_CompactFlash:=
 sysace@83600000 {<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;compatible =3D &quot;xlnx,xps-sysace-1.00.a&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;interrupt-parent =3D &lt;&amp;xps_intc_0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;interrupts =3D &lt; 3 2 &gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;reg =3D &lt; 83600000 10000 &gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,family =3D &quot;virtex4&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,mem-width =3D &lt;10&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;} ;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;TriMode_MAC_GMII: xp=
s-ll-temac@81c00000 {<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;#address-cells =3D &lt;1&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;#size-cells =3D &lt;1&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;compatible =3D &quot;xlnx,compound&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;ethernet@81c00000 {<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;compatible =3D &quot;xlnx,xps-ll-temac-=
<br>
&gt; 1.01.a&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;device_type =3D &quot;network&quot;;<br=
>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;interrupt-parent =3D<br>
&gt; &lt;&amp;xps_intc_0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;interrupts =3D &lt; 2 2 &gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;llink-connected =3D &lt;&amp;PIM2&gt;;<=
br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;local-mac-address =3D [ 02 00 00<br>
&gt; 00 00 01 ];<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;reg =3D &lt; 81c00000 40 &gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;xlnx,bus2core-clk-ratio =3D &lt;1&gt;;<=
br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;xlnx,phy-type =3D &lt;1&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;xlnx,phyaddr =3D &lt;1&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;xlnx,rxcsum =3D &lt;0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;xlnx,rxfifo =3D &lt;1000&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;xlnx,temac-type =3D &lt;1&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;xlnx,txcsum =3D &lt;0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;xlnx,txfifo =3D &lt;1000&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;} ;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;} ;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;mpmc@0 {<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;#address-cells =3D &lt;1&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;#size-cells =3D &lt;1&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;compatible =3D &quot;xlnx,mpmc-4.00.a&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;PIM2: sdma@84600100 {<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;compatible =3D &quot;xlnx,ll-dma-<br>
&gt; 1.00.a&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;interrupt-parent =3D<br>
&gt; &lt;&amp;xps_intc_0&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;interrupts =3D &lt; 1 2 0 2 &gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;reg =3D &lt; 84600100 80 &gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;} ;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;} ;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;xps_bram_if_cntlr_1:=
 xps-bram-if-cntlr@ffffe000 {<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;compatible =3D &quot;xlnx,xps-bram-if-cntlr-<br>
&gt; 1.00.a&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;reg =3D &lt; ffffe000 2000 &gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,family =3D &quot;virtex4&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;} ;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;xps_intc_0: interrup=
t-controller@81800000 {<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;#interrupt-cells =3D &lt;2&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;compatible =3D &quot;xlnx,xps-intc-1.00.a&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;interrupt-controller ;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;reg =3D &lt; 81800000 10000 &gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;xlnx,num-intr-inputs =3D &lt;7&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;} ;<br>
&gt; &gt;&gt; &nbsp; &nbsp;} ;<br>
&gt; &gt;&gt; &nbsp; &nbsp;ppc405_0_dplb1: plb@1 {<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#address-cells =3D &=
lt;1&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#size-cells =3D &lt;=
1&gt;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;compatible =3D &quot=
;xlnx,plb-v46-1.02.a&quot;;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ranges ;<br>
&gt; &gt;&gt; &nbsp; &nbsp;} ;<br>
&gt; &gt;&gt; } &nbsp;;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt; From: Magnus Hjorth [mailto:<a href=3D"mailto:mh@omnisys.se">=
mh@omnisys.se</a>]<br>
&gt; &gt;&gt; Sent: Saturday, March 29, 2008 6:54 AM<br>
&gt; &gt;&gt; To: git<br>
&gt; &gt;&gt; Cc: <a href=3D"mailto:linuxppc-embedded@ozlabs.org">linuxppc-=
embedded@ozlabs.org</a><br>
&gt; &gt;&gt; Subject: Xilinx LLTEMAC driver issues<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Hi,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I&#39;m having some networking troubles with the Xilinx LLTEM=
AC driver from the<br>
&gt; &gt;&gt; Xilinx Linux git tree (powerpc arch) on an ML403 board. EDK9.=
2SP2,<br>
&gt; &gt;&gt; xps_ll_temac v1.00.b<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The weird thing is, that it sort of half works. It successful=
ly makes a DHCP<br>
&gt; &gt;&gt; request and gets its IP address. I tried setting up a tftpd s=
erver, and I can<br>
&gt; &gt;&gt; see UDP requests coming in but the response doesn&#39;t seem =
to come out. I also<br>
&gt; &gt;&gt; tried running a TCP server on the board, and it can see and a=
ccept incoming<br>
&gt; &gt;&gt; connections but after that no data seems to get through. I ca=
n ping out and<br>
&gt; &gt;&gt; get around 40% packet loss.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Looking at /proc/interrupts, I can see both TxDma interrupts =
and RxDma<br>
&gt; &gt;&gt; interrupts. No eth0 interrupts but that seems to be OK judgin=
g by the driver<br>
&gt; &gt;&gt; source comments. Ifconfig shows no collistions, no dropped pa=
ckets, no<br>
&gt; errors,<br>
&gt; &gt;&gt; so the system seems to think that everything is OK.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Clues anyone? I&#39;m starting to run out of ideas...<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Best regards,<br>
&gt; &gt;&gt; Magnus<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; --<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Magnus Hjorth, M.Sc.<br>
&gt; &gt;&gt; Omnisys Instruments AB<br>
&gt; &gt;&gt; Gruvgatan 8<br>
&gt; &gt;&gt; SE-421 30 &nbsp;V=E4stra Fr=F6lunda, SWEDEN<br>
&gt; &gt;&gt; Phone: +46 31 734 34 09<br>
&gt; &gt;&gt; Fax: +46 31 734 34 29<br>
&gt; &gt;&gt; <a href=3D"http://www.omnisys.se" target=3D"_blank">http://ww=
w.omnisys.se</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; Linuxppc-embedded mailing list<br>
&gt; &gt; <a href=3D"mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded=
@ozlabs.org</a><br>
&gt; &gt; <a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded"=
 target=3D"_blank">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a=
><br>
_______________________________________________<br>
Linuxppc-embedded mailing list<br>
<a href=3D"mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.or=
g</a><br>
<a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target=3D=
"_blank">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></div></d=
iv></blockquote></div><br><br clear=3D"all"><br>-- <br>Johann Baudy<br><a h=
ref=3D"mailto:johaahn@gmail.com">johaahn@gmail.com</a>

------=_Part_49_25935075.1207120843991--
