Return-Path: <dbaryshkov@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) by ozlabs.org (Postfix) with ESMTP id 01949B70DA
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 05:03:05 +1000 (EST)
Received: by fxm17 with SMTP id 17so4936753fxm.15
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 12:03:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <95F6CFEA-DC74-4CF6-A195-4CBFABAAB7F0@kernel.crashing.org>
References: <1279756992-29543-1-git-send-email-dbaryshkov@gmail.com>
	<1279756992-29543-2-git-send-email-dbaryshkov@gmail.com>
	<566EC982-1CDA-4806-8EC0-8C9F36448F83@kernel.crashing.org>
	<AANLkTim7kbHsouc==7gRAuRO6AYMNVdA4yyPFpRBC+QR@mail.gmail.com>
	<20100722132548.6eef941b@schlenkerla.am.freescale.net>
	<95F6CFEA-DC74-4CF6-A195-4CBFABAAB7F0@kernel.crashing.org>
Date: Thu, 22 Jul 2010 23:03:03 +0400
Message-ID: <AANLkTikX8An80SMZiypoO63Be8MKyCsmNzviwqR6syQd@mail.gmail.com>
Subject: Re: [PATCH 2/2] mpc85xx_edac: change to use new definitions for PCI
	EDAC regspace
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
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

Hello,

On Thu, Jul 22, 2010 at 10:40 PM, Kumar Gala <galak@kernel.crashing.org> wr=
ote:
>
> On Jul 22, 2010, at 1:25 PM, Scott Wood wrote:
>
>> On Thu, 22 Jul 2010 20:48:15 +0400
>> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
>>
>>> Hello,
>>>
>>> On Thu, Jul 22, 2010 at 7:38 PM, Kumar Gala <galak@kernel.crashing.org>=
 wrote:
>>>>
>>>> On Jul 21, 2010, at 7:03 PM, Dmitry Eremin-Solenikov wrote:
>>>>
>>>>> Currently (as mpc8540-pci) devices are not created on of_platform bus=
,
>>>>> mpc85xx_edac can't probe to them. Follow the change to dts trees to b=
ind
>>>>> not to the main mpc8540-pci node but to special mpc85xx-pci-error nod=
es,
>>>>> present on soc bus.
>>>>>
>>>>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>>>>> ---
>>>>> drivers/edac/mpc85xx_edac.c | =A0 18 +++++++++---------
>>>>> 1 files changed, 9 insertions(+), 9 deletions(-)
>>>>
>>>> Nak.
>>>>
>>>> We already have a node in the dts for the PCI controller. =A0Lets upda=
te the platform code to add the pci controller to the of_platform_bus_probe=
 list.
>>>
>>> I've had that idea. However it's really look strange to me to call
>>> of_platform_bus_probe() on the bus node, for which we (IMO) explicitly
>>> won't like for
>>> child devices (PCI devices) to be added to of_platform bus.
>>
>> Right, and it's also not great for a driver for one aspect of PCI to
>> claim to be the driver for the whole thing.
>>
>> But changing the device tree because of this Linux-internal concern is
>> also not good.
>>
>> How about keeping the error stuff as a separate device from Linux's
>> perspective, but have the main Freescale PCI code create it as a
>> platform device instead of putting it in the device tree?
>
> I'd be good with that solution.

Then we come back to the question that was raised before (during initial
review of edac driver): as PCI code is probbed long before other parts
of the kernel and mpc85xx_edac code can be compiled as module,
it's not possible to directly call mpc85xx_edac code from fsl_pci.c

Two initial suggestions were:
1) creating special platform device
2) creating special of_platform device from dts

Which approach should I choose? Did i miss any other opportunities?

--=20
With best wishes
Dmitry
