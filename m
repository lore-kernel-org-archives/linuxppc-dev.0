Return-Path: <SRane@alphion.com>
Received: from alphion.com (unknown [66.147.184.82])
	by ozlabs.org (Postfix) with ESMTP id 6A2D867BD4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Sep 2006 21:10:34 +1000 (EST)
Subject: RE: I2C: Getting Compiation Error for application program
Date: Thu, 21 Sep 2006 07:10:32 -0400
Message-ID: <8584FDC94AFF7640B17B8A89B23B19B34F657E@sbsserver.AlphionCorp.local>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6DD6E.8E21CC48"
References: <8584FDC94AFF7640B17B8A89B23B19B34F6571@sbsserver.AlphionCorp.local>
	<200609211113.15457.matthias.fuchs@esd-electronics.com>
From: "Sachin Rane" <SRane@alphion.com>
To: "Matthias Fuchs" <matthias.fuchs@esd-electronics.com>
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

------_=_NextPart_001_01C6DD6E.8E21CC48
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Matthias,
=20
Thanks for the reply.
=20
I got the reason from i2c mailing list on getting compilation errors.=20
=20
A text from the I2C mailing list :
8<-----------------------------------------------------------------------=
----------------
"All the above it caused by you including <linux/i2c.h>. As explained
before, this is a kernel-only header file, which you must _not_ include
in user-space code. You are not the only one to blame though, as in
fact this header file should not be in /usr/include at all, this is a
mistake which should be fixed "soon". "
-------------------------------------------------------------------------=
-------------->8
=20
Some of the error lines are appended for your reference.
=20
Now I will do the changes in the code as per above above suggestion.
=20
Tnaks and Regards,
Sachin Rane

=20
> -bash-2.05b# gcc eeprom-client.c
> In file included from /usr/include/asm/div64.h:1,
>                  from /usr/include/linux/jiffies.h:9,
>                  from /usr/include/linux/sched.h:12,
>                  from /usr/include/linux/module.h:10,
>                  from /usr/include/linux/i2c.h:31,
>                  from eeprom-client.c:1:
> /usr/include/asm-generic/div64.h:54:3: #error do_div() does not yet =
support the C64
> In file included from /usr/include/linux/sched.h:12,
>                  from /usr/include/linux/module.h:10,
>                  from /usr/include/linux/i2c.h:31,
>                  from eeprom-client.c:1:
> /usr/include/linux/jiffies.h:84: error: parse error before =
"jiffies_64"
> /usr/include/linux/jiffies.h:88: error: parse error before =
"get_jiffies_64"
> In file included from /usr/include/linux/sched.h:12,
>                  from /usr/include/linux/module.h:10,
>                  from /usr/include/linux/i2c.h:31,
>                  from eeprom-
=20
=20

________________________________

From: Matthias Fuchs [mailto:matthias.fuchs@esd-electronics.com]
Sent: Thu 9/21/2006 5:13 AM
To: linuxppc-embedded@ozlabs.org
Cc: Sachin Rane
Subject: Re: I2C: Getting Compiation Error for application program



On Wednesday 20 September 2006 14:51, Sachin Rane wrote:
> Hi,
>=20
> I am trying to compile simple program (appended), but getting lots of
compilation error.
It's always helpful to see the compiler output. Could you post it?

> I am using Timesys Linux 2.6.13 for ppc440 evaluation board.
>=20
> Command used for compilation:
> $> gcc eeprom-client.c -o eeprom-client.o
Are you crosscompiling? Doesn't look like that...
>=20
> Could you help me to find out the reason behind getting the errors?
>=20
> Regards,
> Sachin Rane
>=20
>=20
>
8< ------------------------eeprom-client.c =
-------------------------------------------------------------------------=
------------
>=20
> #include <linux/i2c.h>
> #include <linux/i2c-dev.h>
>
> int main()
> {
>      int file;
>      int adapter_nr =3D 0; /* probably dynamically determined */
>      char filename[20];
>      int addr =3D 0xA1; /* The I2C address */
You propably have to use 0x50 here.
>
>     sprintf(filename,"/dev/i2c-%d",adapter_nr);
>     if ((file =3D open(filename,O_RDWR)) < 0)
>    {
>        exit(1);
>     }
>  =20
>     if (ioctl(file,I2C_SLAVE,addr) < 0)
>    {
>       exit(1);
>    }
>    else
>   {
>       printf("\n Able to bind the adapter");
>    }
>    return 0;
> }

Matthias



