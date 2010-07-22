Return-Path: <dbaryshkov@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) by ozlabs.org (Postfix) with ESMTP id 53920B70CE
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 02:48:17 +1000 (EST)
Received: by fxm17 with SMTP id 17so4814796fxm.15
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 09:48:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <566EC982-1CDA-4806-8EC0-8C9F36448F83@kernel.crashing.org>
References: <1279756992-29543-1-git-send-email-dbaryshkov@gmail.com>
	<1279756992-29543-2-git-send-email-dbaryshkov@gmail.com>
	<566EC982-1CDA-4806-8EC0-8C9F36448F83@kernel.crashing.org>
Date: Thu, 22 Jul 2010 20:48:15 +0400
Message-ID: <AANLkTim7kbHsouc==7gRAuRO6AYMNVdA4yyPFpRBC+QR@mail.gmail.com>
Subject: Re: [PATCH 2/2] mpc85xx_edac: change to use new definitions for PCI
	EDAC regspace
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	Doug Thompson <dougthompson@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Thu, Jul 22, 2010 at 7:38 PM, Kumar Gala <galak@kernel.crashing.org> wro=
te:
>
> On Jul 21, 2010, at 7:03 PM, Dmitry Eremin-Solenikov wrote:
>
>> Currently (as mpc8540-pci) devices are not created on of_platform bus,
>> mpc85xx_edac can't probe to them. Follow the change to dts trees to bind
>> not to the main mpc8540-pci node but to special mpc85xx-pci-error nodes,
>> present on soc bus.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> ---
>> drivers/edac/mpc85xx_edac.c | =A0 18 +++++++++---------
>> 1 files changed, 9 insertions(+), 9 deletions(-)
>
> Nak.
>
> We already have a node in the dts for the PCI controller. =A0Lets update =
the platform code to add the pci controller to the of_platform_bus_probe li=
st.

I've had that idea. However it's really look strange to me to call
of_platform_bus_probe() on the bus node, for which we (IMO) explicitly
won't like for
child devices (PCI devices) to be added to of_platform bus. Would it
be suitable to just call of_platform_device_create for it (Or do i
miss someth<ing)?

BTW: While I'm at it, should I change all mpc8540-pci/-pcix device
names to include respective SoC name?

--=20
With best wishes
Dmitry
