Return-Path: <TNghiem@oerlikon.ca>
Received: from mail.oerlikon.ca (unknown [205.233.198.228])
	by ozlabs.org (Postfix) with ESMTP id 039B3679E0
	for <linuxppc-dev@ozlabs.org>; Sat, 14 May 2005 06:36:46 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-15"
Date: Fri, 13 May 2005 16:36:43 -0400
Message-ID: <CCD52035B75A5D4E8A481EFB132C42EA2835F7@mail.oerlikon.ca>
From: "Nghiem, Tien" <TNghiem@oerlikon.ca>
To: "Colin Leroy" <colin@colino.net>
Cc: linuxppc-dev@ozlabs.org,
	=?ISO-8859-15?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
Subject: RE: eth0: PHY id 0x00221619 is not supported! HELP
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Colin,

I worked on a project 2 years ago, and the hardware supplier decided to
change the tranceiver twice during the course of the project.  So =
instead of modifying the mii_phy_table
each time the transeiver was changed, I bypassed the id check. =20

I did this because I doubt that in the future people are going to be =
interested in updating software, and delivering a new s/w version when a =
hardware fix is performed.

It's not clean, but it's easy and convenient.
This is just a suggestion of mine for a quick fix.

Tien

-----Original Message-----
From: Colin Leroy [mailto:colin@colino.net]
Sent: Friday, May 13, 2005 3:31 PM
To: Nghiem, Tien
Cc: Garcia J=E9r=E9mie; linuxppc-dev@ozlabs.org
Subject: Re: eth0: PHY id 0x00221619 is not supported! HELP


On 13 May 2005 at 14h05, Nghiem, Tien wrote:

Hi,=20

>          rc =3D reset_one_mii_phy(phy, mii_id);
>         //if (rc)
>         //        return -ENODEV;

Why disabling such guards?

>         //for (i=3D0; (def =3D mii_phy_table[i]) !=3D NULL; i++)
>         //        if ((id & def->phy_id_mask) =3D=3D def->phy_id)
>         //                break;

Just an idea, I guess it'd be far more clean to add the phy id to
mii_phy_table[] (and, optionally, send the patch so you won't have to
do it everytime).

You're just asking for breakage there.
--=20
Colin
