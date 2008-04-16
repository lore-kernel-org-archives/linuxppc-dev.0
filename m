Return-Path: <super.firetwister@googlemail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 26189DDFAD
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 20:49:54 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so718023anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 03:49:46 -0700 (PDT)
Message-ID: <6a6049b80804160349q42120b4bs1c0db49ea5ad055d@mail.gmail.com>
Date: Wed, 16 Apr 2008 12:49:46 +0200
From: "M B" <super.firetwister@googlemail.com>
To: netdev@vger.kernel.org
Subject: Phy read timeout in ibm_new_emac driver
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The __emac_mdio_read function of the emac driver (core.c) will retry
100 times and wait 99us (until the last call of emac_phy_done). I
assume this is an off by one error.

	/* Wait for read to complete */
	n = 100;
	while (!emac_phy_done(dev, (r = in_be32(&p->stacr)))) {
		udelay(1);
		if (!--n) {
			DBG2(dev, " -> timeout wait complete\n");
			goto bail;
		}
	}

My Micrel/Kendin KSZ8721BT on my ppc405EP board needs one us longer to
finish. I was able to reproduce this all the time. So I wonder if the
timeout of 100us is defined by the MII standard, or by the author of
the driver?
If it's a standard I've still a bad feeling if we just correct the
timeout to 100us, maybe 110 should be fine. If it's not defined by the
standard, I would add 50% to the timeout. It won't slow down other
phys, but a scan on the phy bus might get slowed down.
Same applies for __emac_mdio_write.

Oh and we could save a us by putting the udelay(1) after the if section ;-)

Regards

Markus
