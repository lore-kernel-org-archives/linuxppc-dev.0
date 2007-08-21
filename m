Return-Path: <joseph.robertson@sanmina-sci.com>
Received: from mail94.messagelabs.com (mail94.messagelabs.com [216.82.240.115])
	by ozlabs.org (Postfix) with SMTP id 72513DDE3B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 04:57:24 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7E425.19B6F88B"
Subject: C67x00 Driver IRQ Problem.
Date: Tue, 21 Aug 2007 13:57:19 -0500
Message-ID: <939D37AEB47F1F49B88FAB6599B6023501A17279@hsv1dafpew02.das.gov.sanm.corp>
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

------_=_NextPart_001_01C7E425.19B6F88B
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi=20all.

I=20got=20the=20driver=20registered=20and=20have=20spent=20some=20time=20t=
racking=20down=20a=20IRQ=20problem.
It=20just=20ignores=20me=20when=20it=20gets=20to=20'request_irq'=20with=20=
a=20'nobody=20cared'=20response.=20=20
The=20memory=20appears=20right=20and=20the=20test=20IRQ=20of=203=20is=20su=
pposed=20to=20be=20correct.=20=20
I=20never=20see=20the=20HCD=20driver=20load=20up,=20does=20that=20have=20t=
o=20startup=20first?

I=20tried=20also=20waking=20the=20c67300=20chip=20by=20writing=20a=20Inter=
rupt=20Enable=20Reg=20(0xC00E)=20a=20value=20to=20enable=20the=20ints.=20=20=


Do=20I=20need=20a=20/dev/usb=20device=20tree=20of=20some=20kind?=20=20I=20=
have=20a=20fixed=20dev=20tree=20since=20we=20are=20a=20embedded=20sys.

I=20added=20some=20printk=20messages=20to=20help=20us=20out...
Any=20helpful=20info=20would=20be=20much=20appreciated.
Kernel=20code=20is=202.6.17.3,=20much=20hacked=20and=20maligned=20by=20me.=

I=20made=20a=20module=20of=20the=20c67x00,=20heres=20the=20load=20results.=


