Return-Path: <B08248@freescale.com>
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>, Meador Inge
	<meador_inge@mentor.com>
Subject: RE: [PATCH v2 2/3] powerpc: document the Open PIC device tree binding
Date: Thu, 3 Feb 2011 17:02:14 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15030BE4F7@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1296697900-14004-1-git-send-email-meador_inge@mentor.com>
	<1296697900-14004-3-git-send-email-meador_inge@mentor.com>
	<AANLkTinVak_ukf0wP8=zbGTq8ENV4d88hNuzW_tqvCFf@mail.gmail.com>
In-Reply-To: <AANLkTinVak_ukf0wP8=zbGTq8ENV4d88hNuzW_tqvCFf@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Hollis Blanchard <hollis_blanchard@mentor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > + =A0- no-reset
> > + =A0 =A0 =A0Usage: optional
> > + =A0 =A0 =A0Value type: <empty>
> > + =A0 =A0 =A0Definition: The presence of this property indicates that t=
he
> > + PIC
> > + =A0 =A0 =A0 =A0 =A0should not be reset during runtime initialization.=
 =A0The
> > + presence of
> > + =A0 =A0 =A0 =A0 =A0this property also mandates that any initializatio=
n related
> > + to
> > + =A0 =A0 =A0 =A0 =A0interrupt sources shall be limited to sources expl=
icitly
> > + referenced
> > + =A0 =A0 =A0 =A0 =A0in the device tree.
>=20
> Please follow the lead set by the other binding documentation which is mo=
re
> concise and tends to be of the form:
>=20
>     Required properties:
>         - reg : <description>
>         - interrupt-controller : <description>
>=20
>     Optional Properties:
>         - no-reset : blah
>=20
> I'm considering formalizing the binding format so that fully specified an=
d
> cross-referenced documentation can be generated from the bindings
> directory.

Regarding the format-- The definition should also to specify the value
type.  I don't see this being consistently done in existing bindings. =20
They are not completely unclear, but using consistent terms might help.

The ePAPR uses this convention:

    <empty>      # no value, a Boolean
     <u32>       # A 32-bit integer in big-endian format
     <u64>       # A 64-bit integer in big-endian format
   <string>      # null terminated
 <prop-encoded-array>    # format specific to the property
   <phandle>    # A <u32> value, referecnes another node
  <stringlist>    # A list of <string> values concatenated together.

The identifier prop-encoded-array came from precedence in other
of binding and ieee1275.   prop-encoded-arrays should be
be specifically defined in terms of # of cells and the=20
meaning of each cell.

If you use the above types identifiers, there is no ambiguity.

Also, there are properties that don't necessarily fall in 'required'
and 'optional', but may be required depending on the context.  Thus
the 'Usage' identifier which Meador derived from my mpic binding
posted.   Usage could be:
               Required
               Optional
               See Definition

Stuart
