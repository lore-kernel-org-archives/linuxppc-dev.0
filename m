Return-Path: <junijoseph@yahoo.co.in>
Received: from web8415.mail.in.yahoo.com (web8415.mail.in.yahoo.com
	[202.43.219.103]) by ozlabs.org (Postfix) with SMTP id 19CBF67C23
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Nov 2006 06:00:12 +1100 (EST)
Message-ID: <20061106190010.58059.qmail@web8415.mail.in.yahoo.com>
Date: Tue, 7 Nov 2006 00:30:10 +0530 (IST)
From: agnel juni <junijoseph@yahoo.co.in>
Subject: Re: System ACE driver - for 2.6 kernel - issue resolved
To: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-499964483-1162839610=:56369"
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

--0-499964483-1162839610=:56369
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: quoted-printable

Hi Ameet,=0A=0AWe were able to get over with the unstability in the driver =
with the following fix in the code=0A=0AInstead of fixing the number of sec=
tors to be 2 in the loop, we are actually doing a read based on the kernel =
request  like this :=0A=0A for(i =3D xsa_cur_req->current_nr_sectors; i > 0=
; i-=3Dxsa_cur_req->current_nr_sectors ){=0A                        xsa_dev=
ice.req_done =3D 1;=0A                        while ((stat =3D cur_req(&Sys=
Ace, sector,=0A                                        xsa_cur_req->current=
_nr_sectors ,=0A                                        buffer)) =3D=3D XST=
_DEVICE_BUSY)=0A                                xsa_short_delay();=0A=0A=0A=
Now the driver is stable with all the filesystem commands.=0A=0APlease test=
 this out and if appropriate patch this to the driver code.=0A=0AThanks=0AJ=
unita=0A=0A----- Original Message ----=0AFrom: Ameet Patil <ammubhai@gmail.=
com>=0ATo: agnel juni <junijoseph@yahoo.co.in>=0ACc: linuxppc-embedded@ozla=
bs.org=0ASent: Thursday, 26 October, 2006 1:00:48 AM=0ASubject: Re: System =
ACE driver - for 2.6 kernel - need help to understand xsa_thread=0A=0AHi Ju=
nita,=0A    Its a hack really! When I was developing/porting the SysAce dri=
ver =0Ato 2.6 I tried to maintain the code as is from the 2.4 kernel driver=
. In =0Adoing so I found that there is a slight difference between the two =
=0Akernels. i.e. I am not sure why, but the sysace device can only handle =
=0Arequests for 2 sectors at a time. This was fine in the 2.4 as the kernel=
 =0Aalways requested 2 sectors. However, in 2.6 I found that this is =0Adif=
ferent: the requests are 8 secs. or more. I tried to fix this in vain =0Aby=
 changing several parameters of the driver during initialization. =0AAnyway=
, due to several issues I didn't try hard to fix it at that time.=0A=0AHenc=
e this hack: No matter how many sec. req. I get from the kernel, I =0Ause a=
 loop to req. only 2 secs. at a time. The xsa_device.req_done is =0Aused as=
 a flag and reset in the XSA IRQ IIRC.=0A=0AIf you find a better approach, =
please do update me. Hope this helps!=0A=0Acheers,=0A-Ameet=0A=0Aagnel juni=
 wrote:=0A> =0A> Hello all=0A> =0A> I am trying to understand the parameter=
s that are sent through "cur_req" =0A> function used in funtion xsa_thread =
in System ACE driver.=0A> =0A> In xsa_thread function in the System ACE dri=
ver ,=0A> =0A> In 2.4 kernel:=0A> --------------------=0A> while ((stat =3D=
 cur_req(&SysAce, sector,=0A>                                        CURREN=
T->current_nr_sectors,=0A>                                        CURRENT->=
buffer)) =3D=3D XST_DEVICE_BUSY)=0A>                         xsa_short_dela=
y();=0A> =0A>  =0A> Where as in 2.6 kernel this is changed to=0A> ---------=
------------------------------------------------------=0A> =0A> for(i =3D x=
sa_cur_req->current_nr_sectors; i > 0; i-=3D2){=0A>                        =
 xsa_device.req_done =3D 1;=0A>                         while ((stat =3D cu=
r_req(&SysAce, sector,=0A>                                         2,=0A>  =
                                       buffer)) =3D=3D XST_DEVICE_BUSY)=0A>=
                                 xsa_short_delay();=0A> #endif=0A> =0A> Ame=
et , could you help me understand the impact of the parameters, =0A> especa=
illy the 3rd paramter which is hardcoded in 2.6 kernel.It would be =0A> gre=
at if you could clarify this in regard to 'mount' command.=0A> =0A> Thanks =
in advance=0A> Junita=0A> =0A> =0A> =0A> ----------------------------------=
--------------------------------------=0A> Find out what India is talking a=
bout on - Yahoo! Answers India =0A> <http://us.rd.yahoo.com/mail/in/yanswer=
s/*http://in.answers.yahoo.com/>=0A> Send FREE SMS to your friend's mobile =
from Yahoo! Messenger Version 8. =0A> Get it NOW =0A> <http://us.rd.yahoo.c=
om/mail/in/messengertagline/*http://in.messenger.yahoo.com> =0A> =0A=0A=0A=
=0A=0A=0A=0A=0A=09=09=0A___________________________________________________=
_______=0AYahoo! India Answers: Share what you know. Learn something new=0A=
http://in.answers.yahoo.com/
--0-499964483-1162839610=:56369
Content-Type: text/html; charset=ascii
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 12pt;">Hi Ameet,<br><br>We were able to get over with the =
unstability in the driver with the following fix in the code<br><br>Instead=
 of fixing the number of sectors to be 2 in the loop, we are actually doing=
 a read based on the kernel request&nbsp; like this :<br><br>&nbsp;for(i =
=3D xsa_cur_req-&gt;current_nr_sectors; i &gt; 0; i-=3D<span style=3D"font-=
weight: bold;">xsa_cur_req-&gt;current_nr_sectors </span>){<br>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xsa_device.req_done =3D=
 1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; whil=
e ((stat =3D
 cur_req(&amp;SysAce, sector,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style=3D"font-weight: bold=
;">xsa_cur_req-&gt;current_nr_sectors</span> ,<br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer)) =3D=3D=
 XST_DEVICE_BUSY)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xsa_short_delay()=
;<br><br><br>Now the driver is stable with all the filesystem commands.<br>=
<br>Please test this out and if appropriate patch this to the driver
 code.<br><br>Thanks<br>Junita<br><br><div style=3D"font-family: times new =
roman,new york,times,serif; font-size: 12pt;">----- Original Message ----<b=
r>From: Ameet Patil &lt;ammubhai@gmail.com&gt;<br>To: agnel juni &lt;junijo=
seph@yahoo.co.in&gt;<br>Cc: linuxppc-embedded@ozlabs.org<br>Sent: Thursday,=
 26 October, 2006 1:00:48 AM<br>Subject: Re: System ACE driver - for 2.6 ke=
rnel - need help to understand xsa_thread<br><br><div>Hi Junita,<br>&nbsp;&=
nbsp;&nbsp;&nbsp;Its a hack really! When I was developing/porting the SysAc=
e driver <br>to 2.6 I tried to maintain the code as is from the 2.4 kernel =
driver. In <br>doing so I found that there is a slight difference between t=
he two <br>kernels. i.e. I am not sure why, but the sysace device can only =
handle <br>requests for 2 sectors at a time. This was fine in the 2.4 as th=
e kernel <br>always requested 2 sectors. However, in 2.6 I found that this =
is <br>different: the requests are 8 secs. or more. I tried to fix this in =
vain <br>by
 changing several parameters of the driver during initialization. <br>Anywa=
y, due to several issues I didn't try hard to fix it at that time.<br><br>H=
ence this hack: No matter how many sec. req. I get from the kernel, I <br>u=
se a loop to req. only 2 secs. at a time. The xsa_device.req_done is <br>us=
ed as a flag and reset in the XSA IRQ IIRC.<br><br>If you find a better app=
roach, please do update me. Hope this helps!<br><br>cheers,<br>-Ameet<br><b=
r>agnel juni wrote:<br>&gt; <br>&gt; Hello all<br>&gt; <br>&gt; I am trying=
 to understand the parameters that are sent through "cur_req" <br>&gt; func=
tion used in funtion xsa_thread in System ACE driver.<br>&gt; <br>&gt; In x=
sa_thread function in the System ACE driver ,<br>&gt; <br>&gt; In 2.4 kerne=
l:<br>&gt; --------------------<br>&gt; while ((stat =3D cur_req(&amp;SysAc=
e,
 sector,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CURRENT-&gt;current_nr_sectors,<br>&gt;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;CURRENT-&gt;buffer)) =3D=3D XST_DEVICE_BUSY)<br>&gt;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xsa_short_delay();=
<br>&gt; <br>&gt;&nbsp;&nbsp;<br>&gt; Where as in 2.6 kernel this is change=
d to<br>&gt; --------------------------------------------------------------=
-<br>&gt; <br>&gt; for(i =3D xsa_cur_req-&gt;current_nr_sectors; i &gt; 0;
 i-=3D2){<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; xsa_device.req_done =3D 1;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while ((stat =3D cur_req(&amp;SysA=
ce, sector,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer)) =3D=
=3D
 XST_DEVICE_BUSY)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xsa_sho=
rt_delay();<br>&gt; #endif<br>&gt; <br>&gt; Ameet , could you help me under=
stand the impact of the parameters, <br>&gt; especailly the 3rd paramter wh=
ich is hardcoded in 2.6 kernel.It would be <br>&gt; great if you could clar=
ify this in regard to 'mount' command.<br>&gt; <br>&gt; Thanks in advance<b=
r>&gt; Junita<br>&gt; <br>&gt; <br>&gt; <br>&gt; --------------------------=
----------------------------------------------<br>&gt; Find out what India =
is talking about on - Yahoo! Answers India <br>&gt; &lt;<a target=3D"_blank=
" href=3D"http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.=
com/">http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/=
</a>&gt;<br>&gt; Send FREE SMS to your friend's mobile from Yahoo! Messenge=
r Version 8.
 <br>&gt; Get it NOW <br>&gt; &lt;<a target=3D"_blank" href=3D"http://us.rd=
.yahoo.com/mail/in/messengertagline/*http://in.messenger.yahoo.com">http://=
us.rd.yahoo.com/mail/in/messengertagline/*http://in.messenger.yahoo.com</a>=
&gt; <br>&gt; <br></div></div><br></div></div><br>=0A=09=0A=0A=09=0A=09=09<=
hr size=3D1></hr> =0AFind out what India is talking about on  - <a href=3D"=
http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/">Yaho=
o! Answers India</a> <BR> =0ASend FREE SMS to your friend's mobile from Yah=
oo! Messenger Version 8. <a href=3D"http://us.rd.yahoo.com/mail/in/messenge=
rtagline/*http://in.messenger.yahoo.com">Get it NOW</a></body></html>
--0-499964483-1162839610=:56369--
