Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8C1DFB7CEF
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Mar 2010 02:17:51 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o2QFHcrA025520
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 08:17:48 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o2QFP1We026246
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 10:25:01 -0500 (CDT)
Message-ID: <4BACD011.5050609@freescale.com>
Date: Fri, 26 Mar 2010 10:17:37 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<ed82fe3e1003240505h59d29c83x6948f8b3b70c4570@mail.gmail.com>
	<90D93687-940F-47FB-8CEA-F3C065EA611D@kernel.crashing.org>
	<fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>
	<4BAA4C8A.70104@freescale.com>
	<65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
	<4BAB7E67.6040707@freescale.com> <4BAB816F.5060405@firmworks.com>
	<fa686aa41003250916t3d0839e5m42d7f7f6540e821a@mail.gmail.com>
	<4BAB9120.1060600@freescale.com>
	<fa686aa41003251826m16ea94dfy422fae14fec81204@mail.gmail.com>
In-Reply-To: <fa686aa41003251826m16ea94dfy422fae14fec81204@mail.gmail.com>
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

Grant Likely wrote:

> +- fsl,firmware:
> +    Usage: Optional.
> +    Value type: <prop-encoded-array>, encoded array of bytes
> +    Definition: Contains the QUICC engine firmware blob.
> [plus any other properties needed for firmware metadata]

This would place the firmware metadata properties inside the QE node itself, which would break the QE binding.

> +Example:
> +       qe1: qe@e0080000 {
> +               compatible = "fsl,qe";
> +               fsl,firmware = /bininc/("firmware-blob.bin");  /* Or
> squirted in by firmware */
> +               ...
> +       }
> +
> +       qe@e0090000 {
> +               compatible = "fsl,qe";
> +               fsl,firmware-phandle = <&qe1>;
> +               ...
> +       }
> 
> Putting the blob into just one of the qe nodes keeps everything nicely
> contained with the device it actually applies to.  No debates about
> the best place to put device firmware blobs or new compatible values,
> and it is applicable to any device where firmware needs to be passed
> via the tree.

Except when you actually need to add metadata properties:

       qe1: qe@e0080000 {
               compatible = "fsl,qe";
               fsl,firmware = /bininc/("firmware-blob.bin"); 
               fsl,qe-firmware-eccr = <0x00000000 0x00001230>;
               ...
       }

(The ECCR is stored in the QE firmware blob, but let's pretend it isn't and I need to specify it)

Here, the fsl,qe-firmware-eccr property is associated with the QE itself.  This is why I want a compatible property for the firmware node, no matter where it is.  Then you can do this:

       qe1: qe@e0080000 {
               compatible = "fsl,qe";
               fsl,qe_firmware {
                       compatible="fsl,qe-firmware";
                       fsl,firmware = /bininc/("firmware-blob.bin"); 
                       fsl,qe-firmware-eccr = <0x00000000 0x00001230>;
               }
               ...
       }

Without the compatible property, the only way I'd know that the child node contains a firmware is to look at the actual name of the child node, which (as Scott and I believe) is not better than a compatible property.

-- 
Timur Tabi
Linux kernel developer at Freescale
