Return-Path: <pavius@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 08ED2B6FDC
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Apr 2011 16:40:33 +1000 (EST)
Received: by vxi40 with SMTP id 40so3033765vxi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Apr 2011 23:40:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110415154110.1b523da0@schlenkerla.am.freescale.net>
References: <BANLkTik=ivFpWQEhqrVnYfr2LS4HSnTDuA@mail.gmail.com>
	<20110415154110.1b523da0@schlenkerla.am.freescale.net>
Date: Sat, 16 Apr 2011 09:40:29 +0300
Message-ID: <BANLkTikrqn8Pd2J05LP3jPF9OWwygfKBOQ@mail.gmail.com>
Subject: Re: Non-console UART issues with 8xx
From: Eran Duchan <pavius@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: multipart/alternative; boundary=bcaec50163892f3d6504a1036f97
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--bcaec50163892f3d6504a1036f97
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for the pointers, Scott.
Looks like some elbow grease is in order. I will post any results I have
once I get to this :-/

Eran

On Fri, Apr 15, 2011 at 11:41 PM, Scott Wood <scottwood@freescale.com>wrote=
:

> On Fri, 15 Apr 2011 02:52:22 +0300
> Eran Duchan <pavius@gmail.com> wrote:
>
> > Hey list
> >
> > I have a custom MPC875 board running 2.6.37. SMC1 is the console, SCC4 =
is
> a
> > general purpose UART (DTS is set up accordingly). No hardware or softwa=
re
> > flow control for either.
> >
> > The issue is simple: the non-console UART transmits garbled characters =
at
> > the end of the transmission.
>
> Hmm, there's a wait_closing field in uart_cpm_port that doesn't seem to b=
e
> initialized anywhere.
>
> The driver should also be sending the STOP_TX/GRA_STOP_TX command *before=
*
> clearing the transmit enable bits, rather than after.
>
> >  For example, set up SMC1 to console (works
> > perfect) and SCC4 as non-console, run stty -F /dev/ttyCPM1 19200 raw an=
d
> > then echo -n 1234567890 > /dev/ttyCPM1 - transmission may be something
> like
> > "1234567=F8". Set the SCC4 as console (same baud rates) and the problem=
 is
> > reversed (SCC4 works perfect, SMC1 transmit garbled).
> >
> > Rx direction seems fine, after some rudementary testing.
> >
> > I dived into the code and see that the console UART has a completely
> > different initialization sequence than the non-console UART. Short of
> diving
> > into this ancient CPM architecture - does anyone have an idea?
>
> The console is a bit different because it has a user that isn't tied to a=
n
> open file-handle -- which doesn't interact well with the driver's
> (possibly misguided) desire to actually deconfigure the hardware when not
> open.
>
> -Scott
>
>

--bcaec50163892f3d6504a1036f97
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the pointers, Scott.<div>Looks like some elbow =
grease is in order. I will post any results I have once I get to this :-/</=
div><div><br></div><div>Eran<br><br><div class=3D"gmail_quote">On Fri, Apr =
15, 2011 at 11:41 PM, Scott Wood <span dir=3D"ltr">&lt;<a href=3D"mailto:sc=
ottwood@freescale.com">scottwood@freescale.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On Fri, 15 Apr 2011 02:52=
:22 +0300<br>
Eran Duchan &lt;<a href=3D"mailto:pavius@gmail.com">pavius@gmail.com</a>&gt=
; wrote:<br>
<br>
&gt; Hey list<br>
&gt;<br>
&gt; I have a custom MPC875 board running 2.6.37. SMC1 is the console, SCC4=
 is a<br>
&gt; general purpose UART (DTS is set up accordingly). No hardware or softw=
are<br>
&gt; flow control for either.<br>
&gt;<br>
&gt; The issue is simple: the non-console UART transmits garbled characters=
 at<br>
&gt; the end of the transmission.<br>
<br>
</div>Hmm, there&#39;s a wait_closing field in uart_cpm_port that doesn&#39=
;t seem to be<br>
initialized anywhere.<br>
<br>
The driver should also be sending the STOP_TX/GRA_STOP_TX command *before*<=
br>
clearing the transmit enable bits, rather than after.<br>
<div class=3D"im"><br>
&gt; =A0For example, set up SMC1 to console (works<br>
&gt; perfect) and SCC4 as non-console, run stty -F /dev/ttyCPM1 19200 raw a=
nd<br>
&gt; then echo -n 1234567890 &gt; /dev/ttyCPM1 - transmission may be someth=
ing like<br>
&gt; &quot;1234567=F8&quot;. Set the SCC4 as console (same baud rates) and =
the problem is<br>
&gt; reversed (SCC4 works perfect, SMC1 transmit garbled).<br>
&gt;<br>
&gt; Rx direction seems fine, after some rudementary testing.<br>
&gt;<br>
&gt; I dived into the code and see that the console UART has a completely<b=
r>
&gt; different initialization sequence than the non-console UART. Short of =
diving<br>
&gt; into this ancient CPM architecture - does anyone have an idea?<br>
<br>
</div>The console is a bit different because it has a user that isn&#39;t t=
ied to an<br>
open file-handle -- which doesn&#39;t interact well with the driver&#39;s<b=
r>
(possibly misguided) desire to actually deconfigure the hardware when not<b=
r>
open.<br>
<font color=3D"#888888"><br>
-Scott<br>
<br>
</font></blockquote></div><br></div></div>

--bcaec50163892f3d6504a1036f97--
