Subject: Using the "chips" XFree86 driver on a PowerBook 3400 (almost there.)
From: Michael Stephen Hanni <michael@deviant-behavior.com>
To: xpert@XFree86.Org
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: multipart/mixed; boundary="=-PoL2eown9JsN5meyMEAo"
Date: 08 Oct 2002 18:15:31 -0600
Message-Id: <1034122532.952.38.camel@zippy.deviant-behavior.com>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-PoL2eown9JsN5meyMEAo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Being of unsound mind and body I decided to see if the chips driver
could be made to work on my PowerBook 3400. This model of powerbook
includes the ct65550 chipset -- i.e. HiQV -- and has 1 meg of video ram.
>From reading the documentation in the source tree it would appear that
the "chips" driver fully supports this chipset and furthermore sports
full acceleration -- which would really be nice on this older powerbook!
However, in using the driver my powerbook lockedup nicely. After some
trying of various config switches I got the thing to come up by using
the "NoAccel" option. Alas, the colors were hopelessly screwed up, the
video ram wasn't detected correctly, and the hardware cursor was not an
X but rather <>. Suffice it to say, it was not usable.

After some small hacking I've gotten the colors right (though this may
just be a coincidence) and I've fixed the ram detection problem (I'm
more certain here as it was only a small fix.) Unfortunately I still can
not use the acceleration as it freezes the machine solid. Sometimes the
screen will come up, but it is frozen on arrival (FOA.)

Other issues:

1.) there seems to be a lot of visuals coming up. That is, by using the
fbdev I get 2 TrueColor visuals for this machine, with the chips driver
I get 2 TrueColor and 2 DirectColor.

2.) XVideo is hosed. When I try to use any program that makes use of
xvideo I get a BadAlloc error reporting there are insufficient
resources.

Patch:

This is against a freshly updated CVS copy of the xc module.

I'd really appreciate any help any of you could offer on making this
baby work. I'm not sure what exactly has to be fixed endian-wise to make
acceleration work (the *ToCPU* stuff maybe?) and what is going on with
xvideo.

If there is any info I can give please let me know and I'd be happy to
pass it on.

Cheers!

Michael

--=-PoL2eown9JsN5meyMEAo
Content-Disposition: inline; filename=ct_driver.c.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=ct_driver.c.patch; charset=ISO-8859-1

Index: ct_driver.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/xc/programs/Xserver/hw/xfree86/drivers/chips/ct_driver.c,v
retrieving revision 1.121
diff -u -r1.121 ct_driver.c
--- ct_driver.c	2002/09/16 18:05:52	1.121
+++ ct_driver.c	2002/10/08 23:39:30
@@ -1525,7 +1525,12 @@
     /* linear base */
     if (cPtr->Flags & ChipsLinearSupport) {
 	if (cPtr->pEnt->location.type =3D=3D BUS_PCI) {
+	    /* Tack on 0x800000 to access the big-endian aperture? */
+#if X_BYTE_ORDER =3D=3D X_BIG_ENDIAN
+	    cPtr->FbAddress =3D  (cPtr->PciInfo->memBase[0] & 0xff800000) + 0x800=
000;
+#else
 	    cPtr->FbAddress =3D  cPtr->PciInfo->memBase[0] & 0xff800000;
+#endif
 	    from =3D X_PROBED;
 	    if (xf86RegisterResources(cPtr->pEnt->index,NULL,ResNone))
 		cPtr->Flags &=3D ~ChipsLinearSupport;
@@ -1786,6 +1791,8 @@
 		pScrn->videoRam =3D 2048;
 		break;
 	    }
+	    /* We need to break out completely, i.e. do not fall through. */
+            break;
 	default:
 	    /* XRE0: Software reg     */
 	    /* bit 3-0: memory size   */
@@ -1817,7 +1824,6 @@
 	    }
 	}
     }
-
=20
     if ((cPtr->Flags & ChipsDualChannelSupport) &&
 		(xf86IsEntityShared(pScrn->entityList[0]))) {

--=-PoL2eown9JsN5meyMEAo--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
