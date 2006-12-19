Return-Path: <jcrigby@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id 9720DDDEF4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Dec 2006 04:34:18 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id n15so2020021nfc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Dec 2006 09:34:16 -0800 (PST)
Message-ID: <4b73d43f0612190934t53fdd35ap98243ba107eb446c@mail.gmail.com>
Date: Tue, 19 Dec 2006 10:34:16 -0700
From: "John Rigby" <jcrigby@gmail.com>
To: "Pedro Luis D. L." <carcadiz@hotmail.com>
Subject: Re: LITE5200B Powerfail
In-Reply-To: <4b73d43f0612151752x1602392ehe9933e71fa1ac456@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_12331_22589006.1166549656169"
References: <BAY114-F102E7A8BBB9E25B0CC42FCAD40@phx.gbl>
	<4b73d43f0612151752x1602392ehe9933e71fa1ac456@mail.gmail.com>
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

------=_Part_12331_22589006.1166549656169
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

According to the Lite5200B schematic
http://www.freescale.com/files/32bit/hardware_tools/schematics/lite5200BSCH=
.pdf

PSC2_4 is tied to a signal called PWR_DN_CTL_STS via a zero ohm resistor
R88.  If you want to use PSC2_4 as something else you probably need to
remove R88.

On 12/15/06, John Rigby <jcrigby@gmail.com> wrote:
>
> Have you looked at the Lite5200B schematic to see where the signals in
> question go?  Maybe you trying to drive something tied to ground high or
> vice-versa.
>
> On 12/15/06, Pedro Luis D. L. <carcadiz@hotmail.com> wrote:
> >
> > Hi all,
> >
> > I not pretty sure if this is the correct forum to ask for a solution bu=
t
> > I
> > know that some of you have worked on a driver to make PSCs in this boar=
d
> > work in an I2S mode.
> >
> > Have you ever have powerfail problems when writing the configuration
> > registers for this mode?
> >
> > I=B4ve delimited the problem:
> > - GPIO Port Config register stores without problems the value "111" in
> > bits
> > 25:27 (PSC2 to work in CODEC2 functionality with MCLK).
> > - When I write a "1" in PSC2->SICR register bit GenClk  to ensure that
> > clock
> > and FrameSync are generated internally from MCLK the systems suffers a
> > powerfail and I suppose that=B4s consecuence or some kind of shortcircu=
it.
> > I=B4ve followed the same steps made by Bob Peterson in
> > http://ozlabs.org/pipermail/linuxppc-embedded/2005-September/020210.htm=
l
> > to write the configuration in the proper registers but I still suffer
> > the
> > powerfail when GenClk is activated or, if I activate that bit first,
> > when
> > Port Config is written.
> > I=B4m also trying to understand how things are done in Roman Fietze dri=
ver
> > but
> > can=B4t find a difference. That makes me think that perhaps other
> > registers
> > must be modificated before driver loading. Meanwhile, I keep waiting fo=
r
> >
> > Grant Likely release, :-).
> > Has this happened to someone before?
> >
> > Thanks for your help.
> >
> >     Pedro.
> >
> > _________________________________________________________________
> > Hor=F3scopo, tarot, numerolog=EDa... Escucha lo que te dicen los astros=
.
> > http://astrocentro.msn.es/
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
>
>

------=_Part_12331_22589006.1166549656169
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

According to the Lite5200B schematic <a href=3D"http://www.freescale.com/fi=
les/32bit/hardware_tools/schematics/lite5200BSCH.pdf">http://www.freescale.=
com/files/32bit/hardware_tools/schematics/lite5200BSCH.pdf</a><br><br>PSC2_=
4 is tied to a signal called PWR_DN_CTL_STS via a zero ohm resistor R88.&nb=
sp; If you want to use PSC2_4 as something else you probably need to remove=
 R88.
<br><br><div><span class=3D"gmail_quote">On 12/15/06, <b class=3D"gmail_sen=
dername">John Rigby</b> &lt;<a href=3D"mailto:jcrigby@gmail.com">jcrigby@gm=
ail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"bor=
der-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-=
left: 1ex;">
<span class=3D"q">Have you looked at the Lite5200B schematic to see where t=
he signals in
question go?&nbsp; Maybe you trying to drive something tied to ground high
or vice-versa.<br><br></span><div><span class=3D"q"><span class=3D"gmail_qu=
ote">On 12/15/06, <b class=3D"gmail_sendername">Pedro Luis D. L.</b> &lt;<a=
 href=3D"mailto:carcadiz@hotmail.com" target=3D"_blank" onclick=3D"return t=
op.js.OpenExtLink(window,event,this)">
carcadiz@hotmail.com</a>&gt; wrote:</span></span><div><span class=3D"e" id=
=3D"q_10f88f609c37664c_3"><blockquote class=3D"gmail_quote" style=3D"border=
-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-lef=
t: 1ex;">

Hi all,<br><br>I not pretty sure if this is the correct forum to ask for a =
solution but I<br>know that some of you have worked on a driver to make PSC=
s in this board<br>work in an I2S mode.<br><br>Have you ever have powerfail=
 problems when writing the configuration
<br>registers for this mode?<br><br>I=B4ve delimited the problem:<br>- GPIO=
 Port Config register stores without problems the value &quot;111&quot; in =
bits<br>25:27 (PSC2 to work in CODEC2 functionality with MCLK).<br>- When I=
 write a &quot;1&quot; in PSC2-&gt;SICR register bit GenClk&nbsp;&nbsp;to e=
nsure that clock
<br>and FrameSync are generated internally from MCLK the systems suffers a<=
br>powerfail and I suppose that=B4s consecuence or some kind of shortcircui=
t.<br>I=B4ve followed the same steps made by Bob Peterson in<br><a href=3D"=
http://ozlabs.org/pipermail/linuxppc-embedded/2005-September/020210.html" t=
arget=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">

http://ozlabs.org/pipermail/linuxppc-embedded/2005-September/020210.html</a=
><br>to write the configuration in the proper registers but I still suffer =
the<br>powerfail when GenClk is activated or, if I activate that bit first,=
 when
<br>Port Config is written.<br>I=B4m also trying to understand how things a=
re done in Roman Fietze driver but<br>can=B4t find a difference. That makes=
 me think that perhaps other registers<br>must be modificated before driver=
 loading. Meanwhile, I keep waiting for
<br>Grant Likely release, :-).<br>Has this happened to someone before?<br><=
br>Thanks for your help.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;Pedro.<br><br>_____=
____________________________________________________________<br>Hor=F3scopo=
, tarot, numerolog=EDa... Escucha lo que te dicen los astros.
<br><a href=3D"http://astrocentro.msn.es/" target=3D"_blank" onclick=3D"ret=
urn top.js.OpenExtLink(window,event,this)">http://astrocentro.msn.es/</a><b=
r><br>_______________________________________________<br>Linuxppc-embedded =
mailing list
<br><a href=3D"mailto:Linuxppc-embedded@ozlabs.org" target=3D"_blank" oncli=
ck=3D"return top.js.OpenExtLink(window,event,this)">Linuxppc-embedded@ozlab=
s.org
</a><br><a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded" t=
arget=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">h=
ttps://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote></=
span>
</div></div><br>

</blockquote></div><br>

------=_Part_12331_22589006.1166549656169--