Load=20Results=20-----
c67x00=20init.<6>bus=20platform:=20add=20driver=20c67x00
before=20kset=20=3D=20bus->drivers.
c67x00=20drv=20probing...
c67x00=20drv=20get=20mem=20resource.
platform_get_resource,=20num=20resources=3D2.
dev->resource[0]=3D512
c67x00=20drv=20get=20irq=20resource.
platform_get_resource,=20num=20resources=3D2.
dev->resource[0]=3D512
dev->resource[1]=3D1024
c67x00=20drv=20get=20platform=20data.
c67x00=20drv=20setup=20sies.
c67x00=20c67x00.0:=20USB=20OTG=20controller,=20p:0x43e00000,=20v:0xc505800=
0,=20irq:3
irq=203:=20nobody=20cared=20(try=20booting=20with=20the=20"irqpoll"=20opti=
on)
Call=20Trace:
[C0F0FA50]=20[C0009BC0]=20show_stack+0x44/0x194=20(unreliable)
[C0F0FA90]=20[C004A118]=20__report_bad_irq+0x34/0xac
[C0F0FAB0]=20[C004A268]=20note_interrupt+0xbc/0x13c
[C0F0FAE0]=20[C00498E8]=20__do_IRQ+0x1a8/0x1c0
[C0F0FB10]=20[C0007360]=20do_IRQ+0x48/0x78
[C0F0FB30]=20[C00033FC]=20ret_from_except+0x0/0x18
[C0F0FBF0]=20[C0F0FC90]=200xc0f0fc90
[C0F0FC20]=20[C00073F4]=20do_softirq+0x64/0x74
[C0F0FC40]=20[C0028358]=20irq_exit+0x60/0x64
[C0F0FC60]=20[C0007364]=20do_IRQ+0x4c/0x78
[C0F0FC80]=20[C00033FC]=20ret_from_except+0x0/0x18
[C0F0FD40]=20[C5058000]=200xc5058000
[C0F0FD70]=20[C0049EC0]=20request_irq+0x94/0xc8
[C0F0FDA0]=20[C50715B4]=20usb_c67x00_drv_probe+0x240/0x2f4=20[c67x00]
[C0F0FDF0]=20[C0142124]=20platform_drv_probe+0x20/0x30
[C0F0FE00]=20[C013FA58]=20driver_probe_device+0x7c/0x110
[C0F0FE20]=20[C013EE70]=20bus_for_each_drv+0x74/0xa4
[C0F0FE60]=20[C013FB98]=20device_attach+0xa8/0xb8
[C0F0FE80]=20[C013F004]=20bus_add_device+0x34/0xa0
[C0F0FEA0]=20[C013D900]=20device_add+0x128/0x188
[C0F0FED0]=20[C0141EDC]=20platform_device_add+0xd4/0x194
[C0F0FF00]=20[C502D074]=20c67x00_init+0x74/0x118=20[c67x00]
[C0F0FF20]=20[C00433A8]=20sys_init_module+0x188/0x240
[C0F0FF40]=20[C0002DB4]=20ret_from_syscall+0x0/0x3c
handlers:
[<c5071220>]=20(c67x00_irq+0x0/0x154=20[c67x00])
Disabling=20IRQ=20#3
Badness=20in=20ll_recv_msg=20at=20drivers/usb/c67x00/c67x00-ll-hpi.c:246
Call=20Trace:
[C0F0FC50]=20[C0009BC0]=20show_stack+0x44/0x194=20(unreliable)
[C0F0FC90]=20[C0003F64]=20check_bug_trap+0x84/0xac
[C0F0FCA0]=20[C0004130]=20program_check_exception+0x1a4/0x1f8
[C0F0FCC0]=20[C00033B0]=20ret_from_except_full+0x0/0x4c
[C0F0FD80]=20[C5072A6C]=20c67x00_ll_reset+0x84/0xe0=20[c67x00]
[C0F0FDA0]=20[C50715FC]=20usb_c67x00_drv_probe+0x288/0x2f4=20[c67x00]
[C0F0FDF0]=20[C0142124]=20platform_drv_probe+0x20/0x30
[C0F0FE00]=20[C013FA58]=20driver_probe_device+0x7c/0x110
[C0F0FE20]=20[C013EE70]=20bus_for_each_drv+0x74/0xa4
[C0F0FE60]=20[C013FB98]=20device_attach+0xa8/0xb8
[C0F0FE80]=20[C013F004]=20bus_add_device+0x34/0xa0
[C0F0FEA0]=20[C013D900]=20device_add+0x128/0x188
[C0F0FED0]=20[C0141EDC]=20platform_device_add+0xd4/0x194
[C0F0FF00]=20[C502D074]=20c67x00_init+0x74/0x118=20[c67x00]
[C0F0FF20]=20[C00433A8]=20sys_init_module+0x188/0x240
[C0F0FF40]=20[C0002DB4]=20ret_from_syscall+0x0/0x3c
c67x00=20c67x00.0:=20Device=20reset=20failed
c67x00:=20probe=20of=20c67x00.0=20failed=20with=20error=2065531
c67x00=20udc=20init.
ECAU-9999:#=20
End=20Load=20Results=20-----


Memory=20Check-----
ECAU-9999:#=20cat=20/proc/iomem=20
40401003-40401022=20:=20serial
40421003-40421022=20:=20serial
43e00000-43e0000f=20:=20c67x00.0
End=20Memory=20CHeck------


Many=20Thanks,

Joe=20Robertson
Joseph.Robertson@sanmina-sci.com


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
------_=_NextPart_001_01C7E425.19B6F88B
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
<TITLE>C67x00=20Driver=20IRQ=20Problem.</TITLE>
</HEAD>
<BODY>
<!--=20Converted=20from=20text/plain=20format=20-->

