Return-Path: <g.schardt@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with SMTP id B9E35DDE47
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Nov 2007 23:03:35 +1100 (EST)
Message-ID: <473AE411.30009@fz-juelich.de>
Date: Wed, 14 Nov 2007 13:03:29 +0100
From: schardt <g.schardt@fz-juelich.de>
MIME-Version: 1.0
To: alex_snippet <alex.snippet@gmail.com>
Subject: Re: Virtex TEMAC 1000Mb/s trouble, but 100b/s is working
References: <13743302.post@talk.nabble.com>
In-Reply-To: <13743302.post@talk.nabble.com>
Content-Type: text/plain;
	charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have the same problem with the FX12 Minimodul, runing 2.6.23 kernel...

running the nfs-kernel-server on the host, i could mount the
nfs-directory from the target with -o nolock,tcp
running the nfs-user-kernel failed

with both server i could not mount root-fs in the boot process

i gave up at this moment and take the root-fs to flash memory

regards
georg


alex_snippet wrote:
> Hi all!
>
> I'm porting Linux for custom board based on Virtex4 FX, vanilla kernel
> 2.6.22.5 , Xilinx EDK 9.1 BSP, 
> ELDK41 - cross-compiler 
> target nfs-root pointed to ELDK41/ppc_4xx
>
> Kernel command line:
> Linux/PPC load: root=/dev/nfs rw console=ttyS0,9600
> nfsroot=192.168.0.1:/target
> ip=on
>
> All work successfully was done, i tested all at 100Mb's connection speed,
> but yesterday my customer said that with 1Gbit connection it did't work :(
> end of log following:
>
>     3.341532] eth0: XTemac: Options: 0xb8f2
> [   11.855386] eth0: XTemac: We renegotiated the speed to: 1000
> [   11.923237] eth0: XTemac: speed set to 1000Mb/s
> [   13.000064] Sending DHCP requests ......, OK
> [   65.484075] IP-Config: Got DHCP answer from 0.0.0.0, my address is
> 192.168.0.
> 192
> [   65.573684] IP-Config: Complete:
> [   65.610416]       device=eth0, addr=192.168.0.192, mask=255.255.255.0,
> gw=192
> .168.0.1,
> [   65.705572]      host=192.168.0.192, domain=, nis-domain=(none),
> [   65.777872]      bootserver=0.0.0.0, rootserver=192.168.0.1, rootpath=
> [   65.861982] Looking up port of RPC 100003/2 on 192.168.0.1
> [   65.929093] Looking up port of RPC 100005/1 on 192.168.0.1
> [   66.024134] VFS: Mounted root (nfs filesystem).
> [   66.079160] Freeing unused kernel memory: 104k init
> [   71.640314] nfs: server 192.168.0.1 not responding, still trying
> [   76.040311] nfs: server 192.168.0.1 not responding, still trying
>
> Load process was friezed at this point. When connection speed is 100Mb/s
> everything is ok.
>
> Please advise me what to do, i tried to increase ppc core frequency from 100
> to 300 MHz - the same problem. 
> When i'm using virtual machine instead of real hardware it's working on
> 1000Gb/s :) but isn't on real hardware.
> I'm using Fedora 7 as a host.
> May be there are some nfs-demon settings?
>
> My MHS file fragment:
>
> BEGIN hard_temac
>  PARAMETER INSTANCE = hard_temac_0
>  PARAMETER HW_VER = 3.00.b
>  PARAMETER C_PHY_TYPE = 1
>  PARAMETER C_EMAC1_PRESENT = 0
>  BUS_INTERFACE V4EMACDST0 = V4EMAC0
>  PORT GMII_TXD_0 = GMII_TXD0
>  PORT GMII_TX_EN_0 = GMII_TX_EN0
>  PORT GMII_TX_ER_0 = GMII_TX_ER0
>  PORT GMII_TX_CLK_0 = GMII_TX_CLK0
>  PORT GMII_RXD_0 = GMII_RXD0
>  PORT GMII_RX_DV_0 = GMII_RX_DV0
>  PORT GMII_RX_ER_0 = GMII_RX_ER0
>  PORT GMII_RX_CLK_0 = GMII_RX_CLK0
>  PORT MDC_0 = MDC0
>  PORT MDIO_0 = MDIO0
>  PORT GTX_CLK_0 = GTX_CLK0
>  PORT MII_TX_CLK_0 = MII_TX_CLK0
>  PORT RESET = Emac_Reset
>  PORT REFCLK = sys_clk_s
> END
>
> BEGIN plb_temac
>  PARAMETER INSTANCE = TriMode_MAC_GMII
>  PARAMETER HW_VER = 3.00.a
>  PARAMETER C_BASEADDR = 0x81200000
>  PARAMETER C_HIGHADDR = 0x8120ffff
>  PARAMETER C_MAC_FIFO_DEPTH = 64
>  PARAMETER C_RX_DRE_TYPE = 0
>  PARAMETER C_TX_DRE_TYPE = 0
>  PARAMETER C_DMA_TYPE = 1
>  PARAMETER C_PLB_CLK_PERIOD_PS = 10000
>  BUS_INTERFACE MSPLB = plb
>  BUS_INTERFACE V4EMACSRC = V4EMAC0
>  PORT IP2INTC_Irpt = TEMAC_Interrupt
>  PORT Emac_Reset = Emac_Reset
>  PORT PhyResetN = PhyResetN
> END
>
>   



-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
Forschungszentrum Jülich GmbH
52425 Jülich

Sitz der Gesellschaft: Jülich
Eingetragen im Handelsregister des Amtsgerichts Düren Nr. HR B 3498
Vorsitzende des Aufsichtsrats: MinDirig'in Bärbel Brumme-Bothe
Geschäftsführung: Prof. Dr. Achim Bachem (Vorsitzender), Dr. Ulrich Krafft (stellv. 
Vorsitzender)
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
