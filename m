Message-Id: <5.1.1.6.0.20030611181918.01a3cc08@dns.struinfo.it>
Date: Wed, 11 Jun 2003 18:23:47 +0200
To: linuxppc-embedded@lists.linuxppc.org
From: llandre <r&d@wawnet.biz>
Subject: Bug in IBM 4xx on-chip Ethernet drivers?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We are developing a PPC405EP-based board. As PHY we use two STE100P from
ST. Since this chip was not supported by the Linux driver, we modified the
file ibm_ocp_phy.c (because the size limit I did not attach the file; I'll
be glad to send it to anybody interested). We submitted it to Armin Kuster
in order to put it in the official kernel tree, but we did not get any
response.
Is he still the maintainer for the PHY drivers?

Beside we have a question about the mk_mii macros in
drivers/net/ibm_ocp/ibm_ocp_enet.h. In our understanding they are wrong
because they assume the OCP bus frequency is 50MHz. In our case this
frequency is 66MHz and thus the MII clock is 3.3MHz (66/20). Since the
STE100P does not tolerate frequencies above 2.5 MHz (that is the maximum
frequency defined by the MII standard), we changed the two macros like this:

#define mk_mii_read(REG)                ((EMAC_STACR_READ| (REG & 0x1f)) & \
                                                 ~EMAC_STACR_CLK_100MHZ |
EMAC_STACR_CLK_66MHZ)
#define mk_mii_write(REG,VAL)           (((EMAC_STACR_WRITE | (REG & 0x1f)) & \
                                                 ~EMAC_STACR_CLK_100MHZ |
EMAC_STACR_CLK_66MHZ) | \
                                                 ((VAL & 0xffff) << 16))

We think it should be introduced a new #define (EMAC_STACR_CLK dor
example), and the platform specific code should set it to the appropriate
value. For example:

--- in drivers/net/ibm_ocp/ibm_ocp_enet.h ----
#define mk_mii_read(REG)                ((EMAC_STACR_READ| (REG & 0x1f)) & \
                                                 ~EMAC_STACR_CLK_100MHZ |
EMAC_STACR_CLK)

--- somewhere in the platform-specific stuff ----
#define EMAC_STACR_CLK EMAC_STACR_CLK_66MHZ

Last but not least, we think the
#define MIN_PHY_ADDR            0x00 (drivers/net/ibm_ocp/ibm_ocp_enet.h)
is not correct because every PHY attached to the MMI management interface
shall respond to this "special" address (please see clause 22.2.4.5.5 od
the IEEE Std 802.3). So the kernel, when performs the bus scan (function
find_phy in drivers/net/ibm_ocp/ibm_ocp_phy.c), finds a PHY at the address
0 even if there are no PHYs with this address. In conclusion we think
MIN_PHY_ADDR should be set to 1.

Any remarks or comments will be appreciated.


llandre


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
