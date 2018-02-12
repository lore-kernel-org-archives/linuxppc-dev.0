Return-Path: <dcb314@hotmail.com>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-oln040092068047.outbound.protection.outlook.com [40.92.68.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zg0245hdjzF0kt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 19:58:16 +1100 (AEDT)
From: David Binderman <dcb314@hotmail.com>
To: "fbarrat@linux.vnet.ibm.com" <fbarrat@linux.vnet.ibm.com>,
 "andrew.donnellan@au1.ibm.com" <andrew.donnellan@au1.ibm.com>,
 "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: linux-4.16-rc1/drivers/misc/ocxl/file.c:320:broken error checking ?
Date: Mon, 12 Feb 2018 08:58:10 +0000
Message-ID: <HE1PR0802MB23312F7C9FFE65D802F9D0259CF70@HE1PR0802MB2331.eurprd08.prod.outlook.com>
Content-Type: multipart/alternative;
 boundary="_000_HE1PR0802MB23312F7C9FFE65D802F9D0259CF70HE1PR0802MB2331_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_HE1PR0802MB23312F7C9FFE65D802F9D0259CF70HE1PR0802MB2331_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello there,


linux-4.16-rc1/drivers/misc/ocxl/file.c:320]: (style) Checking if unsigned =
variable 'used' is less than zero.

Source code is


       used =3D append_xsl_error(ctx, &header, buf + sizeof(header));
        if (used < 0)
            return used;

Suggest put return value from function into signed variable, sanity check i=
t,

then assign it to an unsigned variable.


Also, use of the gcc compiler flag -Wtype-limits will show up this kind of =
problem in future.


Regards


David Binderman


--_000_HE1PR0802MB23312F7C9FFE65D802F9D0259CF70HE1PR0802MB2331_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Hello there,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div>linux-4.16-rc1/drivers/misc/ocxl/file.c:320]: (style) Checking if unsi=
gned variable 'used' is less than zero.<br>
<br>
</div>
Source code is
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; used =3D append_xsl_error(ctx, &a=
mp;header, buf &#43; sizeof(header));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (used &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return u=
sed;<br>
<br>
</div>
Suggest put return value from function into signed variable, sanity check i=
t,
<p></p>
<p style=3D"margin-top:0;margin-bottom:0">then assign it to an unsigned var=
iable.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Also, use of the gcc compiler fla=
g -Wtype-limits will show up this kind of problem in future.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Regards</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">David Binderman</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
</div>
</body>
</html>

--_000_HE1PR0802MB23312F7C9FFE65D802F9D0259CF70HE1PR0802MB2331_--
