Return-Path: <junijoseph@yahoo.co.in>
Received: from web8401.mail.in.yahoo.com (web8401.mail.in.yahoo.com
	[202.43.219.149]) by ozlabs.org (Postfix) with SMTP id 4920367E0D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Oct 2006 07:58:50 +1000 (EST)
Message-ID: <20061005215848.94147.qmail@web8401.mail.in.yahoo.com>
Date: Fri, 6 Oct 2006 03:28:48 +0530 (IST)
From: agnel juni <junijoseph@yahoo.co.in>
Subject: Re: linux-2.6 system ACE driver - need help
To: "Grenier, Jim" <James.Grenier@adc.com>, linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-993843009-1160085528=:93258"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-993843009-1160085528=:93258
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: quoted-printable

Hello Jim,=0A=0AThanks for your reply.=0A=0AI did try the option you have p=
ropsed. Though didn't help me its good to know.=0A=0AThe driver behaves the=
 same way when put in polling mode also.=0A=0Athanks very much=0AJunita=0A=
=0A----- Original Message ----=0AFrom: "Grenier, Jim" <James.Grenier@adc.co=
m>=0ATo: linuxppc-embedded@ozlabs.org=0ASent: Tuesday, 3 October, 2006 3:31=
:03 PM=0ASubject: linux-2.6 system ACE driver - need help=0A=0A> Hi Jeff,=
=0A> =0A> Thanks for your reply.=0A> =0A> > Does it work for you in polling=
 mode?  If not, you probably have a=0A> problem with the way you are access=
ing the system ace - cache,=0A> endianess, byte alignment, etc.  If it does=
 work in polling, the usual=0A> suspects are interrupt masking errors or so=
me low level problems with=0A> your IRQ signals.  Since you know the size o=
f a sector and the size of=0A> the sysace buffers, how many interrupts do y=
ou get per sector read?=0ADo=0A> you see extras or not enough?=0A> =0A> I h=
eard from Ameet Patil that this driver is not tested in poilling=0Amode and=
 it failed when we tried also.=0A> Thats when we moved to interrupt mode. =
=0A> =0A> I did check for the endianess...byte alignment etc.It looks ok to=
 me.=0A> =0A> I am using a 64 MB flash. And the sector sice is 512K.When th=
e kernel=0Aboots up I see 128 interrupts getting registered. (I think its f=
rom=0Aalloc_disk(16) function in adapter.c )=0A> =0A> Seems like the driver=
 has issues with completing the request.=0A> =0A> We are having issues whil=
