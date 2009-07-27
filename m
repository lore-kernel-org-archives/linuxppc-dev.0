Return-Path: <rlary@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 53FBFB6EDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 00:29:42 +1000 (EST)
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55DE5DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2009 00:29:39 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6REXA70023945
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 10:33:10 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6RETXP6222004
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 10:29:33 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6RETVVp032710
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 10:29:33 -0400
In-Reply-To: <3ae3aa420907241730i74541747l2ca288e0c138001e@mail.gmail.com>
Subject: Re: [PATCH] Support for PCI Express reset type in EEH
To: linasvepstas@gmail.com
Message-ID: <OFB25F1A6D.372F2A3F-ON88257600.004F6D39-88257600.004F936D@us.ibm.com>
From: Richard Lary <rlary@us.ibm.com>
Date: Mon, 27 Jul 2009 07:29:10 -0700
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=07BBFC93DFDCEBA98f9e8a93df938690918c07BBFC93DFDCEBA9"
Cc: linuxppc-dev@ozlabs.org, mmlnx@linux.vnet.ibm.com,
	Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0__=07BBFC93DFDCEBA98f9e8a93df938690918c07BBFC93DFDCEBA9
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: quoted-printable




Linas Vepstas <linasvepstas@gmail.com> wrote on 07/24/2009 05:30:09 PM:=


> 2009/7/24 Richard Lary <rlary@us.ibm.com>:
> > Linas Vepstas <linasvepstas@gmail.com> wrote on 07/23/2009 07:44:33=
 AM:
