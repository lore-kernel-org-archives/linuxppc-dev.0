Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 25B0CDDF6C
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 11:58:33 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l0U0wR9x011665
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 18:58:28 -0600
Subject: EMAC device-tree binding (#2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 30 Jan 2007 11:58:27 +1100
Message-Id: <1170118707.26655.299.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

According to the various comments I got, here's the latest binding for
EMAC:

* The OPB node needs a "clock-frequency" property

* In the EMAC node itself (plb5/plb4/opb/ethernet)

 - name              : "ethernet"
 - device_type       : "network"
 - compatible        : compatible list, contains 2 entries, first is "ibm,emac-CHIP" where
                       CHIP is the host ASIC (440gx, 405gp, axon) and second is either
                       "ibm,emac" or "ibm,emac4".
                       For axon, thus, we have: "ibm,emac-axon","ibm,emac4"
 - model             : optional model string
 - interrupts	     : <interrupt mapping for EMAC IRQ and WOL IRQ>
 - interrupt-parent  : optional, if needed for interrupt mapping
 - reg               : <registers mapping>
 - local-mac-address : 6 bytes, MAC address
 - mal-device        : 1 cell, phandle of the associated McMAL node
 - mal-tx-channel    : 1 cell, index of the tx channel on McMAL associated with this EMAC
 - mal-rx-channel    : 1 cell, index of the rx channel on McMAL associated with this EMAC
 - cell-index        : 1 cell, hardware index of the EMAC cell on a given ASIC (typically
                       0x00000000 and 0x00000001 for EMAC-0 and EMAC-1 on each Axon chip)
 - max-frame-size    : 1 cell, maximum frame size supported in bytes
 - rx-fifo-size      : 1 cell, Rx fifo size in bytes for 10 and 100 Mb/sec operations.
                       For axon, 2048
 - rx-fifo-size-gige : 1 cell, optional, Rx fifo size in bytes for 1000 Mb/sec operations
                       (if absent the value is the same as rx-fifo-size).
                       For axon, either absent or 2048.
 - tx-fifo-size      : 1 cell, Tx fifo size in bytes for 10 and 100 Mb/sec operations. For axon
 - tx-fifo-size-gige : 1 cell, optional, Tx fifo size in bytes for 1000 Mb/sec operations
                       (if absent the value is the same as tx-fifo-size)
                       For axon, either absent or 2048.
 - fifo-entry-size   : 1 cell, size of a fifo entry (used to calculate thresholds)
                       For axon, 0x00000010
 - mal-burst-size    : 1 cell, MAL burst size (used to calculate thresholds) in bytes
                       For axon, 0x00000100 (I think ...)
 - phy-mode          : 1 cell, Mode of operations of the PHY interface:
                         #define PHY_MODE_NA    0
                         #define PHY_MODE_MII   1
                         #define PHY_MODE_RMII  2
                         #define PHY_MODE_SMII  3
                         #define PHY_MODE_RGMII 4
                         #define PHY_MODE_TBI   5
                         #define PHY_MODE_GMII  6
                         #define PHY_MODE_RTBI  7
                         #define PHY_MODE_SGMII 8
                       For axon, it is PHY_MODE_RGMII
 - phy-address       : 1 cell, optional, MDIO address of the PHY. If absent, a search
                       is performed
                       For axon: please fill with approriate value, I don't have it at
                       hand, it depends on the board and the EMAC of course.
 - phy-map           : 1 cell, optional, bitmap of addresses to probe the PHY for, used
                       if phy-address is absent. bit 0x00000001 is MDIO address 0. For axon
                       it can be absent, thouugh my current driver doesn't handle phy-address
                       yet so for now, keep 0x00ffffff in it.
 - mdio-device       : 1 cell, optional. If shared MDIO registers (440EP), phandle of the EMAC
                       to use to drive the MDIO lines for the PHY used by this EMAC.
                       For axon: absent
 - zmii-device       : 1 cell, optional. If connected to a ZMII, phandle of the ZMII device node
                       For axon: absent
 - zmii-channel      : 1 cell, optional. If connected to a ZMII, which channel or 0xffffffff if
                       ZMII is only used for MDIO
 - rgmii-device      : 1 cell, optional. If connected to a RGMII, phandle of the RGMII device node
                       For axon: phandle of plb5/plb4/opb/rgmii
 - rgmii-channel     : 1 cell, optional. If connected to a RGMII, which channel
                       Fox axon: present, whatever value is appropriate for each EMAC, that is
                       the content of the current (bogus) "phy-port" property
 - tah-device        : 1 cell, optional. If connected to a TAH engine for offload, phandle of
                       the TAH device node
 - tah-channel       : 1 cell, optional. If appropriate, channel used on the TAH engine

* In the McMAL node

 - name               : "mcmal"
 - device_type        : "mcmal-dma"
 - compatible         : compatible list, containing 2 entries, first is "ibm,mcmal-CHIP" where
                        CHIP is the hose ASIC (like emac) and the second is either "ibm,mcmal"
                        or "ibm,mcmal2".
                      : For axon, "ibm,mcmal-axon","ibm,mcmal2"
 - model              : optional model string
 - interrupts         : <interrupt mapping for the MAL interrupts sources:
                         5 sources: tx_eob, rx_eob, serr, txde, rxde>.
                        For axon: This is _different_ from the current firmware. We use
                        the "delayed" interrupts for txeob and rxeob. Thus we end up with
                        mapping those 5 MPIC interrupts, all level positive sensitive:
                        10, 11, 32, 33, 34 (in decimal)
 - dcr-reg            : < DCR registers range >
 - dcr-parent         : if needed for dcr-reg
 - num-tx-chans       : 1 cell, number of Tx channels
 - num-rx-chans       : 1 cell, number of Rx channels

* In the ZMII node

 - name               : "emac-zmii"
 - device_type        : "emac-zmii"
 - compatible         : compatible list, containing 2 entries, first is "ibm,zmii-CHIP" where
                        CHIP is the hose ASIC (like emac) and the second is "zmii"
                      : For axon, there is no ZMII node
 - model              : optional model string
 - reg                : <registers mapping>

* In the RGMII node

 - name               : "emac-rgmii"
 - device_type        : "emac-rgmii"
 - compatible         : compatible list, containing 2 entries, first is "ibm,rgmii-CHIP" where
                        CHIP is the hose ASIC (like emac) and the second is "rgmii"
                      : For axon, "ibm,rgmii-axon","ibm,rgmii"
 - model              : optional model string
 - reg                : <registers mapping>
 - revision           : as provided by the RGMII new version register if available
                        For axon: 0x0000012a
