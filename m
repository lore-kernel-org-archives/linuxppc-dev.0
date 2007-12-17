Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from mail50-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1C840DDE0E
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 05:25:10 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C840DA.208E366C"
Subject: RE: [PATCH 7/7] [POWERPC] Xilinx: Update booting-without-of.
Date: Mon, 17 Dec 2007 10:24:57 -0800
References: <1197589413-5965-1-git-send-email-stephen.neuendorffer@xilinx.com><1197589413-5965-2-git-send-email-stephen.neuendorffer@xilinx.com><1197589413-5965-3-git-send-email-stephen.neuendorffer@xilinx.com><1197589413-5965-4-git-send-email-stephen.neuendorffer@xilinx.com><1197589413-5965-5-git-send-email-stephen.neuendorffer@xilinx.com><1197589413-5965-6-git-send-email-stephen.neuendorffer@xilinx.com><20071213234151.D0B3DE80061@mail20-sin.bigfish.com>
	<fa686aa40712170719o29da3caew43d65225feea9ba@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20071217182459.7972AAE804F@mail50-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
	simekm2@fel.cvut.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C840DA.208E366C
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

When the driver no longer requires the port number, it's easy to drop.  =
Until then, I'll keep it in.
=20
Also, I'm not so sure that moving to completely generic names is really =
worth the effort...  All the 'semantically' interesting' information is =
already in the device tree somewhere else.  In the limit, the node name =
could just be a randomly generated string.  So now we have a matter of =
taste: what is the right amount of detail to put in so that someone who =
looks at the tree can easily understand what's going on, but not be =
overwhelmed?  The xilinx ip name seems to usually do that almost as well =
as a 'generic name'.  Anyway, you proved me wrong last time after a =
bunch of mulling it over, so maybe I'll just take your word for it and =
do it that way. :)
=20
In other news, my computer seems to have died this morning, so =
productivity may be low. :)
=20
Steve

________________________________

From: glikely@secretlab.ca on behalf of Grant Likely
Sent: Mon 12/17/2007 7:19 AM
To: Stephen Neuendorffer
Cc: simekm2@fel.cvut.cz; jwilliams@itee.uq.edu.au; =
linuxppc-dev@ozlabs.org; David Gibson
Subject: Re: [PATCH 7/7] [POWERPC] Xilinx: Update booting-without-of.

>                                 reg =3D <d1000fc0 20>;
>                         };
>                 };
> @@ -2513,6 +2521,9 @@ platforms are moved over to use the =
flattened-device-tree model.
>
>        Requred properties:
>         - current-speed : Baud rate of uartlite
> +               Optional properties:
> +       - port-number : unique ordinal index of the device. This
> +         property is required for a console on uartlite.

And has already been discussed, drop the port-number property.  I'll
rework the uartlite driver to use aliases instead.

Cheers,
g.

--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195



------_=_NextPart_001_01C840DA.208E366C
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD><TITLE>Re: [PATCH 7/7] [POWERPC] Xilinx: Update =
booting-without-of.</TITLE>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.3199" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText78077 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>When the =
driver no longer requires the port number, it's easy to drop.&nbsp; =
Until then, I'll keep it in.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Also, I'm not so sure that =
moving to completely generic names is really worth the effort...&nbsp; =
All the 'semantically' interesting' information is already in the device =
tree somewhere else.&nbsp; In the limit, the node name could =
just&nbsp;be a randomly generated string.&nbsp; So now we have a matter =
of taste: what is the right amount of detail to put in so that someone =
who looks at the tree can easily understand what's going on, but not be =
overwhelmed?&nbsp; The xilinx ip name seems to usually do that almost as =
well as a 'generic name'.&nbsp; Anyway, you proved me wrong last time =
after a bunch of mulling it over, so maybe I'll just take your word for =
it and do it that way. :)</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>In other news, my computer =
seems to have died this morning, so productivity may be low. =
:)</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Steve</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR></DIV>=0A=
<DIV dir=3Dltr>=0A=
<HR tabIndex=3D-1>=0A=
</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DTahoma size=3D2><B>From:</B> =
glikely@secretlab.ca on behalf of Grant Likely<BR><B>Sent:</B> Mon =
12/17/2007 7:19 AM<BR><B>To:</B> Stephen Neuendorffer<BR><B>Cc:</B> =
simekm2@fel.cvut.cz; jwilliams@itee.uq.edu.au; linuxppc-dev@ozlabs.org; =
David Gibson<BR><B>Subject:</B> Re: [PATCH 7/7] [POWERPC] Xilinx: Update =
booting-without-of.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DTahoma size=3D2></FONT><FONT =
size=3D2><BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D =
&lt;d1000fc0 =
20&gt;;<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =
};<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>&gt; @@ -2513,6 +2521,9 @@ =
platforms are moved over to use the flattened-device-tree =
model.<BR>&gt;<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Requred =
properties:<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - =
current-speed : Baud rate of uartlite<BR>&gt; =
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; Optional properties:<BR>&gt; =
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - port-number : unique ordinal =
index of the device. This<BR>&gt; =
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; property is required =
for a console on uartlite.<BR><BR>And has already been discussed, drop =
the port-number property.&nbsp; I'll<BR>rework the uartlite driver to =
use aliases instead.<BR><BR>Cheers,<BR>g.<BR><BR>--<BR>Grant Likely, =
B.Sc., P.Eng.<BR>Secret Lab Technologies =
Ltd.<BR>grant.likely@secretlab.ca<BR>(403) =
399-0195<BR><BR></DIV></FONT></BODY></HTML>
------_=_NextPart_001_01C840DA.208E366C--
