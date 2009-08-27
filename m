Return-Path: <hal.rosenstock@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 188E7B7B76
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 23:31:44 +1000 (EST)
Received: from mail-fx0-f222.google.com (mail-fx0-f222.google.com
	[209.85.220.222]) by ozlabs.org (Postfix) with ESMTP id DB007DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 23:31:42 +1000 (EST)
Received: by fxm22 with SMTP id 22so59343fxm.9
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 06:31:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <OFF2257478.FF0FEABE-ONC125761F.00344884-C125761F.00358310@de.ibm.com>
References: <200908261337.56128.fenkes@de.ibm.com>
	<f0e08f230908260815g70de3002pfd0b34f1b17abd6@mail.gmail.com>
	<OFF2257478.FF0FEABE-ONC125761F.00344884-C125761F.00358310@de.ibm.com>
Date: Thu, 27 Aug 2009 09:31:40 -0400
Message-ID: <f0e08f230908270631j3e159f3fgb0034eb41acdac7b@mail.gmail.com>
Subject: Re: [ewg] [PATCH] IB/ehca: Construct MAD redirect replies from
	request MAD
From: Hal Rosenstock <hal.rosenstock@gmail.com>
To: Joachim Fenkes <FENKES@de.ibm.com>
Content-Type: multipart/alternative; boundary=000e0ce0eea86c2b2204721f962d
Cc: Hal Rosenstock <hnrose@comcast.net>, OF-EWG <ewg@lists.openfabrics.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0ce0eea86c2b2204721f962d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/09, Joachim Fenkes <FENKES@de.ibm.com> wrote:
>
> Hal Rosenstock <hal.rosenstock@gmail.com> wrote on 26.08.2009 17:15:03:
>
> > Thanks for doing this. It looks sane to me. The only issue I recall that
>
> > appears to be remaining is a better setting of
> ClassPortInfo:RespTimeValue
> > rather than hardcoding. Perhaps using the value from PortInfo is the way
> to go
> > (ideally it would be that value from the port to which the the requester
> is
> > being redirected to but that might not be so easy to get from this port.
>
> I don't think that effort will be necessary or even legal. The requestor
> will react to the redirection with another Get(ClassPortInfo) to the
> redirection target, which will reply with its own RespTimeValue, so our
> driver should speak for itself.


I overreached with my comment on how this works.

 Since we don't know when our MAD
> processing and sending of the response is going to be scheduled (we're not
> running on real-time constraints here), we play it safe and return 18,
> which amounts to roughly a second.
>
> Make sense?


I don't think it should be hard coded. IMO it would be better to default to
18 and somehow able to be adjusted (via a (dynamic) module parameter ?).

-- Hal


> Regards
> Joachim
>

--000e0ce0eea86c2b2204721f962d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br>
<div><span class=3D"gmail_quote">On 8/27/09, <b class=3D"gmail_sendername">=
Joachim Fenkes</b> &lt;<a onclick=3D"return top.js.OpenExtLink(window,event=
,this)" href=3D"mailto:FENKES@de.ibm.com" target=3D"_blank">FENKES@de.ibm.c=
om</a>&gt; wrote:</span>=20
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hal Rosenstock &lt;<a onclick=3D=
"return top.js.OpenExtLink(window,event,this)" href=3D"mailto:hal.rosenstoc=
k@gmail.com" target=3D"_blank">hal.rosenstock@gmail.com</a>&gt; wrote on 26=
.08.2009 17:15:03:<br>
<br>&gt; Thanks for doing this. It looks sane to me. The only issue I recal=
l that<br><br>&gt; appears to be remaining is a better setting of<br>ClassP=
ortInfo:RespTimeValue<br>&gt; rather than hardcoding. Perhaps using the val=
ue from PortInfo is the way<br>
to go<br>&gt; (ideally it would be that value from the port to which the th=
e requester<br>is<br>&gt; being redirected to but that might not be so easy=
 to get from this port.<br><br>I don&#39;t think that effort will be necess=
ary or even legal. The requestor<br>
will react to the redirection with another Get(ClassPortInfo) to the<br>red=
irection target, which will reply with its own RespTimeValue, so our<br>dri=
ver should speak for itself.</blockquote>
<div>=C2=A0</div>
<div>I overreached with my comment on how this works.</div><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"> Since we don&#39;t know when ou=
r MAD<br>processing and sending of the response is going to be scheduled (w=
e&#39;re not<br>
running on real-time constraints here), we play it safe and return 18,<br>w=
hich amounts to roughly a second.<br><br>Make sense?</blockquote>
<div>=C2=A0</div>
<div>I don&#39;t think it should be hard coded. IMO it would be better to d=
efault to 18 and somehow able to be adjusted (via a (dynamic) module parame=
ter ?).</div>
<div>=C2=A0</div>
<div>-- Hal<br>=C2=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Regards<br>Joachim<br></blockquo=
te></div><br>

--000e0ce0eea86c2b2204721f962d--