> >
> >> 2009/7/15 Mike Mason <mmlnx@us.ibm.com>:
> >> > By default, EEH does what's known as a "hot reset" during error
recovery
> >> > of
> >> > a PCI Express device. =A0We've found a case where the device nee=
ds a
> >> > "fundamental reset" to recover properly. =A0The current PCI erro=
r
recovery
> >> > and
> >> > EEH frameworks do not support this distinction.
> >> >
> >> > The attached patch (courtesy of Richard Lary) adds a bit field t=
o
> >> > pci_dev
> >> > that indicates whether the device requires a fundamental reset
during
> >> > error
> >> > recovery. =A0This bit can be checked by EEH to determine which r=
eset
type
> >> > is
> >> > required.
> >> >
> >> > This patch supersedes the previously submitted patch that
implemented a
> >> > reset type callback.
> >> >
> >> > Please review and let me know of any concerns.
> >>
> >> I like this patch a *lot* better .. it is vastly simpler, more dir=
ect.
> >>
> >>
> >> > diff -uNrp a/include/linux/pci.h b/include/linux/pci.h
> >> > --- a/include/linux/pci.h =A0 =A0 =A0 2009-07-13 14:25:37.000000=
000 -0700
> >> > +++ b/include/linux/pci.h =A0 =A0 =A0 2009-07-15 10:25:37.000000=
000 -0700
> >> > @@ -273,6 +273,7 @@ struct pci_dev {
> >> > =A0 =A0 =A0 =A0unsigned int =A0 =A0ari_enabled:1; =A0/* ARI forw=
arding */
> >> > =A0 =A0 =A0 =A0unsigned int =A0 =A0is_managed:1;
> >> > =A0 =A0 =A0 =A0unsigned int =A0 =A0is_pcie:1;
> >> > + =A0 =A0 =A0 unsigned int =A0 =A0fndmntl_rst_rqd:1; /* Dev requ=
ires
fundamental
> >> > reset
> >> > */
> >> > =A0 =A0 =A0 =A0unsigned int =A0 =A0state_saved:1;
> >> > =A0 =A0 =A0 =A0unsigned int =A0 =A0is_physfn:1;
> >> > =A0 =A0 =A0 =A0unsigned int =A0 =A0is_virtfn:1;
> >>
> >> As Ben points out, the name is awkward. =A0How about needs_freset =
?
> >
> > I am OK with name change.
> >
> >
> >> Since this affects the entire pci subsystem, it should be document=
ed
> >> properly. =A0The "pci error recovery" subsystem was designed to be=

> >> usable in other architectures, and so the error recovery docs shou=
ld
> >> take at least a paragraph to describe what this flag means, and wh=
en
> >> its supposed to be used.
> >
> > I will update the documentation, are you referring to
> > Documentation/powerpc/eeh-pci-error-recovery.txt
> > or some other documentation?
>
> No, I'm thinking
> Documentation/PCI/pci-error-recovery.txt
>
> because the flag is not powerpc-specific.

Got it, glad I asked...

-rich

> >
> >> Providing the docs patch together with the pci.h patch *only* woul=
d
> >> probably simplify acceptance by the PCI community.
> >>
> >> --linas
> >=

--0__=07BBFC93DFDCEBA98f9e8a93df938690918c07BBFC93DFDCEBA9
Content-type: text/html; charset=ISO-8859-1
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><tt>Linas Vepstas &lt;linasvepstas@gmail.com&gt; wrote on 07/24/2009=
 05:30:09 PM:<br>
<br>
&gt; 2009/7/24 Richard Lary &lt;rlary@us.ibm.com&gt;:<br>
&gt; &gt; Linas Vepstas &lt;linasvepstas@gmail.com&gt; wrote on 07/23/2=
009 07:44:33 AM:<br>
&gt; &gt;<br>
&gt; &gt;&gt; 2009/7/15 Mike Mason &lt;mmlnx@us.ibm.com&gt;:<br>
&gt; &gt;&gt; &gt; By default, EEH does what's known as a &quot;hot res=
et&quot; during error recovery<br>
&gt; &gt;&gt; &gt; of<br>
&gt; &gt;&gt; &gt; a PCI Express device. =A0We've found a case where th=
e device needs a<br>
&gt; &gt;&gt; &gt; &quot;fundamental reset&quot; to recover properly. =A0=
The current PCI error recovery<br>
&gt; &gt;&gt; &gt; and<br>
&gt; &gt;&gt; &gt; EEH frameworks do not support this distinction.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; The attached patch (courtesy of Richard Lary) adds a=
 bit field to<br>
&gt; &gt;&gt; &gt; pci_dev<br>
&gt; &gt;&gt; &gt; that indicates whether the device requires a fundame=
ntal reset during<br>
&gt; &gt;&gt; &gt; error<br>
&gt; &gt;&gt; &gt; recovery. =A0This bit can be checked by EEH to deter=
mine which reset type<br>
&gt; &gt;&gt; &gt; is<br>
&gt; &gt;&gt; &gt; required.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; This patch supersedes the previously submitted patch=
 that implemented a<br>
&gt; &gt;&gt; &gt; reset type callback.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Please review and let me know of any concerns.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I like this patch a *lot* better .. it is vastly simpler,=
 more direct.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt; diff -uNrp a/include/linux/pci.h b/include/linux/pci=
.h<br>
&gt; &gt;&gt; &gt; --- a/include/linux/pci.h =A0 =A0 =A0 2009-07-13 14:=
25:37.000000000 -0700<br>
&gt; &gt;&gt; &gt; +++ b/include/linux/pci.h =A0 =A0 =A0 2009-07-15 10:=
25:37.000000000 -0700<br>
&gt; &gt;&gt; &gt; @@ -273,6 +273,7 @@ struct pci_dev {<br>
&gt; &gt;&gt; &gt; =A0 =A0 =A0 =A0unsigned int =A0 =A0ari_enabled:1; =A0=
/* ARI forwarding */<br>
&gt; &gt;&gt; &gt; =A0 =A0 =A0 =A0unsigned int =A0 =A0is_managed:1;<br>=

&gt; &gt;&gt; &gt; =A0 =A0 =A0 =A0unsigned int =A0 =A0is_pcie:1;<br>
&gt; &gt;&gt; &gt; + =A0 =A0 =A0 unsigned int =A0 =A0fndmntl_rst_rqd:1;=
 /* Dev requires fundamental<br>
&gt; &gt;&gt; &gt; reset<br>
&gt; &gt;&gt; &gt; */<br>
&gt; &gt;&gt; &gt; =A0 =A0 =A0 =A0unsigned int =A0 =A0state_saved:1;<br=
>
&gt; &gt;&gt; &gt; =A0 =A0 =A0 =A0unsigned int =A0 =A0is_physfn:1;<br>
&gt; &gt;&gt; &gt; =A0 =A0 =A0 =A0unsigned int =A0 =A0is_virtfn:1;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; As Ben points out, the name is awkward. =A0How about need=
s_freset ?<br>
&gt; &gt;<br>
&gt; &gt; I am OK with name change.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;&gt; Since this affects the entire pci subsystem, it should be=
 documented<br>
&gt; &gt;&gt; properly. =A0The &quot;pci error recovery&quot; subsystem=
 was designed to be<br>
&gt; &gt;&gt; usable in other architectures, and so the error recovery =
docs should<br>
&gt; &gt;&gt; take at least a paragraph to describe what this flag mean=
s, and when<br>
&gt; &gt;&gt; its supposed to be used.<br>
&gt; &gt;<br>
&gt; &gt; I will update the documentation, are you referring to<br>
&gt; &gt; Documentation/powerpc/eeh-pci-error-recovery.txt<br>
&gt; &gt; or some other documentation?<br>
&gt; <br>
&gt; No, I'm thinking<br>
&gt; Documentation/PCI/pci-error-recovery.txt<br>
&gt; <br>
&gt; because the flag is not powerpc-specific.<br>
</tt><br>
<tt>Got it, glad I asked...</tt><br>
<br>
<tt>-rich</tt><br>
<tt><br>
&gt; &gt;<br>
&gt; &gt;&gt; Providing the docs patch together with the pci.h patch *o=
nly* would<br>
&gt; &gt;&gt; probably simplify acceptance by the PCI community.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; --linas<br>
&gt; &gt;<br>
</tt></body></html>=

--0__=07BBFC93DFDCEBA98f9e8a93df938690918c07BBFC93DFDCEBA9--
