Return-Path: <junijoseph@yahoo.co.in>
Received: from web8413.mail.in.yahoo.com (web8413.mail.in.yahoo.com
	[202.43.219.101]) by ozlabs.org (Postfix) with SMTP id 9FF16DDEBE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 07:27:45 +1100 (EST)
Date: Tue, 23 Jan 2007 01:57:42 +0530 (IST)
From: agnel juni <junijoseph@yahoo.co.in>
Subject: Re: PCI IRQ -MPC8540
To: Jin Zhengxiong-R64188 <Jason.Jin@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-705913723-1169497662=:64959"
Message-ID: <83529.64959.qm@web8413.mail.in.yahoo.com>
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

--0-705913723-1169497662=:64959
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hello all:=0A=0A=0A=0ACan someone provide me the pointer for the patch for =
u-boot-1.1.2 to set-up  MPC8540 as an agent correctly.=0A=0AThanks=0AJ.Jose=
ph=0A=0A=0A=0A----- Original Message ----=0AFrom: Jin Zhengxiong-R64188 <Ja=
son.Jin@freescale.com>=0ATo: agnel juni <junijoseph@yahoo.co.in>=0ASent: Th=
ursday, 18 January, 2007 6:43:55 PM=0ASubject: RE: PCI IRQ -MPC8540=0A=0AMe=
ssage=0A=0A =0ADIV {=0AMARGIN:0px;}=0A=0A=0A=0A=0AThe comments inline the m=
ail, FYI... =0A=0A =0A=0A Ok.=0A=0AThe issue is , for the agent =0Adriver t=
o route the IRQ, if I understand right ... the PCI(being the host) BIOS =0A=
should assign an IRQ value isn't?.=0A =0A=0ADo you means the =0AIRQ value s=
hould be write to the 8540 pci config space? If the 8540 card was set =0Aas=
 agent correctly(there's another patch for the 8540 u-boot to set the agent=
 =0Acorrectly), it's the responsibility of the host to settup it's PCI IRQ.=
 The =0Aagent should just act like and normal PCI card, such as the ether c=
ard.the =0Aagent just need to generate a interrupt on the IRQ_OUT ping when=
 =0Aneeded.=0A=0A =0AThis doesn't happen in our =0Acase.=0A=0AWhen we plug =
the 8540 card as an agent to the PC host, only in one =0Aof the slots does =
the host PC BIOS =0Aassigns an IRQ value for the card. In others it doesn't=
.=0A=0A=0ATry to patch the =0A8540 u-boot to set the agent correctly, you c=
an also pay attention to the start =0Aup sequence of the agent and host, ma=
y be you need to stat up the agent u-boot =0Afirst(I can't remember this cl=
early,just FYI)=0A=0A  =0AI am just trying to understand the =0Apossible re=
ason.=0A=0AThanks=0AJ.Joseph=0A=0A=0A=0A----- =0AOriginal Message ----=0AFr=
om: Jin Zhengxiong-R64188 =0A<Jason.Jin@freescale.com>=0ATo: Kumar Gala =0A=
<galak@kernel.crashing.org>; agnel juni =0A<junijoseph@yahoo.co.in>=0ACc: l=
inuxppc-embedded@ozlabs.org=0ASent: =0AWednesday, 17 January, 2007 1:34:06 =
AM=0ASubject: RE: PCI IRQ -MPC8540=0A=0A=0A=0A=0A>What kinda of interrupt d=
o you want on =0AIRQ_OUT/INTA?=0A=0A>- k=0A=0AOn Jan 16, 2007, at 7:54 PM, =
agnel juni =0Awrote:=0A=0A> Yes IRQ_OUT is wired to INTA.=0A>=0A> Could you=
 =0Aplease advise on how to generate interrupt for this.=0A=0AYou can refer=
 to a =0AFreescale Linux BSP for MPC8540EVAL board. There's a pci agent dri=
ver for =0AMPC8540, and the corresponding host driver for MPC8560. The agen=
t driver use a =0Amessage interrupt in MPC8540 and redirect the interrupt t=
o IRQ_OUT. As the =0AIRQ_OUT is wired to INTA, you can treat MPC8540 as a P=
CI device.=0A=0AJason =0AJin=0A=0A=0A> Thanks=0A> J-=0A>=0A> ----- Original=
 Message =0A----=0A> From: Kumar Gala <galak@kernel.crashing.org>=0A> To: =
