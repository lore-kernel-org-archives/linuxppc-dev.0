Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 501F0B6EF7
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jun 2010 05:00:14 +1000 (EST)
Message-ID: <4C1FB6BB.4040705@mlbassoc.com>
Date: Mon, 21 Jun 2010 13:00:11 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Subject: UCC interactions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm running 2.6.33.3 on MPC8358.  I have UCC1+UCC2 working fine
for ethernet, but when I add UCC3 as a UART, the network devices
quit working.

Here are my device tree entries:
          /* ETH0 (UCC1, MDIO 0x02, RMII) */
          enet_eth0: ethernet@2000 {
             device_type = "network";
             compatible = "ucc_geth";
             cell-index = <1>;
             reg = <0x2000 0x200>;
             interrupts = <32>;
             interrupt-parent = <&qeic>;
             local-mac-address = [ 00 00 00 00 00 00 ];
             rx-clock-name = "none";
             tx-clock-name = "clk16";
             phy-handle = <&phy_eth0>;
             phy-connection-type = "rmii";
             pio-handle = <&pio_ucc1>;
             linux,network-index = <0>;
          };

          /* ETH1 (UCC2, MDIO 0x01, GMII) */
          enet_eth1: ethernet@3000 {
             device_type = "network";
             compatible = "ucc_geth";
             cell-index = <2>;
             reg = <0x3000 0x200>;
             interrupts = <33>;
             interrupt-parent = <&qeic>;
             local-mac-address = [ 00 00 00 00 00 00 ];
             rx-clock-name = "clk4";
             tx-clock-name = "none";
             fixed-link = <1 1 1000 0 0>;
             phy-connection-type = "gmii";
             pio-handle = <&pio_ucc2>;
             linux,network-index = <1>;
          };

          /* ttyQE0 (UCC3) */
          serial_qe0: serial@4000 {
             device_type = "serial";
             compatible = "ucc_uart";
             cell-index = <3>;
             reg = <0x4000 0x200>;
             interrupts = <34>;
             interrupt-parent = <&qeic>;
             port-number = <0>;
             rx-clock-name = "brg1";
             tx-clock-name = "brg1";
          };

Are there known interactions between these two drivers/ports?
Maybe there's something obviously wrong with my device tree?

Thanks for any ideas/pointers

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
