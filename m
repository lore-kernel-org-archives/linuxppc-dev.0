Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound2-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 744C3DDEED
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 04:24:34 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2] Device tree bindings for Xilinx devices
Date: Tue, 16 Oct 2007 11:24:07 -0700
In-Reply-To: <20071015155223.7403.39615.stgit@trillian.cg.shawcable.net>
References: <20071015155223.7403.39615.stgit@trillian.cg.shawcable.net>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>, <linuxppc-dev@ozlabs.org>,
	"Wolfgang Reissnegger" <wre@xilinx.com>, "Leonid" <Leonid@a-k-a.net>,
	<microblaze-uclinux@itee.uq.edu.au>
Message-Id: <20071016182425.DCBF0BA804F@mail41-fra.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +   n) Xilinx EMAC and Xilinx TEMAC
> +
> +   Xilinx Ethernet devices.  Uses common properties from=20
> other Ethernet
> +   devices with the following constraints:
> +  =20
> +   Required properties:
> +    - compatible : Must include one of: "xilinx,plb-temac",
> +                   "xilinx,plb-emac", "xilinx-opb-emac"
> +    - dma-mode : Must be one of "none", "simple", "sg" (sg=20
> =3D=3D scatter gather)

I think it's going to be a significant headache to remap things like the
dma-mode from the xilinx configurations to something else, and then
interpret them correctly in the drivers.

Although it lacks a bit in style, perhaps, I'd greatly prefer having
something like:

	Ethernet_MAC {
		xilinx,C_DMA_PRESENT =3D <1>;
            ...
      }

(which happens to correspond to "none" above)
DMA mode is perhaps a bad example, since the Xilinx EDK encoding for
this is so unnecessarily obfuscated, but I'd like to avoid setting
precedent for defining a new set of parameterizations here.  In the long
term, I'm afraid this will just be an added source of confusion and more
code to maintain.

Steve
