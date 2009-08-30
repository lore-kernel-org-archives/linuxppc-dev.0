Return-Path: <bzolnier@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 58BC0B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Aug 2009 05:01:29 +1000 (EST)
Received: from mail-fx0-f222.google.com (mail-fx0-f222.google.com
	[209.85.220.222]) by ozlabs.org (Postfix) with ESMTP id 891EADDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2009 05:01:27 +1000 (EST)
Received: by fxm22 with SMTP id 22so1425019fxm.9
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Aug 2009 12:01:24 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powermac: thermal control turns system off in normal
	temperature conditions
Date: Sun, 30 Aug 2009 20:54:20 +0200
MIME-Version: 1.0
Message-Id: <200908302054.20498.bzolnier@gmail.com>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Lyonel Vincent <lyonel@ezix.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=46rom: Lyonel Vincent <lyonel@ezix.org>
Subject: [PATCH] powermac: thermal control turns system off in normal tempe=
rature conditions

On certain PowerMacs, a module (therm_windtunnel) controls various
thermal settings (it can report CPU/case temperature, change speed
of internal fans, etc.)

By default, the hardware thermal control has a temperature limit to
protect the computer from damages (the default limit seems to be 80=B0C)
but therm_windtunnel.c reduces it to an anormaly low value (65=B0C),
which means that he computer will shut down randomly when hit by direct
sun light or during summer (summer in France can be quite hot), actually
possibly losing data instead of protecting it.

The overheat limit in therm_windtunnel.c:253-254 should be set to 75=B0C
and 70=B0C instead of 65=B0C and 60=B0C respectively.

=46rom: Lyonel Vincent <lyonel@ezix.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
=2D--
Resurrected from Fedora's bugzilla (aka The Big Black Hole):
https://bugzilla.redhat.com/show_bug.cgi?id=3D171937

The patch itself seems perfectly valid to me
(especially given comments in therm_windtunnel.c).

 drivers/macintosh/therm_windtunnel.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/macintosh/therm_windtunnel.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -239,8 +239,8 @@ setup_hardware( void )
 	 * to be on the safe side (OSX doesn't)...
 	 */
 	if( x.overheat_temp =3D=3D (80 << 8) ) {
=2D		x.overheat_temp =3D 65 << 8;
=2D		x.overheat_hyst =3D 60 << 8;
+		x.overheat_temp =3D 75 << 8;
+		x.overheat_hyst =3D 70 << 8;
 		write_reg( x.thermostat, 2, x.overheat_hyst, 2 );
 		write_reg( x.thermostat, 3, x.overheat_temp, 2 );
=20
