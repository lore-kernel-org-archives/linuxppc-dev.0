Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C9A53DE151
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 00:35:15 +1000 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA3030669AF@az33exm25.fsl.freescale.net>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com><1184162389.32199.65.camel@weaponx.rchland.ibm.com>
	<4EAC985A-2F04-465D-AB69-C67807310D7B@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA3030669AF@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <28A3F6B9-512B-4D86-8E0D-A7680CCE2354@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC][PATCH 6/8] Walnut DTS
Date: Mon, 16 Jul 2007 16:34:45 +0200
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +		#address-cells = <0>;
>>> +		#size-cells = <0>;
>>
>> No need for these.
>
> Isn't a good practice to put #address-cells in interrupt controller
> nodes?

It is not.

> If the device tree has an interrupt map defined the interrupt
> parent 'unit interrupt specifier' has to be interpreted according
> to the #address-cells of the interrupt parent.

And "#address-cells" is defaulted to 0 if it is absent,
for the purpose of interrupt mapping (but not for its
other purposes).  Typically, such interrupt controllers
don't have device tree children so it doesn't make sense
to give them an "#address-cells" anyway.

> It seems like
> typical practice in the current DTS files to explicitly define this
> in the interrupt controller.

That "typical practice" is inspired by the need to explicitly
put #address-cells and #size-cells into the device tree if you
want Linux to properly parse the device tree, even if the default
values would work perfectly (if Linux would work correctly,
that is).

> Of course this particular device tree doesn't have an interrupt
> map...
>
> #size-cells is not needed.

There are no child nodes, and no binding that says there can
be any; neither #address-cells not #size-cells should be there.


Segher
