Return-Path: <laurent.pinchart@technotrade.biz>
Received: from mailrelay008.isp.belgacom.be (mailrelay008.isp.belgacom.be
	[195.238.6.174]) by ozlabs.org (Postfix) with ESMTP id 1E12ADDEC8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 00:20:01 +1000 (EST)
From: Laurent Pinchart <laurent.pinchart@technotrade.biz>
To: linuxppc-embedded@ozlabs.org
Subject: MPC82xx ADS SCC ports initialisation
Date: Tue, 10 Jul 2007 16:19:51 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707101619.52438.laurent.pinchart@technotrade.biz>
Cc: vbordug@ru.mvista.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody,

while checking the availability of MPC8260 support in ARCH=powerpc, I ran 
across a possible issue in SCC ports initialisation for the MPC82xx ADS 
boards.

init_scc1_uart_ioports and init_scc4_uart_ioports in 
arch/powerpc/platforms/mpc82xx/mpx82xx_ads.c use the following code to 
configure the SCC clocks:

clrbits32(&immap->im_cpmux.cmx_scr, (0x00000007 << (4 - data->clk_tx)));
clrbits32(&immap->im_cpmux.cmx_scr, (0x00000038 << (4 - data->clk_rx)));
setbits32(&immap->im_cpmux.cmx_scr, 
          ((data->clk_tx - 1) << (4 - data->clk_tx)));
setbits32(&immap->im_cpmux.cmx_scr,
          ((data->clk_rx - 1) << (4 - data->clk_rx)));

The shift right-hand operand doesn't seem to be correct. Could anyone confirm 
this ? If my assumption is right, could anyone tell me if the MPC82xx 
processors are actually supported by the powerpc architecture, or if the 
MPC82xx ADS code is just a non-functional work in progress.

I also noticed that U-Boot doesn't have flatten device tree support for the 
MPC82xx family. There seem to be still a lot of work to do to support the 
MPC82xx in the powerpc tree, and the effort is much bigger than just porting 
a board from ppc to powerpc.

Laurent Pinchart
