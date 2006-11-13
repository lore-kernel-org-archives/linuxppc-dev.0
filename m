Return-Path: <aniket_spce@yahoo.com>
Received: from web50703.mail.yahoo.com (web50703.mail.yahoo.com
	[206.190.38.101]) by ozlabs.org (Postfix) with SMTP id D007767E51
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 10:40:22 +1100 (EST)
Message-ID: <20061113233340.65403.qmail@web50703.mail.yahoo.com>
Date: Mon, 13 Nov 2006 15:33:40 -0800 (PST)
From: "Aniket D." <aniket_spce@yahoo.com>
Subject: RTC DS1340 on MPC 8245 - problem
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2075033525-1163460820=:64193"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-2075033525-1163460820=:64193
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

=0AProblem:=0A=0AWhen processor dependent macros are =0Aset to use RTC ie (=
ppc_md.set_rtc_time =3D mydriver_set_rtc; ppc_md.get_rtc_time =3D =0Amydriv=
er_get_rtc_time;), then the scheduler gets messed up and prints a message =
=0A=93scheduling when atomic=94.=0A=0ASystem time is not synced to RTC =0At=
ime.=0A=0A =0A=0ADetails:=0A=0AProcessor: =0AMPC8245=0A=0AKernel version: L=
inux =0A2.6.14=0A=0ARTC chip: DS1340 (I2c =0Abased)=0A=0ADriver used: Stand=
ard kernel version =0A2.6.17 or later has a driver for RTC DS1340. I ported=
 it to work with our =0Aversion of the kernel. So it is the driver provided=
 by later version of the =0Astandard kernel.=0A=0A =0A=0AI have added the d=
river and the read =0Aand write to the RTC works fine. Time that is set to =
the rtc remains on the RTC =0Aeven through successive reboots. So the drive=
r is working =0Afine.=0A=0AHowever we needed to sync the system =0Atime wit=
h the RTC. For this purpose, I tried to use the drivers/rtc/hctosys.c =0Aco=
de. This code reads the time from the RTC during bootup, and does a =0Ado_s=
ettimeofday so that system time reflects the time in the RTC. However, with=
 =0Athis change, as soon as settimeofday happens, I read it back, it displa=
ys the =0Acorrect time (same as RTC), but after system boots up, the system=
 time is messed =0Aup again. =0A=0A =0A=0AAnother thing that I changed was =
the =0Appc_md.get_rtc_time and ppc_md.set_rtc_time =96 these function point=
ers were =0Apointed to my driver=92s get_rtc_time and =0Aset_rtc_time.=0A=
=0A =0A=0AIn the same function, =0Appc_md.calibrate_decr is set to initiali=
ze the decrementer register. However the =0Appc_md.time_init has still not =
been set. I looked up MPC8349 example and they =0Aare enabling the =91time =
base=92 in this function. However for 8245 the time base =0Aenable is not a=
 bit in a register, but it is a signal. So does the =0Appc_md.time_init nee=
d to be pointed to some function =96 what should that function =0Ado? Is it=
 needed at all?=0A=0AAlso, having set the =0Appc_md.calibrate_decr, ppc_md.=
