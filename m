Subject: Re: two aty128 frame buffers?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Jeffery von Ronne <jronne@ics.uci.edu>
Cc: Kaoru Fukui <k_fukui@highway.ne.jp>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020204222214.A28746@reepicheep.ics.uci.edu>
References: <20020204154626.C28199@reepicheep.ics.uci.edu>
	<200202050524.OAA13555@mail.highway.ne.jp>
	<20020204222214.A28746@reepicheep.ics.uci.edu>
Content-Type: multipart/mixed; boundary="=-d7MmHw464XY1evXSr5Dw"
Date: 05 Feb 2002 10:28:33 +0100
Message-Id: <1012901313.734.210.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-d7MmHw464XY1evXSr5Dw
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Die, 2002-02-05 at 07:22, Jeffery von Ronne wrote:
>=20
> On Tue, Feb 05, 2002 at 02:21:27PM +0900, Kaoru Fukui wrote:
> > Add drm in Section Module
>=20
> Thanks.  I should have been able to figure that out.
>=20
> Unfortunately, that was not my real problem.  I guess I forgot to mention
> that it crashes with a "signal 11" after the error message; now it crashe=
s
> with a signal 11 and no error message.

You need a hack like the attached one.


--=20
Earthling Michel D=E4nzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

--=-d7MmHw464XY1evXSr5Dw
Content-Disposition: attachment; filename=r128-vgaHW.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

Index: r128_driver.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/xc/programs/Xserver/hw/xfree86/drivers/ati/r128_driver.c,v
retrieving revision 1.57
diff -u -r1.57 r128_driver.c
--- r128_driver.c	2002/01/04 21:22:26	1.57
+++ r128_driver.c	2002/02/05 09:24:32
@@ -186,6 +186,7 @@
     "vgaHWGetIndex",
     "vgaHWLock",
     "vgaHWRestore",
+    "vgaHWGetIOBase",
     "vgaHWSave",
     "vgaHWUnlock",
     NULL
@@ -1793,6 +1794,8 @@
 	return FALSE;
     }
=20
+    vgaHWGetIOBase(VGAHWPTR(pScrn));
+
     info->PciInfo      =3D xf86GetPciInfoForEntity(info->pEnt->index);
     info->PciTag       =3D pciTag(info->PciInfo->bus,
 				info->PciInfo->device,
@@ -2755,7 +2758,10 @@
 	return;
     }
     vgaHWUnlock(hwp);
-    vgaHWSave(pScrn, &hwp->SavedReg, VGA_SR_ALL); /* save mode, fonts, cma=
p */
+    if (info->VBIOS)
+        vgaHWSave(pScrn, &hwp->SavedReg, VGA_SR_ALL); /* save mode, fonts,=
 cmap */
+    else
+        vgaHWSave(pScrn, &hwp->SavedReg, VGA_SR_MODE); /* save mode */
     vgaHWLock(hwp);
=20
     R128SaveMode(pScrn, save);

--=-d7MmHw464XY1evXSr5Dw--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
