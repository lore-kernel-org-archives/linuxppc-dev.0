Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 407CDB70D2
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 04:40:34 +1000 (EST)
Subject: Re: [PATCH 2/2] mpc85xx_edac: change to use new definitions for PCI
	EDAC regspace
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100722132548.6eef941b@schlenkerla.am.freescale.net>
Date: Thu, 22 Jul 2010 13:40:19 -0500
Message-Id: <95F6CFEA-DC74-4CF6-A195-4CBFABAAB7F0@kernel.crashing.org>
References: <1279756992-29543-1-git-send-email-dbaryshkov@gmail.com>
	<1279756992-29543-2-git-send-email-dbaryshkov@gmail.com>
	<566EC982-1CDA-4806-8EC0-8C9F36448F83@kernel.crashing.org>
	<AANLkTim7kbHsouc==7gRAuRO6AYMNVdA4yyPFpRBC+QR@mail.gmail.com>
	<20100722132548.6eef941b@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linuxppc-dev@ozlabs.org,
	bluesmoke-devel@lists.sourceforge.net,
	Doug Thompson <dougthompson@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 22, 2010, at 1:25 PM, Scott Wood wrote:

> On Thu, 22 Jul 2010 20:48:15 +0400
> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
>=20
>> Hello,
>>=20
>> On Thu, Jul 22, 2010 at 7:38 PM, Kumar Gala =
<galak@kernel.crashing.org> wrote:
>>>=20
>>> On Jul 21, 2010, at 7:03 PM, Dmitry Eremin-Solenikov wrote:
>>>=20
>>>> Currently (as mpc8540-pci) devices are not created on of_platform =
bus,
>>>> mpc85xx_edac can't probe to them. Follow the change to dts trees to =
bind
>>>> not to the main mpc8540-pci node but to special mpc85xx-pci-error =
nodes,
>>>> present on soc bus.
>>>>=20
>>>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>>>> ---
>>>> drivers/edac/mpc85xx_edac.c |   18 +++++++++---------
>>>> 1 files changed, 9 insertions(+), 9 deletions(-)
>>>=20
>>> Nak.
>>>=20
>>> We already have a node in the dts for the PCI controller.  Lets =
update the platform code to add the pci controller to the =
of_platform_bus_probe list.
>>=20
>> I've had that idea. However it's really look strange to me to call
>> of_platform_bus_probe() on the bus node, for which we (IMO) =
explicitly
>> won't like for
>> child devices (PCI devices) to be added to of_platform bus.
>=20
> Right, and it's also not great for a driver for one aspect of PCI to
> claim to be the driver for the whole thing.
>=20
> But changing the device tree because of this Linux-internal concern is
> also not good.
>=20
> How about keeping the error stuff as a separate device from Linux's
> perspective, but have the main Freescale PCI code create it as a
> platform device instead of putting it in the device tree?

I'd be good with that solution.

- k=