<P><FONT=20SIZE=3D2>Hi=20all.<BR>
<BR>
I=20got=20the=20driver=20registered=20and=20have=20spent=20some=20time=20t=
racking=20down=20a=20IRQ=20problem.<BR>
It=20just=20ignores=20me=20when=20it=20gets=20to=20'request_irq'=20with=20=
a=20'nobody=20cared'=20response.&nbsp;<BR>
The=20memory=20appears=20right=20and=20the=20test=20IRQ=20of=203=20is=20su=
pposed=20to=20be=20correct.&nbsp;<BR>
I=20never=20see=20the=20HCD=20driver=20load=20up,=20does=20that=20have=20t=
o=20startup=20first?<BR>
<BR>
I=20tried=20also=20waking=20the=20c67300=20chip=20by=20writing=20a=20Inter=
rupt=20Enable=20Reg=20(0xC00E)=20a=20value=20to=20enable=20the=20ints.&nbs=
p;<BR>
<BR>
Do=20I=20need=20a=20/dev/usb=20device=20tree=20of=20some=20kind?&nbsp;=20I=
=20have=20a=20fixed=20dev=20tree=20since=20we=20are=20a=20embedded=20sys.<=
BR>
<BR>
I=20added=20some=20printk=20messages=20to=20help=20us=20out...<BR>
Any=20helpful=20info=20would=20be=20much=20appreciated.<BR>
Kernel=20code=20is=202.6.17.3,=20much=20hacked=20and=20maligned=20by=20me.=
<BR>
I=20made=20a=20module=20of=20the=20c67x00,=20heres=20the=20load=20results.=
<BR>
<BR>
Load=20Results=20-----<BR>
c67x00=20init.&lt;6&gt;bus=20platform:=20add=20driver=20c67x00<BR>
before=20kset=20=3D=20bus-&gt;drivers.<BR>
c67x00=20drv=20probing...<BR>
c67x00=20drv=20get=20mem=20resource.<BR>
platform_get_resource,=20num=20resources=3D2.<BR>
dev-&gt;resource[0]=3D512<BR>
c67x00=20drv=20get=20irq=20resource.<BR>
platform_get_resource,=20num=20resources=3D2.<BR>
dev-&gt;resource[0]=3D512<BR>
dev-&gt;resource[1]=3D1024<BR>
c67x00=20drv=20get=20platform=20data.<BR>
c67x00=20drv=20setup=20sies.<BR>
c67x00=20c67x00.0:=20USB=20OTG=20controller,=20p:0x43e00000,=20v:0xc505800=
0,=20irq:3<BR>
irq=203:=20nobody=20cared=20(try=20booting=20with=20the=20&quot;irqpoll&qu=
ot;=20option)<BR>
Call=20Trace:<BR>
[C0F0FA50]=20[C0009BC0]=20show_stack+0x44/0x194=20(unreliable)<BR>
[C0F0FA90]=20[C004A118]=20__report_bad_irq+0x34/0xac<BR>
[C0F0FAB0]=20[C004A268]=20note_interrupt+0xbc/0x13c<BR>
[C0F0FAE0]=20[C00498E8]=20__do_IRQ+0x1a8/0x1c0<BR>
[C0F0FB10]=20[C0007360]=20do_IRQ+0x48/0x78<BR>
[C0F0FB30]=20[C00033FC]=20ret_from_except+0x0/0x18<BR>
[C0F0FBF0]=20[C0F0FC90]=200xc0f0fc90<BR>
[C0F0FC20]=20[C00073F4]=20do_softirq+0x64/0x74<BR>
[C0F0FC40]=20[C0028358]=20irq_exit+0x60/0x64<BR>
[C0F0FC60]=20[C0007364]=20do_IRQ+0x4c/0x78<BR>
[C0F0FC80]=20[C00033FC]=20ret_from_except+0x0/0x18<BR>
[C0F0FD40]=20[C5058000]=200xc5058000<BR>
[C0F0FD70]=20[C0049EC0]=20request_irq+0x94/0xc8<BR>
[C0F0FDA0]=20[C50715B4]=20usb_c67x00_drv_probe+0x240/0x2f4=20[c67x00]<BR>
[C0F0FDF0]=20[C0142124]=20platform_drv_probe+0x20/0x30<BR>
[C0F0FE00]=20[C013FA58]=20driver_probe_device+0x7c/0x110<BR>
[C0F0FE20]=20[C013EE70]=20bus_for_each_drv+0x74/0xa4<BR>
[C0F0FE60]=20[C013FB98]=20device_attach+0xa8/0xb8<BR>
[C0F0FE80]=20[C013F004]=20bus_add_device+0x34/0xa0<BR>
[C0F0FEA0]=20[C013D900]=20device_add+0x128/0x188<BR>
[C0F0FED0]=20[C0141EDC]=20platform_device_add+0xd4/0x194<BR>
[C0F0FF00]=20[C502D074]=20c67x00_init+0x74/0x118=20[c67x00]<BR>
[C0F0FF20]=20[C00433A8]=20sys_init_module+0x188/0x240<BR>
[C0F0FF40]=20[C0002DB4]=20ret_from_syscall+0x0/0x3c<BR>
handlers:<BR>
[&lt;c5071220&gt;]=20(c67x00_irq+0x0/0x154=20[c67x00])<BR>
Disabling=20IRQ=20#3<BR>
Badness=20in=20ll_recv_msg=20at=20drivers/usb/c67x00/c67x00-ll-hpi.c:246<B=
R>
Call=20Trace:<BR>
[C0F0FC50]=20[C0009BC0]=20show_stack+0x44/0x194=20(unreliable)<BR>
[C0F0FC90]=20[C0003F64]=20check_bug_trap+0x84/0xac<BR>
[C0F0FCA0]=20[C0004130]=20program_check_exception+0x1a4/0x1f8<BR>
[C0F0FCC0]=20[C00033B0]=20ret_from_except_full+0x0/0x4c<BR>
[C0F0FD80]=20[C5072A6C]=20c67x00_ll_reset+0x84/0xe0=20[c67x00]<BR>
[C0F0FDA0]=20[C50715FC]=20usb_c67x00_drv_probe+0x288/0x2f4=20[c67x00]<BR>
[C0F0FDF0]=20[C0142124]=20platform_drv_probe+0x20/0x30<BR>
[C0F0FE00]=20[C013FA58]=20driver_probe_device+0x7c/0x110<BR>
[C0F0FE20]=20[C013EE70]=20bus_for_each_drv+0x74/0xa4<BR>
[C0F0FE60]=20[C013FB98]=20device_attach+0xa8/0xb8<BR>
[C0F0FE80]=20[C013F004]=20bus_add_device+0x34/0xa0<BR>
[C0F0FEA0]=20[C013D900]=20device_add+0x128/0x188<BR>
[C0F0FED0]=20[C0141EDC]=20platform_device_add+0xd4/0x194<BR>
[C0F0FF00]=20[C502D074]=20c67x00_init+0x74/0x118=20[c67x00]<BR>
[C0F0FF20]=20[C00433A8]=20sys_init_module+0x188/0x240<BR>
[C0F0FF40]=20[C0002DB4]=20ret_from_syscall+0x0/0x3c<BR>
c67x00=20c67x00.0:=20Device=20reset=20failed<BR>
c67x00:=20probe=20of=20c67x00.0=20failed=20with=20error=2065531<BR>
c67x00=20udc=20init.<BR>
ECAU-9999:#<BR>
End=20Load=20Results=20-----<BR>
<BR>
<BR>
Memory=20Check-----<BR>
ECAU-9999:#=20cat=20/proc/iomem<BR>
40401003-40401022=20:=20serial<BR>
40421003-40421022=20:=20serial<BR>
43e00000-43e0000f=20:=20c67x00.0<BR>
End=20Memory=20CHeck------<BR>
<BR>
<BR>
Many=20Thanks,<BR>
<BR>
Joe=20Robertson<BR>
Joseph.Robertson@sanmina-sci.com<BR>
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
------_=_NextPart_001_01C7E425.19B6F88B--
