Return-Path: <Christopher.Varlese@keymile.com>
Received: from mail.ch.keymile.com (mail.ch.keymile.com [193.17.201.103])
	by ozlabs.org (Postfix) with SMTP id 1DD05DDF20
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Oct 2008 22:07:21 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: MPC8360 : MDS/PIB RMII fast Ethernet help
Date: Thu, 2 Oct 2008 13:56:50 +0200
Message-ID: <D839955AA28B9A42A61B9181506E27C40121DF00@SRVCHBER1212.ch.keymile.net>
From: "Varlese, Christopher" <Christopher.Varlese@keymile.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We are working with the Freescale MPC8360 MDS evaluation board and are
having
trouble getting the 8 x Fast Ethernet (RMII) interfaces working with
Linux.

I would be interested to hear from anyone who has activated these
interfaces
with Linux or can offer useful advice.

Our setup:
    - MPC8360EA MDS eval board (MPC8360 rev 2.1)
    - PIB expansion board with 8 x FE via RMII to Realtek RTL8208 octal
PHY
    - UCC1 left in GbE/RGMII mode as the host debug connection
    - UCC2 and UCC3 try to bring up in FE/RMII mode
    - Linux kernel 2.6.26.5 and Freescale LTIB BSP environment

We tried both UCC2 and UCC3.  UCC3 has a simpler connection just to the
octal FE
PHY; UCC2 can support both GbE/RGMII and FE/RMII setup via configuration
to the
board FPGA and I2C to switch the PHY interconnection.   For now we focus
more
on UCC3 as the simpler option.

Our changes to configuration and code:
    - flat device tree modified to setup:
           - MPC8360 pin I/O config for UCC2/UCC3 RMII mode
           - PHY config for MDIO to Realtek octal PHY
           - UCC2/3 Ethernet MAC config
    - In kernel also a few small fixes to UCC config mode for RMII:
           - UPSMR register clear bits RPM/TBIM to comply with datasheet
table 30-6

Current status:
    - Linux device instances eth1/eth2 for UCC2/UCC3 get created
    - PHYs for UCC2/UCC2 get link up 100Mbps FD and Linux device
instances
      react and are RUNNING
    - MAC level RMII loopback : can send/recv packets :-)
    - PHY level loopback : no receive packets :-(
    - No loops : no send or recv packets :-(

The UCC MAC side seems OK as the RMII loop shows. But to/from the PHY
nothing so far.

Any suggestions or anyone have patched flat device tree / code where
this was
working?


Best regards
Christopher Varlese
R&D Software
KEYMILE AG
Schwarzenburgstrasse 73
3097 Bern, Switzerland
www.keymile.com=20
