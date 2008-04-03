Return-Path: <john.bonesio@xilinx.com>
Received: from outbound2-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E5B98DDDEF
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Apr 2008 11:32:04 +1100 (EST)
From: John Bonesio <john.bonesio@xilinx.com>
To: "Johann Baudy" <johaahn@gmail.com>
Subject: Re: Xilinx LLTEMAC driver issues
Date: Wed, 2 Apr 2008 17:31:58 -0700
References: <20080329125416.B09261AD8051@mail119-sin.bigfish.com>
	<000601c8931f$e1d549a0$a57fdce0$@se>
	<7e0dd21a0804020020s66a091ferfbbf4142adcd84ae@mail.gmail.com>
In-Reply-To: <7e0dd21a0804020020s66a091ferfbbf4142adcd84ae@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <20080403003200.CB2BF1968046@mail103-sin.bigfish.com>
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


The change with the extra parenthesis (in the patch starting with line 133)=
 seems unecessary. I looked at the XLlDma_mBdWrite macro and it appeared to=
 have the correct use of parethesis in the implementation.
So, assuming there's nothing subtle that I missed, it's not needed. However=
, it does no harm either.

The rest of the patch seems fine.

=2D John

On Wednesday 02 April 2008 00:20, Johann Baudy wrote:
> I've solved this checksum offloading issue with this below patch.
> It may help, if you need performance. It certainly needs review but it wo=
rks
> on my side.
>=20
> --- xilinxgit/drivers/net/xilinx_lltemac/xlltemac_main.c.orig    2008-03-=
21
> 09:11:43.000000000 +0100
> +++ xilinxgit/drivers/net/xilinx_lltemac/xlltemac_main.c    2008-03-21
> 09:24:23.000000000 +0100
> @@ -133,7 +133,7 @@
>          (XLlDma_mBdRead((BdPtr), XLLDMA_BD_STSCTRL_USR0_OFFSET)) &
> 0xFFFFFFFE )
>=20
>  #define BdCsumSetup(BdPtr, Start, Insert) \
> -    XLlDma_mBdWrite((BdPtr), XLLDMA_BD_USR1_OFFSET, (Start) << 16 |
> (Insert))
> +    XLlDma_mBdWrite((BdPtr), XLLDMA_BD_USR1_OFFSET, ((Start) << 16) |
> (Insert))
>=20
>  /* Used for debugging */
>  #define BdCsumInsert(BdPtr) \
> @@ -1540,7 +1541,7 @@ static int xenet_DmaSend_internal(struct
>      /*
>       * if tx checksum offloading is enabled, when the ethernet stack
>       * wants us to perform the checksum in hardware,
> -     * skb->ip_summed is CHECKSUM_COMPLETE. Otherwise skb->ip_summed is
> +     * skb->ip_summed is CHECKSUM_PARTIAL. Otherwise skb->ip_summed is
>       * CHECKSUM_NONE, meaning the checksum is already done, or
>       * CHECKSUM_UNNECESSARY, meaning checksumming is turned off (e.g.
>       * loopback interface)
> @@ -1565,9 +1566,11 @@ static int xenet_DmaSend_internal(struct
>       * skb_transport_header(skb) points to the beginning of the ip header
>       *
>       */
> -    if (skb->ip_summed =3D=3D CHECKSUM_COMPLETE) {
> +    if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> +
> +        unsigned int csum_start_off =3D skb_transport_offset(skb);
> +        unsigned int csum_index_off =3D csum_start_off + skb->csum_offse=
t;
>=20
> -        unsigned char *raw =3D skb_transport_header(skb);
>  #if 0
>          {
>              unsigned int csum =3D _xenet_tx_csum(skb);
> @@ -1578,9 +1581,8 @@ static int xenet_DmaSend_internal(struct
>          }
>  #else
>          BdCsumEnable(bd_ptr);
> -        BdCsumSetup(bd_ptr, raw - skb->data,
> -                (raw - skb->data) + skb->csum);
> -
> +        BdCsumSetup(bd_ptr, csum_start_off,
> +                csum_index_off);
>  #endif
>          lp->tx_hw_csums++;
>      }
> @@ -3277,7 +3279,7 @@ static int __devinit xtenet_of_probe(str
>      struct resource *r_irq =3D &r_irq_struct;    /* Interrupt resources =
*/
>      struct resource *r_mem =3D &r_mem_struct;    /* IO mem resources */
>      struct xlltemac_platform_data *pdata =3D &pdata_struct;
> -        void *mac_address;
> +        const void *mac_address;
>      int rc =3D 0;
>      const phandle *llink_connected_handle;
>      struct device_node *llink_connected_node;
>=20
>=20
> On Mon, Mar 31, 2008 at 11:10 AM, Magnus Hjorth <mh@omnisys.se> wrote:
>=20
> > Deactivating checksum offloading helped a lot! I still have some packet
> > loss and not the best performance (TFTP transfer about 100 kbyte/s) but=
 at
> > least it works.
> >
> > Thanks!
> >
> > //Magnus
> >
> > > -----Original Message-----
> > > From: rza1 [mailto:rza1@so-logic.net]
> > > Sent: den 31 mars 2008 11:14
> > > To: Magnus Hjorth
> > > Cc: John Linn; git; linuxppc-embedded@ozlabs.org
> > > Subject: Re: Xilinx LLTEMAC driver issues
> > >
> > > Hi Magnus,
> > >
> > > 1.
> > > I am using nearly the same versions then you and got the same problems
> > > too ;-).
> > > I think there are some problems with the checksum offloading.
> > > Try to sniff the some packages (e.g. wireshark)...
> > > For me ICMP (ping) worked but udp and tcp not (because off a wrong
> > > checksum in the transport layer).
> > > A quick solution is to just deactivate checksum offloading.
> > >
> > > 2.
> > > I remember some problems with Virtex-4 presamples too.
> > > There where problems with the hard-temac wrapper. You had to use 1.00=
=2Ea
> > > and not b version.
> > > But I don't have these problems with the EDK 9.2sp2/ISE9.2sp3 anymore.
> > >
> > > all the best,
> > > Robert
> > >
> > > Magnus Hjorth wrote:
> > > > Hi John,
> > > >
> > > > Thanks for the very fast reply! Right now I'm not at work so I don't
> > > > have the board or EDK here to test anything.
> > > >
> > > > I'm using checksum offload, but I don't know if DRE is enabled or n=
ot.
> > I
> > > > can't recall seeing any setting to enable/disable DRE..
> > > >
> > > > A few things that crossed my mind:
> > > >
> > > > Last year I did a design with EDK 8.2, back then there was an issue
> > with
> > > > the ML403 boards having an old revision of the FPGA which wasn't
> > > > compatible with some versions of the IP core. There are no such
> > version
> > > > issues with the xps_ll_temac?
> > > >
> > > > I don't think that I had phy-addr set in the DTS file. Will test th=
at
> > on
> > > > Monday.
> > > >
> > > > Best regards,
> > > > Magnus
> > > >
> > > >
> > > > On Sat, 2008-03-29 at 07:58 -0600, John Linn wrote:
> > > >
> > > >> Hi Magnus,
> > > >>
> > > >> Sorry to hear you're having problems with it.
> > > >>
> > > >> I am doing testing on an ML405 which is the same board but with a
> > bigger
> > > FPGA, but with ppc arch and I don't see this issue. I have done limit=
ed
> > testing
> > > with powerpc arch and the LL TEMAC, but I didn't see this issue there
> > either.
> > > Powerpc arch is definitely less mature in my experience than the ppc
> > arch. I'll
> > > do a quick test with my powerpc arch and make sure again I'm not seei=
ng
> > it.
> > > >>
> > > >> My kernel is from the Xilinx Git tree, but there have been a number
> > of
> > > changes we have pushed out so I don't know how long ago you pulled fr=
om
> > the Git
> > > tree.
> > > >>
> > > >> My EDK project is 10.1 so it's a little newer. I am using LL TEMAC
> > 1.01a so
> > > it's a little newer.  I reviewed the change log for the LL TEMAC and
> > don't see
> > > any big problems that were fixed in the newer versions, more new
> > features.  I'll
> > > check with some others here to see if I missed something there.
> > > >>
> > > >> I am using DMA also, but no DRE or checksum offload.  You didn't s=
ay
> > anything
> > > about those. I'm going to insert my mhs file that describes my system=
 to
> > let you
> > > compare your system configuration. It's not clear to me yet if you ha=
ve
> > a h/w or
> > > s/w problem.
> > > >>
> > > >> I'll also insert some of my device tree with the LL TEMAC so you c=
an
> > compare
> > > (ignore 16550 stuff as we are still working on that).
> > > >>
> > > >> Since you can't ping reliably I would probably focus on that since
> > it's
> > > simpler than the other issues you're seeing.
> > > >>
> > > >> Thanks,
> > > >> John
> > > >>
> > > >>
> > > >>
> > > >> #
> > >
> > #######################################################################=
#######
> > > >> # Created by Base System Builder Wizard for Xilinx EDK 10.1.1 Build
> > > EDK_K_SP1.1
> > > >> # Thu Feb 14 14:11:12 2008
> > > >> # Target Board:  Xilinx Virtex 4 ML405 Evaluation Platform Rev 1
> > > >> # Family:    virtex4
> > > >> # Device:    xc4vfx20
> > > >> # Package:   ff672
> > > >> # Speed Grade:  -10
> > > >> # Processor: ppc405_0
> > > >> # Processor clock frequency: 300.00 MHz
> > > >> # Bus clock frequency: 100.00 MHz
> > > >> # On Chip Memory :   8 KB
> > > >> # Total Off Chip Memory : 128 MB
> > > >> # - DDR_SDRAM =3D 128 MB
> > > >> #
> > >
> > #######################################################################=
#######
> > > >>  PARAMETER VERSION =3D 2.1.0
> > > >>
> > > >>
> > > >>  PORT fpga_0_RS232_Uart_sin_pin =3D fpga_0_RS232_Uart_sin, DIR =3D=
 I
> > > >>  PORT fpga_0_RS232_Uart_sout_pin =3D fpga_0_RS232_Uart_sout, DIR =
=3D O
> > > >>  PORT fpga_0_LEDs_4Bit_GPIO_IO_pin =3D fpga_0_LEDs_4Bit_GPIO_IO, D=
IR =3D
> > IO, VEC
> > > =3D [0:3]
> > > >>  PORT fpga_0_IIC_EEPROM_Scl_pin =3D fpga_0_IIC_EEPROM_Scl, DIR =3D=
 IO
> > > >>  PORT fpga_0_IIC_EEPROM_Sda_pin =3D fpga_0_IIC_EEPROM_Sda, DIR =3D=
 IO
> > > >>  PORT fpga_0_SysACE_CompactFlash_SysACE_CLK_pin =3D
> > > fpga_0_SysACE_CompactFlash_SysACE_CLK, DIR =3D I
> > > >>  PORT fpga_0_SysACE_CompactFlash_SysACE_MPA_pin =3D
> > > fpga_0_SysACE_CompactFlash_SysACE_MPA, DIR =3D O, VEC =3D [6:1]
> > > >>  PORT fpga_0_SysACE_CompactFlash_SysACE_MPD_pin =3D
> > > fpga_0_SysACE_CompactFlash_SysACE_MPD, DIR =3D IO, VEC =3D [15:0]
> > > >>  PORT fpga_0_SysACE_CompactFlash_SysACE_CEN_pin =3D
> > > fpga_0_SysACE_CompactFlash_SysACE_CEN, DIR =3D O
> > > >>  PORT fpga_0_SysACE_CompactFlash_SysACE_OEN_pin =3D
> > > fpga_0_SysACE_CompactFlash_SysACE_OEN, DIR =3D O
> > > >>  PORT fpga_0_SysACE_CompactFlash_SysACE_WEN_pin =3D
> > > fpga_0_SysACE_CompactFlash_SysACE_WEN, DIR =3D O
> > > >>  PORT fpga_0_SysACE_CompactFlash_SysACE_MPIRQ_pin =3D
> > > fpga_0_SysACE_CompactFlash_SysACE_MPIRQ, DIR =3D I
> > > >>  PORT fpga_0_DDR_SDRAM_DDR_Clk_pin =3D fpga_0_DDR_SDRAM_DDR_Clk, D=
IR =3D
> > O
> > > >>  PORT fpga_0_DDR_SDRAM_DDR_Clk_n_pin =3D fpga_0_DDR_SDRAM_DDR_Clk_=
n,
> > DIR =3D O
> > > >>  PORT fpga_0_DDR_SDRAM_DDR_Addr_pin =3D fpga_0_DDR_SDRAM_DDR_Addr,=
 DIR
> > =3D O, VEC
> > > =3D [12:0]
> > > >>  PORT fpga_0_DDR_SDRAM_DDR_BankAddr_pin =3D
> > fpga_0_DDR_SDRAM_DDR_BankAddr, DIR
> > > =3D O, VEC =3D [1:0]
> > > >>  PORT fpga_0_DDR_SDRAM_DDR_CAS_n_pin =3D fpga_0_DDR_SDRAM_DDR_CAS_=
n,
> > DIR =3D O
> > > >>  PORT fpga_0_DDR_SDRAM_DDR_CE_pin =3D fpga_0_DDR_SDRAM_DDR_CE, DIR=
 =3D O
> > > >>  PORT fpga_0_DDR_SDRAM_DDR_CS_n_pin =3D fpga_0_DDR_SDRAM_DDR_CS_n,=
 DIR
> > =3D O
> > > >>  PORT fpga_0_DDR_SDRAM_DDR_RAS_n_pin =3D fpga_0_DDR_SDRAM_DDR_RAS_=
n,
> > DIR =3D O
> > > >>  PORT fpga_0_DDR_SDRAM_DDR_WE_n_pin =3D fpga_0_DDR_SDRAM_DDR_WE_n,=
 DIR
> > =3D O
> > > >>  PORT fpga_0_DDR_SDRAM_DDR_DM_pin =3D fpga_0_DDR_SDRAM_DDR_DM, DIR=
 =3D O,
> > VEC =3D
> > > [3:0]
> > > >>  PORT fpga_0_DDR_SDRAM_DDR_DQS =3D fpga_0_DDR_SDRAM_DDR_DQS, DIR =
=3D IO,
> > VEC =3D
> > > [3:0]
> > > >>  PORT fpga_0_DDR_SDRAM_DDR_DQ =3D fpga_0_DDR_SDRAM_DDR_DQ, DIR =3D=
 IO,
> > VEC =3D
> > > [31:0]
> > > >>  PORT fpga_0_TriMode_MAC_GMII_GMII_TXD_0_pin =3D
> > > fpga_0_TriMode_MAC_GMII_GMII_TXD_0, DIR =3D O, VEC =3D [7:0]
> > > >>  PORT fpga_0_TriMode_MAC_GMII_GMII_TX_EN_0_pin =3D
> > > fpga_0_TriMode_MAC_GMII_GMII_TX_EN_0, DIR =3D O
> > > >>  PORT fpga_0_TriMode_MAC_GMII_GMII_TX_ER_0_pin =3D
> > > fpga_0_TriMode_MAC_GMII_GMII_TX_ER_0, DIR =3D O
> > > >>  PORT fpga_0_TriMode_MAC_GMII_GMII_TX_CLK_0_pin =3D
> > > fpga_0_TriMode_MAC_GMII_GMII_TX_CLK_0, DIR =3D O
> > > >>  PORT fpga_0_TriMode_MAC_GMII_GMII_RXD_0_pin =3D
> > > fpga_0_TriMode_MAC_GMII_GMII_RXD_0, DIR =3D I, VEC =3D [7:0]
> > > >>  PORT fpga_0_TriMode_MAC_GMII_GMII_RX_DV_0_pin =3D
> > > fpga_0_TriMode_MAC_GMII_GMII_RX_DV_0, DIR =3D I
> > > >>  PORT fpga_0_TriMode_MAC_GMII_GMII_RX_ER_0_pin =3D
> > > fpga_0_TriMode_MAC_GMII_GMII_RX_ER_0, DIR =3D I
> > > >>  PORT fpga_0_TriMode_MAC_GMII_GMII_RX_CLK_0_pin =3D
> > > fpga_0_TriMode_MAC_GMII_GMII_RX_CLK_0, DIR =3D I
> > > >>  PORT fpga_0_TriMode_MAC_GMII_MII_TX_CLK_0_pin =3D
> > > fpga_0_TriMode_MAC_GMII_MII_TX_CLK_0, DIR =3D I
> > > >>  PORT fpga_0_TriMode_MAC_GMII_MDIO_0_pin =3D
> > fpga_0_TriMode_MAC_GMII_MDIO_0,
> > > DIR =3D IO
> > > >>  PORT fpga_0_TriMode_MAC_GMII_MDC_0_pin =3D
> > fpga_0_TriMode_MAC_GMII_MDC_0, DIR
> > > =3D O
> > > >>  PORT fpga_0_TriMode_MAC_GMII_TemacPhy_RST_n_pin =3D
> > > fpga_0_TriMode_MAC_GMII_TemacPhy_RST_n, DIR =3D O
> > > >>  PORT sys_clk_pin =3D dcm_clk_s, DIR =3D I, SIGIS =3D CLK, CLK_FRE=
Q =3D
> > 100000000
> > > >>  PORT sys_rst_pin =3D sys_rst_s, DIR =3D I, RST_POLARITY =3D 0, SI=
GIS =3D RST
> > > >>
> > > >>
> > > >> BEGIN ppc405_virtex4
> > > >>  PARAMETER INSTANCE =3D ppc405_0
> > > >>  PARAMETER HW_VER =3D 2.01.a
> > > >>  PARAMETER C_FASTEST_PLB_CLOCK =3D DPLB1
> > > >>  PARAMETER C_IDCR_BASEADDR =3D 0b0100000000
> > > >>  PARAMETER C_IDCR_HIGHADDR =3D 0b0111111111
> > > >>  BUS_INTERFACE JTAGPPC =3D jtagppc_0_0
> > > >>  BUS_INTERFACE IPLB0 =3D plb
> > > >>  BUS_INTERFACE DPLB0 =3D plb
> > > >>  BUS_INTERFACE IPLB1 =3D ppc405_0_iplb1
> > > >>  BUS_INTERFACE DPLB1 =3D ppc405_0_dplb1
> > > >>  BUS_INTERFACE RESETPPC =3D ppc_reset_bus
> > > >>  PORT CPMC405CLOCK =3D proc_clk_s
> > > >>  PORT EICC405EXTINPUTIRQ =3D EICC405EXTINPUTIRQ
> > > >> END
> > > >>
> > > >> BEGIN jtagppc_cntlr
> > > >>  PARAMETER INSTANCE =3D jtagppc_0
> > > >>  PARAMETER HW_VER =3D 2.01.a
> > > >>  BUS_INTERFACE JTAGPPC0 =3D jtagppc_0_0
> > > >> END
> > > >>
> > > >> BEGIN plb_v46
> > > >>  PARAMETER INSTANCE =3D plb
> > > >>  PARAMETER C_DCR_INTFCE =3D 0
> > > >>  PARAMETER C_NUM_CLK_PLB2OPB_REARB =3D 100
> > > >>  PARAMETER HW_VER =3D 1.02.a
> > > >>  PORT PLB_Clk =3D sys_clk_s
> > > >>  PORT SYS_Rst =3D sys_bus_reset
> > > >> END
> > > >>
> > > >> BEGIN xps_bram_if_cntlr
> > > >>  PARAMETER INSTANCE =3D xps_bram_if_cntlr_1
> > > >>  PARAMETER HW_VER =3D 1.00.a
> > > >>  PARAMETER C_SPLB_NATIVE_DWIDTH =3D 64
> > > >>  PARAMETER C_BASEADDR =3D 0xffffe000
> > > >>  PARAMETER C_HIGHADDR =3D 0xffffffff
> > > >>  BUS_INTERFACE SPLB =3D plb
> > > >>  BUS_INTERFACE PORTA =3D xps_bram_if_cntlr_1_port
> > > >> END
> > > >>
> > > >> BEGIN bram_block
> > > >>  PARAMETER INSTANCE =3D plb_bram_if_cntlr_1_bram
> > > >>  PARAMETER HW_VER =3D 1.00.a
> > > >>  BUS_INTERFACE PORTA =3D xps_bram_if_cntlr_1_port
> > > >> END
> > > >>
> > > >> BEGIN xps_uart16550
> > > >>  PARAMETER INSTANCE =3D RS232_Uart
> > > >>  PARAMETER HW_VER =3D 2.00.a
> > > >>  PARAMETER C_IS_A_16550 =3D 1
> > > >>  PARAMETER C_BASEADDR =3D 0x83e00000
> > > >>  PARAMETER C_HIGHADDR =3D 0x83e0ffff
> > > >>  BUS_INTERFACE SPLB =3D plb
> > > >>  PORT sin =3D fpga_0_RS232_Uart_sin
> > > >>  PORT sout =3D fpga_0_RS232_Uart_sout
> > > >>  PORT IP2INTC_Irpt =3D RS232_Uart_IP2INTC_Irpt
> > > >> END
> > > >>
> > > >> BEGIN xps_gpio
> > > >>  PARAMETER INSTANCE =3D LEDs_4Bit
> > > >>  PARAMETER HW_VER =3D 1.00.a
> > > >>  PARAMETER C_INTERRUPT_PRESENT =3D 1
> > > >>  PARAMETER C_GPIO_WIDTH =3D 4
> > > >>  PARAMETER C_IS_DUAL =3D 0
> > > >>  PARAMETER C_IS_BIDIR =3D 1
> > > >>  PARAMETER C_ALL_INPUTS =3D 0
> > > >>  PARAMETER C_BASEADDR =3D 0x81400000
> > > >>  PARAMETER C_HIGHADDR =3D 0x8140ffff
> > > >>  BUS_INTERFACE SPLB =3D plb
> > > >>  PORT GPIO_IO =3D fpga_0_LEDs_4Bit_GPIO_IO
> > > >>  PORT IP2INTC_Irpt =3D LEDs_4Bit_IP2INTC_Irpt
> > > >> END
> > > >>
> > > >> BEGIN xps_iic
> > > >>  PARAMETER INSTANCE =3D IIC_EEPROM
> > > >>  PARAMETER HW_VER =3D 2.00.a
> > > >>  PARAMETER C_CLK_FREQ =3D 100000000
> > > >>  PARAMETER C_IIC_FREQ =3D 100000
> > > >>  PARAMETER C_TEN_BIT_ADR =3D 0
> > > >>  PARAMETER C_BASEADDR =3D 0x81600000
> > > >>  PARAMETER C_HIGHADDR =3D 0x8160ffff
> > > >>  BUS_INTERFACE SPLB =3D plb
> > > >>  PORT Scl =3D fpga_0_IIC_EEPROM_Scl
> > > >>  PORT Sda =3D fpga_0_IIC_EEPROM_Sda
> > > >>  PORT IIC2INTC_Irpt =3D IIC_EEPROM_IIC2INTC_Irpt
> > > >> END
> > > >>
> > > >> BEGIN xps_sysace
> > > >>  PARAMETER INSTANCE =3D SysACE_CompactFlash
> > > >>  PARAMETER HW_VER =3D 1.00.a
> > > >>  PARAMETER C_MEM_WIDTH =3D 16
> > > >>  PARAMETER C_BASEADDR =3D 0x83600000
> > > >>  PARAMETER C_HIGHADDR =3D 0x8360ffff
> > > >>  BUS_INTERFACE SPLB =3D plb
> > > >>  PORT SysACE_CLK =3D fpga_0_SysACE_CompactFlash_SysACE_CLK
> > > >>  PORT SysACE_MPA =3D fpga_0_SysACE_CompactFlash_SysACE_MPA_split
> > > >>  PORT SysACE_MPD =3D fpga_0_SysACE_CompactFlash_SysACE_MPD
> > > >>  PORT SysACE_CEN =3D fpga_0_SysACE_CompactFlash_SysACE_CEN
> > > >>  PORT SysACE_OEN =3D fpga_0_SysACE_CompactFlash_SysACE_OEN
> > > >>  PORT SysACE_WEN =3D fpga_0_SysACE_CompactFlash_SysACE_WEN
> > > >>  PORT SysACE_MPIRQ =3D fpga_0_SysACE_CompactFlash_SysACE_MPIRQ
> > > >>  PORT SysACE_IRQ =3D SysACE_CompactFlash_SysACE_IRQ
> > > >> END
> > > >>
> > > >> BEGIN mpmc
> > > >>  PARAMETER INSTANCE =3D DDR_SDRAM
> > > >>  PARAMETER HW_VER =3D 4.00.a
> > > >>  PARAMETER C_NUM_PORTS =3D 3
> > > >>  PARAMETER C_MEM_PARTNO =3D HYB25D512160BE-5
> > > >>  PARAMETER C_MEM_DATA_WIDTH =3D 32
> > > >>  PARAMETER C_MEM_DQS_WIDTH =3D 4
> > > >>  PARAMETER C_MEM_DM_WIDTH =3D 4
> > > >>  PARAMETER C_MEM_TYPE =3D DDR
> > > >>  PARAMETER C_NUM_IDELAYCTRL =3D 2
> > > >>  PARAMETER C_IDELAYCTRL_LOC =3D IDELAYCTRL_X0Y3-IDELAYCTRL_X0Y2
> > > >>  PARAMETER C_PIM0_BASETYPE =3D 2
> > > >>  PARAMETER C_PIM1_BASETYPE =3D 2
> > > >>  PARAMETER C_PIM2_BASETYPE =3D 3
> > > >>  PARAMETER C_MPMC_CLK0_PERIOD_PS =3D 10000
> > > >>  PARAMETER C_SDMA2_PI2LL_CLK_RATIO =3D 1
> > > >>  PARAMETER C_MPMC_BASEADDR =3D 0x00000000
> > > >>  PARAMETER C_MPMC_HIGHADDR =3D 0x07ffffff
> > > >>  PARAMETER C_SDMA_CTRL_BASEADDR =3D 0x84600000
> > > >>  PARAMETER C_SDMA_CTRL_HIGHADDR =3D 0x8460ffff
> > > >>  BUS_INTERFACE SPLB0 =3D ppc405_0_iplb1
> > > >>  BUS_INTERFACE SPLB1 =3D ppc405_0_dplb1
> > > >>  BUS_INTERFACE SDMA_LL2 =3D TriMode_MAC_GMII_LLINK0
> > > >>  BUS_INTERFACE SDMA_CTRL2 =3D plb
> > > >>  PORT DDR_Addr =3D fpga_0_DDR_SDRAM_DDR_Addr
> > > >>  PORT DDR_BankAddr =3D fpga_0_DDR_SDRAM_DDR_BankAddr
> > > >>  PORT DDR_CAS_n =3D fpga_0_DDR_SDRAM_DDR_CAS_n
> > > >>  PORT DDR_CE =3D fpga_0_DDR_SDRAM_DDR_CE
> > > >>  PORT DDR_CS_n =3D fpga_0_DDR_SDRAM_DDR_CS_n
> > > >>  PORT DDR_RAS_n =3D fpga_0_DDR_SDRAM_DDR_RAS_n
> > > >>  PORT DDR_WE_n =3D fpga_0_DDR_SDRAM_DDR_WE_n
> > > >>  PORT DDR_DM =3D fpga_0_DDR_SDRAM_DDR_DM
> > > >>  PORT DDR_DQS =3D fpga_0_DDR_SDRAM_DDR_DQS
> > > >>  PORT DDR_DQ =3D fpga_0_DDR_SDRAM_DDR_DQ
> > > >>  PORT DDR_Clk =3D fpga_0_DDR_SDRAM_DDR_Clk
> > > >>  PORT DDR_Clk_n =3D fpga_0_DDR_SDRAM_DDR_Clk_n
> > > >>  PORT MPMC_Clk0 =3D sys_clk_s
> > > >>  PORT MPMC_Clk90 =3D DDR_SDRAM_mpmc_clk_90_s
> > > >>  PORT SDMA2_Clk =3D sys_clk_s
> > > >>  PORT MPMC_Clk_200MHz =3D clk_200mhz_s
> > > >>  PORT MPMC_Rst =3D sys_periph_reset
> > > >>  PORT SDMA2_Rx_IntOut =3D DDR_SDRAM_SDMA2_Rx_IntOut
> > > >>  PORT SDMA2_Tx_IntOut =3D DDR_SDRAM_SDMA2_Tx_IntOut
> > > >> END
> > > >>
> > > >> BEGIN xps_ll_temac
> > > >>  PARAMETER INSTANCE =3D TriMode_MAC_GMII
> > > >>  PARAMETER HW_VER =3D 1.01.a
> > > >>  PARAMETER C_SPLB_CLK_PERIOD_PS =3D 10000
> > > >>  PARAMETER C_PHY_TYPE =3D 1
> > > >>  PARAMETER C_NUM_IDELAYCTRL =3D 4
> > > >>  PARAMETER C_IDELAYCTRL_LOC =3D IDELAYCTRL_X1Y1-IDELAYCTRL_X1Y3-
> > > IDELAYCTRL_X2Y2-IDELAYCTRL_X2Y3
> > > >>  PARAMETER C_TEMAC_TYPE =3D 1
> > > >>  PARAMETER C_BUS2CORE_CLK_RATIO =3D 1
> > > >>  PARAMETER C_BASEADDR =3D 0x81c00000
> > > >>  PARAMETER C_HIGHADDR =3D 0x81c0ffff
> > > >>  BUS_INTERFACE SPLB =3D plb
> > > >>  BUS_INTERFACE LLINK0 =3D TriMode_MAC_GMII_LLINK0
> > > >>  PORT GMII_TXD_0 =3D fpga_0_TriMode_MAC_GMII_GMII_TXD_0
> > > >>  PORT GMII_TX_EN_0 =3D fpga_0_TriMode_MAC_GMII_GMII_TX_EN_0
> > > >>  PORT GMII_TX_ER_0 =3D fpga_0_TriMode_MAC_GMII_GMII_TX_ER_0
> > > >>  PORT GMII_TX_CLK_0 =3D fpga_0_TriMode_MAC_GMII_GMII_TX_CLK_0
> > > >>  PORT GMII_RXD_0 =3D fpga_0_TriMode_MAC_GMII_GMII_RXD_0
> > > >>  PORT GMII_RX_DV_0 =3D fpga_0_TriMode_MAC_GMII_GMII_RX_DV_0
> > > >>  PORT GMII_RX_ER_0 =3D fpga_0_TriMode_MAC_GMII_GMII_RX_ER_0
> > > >>  PORT GMII_RX_CLK_0 =3D fpga_0_TriMode_MAC_GMII_GMII_RX_CLK_0
> > > >>  PORT MII_TX_CLK_0 =3D fpga_0_TriMode_MAC_GMII_MII_TX_CLK_0
> > > >>  PORT MDIO_0 =3D fpga_0_TriMode_MAC_GMII_MDIO_0
> > > >>  PORT MDC_0 =3D fpga_0_TriMode_MAC_GMII_MDC_0
> > > >>  PORT TemacPhy_RST_n =3D fpga_0_TriMode_MAC_GMII_TemacPhy_RST_n
> > > >>  PORT GTX_CLK_0 =3D temac_clk_s
> > > >>  PORT REFCLK =3D clk_200mhz_s
> > > >>  PORT LlinkTemac0_CLK =3D sys_clk_s
> > > >>  PORT TemacIntc0_Irpt =3D TriMode_MAC_GMII_TemacIntc0_Irpt
> > > >> END
> > > >>
> > > >> BEGIN util_bus_split
> > > >>  PARAMETER INSTANCE =3D SysACE_CompactFlash_util_bus_split_0
> > > >>  PARAMETER HW_VER =3D 1.00.a
> > > >>  PARAMETER C_SIZE_IN =3D 7
> > > >>  PARAMETER C_LEFT_POS =3D 0
> > > >>  PARAMETER C_SPLIT =3D 6
> > > >>  PORT Sig =3D fpga_0_SysACE_CompactFlash_SysACE_MPA_split
> > > >>  PORT Out1 =3D fpga_0_SysACE_CompactFlash_SysACE_MPA
> > > >> END
> > > >>
> > > >> BEGIN plb_v46
> > > >>  PARAMETER INSTANCE =3D ppc405_0_iplb1
> > > >>  PARAMETER HW_VER =3D 1.02.a
> > > >>  PORT PLB_Clk =3D sys_clk_s
> > > >>  PORT SYS_Rst =3D sys_bus_reset
> > > >> END
> > > >>
> > > >> BEGIN plb_v46
> > > >>  PARAMETER INSTANCE =3D ppc405_0_dplb1
> > > >>  PARAMETER HW_VER =3D 1.02.a
> > > >>  PORT PLB_Clk =3D sys_clk_s
> > > >>  PORT SYS_Rst =3D sys_bus_reset
> > > >> END
> > > >>
> > > >> BEGIN clock_generator
> > > >>  PARAMETER INSTANCE =3D clock_generator_0
> > > >>  PARAMETER HW_VER =3D 2.00.a
> > > >>  PARAMETER C_EXT_RESET_HIGH =3D 1
> > > >>  PARAMETER C_CLKIN_FREQ =3D 100000000
> > > >>  PARAMETER C_CLKOUT0_FREQ =3D 100000000
> > > >>  PARAMETER C_CLKOUT0_BUF =3D TRUE
> > > >>  PARAMETER C_CLKOUT0_PHASE =3D 0
> > > >>  PARAMETER C_CLKOUT0_GROUP =3D DCM0
> > > >>  PARAMETER C_CLKOUT1_FREQ =3D 100000000
> > > >>  PARAMETER C_CLKOUT1_BUF =3D TRUE
> > > >>  PARAMETER C_CLKOUT1_PHASE =3D 90
> > > >>  PARAMETER C_CLKOUT1_GROUP =3D DCM0
> > > >>  PARAMETER C_CLKOUT2_FREQ =3D 300000000
> > > >>  PARAMETER C_CLKOUT2_BUF =3D TRUE
> > > >>  PARAMETER C_CLKOUT2_PHASE =3D 0
> > > >>  PARAMETER C_CLKOUT2_GROUP =3D DCM0
> > > >>  PARAMETER C_CLKOUT3_FREQ =3D 200000000
> > > >>  PARAMETER C_CLKOUT3_BUF =3D TRUE
> > > >>  PARAMETER C_CLKOUT3_PHASE =3D 0
> > > >>  PARAMETER C_CLKOUT3_GROUP =3D NONE
> > > >>  PARAMETER C_CLKOUT4_FREQ =3D 125000000
> > > >>  PARAMETER C_CLKOUT4_BUF =3D TRUE
> > > >>  PARAMETER C_CLKOUT4_PHASE =3D 0
> > > >>  PARAMETER C_CLKOUT4_GROUP =3D NONE
> > > >>  PORT CLKOUT0 =3D sys_clk_s
> > > >>  PORT CLKOUT1 =3D DDR_SDRAM_mpmc_clk_90_s
> > > >>  PORT CLKOUT2 =3D proc_clk_s
> > > >>  PORT CLKOUT3 =3D clk_200mhz_s
> > > >>  PORT CLKOUT4 =3D temac_clk_s
> > > >>  PORT CLKIN =3D dcm_clk_s
> > > >>  PORT LOCKED =3D Dcm_all_locked
> > > >>  PORT RST =3D net_gnd
> > > >> END
> > > >>
> > > >> BEGIN proc_sys_reset
> > > >>  PARAMETER INSTANCE =3D proc_sys_reset_0
> > > >>  PARAMETER HW_VER =3D 2.00.a
> > > >>  PARAMETER C_EXT_RESET_HIGH =3D 0
> > > >>  BUS_INTERFACE RESETPPC0 =3D ppc_reset_bus
> > > >>  PORT Slowest_sync_clk =3D sys_clk_s
> > > >>  PORT Dcm_locked =3D Dcm_all_locked
> > > >>  PORT Ext_Reset_In =3D sys_rst_s
> > > >>  PORT Bus_Struct_Reset =3D sys_bus_reset
> > > >>  PORT Peripheral_Reset =3D sys_periph_reset
> > > >> END
> > > >>
> > > >> BEGIN xps_intc
> > > >>  PARAMETER INSTANCE =3D xps_intc_0
> > > >>  PARAMETER HW_VER =3D 1.00.a
> > > >>  PARAMETER C_BASEADDR =3D 0x81800000
> > > >>  PARAMETER C_HIGHADDR =3D 0x8180ffff
> > > >>  BUS_INTERFACE SPLB =3D plb
> > > >>  PORT Irq =3D EICC405EXTINPUTIRQ
> > > >>  PORT Intr =3D RS232_Uart_IP2INTC_Irpt & LEDs_4Bit_IP2INTC_Irpt &
> > > IIC_EEPROM_IIC2INTC_Irpt & SysACE_CompactFlash_SysACE_IRQ &
> > > TriMode_MAC_GMII_TemacIntc0_Irpt & DDR_SDRAM_SDMA2_Rx_IntOut &
> > > DDR_SDRAM_SDMA2_Tx_IntOut
> > > >> END
> > > >>
> > > >>
> > > >>
> > > >>    #address-cells =3D <1>;
> > > >>    #size-cells =3D <1>;
> > > >>    compatible =3D "xlnx,virtex";
> > > >>    model =3D "testing";
> > > >>    DDR_SDRAM: memory@0 {
> > > >>            device_type =3D "memory";
> > > >>            reg =3D < 0 8000000 >;
> > > >>    } ;
> > > >>    chosen {
> > > >>            bootargs =3D "console=3DttyS0,9600 ip=3Don
> > > nfsroot=3D172.16.40.76:/v2pclients/jhl26,tcp";
> > > >>            linux,stdout-path =3D "/plb@0/serial@83e00000";
> > > >>    } ;
> > > >>    cpus {
> > > >>            #address-cells =3D <1>;
> > > >>            #cpus =3D <1>;
> > > >>            #size-cells =3D <0>;
> > > >>            ppc405_0: cpu@0 {
> > > >>                    clock-frequency =3D <11e1a300>;
> > > >>                    compatible =3D "PowerPC,405", "ibm,ppc405";
> > > >>                    d-cache-line-size =3D <20>;
> > > >>                    d-cache-size =3D <4000>;
> > > >>                    device_type =3D "cpu";
> > > >>                    i-cache-line-size =3D <20>;
> > > >>                    i-cache-size =3D <4000>;
> > > >>                    model =3D "PowerPC,405";
> > > >>                    reg =3D <0>;
> > > >>                    timebase-frequency =3D <11e1a300>;
> > > >>                    xlnx,apu-control =3D <de00>;
> > > >>                    xlnx,apu-udi-1 =3D <a18983>;
> > > >>                    xlnx,apu-udi-2 =3D <a38983>;
> > > >>                    xlnx,apu-udi-3 =3D <a589c3>;
> > > >>                    xlnx,apu-udi-4 =3D <a789c3>;
> > > >>                    xlnx,apu-udi-5 =3D <a98c03>;
> > > >>                    xlnx,apu-udi-6 =3D <ab8c03>;
> > > >>                    xlnx,apu-udi-7 =3D <ad8c43>;
> > > >>                    xlnx,apu-udi-8 =3D <af8c43>;
> > > >>                    xlnx,deterministic-mult =3D <0>;
> > > >>                    xlnx,disable-operand-forwarding =3D <1>;
> > > >>                    xlnx,fastest-plb-clock =3D "DPLB0";
> > > >>                    xlnx,generate-plb-timespecs =3D <1>;
> > > >>                    xlnx,mmu-enable =3D <1>;
> > > >>                    xlnx,pvr-high =3D <0>;
> > > >>                    xlnx,pvr-low =3D <0>;
> > > >>            } ;
> > > >>    } ;
> > > >>    plb: plb@0 {
> > > >>            #address-cells =3D <1>;
> > > >>            #size-cells =3D <1>;
> > > >>            compatible =3D "xlnx,plb-v46-1.02.a";
> > > >>            ranges ;
> > > >>            IIC_EEPROM: i2c@81600000 {
> > > >>                    compatible =3D "xlnx,xps-iic-2.00.a";
> > > >>                    interrupt-parent =3D <&xps_intc_0>;
> > > >>                    interrupts =3D < 4 2 >;
> > > >>                    reg =3D < 81600000 10000 >;
> > > >>                    xlnx,clk-freq =3D <5f5e100>;
> > > >>                    xlnx,family =3D "virtex4";
> > > >>                    xlnx,gpo-width =3D <1>;
> > > >>                    xlnx,iic-freq =3D <186a0>;
> > > >>                    xlnx,scl-inertial-delay =3D <0>;
> > > >>                    xlnx,sda-inertial-delay =3D <0>;
> > > >>                    xlnx,ten-bit-adr =3D <0>;
> > > >>            } ;
> > > >>            LEDs_4Bit: gpio@81400000 {
> > > >>                    compatible =3D "xlnx,xps-gpio-1.00.a";
> > > >>                    interrupt-parent =3D <&xps_intc_0>;
> > > >>                    interrupts =3D < 5 2 >;
> > > >>                    reg =3D < 81400000 10000 >;
> > > >>                    xlnx,all-inputs =3D <0>;
> > > >>                    xlnx,all-inputs-2 =3D <0>;
> > > >>                    xlnx,dout-default =3D <0>;
> > > >>                    xlnx,dout-default-2 =3D <0>;
> > > >>                    xlnx,family =3D "virtex4";
> > > >>                    xlnx,gpio-width =3D <4>;
> > > >>                    xlnx,interrupt-present =3D <1>;
> > > >>                    xlnx,is-bidir =3D <1>;
> > > >>                    xlnx,is-bidir-2 =3D <1>;
> > > >>                    xlnx,is-dual =3D <0>;
> > > >>                    xlnx,tri-default =3D <ffffffff>;
> > > >>                    xlnx,tri-default-2 =3D <ffffffff>;
> > > >>            } ;
> > > >>            RS232_Uart: serial@83e00000 {
> > > >>                    compatible =3D "xlnx,xps-uart16550-2.00.a";
> > > >> //                 compatible =3D "ns16550";
> > > >>                    device_type =3D "serial";
> > > >>                    interrupt-parent =3D <&xps_intc_0>;
> > > >>                    interrupts =3D < 6 2 >;
> > > >>                    reg =3D < 83e00000 10000 >;
> > > >>                    current-speed =3D <d#9600>;
> > > >>                    clock-frequency =3D <d#100000000>;  /* added
> > > by jhl */
> > > >>                    reg-shift =3D <2>;
> > > >>                    xlnx,family =3D "virtex4";
> > > >>                    xlnx,has-external-rclk =3D <0>;
> > > >>                    xlnx,has-external-xin =3D <0>;
> > > >>                    xlnx,is-a-16550 =3D <1>;
> > > >>            } ;
> > > >>            SysACE_CompactFlash: sysace@83600000 {
> > > >>                    compatible =3D "xlnx,xps-sysace-1.00.a";
> > > >>                    interrupt-parent =3D <&xps_intc_0>;
> > > >>                    interrupts =3D < 3 2 >;
> > > >>                    reg =3D < 83600000 10000 >;
> > > >>                    xlnx,family =3D "virtex4";
> > > >>                    xlnx,mem-width =3D <10>;
> > > >>            } ;
> > > >>            TriMode_MAC_GMII: xps-ll-temac@81c00000 {
> > > >>                    #address-cells =3D <1>;
> > > >>                    #size-cells =3D <1>;
> > > >>                    compatible =3D "xlnx,compound";
> > > >>                    ethernet@81c00000 {
> > > >>                            compatible =3D "xlnx,xps-ll-temac-
> > > 1.01.a";
> > > >>                            device_type =3D "network";
> > > >>                            interrupt-parent =3D
> > > <&xps_intc_0>;
> > > >>                            interrupts =3D < 2 2 >;
> > > >>                            llink-connected =3D <&PIM2>;
> > > >>                            local-mac-address =3D [ 02 00 00
> > > 00 00 01 ];
> > > >>                            reg =3D < 81c00000 40 >;
> > > >>                            xlnx,bus2core-clk-ratio =3D <1>;
> > > >>                            xlnx,phy-type =3D <1>;
> > > >>                            xlnx,phyaddr =3D <1>;
> > > >>                            xlnx,rxcsum =3D <0>;
> > > >>                            xlnx,rxfifo =3D <1000>;
> > > >>                            xlnx,temac-type =3D <1>;
> > > >>                            xlnx,txcsum =3D <0>;
> > > >>                            xlnx,txfifo =3D <1000>;
> > > >>                    } ;
> > > >>            } ;
> > > >>            mpmc@0 {
> > > >>                    #address-cells =3D <1>;
> > > >>                    #size-cells =3D <1>;
> > > >>                    compatible =3D "xlnx,mpmc-4.00.a";
> > > >>                    PIM2: sdma@84600100 {
> > > >>                            compatible =3D "xlnx,ll-dma-
> > > 1.00.a";
> > > >>                            interrupt-parent =3D
> > > <&xps_intc_0>;
> > > >>                            interrupts =3D < 1 2 0 2 >;
> > > >>                            reg =3D < 84600100 80 >;
> > > >>                    } ;
> > > >>            } ;
> > > >>            xps_bram_if_cntlr_1: xps-bram-if-cntlr@ffffe000 {
> > > >>                    compatible =3D "xlnx,xps-bram-if-cntlr-
> > > 1.00.a";
> > > >>                    reg =3D < ffffe000 2000 >;
> > > >>                    xlnx,family =3D "virtex4";
> > > >>            } ;
> > > >>            xps_intc_0: interrupt-controller@81800000 {
> > > >>                    #interrupt-cells =3D <2>;
> > > >>                    compatible =3D "xlnx,xps-intc-1.00.a";
> > > >>                    interrupt-controller ;
> > > >>                    reg =3D < 81800000 10000 >;
> > > >>                    xlnx,num-intr-inputs =3D <7>;
> > > >>            } ;
> > > >>    } ;
> > > >>    ppc405_0_dplb1: plb@1 {
> > > >>            #address-cells =3D <1>;
> > > >>            #size-cells =3D <1>;
> > > >>            compatible =3D "xlnx,plb-v46-1.02.a";
> > > >>            ranges ;
> > > >>    } ;
> > > >> }  ;
> > > >>
> > > >>
> > > >>
> > > >> -----Original Message-----
> > > >> From: Magnus Hjorth [mailto:mh@omnisys.se]
> > > >> Sent: Saturday, March 29, 2008 6:54 AM
> > > >> To: git
> > > >> Cc: linuxppc-embedded@ozlabs.org
> > > >> Subject: Xilinx LLTEMAC driver issues
> > > >>
> > > >> Hi,
> > > >>
> > > >> I'm having some networking troubles with the Xilinx LLTEMAC driver
> > from the
> > > >> Xilinx Linux git tree (powerpc arch) on an ML403 board. EDK9.2SP2,
> > > >> xps_ll_temac v1.00.b
> > > >>
> > > >> The weird thing is, that it sort of half works. It successfully ma=
kes
> > a DHCP
> > > >> request and gets its IP address. I tried setting up a tftpd server,
> > and I can
> > > >> see UDP requests coming in but the response doesn't seem to come o=
ut.
> > I also
> > > >> tried running a TCP server on the board, and it can see and accept
> > incoming
> > > >> connections but after that no data seems to get through. I can ping
> > out and
> > > >> get around 40% packet loss.
> > > >>
> > > >> Looking at /proc/interrupts, I can see both TxDma interrupts and
> > RxDma
> > > >> interrupts. No eth0 interrupts but that seems to be OK judging by =
the
> > driver
> > > >> source comments. Ifconfig shows no collistions, no dropped packets,
> > no
> > > errors,
> > > >> so the system seems to think that everything is OK.
> > > >>
> > > >> Clues anyone? I'm starting to run out of ideas...
> > > >>
> > > >> Best regards,
> > > >> Magnus
> > > >>
> > > >>
> > > >> --
> > > >>
> > > >> Magnus Hjorth, M.Sc.
> > > >> Omnisys Instruments AB
> > > >> Gruvgatan 8
> > > >> SE-421 30  V=C3=A4stra Fr=C3=B6lunda, SWEDEN
> > > >> Phone: +46 31 734 34 09
> > > >> Fax: +46 31 734 34 29
> > > >> http://www.omnisys.se
> > > >>
> > > >
> > > > _______________________________________________
> > > > Linuxppc-embedded mailing list
> > > > Linuxppc-embedded@ozlabs.org
> > > > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
>=20
>=20
>=20
> --=20
> Johann Baudy
> johaahn@gmail.com
>=20
