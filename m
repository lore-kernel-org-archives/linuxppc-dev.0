Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id EE1B367C06
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2006 23:52:30 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6F12A.517511E3"
Subject: RE: preempt crash in 2.6.18
Date: Mon, 16 Oct 2006 08:50:40 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B07B398@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B07B397@ismail.innsys.innovsys.com><20061014012105.6ca4ff05@localhost.localdomain><1160781278.4792.279.camel@localhost.localdomain>
	<20061015132058.01c68605@localhost.localdomain>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Vitaly Bordug" <vbordug@ru.mvista.com>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6F12A.517511E3
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

-----Original Message-----
From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]
=20
On Sat, 14 Oct 2006 09:14:38 +1000
Benjamin Herrenschmidt wrote:

> On Sat, 2006-10-14 at 01:21 +0400, Vitaly Bordug wrote:
> > On Fri, 13 Oct 2006 09:16:52 -0500
> > Rune Torgersen wrote:
> >=20
> > >=20
> > > This is from a Freescale 8265 running 2.6.18
> > > Anyone have any idea what this is and how to fix it?
> > >=20
> > Yes. Actually, I recall alike thing and used to fix with proper
> > spin-locking if the cascade PCI irq, which apparently does do_irq
> > that seems to confuse preempt counters.
> >=20
> > Just a pure guess.
>=20
> How so ? Cascades shouldn't do do_IRQ with the new irq code anyway
> unless this is still arch/ppc, they should do either __do_IRQ or
> better, generic_handle_irq().
>=20
To clarify - I was about __do_IRQ and arch/ppc.=20
Anyway, cascade for PCI is the first place I'd give a look.

In our case it turned out to be in the TIPC network code. post_timeout =
was called and didn't unlock a lock.
The patch had been in the TIPC tree for abpout 2 days when we saw the =
problem.


--
Sincerely,

-Vitaly


------_=_NextPart_001_01C6F12A.517511E3
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7233.69">
<TITLE>RE: preempt crash in 2.6.18</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>-----Original Message-----<BR>
From: Vitaly Bordug [<A =
HREF=3D"mailto:vbordug@ru.mvista.com">mailto:vbordug@ru.mvista.com</A>]<B=
R>
<BR>
On Sat, 14 Oct 2006 09:14:38 +1000<BR>
Benjamin Herrenschmidt wrote:<BR>
<BR>
&gt; On Sat, 2006-10-14 at 01:21 +0400, Vitaly Bordug wrote:<BR>
&gt; &gt; On Fri, 13 Oct 2006 09:16:52 -0500<BR>
&gt; &gt; Rune Torgersen wrote:<BR>
&gt; &gt;<BR>
&gt; &gt; &gt;<BR>
&gt; &gt; &gt; This is from a Freescale 8265 running 2.6.18<BR>
&gt; &gt; &gt; Anyone have any idea what this is and how to fix it?<BR>
&gt; &gt; &gt;<BR>
&gt; &gt; Yes. Actually, I recall alike thing and used to fix with =
proper<BR>
&gt; &gt; spin-locking if the cascade PCI irq, which apparently does =
do_irq<BR>
&gt; &gt; that seems to confuse preempt counters.<BR>
&gt; &gt;<BR>
&gt; &gt; Just a pure guess.<BR>
&gt;<BR>
&gt; How so ? Cascades shouldn't do do_IRQ with the new irq code =
anyway<BR>
&gt; unless this is still arch/ppc, they should do either __do_IRQ =
or<BR>
&gt; better, generic_handle_irq().<BR>
&gt;<BR>
To clarify - I was about __do_IRQ and arch/ppc.<BR>
Anyway, cascade for PCI is the first place I'd give a look.<BR>
<BR>
In our case it turned out to be in the TIPC network code. post_timeout =
was called and didn't unlock a lock.<BR>
The patch had been in the TIPC tree for abpout 2 days when we saw the =
problem.<BR>
<BR>
<BR>
--<BR>
Sincerely,<BR>
<BR>
-Vitaly<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C6F12A.517511E3--