------_=_NextPart_001_01C6DD6E.8E21CC48
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD><TITLE>Re: I2C: Getting Compiation Error for =
application program</TITLE>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.2180" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText21320 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>=0A=
<DIV id=3DidOWAReplyText16906 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT color=3D#000000 size=3D2>Hello =
Matthias,</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2>Thanks for the reply.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2>I got the reason from i2c mailing list on =
getting compilation errors. </FONT></DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2>A text from the I2C mailing =
list&nbsp;:</FONT></DIV>=0A=
<DIV =
dir=3Dltr>8&lt;----------------------------------------------------------=
-----------------------------</DIV>=0A=
<DIV dir=3Dltr><FONT color=3D#000000 size=3D2>"All the above it caused =
by you including &lt;linux/i2c.h&gt;. As explained<BR>before, this is a =
kernel-only header file, which you must _not_ include<BR>in user-space =
code. You are not the only one to blame though, as in<BR>fact this =
header file should not be in /usr/include at all, this is a<BR>mistake =
which should be fixed "soon". "</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr>=0A=
<DIV =
dir=3Dltr>---------------------------------------------------------------=
------------------------&gt;8</DIV></DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr>Some of the error lines are appended for your =
reference.</DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr>Now I will do the changes in the code as per above above =
suggestion.</DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr>Tnaks and Regards,</DIV>=0A=
<DIV dir=3Dltr>Sachin Rane</DIV>=0A=
<DIV dir=3Dltr><BR>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2>&gt; -bash-2.05b# gcc =
eeprom-client.c<BR>&gt; In file included from =
/usr/include/asm/div64.h:1,<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =
/usr/include/linux/jiffies.h:9,<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
from =
/usr/include/linux/sched.h:12,<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =
/usr/include/linux/module.h:10,<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
from =
/usr/include/linux/i2c.h:31,<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =
eeprom-client.c:1:<BR>&gt; /usr/include/asm-generic/div64.h:54:3: #error =
do_div() does not yet support the C64<BR>&gt; In file included from =
/usr/include/linux/sched.h:12,<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =
/usr/include/linux/module.h:10,<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
from =
/usr/include/linux/i2c.h:31,<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =
eeprom-client.c:1:<BR>&gt; /usr/include/linux/jiffies.h:84: error: parse =
error before "jiffies_64"<BR>&gt; /usr/include/linux/jiffies.h:88: =
error: parse error before "get_jiffies_64"<BR>&gt; In file included from =
/usr/include/linux/sched.h:12,<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =
/usr/include/linux/module.h:10,<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
from =
/usr/include/linux/i2c.h:31,<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =
eeprom-</FONT></DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV></FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> Matthias Fuchs =
[mailto:matthias.fuchs@esd-electronics.com]<BR><B>Sent:</B> Thu =
9/21/2006 5:13 AM<BR><B>To:</B> =
linuxppc-embedded@ozlabs.org<BR><B>Cc:</B> Sachin =
Rane<BR><B>Subject:</B> Re: I2C: Getting Compiation Error for =
application program<BR></FONT><BR></DIV>=0A=
<DIV>=0A=
<P><FONT size=3D2>On Wednesday 20 September 2006 14:51, Sachin Rane =
wrote:<BR>&gt; Hi,<BR>&gt;&nbsp;<BR>&gt; I am trying to compile simple =
program (appended), but getting lots of<BR>compilation error.<BR>It's =
always helpful to see the compiler output. Could you post =
it?<BR><BR>&gt; I am using Timesys Linux 2.6.13 for ppc440 evaluation =
board.<BR>&gt;&nbsp;<BR>&gt; Command used for compilation:<BR>&gt; $&gt; =
gcc eeprom-client.c -o eeprom-client.o<BR>Are you crosscompiling? =
Doesn't look like that...<BR>&gt;&nbsp;<BR>&gt; Could you help me to =
find out the reason behind getting the errors?<BR>&gt;&nbsp;<BR>&gt; =
Regards,<BR>&gt; Sachin =
Rane<BR>&gt;&nbsp;<BR>&gt;&nbsp;<BR>&gt;<BR>8&lt; =
------------------------eeprom-client.c =
-------------------------------------------------------------------------=
------------<BR>&gt;&nbsp;<BR>&gt; #include &lt;linux/i2c.h&gt;<BR>&gt; =
#include &lt;linux/i2c-dev.h&gt;<BR>&gt;<BR>&gt; int main()<BR>&gt; =
{<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
file;<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int adapter_nr =3D 0; /* =
probably dynamically determined */<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
char filename[20];<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int addr =3D =
0xA1; /* The I2C address */<BR>You propably have to use 0x50 =
here.<BR>&gt;<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp; =
sprintf(filename,"/dev/i2c-%d",adapter_nr);<BR>&gt;&nbsp;&nbsp;&nbsp;&nbs=
p; if ((file =3D open(filename,O_RDWR)) &lt; =
0)<BR>&gt;&nbsp;&nbsp;&nbsp; =
{<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
exit(1);<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>&gt;&nbsp;&nbsp;&nbsp;<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp; if =
(ioctl(file,I2C_SLAVE,addr) &lt; 0)<BR>&gt;&nbsp;&nbsp;&nbsp; =
{<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
exit(1);<BR>&gt;&nbsp;&nbsp;&nbsp; }<BR>&gt;&nbsp;&nbsp;&nbsp; =
else<BR>&gt;&nbsp;&nbsp; {<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
printf("\n Able to bind the adapter");<BR>&gt;&nbsp;&nbsp;&nbsp; =
}<BR>&gt;&nbsp;&nbsp;&nbsp; return 0;<BR>&gt; =
}<BR><BR>Matthias<BR></FONT></P></DIV></BODY></HTML>
------_=_NextPart_001_01C6DD6E.8E21CC48--
