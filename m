Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C5C2DDE3B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Nov 2007 18:45:18 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IuNnG-0005KS-Vo
	for linuxppc-embedded@ozlabs.org; Mon, 19 Nov 2007 23:45:14 -0800
Message-ID: <13852281.post@talk.nabble.com>
Date: Mon, 19 Nov 2007 23:45:14 -0800 (PST)
From: Lorenz Kolb <linuxppcemb@lkmail.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Virtex TEMAC ping -s 10000 host, is it working?
In-Reply-To: <13830023.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <13770288.post@talk.nabble.com> <13790720.post@talk.nabble.com>
	<13830023.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



alex_snippet wrote:
> 
> 
> It's interesting to see some info from your design files,  PLB_TEMAC &
> HardTEMAC description from mhs,
> and kernel .config network section.
> 

.mhs


> <snip>
> BEGIN hard_temac
>  PARAMETER INSTANCE = hard_temac_0
>  PARAMETER HW_VER = 3.00.a
>  BUS_INTERFACE V4EMACDST0 = plb_temac_0_V4EMACSRC
>  PORT MII_TX_CLK_0 = fpga_0_Hard_Temac_0_MII_TX_CLK_0
>  PORT GMII_TXD_0 = fpga_0_Hard_Temac_0_GMII_TXD_0
>  PORT GMII_TX_EN_0 = fpga_0_Hard_Temac_0_GMII_TX_EN_0
>  PORT GMII_TX_ER_0 = fpga_0_Hard_Temac_0_GMII_TX_ER_0
>  PORT GMII_TX_CLK_0 = fpga_0_Hard_Temac_0_GMII_TX_CLK_0
>  PORT GMII_RXD_0 = fpga_0_Hard_Temac_0_GMII_RXD_0
>  PORT GMII_RX_DV_0 = fpga_0_Hard_Temac_0_GMII_RX_DV_0
>  PORT GMII_RX_ER_0 = fpga_0_Hard_Temac_0_GMII_RX_ER_0
>  PORT GMII_RX_CLK_0 = fpga_0_Hard_Temac_0_GMII_RX_CLK_0
>  PORT MDC_0 = fpga_0_Hard_Temac_0_MDC_0
>  PORT MDIO_0 = fpga_0_Hard_Temac_0_MDIO_0
>  PORT RESET = Emac_Reset_s
>  PORT GTX_CLK_0 = temac_0_clk_s
>  PORT REFCLK = sys_clk
> END
> 
> BEGIN plb_temac
>  PARAMETER INSTANCE = plb_temac_0
>  PARAMETER HW_VER = 3.00.a
>  PARAMETER C_MAC_FIFO_DEPTH = 64
>  PARAMETER C_RX_DRE_TYPE = 0
>  PARAMETER C_TX_DRE_TYPE = 0
>  PARAMETER C_DMA_TYPE = 1
>  PARAMETER C_PLB_CLK_PERIOD_PS = 10000
>  PARAMETER C_BASEADDR = 0x40000000
>  PARAMETER C_HIGHADDR = 0x4000FFFF
>  BUS_INTERFACE V4EMACSRC = plb_temac_0_V4EMACSRC
>  BUS_INTERFACE MSPLB = plb_v34_0
>  PORT Emac_Reset = Emac_Reset_s
>  PORT PhyResetN = fpga_0_TriMode_MAC_GMII_PhyResetN
>  PORT IP2INTC_Irpt = plb_temac_0_IP2INTC_Irpt
> END
> <snap>
> 

.config


> <snip>
> #
> # Networking
> #
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> CONFIG_PACKET_MMAP=y
> CONFIG_UNIX=y
> CONFIG_INET=y
> CONFIG_IP_FIB_HASH=y
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_DEFAULT_TCP_CONG="cubic"
> <snap>
> 

We use the Temac driver from Grant's tree.
Nevertheless we changed the auto-negotiation code, as we had problem with
the default code when using the same code in U-Boot.
I have attached our auto-negotiation patch (nevertheless the old
auto-negotiation worked fine with the linux kernel, the main reason we
patched that is to hold the code base to maintain minimal).
http://www.nabble.com/file/p13852281/0018-TEMAC-changed-renegotiation-function-to-ESIC-U-Boo.patch
0018-TEMAC-changed-renegotiation-function-to-ESIC-U-Boo.patch 


alex_snippet wrote:
> 
> The biggest problem that i actually do not understand what kind of problem
> is it, hardware or software or configuration.
> 


Regards,

--
Lorenz Kolb
Embedded specialist
ESIC Solutions
San Jose, CA
Neu-Ulm, Germany
-- 
View this message in context: http://www.nabble.com/Virtex-TEMAC-ping--s-10000-host%2C-is-it-working--tf4812989.html#a13852281
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
