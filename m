Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 17D60DDE06
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 12:08:14 +1100 (EST)
Date: Thu, 30 Oct 2008 18:07:31 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Nate Case <ncase@xes-inc.com>
Subject: Re: [PATCH] gianfar: Omit TBI auto-negotiation based on device tree
In-Reply-To: <1225234382-23050-1-git-send-email-ncase@xes-inc.com>
Message-ID: <Pine.LNX.4.64.0810301738020.3943@t2.domain.actdsltmp>
References: <1225234382-23050-1-git-send-email-ncase@xes-inc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>,
	Andy Fleming <afleming@freescale.com>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 28 Oct 2008, Nate Case wrote:
> Some SGMII PHYs don't auto-negotiate correctly with the TBI+SerDes
> interface on the mpc85xx processors.  Check for the "sgmii-aneg-disable"
> device tree flag and skip enabling auto-negotiation on the TBI
> side if present.  Full duplex 1000 Mbit/s will be assumed for the
> SGMII link to the PHY (note that this does not affect the link speed
> on the external side of the external PHY).

Note that there is a race in the tbi/serdes setup code.  The writes to the
TBI/SerDes with gfar_local_mdio_write() use the same MDIO bus registers as
phylib uses to talk to the real phy or phys.  There is no locking for
gfar_local_mdio vs phylib so they can (and will) clobber each other.

It doesn't usually happen, due to luck and general phylib slowness.  But I've
got some patches in 2.6.28 that speed up phylib and might makes this happen
more often...

But more relevant to your serdes problem, I also have a patch that prevents
restarting serdes auto-negotiation if the serdes link is already up.  My SGMII
PHY will auto-negotiate, but it takes about 3 seconds.  Avoiding an
unnecessary 3 second auto-negotiation when the gianfar device is opened lets
me cut my power-on to DHCP completion time in half.

I wonder if this would also fix your problem, without needing to add the extra
workaround?
