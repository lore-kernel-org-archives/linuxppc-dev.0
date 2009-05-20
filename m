Return-Path: <tanderson@curtisswright.com>
Received: from mail108.messagelabs.com (mail108.messagelabs.com
	[216.82.250.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail108.messagelabs.com",
	Issuer "MessageLabs" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 621E2DE19A
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 09:42:52 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: RapidIO - general questions
Date: Wed, 20 May 2009 16:42:41 -0700
Message-ID: <DB9BF8E7D974314CA8FEF8445DE4098F047F3EB4@SDGEXCH01.SDG.CW.LOCAL>
In-Reply-To: <1242802800.9160.143.camel@demuxf9c>
References: <1242119872.16400.113.camel@demuxf9c><2a27d3730905130357re0adf41l19f5603a70dac57b@mail.gmail.com><1242372791.26759.34.camel@demuxf9c><2a27d3730905150056m7298b66ckb9db92f9432953d6@mail.gmail.com>
	<1242802800.9160.143.camel@demuxf9c>
From: "Anderson, Trevor" <tanderson@curtisswright.com>
To: "Jan Neskudla" <jan.neskudla.ext@nsn.com>,
	"ext Li Yang" <leoli@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With=20regards=20to=20your=20Oops:=20we=20sometimes=20find=20that,=20altho=
ugh=20a=20switch=20may
report=20a=20port=20being=20active,=20whenever
we=20try=20to=20discover=20what=20lies=20behind=20it,=20transfer=20errors=20=
occur=20that=20are
non-recoverable.

As=20a=20solution,=20on=20Freescale=20MPC8641D,=20we=20use=20a=20DMA=20tra=
nsfer=20to=20perform=20a
simple=20MAINT=20read=20on=20a=20new=20device,=20just=20to=20see=20if=20it=
=20responds.=20Transfer
errors=20may=20still=20happen,=20but=20they=20are=20recoverable=20in=20tha=
t=20case,=20and=20you
can=20train=20your=20code=20to=20avoid=20that=20port=20or=20try=20it=20lat=
er.=20(The=20DMA=20engine
will=20report=20the=20error,=20not=20the=20processor.)



>=20-----Original=20Message-----
>=20From:=20linuxppc-dev-bounces+tanderson=3Dcurtisswright.com@ozlabs.org
[mailto:linuxppc-dev-
>=20bounces+tanderson=3Dcurtisswright.com@ozlabs.org]=20On=20Behalf=20Of=20=
Jan
Neskudla
>=20Sent:=20Wednesday,=20May=2020,=202009=2012:00=20AM
>=20To:=20ext=20Li=20Yang
>=20Cc:=20linuxppc-dev;=20linux-kernel@vger.kernel.org
>=20Subject:=20Re:=20RapidIO=20-=20general=20questions
>=20
>=20n=20Fri,=202009-05-15=20at=2015:56=20+0800,=20ext=20Li=20Yang=20wrote:=

>=20>=20On=20Fri,=20May=2015,=202009=20at=203:33=20PM,=20Jan=20Neskudla
<jan.neskudla.ext@nsn.com>=20wrote:
>=20>=20>=20On=20Wed,=202009-05-13=20at=2018:57=20+0800,=20ext=20Li=20Yang=
=20wrote:
>=20>=20>>=20cc'ed=20LKML
>=20>=20>>
>=20>=20>>=20On=20Tue,=20May=2012,=202009=20at=205:17=20PM,=20Jan=20Neskud=
la
<jan.neskudla.ext@nsn.com>=20wrote:
>=20>=20>>=20>=20Hallo
>=20>=20>>=20>
>=20>=20>>=20>=20we'd=20likes=20to=20use=20a=20RapidIO=20as=20a=20general=20=
communication=20bus=20on
our=20new
>=20>=20>>=20>=20product,=20and=20so=20I=20have=20some=20questions=20about=
=20general=20design=20of
Linux=20RIO
>=20>=20>>=20>=20subsystem.=20I=20did=20not=20find=20any=20better=20mailin=
g=20list=20for=20RapidIO
>=20>=20>>=20>=20discussion.
>=20>=20>>=20>
>=20>=20>>=20>=20[1]=20-=20we'd=20like=20to=20implement=20following=20feat=
ures
>=20>=20>>=20>=20=20=20=20*=20Hot-plug=20(hot-insert/hot-remove)=20of=20de=
vices
>=20>=20>>=20>=20=20=20=20*=20Error=20handling=20(port-write=20packets=20-=
=20configuration,
handling=20of
>=20>=20>>=20>=20them)
>=20>=20>>=20>=20=20=20=20*=20Static=20ID=20configuration=20based=20on=20p=
ort=20numbers
>=20>=20>>=20>=20=20=20=20*=20Aux=20driver=20-=20basic=20driver,=20for=20s=
ending=20messages=20over
different
>=20>=20>>=20>=20mboxes,=20handling=20ranges=20of=20doorbells
>=20>=20>>=20>
>=20>=20>>=20>=20=20=20=20Is=20it=20here=20anyone=20who=20is=20working=20o=
n=20any=20improvement,=20or
anyone=20who
>=20>=20>>=20>=20knows=20the=20development=20plans=20for=20RapidIO=20subsy=
stem?
>=20>=20>>=20>
>=20>=20>>
>=20>=20>>=20AFAIK,=20there=20is=20no=20one=20currently=20working=20on=20t=
hese=20features=20for
Linux.
>=20>=20>>=20It=20will=20be=20good=20if=20you=20can=20add=20these=20useful=
=20features.
>=20>=20>=20Yes=20it=20looks=20like=20that,=20currently=20we=20are=20analy=
zing=20current=20rapidIO
>=20>=20>=20system,=20and=20how=20we=20can=20add=20these=20features.
>=20>=20>
>=20>=20>>
>=20>=20>>=20>=20[2]=20-=20I=20have=20a=20following=20problem=20with=20a=20=
current=20implementation
of
>=20>=20>>=20>=20loading=20drivers.=20The=20driver=20probe-function=20call=
=20is=20based=20on
comparison
>=20>=20>>=20>=20of=20VendorID=20(VID)=20and=20DeviceID=20(DID)=20only.=20=
Thus=20if=20I=20have=203
devices=20with
>=20>=20>>=20>=20same=20DID=20and=20VID=20connected=20to=20the=20same=20ne=
twork=20(bus),=20the
driver=20is
>=20>=20>>=20>=20loaded=203times,=20instead=20only=20once=20for=20the=20ac=
tual=20device=20Master
port.
>=20>=20>>
>=20>=20>>=20This=20should=20be=20the=20correct=20way=20as=20you=20actuall=
y=20have=203=20instances
of=20the=20device.
>=20>=20>>
>=20>=20>>=20>
>=20>=20>>=20>=20Rionet=20driver=20solved=20this=20by=20enabling=20to=20ca=
ll=20initialization
function
>=20>=20>>=20>=20just=20once,=20and=20it=20expect=20that=20this=20is=20the=
=20Master=20port.
>=20>=20>>
>=20>=20>>=20Rionet=20is=20kind=20of=20special.=20=20It's=20not=20working=20=
like=20a=20simple=20device
>=20>=20>>=20driver,=20but=20more=20like=20a=20customized=20protocol=20sta=
ck=20to=20support
multiple
>=20>=20>>=20ethernet=20over=20rio=20links.
>=20>=20>>
>=20>=20>>=20>
>=20>=20>>=20>=20Is=20it=20this=20correct=20behavior=20=20?=20It=20looks=20=
to=20me=20that=20RapidIO=20is
handled
>=20>=20>>=20>=20like=20a=20local=20bus=20(like=20PCI)
>=20>=20>>
>=20>=20>>=20This=20is=20correct=20behavior.=20=20All=20of=20them=20are=20=
using=20Linux
device/driver
>=20>=20>>=20infrastructure,=20but=20rionet=20is=20a=20special=20device.
>=20>=20>
>=20>=20>=20But=20I=20do=20not=20have=20a=203=20devices=20on=20one=20silic=
on.=20I=20am=20talking=20about=203
>=20>=20>=20devices=20(3=20x=20EP8548=20boards=20+=20IDT=20switch)=20conne=
cted=20over=20rapidIO
through
>=20>=20>=20the=20switch.=20And=20in=20this=20case=20I'd=20like=20to=20hav=
e=20only=20one=20driver
siting=20on
>=20>=20>=20the=20top=20of=20Linux=20RapidIO=20subsystem.=20I=20don't=20se=
e=20the=20advantage=20of
loading
>=20>
>=20>=20You=20are=20having=20one=20driver,=20but=20it=20probes=203=20times=
=20for=20each=20device
using
>=20>=20the=20driver.
>=20>
>=20>=20>=20a=20driver=20locally=20for=20remote=20device.=20Am=20I=20missi=
ng=20something=20=20?
>=20>
>=20>=20If=20you=20want=20to=20interact=20with=20the=20remote=20device,=20=
you=20need=20the=20driver
to
>=20>=20do=20the=20work=20locally.
>=20
>=20We=20are=20going=20to=20use=20a=20RapidIO=20as=20a=20bigger=20network=20=
of=20active=20devices,
and
>=20each=20will=20have=20each=20own=20driver=20(sitting=20on=20its=20own),=
=20and=20all=20the
>=20settings=20will=20be=20done=20over=20maintenance=20packets.
>=20
>=20May=20be=20it=20will=20be=20solved=20by=20the=20fact,=20that=20we=20ar=
e=20going=20to=20use=20a
>=20staticIDs,=20so=20there=20will=20be=20no=20discovery=20as=20it=20is=20=
now.=20And=20thus=20there
>=20will=20be=20only=20one=20device=20visible=20in=20the=20internal=20stru=
ctures=20of=20the
>=20subsystem,=20and=20thus=20only=20one=20drive=20will=20be=20loaded.
>=20
>=20>
>=20>=20>
>=20>=20>=20And=20one=20more=20think,=20I=20am=20getting=20so=20much=20Bus=
=20errors=20OOPSes.
Whenever
>=20>=20>=20there=20is=20a=20problem=20with=20a=20comunication=20over=20Ri=
o=20I=20get=20such=20a
kernel=20OPS.
>=20>=20>=20I=20had=20to=20add=20some=20delays=20into=20some=20function=20=
to=20be=20able=20to=20finish
the
>=20>=20>=20enum+discovery=20process.=20Did=20you=20have=20some=20experien=
ce=20with=20some
bigger
>=20>=20>=20rio=20network=20running=20under=20linux=20?
>=20>
>=20>=20It=20looks=20like=20an=20known=20issue=20for=20switched=20rio=20ne=
twork,=20but=20I=20don't
>=20>=20have=20the=20correct=20equipment=20to=20reproduce=20the=20problem=20=
here.=20=20Could=20you
>=20>=20do=20some=20basic=20debugging=20and=20share=20your=20findings?=20=20=
Thanks.
>=20
>=20I=20tried=20to=20acquired=20some=20info=20about=20the=20problem,=20I=20=
found=20that=20the=20OOPS
>=20always=20occur=20when=20there=20is=20no=20respond=20from=20the=20devic=
e=20or=20the=20respond
is
>=20too=20slow.=20I=20always=20got=20that=20error=20during=20function=20ca=
ll
>=20rio_get_host_deviceid_lock=20when=20it=20tries=20to=20access=20a=20rem=
ote=20device=20or
>=20switch.=20This=20function=20is=20the=20first=20call=20of=20the
rio_mport_read_config_32
>=20so=20is=20also=20first=20try=20of=20remote=20access=20to=20any=20devic=
e.
>=20
>=20It=20is=20a=20timing=20issue,=20and=20after=20placing=20a=20printk=20i=
nto=20the
>=20rio_get_host_deviceid_lock=20the=20OOPSing=20almost=20disappeared.
>=20
>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20Jan
>=20
>=20>
>=20>=20-=20Leo
>=20
>=20_______________________________________________
>=20Linuxppc-dev=20mailing=20list
>=20Linuxppc-dev@ozlabs.org
>=20https://ozlabs.org/mailman/listinfo/linuxppc-dev

_______________________________________________________________________
This=20e-mail=20and=20any=20files=20transmitted=20with=20it=20are=20propri=
etary=20and=20intended=20solely=20for=20the=20use=20of=20the=20individual=20=
or=20entity=20to=20whom=20they=20are=20addressed.=20If=20you=20have=20reas=
on=20to=20believe=20that=20you=20have=20received=20this=20e-mail=20in=20er=
ror,=20please=20notify=20the=20sender=20and=20destroy=20this=20email=20and=
=20any=20attached=20files.=20Please=20note=20that=20any=20views=20or=20opi=
nions=20presented=20in=20this=20e-mail=20are=20solely=20those=20of=20the=20=
author=20and=20do=20not=20necessarily=20represent=20those=20of=20the=20Cur=
tiss-Wright=20Corporation=20or=20any=20of=20its=20subsidiaries.=20=20Docum=
ents=20attached=20hereto=20may=20contain=20technology=20subject=20to=20gov=
ernment=20export=20regulations.=20Recipient=20is=20solely=20responsible=20=
for=20ensuring=20that=20any=20re-export,=20transfer=20or=20disclosure=20of=
=20this=20information=20is=20in=20accordance=20with=20applicable=20governm=
ent=20export=20regulations.=20=20The=20recipient=20should=20check=20this=20=
e-mail=20and=20any=20attachments=20for=20the=20presence=20of=20viruses.=20=
Curtiss-Wright=20Corporation=20and=20its=20subsidiaries=20accept=20no=20li=
ability=20for=20any=20damage=20caused=20by=20any=20virus=20transmitted=20b=
y=20this=20e-mail.
