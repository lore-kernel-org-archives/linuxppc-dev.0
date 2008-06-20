Return-Path: <mike_timmons@trimble.com>
Received: from snvl-smtp1.trimble.com (snvl-smtp1.trimble.com [155.63.64.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "snvl-smtp1.trimble.com", Issuer "Trimble CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8849CDDFCE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jun 2008 01:06:23 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8D2E7.3218D659"
Subject: RE: u-boot, MPC8313erdb
Date: Fri, 20 Jun 2008 08:06:06 -0700
Message-ID: <161B3BAD77161449A144FF054231C3D60235CFF0@uss-am-xch-01.am.trimblecorp.net>
In-Reply-To: <d8b992c20806200752k6745b917w5d45efee440778fa@mail.gmail.com>
References: <d8b992c20806200752k6745b917w5d45efee440778fa@mail.gmail.com>
From: "Mike Timmons" <mike_timmons@trimble.com>
To: "Nidhi Dua" <dua.nidhi2007@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8D2E7.3218D659
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The environment variable ethact does not, "stick" for me either,
although it's not an issue for me. Look in eth.c to learn when/how it is
initialized. Note the CONFIG_NET_MULTI constant (I have it defined, but
I'm not sure why).

=20

I bet you have that defined in your board header file. Take a look and
see if you can get your custom ethact to stick by defining or undefining
that or something.

=20

-Mike

=20

________________________________

From: linuxppc-embedded-bounces+mike_timmons=3Dtrimble.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+mike_timmons=3Dtrimble.com@ozlabs.org]
On Behalf Of Nidhi Dua
Sent: Friday, June 20, 2008 9:53 AM
To: linuxppc-embedded@ozlabs.org
Subject: u-boot, MPC8313erdb

=20

We are using the board MPC8313ERDB and we are facing problems regarding
u-boot environment variables(the environment variables displayed after
giving 'printenv' command at u-boot prompt).

We are following the steps stated as below:

1. =3D>printenv

output is:
....
....
bootargs=3Droot=3D/dev/mtdblock2 rootfstype=3Djffs2 rw =
console=3DttyS0,115200
bootcmd=3Dbootm fe100000 - fe700000
filesize=3D1a4a05
fileaddr=3D200000
ipaddr=3D192.168.1.101 <http://192.168.1.101/>=20
serverip=3D192.168.1.57 <http://192.168.1.57/>=20
stdin=3Dserial
stdout=3Dserial
stderr=3Dserial
ethact=3DTSEC0


Here ethact is TSEC0 by default.

2. =3D>setenv ethact TSEC1
3. =3D>saveenv
output:
Saving Environment to Flash...
Un-Protected 1 sectors
Erasing Flash...
. done
Erased 1 sectors
Writing to Flash... done
Protected 1 sectors

Here we have set the ethact variable to TSEC1 and saved it. Now it is
showing that this value of ethact is burnt in flash. But after the board
is reset,=20

4. =3D>printenv

ileaddr=3D200000
ipaddr=3D192.168.1.101 <http://192.168.1.101/>=20
serverip=3D192.168.1.57 <http://192.168.1.57/>=20
stdin=3Dserial
stdout=3Dserial
stderr=3Dserial
ethact=3DTSEC0

Here again the value of ethact is changed to TSEC0.

we have following questions:

question 1: We want to know the reason why it(ethact variable) changes
to TSEC0 everytime with a reset.

question2: After we have set ethact to TSEC1 and saved it(=3D>saveenv) =
and
tried to ping the Host from u-boot prompt it is working (displaying:
'host alive').
But when we are trying to ping Target board from the host it is showing:

PING 192.168.1.101 <http://192.168.1.101/>  (192.168.1.101
<http://192.168.1.101/> ) 56(84) bytes of data.
>From 192.168.1.57 <http://192.168.1.57/>  icmp_seq=3D2 Destination Host
Unreachable
>From 192.168.1.57 <http://192.168.1.57/>  icmp_seq=3D3 Destination Host
Unreachable
....
....
--- 192.168.1.101 <http://192.168.1.101/>  ping statistics ---
12 packets transmitted, 0 received, +9 errors, 100% packet loss, time
11002ms
, pipe 3

Why is it happening so?

question 3: After we have set 'ethact' to TSEC1, the kernel is loaded,
and we have logged -in, when we try to ping the Host from target it says
'100% packet lost'. also we are unable to ping target from the host. Why
is it happening so?

Awaiting a prompt reply
Regards=20
Nidhi Dua=20


------_=_NextPart_001_01C8D2E7.3218D659
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><o:SmartTagType
 namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags" =
name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:blue;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<div>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:navy'>The environment variable ethact =
does not, &#8220;stick&#8221;
for me either, although it&#8217;s not an issue for me. Look in eth.c to =
learn
when/how it is initialized. Note the CONFIG_NET_MULTI constant (I have =
it
defined, but I&#8217;m not sure why).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:navy'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:navy'>I bet you have that defined in =
your board
header file. Take a look and see if you can get your custom ethact to =
stick by defining
or undefining that or something.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:navy'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:navy'>-Mike<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:navy'>&nbsp;</span></font><o:p></o:p></p>=


</div>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'>
linuxppc-embedded-bounces+mike_timmons=3Dtrimble.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+mike_timmons=3Dtrimble.com@ozlabs.org] =
<b><span
style=3D'font-weight:bold'>On Behalf Of </span></b>Nidhi Dua<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Friday, June 20, =
2008 9:53
AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> =
linuxppc-embedded@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> u-boot, =
MPC8313erdb</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>We are using the board MPC8313ERDB and we are facing problems =
regarding
u-boot environment variables(the environment variables displayed after =
giving
'printenv' command at u-boot prompt).<br>
<br>
We are following the steps stated as below:<br>
<br>
1. =3D&gt;printenv<br>
<br>
output is:<br>
....<br>
....<br>
bootargs=3Droot=3D/dev/mtdblock2 rootfstype=3Djffs2 rw =
console=3DttyS0,115200<br>
bootcmd=3Dbootm fe100000 - fe700000<br>
filesize=3D1a4a05<br>
fileaddr=3D200000<br>
ipaddr=3D<a href=3D"http://192.168.1.101/" =
target=3D"_blank">192.168.1.101</a><br>
serverip=3D<a href=3D"http://192.168.1.57/" =
target=3D"_blank">192.168.1.57</a><br>
stdin=3Dserial<br>
stdout=3Dserial<br>
stderr=3Dserial<br>
<span style=3D'background:yellow'>ethact=3DTSEC0</span><br>
<br>
<br>
Here ethact is TSEC0 by default.<br>
<br>
2. =3D&gt;setenv ethact TSEC1<br>
3. =3D&gt;saveenv<br>
output:<br>
Saving Environment to Flash...<br>
Un-Protected 1 sectors<br>
Erasing Flash...<br>
. done<br>
Erased 1 sectors<br>
Writing to Flash... done<br>
Protected 1 sectors<br>
<br>
Here we have set the ethact variable to TSEC1 and saved it. Now it is =
showing
that this value of ethact is burnt in flash. But after the board is =
reset, <br>
<br>
4. =3D&gt;printenv<br>
<br>
ileaddr=3D200000<br>
ipaddr=3D<a href=3D"http://192.168.1.101/" =
target=3D"_blank">192.168.1.101</a><br>
serverip=3D<a href=3D"http://192.168.1.57/" =
target=3D"_blank">192.168.1.57</a><br>
stdin=3Dserial<br>
stdout=3Dserial<br>
stderr=3Dserial<br>
<span style=3D'background:yellow'>ethact=3DTSEC0</span><br>
<br>
Here again the value of ethact is changed to TSEC0.<br>
<br>
we have following questions:<br>
<br>
<b><i><u><span style=3D'font-weight:bold;font-style:italic'>question =
1</span></u></i></b>:
We want to know the reason why it(ethact variable) changes to TSEC0 =
everytime
with a reset.<br>
<br>
<b><i><u><span =
style=3D'font-weight:bold;font-style:italic'>question2</span></u></i></b>=
<i><u><span
style=3D'font-style:italic'>:</span></u></i> After we have set ethact to =
TSEC1
and saved it(=3D&gt;saveenv) and tried to ping the Host from u-boot =
prompt it is
working (displaying: 'host alive').<br>
But when we are trying to ping Target board from the host it is =
showing:<br>
<br>
<st1:place w:st=3D"on">PING</st1:place> <a =
href=3D"http://192.168.1.101/"
target=3D"_blank">192.168.1.101</a> (<a href=3D"http://192.168.1.101/"
target=3D"_blank">192.168.1.101</a>) 56(84) bytes of data.<br>
>From <a href=3D"http://192.168.1.57/" target=3D"_blank">192.168.1.57</a> =
icmp_seq=3D2
Destination Host Unreachable<br>
>From <a href=3D"http://192.168.1.57/" target=3D"_blank">192.168.1.57</a> =
icmp_seq=3D3
Destination Host Unreachable<br>
....<br>
....<br>
--- <a href=3D"http://192.168.1.101/" =
target=3D"_blank">192.168.1.101</a> ping
statistics ---<br>
12 packets transmitted, 0 received, +9 errors, 100% packet loss, time =
11002ms<br>
, pipe 3<br>
<br>
Why is it happening so?<br>
<br>
<b><i><u><span style=3D'font-weight:bold;font-style:italic'>question =
3</span></u></i></b>:
After we have set 'ethact' to TSEC1, the kernel is loaded, and we have =
logged
-in, when we try to ping the Host from target it says '100% packet =
lost'. also
we are unable to ping target from the host. Why is it happening so?<br>
<br>
Awaiting a prompt reply<br>
Regards <br>
<font color=3D"#888888"><span style=3D'color:#888888'>Nidhi =
Dua</span></font> <o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C8D2E7.3218D659--
