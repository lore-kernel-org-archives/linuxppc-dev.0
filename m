Return-Path: <s104259@yahoo.it>
Received: from web23103.mail.ird.yahoo.com (web23103.mail.ird.yahoo.com
	[217.146.189.43]) by ozlabs.org (Postfix) with SMTP id 78937DDDEE
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 07:29:59 +1100 (EST)
Date: Fri, 5 Dec 2008 20:29:57 +0000 (GMT)
From: Angelo <s104259@yahoo.it>
Subject: Re: R: Installation on a MPC5200 based custom board
To: Juergen Beisert <jbe@pengutronix.de>, Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910812051133v2b14f698k6165834d55037888@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1264117439-1228508997=:68911"
Message-ID: <895374.68911.qm@web23103.mail.ird.yahoo.com>
Cc: linuxppc-dev@ozlabs.org, Gary Thomas <gary@mlbassoc.com>,
	gianfranco.casanova@alice.it
Reply-To: s104259@yahoo.it
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-1264117439-1228508997=:68911
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ok .
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Case arch =3D powerpc

I saw that cdm is modified in two fields.

arch/powerpc/platforms/mpc52xx_common.c file, in function: mpc52xx_setup_cp=
u(void)
.....
=C2=A0=C2=A0=C2=A0 /* Use internal 48 Mhz */
=C2=A0=C2=A0=C2=A0 out_8(&cdm->ext_48mhz_en, 0x00);
=C2=A0=C2=A0=C2=A0 out_8(&cdm->fd_enable, 0x01);
=C2=A0=C2=A0=C2=A0 if (in_be32(&cdm->rstcfg) & 0x40)=C2=A0=C2=A0=C2=A0 /* A=
ssumes 33Mhz clock */
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 out_be16(&cdm->fd_counters, 0x0001);
=C2=A0=C2=A0=C2=A0 else
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 out_be16(&cdm->fd_counters, 0x5555);
.....

