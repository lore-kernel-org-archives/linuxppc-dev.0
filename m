Return-Path: <joseph.robertson@sanmina-sci.com>
Received: from mail53.messagelabs.com (mail53.messagelabs.com [216.82.249.211])
	by ozlabs.org (Postfix) with SMTP id DAE8DDDE38
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Aug 2007 05:48:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7DF75.3CCE6132"
Subject: FW: Cypress C67X00 driver question
Date: Wed, 15 Aug 2007 14:47:44 -0500
Message-ID: <939D37AEB47F1F49B88FAB6599B6023501A1726F@hsv1dafpew02.das.gov.sanm.corp>
References: <939D37AEB47F1F49B88FAB6599B6023501A17257@hsv1dafpew02.das.gov.sanm.corp>
	<87lkclw5fq.fsf@sleipner.barco.com>
	<939D37AEB47F1F49B88FAB6599B6023501A1726C@hsv1dafpew02.das.gov.sanm.corp>
From: "Robertson, Joseph M." <joseph.robertson@sanmina-sci.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C7DF75.3CCE6132
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Sorry,=20replied=20to=20wrong=20address...

-----Original=20Message-----
From:=20Robertson,=20Joseph=20M.
Sent:=20Wed=208/15/2007=202:18=20PM
To:=20Peter=20Korsgaard
Subject:=20RE:=20Cypress=20C67X00=20driver=20question
=20
Hi,

Ok=20call=20me=20dense,=20but=20I=20still=20get=20a=20problem.=20=20
I=20put=20some=20messages=20in=20the=20driver.=20=20I=20see=20the=20c67x00=
_drv=20init,=20and=20also=20udc_init.
But=20no=20hdc=20init=20and=20no=20probing.=20=20And=20my=20ports=20are=20=
not=20powered.
I=20built=20the=20system=20to=20use=20c67x00_hdc,=20and=20I=20want=202=20h=
osts=20enabled.

RE:=20The=20CYPRESS=20C67300=20and=20ROM.=20=20=20By=20the=20docs,=20this=20=
thing=20comes=20up=20dead.=20=20It=20comes=20up=20HPI,=20co-processor=20mo=
de=20and=20waits.
All=20the=20defaut=20values=20are=200=20=3D=20disabled,=20off,=20etc.

Actually=20I=20have=20to=20get=20my=20hardware=20guys=20to=20double-check=20=
that,=20and=20also=20my=20port=20wiring,=20but=20thats=20another=20story.

Where=20does=20'platform_device=20c67x00'=20go?=20=20That=20is,=20should=20=
it=20be=20sent/used=20by=20some=20init=20function?=20=20All=20I=20could=20=
find=20was=20c67x00_sie?

Thanks=20again.

Joe=20Robertson
Joseph.Robertson@sanmina-sci.com



-----Original=20Message-----
From:=20linuxppc-embedded-bounces+joseph.robertson=3Dsanmina-sci.com@ozlab=
s.org=20on=20behalf=20of=20Peter=20Korsgaard
Sent:=20Thu=208/9/2007=202:08=20AM
To:=20linuxppc-embedded@ozlabs.org
Subject:=20Re:=20Cypress=20C67X00=20driver=20question
=20
>>>>>=20"RJM"=20=3D=3D=20Robertson,=20Joseph=20M=20<joseph.robertson@sanmi=
na-sci.com>=20writes:

Hi,

RJM>=20Hi=20all,=20First=20off=20big=20thanks=20to=20the=20guys=20working=20=
on=20the=20Cypress
RJM>=20USB=20C67X00=20driver!=20=20Without=20them=20I=20would=20not=20even=
=20be=20this=20far.

You're=20welcome.

RJM>=20But=20my=20question=20for=20them=20is:=20How=20are=20you=20guys=20i=
nitializing=20the
RJM>=20Cypress=20chip?=20=20It=20looks=20like=20the=20driver=20is=20expect=
ing=20the=20cypress
RJM>=20to=20be=20programmed=20and=20ready.

No,=20you=20don't=20need=20to=20program=20anything.=20The=20driver=20only=20=
uses=20he
Cypress=20BIOS=20programmed=20in=20ROM=20in=20the=20chip.