=0Aagnel juni <junijoseph@yahoo.co.in>=0A> Cc: =0Alinuxppc-embedded@ozlabs.=
org=0A> Sent: Tuesday, 16 January, 2007 5:29:01 =0APM=0A> Subject: Re: PCI =
IRQ -MPC8540=0A>=0A>=0A> On Jan 16, =0A2007, at 5:20 PM, agnel juni wrote:=
=0A>=0A> > Hello all:=0A> =0A>=0A> > I would like to understand if there is=
 a way to program the =0APCI =0A> > interrupt pin register of MPC8540. I di=
d look for this in the =0A=0A> > datasheet, but couldn't find any positive =
answer.=0A> =0A>=0A> > Currently, I am working in a set-up where MPC8540 is=
 an agent, =0A=0A> > plugged into the PC host. I couldn't get an IRQ for th=
e card when =0A=0A> > plugged in some PCI slots, whereas in one of the slot=
s I do see a =0A=0A> > non-zero value.=0A> >=0A> > It would be great if you=
 =0Acould help me understand the issue.=0A> >=0A> > I am sorry if the =0Aqu=
estion is inapporpriate in the group. I am =0A> > desperate to solve =0Athe=
 issue.=0A> >=0A> > Thanks for any help.=0A>=0A> You =0Aneed to find out ho=
w the PCI edge interrupts are wired on you =0A> board =0Athan we can talk a=
bout how to generate an interrupt based on =0A> =0Athat.  I'd guess IRQ_OUT=
 is wired to INTA, but it would be good to =0A=0A> verify that.=0A>=0A> - k=
=0A>=0A> > J.Joseph=0A> =0A>=0A> > ----- Original Message ----=0A> > From: =
Kumar Gala =0A<galak@kernel.crashing.org>=0A> > To: Wang Matthew-R59995 =0A=
<Qi.W@freescale.com>=0A> > Cc: linuxppc-embedded@ozlabs.org=0A> =0A> Sent: =
Wednesday, 18 October, 2006 6:54:24 PM=0A> > Subject: Re: =0ALinuxppc-embed=
ded Digest, Vol 26, Issue 36=0A> >=0A> >=0A> =0A> On Oct 18, 2006, at 8:10 =
PM, Wang Matthew-R59995 wrote:=0A> =0A>=0A> > > Hi Kumar,=0A> > >=0A> > > A=
ctually I =0Ado many trials about it. Vxwerks Bootrom is smaller=0A> than=
=0A> > =0A> U-Boot. The key difference between Bootrom and U-boot is that s=
ome =0A> =0A> > source code of Bootrom is invisible to the users.=0A> > =0A=
>=0A> > > Actually the rfi instruction which I point out is the =0Afirst rf=
i =0A> > > instruction of Linux PowerPC bringup.=0A> > =0A>=0A> > > Before =
that, it's TLB entry invalidation and temp TLB =0Aentry=0A> mapping.=0A> > =
>=0A> > > I check MMU setting =0Acarefully before coming Linux Kernel.=0A> =
> >=0A> > > I just =0Awant to know if other guys met similar scenario like =
me. I =0A> > > =0Adon't need the precise answer, just overall suggestion ab=
out it=0A> because =0AI=0A> > > understand that not everyone has the same b=
ootloader of =0Amine, that =0A> > > bootloader is actually a customized =0A=
bootloader.=0A> >=0A> > I understand that, thus I was asking what =0Aexact =
problem you were =0A> > seeing to try and help.=0A> =0A>=0A> > > Anyway tha=
nk you.=0A> > >=0A> > > R9 =0Apoint to LR register, mask the high 20 bit of=
 r9 and send to=0A> r7,=0A> =0A> > and=0A> > > then add 24, which means str=
ide 6 instructions =0Afor rfi instruction =0A> > > execution.=0A> > >=0A> >=
 =0A> Of course, rfi can switch the TLB entry, both the previous TLB =0A> =
=0A> > entry and the temp TLB entry point to the same physical =0Aaddress.=
=0A> > >=0A> > > I've checked it.=0A> =0A>=0A> > I know what the code does,=
 I wrote it :)=0A> >=0A> =0A> - kumar=0A> >=0A> >=0A> >=0A> > =0A__________=
