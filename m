Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 12E09DDEBA
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 07:22:30 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] generic check_legacy_ioport
Date: Tue, 17 Apr 2007 23:22:22 +0200
References: <20070417210745.GA3567@aepfle.de>
In-Reply-To: <20070417210745.GA3567@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704172322.23362.arnd@arndb.de>
Cc: Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 17 April 2007, Olaf Hering wrote:
>=20
> =A0int check_legacy_ioport(unsigned long base_port)
> =A0{
> -=A0=A0=A0=A0=A0=A0=A0if (ppc_md.check_legacy_ioport =3D=3D NULL)
> +=A0=A0=A0=A0=A0=A0=A0struct device_node *np;
> +=A0=A0=A0=A0=A0=A0=A0if (ppc_md.check_legacy_ioport =3D=3D NULL) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0np =3D of_find_node_by_type=
(NULL, "isa");
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (np =3D=3D NULL)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ret=
urn -ENODEV;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0of_node_put(np);
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0;
> +=A0=A0=A0=A0=A0=A0=A0}
> =A0=A0=A0=A0=A0=A0=A0=A0return ppc_md.check_legacy_ioport(base_port);
> =A0}

I could be wrong, but I think I've seen fake 'isa' bus nodes in the device =
tree
for machines that don't actually have isa. I probably saw this on very early
cell blades (not the ones currently shipping), but perhaps others have
made the same mistake.

How about simply defining a new common function like

int generic_deny_legacy_ioport(unsigned long base_port)
{
	return -EINVAL;
}

so that not every platform has to define their own but can either
set ppc_md.check_legacy_ioport to NULL, to generic_deny_legacy_ioport
or their own function if they do something fancy?

	Arnd <><
