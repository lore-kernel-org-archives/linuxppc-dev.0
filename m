Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
	[209.85.213.42]) by ozlabs.org (Postfix) with ESMTP id 235C71007D2
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 05:16:00 +1000 (EST)
Received: by ywi6 with SMTP id 6so1184407ywi.15
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 12:15:59 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <AANLkTikX8An80SMZiypoO63Be8MKyCsmNzviwqR6syQd@mail.gmail.com>
References: <1279756992-29543-1-git-send-email-dbaryshkov@gmail.com>
	<1279756992-29543-2-git-send-email-dbaryshkov@gmail.com>
	<566EC982-1CDA-4806-8EC0-8C9F36448F83@kernel.crashing.org>
	<AANLkTim7kbHsouc==7gRAuRO6AYMNVdA4yyPFpRBC+QR@mail.gmail.com>
	<20100722132548.6eef941b@schlenkerla.am.freescale.net>
	<95F6CFEA-DC74-4CF6-A195-4CBFABAAB7F0@kernel.crashing.org>
	<AANLkTikX8An80SMZiypoO63Be8MKyCsmNzviwqR6syQd@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 22 Jul 2010 13:15:39 -0600
Message-ID: <AANLkTimeHlrB_Q5pHGzamxtyDNq6O1yZzAKfbrND4A5m@mail.gmail.com>
Subject: Re: [PATCH 2/2] mpc85xx_edac: change to use new definitions for PCI
	EDAC regspace
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Doug Thompson <dougthompson@xmission.com>,
	bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 22, 2010 at 1:03 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> Hello,
>
> On Thu, Jul 22, 2010 at 10:40 PM, Kumar Gala <galak@kernel.crashing.org> =
wrote:
>>
>> On Jul 22, 2010, at 1:25 PM, Scott Wood wrote:
>>
>>> On Thu, 22 Jul 2010 20:48:15 +0400
>>> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
>>>
>>>> Hello,
>>>>
>>>> On Thu, Jul 22, 2010 at 7:38 PM, Kumar Gala <galak@kernel.crashing.org=
> wrote:
>>>>>
>>>>> On Jul 21, 2010, at 7:03 PM, Dmitry Eremin-Solenikov wrote:
>>>>>
>>>>>> Currently (as mpc8540-pci) devices are not created on of_platform bu=
s,
>>>>>> mpc85xx_edac can't probe to them. Follow the change to dts trees to =
bind
>>>>>> not to the main mpc8540-pci node but to special mpc85xx-pci-error no=
des,
>>>>>> present on soc bus.
>>>>>>
>>>>>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>>>>>> ---
>>>>>> drivers/edac/mpc85xx_edac.c | =A0 18 +++++++++---------
>>>>>> 1 files changed, 9 insertions(+), 9 deletions(-)
>>>>>
>>>>> Nak.
>>>>>
>>>>> We already have a node in the dts for the PCI controller. =A0Lets upd=
ate the platform code to add the pci controller to the of_platform_bus_prob=
e list.
>>>>
>>>> I've had that idea. However it's really look strange to me to call
>>>> of_platform_bus_probe() on the bus node, for which we (IMO) explicitly
>>>> won't like for
>>>> child devices (PCI devices) to be added to of_platform bus.
>>>
>>> Right, and it's also not great for a driver for one aspect of PCI to
>>> claim to be the driver for the whole thing.
>>>
>>> But changing the device tree because of this Linux-internal concern is
>>> also not good.
>>>
>>> How about keeping the error stuff as a separate device from Linux's
>>> perspective, but have the main Freescale PCI code create it as a
>>> platform device instead of putting it in the device tree?
>>
>> I'd be good with that solution.
>
> Then we come back to the question that was raised before (during initial
> review of edac driver): as PCI code is probbed long before other parts
> of the kernel and mpc85xx_edac code can be compiled as module,
> it's not possible to directly call mpc85xx_edac code from fsl_pci.c

Not sure what you mean here.  If the driver is compiled as a module,
then it must be handled the same way all other drivers are handled.
The platform code registers an of_platform_device at boot time, and
the driver gets bound to it whenever it happens to show up.  None of
the children of that bus can be available until after the driver is
probed.

> Two initial suggestions were:
> 1) creating special platform device
> 2) creating special of_platform device from dts

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
