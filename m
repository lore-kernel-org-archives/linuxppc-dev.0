Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1DFC3B70BE
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 06:17:41 +1000 (EST)
Subject: Re: [PATCH] DTS: Adding device tree source for the STx GP3 SSA
	MPC8555-based board.
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AANLkTinoCJrYTdc56uK0ELQGMfG-em_5iiTtGGGWCgPT@mail.gmail.com>
Date: Wed, 21 Jul 2010 15:17:37 -0500
Message-Id: <0DF9688A-14A9-46F6-84E4-798839A95CDC@kernel.crashing.org>
References: <AANLkTinQkpBTtmVZYGM71wzREHGDzG6R3k7LbR66yX5c@mail.gmail.com>
	<7AD5FB58-D6EA-4AA6-870B-32E901F72589@kernel.crashing.org>
	<AANLkTinoCJrYTdc56uK0ELQGMfG-em_5iiTtGGGWCgPT@mail.gmail.com>
To: Bradley Hughes <bhughes@silicontkx.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 21, 2010, at 11:52 AM, Bradley Hughes wrote:

> On Wed, Jul 21, 2010 at 10:24 AM, Kumar Gala =
<galak@kernel.crashing.org> wrote:
>>>=20
>>> +     soc8555@e0000000 {
>>> +             #address-cells =3D <1>;
>>> +             #size-cells =3D <1>;
>>> +             device_type =3D "soc";
>>> +             compatible =3D "simple-bus";
>>> +             ranges =3D <0x0 0xe0000000 0x100000>;
>>> +             bus-frequency =3D <0>;
>>> +
>>> +             ecm-law@0 {
>>> +                     compatible =3D "fsl,ecm-law";
>>> +                     reg =3D <0x0 0x1000>;
>>> +                     fsl,num-laws =3D <8>;
>>> +             };
>>> +
>>> +             ecm@1000 {
>>> +                     compatible =3D "fsl,mpc8555-ecm", "fsl,ecm";
>>> +                     reg =3D <0x1000 0x1000>;
>>> +                     interrupts =3D <17 2>;
>>> +                     interrupt-parent =3D <&mpic>;
>>> +             };
>>> +
>>> +             memory-controller@2000 {
>>> +                     compatible =3D "fsl,8555-memory-controller";
>>=20
>> fsl,mpc8555?
>=20
> Ah, yes -- it seems the dts I used for an example also has this
> problem.  In drivers/edac/mpc85xx_edac.c, bindings still work for
> fsl,85.. style notation, but a comment claims that this notation would
> be deprecated at some point (2.6.29 or 2.6.30).  I have updated my
> local copy and it works fine, should I send a new patch?  I could also
> extend this change to the other DTS files affected (A quick search
> found 14 instances of fsl,85.. style notation.)  Please let me know
> what I should do.

Send two patches.  One to update your patch and another to fix the in =
tree dts that have the old name.

- k=
