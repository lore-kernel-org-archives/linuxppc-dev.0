Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 6A001DDDA2
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Mar 2009 05:04:13 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1021509ywb.39
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Feb 2009 10:04:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <49A97878.6060308@mlbassoc.com>
References: <49A97878.6060308@mlbassoc.com>
Date: Sat, 28 Feb 2009 11:04:11 -0700
Message-ID: <fa686aa40902281004r5fcb67f4md328d79dd1d5d82c@mail.gmail.com>
Subject: Re: OF device mappings
From: Grant Likely <grant.likely@secretlab.ca>
To: Gary Thomas <gary@mlbassoc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Feb 28, 2009 at 10:46 AM, Gary Thomas <gary@mlbassoc.com> wrote:
> Still looking for some help... =A0I need to be able to locate
> the kernel platform_device which corresponds to an instance
> from my OF tree. =A0Basically, I have a [somewhat] unrelated
> driver which needs to know these things, so the drivers in
> question should not have to be affected.
>
> In particular, I'm working with the net/dsa drivers (Distributed
> Switch Architecture) which need access to the network driver as
> well as the MII/MDIO bus driver. =A0It doesn't make sense to tie
> those drivers back to DSA, but rather let the DSA driver find
> its way to them.
>
> I've defined this in by DTS tree:
> =A0 =A0 =A0 =A0lan1 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cell-index =3D <0x01>;

Side note, why do you have cell-index here?  I suspect that you're
using it incorrectly.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,m88e609x";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0net_dev =3D "fsl-gianfar.0";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mii_bus =3D "fsl-gianfar_mdio.14";

These two lines don't make much sense.  They are encoding Linux
internal details with could very well change in the future.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0net_devX =3D <&eth0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mii_busX =3D <&mii_bus>;

This is the right thing to do.  This give you the phandle to the relevant n=
ode.

Once you have a handle to the node, you can iterate through the
of_platform bus devices and look for a node which has a matching node
pointer stored in archdata.  That will give you a struct device which
is contained by a struct of_device (note well: this will give you an
of_device, not a platform_device.)

I'm working on a set of patches which should make this much easier.
I'll try to remember to CC you when I post them to the list.

> =A0 =A0 =A0 =A0};
> ... two ways to find the same node.
>
> Using 'net_dev' (which I admit is pretty hokey), I can look
> up the corresponding platform device, which does work for
> the DSA layer. =A0What I want is to be able to get to this
> from the 'net_devX' pointer, but I don't seem to be able
> to get out of the OF tree and into the actual platform
> device tree to find the appropriate instance.
>
> Any pointers?
>
> Thanks
>
> --
> ------------------------------------------------------------
> Gary Thomas =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0Consulting for the
> MLB Associates =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0Embedded world
> ------------------------------------------------------------
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