get_rtc_time and ppc_md.set_rtc_time, when the =0Asystem boots up, the sche=
duler prints a message that says =93scheduling when =0Aatomic=94 and the sy=
stem doesn=92t boot beyond this =0Apoint.=0A=0A =0A=0AI have set these ppc_=
md function =0Apointers late during the bootup because it depends on initia=
lization of the RTC =0Adriver before these pointers are set. =0A=0A =0A=0AN=
ow as I understand, before the RTC =0Ais available, the processor uses the =
decrementer register to keep time for the =0Ascheduler. When the ppc_md.get=
/set_rtc_time are set, the processor starts using =0Athe RTC to keep time. =
However the point where the handover from decrementer to =0ARTC happens is =
the point where the scheduler gets messed up. =0A=0A=0A =0A=0ACan you pleas=
e guide me as to what =0Ais the right way for me to use the RTC. Which are =
the places other than the =0Adriver that I need to modify/add?=0A=0A =0A=0A=
Thanks,=0A=0AAniket.=0A=0A=0A=0A=0A=0A =0A_________________________________=
___________________________________________________=0ADo you Yahoo!?=0AEver=
yone is raving about the all-new Yahoo! Mail beta.=0Ahttp://new.mail.yahoo.=
com
--0-2075033525-1163460820=:64193
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div><div class=3D"Section1">=0A<p class=3D"MsoNormal"><fon=
t face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-family: Ar=
ial;">Problem:<o:p></o:p></span></font></p>=0A<p class=3D"MsoNormal"><font =
face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-family: Aria=
l;">When processor dependent macros are =0Aset to use RTC ie (ppc_md.set_rt=
c_time =3D mydriver_set_rtc; ppc_md.get_rtc_time =3D =0Amydriver_get_rtc_ti=
me;), then the scheduler gets messed up and prints a message =0A=93scheduli=
ng when atomic=94.<o:p></o:p></span></font></p>=0A<p class=3D"MsoNormal"><f=
ont face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-family: =
Arial;">System time is not synced to RTC =0Atime.<o:p></o:p></span></font><=
/p>=0A<p class=3D"MsoNormal"><font face=3D"Arial" size=3D"2"><span style=3D=
"font-size: 10pt; font-family: Arial;"><o:p>&nbsp;</o:p></span></font></p>=
=0A<p class=3D"MsoNormal"><font face=3D"Arial" size=3D"2"><span style=3D"fo=
nt-size: 10pt; font-family: Arial;">Details:<o:p></o:p></span></font></p>=
=0A<p class=3D"MsoNormal"><font face=3D"Arial" size=3D"2"><span style=3D"fo=
nt-size: 10pt; font-family: Arial;">Processor: =0AMPC8245<o:p></o:p></span>=
</font></p>=0A<p class=3D"MsoNormal"><font face=3D"Arial" size=3D"2"><span =
style=3D"font-size: 10pt; font-family: Arial;">Kernel version: Linux =0A2.6=
.14<o:p></o:p></span></font></p>=0A<p class=3D"MsoNormal"><font face=3D"Ari=
al" size=3D"2"><span style=3D"font-size: 10pt; font-family: Arial;">RTC chi=
p: DS1340 (I2c =0Abased)<o:p></o:p></span></font></p>=0A<p class=3D"MsoNorm=
al"><font face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-fa=
mily: Arial;">Driver used: Standard kernel version =0A2.6.17 or later has a=
 driver for RTC DS1340. I ported it to work with our =0Aversion of the kern=
el. So it is the driver provided by later version of the =0Astandard kernel=
.<o:p></o:p></span></font></p>=0A<p class=3D"MsoNormal"><font face=3D"Arial=
" size=3D"2"><span style=3D"font-size: 10pt; font-family: Arial;"><o:p>&nbs=
p;</o:p></span></font></p>=0A<p class=3D"MsoNormal"><font face=3D"Arial" si=
ze=3D"2"><span style=3D"font-size: 10pt; font-family: Arial;">I have added =
the driver and the read =0Aand write to the RTC works fine. Time that is se=
t to the rtc remains on the RTC =0Aeven through successive reboots. So the =
driver is working =0Afine.<o:p></o:p></span></font></p>=0A<p class=3D"MsoNo=
rmal"><font face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-=
family: Arial;">However we needed to sync the system =0Atime with the RTC. =
For this purpose, I tried to use the drivers/rtc/hctosys.c =0Acode. This co=
de reads the time from the RTC during bootup, and does a =0Ado_settimeofday=
 so that system time reflects the time in the RTC. However, with =0Athis ch=