You=20just=20need=20to=20register=20a=20struct=20platform_device=20in=20yo=
ur=20board=20code
with=20the=20base=20address,=20IRQ=20and=20port=20configuration=20-=20Some=
thing=20like:

#include=20<linux/usb/c67x00.h

..

static=20struct=20resource=20c67x00_resources[]=20=3D=20{
=20=20=20=20=20=20=20=20[0]=20=3D=20{
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20.start=20=20=3D=200x840000=
00,
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20.end=20=20=20=20=3D=200x84=
00000f,
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20.flags=20=20=3D=20IORESOUR=
CE_MEM,
=20=20=20=20=20=20=20=20},
=20=20=20=20=20=20=20=20[1]=20=3D=20{
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20.start=20=20=3D=203,
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20.end=20=20=20=20=3D=203,
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20.flags=20=20=3D=20IORESOUR=
CE_IRQ,
=20=20=20=20=20=20=20=20},
};

static=20struct=20c67x00_platform_data=20c67x00_data=20=3D=20{
=20=20=20=20=20=20=20=20.sie_config=20=20=20=20=20=20=20=20=20=20=20=20=20=
=3D=20C67X00_SIE1_HOST=20|=20C67X00_SIE2_HOST,
=20=20=20=20=20=20=20=20.hpi_regstep=20=20=20=20=20=20=20=20=20=20=20=20=3D=
=200x02,
};

static=20struct=20platform_device=20c67x00=20=3D=20{
=20=20=20=20=20=20=20=20.name=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=3D=20"c67x00",
=20=20=20=20=20=20=20=20.id=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=3D=200,
=20=20=20=20=20=20=20=20.num_resources=20=20=20=20=20=20=20=20=20=20=3D=20=
ARRAY_SIZE(c67x00_resources),
=20=20=20=20=20=20=20=20.resource=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=3D=20c67x00_resources,
=20=20=20=20=20=20=20=20.dev.platform_data=20=20=20=20=20=20=3D=20&c67x00_=
data,
};

--=20
Bye,=20Peter=20Korsgaard
_______________________________________________
Linuxppc-embedded=20mailing=20list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded



CONFIDENTIALITY
This=20e-mail=20message=20and=20any=20attachments=20thereto,=20is=20intend=
ed=20only=20for=20use=20by=20the=20addressee(s)=20named=20herein=20and=20m=
ay=20contain=20legally=20privileged=20and/or=20confidential=20information.=
=20If=20you=20are=20not=20the=20intended=20recipient=20of=20this=20e-mail=20=
message,=20you=20are=20hereby=20notified=20that=20any=20dissemination,=20d=
istribution=20or=20copying=20of=20this=20e-mail=20message,=20and=20any=20a=
ttachments=20thereto,=20is=20strictly=20prohibited.=20=20If=20you=20have=20=
received=20this=20e-mail=20message=20in=20error,=20please=20immediately=20=
notify=20the=20sender=20and=20permanently=20delete=20the=20original=20and=20=
any=20copies=20of=20this=20email=20and=20any=20prints=20thereof.
ABSENT=20AN=20EXPRESS=20STATEMENT=20TO=20THE=20CONTRARY=20HEREINABOVE,=20T=
HIS=20E-MAIL=20IS=20NOT=20INTENDED=20AS=20A=20SUBSTITUTE=20FOR=20A=20WRITI=
NG.=20=20Notwithstanding=20the=20Uniform=20Electronic=20Transactions=20Act=
=20or=20the=20applicability=20of=20any=20other=20law=20of=20similar=20subs=
tance=20and=20effect,=20absent=20an=20express=20statement=20to=20the=20con=
trary=20hereinabove,=20this=20e-mail=20message=20its=20contents,=20and=20a=
ny=20attachments=20hereto=20are=20not=20intended=20to=20represent=20an=20o=
ffer=20or=20acceptance=20to=20enter=20into=20a=20contract=20and=20are=20no=
t=20otherwise=20intended=20to=20bind=20the=20sender,=20Sanmina-SCI=20Corpo=
ration=20(or=20any=20of=20its=20subsidiaries),=20or=20any=20other=20person=
=20or=20entity.
------_=_NextPart_001_01C7DF75.3CCE6132
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE=20HTML=20PUBLIC=20"-//W3C//DTD=20HTML=203.2//EN">
<HTML>
<HEAD>
<META=20HTTP-EQUIV=3D"Content-Type"=20CONTENT=3D"text/html;=20charset=3Dis=
o-8859-1">
<META=20NAME=3D"Generator"=20CONTENT=3D"MS=20Exchange=20Server=20version=20=
6.5.7652.24">
<TITLE>FW:=20Cypress=20C67X00=20driver=20question</TITLE>
</HEAD>
<BODY>
<!--=20Converted=20from=20text/plain=20format=20-->

