Return-Path: <wilbur512@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 18E08B7B73
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 01:53:13 +1000 (EST)
Received: from mail-gx0-f215.google.com (mail-gx0-f215.google.com
	[209.85.217.215]) by ozlabs.org (Postfix) with ESMTP id 15CE7DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 01:53:10 +1000 (EST)
Received: by gxk11 with SMTP id 11so1391775gxk.16
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 08:53:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090826192030.GA17027@b07421-ec1.am.freescale.net>
References: <e997b7420908260739u49fb4b36j9eb148782829547b@mail.gmail.com>
	<20090826192030.GA17027@b07421-ec1.am.freescale.net>
Date: Thu, 27 Aug 2009 23:53:07 +0800
Message-ID: <e997b7420908270853i7d4058e1p8ddcfcf8df18486e@mail.gmail.com>
Subject: Re: Can't write value into memory ?(E500 V2)
From: "wilbur.chan" <wilbur512@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: multipart/alternative; boundary=0016e646182e4be4210472219078
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e646182e4be4210472219078
Content-Type: text/plain; charset=ISO-8859-1

2009/8/27 Scott Wood <scottwood@freescale.com>

>
> > //check if we successfully store value at 0x400,0000
> >
> > lis r22, 0x400
> > ori r22,r22,0x0
> > lwz r23,0(r22)
> > cmpw r23, 30
>
> The values should not be equal, since you wrote a byte and read back a
> word.
>
> Furthermore, you are storing the constant 30, but are comparing r23 with
> the register r30 (I never liked that aspect of ppc asm syntax -- too
> error prone).  If you want to compare with the constant 30, use "cmpwi".
>
> > beq  print_equal
> >
> > 1: b 1b
> >
> > print_equal:
> >  ...
> > //code end
> >
> > I found that, print_equal was not called ,the whole code seemed  to
> > enter an  infinite loop.
>
> That's because you have an infinite loop in your code, right after "beq
> print_equal".
>
> -Scott
>



Thank you very much.

I am using a SMP E500 v2, and I want CPU0 to write some value to a physical
address, and

wait for CPU1 to read from it.

However, it seemed failed to communicate between CPUs by DRAM..  CPU1 can
not read

the correct value from the address where CPU1 wrote to.

BTW: the physical address is  at 16M .

--0016e646182e4be4210472219078
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br>
<div class=3D"gmail_quote">2009/8/27 Scott Wood <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:scottwood@freescale.com">scottwood@freescale.com</a>&gt;</span=
><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im"><br>&gt; //check if we successfully store value at 0x400,=
0000<br>&gt;<br>&gt; lis r22, 0x400<br>&gt; ori r22,r22,0x0<br>&gt; lwz r23=
,0(r22)<br>&gt; cmpw r23, 30<br><br></div>The values should not be equal, s=
ince you wrote a byte and read back a<br>
word.<br><br>Furthermore, you are storing the constant 30, but are comparin=
g r23 with<br>the register r30 (I never liked that aspect of ppc asm syntax=
 -- too<br>error prone). =A0If you want to compare with the constant 30, us=
e &quot;cmpwi&quot;.<br>

<div class=3D"im"><br>&gt; beq =A0print_equal<br>&gt;<br>&gt; 1: b 1b<br>&g=
t;<br>&gt; print_equal:<br>&gt; =A0...<br>&gt; //code end<br>&gt;<br>&gt; I=
 found that, print_equal was not called ,the whole code seemed =A0to<br>&gt=
; enter an =A0infinite loop.<br>
<br></div>That&#39;s because you have an infinite loop in your code, right =
after &quot;beq<br>print_equal&quot;.<br><font color=3D"#888888"><br>-Scott=
<br></font></blockquote></div>
<div><br>=A0</div>
<div>=A0</div>
<div>Thank you very much.</div>
<div>=A0</div>
<div>I am using a SMP E500 v2, and I want CPU0 to write some value to a phy=
sical address, and </div>
<div>=A0</div>
<div>wait for CPU1 to read from it.</div>
<div>=A0</div>
<div>However, it seemed failed to communicate between CPUs by DRAM..=A0 CPU=
1 can not read </div>
<div>=A0</div>
<div>the correct value from the address where CPU1 wrote to.</div>
<div>=A0</div>
<div>BTW: the physical address is=A0 at 16M .</div>
<div>=A0</div>
<div>=A0</div>

--0016e646182e4be4210472219078--
