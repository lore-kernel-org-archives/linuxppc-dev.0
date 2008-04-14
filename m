Return-Path: <super.firetwister@googlemail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 9F4A8DF019
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 03:39:01 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so475960anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 10:38:54 -0700 (PDT)
Message-ID: <6a6049b80804141038k77ac361cl11f50bc9d890c6a2@mail.gmail.com>
Date: Mon, 14 Apr 2008 19:38:54 +0200
From: "M B" <super.firetwister@googlemail.com>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Get new_emac driver running on 405EP
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
I'm trying to get the new_emac driver (linux 2.6.25-rc8) running on my
405EP board with a KSZ8721BT Micrel/Kendin PHY.
I've already found 2 problems/missing features:
1) 100 retries in __emac_mdio_read for the read to complete are
slightly too less. 101 seem to be enough. But we could add a bit more,
because there is no negative effect for faster chips.
2) On the 405EP only the MDIO pin of the emac0 is pinned out, so both
phys have to be accessed through this one. This affectes the mdio
read/write functions.

I've already hacked around this problems, but ethernet is still not working.
After bringing up the device dmesg is flooded with this section.
emac/plb/opb/ethernet@ef600800: link timer
emac/plb/opb/ethernet@ef600800: mdio_read(00,01)
emac/plb/opb/ethernet@ef600800: mdio_read -> 786d
emac/plb/opb/ethernet@ef600800: mdio_read(00,01)
emac/plb/opb/ethernet@ef600800: mdio_read -> 786d


Any ideas where I should start looking?

Best Regards

Markus


A ping doesn't work
==============

# ifconfig eth0 1.1.1.1
eth0: link is up, 100 FDX, pause enabled

# ping 1.1.1.1 -c1
PING 1.1.1.1 (1.1.1.1): 56 data bytes

--- 1.1.1.1 ping statistics ---
1 packets transmitted, 0 packets received, 100% packet loss

No data gets transmitted
==================
# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:50:C2:1E:AF:FE
          inet addr:1.1.1.1  Bcast:1.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
          Interrupt:23

And no interrupts triggered
===================
# cat /proc/interrupts
           CPU0
 16:        737   UIC   Level     serial
 18:          0   UIC   Level     MAL TX EOB
 19:          0   UIC   Level     MAL RX EOB
 20:          0   UIC   Level     MAL SERR
 21:          0   UIC   Level     MAL TX DE
 22:          0   UIC   Level     MAL RX DE
BAD:          0


dmesg section after boot, debug level of emac driver is 3
=========================================

