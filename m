Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EC2722C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 02:27:25 +1000 (EST)
Received: from mail96-co1 (localhost [127.0.0.1])	by mail96-co1-R.bigfish.com
 (Postfix) with ESMTP id 596BCD001CF	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 30 Jul 2013 16:27:21 +0000 (UTC)
Received: from CO1EHSMHS002.bigfish.com (unknown [10.243.78.226])	by
 mail96-co1.bigfish.com (Postfix) with ESMTP id 6FAFDAA0048	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 16:27:19 +0000 (UTC)
Date: Tue, 30 Jul 2013 11:27:15 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: powerpc/85xx: Add P1023RDB board support
To: Chunhe Lan <b25806@freescale.com>
In-Reply-To: <51F793D3.6080504@freescale.com> (from b25806@freescale.com on
 Tue Jul 30 05:22:11 2013)
Message-ID: <1375201635.30721.71@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/30/2013 05:22:11 AM, Chunhe Lan wrote:
>=20
> On 07/30/2013 09:09 AM, Scott Wood wrote:
>> On Fri, Jun 14, 2013 at 04:26:20PM +0800, Chunhe Lan wrote:
>>> Ethernet:
>>>     eTSEC1: Connected to Atheros AR8035 GETH PHY
>>>     eTSEC2: Connected to Atheros AR8035 GETH PHY
>> Where are the PHYs in the device tree?
>     "Atheros AR8035 GETH PHY" driver is module_init driver. It uses =20
> the two structs of "static struct phy_driver at8035_driver" and
>     "static struct mdio_device_id __maybe_unused atheros_tbl" to =20
> register at8035_driver.
>=20
>     So do not need to add PHYs in the device tree.

Huh?  How does registering a driver eliminate the need to describe the =20
devices in the device tree?  If you're trying to say that the device =20
can be probed (like a PCI device), how do you determine which PHY goes =20
to which MAC?  I suspect the actual answer is "this chip has datapath =20
ethernet, and datapath stuff is not upstream (still!)".  That's no =20
excuse for not describing it in the device tree, though.  The device =20
tree describes the hardware, not what Linux has drivers for.

FWIW, I don't see the string "at8035_driver" anywhere in the kernel =20
(except in the SDK, which doesn't count here).  Maybe you meant =20
at803x_driver?

-Scott=
