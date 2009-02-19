Return-Path: <sylvain.joyeau@gmail.com>
Received: from mail-ew0-f21.google.com (mail-ew0-f21.google.com
	[209.85.219.21]) by ozlabs.org (Postfix) with ESMTP id DC14DDDDB6
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 03:48:05 +1100 (EST)
Received: by ewy14 with SMTP id 14so765373ewy.9
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 08:48:03 -0800 (PST)
MIME-Version: 1.0
Sender: sylvain.joyeau@gmail.com
In-Reply-To: <43EB80E07C42E1408726E4905FB96B04C07700@CYBORG3.cyclone.com>
References: <43EB80E07C42E1408726E4905FB96B04C0769D@CYBORG3.cyclone.com>
	<F122E3A2-3054-4BC9-9C06-0ADE590A8AFC@kernel.crashing.org>
	<43EB80E07C42E1408726E4905FB96B04C076B1@CYBORG3.cyclone.com>
	<6BBF4AB4-FFB0-46ED-B591-17DEC3BE547F@kernel.crashing.org>
	<43EB80E07C42E1408726E4905FB96B04C07700@CYBORG3.cyclone.com>
Date: Thu, 19 Feb 2009 17:48:03 +0100
Message-ID: <d194b8ce0902190848hb53166cj32e7d0bd65021d2e@mail.gmail.com>
Subject: Re: Gianfar tx-babbling-errors
From: "sjoyeau@wanadoo.fr" <sjoyeau@wanadoo.fr>
To: Scott Coulter <scott.coulter@cyclone.com>
Content-Type: multipart/alternative; boundary=0015174c0f86bc79570463484c73
Cc: linuxppc-dev@ozlabs.org
Reply-To: sjoyeau@wanadoo.fr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0015174c0f86bc79570463484c73
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Scott,

Your issue may come from data setup (or corruption) instead of code path:
babbling error may occurs when a TSEC TX descriptor hasn't its "last frame"
bit set or when the data length is greated than max frame length.

--
sj

2009/2/19 Scott Coulter <scott.coulter@cyclone.com>

>
>
> Kumar,
>
> >
> > can't think of any.  How about adding a BUG_ON() in the tx path to see
> > if the buffer size > MTU and re-run your tests.
> >
>
> So, here are the checks I've tried in gfar_start_xmit():
>
> BUG_ON(skb->len > DEFAULT_RX_BUFFER_SIZE)
>
> BUG_ON(skb->len > priv->regs->maxfrm)
>
> Neither produces a bug check yet ethtool reports non-zero
> tx-babbling-errors.  The last check appears to be the definition of
> tx-babbling-errors.  Is there a transmit path that I have missed?
>
> Scott
>
> ___________________________________________________________________
>
>  Scott N. Coulter
>  Senior Software Engineer
>
>  Cyclone Microsystems
>  370 James Street              Phone:  203.786.5536 ext. 118
>  New Haven, CT 06513-3051      Email:  scott.coulter@cyclone.com
>  U.S.A.                        Web:    http://www.cyclone.com
> ___________________________________________________________________
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
------------------
Sylvain JOYEAU
Freelance Engineer
Software RT-OS R&D
sylvain.joyeau@gmail.com
T=E9l: +33-(0)667 477 052
"A good idea is one side of the coin. The other side is the practical
usefulness". J. Liedke.

--0015174c0f86bc79570463484c73
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Scott,<br><br>Your issue may come from data setup (or corruption) instea=
d of code path: babbling error may occurs when a TSEC TX descriptor hasn&#3=
9;t its &quot;last frame&quot; bit set or when the data length is greated t=
han max frame length.<br>
<br>--<br>sj <br><br><div class=3D"gmail_quote">2009/2/19 Scott Coulter <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:scott.coulter@cyclone.com" target=3D"_=
blank">scott.coulter@cyclone.com</a>&gt;</span><br>

<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<br>
Kumar,<br>
<div><br>
&gt;<br>
&gt; can&#39;t think of any. &nbsp;How about adding a BUG_ON() in the tx pa=
th to see<br>
&gt; if the buffer size &gt; MTU and re-run your tests.<br>
&gt;<br>
<br>
</div>So, here are the checks I&#39;ve tried in gfar_start_xmit():<br>
<br>
BUG_ON(skb-&gt;len &gt; DEFAULT_RX_BUFFER_SIZE)<br>
<br>
BUG_ON(skb-&gt;len &gt; priv-&gt;regs-&gt;maxfrm)<br>
<br>
Neither produces a bug check yet ethtool reports non-zero<br>
tx-babbling-errors. &nbsp;The last check appears to be the definition of<br=
>
tx-babbling-errors. &nbsp;Is there a transmit path that I have missed?<br>
<div><br>
Scott<br>
<br>
___________________________________________________________________<br>
<br>
 &nbsp;Scott N. Coulter<br>
 &nbsp;Senior Software Engineer<br>
<br>
 &nbsp;Cyclone Microsystems<br>
 &nbsp;370 James Street &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Pho=
ne: &nbsp;203.786.5536 ext. 118<br>
 &nbsp;New Haven, CT 06513-3051 &nbsp; &nbsp; &nbsp;Email: &nbsp;<a href=3D=
"mailto:scott.coulter@cyclone.com" target=3D"_blank">scott.coulter@cyclone.=
com</a><br>
 &nbsp;U.S.A. &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp;Web: &nbsp; &nbsp;<a href=3D"http://www.cyclone.com" =
target=3D"_blank">http://www.cyclone.com</a><br>
___________________________________________________________________<br>
<br>
_______________________________________________<br>
</div><div><div></div><div>Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@ozlabs.org" target=3D"_blank">Linuxppc-dev@o=
zlabs.org</a><br>
<a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev" target=3D"_bla=
nk">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>-----------=
-------<br>Sylvain JOYEAU<br>Freelance Engineer<br>Software RT-OS R&amp;D<b=
r><a href=3D"mailto:sylvain.joyeau@gmail.com" target=3D"_blank">sylvain.joy=
eau@gmail.com</a><br>


T=E9l: +33-(0)667 477 052<br>&quot;A good idea is one side of the coin. The=
 other side is the practical usefulness&quot;. J. Liedke.<br>

--0015174c0f86bc79570463484c73--