and in file arch/powerpc/platforms/52xx/lite5200.c , function:
void __init lite5200_calibrate_decr(void)
{
=C2=A0=C2=A0=C2=A0 ppc_tb_freq =3D 0x1F78A40;=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 /* hardcoded default */
=C2=A0=C2=A0=C2=A0 /* CPU FREQUENCY FORCED TO 396 MHz VALUE */
=C2=A0=C2=A0=C2=A0 ppc_proc_freq =3D 0x179A7B00;=C2=A0=C2=A0=C2=A0 /* hardc=
oded default */
..........

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Case arch =3D ppc

The code is equal but obviously the path change (arch/ppc/syslib/mpc52xx_se=
tup.c). Funtion: mpc52xx_setup_cpu(void)
.....
=C2=A0=C2=A0=C2=A0 /* Use internal 48 Mhz */
=C2=A0=C2=A0=C2=A0 out_8(&cdm->ext_48mhz_en, 0x00);
=C2=A0=C2=A0=C2=A0 out_8(&cdm->fd_enable, 0x01);
=C2=A0=C2=A0=C2=A0 if (in_be32(&cdm->rstcfg) & 0x40)=C2=A0=C2=A0=C2=A0 /* A=
ssumes 33Mhz clock */
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 out_be16(&cdm->fd_counters, 0x0001);
=C2=A0=C2=A0=C2=A0 else
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 out_be16(&cdm->fd_counters, 0x5555);
.....
And in function: mpc52xx_calibrate_decr(void)

.....
=C2=A0=C2=A0=C2=A0 xlbfreq =3D __res.bi_busfreq;
=C2=A0=C2=A0=C2=A0 /* if bootloader didn't pass bus frequencies, calculate =
them */
=C2=A0=C2=A0=C2=A0 if (xlbfreq =3D=3D 0) {
=C2=A0=C2=A0=C2=A0 ...........
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /* Compute all frequency from that & =
CDM settings */
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 xlbfreq =3D (tbl_end - tbl_start) << =
8;
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 cpufreq =3D (xlbfreq * core_mult[in_b=
e32(&cdm->rstcfg)&0x1f])/10;
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ipbfreq =3D (in_8(&cdm->ipb_clk_sel) =
& 1) ?
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0 xlbfreq / 2 : xlbfreq;
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 switch (in_8(&cdm->pci_clk_sel) & 3) =
{
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 case 0:
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 pcifreq =3D ipbfre=
q;
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 break;
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 case 1:
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 pcifreq =3D ipbfre=
q / 2;
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 break;
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 default:
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 pcifreq =3D xlbfre=
q / 4;
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 break;
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0 .....
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

What do you think about this?

Thanks in advance,
@ngel
--- Ven 5/12/08, Jon Smirl <jonsmirl@gmail.com> ha scritto:
Da: Jon Smirl <jonsmirl@gmail.com>
Oggetto: Re: R: Installation on a MPC5200 based custom board
A: "Juergen Beisert" <jbe@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, s104259@yahoo.it, "Gary Thomas" <gary@mlbassoc=
.com>, gianfranco.casanova@alice.it
Data: Venerd=C3=AC 5 dicembre 2008, 20:33

The attachment is from Freescale and shows how the divider works.

--=20
Jon Smirl
jonsmirl@gmail.com
=0A=0A=0A      
--0-1264117439-1228508997=:68911
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Ok .<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br><span style=3D"font-weight: bold;">Case arch =
=3D powerpc</span><br><br>I saw that <span style=3D"font-weight: bold;">cdm=
</span> is modified in two fields.<br><br><span style=3D"font-style: italic=
;">arch/powerpc/platforms/mpc52xx_common.c</span> file, in function: <span =
style=3D"font-weight: bold;">mpc52xx_setup_cpu(void)</span><br>.....<br>&nb=
sp;&nbsp;&nbsp; /* Use internal 48 Mhz */<br>&nbsp;&nbsp;&nbsp; out_8(&amp;=
cdm-&gt;ext_48mhz_en, 0x00);<br>&nbsp;&nbsp;&nbsp; out_8(&amp;cdm-&gt;fd_en=
able, 0x01);<br>&nbsp;&nbsp;&nbsp; if (in_be32(&amp;cdm-&gt;rstcfg) &amp; 0=
x40)&nbsp;&nbsp;&nbsp; /* Assumes 33Mhz clock */<br>&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; out_be16(&amp;cdm-&gt;fd_counters, 0x0001);<br>&nbsp;&nbsp;&=
nbsp; else<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; out_be16(&amp;cdm-&gt;f=
d_counters,
 0x5555);<br>.....<br><br>and in file <span style=3D"font-style: italic;">a=
rch/powerpc/platforms/52xx/lite5200.c</span> , function:<br>void __init <sp=
an style=3D"font-weight: bold;">lite5200_calibrate_decr(void)</span><br>{<b=
r>&nbsp;&nbsp;&nbsp; ppc_tb_freq =3D 0x1F78A40;&nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; /* hardcoded default */<br>&nbsp;&nbsp;&nbsp; /* CPU FREQUENCY FO=
RCED TO 396 MHz VALUE */<br>&nbsp;&nbsp;&nbsp; ppc_proc_freq =3D 0x179A7B00=
;&nbsp;&nbsp;&nbsp; /* hardcoded default */<br>..........<br><br>=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><span style=3D"font-=
weight: bold;">Case arch =3D ppc</span><br><br>The code is equal but obviou=
sly the path change (<span style=3D"font-style: italic;">arch/ppc/syslib/mp=
c52xx_setup.c</span>). Funtion: <span style=3D"font-weight: bold;">mpc52xx_=
setup_cpu(void)</span><br>.....<br>&nbsp;&nbsp;&nbsp; /* Use internal 48 Mh=
z */<br>&nbsp;&nbsp;&nbsp; out_8(&amp;cdm-&gt;ext_48mhz_en, 0x00);<br>&nbsp=
;&nbsp;&nbsp;
 out_8(&amp;cdm-&gt;fd_enable, 0x01);<br>&nbsp;&nbsp;&nbsp; if (in_be32(&am=
p;cdm-&gt;rstcfg) &amp; 0x40)&nbsp;&nbsp;&nbsp; /* Assumes 33Mhz clock */<b=
r>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; out_be16(&amp;cdm-&gt;fd_counters, =
0x0001);<br>&nbsp;&nbsp;&nbsp; else<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; out_be16(&amp;cdm-&gt;fd_counters, 0x5555);<br>.....<br>And in function: =
<span style=3D"font-weight: bold;">mpc52xx_calibrate_decr(void)</span><br><=
br>.....<br>&nbsp;&nbsp;&nbsp; xlbfreq =3D __res.bi_busfreq;<br>&nbsp;&nbsp=
;&nbsp; /* if bootloader didn't pass bus frequencies, calculate them */<br>=
&nbsp;&nbsp;&nbsp; if (xlbfreq =3D=3D 0) {<br>&nbsp;&nbsp;&nbsp; ..........=
.<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* Compute all frequency from th=
at &amp; CDM settings */<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; xlbfreq =
=3D (tbl_end - tbl_start) &lt;&lt; 8;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; cpufreq =3D (xlbfreq *
 core_mult[in_be32(&amp;cdm-&gt;rstcfg)&amp;0x1f])/10;<br>&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; ipbfreq =3D (in_8(&amp;cdm-&gt;ipb_clk_sel) &amp; 1) ?=
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; xlbfreq / 2 : xlbfreq;<br>&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; switch (in_8(&amp;cdm-&gt;pci_clk_sel) &amp; 3) {<br>&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; case 0:<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; pcifreq =3D ipbfreq;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 case 1:<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; pcifre=
q =3D ipbfreq / 2;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; break;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; default:<br>&nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; pcifreq =3D xlbfreq / 4;<br>&=
nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
 break;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; ..=
...<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><b=
r>What do you think about this?<br><br>Thanks in advance,<br>@ngel<br>--- <=
b>Ven 5/12/08, Jon Smirl <i>&lt;jonsmirl@gmail.com&gt;</i></b> ha scritto:<=
br><blockquote style=3D"border-left: 2px solid rgb(16, 16, 255); margin-lef=
t: 5px; padding-left: 5px;">Da: Jon Smirl &lt;jonsmirl@gmail.com&gt;<br>Ogg=
etto: Re: R: Installation on a MPC5200 based custom board<br>A: "Juergen Be=
isert" &lt;jbe@pengutronix.de&gt;<br>Cc: linuxppc-dev@ozlabs.org, s104259@y=
ahoo.it, "Gary Thomas" &lt;gary@mlbassoc.com&gt;, gianfranco.casanova@alice=
.it<br>Data: Venerd=C3=AC 5 dicembre 2008, 20:33<br><br><pre>The attachment=
 is from Freescale and shows how the divider works.<br><br>-- <br>Jon Smirl=
<br>jonsmirl@gmail.com<br></pre></blockquote></td></tr></table><br>=0A=0A=
=0A=0A      
--0-1264117439-1228508997=:68911--