<P><FONT=20SIZE=3D2>Sorry,=20replied=20to=20wrong=20address...<BR>
<BR>
-----Original=20Message-----<BR>
From:=20Robertson,=20Joseph=20M.<BR>
Sent:=20Wed=208/15/2007=202:18=20PM<BR>
To:=20Peter=20Korsgaard<BR>
Subject:=20RE:=20Cypress=20C67X00=20driver=20question<BR>
<BR>
Hi,<BR>
<BR>
Ok=20call=20me=20dense,=20but=20I=20still=20get=20a=20problem.&nbsp;<BR>
I=20put=20some=20messages=20in=20the=20driver.&nbsp;=20I=20see=20the=20c67=
x00_drv=20init,=20and=20also=20udc_init.<BR>
But=20no=20hdc=20init=20and=20no=20probing.&nbsp;=20And=20my=20ports=20are=
=20not=20powered.<BR>
I=20built=20the=20system=20to=20use=20c67x00_hdc,=20and=20I=20want=202=20h=
osts=20enabled.<BR>
<BR>
RE:=20The=20CYPRESS=20C67300=20and=20ROM.&nbsp;&nbsp;=20By=20the=20docs,=20=
this=20thing=20comes=20up=20dead.&nbsp;=20It=20comes=20up=20HPI,=20co-proc=
essor=20mode=20and=20waits.<BR>
All=20the=20defaut=20values=20are=200=20=3D=20disabled,=20off,=20etc.<BR>
<BR>
Actually=20I=20have=20to=20get=20my=20hardware=20guys=20to=20double-check=20=
that,=20and=20also=20my=20port=20wiring,=20but=20thats=20another=20story.<=
BR>
<BR>
Where=20does=20'platform_device=20c67x00'=20go?&nbsp;=20That=20is,=20shoul=
d=20it=20be=20sent/used=20by=20some=20init=20function?&nbsp;=20All=20I=20c=
ould=20find=20was=20c67x00_sie?<BR>
<BR>
Thanks=20again.<BR>
<BR>
Joe=20Robertson<BR>
Joseph.Robertson@sanmina-sci.com<BR>
<BR>
<BR>
<BR>
-----Original=20Message-----<BR>
From:=20linuxppc-embedded-bounces+joseph.robertson=3Dsanmina-sci.com@ozlab=
s.org=20on=20behalf=20of=20Peter=20Korsgaard<BR>
Sent:=20Thu=208/9/2007=202:08=20AM<BR>
To:=20linuxppc-embedded@ozlabs.org<BR>
Subject:=20Re:=20Cypress=20C67X00=20driver=20question<BR>
<BR>
&gt;&gt;&gt;&gt;&gt;=20&quot;RJM&quot;=20=3D=3D=20Robertson,=20Joseph=20M=20=
&lt;joseph.robertson@sanmina-sci.com&gt;=20writes:<BR>
<BR>
Hi,<BR>
<BR>
RJM&gt;=20Hi=20all,=20First=20off=20big=20thanks=20to=20the=20guys=20worki=
ng=20on=20the=20Cypress<BR>
RJM&gt;=20USB=20C67X00=20driver!&nbsp;=20Without=20them=20I=20would=20not=20=
even=20be=20this=20far.<BR>
<BR>
You're=20welcome.<BR>
<BR>
RJM&gt;=20But=20my=20question=20for=20them=20is:=20How=20are=20you=20guys=20=
initializing=20the<BR>
RJM&gt;=20Cypress=20chip?&nbsp;=20It=20looks=20like=20the=20driver=20is=20=
expecting=20the=20cypress<BR>
RJM&gt;=20to=20be=20programmed=20and=20ready.<BR>
<BR>
No,=20you=20don't=20need=20to=20program=20anything.=20The=20driver=20only=20=
uses=20he<BR>
Cypress=20BIOS=20programmed=20in=20ROM=20in=20the=20chip.<BR>
<BR>
You=20just=20need=20to=20register=20a=20struct=20platform_device=20in=20yo=
ur=20board=20code<BR>
with=20the=20base=20address,=20IRQ=20and=20port=20configuration=20-=20Some=
thing=20like:<BR>
<BR>
#include=20&lt;linux/usb/c67x00.h<BR>
<BR>
..<BR>
<BR>
static=20struct=20resource=20c67x00_resources[]=20=3D=20{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20[0]=20=3D=20{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20.start&nbsp;=20=3D=200x84000000,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20.end&nbsp;&nbsp;&nbsp;=20=3D=200x8400000f,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20.flags&nbsp;=20=3D=20IORESOURCE_MEM,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20},<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20[1]=20=3D=20{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20.start&nbsp;=20=3D=203,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20.end&nbsp;&nbsp;&nbsp;=20=3D=203,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20.flags&nbsp;=20=3D=20IORESOURCE_IRQ,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20},<BR>
};<BR>
<BR>
static=20struct=20c67x00_platform_data=20c67x00_data=20=3D=20{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20.sie_config&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20=3D=20C67X00_SIE1=
_HOST=20|=20C67X00_SIE2_HOST,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20.hpi_regstep&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20=3D=200x02,<BR>
};<BR>
<BR>
static=20struct=20platform_device=20c67x00=20=3D=20{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20.name&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;=20=3D=20&quot;c67x00&quot;,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20.id&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;=20=3D=200,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20.num_resources&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20=3D=20ARRAY_SIZE(c67x00_resource=
s),<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20.resource&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20=3D=20c=
67x00_resources,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20.dev.platform_data&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;=20=3D=20&amp;c67x00_data,<BR>
};<BR>
<BR>
--<BR>
Bye,=20Peter=20Korsgaard<BR>
_______________________________________________<BR>
Linuxppc-embedded=20mailing=20list<BR>
Linuxppc-embedded@ozlabs.org<BR>
<A=20HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https:=
//ozlabs.org/mailman/listinfo/linuxppc-embedded</A><BR>
<BR>
<BR>
</FONT>
</P>


