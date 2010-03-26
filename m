Return-Path: <glikely@secretlab.ca>
Received: from mail-pz0-f201.google.com (mail-pz0-f201.google.com
	[209.85.222.201]) by ozlabs.org (Postfix) with ESMTP id 7A731B7CED
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Mar 2010 05:45:15 +1100 (EST)
Received: by pzk39 with SMTP id 39so164061pzk.15
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 11:45:13 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4BACFF7B.3010002@freescale.com>
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
	<4BAB7E67.6040707@freescale.com> <4BAB816F.5060405@firmworks.com>
	<fa686aa41003250916t3d0839e5m42d7f7f6540e821a@mail.gmail.com>
	<4BAB9120.1060600@freescale.com>
	<fa686aa41003251826m16ea94dfy422fae14fec81204@mail.gmail.com>
	<4BACD011.5050609@freescale.com>
	<fa686aa41003261120o15fea3cev8ca625f389bc8664@mail.gmail.com>
	<4BACFF7B.3010002@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 26 Mar 2010 12:44:52 -0600
Message-ID: <fa686aa41003261144i61429f23x1217a528fcfb3e66@mail.gmail.com>
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

On Fri, Mar 26, 2010 at 12:39 PM, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>>> Without the compatible property, the only way I'd know that the child n=
ode contains a firmware is to look at the actual name of the child node, wh=
ich (as Scott and I believe) is not better than a compatible property.
>> If it is always a child of a qe node, then I've got no objections.
>
> I have no problem with putting the firmware node as a child of the QE nod=
e and skipping the phandle property, but only as long as there's only one Q=
E node. =A0Would you agree that this is bad:
>
> qe1: qe@e0080000 {
> =A0 =A0 =A0 =A0compatible =3D "fsl,qe";
> =A0 =A0 =A0 =A0qefw: fsl,qe_firmware {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible=3D"fsl,qe-firmware";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl,firmware =3D /bininc/("firmware-blob.b=
in");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl,qe-firmware-eccr =3D <0x00000000 0x000=
01230>;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0...
> }
>
> qe2: qe@e0090000 {
> =A0 =A0 =A0 =A0compatible =3D "fsl,qe";
> =A0 =A0 =A0 =A0fsl,firmware-phandle =3D <&qefw>;
> =A0 =A0 =A0 =A0...
> }

Nah.  That looks totally fine.  Not having the firmware under a qe
node would look bad to me.

g.
