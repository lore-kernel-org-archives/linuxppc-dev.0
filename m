Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55067DE557
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 02:34:40 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m2BFYWkj000042
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 08:34:33 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m2BFYWPM016536
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 10:34:32 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Add some documentation for the dts formta
Date: Tue, 11 Mar 2008 08:34:25 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA303B510C5@az33exm25.fsl.freescale.net>
In-Reply-To: <20080310234714.GB11559@localhost.localdomain>
References: <20080310234714.GB11559@localhost.localdomain>
From: "Yoder Stuart" <stuart.yoder@freescale.com>
To: "David Gibson" <david@gibson.dropbear.id.au>,
	"Loeliger Jon" <jdl@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>=20

> -----Original Message-----
> From: David Gibson [mailto:david@gibson.dropbear.id.au]=20
> Sent: Monday, March 10, 2008 6:47 PM
> To: Loeliger Jon
> Cc: Yoder Stuart; linuxppc-dev@ozlabs.org
> Subject: dtc: Add some documentation for the dts formta
>=20
> This patch adds a dts-format.txt in the Documentation directory, with
> an introduction to the dtc source format.  Note that this
> documentation is also going into the upcoming ePAPR specification.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> ---
>  Documentation/dts-format.txt |  110=20
> +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 110 insertions(+)
>=20
> I wrote this documentation based on an earlier draft from Stuart
> Yoder.  Stuart, can you please reply with a Signed-off-by line?
>=20
> Index: dtc/Documentation/dts-format.txt
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ dtc/Documentation/dts-format.txt	2008-03-11=20
> 10:42:17.000000000 +1100
> @@ -0,0 +1,110 @@
> +Device Tree Source Format (version 1)
> =
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Device Tree Source (DTS) format is a textual representation of a
> +device tree in a form that can be processed by dtc into a binary
> +device tree in the form expected by the kernel.  The=20
> description below
> +is not a formal syntax definition of DTS, but describes the basic
> +constructs used to represent device trees.
> +
> +Node and property definitions
> +-----------------------------
> +
> +Device tree nodes are defined with a node name and unit address with
> +braces marking the start and end of the node definition.  They may be
> +preceded by a label.
> +
> +	[label:] node-name[@unit-address] {
> +		[properties definitions]
> +		[child nodes]
> +	}
> +
> +Nodes may contain property definitions and/or child node
> +definitions. If both are present, properties must come before child
> +nodes.
> +
> +Property definitions are name value pairs in the form:
> +	[label:] property-name =3D value;
> +except for properties with empty (zero length) value which have the
> +form:
> +	[label:] property-name;
> +
> +Property values may be defined as an array of 32-bit integer=20
> cells, as
> +NUL-terminated strings, as bytestrings or a combination of these.
> +
> +* Arrays of cells are represented by angle brackets surrounding a
> +  space separated list of C-style integers
> +
> +	e.g. interrupts =3D <17 0xc>;
> +
> +* A 64-bit value is represented with two 32-bit cells.
> +
> +	e.g. clock-frequency =3D <0x00000001 0x00000000>;
> +
> +* A NUL-terminated string value is represented using double quotes
> +  (the property value is considered to include the terminating NUL
> +  character).
> +
> +	e.g. compatible =3D "simple-bus";
> +
> +* A bytestring is enclosed in square brackets [] with each byte
> +  represented by two hexadecimal digits.  Spaces between=20
> each byte are
> +  optional.
> +
> +	e.g. local-mac-address =3D [00 00 12 34 56 78]; or equivalently
> +	     local-mac-address =3D [000012345678];
> +
> +* Values may have several comma-separated components, which are
> +  concatenated together.
> +	e.g. compatible =3D "ns16550", "ns8250";
> +	     example =3D <0xf00f0000 19>, "a strange property format";
> +
> +* In a cell array a reference to another node will be=20
> expanded to that
> +  node's phandle.  References may by '&' followed by a node's label:
> +	e.g. interrupt-parent =3D < &mpic >;
> +  or they may be '&' followed by a node's full path in braces:
> +	e.g. interrupt-parent =3D < &{/soc/interrupt-controller@40000} >;
> +
> +* Outside a cell array, a reference to another node will be expanded
> +  to that node's full path.
> +	e.g. ethernet0 =3D &EMAC0;
> +
> +* Labels may also appear before or after any component of a property
> +  value, or between cells of a cell array, or between bytes of a
> +  bytestring.
> +	e.g. reg =3D reglabel: <0 sizelabel: 0x1000000>;
> +	e.g. prop =3D [ab cd ef byte4: 00 ff fe];
> +	e.g. str =3D start: "string value" end: ;
> +
> +
> +File layout
> +-----------
> +
> +Version 1 DTS files have the overall layout:
> +	/dts-v1/;
> +
> +	[memory reservations]
> +
> +	/ {
> +		[property definitions]
> +		[child nodes]
> +	};
> +
> +* The "/dts-v1/;" must be present to identify the file as a version 1
> +  DTS (dts files without this tag will be treated by dtc as being in
> +  the obsolete "version 0", which uses a different format=20
> for integers
> +  amongst other small but incompatible changes).
> +
> +* Memory reservations define an entry for the device tree blob's
> +  memory reservation table.  They have the form:
> +	e.g. /memreserve/ <address> <length>;
> +  Where <address> and <length> are 64-bit C-style integers.
> +
> +* The / { ... }; section defines the root node of the device tree.
> +
> +* C style (/* ... */) and C++ style (// ...) comments are supported.
> +
> +
> +
> +	-- David Gibson <david@gibson.dropbear.id.au>
> +	-- Yoder Stuart <stuart.yoder@freescale.com>
>=20
>=20
> --=20
> David Gibson			| I'll have my music baroque,=20
> and my code
> david AT gibson.dropbear.id.au	| minimalist, thank=20
> you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
>=20
