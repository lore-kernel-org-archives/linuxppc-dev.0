Return-Path: <dadair@ariodata.com>
Received: from orion.ariodata.com (adsl-64-170-199-186.dsl.snfc21.pacbell.net
	[64.170.199.186]) by ozlabs.org (Postfix) with ESMTP id B384D2BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Nov 2004 09:41:40 +1100 (EST)
From: "David Adair" <dadair@ariodata.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Wed, 10 Nov 2004 14:41:47 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20041110135238.A22537@home.com>
Message-ID: <ORIONhx27kBnccYTjr800000173@orion.ariodata.com>
Subject: RE: Problems with MII mode operation on 440GP ethernet
Reply-To: dadair@ariodata.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Thanks for the advice Matt. 

> I have a custom board with the same configuration (on 2.6). The
> driver in that tree works in this configuration. FWIW, the port
> also uses ocp calls to remove the three unused interfaces. In

This sounds reasonable to me -- OCP stays cpu generic but exact
use is refined by the board port.

Can you give me any hints were to find the "ocp calls?"

> > (I also tweaked things so my version of mii-tool would work
> > does anyone else have trouble with the wrong variable size?)
> 
> I haven't tried 2.4 in a long time...others would know. A lot
> of fixes/features have gone into the 2.6 driver that haven't
> been backported to 2.4.

I'm severely 2.6 impaired, but looking at 2.6.9 there is still a mismatch
that does not exist in other drivers such as eepro100:

drivers/net/ibm_emac/ibm_emac_core.c:

static int emac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
{
	struct ocp_enet_private *fep = dev->priv;
	uint *data = (uint *) & rq->ifr_ifru;

	switch (cmd) {
	case SIOCGMIIPHY:
		data[0] = fep->mii_phy_addr;

And

include/linux/mii.h:

/* This structure is used in all SIOCxMIIxxx ioctl calls */
struct mii_ioctl_data {
	u16		phy_id;
	u16		reg_num;
	u16		val_in;
	u16		val_out;
};
