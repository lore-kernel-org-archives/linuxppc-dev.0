Return-Path: <rdpatel55@yahoo.co.in>
Received: from n12-vm0.bullet.mail.in.yahoo.com
	(n12-vm0.bullet.mail.in.yahoo.com [202.86.4.246])
	by ozlabs.org (Postfix) with SMTP id 90781DE0A6
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 12:01:49 +1000 (EST)
Message-ID: <246420.44978.qm@web94801.mail.in2.yahoo.com>
Date: Thu, 21 May 2009 07:18:01 +0530 (IST)
From: patel rajendra <rdpatel55@yahoo.co.in>
Subject: problem in registering the device while inserting the kernel module
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1236608959-1242870481=:44978"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--0-1236608959-1242870481=:44978
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Members of linuxppc,
=A0
I'm working on XUPV2P board with Virtex II Pro FPGA device.
=A0
I written a kernel module for LED device. I got that module run successfuly=
 on ML403 board having Virtex 4 FPGA.I have not make any change in my sourc=
e code, because I don't feel any change is required.
=A0
On XUP board when I run "insmod xilinx_led.ko" command on my target board, =
I got following message.
=A0
# insmod xilinx_led.ko
Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
NIP: d1006190 LR: d1006188 CTR: 00000000
REGS: c0705db0 TRAP: 0300=A0=A0 Not tainted=A0 (2.6.23xlnx)
MSR: 00029030 <EE,ME,IR,DR>=A0 CR: 24000024=A0 XER: 00000000
DEAR: 0000004c, ESR: 00000000
TASK =3D c04c63d0[186] 'insmod' THREAD: c0704000
GPR00: d1006188 c0705e60 c04c63d0 00000000 000000d0 00000001 00000000 c0220=
ae0
GPR08: c006c60c 00000000 00000001 c04553f0 026f4bac 100b4260 d1003288 d1007=
668
GPR16: d1003288 d1003238 0000fff1 0000fff2 0000004c 00000000 d100762c c003e=
94c
GPR24: d1002e02 00000018 d1002000 00000019 d1000000 d1007598 d10077c8 00000=
000
NIP [d1006190] xilinx_ml403_led_setup+0x174/0x1dc [xilinx_led]
LR [d1006188] xilinx_ml403_led_setup+0x16c/0x1dc [xilinx_led]
Call Trace:
[c0705e60] [d1006188] xilinx_ml403_led_setup+0x16c/0x1dc [xilinx_led] (unre=
liable)
[c0705e90] [c0040be0] sys_init_module+0x120c/0x12f8
[c0705f40] [c0002c10] ret_from_syscall+0x0/0x3c
Instruction dump:
48000819 3d20d100 39297620 913f003c 93bf0040 3c800fc0 60840001 7fe3fb78
38a00001 48000805 813e0014 7c7f1b78 <80e9004c> 3c60d100 3c80d100 80bc77c8
=A0
Note: After above output when I execute "lsmod" command. I observed that le=
d device is tainted.
=A0
~ # lsmod
Module=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Size=A0 Used by=
=A0=A0=A0 Tainted: G
xilinx_led=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A06172=A0 1
~ #