e mouting the device. It is erratic, that=0Asometimes we are able to mount/=
list files, copy files.=0A> =0A> But sometimes the kernel crashes and gives=
 a Ooops message like :=0A> =0A> /*****************************************=
****************/=0A> =0A> # ls /mnt/Oops: kernel access of bad area, sig: =
11 [#1]=0A> NIP: C00556B8 LR: C00557E4 CTR: 00000000=0A> REGS: dfec1e08 TRA=
P: 0300   Not tainted  (2.6.16.2)=0A> MSR: 00021000 <ME>  CR: 22128828  XER=
: 00000000=0A> DAR: 30303030, DSISR: 00800000=0A> TASK GPR00: 00100100 DFEC=
1EB8 DFF6C030 C0258C60 DFF7BE10 00000018=0ADF4E9000 C0256D60=0A> GPR08: 303=
03030 00200200 DF4E9154 30303030 22128888 00100400 1FFB9700=0A00000000=0A> =
GPR16: 00000001 FFFFFFFF 00000000 007FFF00 1FFB3604 1FF63CE0 1FFCEF78=0AC01=
F0000=0A> GPR24: C0240000 00100100 C0240000 00000000 DFF7BE10 00000018 0000=
0000=0AC0258C60=0A> NIP [C00556B8] free_block+0xa8/0x148=0A> LR [C00557E4] =
drain_array_locked+0x8c/0xd8=0A> Call Trace:=0A> [DFEC1EB8] [DFCA9490] 0xdf=
ca9490 (unreliable)=0A> [DFEC1ED8] [C00557E4] drain_array_locked+0x8c/0xd8=
=0A> [DFEC1EF0] [C0056F80] cache_reap+0x74/0x18c=0A> [DFEC1F28] [C002B578] =
run_workqueue+0x9c/0x110=0A> [DFEC1F48] [C002B6E4] worker_thread+0xf8/0x13c=
=0A> [DFEC1FC0] [C002F6F0] kthread+0xf4/0x130=0A> [DFEC1FF0] [C000413C] ker=
nel_thread+0x44/0x60=0A> Instruction dump:=0A> 7cfbfa14 3c000010 80e70014 3=
d2a4000 60000100 5529c9f4 7d295a14=0A80c9001c=0A> 3d200020 61290200 8106000=
4 81660000 <91680000> 910b0004 3966001c=0A90060000=0A> BUG: events/0/4, loc=
k held at task exit time!=0A>  [c01f5d60] {cache_chain_mutex}=0A> .. held b=
y:          events/0:    4 [dff6c030, 110]=0A> ... acquired at:            =
   cache_reap+0x1c/0x18c=0A> /*********************************************=
**********************/=0A>=0A>=0A> We are able to do this after modiifying=
 the file=0Axsysace_compactflash.c and xsysace_intr.c  to reset the control=
ler( It=0Awas commented out by applying the patch).=0A> =0A> The data in th=
e CF looks sane.=0A>=0A> Please advise.=0A>=0A> Thanks for your help.=0A>=
=0A>=0A> Thanks=0A> Junita=0A=0AI have run into a problem with random crash=
es with System ACE on a=0Acustom board.=0AIt turned out that sometimes the =
System ACE chip would generate an extra=0Ainterrupt=0Aafter a write operati=
on completed. The ISR in the driver is dumb and=0Aassumes a transfer=0Ajust=
 completed. This messed up the empty read/write queue for the=0Adevice.=0A=
=0AI was working on a 2.4.17 kernel, so I don't know if it applies to you.=
=0AThe quick fix was to ignore these extra interrupts. I changed the line=
=0Ain xsysace_intr.c from:=0A=0A    if (StatusReg & XSA_SR_DATABUFRDY_MASK)=
 {=0A=0Ato:=0A=0A    if ( (StatusReg & XSA_SR_DATABUFRDY_MASK) &&=0A       =
             (XSysAce_mGetControlReg(AcePtr->BaseAddress) &=0A             =
        XSA_CR_DATARDYIRQ_MASK) ) {=0A=0AWith this change, the driver will =
generate a transfer complete event=0Aonly if a transfer was in progress.=0A=
=0AHope this helps.=0A=0AJim Grenier=0A=0A=0A______________________________=
_________________=0ALinuxppc-embedded mailing list=0ALinuxppc-embedded@ozla=
bs.org=0Ahttps://ozlabs.org/mailman/listinfo/linuxppc-embedded=0A=0A=0A=0A=
=0A=0A=0A=0A=09=09=0A______________________________________________________=
____=0AYahoo! India Answers: Share what you know. Learn something new=0Ahtt=
p://in.answers.yahoo.com/
--0-993843009-1160085528=:93258
Content-Type: text/html; charset=ascii
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 12pt;">Hello Jim,<br><br>Thanks for your reply.<br><br>I d=
id try the option you have propsed. Though didn't help me its good to know.=
<br><br>The driver behaves the same way when put in polling mode also.<br><=
br>thanks very much<br>Junita<br><br><div style=3D"font-family: times new r=
oman,new york,times,serif; font-size: 12pt;">----- Original Message ----<br=
>From: "Grenier, Jim" &lt;James.Grenier@adc.com&gt;<br>To: linuxppc-embedde=
d@ozlabs.org<br>Sent: Tuesday, 3 October, 2006 3:31:03 PM<br>Subject: linux=
-2.6 system ACE driver - need help<br><br><div>&gt; Hi Jeff,<br>&gt; <br>&g=
t; Thanks for your reply.<br>&gt; <br>&gt; &gt; Does it work for you in pol=
ling mode?&nbsp;&nbsp;If not, you probably have a<br>&gt; problem with the =
way you are accessing
 the system ace - cache,<br>&gt; endianess, byte alignment, etc.&nbsp;&nbsp=
;If it does work in polling, the usual<br>&gt; suspects are interrupt maski=
ng errors or some low level problems with<br>&gt; your IRQ signals.&nbsp;&n=
bsp;Since you know the size of a sector and the size of<br>&gt; the sysace =
buffers, how many interrupts do you get per sector read?<br>Do<br>&gt; you =
see extras or not enough?<br>&gt; <br>&gt; I heard from Ameet Patil that th=
is driver is not tested in poilling<br>mode and it failed when we tried als=
o.<br>&gt; Thats when we moved to interrupt mode. <br>&gt; <br>&gt; I did c=
heck for the endianess...byte alignment etc.It looks ok to me.<br>&gt; <br>=
&gt; I am using a 64 MB flash. And the sector sice is 512K.When the kernel<=
br>boots up I see 128 interrupts getting registered. (I think its from<br>a=
lloc_disk(16) function in adapter.c )<br>&gt; <br>&gt; Seems like the drive=
r has issues with completing the request.<br>&gt; <br>&gt; We are having is=
sues while
 mouting the device. It is erratic, that<br>sometimes we are able to mount/=
list files, copy files.<br>&gt; <br>&gt; But sometimes the kernel crashes a=
nd gives a Ooops message like :<br>&gt; <br>&gt; /*************************=
********************************/<br>&gt; <br>&gt; # ls /mnt/Oops: kernel a=
ccess of bad area, sig: 11 [#1]<br>&gt; NIP: C00556B8 LR: C00557E4 CTR: 000=
00000<br>&gt; REGS: dfec1e08 TRAP: 0300&nbsp;&nbsp; Not tainted&nbsp;&nbsp;=
(2.6.16.2)<br>&gt; MSR: 00021000 &lt;ME&gt;&nbsp;&nbsp;CR: 22128828&nbsp;&n=
bsp;XER: 00000000<br>&gt; DAR: 30303030, DSISR: 00800000<br>&gt; TASK GPR00=
: 00100100 DFEC1EB8 DFF6C030 C0258C60 DFF7BE10 00000018<br>DF4E9000 C0256D6=
0<br>&gt; GPR08: 30303030 00200200 DF4E9154 30303030 22128888 00100400 1FFB=
9700<br>00000000<br>&gt; GPR16: 00000001 FFFFFFFF 00000000 007FFF00 1FFB360=
4 1FF63CE0 1FFCEF78<br>C01F0000<br>&gt; GPR24: C0240000 00100100 C0240000 0=
0000000 DFF7BE10 00000018 00000000<br>C0258C60<br>&gt; NIP [C00556B8]
 free_block+0xa8/0x148<br>&gt; LR [C00557E4] drain_array_locked+0x8c/0xd8<b=
r>&gt; Call Trace:<br>&gt; [DFEC1EB8] [DFCA9490] 0xdfca9490 (unreliable)<br=
>&gt; [DFEC1ED8] [C00557E4] drain_array_locked+0x8c/0xd8<br>&gt; [DFEC1EF0]=
 [C0056F80] cache_reap+0x74/0x18c<br>&gt; [DFEC1F28] [C002B578] run_workque=
ue+0x9c/0x110<br>&gt; [DFEC1F48] [C002B6E4] worker_thread+0xf8/0x13c<br>&gt=
; [DFEC1FC0] [C002F6F0] kthread+0xf4/0x130<br>&gt; [DFEC1FF0] [C000413C] ke=
rnel_thread+0x44/0x60<br>&gt; Instruction dump:<br>&gt; 7cfbfa14 3c000010 8=
0e70014 3d2a4000 60000100 5529c9f4 7d295a14<br>80c9001c<br>&gt; 3d200020 61=
290200 81060004 81660000 &lt;91680000&gt; 910b0004 3966001c<br>90060000<br>=
&gt; BUG: events/0/4, lock held at task exit time!<br>&gt;&nbsp;&nbsp;[c01f=
5d60] {cache_chain_mutex}<br>&gt; .. held by:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;events/0:&nbsp;&nbsp;&nbsp;&nbsp;4 [dff6c030,=
 110]<br>&gt; ... acquired
 at:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; cache_reap+0x1c/0x18c<br>&gt; /******************************=
*************************************/<br>&gt;<br>&gt;<br>&gt; We are able =
to do this after modiifying the file<br>xsysace_compactflash.c and xsysace_=
intr.c&nbsp;&nbsp;to reset the controller( It<br>was commented out by apply=
ing the patch).<br>&gt; <br>&gt; The data in the CF looks sane.<br>&gt;<br>=
&gt; Please advise.<br>&gt;<br>&gt; Thanks for your help.<br>&gt;<br>&gt;<b=
r>&gt; Thanks<br>&gt; Junita<br><br>I have run into a problem with random c=
rashes with System ACE on a<br>custom board.<br>It turned out that sometime=
s the System ACE chip would generate an extra<br>interrupt<br>after a write=
 operation completed. The ISR in the driver is dumb and<br>assumes a transf=
er<br>just completed. This messed up the empty read/write queue for the<br>=
device.<br><br>I was working on a 2.4.17 kernel, so I don't know if it appl=
ies to
 you.<br>The quick fix was to ignore these extra interrupts. I changed the =
line<br>in xsysace_intr.c from:<br><br>&nbsp;&nbsp;&nbsp;&nbsp;if (StatusRe=
g &amp; XSA_SR_DATABUFRDY_MASK) {<br><br>to:<br><br>&nbsp;&nbsp;&nbsp;&nbsp=
;if ( (StatusReg &amp; XSA_SR_DATABUFRDY_MASK) &amp;&amp;<br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(XSysAce_mGetControlReg(AcePtr-&gt;BaseAddre=
ss) &amp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; XSA_CR_DATARDYIR=
Q_MASK) ) {<br><br>With this change, the driver will generate a transfer co=
mplete event<br>only if a transfer was in progress.<br><br>Hope this helps.=
<br><br>Jim Grenier<br><br><br>____________________________________________=
___<br>Linuxppc-embedded mailing list<br>Linuxppc-embedded@ozlabs.org<br><a=
 target=3D"_blank"
 href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozl=
abs.org/mailman/listinfo/linuxppc-embedded</a><br></div></div><br></div></d=
iv><br>=0A=09=0A=0A=09=0A=09=09<hr size=3D1></hr> =0AFind out what India is=
 talking about on  - <a href=3D"http://us.rd.yahoo.com/mail/in/yanswers/*ht=
tp://in.answers.yahoo.com/">Yahoo! Answers India</a> <BR> =0ASend FREE SMS =
to your friend's mobile from Yahoo! Messenger Version 8. <a href=3D"http://=
us.rd.yahoo.com/mail/in/messengertagline/*http://in.messenger.yahoo.com">Ge=
t it NOW</a></body></html>
--0-993843009-1160085528=:93258--