ef600400.serial: ttyS1 at MMIO 0xef600400 (irq = 17) is a 16550A
PPC 4xx OCP EMAC driver, version 3.54
mal/plb/mcmal: probe
mal/plb/mcmal: reset
mal/plb/mcmal: enable_irq
MAL v1 /plb/mcmal, 4 TX channels, 4 RX channels
emac/plb/opb/ethernet@ef600800: features     : 0x00000000 / 0x00000000
emac/plb/opb/ethernet@ef600800: tx_fifo_size : 2048 (2048 gige)
emac/plb/opb/ethernet@ef600800: rx_fifo_size : 4096 (4096 gige)
emac/plb/opb/ethernet@ef600800: max_mtu      : 1500
emac/plb/opb/ethernet@ef600800: OPB freq     : 66000000
mal/plb/mcmal: reg(80000000, 80000000)
emac/plb/opb/ethernet@ef600800: tx_desc ff100000
emac/plb/opb/ethernet@ef600800: rx_desc ff100800
emac/plb/opb/ethernet@ef600800: PHY maps 00000000 00000000
emac/plb/opb/ethernet@ef600800: configure
emac/plb/opb/ethernet@ef600800: reset
emac/plb/opb/ethernet@ef600800: rx_disable
emac/plb/opb/ethernet@ef600800: tx_disable
emac/plb/opb/ethernet@ef600800:  link = 1 duplex = 1, pause = 0, asym_pause = 0
emac/plb/opb/ethernet@ef600800: __emac_calc_base_mr1
emac/plb/opb/ethernet@ef600800: mdio_read(00,00)
emac/plb/opb/ethernet@ef600800: mdio_read -> 3100
emac/plb/opb/ethernet@ef600800: mdio_read(00,00)
emac/plb/opb/ethernet@ef600800: mdio_read -> 3100
emac/plb/opb/ethernet@ef600800: mdio_write(00,00,a100)
emac/plb/opb/ethernet@ef600800: mdio_read(00,00)
emac/plb/opb/ethernet@ef600800: mdio_read -> 3100
emac/plb/opb/ethernet@ef600800: mdio_read(00,02)
emac/plb/opb/ethernet@ef600800: mdio_read -> 0022
emac/plb/opb/ethernet@ef600800: mdio_read(00,03)
emac/plb/opb/ethernet@ef600800: mdio_read -> 1619
emac/plb/opb/ethernet@ef600800: mdio_read(00,01)
emac/plb/opb/ethernet@ef600800: mdio_read -> 7849
emac/plb/opb/ethernet@ef600800: mdio_read(00,00)
emac/plb/opb/ethernet@ef600800: mdio_read -> 3100
emac/plb/opb/ethernet@ef600800: mdio_write(00,00,0000)
emac/plb/opb/ethernet@ef600800: mdio_read(00,04)
emac/plb/opb/ethernet@ef600800: mdio_read -> 01e1
emac/plb/opb/ethernet@ef600800: mdio_write(00,04,0de1)
emac/plb/opb/ethernet@ef600800: mdio_read(00,00)
emac/plb/opb/ethernet@ef600800: mdio_read -> 0000
emac/plb/opb/ethernet@ef600800: mdio_write(00,00,1200)
emac/plb/opb/ethernet@ef600800: stats
eth0: EMAC-0 /plb/opb/ethernet@ef600800, MAC 00:50:c2:1e:af:fe
eth0: found Generic MII PHY (0x00)
emac/plb/opb/ethernet@ef600900: features     : 0x00000000 / 0x00000000
emac/plb/opb/ethernet@ef600900: tx_fifo_size : 2048 (2048 gige)
emac/plb/opb/ethernet@ef600900: rx_fifo_size : 4096 (4096 gige)
emac/plb/opb/ethernet@ef600900: max_mtu      : 1500
emac/plb/opb/ethernet@ef600900: OPB freq     : 66000000
mal/plb/mcmal: reg(20000000, 40000000)
emac/plb/opb/ethernet@ef600900: tx_desc ff100400
emac/plb/opb/ethernet@ef600900: rx_desc ff100c00
emac/plb/opb/ethernet@ef600900: PHY maps 00000020 00000001
emac/plb/opb/ethernet@ef600900: configure
emac/plb/opb/ethernet@ef600900: reset
emac/plb/opb/ethernet@ef600900: rx_disable
emac/plb/opb/ethernet@ef600900: tx_disable
emac/plb/opb/ethernet@ef600900:  link = 1 duplex = 1, pause = 0, asym_pause = 0
emac/plb/opb/ethernet@ef600900: __emac_calc_base_mr1
emac/plb/opb/ethernet@ef600900: mdio_read(01,00)
emac/plb/opb/ethernet@ef600900: mdio_read -> 3100
emac/plb/opb/ethernet@ef600900: mdio_read(01,00)
emac/plb/opb/ethernet@ef600900: mdio_read -> 3100
emac/plb/opb/ethernet@ef600900: mdio_write(01,00,a100)
emac/plb/opb/ethernet@ef600900: mdio_read(01,00)
emac/plb/opb/ethernet@ef600900: mdio_read -> 3100
emac/plb/opb/ethernet@ef600900: mdio_read(01,02)
emac/plb/opb/ethernet@ef600900: mdio_read -> 0022
emac/plb/opb/ethernet@ef600900: mdio_read(01,03)
emac/plb/opb/ethernet@ef600900: mdio_read -> 1619
emac/plb/opb/ethernet@ef600900: mdio_read(01,01)
emac/plb/opb/ethernet@ef600900: mdio_read -> 7849
emac/plb/opb/ethernet@ef600900: mdio_read(01,00)
emac/plb/opb/ethernet@ef600900: mdio_read -> 3100
emac/plb/opb/ethernet@ef600900: mdio_write(01,00,0000)
emac/plb/opb/ethernet@ef600900: mdio_read(01,04)
emac/plb/opb/ethernet@ef600900: mdio_read -> 01e1
emac/plb/opb/ethernet@ef600900: mdio_write(01,04,0de1)
emac/plb/opb/ethernet@ef600900: mdio_read(01,00)
emac/plb/opb/ethernet@ef600900: mdio_read -> 0000
emac/plb/opb/ethernet@ef600900: mdio_write(01,00,1200)
emac/plb/opb/ethernet@ef600900: stats
eth1: EMAC-1 /plb/opb/ethernet@ef600900, MAC 00:50:c2:1e:af:fd
eth1: found Generic MII PHY (0x01)
TCP cubic registered


