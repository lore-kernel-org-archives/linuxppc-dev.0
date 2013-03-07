Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1C9452C038D
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Mar 2013 04:10:02 +1100 (EST)
Subject: Re: [PATCH 5/8] powerpc/fsl-booke: Add initial silicon device tree for
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1362528955.25308.12@snotra>
Date: Thu, 7 Mar 2013 11:09:50 -0600
Message-Id: <FFA4082B-0C61-43F6-BB84-2C5A25476814@kernel.crashing.org>
References: <1362528955.25308.12@snotra>
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


On Mar 5, 2013, at 6:15 PM, Scott Wood wrote:

> On 03/05/2013 05:15:57 PM, Kumar Gala wrote:
>> Enable a baseline T4240 SoC to boot.  There are several things =
missing
>> from the device trees for T4240:
>> * Thread support on e6500
>=20
> Why did threads get removed from the device tree?  It's supposed to =
describe hardware, not what Linux currently supports.

will fix, was concerned if we'd be able to boot if they exited

>=20
>> * Proper PAMU topology information
>> * DPAA related nodes (Qman, Bman, Fman, Rman, DCE)
>> * Prefetch Manager
>> * Thermal monitor unit
>> * Interlaken
>=20
> The dts should be marked preliminary somehow -- we really should get =
out of the habit of letting device nodes trickle in as drivers get =
added.

agreed but forward progress always gets in the way

>=20
>> +/* controller at 0x240000 */
>> +&pci0 {
>> +	compatible =3D "fsl,t4240-pcie", "fsl,qoriq-pcie-v3.0";
>=20
> We have a version register -- do we really need to keep sticking the =
version number in the compatible?  Note that we've had device trees that =
specified the version incorrectly in the past.
>=20
>> +	device_type =3D "pci";
>> +	#size-cells =3D <2>;
>> +	#address-cells =3D <3>;
>> +	bus-range =3D <0x0 0xff>;
>> +	clock-frequency =3D <33333333>;
>=20
> This clock-frequency is not correct (I doubt it's needed at all).

I can zero the field, but its spec'd by pci binding

>=20
>> +		PowerPC,e6500@1 {
>> +			device_type =3D "cpu";
>> +			reg =3D <2>;
>> +			next-level-cache =3D <&L2_1>;
>> +		};
>> +		PowerPC,e6500@2 {
>> +			device_type =3D "cpu";
>> +			reg =3D <4>;
>> +			next-level-cache =3D <&L2_1>;
>> +		};
>> +		PowerPC,e6500@3 {
>> +			device_type =3D "cpu";
>> +			reg =3D <6>;
>> +			next-level-cache =3D <&L2_1>;
>> +		};
>> +
>> +		PowerPC,e6500@4 {
>> +			device_type =3D "cpu";
>> +			reg =3D <8>;
>> +			next-level-cache =3D <&L2_2>;
>> +		};
>=20
> Inconsistent whitespace.

will kill the whitespace.

> As usual, the pre/post split is unnecessary.  Everything in it can go =
in post.
>=20
> -Scott
