Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 075DAB6F9C
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jun 2011 02:15:02 +1000 (EST)
Message-ID: <4E021113.10909@embedded-sol.com>
Date: Wed, 22 Jun 2011 18:58:11 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Tabi Timur-B04825 <B04825@freescale.com>
Subject: Connecting SGMII PHY to eTSEC1 on P1022
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On a custom P1022-based board I have SGMII PHY connected to eTSEC1.
PHY address is 0x1. Ethernet works fine in u-boot, but in linux 
there's no link.
I have the following in my device tree:

         mdio@24000 {
             #address-cells = <1>;
             #size-cells = <0>;
             compatible = "fsl,etsec2-mdio";
             reg = <0x24000 0x1000 0xb0030 0x4>;

             phy0: ethernet-phy@1 {
                 interrupt-parent = <&mpic>;
                 interrupts = <3 1>;
                 reg = <0x1>;
             };

             tbi0: tbi-phy@11 {
                 reg = <0x11>;
                 device_type = "tbi-phy";
             };

         };

         enet0: ethernet@B0000 {
             #address-cells = <1>;
             #size-cells = <1>;
             cell-index = <0>;
             device_type = "network";
             model = "eTSEC";
             compatible = "fsl,etsec2";
             fsl,num_rx_queues = <0x8>;
             fsl,num_tx_queues = <0x8>;
             fsl,magic-packet;
             fsl,wake-on-filer;
             clk-handle = <&etsec1_clk>;
             local-mac-address = [ 00 00 00 00 00 00 ];
             interrupt-parent = <&mpic>;
             phy-handle = <&phy0>;
             tbi-handle = <&tbi0>;
             phy-connection-type = "sgmii";
             ...
         };

What am I doing wrong ?

Thanks a lot in advance.

Felix.
