Return-Path: <bastiaan.nijkamp@gmail.com>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by ozlabs.org (Postfix) with ESMTP id 2900F1007D8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 02:06:02 +1100 (EST)
Received: by pva4 with SMTP id 4so777927pva.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Oct 2010 08:06:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E552013FCC59@CORPEXCH1.na.ads.idt.com>
References: <0CE8B6BE3C4AD74AB97D9D29BD24E552013B97E8@CORPEXCH1.na.ads.idt.com>
	<AANLkTimCiHWRR-kVuT0ift3CH63Xk_XcaXS22qmVh6fr@mail.gmail.com>
	<4CAB2729.6080402@freescale.com>
	<AANLkTik46NsiMhWo=GkHz4UbdDJeBLwFATJzhk-M3hSP@mail.gmail.com>
	<4CAB39F4.3030208@freescale.com>
	<AANLkTimKbibzzNc3+DSJHcLC4gA0H5JiM+EHW2k4znZ-@mail.gmail.com>
	<AANLkTimk2hRhyX4WufjdviDz-OTj7VRfjA94oyoXL9mM@mail.gmail.com>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552013FCC59@CORPEXCH1.na.ads.idt.com>
From: Bastiaan Nijkamp <bastiaan.nijkamp@gmail.com>
Date: Wed, 13 Oct 2010 17:05:41 +0200
Message-ID: <AANLkTikV69ZThBQbetT0f=PZGQos3qWKjqjoNJXysH2V@mail.gmail.com>
Subject: Re: Serial RapidIO Maintaintance read causes lock up
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
Content-Type: multipart/alternative; boundary=000e0cd144ba7c2843049280ee7c
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd144ba7c2843049280ee7c
Content-Type: text/plain; charset=ISO-8859-1

> How the host ID is set on your host board?
Normally rio_enum_host() should increment next_destid in your case.

The hostID is set to 0x0 with the riohdid parameter as boot argument.

> Make sure that you have the MASTER bit is set in agent's GCCSR register
(0xC_013C).
If your board uses HW config switches to set host/agent mode this bit will
be 0 for agent.
For quick test you may keep both boards in the host mode - the current RIO
implementation relies on "riohdid=" command line parameter instead of HOST
bit.

This seems to have done the trick :-) However, i wonder, doesn't it make
more sense to make the driver check this setting and correcting it or giving
an error instead of entering a endless loop?

Thank you for helping out, it is very much appreciated.

Bastiaan.


2010/10/13 Bounine, Alexandre <Alexandre.Bounine@idt.com>

> Bastiaan Nijkamp wrote:
>
> >Has the driver ever been tested/used without a switch attached? Because
> when the host >(which has ID 0x0) enumerates the other board it also assigns
> ID 0x0 to the agent, it seems >that the agent should have been assigned 0x1
> as ID.
>
> How the host ID is set on your host board?
> Normally rio_enum_host() should increment next_destid in your case.
>
> >Another thing is that the agent is now hanging on the discovery process.
>
> Make sure that you have the MASTER bit is set in agent's GCCSR register
> (0xC_013C).
> If your board uses HW config switches to set host/agent mode this bit will
> be 0 for agent.
> For quick test you may keep both boards in the host mode - the current RIO
> implementation relies on "riohdid=" command line parameter instead of HOST
> bit.
>
>
> Alex.
>
>
>

--000e0cd144ba7c2843049280ee7c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

&gt;=A0<meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dut=
f-8">How the host ID is set on your host board?<br>Normally rio_enum_host()=
 should increment next_destid in your case.<div><br></div><div>The hostID i=
s set to 0x0 with the riohdid parameter as boot argument.=A0<br>

<div><br></div><div>&gt;=A0Make sure that you have the MASTER bit is set in=
 agent&#39;s GCCSR register (0xC_013C).</div>If your board uses HW config s=
witches to set host/agent mode this bit will be 0 for agent.<br>For quick t=
est you may keep both boards in the host mode - the current RIO implementat=
ion relies on &quot;riohdid=3D&quot; command line parameter instead of HOST=
 bit.</div>

<div><br></div><div>This seems to have done the trick :-) However, i wonder=
, doesn&#39;t it make more sense to make the driver check this setting and =
correcting it or giving an error instead of entering a endless loop?=A0</di=
v>

<div><br></div><div>Thank you for helping out, it is very much appreciated.=
=A0</div><div><br></div><div>Bastiaan.<br><div><br><br><div class=3D"gmail_=
quote">2010/10/13 Bounine, Alexandre <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:Alexandre.Bounine@idt.com">Alexandre.Bounine@idt.com</a>&gt;</span><br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">Bastiaan Nijkamp wrote:<b=
r>
=A0<br>
&gt;Has the driver ever been tested/used without a switch attached? Because=
 when the host &gt;(which has ID 0x0) enumerates the other board it also as=
signs ID 0x0 to the agent, it seems &gt;that the agent should have=A0been a=
ssigned 0x1 as ID.<br>


<br>
</div>How the host ID is set on your host board?<br>
Normally rio_enum_host() should increment next_destid in your case.<br>
<div class=3D"im"><br>
&gt;Another thing is that the agent is now hanging on the discovery process=
.<br>
<br>
</div>Make sure that you have the MASTER bit is set in agent&#39;s GCCSR re=
gister (0xC_013C).<br>
If your board uses HW config switches to set host/agent mode this bit will =
be 0 for agent.<br>
For quick test you may keep both boards in the host mode - the current RIO =
implementation relies on &quot;riohdid=3D&quot; command line parameter inst=
ead of HOST bit.<br>
<br>
<br>
Alex.<br>
<br>
=A0<br>
</blockquote></div><br></div></div>

--000e0cd144ba7c2843049280ee7c--