=A0
What I understood from above message is that there is a problem in register=
ing the device in function xilinx_ml403_led_setup( ).=20
=A0
Anyone can help me out to solve this problem?
=A0
Rajendra=0A=0A=0A      Bollywood news, movie reviews, film trailers and mor=
e! Go to http://in.movies.yahoo.com/
--0-1236608959-1242870481=:44978
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><DIV>Hi Members of linuxppc,</DIV>
<DIV>&nbsp;</DIV>
<DIV>I'm working on XUPV2P board with Virtex II Pro FPGA device.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I written a kernel module for LED device. I got that module run succes=
sfuly on ML403 board having Virtex 4 FPGA.I have not make any change in my =
source code, because I don't feel any change is required.</DIV>
<DIV>&nbsp;</DIV>
<DIV>On XUP board when I run "insmod xilinx_led.ko" command on my target bo=
ard, I got following message.</DIV>
<DIV>&nbsp;</DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff># insmod xilinx_led.ko<?xml:namespace prefix =3D =
o ns =3D "urn:schemas-microsoft-com:office:office" /><o:p></o:p></FONT></SP=
AN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><B><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><FONT color=3D#0000ff>Oops: kernel access of bad area, sig: 11 [#1]<=
o:p></o:p></FONT></SPAN></B></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>PREEMPT<o:p></o:p></FONT></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>NIP: d1006190 LR: d1006188 CTR: 00000000<o:p></o:=
p></FONT></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>REGS: c0705db0 TRAP: 0300<SPAN style=3D"mso-space=
run: yes">&nbsp;&nbsp; </SPAN>Not tainted<SPAN style=3D"mso-spacerun: yes">=
&nbsp; </SPAN>(2.6.23xlnx)<o:p></o:p></FONT></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>MSR: 00029030 &lt;EE,ME,IR,DR&gt;<SPAN style=3D"m=
so-spacerun: yes">&nbsp; </SPAN>CR: 24000024<SPAN style=3D"mso-spacerun: ye=
s">&nbsp; </SPAN>XER: 00000000<o:p></o:p></FONT></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>DEAR: 0000004c, ESR: 00000000<o:p></o:p></FONT></=
SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>TASK =3D c04c63d0[186] 'insmod' THREAD: c0704000<=
o:p></o:p></FONT></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>GPR00: d1006188 c0705e60 c04c63d0 00000000 000000=
d0 00000001 00000000 c0220ae0<o:p></o:p></FONT></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>GPR08: c006c60c 00000000 00000001 c04553f0 026f4b=
ac 100b4260 d1003288 d1007668<o:p></o:p></FONT></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>GPR16: d1003288 d1003238 0000fff1 0000fff2 000000=
4c 00000000 d100762c c003e94c<o:p></o:p></FONT></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>GPR24: d1002e02 00000018 d1002000 00000019 d10000=
00 d1007598 d10077c8 00000000<o:p></o:p></FONT></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>NIP [d1006190] xilinx_ml403_led_setup+0x174/0x1dc=
 [xilinx_led]<o:p></o:p></FONT></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>LR [d1006188] xilinx_ml403_led_setup+0x16c/0x1dc =
[xilinx_led]<o:p></o:p></FONT></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>Call Trace:<o:p></o:p></FONT></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>[c0705e60] [d1006188] <STRONG>xilinx_ml403_led_se=
tup</STRONG>+0x16c/0x1dc [xilinx_led] <B>(unreliable)<o:p></o:p></B></FONT>=
</SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>[c0705e90] [c0040be0] sys_init_module+0x120c/0x12=
f8<o:p></o:p></FONT></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>[c0705f40] [c0002c10] ret_from_syscall+0x0/0x3c<o=
:p></o:p></FONT></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>Instruction dump:<o:p></o:p></FONT></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>48000819 3d20d100 39297620 913f003c 93bf0040 3c80=
0fc0 60840001 7fe3fb78<o:p></o:p></FONT></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>38a00001 48000805 813e0014 7c7f1b78 &lt;80e9004c&=
gt; 3c60d100 3c80d100 80bc77c8<o:p></o:p></FONT></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><o:p>&nbsp;</o:p></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al">Note: After above output when I execute "lsmod" command. I observed tha=
t led device is tainted.<o:p></o:p></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><o:p>&nbsp;</o:p></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>~ # lsmod<o:p></o:p></FONT></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>Module<SPAN style=3D"mso-spacerun: yes">&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; </SPAN>Size<SPAN style=3D"mso-spacerun: yes">&nbsp; </SP=
AN>Used by<SPAN style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </SPAN>Taint=
ed: G<o:p></o:p></FONT></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>xilinx_led<SPAN style=3D"mso-spacerun: yes">&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN><SPAN style=3D"mso-spacerun: yes">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</SPAN>6172<SPAN style=3D"mso-space=
run: yes">&nbsp; </SPAN>1<o:p></o:p></FONT></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt; mso-pagination: none; ms=
o-layout-grid-align: none"><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ari=
al"><FONT color=3D#0000ff>~ #<o:p></o:p></FONT></SPAN></DIV>
<DIV>
<DIV>&nbsp;</DIV></DIV>
<DIV>What I understood from above message is that there is a problem in reg=
istering the device in function <STRONG><FONT color=3D#0000ff>xilinx_ml403_=
led_setup( ). </FONT></STRONG></DIV>
<DIV><STRONG><FONT color=3D#0000ff></FONT></STRONG>&nbsp;</DIV>
<DIV><FONT color=3D#000000>Anyone can help me out to solve this problem?</F=
ONT></DIV>
<DIV>&nbsp;</DIV>
<DIV>Rajendra</DIV></td></tr></table><br>=0A=0A=0A      <!--1--><hr size=3D=
1></hr> Cricket on your mind? Visit the ultimate cricket website. <a href=
=3D"http://in.rd.yahoo.com/tagline_cricket_1/*http://beta.cricket.yahoo.com=
"> Enter now!</a>
--0-1236608959-1242870481=:44978--
