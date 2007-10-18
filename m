Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound3-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 680BADDEE2
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 03:50:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v3] Device tree bindings for Xilinx devices
Date: Thu, 18 Oct 2007 10:49:11 -0700
In-Reply-To: <20071018172259.14948.74736.stgit@trillian.cg.shawcable.net>
References: <20071018172259.14948.74736.stgit@trillian.cg.shawcable.net>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>, <linuxppc-dev@ozlabs.org>,
	"Wolfgang Reissnegger" <wre@xilinx.com>, "Leonid" <Leonid@a-k-a.net>,
	<microblaze-uclinux@itee.uq.edu.au>,
	"Josh Boyer" <jwboyer@linux.vnet.ibm.com>, "Arnd Bergmann" <arnd@arndb.de>
Message-Id: <20071018174956.05D7A1AA008D@mail197-blu.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
> -----Original Message-----
> From: Grant Likely [mailto:grant.likely@secretlab.ca]=20
> Sent: Thursday, October 18, 2007 10:23 AM
> To: linuxppc-dev@ozlabs.org; Stephen Neuendorffer; Wolfgang=20
> Reissnegger; Leonid; microblaze-uclinux@itee.uq.edu.au; Josh=20
> Boyer; Arnd Bergmann
> Subject: [PATCH v3] Device tree bindings for Xilinx devices
>=20
> From: Grant Likely <grant.likely@secretlab.ca>
>=20
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

This is good enough for the moment, and it reflects the best we can do
right now...  But:

> +	(parameter#):	C_* parameters from system.mhs.  The C_=20
> prefix is
> +			dropped from the parameter name, the=20
> name is converted
> +			to lowercase and all underscore '_'=20
> characters are
> +			converted to dashes '-'.

Unfortunately, xparameters don't follow this exactly, particularly for
the 'multiple logical devices' case...  Maybe it's worth adding
something like: "For simple devices, the parameter name can be formed
by:"

In any event, this should essentially document what the mechanism for
generating the device trees actually does...  Have you updated
gen_mhs_devtree.py to reflect all this?

> +   Typically, the compatible list will include the exact IP=20
> core version
> +   followed by an older IP core version which implements the same
> +   interface or any other device with the same interface.

This seems to be awkward, since it means that the tree *and* the driver
will likely have long lists of compatible types.  In the driver, this is
hard to maintain, and in the device tree we don't have an easy way of
knowing exactly what is compatible and what isn't anyway...  It seems
better to me to have the
compatible list include the exact type (e.g. xilinx,opb-uartlite-1.00.b)
and
a generic compatibility class (e.g. xilinx,uartlite), and for the
drivers
to essentially define the gross compatibility classes.  Then the driver
only has an of_match with:

 .compatible =3D "xilinx,uartlite"

Steve
