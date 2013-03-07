Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8CD172C0351
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Mar 2013 06:53:51 +1100 (EST)
Subject: Re: [PATCH 5/8] powerpc/fsl-booke: Add initial silicon device tree for
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1362678470.23227.5@snotra>
Date: Thu, 7 Mar 2013 13:53:40 -0600
Message-Id: <8D2C28ED-52BB-4253-8FE8-7FA20834A4A1@kernel.crashing.org>
References: <1362678470.23227.5@snotra>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 7, 2013, at 11:47 AM, Scott Wood wrote:

> On 03/07/2013 11:09:50 AM, Kumar Gala wrote:
>> On Mar 5, 2013, at 6:15 PM, Scott Wood wrote:
>> > On 03/05/2013 05:15:57 PM, Kumar Gala wrote:
>> >> Enable a baseline T4240 SoC to boot.  There are several things =
missing
>> >> from the device trees for T4240:
>> >> * Thread support on e6500
>> >
>> > Why did threads get removed from the device tree?  It's supposed to =
describe hardware, not what Linux currently supports.
>> will fix, was concerned if we'd be able to boot if they exited
>=20
> I don't think it'd be a problem (and if it is, then fix Linux).

looks fine, so I'll add them in v2 patch.

>=20
>> >> +	device_type =3D "pci";
>> >> +	#size-cells =3D <2>;
>> >> +	#address-cells =3D <3>;
>> >> +	bus-range =3D <0x0 0xff>;
>> >> +	clock-frequency =3D <33333333>;
>> >
>> > This clock-frequency is not correct (I doubt it's needed at all).
>> I can zero the field, but its spec'd by pci binding
>=20
> If we aren't going to put a correct value in, is zero better than =
omitting it entirely?
>=20
> There are other properties in the PCI binding that we don't have, such =
as slot-names.  I don't see any language in the PCI binding that says =
one is required but the other isn't.
>=20
> And shouldn't we be using the PCI express binding (device_type =3D =
"pciex", or just get rid of it since this isn't real OF)?

I'll drop clock-frequency since we dont use it.

- k