ange, as soon as settimeofday happens, I read it back, it displays the =0Ac=
orrect time (same as RTC), but after system boots up, the system time is me=
ssed =0Aup again. <o:p></o:p></span></font></p>=0A<p class=3D"MsoNormal"><f=
ont face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-family: =
Arial;"><o:p>&nbsp;</o:p></span></font></p>=0A<p class=3D"MsoNormal"><font =
face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-family: Aria=
l;">Another thing that I changed was the =0Appc_md.get_rtc_time and ppc_md.=
set_rtc_time =96 these function pointers were =0Apointed to my driver=92s g=
et_rtc_time and =0Aset_rtc_time.<o:p></o:p></span></font></p>=0A<p class=3D=
"MsoNormal"><font face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt;=
 font-family: Arial;"><o:p>&nbsp;</o:p></span></font></p>=0A<p class=3D"Mso=
Normal"><font face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; fon=
t-family: Arial;">In the same function, =0Appc_md.calibrate_decr is set to =
initialize the decrementer register. However the =0Appc_md.time_init has st=
ill not been set. I looked up MPC8349 example and they =0Aare enabling the =
=91time base=92 in this function. However for 8245 the time base =0Aenable =
is not a bit in a register, but it is a signal. So does the =0Appc_md.time_=
init need to be pointed to some function =96 what should that function =0Ad=
o? Is it needed at all?<o:p></o:p></span></font></p>=0A<p class=3D"MsoNorma=
l"><font face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-fam=
ily: Arial;">Also, having set the =0Appc_md.calibrate_decr, ppc_md.get_rtc_=
time and ppc_md.set_rtc_time, when the =0Asystem boots up, the scheduler pr=
ints a message that says =93scheduling when =0Aatomic=94 and the system doe=
sn=92t boot beyond this =0Apoint.<o:p></o:p></span></font></p>=0A<p class=
=3D"MsoNormal"><font face=3D"Arial" size=3D"2"><span style=3D"font-size: 10=
pt; font-family: Arial;"><o:p>&nbsp;</o:p></span></font></p>=0A<p class=3D"=
MsoNormal"><font face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; =
font-family: Arial;">I have set these ppc_md function =0Apointers late duri=
ng the bootup because it depends on initialization of the RTC =0Adriver bef=
ore these pointers are set. <o:p></o:p></span></font></p>=0A<p class=3D"Mso=
Normal"><font face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; fon=
t-family: Arial;"><o:p>&nbsp;</o:p></span></font></p>=0A<p class=3D"MsoNorm=
al"><font face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-fa=
mily: Arial;">Now as I understand, before the RTC =0Ais available, the proc=
essor uses the decrementer register to keep time for the =0Ascheduler. When=
 the ppc_md.get/set_rtc_time are set, the processor starts using =0Athe RTC=
 to keep time. However the point where the handover from decrementer to =0A=
RTC happens is the point where the scheduler gets messed up. =0A<o:p></o:p>=
</span></font></p>=0A<p class=3D"MsoNormal"><font face=3D"Arial" size=3D"2"=
><span style=3D"font-size: 10pt; font-family: Arial;"><o:p>&nbsp;</o:p></sp=
an></font></p>=0A<p class=3D"MsoNormal"><font face=3D"Arial" size=3D"2"><sp=
an style=3D"font-size: 10pt; font-family: Arial;">Can you please guide me a=
s to what =0Ais the right way for me to use the RTC. Which are the places o=
ther than the =0Adriver that I need to modify/add?<o:p></o:p></span></font>=
</p>=0A<p class=3D"MsoNormal"><font face=3D"Arial" size=3D"2"><span style=
=3D"font-size: 10pt; font-family: Arial;"><o:p>&nbsp;</o:p></span></font></=
p>=0A<p class=3D"MsoNormal"><font face=3D"Arial" size=3D"2"><span style=3D"=
font-size: 10pt; font-family: Arial;">Thanks,<o:p></o:p></span></font></p>=
=0A<p class=3D"MsoNormal"><font face=3D"Arial" size=3D"2"><span style=3D"fo=
nt-size: 10pt; font-family: Arial;">Aniket.<o:p></o:p></span></font></p></d=
iv></div></div><br>=0A=0A<hr size=3D1>Want to start your own business? Lear=
n how on <a href=3D"http://us.rd.yahoo.com/evt=3D41244/*http://smallbusines=
s.yahoo.com/r-index">Yahoo! Small Business.</a></body></html>
--0-2075033525-1163460820=:64193--
