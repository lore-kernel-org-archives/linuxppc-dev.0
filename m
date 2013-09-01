Return-Path: <ben@decadent.org.uk>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A27032C0097
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Sep 2013 02:24:30 +1000 (EST)
Message-ID: <1378052656.25743.33.camel@deadeye.wl.decadent.org.uk>
Subject: [PATCH] hvc_vio: Do not override preferred console set by kernel
 parameter
From: Ben Hutchings <ben@decadent.org.uk>
To: Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Date: Sun, 01 Sep 2013 17:24:16 +0100
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-1UdErQ1kOAKUZPlm0VLt"
Mime-Version: 1.0
Cc: Bastian Blank <waldi@debian.org>, linuxppc-dev@lists.ozlabs.org,
 Debian kernel maintainers <debian-kernel@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-1UdErQ1kOAKUZPlm0VLt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The original version of this was done by Bastian Blank, who wrote:

> The problem is the following:
> - Architecture specific code sets preferred console to something bogus.
> - Command line handling tries to set preferred console but is overruled
>   by the old setting.
>=20
> The udbg0 console is a boot console and independant.

References: http://bugs.debian.org/492703
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
We've been carrying this in Debian for 5 years now, so it's about time
it got reviewed.

I'm not convinced strstr() is the right way to check the command line
(what if there's also a 'netconsole=3D'?).

Ben.

--- a/drivers/tty/hvc/hvc_vio.c
+++ b/drivers/tty/hvc/hvc_vio.c
@@ -48,6 +48,7 @@
 #include <asm/prom.h>
 #include <asm/hvsi.h>
 #include <asm/udbg.h>
+#include <asm/machdep.h>
=20
 #include "hvc_console.h"
=20
@@ -440,7 +441,9 @@
 	if (hvterm_priv0.proto =3D=3D HV_PROTOCOL_HVSI)
 		goto out;
 #endif
-	add_preferred_console("hvc", 0, NULL);
+	/* Check whether the user has requested a different console. */
+	if (!strstr(cmd_line, "console=3D"))
+		add_preferred_console("hvc", 0, NULL);
 	hvc_instantiate(0, 0, ops);
 out:
 	of_node_put(stdout_node);

--=20
Ben Hutchings
The most exhausting thing in life is being insincere. - Anne Morrow Lindber=
g

--=-1UdErQ1kOAKUZPlm0VLt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIVAwUAUiNqMOe/yOyVhhEJAQpESxAA1OBj4Bx8PJUJ83zLX4laZb0n+fuvxviO
dsBZBX6K+s2YDUeaarzi/9u+f8MdpwOImWm+Rg/jz+U0FFqjUPupuTyjyxaqsCTd
jb0XlrLAKJGrLGGNLw023MIV34ZUXrvkpqo8Es8LLdXBOEyfc+76X6DYsWMeZZjn
R0wWwvUXICqj+0KsEu66qk/yBOksETPcm2wP7SB/jMhcNN6UbaqL0Z3G3wof48f5
aKFpdaGPTy1xj7QcPCd+S22fTRE6JHAj9L9/LXiSzso85pfZ+NM1DX5PbJhbcBz5
2+vC2Oxt66xUNq+/y73L9wIfEinO8OAfq8EGQSSaRya9zJvLr3QH8Ne7IpToAEVD
NsEaqUv3npONQkf4eFMlE1oIUZ7wo46ESrLdH6PZYijYFSIw+rPQEydwoLzzTPyy
wpqD4xhmVJDdpYUzLf+7SRMpfmwfZa+CvIan+ER3fme9N+2X1P0qsJqg8SijPouY
gqEvFVXcSRHa8gw+ZTUpodlqvBNeEP5FCz1yCefcGOCn//4zmjZy5sRe/vi9YMiQ
9eIYi+AmyTXggeMgDe9Cep6sIq8Jgu3SoOj9g3We1DQru08js++uR1YOpYMzhuK7
y0h1Ql+WrgPfx++7p+mK3BROYpo4UauXzmOhe4jojFLCwn13FXS69c9MDxOzBfcZ
/wdZMhYfSKw=
=ftzS
-----END PGP SIGNATURE-----

--=-1UdErQ1kOAKUZPlm0VLt--