_____________________________________=0A> > Linuxppc-embedded =0Amailing li=
st=0A> > Linuxppc-embedded@ozlabs.org =0A> > https://ozlabs.org/mailman/lis=
tinfo/linuxppc-embedded=0A> =0A>=0A> >=0A> > Here's a new way to find what =
you're looking for =0A- Yahoo! Answers=0A>=0A>=0A>=0A> Here's a new way to =
find what =0Ayou're looking for - Yahoo! =0AAnswers=0A=0A__________________=
_____________________________=0ALinuxppc-embedded =0Amailing list=0ALinuxpp=
c-embedded@ozlabs.org https://ozlabs.org/mailman/listinfo/linuxppc-embedded=
=0A=0A=0A=0A=0A=0A=0A=0A=0A=0AHere=A2s a new way to find what you're lookin=
g for - Yahoo! =0AAnswers =0A=0A=0A=0A=0A=0A=09=09=0A______________________=
____________________________________=0AYahoo! India Answers: Share what you=
 know. Learn something new=0Ahttp://in.answers.yahoo.com/
--0-705913723-1169497662=:64959
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 12pt;">Hello all:<br>=0A<br>=0ACan someone provide me the =
pointer for the patch for u-boot-1.1.2 to set-up&nbsp; MPC8540 as an agent =
correctly.<br><br>Thanks<br>J.Joseph<br><br><br><br><div style=3D"font-fami=
ly: times new roman,new york,times,serif; font-size: 12pt;">----- Original =
Message ----<br>From: Jin Zhengxiong-R64188 &lt;Jason.Jin@freescale.com&gt;=
<br>To: agnel juni &lt;junijoseph@yahoo.co.in&gt;<br>Sent: Thursday, 18 Jan=
uary, 2007 6:43:55 PM<br>Subject: RE: PCI IRQ -MPC8540<br><br><title>Messag=
e</title>=0A=0A =0A<style type=3D"text/css">DIV {=0AMARGIN:0px;}=0A</style>=
=0A=0A=0A<div style=3D"font-family: times new roman,new york,times,serif; f=
ont-size: 12pt;">=0A<div style=3D"font-family: times new roman,new york,tim=
es,serif; font-size: 12pt;"><span class=3D"373023102-19012007"><font color=
=3D"#0000ff" face=3D"Arial" size=3D"2"><font face=3D"Arial">T</font>he comm=
ents inline the mail, FYI...&nbsp;</font></span></div>=0A<div style=3D"font=
-family: times new roman,new york,times,serif; font-size: 12pt;"><span clas=
s=3D"373023102-19012007"></span>&nbsp;</div>=0A<div style=3D"font-family: t=
imes new roman,new york,times,serif; font-size: 12pt;"><span class=3D"37302=
3102-19012007">&nbsp;</span>Ok.<br><br>The issue is , for the agent =0Adriv=
er to route the IRQ, if I understand right ... the PCI(being the host) BIOS=
 =0Ashould assign an IRQ value isn't?.<br><span class=3D"373023102-19012007=