<BR>
CONFIDENTIALITY<BR>
This=20e-mail=20message=20and=20any=20attachments=20thereto,=20is=20intend=
ed=20only=20for=20use=20by=20the=20addressee(s)=20named=20herein=20and=20m=
ay=20contain=20legally=20privileged=20and/or=20confidential=20information.=
=20If=20you=20are=20not=20the=20intended=20recipient=20of=20this=20e-mail=20=
message,=20you=20are=20hereby=20notified=20that=20any=20dissemination,=20d=
istribution=20or=20copying=20of=20this=20e-mail=20message,=20and=20any=20a=
ttachments=20thereto,=20is=20strictly=20prohibited.=20=20If=20you=20have=20=
received=20this=20e-mail=20message=20in=20error,=20please=20immediately=20=
notify=20the=20sender=20and=20permanently=20delete=20the=20original=20and=20=
any=20copies=20of=20this=20email=20and=20any=20prints=20thereof.<BR>
ABSENT=20AN=20EXPRESS=20STATEMENT=20TO=20THE=20CONTRARY=20HEREINABOVE,=20T=
HIS=20E-MAIL=20IS=20NOT=20INTENDED=20AS=20A=20SUBSTITUTE=20FOR=20A=20WRITI=
NG.=20=20Notwithstanding=20the=20Uniform=20Electronic=20Transactions=20Act=
=20or=20the=20applicability=20of=20any=20other=20law=20of=20similar=20subs=
tance=20and=20effect,=20absent=20an=20express=20statement=20to=20the=20con=
trary=20hereinabove,=20this=20e-mail=20message=20its=20contents,=20and=20a=
ny=20attachments=20hereto=20are=20not=20intended=20to=20represent=20an=20o=
ffer=20or=20acceptance=20to=20enter=20into=20a=20contract=20and=20are=20no=
t=20otherwise=20intended=20to=20bind=20the=20sender,=20Sanmina-SCI=20Corpo=
ration=20(or=20any=20of=20its=20subsidiaries),=20or=20any=20other=20person=
=20or=20entity.<BR>
</BODY>
</HTML>
------_=_NextPart_001_01C7DF75.3CCE6132--
