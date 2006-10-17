Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 4E79F67C08
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 23:53:28 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
Date: Wed, 18 Oct 2006 00:22:23 +0200
References: <4534BE9D.7030908@bplan-gmbh.de> <20061017132243.GA6773@lst.de>
In-Reply-To: <20061017132243.GA6773@lst.de>
MIME-Version: 1.0
Message-Id: <200610180022.24631.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: akpm@osdl.org, tilmann@bitterberg.de, Sven Luther <sl@bplan-gmbh.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 17 October 2006 15:22, Christoph Hellwig wrote:
> > =A0=A0=A0=A0=A0=A0rtas_node =3D of_find_node_by_name(NULL, "rtas");
> > =A0=A0=A0=A0=A0=A0if (rtas_node =3D=3D NULL)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENODEV;
>=20
> And given this check I wonder why we need the platform check at all. =A0It
> should be safe to just remove it.
>=20

One difference would be that it triggers on machines running SLOF (QS20,=20
some JS20/JS21) and maybe some older Macs, which is probably a good
thing.

I wonder if it should be a little stricter though:

> 	rtas_node =3D of_find_node_by_path("/rtas");
>	if (!rtas_node)
>		return -ENODEV;

In case there is a node called "rtas" somewhere else.

	Arnd <><