"><font color=3D"#0000ff" face=3D"Arial" size=3D"2">&nbsp;</font></span></d=
iv>=0A<div style=3D"font-family: times new roman,new york,times,serif; font=
-size: 12pt;"><font color=3D"#0000ff" face=3D"Arial" size=3D"2"><span class=
=3D"373023102-19012007">Do you means the =0AIRQ value should be write to th=
e 8540 pci config space? If the 8540 card was set =0Aas agent correctly(the=
re's another patch for the 8540 u-boot to set the agent =0Acorrectly), it's=
 the responsibility of the host to settup it's PCI IRQ. The =0Aagent should=
 just act like and normal PCI card,&nbsp;such as the ether card.the =0Aagen=
t just need to generate a interrupt on the IRQ_OUT ping when =0Aneeded.</sp=
an></font></div>=0A<div style=3D"font-family: times new roman,new york,time=
s,serif; font-size: 12pt;"><span class=3D"373023102-19012007">&nbsp;</span>=
<br>This doesn't happen in our =0Acase.<br><br>When we plug the 8540 card a=
s an agent to the PC host, only in one =0Aof the slots does the <span style=
=3D"font-weight: bold;">host PC BIO</span>S =0Aassigns an IRQ value for the=
 card. In others it doesn't.<br><span class=3D"373023102-19012007"><font co=
lor=3D"#0000ff" face=3D"Arial" size=3D"2"></font></span></div>=0A<div style=
=3D"font-family: times new roman,new york,times,serif; font-size: 12pt;"><f=
ont color=3D"#0000ff" face=3D"Arial" size=3D"2"><span class=3D"373023102-19=
012007">Try to patch the =0A8540 u-boot to set the agent correctly, you can=
 also pay attention to the start =0Aup sequence of the agent and host, may =
be you need to stat up the agent u-boot =0Afirst(I can't remember this clea=
rly,just FYI)</span></font></div>=0A<div style=3D"font-family: times new ro=
man,new york,times,serif; font-size: 12pt;"><span class=3D"373023102-190120=
07">&nbsp;</span><span class=3D"373023102-19012007">&nbsp;</span><br>I am j=
ust trying to understand the =0Apossible reason.<br><br>Thanks<br>J.Joseph<=
br></div><br>=0A<div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 12pt;">----- =0AOriginal Message ----<br>From: Jin Zhengxi=
ong-R64188 =0A&lt;Jason.Jin@freescale.com&gt;<br>To: Kumar Gala =0A&lt;gala=
k@kernel.crashing.org&gt;; agnel juni =0A&lt;junijoseph@yahoo.co.in&gt;<br>=
Cc: linuxppc-embedded@ozlabs.org<br>Sent: =0AWednesday, 17 January, 2007 1:=
34:06 AM<br>Subject: RE: PCI IRQ -MPC8540<br><br>=0A<div><br><br>&gt;What k=
inda of interrupt do you want on =0AIRQ_OUT/INTA?<br><br>&gt;- k<br><br>On =
Jan 16, 2007, at 7:54 PM, agnel juni =0Awrote:<br><br>&gt; Yes IRQ_OUT is w=
ired to INTA.<br>&gt;<br>&gt; Could you =0Aplease advise on how to generate=
 interrupt for this.<br><br>You can refer to a =0AFreescale Linux BSP for M=
PC8540EVAL board. There's a pci agent driver for =0AMPC8540, and the corres=
ponding host driver for MPC8560. The agent driver use a =0Amessage interrup=
t in MPC8540 and redirect the interrupt to IRQ_OUT. As the =0AIRQ_OUT is wi=
red to INTA, you can treat MPC8540 as a PCI device.<br><br>Jason =0AJin<br>=
<br><br>&gt; Thanks<br>&gt; J-<br>&gt;<br>&gt; ----- Original Message =0A--=
--<br>&gt; From: Kumar Gala &lt;galak@kernel.crashing.org&gt;<br>&gt; To: =
=0Aagnel juni &lt;junijoseph@yahoo.co.in&gt;<br>&gt; Cc: =0Alinuxppc-embedd=
ed@ozlabs.org<br>&gt; Sent: Tuesday, 16 January, 2007 5:29:01 =0APM<br>&gt;=
 Subject: Re: PCI IRQ -MPC8540<br>&gt;<br>&gt;<br>&gt; On Jan 16, =0A2007, =
at 5:20 PM, agnel juni wrote:<br>&gt;<br>&gt; &gt; Hello all:<br>&gt; =0A&g=
t;<br>&gt; &gt; I would like to understand if there is a way to program the=
 =0APCI <br>&gt; &gt; interrupt pin register of MPC8540. I did look for thi=
s in the =0A<br>&gt; &gt; datasheet, but couldn't find any positive answer.=
<br>&gt; =0A&gt;<br>&gt; &gt; Currently, I am working in a set-up where MPC=
8540 is an agent, =0A<br>&gt; &gt; plugged into the PC host. I couldn't get=
 an IRQ for the card when =0A<br>&gt; &gt; plugged in some PCI slots, where=
as in one of the slots I do see a =0A<br>&gt; &gt; non-zero value.<br>&gt; =
&gt;<br>&gt; &gt; It would be great if you =0Acould help me understand the =
issue.<br>&gt; &gt;<br>&gt; &gt; I am sorry if the =0Aquestion is inapporpr=
iate in the group. I am <br>&gt; &gt; desperate to solve =0Athe issue.<br>&=
gt; &gt;<br>&gt; &gt; Thanks for any help.<br>&gt;<br>&gt; You =0Aneed to f=
ind out how the PCI edge interrupts are wired on you <br>&gt; board =0Athan=
 we can talk about how to generate an interrupt based on <br>&gt; =0Athat.&=
nbsp;&nbsp;I'd guess IRQ_OUT is wired to INTA, but it would be good to =0A<=
br>&gt; verify that.<br>&gt;<br>&gt; - k<br>&gt;<br>&gt; &gt; J.Joseph<br>&=
gt; =0A&gt;<br>&gt; &gt; ----- Original Message ----<br>&gt; &gt; From: Kum=
ar Gala =0A&lt;galak@kernel.crashing.org&gt;<br>&gt; &gt; To: Wang Matthew-=
R59995 =0A&lt;Qi.W@freescale.com&gt;<br>&gt; &gt; Cc: linuxppc-embedded@ozl=
abs.org<br>&gt; =0A&gt; Sent: Wednesday, 18 October, 2006 6:54:24 PM<br>&gt=
; &gt; Subject: Re: =0ALinuxppc-embedded Digest, Vol 26, Issue 36<br>&gt; &=
gt;<br>&gt; &gt;<br>&gt; =0A&gt; On Oct 18, 2006, at 8:10 PM, Wang Matthew-=
R59995 wrote:<br>&gt; =0A&gt;<br>&gt; &gt; &gt; Hi Kumar,<br>&gt; &gt; &gt;=
<br>&gt; &gt; &gt; Actually I =0Ado many trials about it. Vxwerks Bootrom i=
s smaller<br>&gt; than<br>&gt; &gt; =0A&gt; U-Boot. The key difference betw=
een Bootrom and U-boot is that some <br>&gt; =0A&gt; &gt; source code of Bo=
otrom is invisible to the users.<br>&gt; &gt; =0A&gt;<br>&gt; &gt; &gt; Act=
ually the rfi instruction which I point out is the =0Afirst rfi <br>&gt; &g=
t; &gt; instruction of Linux PowerPC bringup.<br>&gt; &gt; =0A&gt;<br>&gt; =
&gt; &gt; Before that, it's TLB entry invalidation and temp TLB =0Aentry<br=
>&gt; mapping.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; I check MMU setting =0Ac=
arefully before coming Linux Kernel.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; I =
just =0Awant to know if other guys met similar scenario like me. I <br>&gt;=
 &gt; &gt; =0Adon't need the precise answer, just overall suggestion about =
it<br>&gt; because =0AI<br>&gt; &gt; &gt; understand that not everyone has =
the same bootloader of =0Amine, that <br>&gt; &gt; &gt; bootloader is actua=
lly a customized =0Abootloader.<br>&gt; &gt;<br>&gt; &gt; I understand that=
, thus I was asking what =0Aexact problem you were <br>&gt; &gt; seeing to =
try and help.<br>&gt; =0A&gt;<br>&gt; &gt; &gt; Anyway thank you.<br>&gt; &=
gt; &gt;<br>&gt; &gt; &gt; R9 =0Apoint to LR register, mask the high 20 bit=
 of r9 and send to<br>&gt; r7,<br>&gt; =0A&gt; &gt; and<br>&gt; &gt; &gt; t=
hen add 24, which means stride 6 instructions =0Afor rfi instruction <br>&g=
t; &gt; &gt; execution.<br>&gt; &gt; &gt;<br>&gt; &gt; =0A&gt; Of course, r=
fi can switch the TLB entry, both the previous TLB <br>&gt; =0A&gt; &gt; en=
try and the temp TLB entry point to the same physical =0Aaddress.<br>&gt; &=
gt; &gt;<br>&gt; &gt; &gt; I've checked it.<br>&gt; =0A&gt;<br>&gt; &gt; I =
know what the code does, I wrote it :)<br>&gt; &gt;<br>&gt; =0A&gt; - kumar=
<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; =0A___________________=
____________________________<br>&gt; &gt; Linuxppc-embedded =0Amailing list=
<br>&gt; &gt; Linuxppc-embedded@ozlabs.org <br>&gt; &gt; <a rel=3D"nofollow=
" target=3D"_blank" href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-em=
bedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br>&gt; =
=0A&gt;<br>&gt; &gt;<br>&gt; &gt; Here's a new way to find what you're look=
ing for =0A- Yahoo! Answers<br>&gt;<br>&gt;<br>&gt;<br>&gt; Here's a new wa=
y to find what =0Ayou're looking for - Yahoo! =0AAnswers<br><br>___________=
____________________________________<br>Linuxppc-embedded =0Amailing list<b=
r>Linuxppc-embedded@ozlabs.org <a rel=3D"nofollow" target=3D"_blank" href=
=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.o=
rg/mailman/listinfo/linuxppc-embedded</a><br></div></div><br>=0A<div style=
=3D"font-family: times new roman,new york,times,serif; font-size: 12pt;"></=
div></div><br>=0A<hr size=3D"1">=0AHere=A2s a new way to find what you're l=
ooking for - <a rel=3D"nofollow" target=3D"_blank" href=3D"http://us.rd.yah=
oo.com/mail/in/yanswers/*http://in.answers.yahoo.com/">Yahoo! =0AAnswers</a=
> </div><br></div></div><br>=0A=09=0A=0A=09=0A=09=09<hr size=3D1></hr> =0AH=
ere=92s a new way to find what you're looking for - <a href=3D"http://us.rd=
.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/">Yahoo! Answers</=
a> </body></html>
--0-705913723-1169497662=:64959--
