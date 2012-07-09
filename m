Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6BAE82C007C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 03:36:39 +1000 (EST)
Subject: Re: [PATCH 1/3] powerpc/mpic: finish supporting timer group B on
 Freescale chips
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4FFB0A17.2030501@freescale.com>
Date: Mon, 9 Jul 2012 12:36:44 -0500
Message-Id: <66B03D29-D273-4E1A-8CAB-F7A9367587A5@kernel.crashing.org>
References: <1341823542-15654-1-git-send-email-Varun.Sethi@freescale.com>
 <58A5C37E-E2AA-4135-8419-9070FAFE84A2@kernel.crashing.org>
 <4FFB0A17.2030501@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: Varun Sethi <Varun.Sethi@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 9, 2012, at 11:43 AM, Scott Wood wrote:

> On 07/09/2012 09:12 AM, Kumar Gala wrote:
>>=20
>> On Jul 9, 2012, at 3:45 AM, Varun Sethi wrote:
>>=20
>>> Previously, these interrupts would be mapped, but the offset
>>> calculation was broken, and only the first group was initialized.
>>>=20
>>> Signed-off-by: Scott Wood <scottwood@freescale.com>
>>> ---
>>> arch/powerpc/include/asm/mpic.h |    5 +++
>>> arch/powerpc/sysdev/mpic.c      |   58 =
++++++++++++++++++++++++++++-----------
>>> 2 files changed, 47 insertions(+), 16 deletions(-)
>=20
> Varun, where's your signoff?
>=20
>>> +	if (mpic->flags & MPIC_FSL) {
>>> +		u32 brr1 =3D _mpic_read(mpic->reg_type, =
&mpic->thiscpuregs,
>>> +				      MPIC_FSL_BRR1);
>>> +		u32 version =3D brr1 & MPIC_FSL_BRR1_VER;
>>> +
>>> +		/*
>>> +		 * Timer group B is present at the latest in MPIC 3.1 =
(e.g.
>>> +		 * mpc8536).  It is not present in MPIC 2.0 (e.g. =
mpc8544).
>>> +		 * I don't know about the status of intermediate =
versions (or
>>> +		 * whether they even exist).
>>> +		 */
>>> +		if (version >=3D 0x0301)
>>> +			num_timers =3D 8;
>>> +	}
>>> +
>>=20
>> Why don't we do this just via the device tree?
>=20
> Then we'd have to change existing device trees (again), and in general
> there's no reason to put it in the device tree if it's discoverable =
via
> hardware version registers.

Except for the whole AMP issue ;).  One reason we did add the 2nd bank =
of timers was for AMP.

Also, we have this in the .dts already:

$ git grep pq3-mpic-timer-B.dtsi arch/powerpc/boot/dts/
arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi:/include/ =
"pq3-mpic-timer-B.dtsi"
arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi:/include/ =
"pq3-mpic-timer-B.dtsi"
arch/powerpc/boot/dts/fsl/p1010si-post.dtsi:/include/ =
"pq3-mpic-timer-B.dtsi"
arch/powerpc/boot/dts/fsl/p1020si-post.dtsi:/include/ =
"pq3-mpic-timer-B.dtsi"
arch/powerpc/boot/dts/fsl/p1021si-post.dtsi:/include/ =
"pq3-mpic-timer-B.dtsi"
arch/powerpc/boot/dts/fsl/p1022si-post.dtsi:/include/ =
"pq3-mpic-timer-B.dtsi"
arch/powerpc/boot/dts/fsl/p1023si-post.dtsi:/include/ =
"pq3-mpic-timer-B.dtsi"
arch/powerpc/boot/dts/fsl/p2020si-post.dtsi:/include/ =
"pq3-mpic-timer-B.dtsi"

- k=
