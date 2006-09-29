Return-Path: <Phil.Mathews@innocon.com>
Received: from mail.innocon.com (mail.innocon.com [12.109.49.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E41C467B8F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Sep 2006 08:46:15 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6E419.0EEB94B3"
Subject: RE: Need help on PPC8343E bringup 
Date: Fri, 29 Sep 2006 18:43:18 -0400
Message-ID: <3E8081396F6B524BA2854E7FA3F16438042EB1FD@mail.innocon.com>
References: <198592450609291408w2dbf7e5ckf5e4cf7023d2000@mail.gmail.com><200609292133.k8TLXUUv072654@penguin.ncube.com><200609292139.k8TLdV10081103@penguin.ncube.com><198592450609291503s7be0200ehf72925c2cae07787@mail.gmail.com>
	<200609292214.k8TMEZfw006857@penguin.ncube.com>
From: "Mathews, Phil" <Phil.Mathews@innocon.com>
To: "Michael Galassi" <mgalassi@c-cor.com>, "Reeve Yang" <yang.reeve@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6E419.0EEB94B3
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


From: linuxppc-embedded-bounces+phil.mathews=3Dinnocon.com@ozlabs.org on =
behalf of Michael Galassi
Sent: Fri 9/29/2006 6:14 PM
To: Reeve Yang
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Need help on PPC8343E bringup=20
=20
>Thanks Machael.
>
>On my flash data sheet, there are some command about security:
>
>Lock Block | Block Address | 0060h | Block Address | 0001h
>Unlock Block|Block Address| 0060h | Block Address | 00d0h
>
>So I guess it needs two write cycle to perfomr the command, and the =
unlock
>command should be 006000d0. I tried that but still get the same error. =
Bad!
>:(
>
>Another questions is that is there any way to change CPU register =
directy?
>For 8343E all registers are mapped to 1m starting from 0xff400000. I =
want to
>change on 0Xff400c08, but visionclick reject me to write on that =
address.
>
>- Reeve

Actually no, I made the assumption that you have two 16 bit wide flash
parts, one providing bits 0:15, the other 16:31.  Most PPC projects end
up doing this.  The write 0x00600060 ends up sending a 0x60 to the flash
on the low bits and another 0x60 to the flash part on the high bits.
The second write of 0x00d000d0 likewise sends a single 0xd0 to each
flash part.

If your tool gave you a command called mw which had a usage somewhat
like:
    mw <size> <address> <data>
where size is b/byte, w/word, l/longword you might you might try:
    mw l 0x00600060 0xff000000
    mw l 0x00d000d0 0xff000000
Does that make sense to you?

PS: some people here have nothing better to do than whine about
    top-posting, safe yourself the grief and respond bellow the
    post.
PS: Technicaly this is not a Linux topic, I'm responding here
    because this does turn out to be of general interest.

-michael

Actually the comands should be:
    mw l 0xff000000 0x00600060
    mw l 0xff000000 0x00d000d0


BTW - you don't have to bellow the post, you can just type them quietly =
:-)
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


------_=_NextPart_001_01C6E419.0EEB94B3
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>RE: Need help on PPC8343E bringup </TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>From: =
linuxppc-embedded-bounces+phil.mathews=3Dinnocon.com@ozlabs.org on =
behalf of Michael Galassi<BR>
Sent: Fri 9/29/2006 6:14 PM<BR>
To: Reeve Yang<BR>
Cc: linuxppc-embedded@ozlabs.org<BR>
Subject: Re: Need help on PPC8343E bringup<BR>
<BR>
&gt;Thanks Machael.<BR>
&gt;<BR>
&gt;On my flash data sheet, there are some command about security:<BR>
&gt;<BR>
&gt;Lock Block | Block Address | 0060h | Block Address | 0001h<BR>
&gt;Unlock Block|Block Address| 0060h | Block Address | 00d0h<BR>
&gt;<BR>
&gt;So I guess it needs two write cycle to perfomr the command, and the =
unlock<BR>
&gt;command should be 006000d0. I tried that but still get the same =
error. Bad!<BR>
&gt;:(<BR>
&gt;<BR>
&gt;Another questions is that is there any way to change CPU register =
directy?<BR>
&gt;For 8343E all registers are mapped to 1m starting from 0xff400000. I =
want to<BR>
&gt;change on 0Xff400c08, but visionclick reject me to write on that =
address.<BR>
&gt;<BR>
&gt;- Reeve<BR>
<BR>
Actually no, I made the assumption that you have two 16 bit wide =
flash<BR>
parts, one providing bits 0:15, the other 16:31.&nbsp; Most PPC projects =
end<BR>
up doing this.&nbsp; The write 0x00600060 ends up sending a 0x60 to the =
flash<BR>
on the low bits and another 0x60 to the flash part on the high bits.<BR>
The second write of 0x00d000d0 likewise sends a single 0xd0 to each<BR>
flash part.<BR>
<BR>
If your tool gave you a command called mw which had a usage somewhat<BR>
like:<BR>
&nbsp;&nbsp;&nbsp; mw &lt;size&gt; &lt;address&gt; &lt;data&gt;<BR>
where size is b/byte, w/word, l/longword you might you might try:<BR>
&nbsp;&nbsp;&nbsp; mw l 0x00600060 0xff000000<BR>
&nbsp;&nbsp;&nbsp; mw l 0x00d000d0 0xff000000<BR>
Does that make sense to you?<BR>
<BR>
PS: some people here have nothing better to do than whine about<BR>
&nbsp;&nbsp;&nbsp; top-posting, safe yourself the grief and respond =
bellow the<BR>
&nbsp;&nbsp;&nbsp; post.<BR>
PS: Technicaly this is not a Linux topic, I'm responding here<BR>
&nbsp;&nbsp;&nbsp; because this does turn out to be of general =
interest.<BR>
<BR>
-michael<BR>
<BR>
Actually the comands should be:<BR>
&nbsp;&nbsp;&nbsp; mw l 0xff000000 0x00600060<BR>
&nbsp;&nbsp;&nbsp; mw l 0xff000000 0x00d000d0<BR>
<BR>
<BR>
BTW - you don't have to bellow the post, you can just type them quietly =
:-)<BR>
_______________________________________________<BR>
Linuxppc-embedded mailing list<BR>
Linuxppc-embedded@ozlabs.org<BR>
<A =
HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://oz=
labs.org/mailman/listinfo/linuxppc-embedded</A><BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C6E419.0EEB94B3--
