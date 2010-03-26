Return-Path: <glikely@secretlab.ca>
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com
	[209.85.212.42]) by ozlabs.org (Postfix) with ESMTP id 952A3B7CBB
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 12:26:28 +1100 (EST)
Received: by vws18 with SMTP id 18so1448134vws.15
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 18:26:26 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4BAB9120.1060600@freescale.com>
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<ed82fe3e1003240505h59d29c83x6948f8b3b70c4570@mail.gmail.com>
	<90D93687-940F-47FB-8CEA-F3C065EA611D@kernel.crashing.org>
	<fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>
	<4BAA4C8A.70104@freescale.com>
	<65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
	<4BAB7E67.6040707@freescale.com> <4BAB816F.5060405@firmworks.com>
	<fa686aa41003250916t3d0839e5m42d7f7f6540e821a@mail.gmail.com>
	<4BAB9120.1060600@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 25 Mar 2010 19:26:06 -0600
Message-ID: <fa686aa41003251826m16ea94dfy422fae14fec81204@mail.gmail.com>
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

On Thu, Mar 25, 2010 at 10:36 AM, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>> On Thu, Mar 25, 2010 at 9:29 AM, Mitch Bradley <wmb@firmworks.com> wrote=
:
>>> It seems to me that there are plausible use cases for both direct-inclu=
sion
>>> and indirection. =A0I don't see any real problems with either, so I wou=
ld vote
>>> for specifying both alternatives.
>>
>> Ugh. =A0Then this one driver would need to implement both binding for
>> little, if any, actual benefit.
>
> Although I agree that I don't like supporting both bindings, we could enc=
apsulate the locating of the firmware node in a function. =A0The function w=
ill first look for a child firmware node, and if it doesn't find it, look f=
or a fsl,firmware property. =A0It will return a pointer to the firmware nod=
e regardless.

Wait... After eating dinner and mulling on it a bit, I think I've
changed my mind.  I have no objections left if you do it the way Mitch
suggests with one minor change:

diff --git a/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt
b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt
index 6e37be1..d9d6431 100644
--- a/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt
 - fsl,qe-num-riscs: define how many RISC engines the QE has.
 - fsl,qe-num-snums: define how many serial number(SNUM) the QE can use for=
 the
  threads.
+- fsl,firmware:
+    Usage: Optional.
+    Value type: <prop-encoded-array>, encoded array of bytes
+    Definition: Contains the QUICC engine firmware blob.
[plus any other properties needed for firmware metadata]
+- fsl,firmware-phandle:
+    Usage: Required if fsl,firmware property is not present.
+    Value type: <phandle>
+    Definition: Points to another fsl,qe node that has the
fsl,firmware property.

 Recommended properties
 - brg-frequency : the internal clock source frequency for baud-rate

[...]

+Example:
+       qe1: qe@e0080000 {
+               compatible =3D "fsl,qe";
+               fsl,firmware =3D /bininc/("firmware-blob.bin");  /* Or
squirted in by firmware */
+               ...
+       }
+
+       qe@e0090000 {
+               compatible =3D "fsl,qe";
+               fsl,firmware-phandle =3D <&qe1>;
+               ...
+       }

Putting the blob into just one of the qe nodes keeps everything nicely
contained with the device it actually applies to.  No debates about
the best place to put device firmware blobs or new compatible values,
and it is applicable to any device where firmware needs to be passed
via the tree.

g.