Mal and emac sections of my device tree
==============================

		MAL: mcmal {
			compatible = "ibm,mcmal-405ep", "ibm,mcmal";
			dcr-reg = <180 62>;
			num-tx-chans = <4>;
			num-rx-chans = <4>;
			interrupt-parent = <&UIC0>;
			interrupts = <
				a 4 /* SERR */
				b 4 /* TXEOB */
				c 4 /* RXEOB */
				d 4 /* TXDE */
				e 4 /* RXDE */>;
		};

		POB0: opb {
			compatible = "ibm,opb-405ep", "ibm,opb";
			#address-cells = <1>;
			#size-cells = <1>;
			ranges = <ef600000 ef600000 a00000>;
			dcr-reg = <0a0 5>;
			clock-frequency = <3EF1480>;

			EMAC0: ethernet@ef600800 {
				linux,network-index = <0>;
				device_type = "network";
				compatible = "ibm,emac-405ep", "ibm,emac";
				interrupt-parent = <&UIC0>;
				interrupts = <
					f 4 /* Ethernet */
					9 4 /* Ethernet Wake Up */>;
				local-mac-address = [0050c21eaffe]; /* Filled in by zImage */
				reg = <ef600800 70>;
				mal-device = <&MAL>;
				mal-tx-channel = <0>;
				mal-rx-channel = <0>;
				cell-index = <0>;
				max-frame-size = <5dc>;
				rx-fifo-size = <1000>;
				tx-fifo-size = <800>;
				phy-mode = "mii";
				phy-map = <00000000>;
			};

			EMAC1: ethernet@ef600900 {
				linux,network-index = <1>;
				device_type = "network";
				compatible = "ibm,emac-405ep", "ibm,emac";
				interrupt-parent = <&UIC0>;
				interrupts = <
					11 4 /* Ethernet */
					9 4 /* Ethernet Wake Up */>;
				local-mac-address = [0050c21eaffd]; /* Filled in by zImage */
				reg = <ef600900 70>;
				mal-device = <&MAL>;
				mal-tx-channel = <2>;
				mal-rx-channel = <1>;
				cell-index = <1>;
				max-frame-size = <5dc>;
				rx-fifo-size = <1000>;
				tx-fifo-size = <800>;
				phy-mode = "mii";
				phy-map = <00000020>;
			};


Kconfig section of emac
=================

CONFIG_PHYLIB=y

#
# MII PHY device drivers
#
# CONFIG_MARVELL_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_FIXED_PHY is not set
# CONFIG_MDIO_BITBANG is not set
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_ENC28J60 is not set
CONFIG_IBM_NEW_EMAC=y
CONFIG_IBM_NEW_EMAC_RXB=128
CONFIG_IBM_NEW_EMAC_TXB=64
CONFIG_IBM_NEW_EMAC_POLL_WEIGHT=32
CONFIG_IBM_NEW_EMAC_RX_COPY_THRESHOLD=256
CONFIG_IBM_NEW_EMAC_RX_SKB_HEADROOM=0
CONFIG_IBM_NEW_EMAC_DEBUG=y
# CONFIG_IBM_NEW_EMAC_ZMII is not set
# CONFIG_IBM_NEW_EMAC_RGMII is not set
# CONFIG_IBM_NEW_EMAC_TAH is not set
# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
