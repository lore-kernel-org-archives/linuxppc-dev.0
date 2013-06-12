Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B5DE82C009C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jun 2013 04:31:23 +1000 (EST)
Date: Wed, 12 Jun 2013 13:31:11 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] MDIO: FSL_PQ_MDIO: Fix bug on incorrect offset of tbipa
 register
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <1371041258-15298-1-git-send-email-ogabbay@advaoptical.com>
 <51B88EED.6090709@linutronix.de>
In-Reply-To: <51B88EED.6090709@linutronix.de> (from bigeasy@linutronix.de on
 Wed Jun 12 10:08:29 2013)
Message-ID: <1371061871.18413.44@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: stef.van.os@prodrive.nl, Oded Gabbay <ogabbay@advaoptical.com>,
 netdev@vger.kernel.org, Dongsheng.Wang@freescale.com, timur@tabi.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org, B38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/12/2013 10:08:29 AM, Sebastian Andrzej Siewior wrote:
> On 06/12/2013 02:47 PM, Oded Gabbay wrote:
> > This patch fixes a bug in the fsl_pq_mdio.c module and in relevant =20
> device-tree
> > files regarding the correct offset of the tbipa register in the =20
> eTSEC
> > controller in some of Freescale's PQ3 and QorIQ SoC.
> > The bug happens when the mdio in the device tree is configured to =20
> be compatible
> > to "fsl,gianfar-tbi". Because the mdio device in the device tree =20
> points to
> > addresses 25520, 26520 or 27520 (depends on the controller ID), the =20
> variable
> > priv->map at function fsl_pq_mdio_probe, points to that address. =20
> However,
> > later in the function there is a write to register tbipa that is =20
> actually
> > located at 25030, 26030 or 27030. Because the correct address is =20
> not io mapped,
> > the contents are written to a different register in the controller.
> > The fix sets the address of the mdio device to start at 25000, =20
> 26000 or 27000
> > and changes the mii_offset field to 0x520 in the relevant entry
> > (fsl,gianfar-tbi) of the fsl_pq_mdio_match array.
> >
> > Note: This patch may break MDIO functionallity of some old =20
> Freescale's SoC
> > until Freescale will fix their device tree files. Basically, every =20
> device tree
> > which contains an mdio device that is compatible to =20
> "fsl,gianfar-tbi" should be
> > examined.
>=20
> Not as is.
> Please add a check for the original address. If it has 0x520 at the =20
> end
> print a warning and fix it up. Please add to the patch description
> which register is modified instead if this patch is not applied.
> Depending on how critical this it might has to go stable.

I'm not sure it's stable material if this is something that has never =20
worked...

The device tree binding will also need to be fixed to note the =20
difference in "reg" between "fsl,gianfar-mdio" and "fsl-gianfar-tbi" -- =20
and should give an example of the latter.

-Scott=
