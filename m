Return-Path: <glikely@secretlab.ca>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) by ozlabs.org (Postfix) with ESMTP id 5480EB7BEE
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Mar 2010 05:20:55 +1100 (EST)
Received: by pvg6 with SMTP id 6so5072105pvg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 11:20:54 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4BACD011.5050609@freescale.com>
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>
	<4BAA4C8A.70104@freescale.com>
	<65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
	<4BAB7E67.6040707@freescale.com> <4BAB816F.5060405@firmworks.com>
	<fa686aa41003250916t3d0839e5m42d7f7f6540e821a@mail.gmail.com>
	<4BAB9120.1060600@freescale.com>
	<fa686aa41003251826m16ea94dfy422fae14fec81204@mail.gmail.com>
	<4BACD011.5050609@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 26 Mar 2010 12:20:34 -0600
Message-ID: <fa686aa41003261120o15fea3cev8ca625f389bc8664@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mitch Bradley <wmb@firmworks.com>, Scott Wood <scottwood@freescale.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 26, 2010 at 9:17 AM, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>
>> +- fsl,firmware:
>> + =A0 =A0Usage: Optional.
>> + =A0 =A0Value type: <prop-encoded-array>, encoded array of bytes
>> + =A0 =A0Definition: Contains the QUICC engine firmware blob.
>> [plus any other properties needed for firmware metadata]
>
> This would place the firmware metadata properties inside the QE node itse=
lf, which would break the QE binding.

Not really true.  Adding extra properties seldom breaks a binding.
It's a wash when compared with compared with adding a node.  But
that's not really an important debate.

> Here, the fsl,qe-firmware-eccr property is associated with the QE itself.=
 =A0This is why I want a compatible property for the firmware node, no matt=
er where it is. =A0Then you can do this:
>
> =A0 =A0 =A0 qe1: qe@e0080000 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,qe";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,qe_firmware {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible=3D"fsl,qe-firmware=
";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,firmware =3D /bininc/("fi=
rmware-blob.bin");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,qe-firmware-eccr =3D <0x0=
0000000 0x00001230>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
> =A0 =A0 =A0 }
>
> Without the compatible property, the only way I'd know that the child nod=
e contains a firmware is to look at the actual name of the child node, whic=
h (as Scott and I believe) is not better than a compatible property.

If it is always a child of a qe node, then I've got no objections.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
