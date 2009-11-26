Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091126051641.GB27334@yookeroo>
References: <20091126051641.GB27334@yookeroo>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 25 Nov 2009 22:46:29 -0700
Message-ID: <fa686aa40911252146u73a9f9d3y9fb287bfc051503d@mail.gmail.com>
Subject: Re: Make the kernel accept ePAPR style phandle information
To: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
	devicetree-discuss@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 25, 2009 at 10:16 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> Grant, this is based on your test-devicetree branch, if it could be
> merged via there would be great.
>
> Currently when processing flattened device trees, the kernel expects
> the phandle in a property called "linux,phandle". =A0The ePAPR spec -
> not being Linux specific - instead requires phandles to be encoded in
> a property named simply "phandle". =A0This patch makes the kernel accept
> either form when unflattening the device tree.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Looks okay to me.

g.

>
> Index: working-2.6/drivers/of/fdt.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- working-2.6.orig/drivers/of/fdt.c =A0 2009-11-26 09:58:06.052792325 +=
1100
> +++ working-2.6/drivers/of/fdt.c =A0 =A0 =A0 =A02009-11-26 10:00:08.30957=
0256 +1100
> @@ -314,10 +314,19 @@ unsigned long __init unflatten_dt_node(u
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pp =3D unflatten_dt_alloc(&mem, sizeof(str=
uct property),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0__alignof__(struct property));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (allnextpp) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (strcmp(pname, "linux,ph=
andle") =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We accept flattened tree=
 phandles either in
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* ePAPR-style "phandle" =
properties, or the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* legacy "linux,phandle"=
 properties. =A0If both
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* appear and have differ=
ent values, things
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* will get weird. =A0Don=
't do that. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((strcmp(pname, "phandle=
") =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || (strcmp(pname, "=
linux,phandle") =3D=3D 0)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (np->ph=
andle =3D=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0np->phandle =3D *((u32 *)*p);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* And we process the "ibm,=
phandle" property
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* used in pSeries dynami=
c device tree
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* stuff */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (strcmp(pname, "ibm,pha=
ndle") =3D=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0np->phandl=
e =3D *((u32 *)*p);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pp->name =3D pname;
>
>
> --
> David Gibson =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| I'll have my music =
baroque, and my code
> david AT gibson.dropbear.id.au =A0| minimalist, thank you. =A0NOT _the_ _=
other_
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| _way_ _a=
round_!
> http://www.ozlabs.org/~dgibson
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
