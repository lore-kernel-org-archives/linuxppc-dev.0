Return-Path: <rlary@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EC362B7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 25 Jul 2009 07:36:54 +1000 (EST)
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8471CDDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Jul 2009 07:36:54 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6OLSXVD001276
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jul 2009 15:28:33 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6OLaoIA263448
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jul 2009 15:36:50 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.13.1/8.13.3) with ESMTP id n6OLaoBO000418
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jul 2009 15:36:50 -0600
In-Reply-To: <3ae3aa420907230744ya3a9342w4f29e150b3b5658f@mail.gmail.com>
Subject: Re: [PATCH] Support for PCI Express reset type in EEH
To: linasvepstas@gmail.com
Message-ID: <OF71B46F7B.49A6C08D-ON882575FD.00768DAA-882575FD.0076AF2C@us.ibm.com>
From: Richard Lary <rlary@us.ibm.com>
Date: Fri, 24 Jul 2009 14:36:20 -0700
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=07BBFF6EDFE50B3A8f9e8a93df938690918c07BBFF6EDFE50B3A"
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

--0__=07BBFF6EDFE50B3A8f9e8a93df938690918c07BBFF6EDFE50B3A
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: quoted-printable



Linas Vepstas <linasvepstas@gmail.com> wrote on 07/23/2009 07:44:33 AM:=


> 2009/7/15 Mike Mason <mmlnx@us.ibm.com>:
> > By default, EEH does what's known as a "hot reset" during error
recovery of
> > a PCI Express device. =A0We've found a case where the device needs =
a
> > "fundamental reset" to recover properly. =A0The current PCI error
recovery and
> > EEH frameworks do not support this distinction.
> >
> > The attached patch (courtesy of Richard Lary) adds a bit field to
pci_dev
> > that indicates whether the device requires a fundamental reset duri=
ng
error
> > recovery. =A0This bit can be checked by EEH to determine which rese=
t type
is
> > required.
> >
> > This patch supersedes the previously submitted patch that implement=
ed a
> > reset type callback.
> >
> > Please review and let me know of any concerns.
>
> I like this patch a *lot* better .. it is vastly simpler, more direct=
.
>
>
> > diff -uNrp a/include/linux/pci.h b/include/linux/pci.h
> > --- a/include/linux/pci.h =A0 =A0 =A0 2009-07-13 14:25:37.000000000=
 -0700
> > +++ b/include/linux/pci.h =A0 =A0 =A0 2009-07-15 10:25:37.000000000=
 -0700
> > @@ -273,6 +273,7 @@ struct pci_dev {
> > =A0 =A0 =A0 =A0unsigned int =A0 =A0ari_enabled:1; =A0/* ARI forward=
ing */
> > =A0 =A0 =A0 =A0unsigned int =A0 =A0is_managed:1;
> > =A0 =A0 =A0 =A0unsigned int =A0 =A0is_pcie:1;
> > + =A0 =A0 =A0 unsigned int =A0 =A0fndmntl_rst_rqd:1; /* Dev require=
s fundamental
reset
> > */
> > =A0 =A0 =A0 =A0unsigned int =A0 =A0state_saved:1;
> > =A0 =A0 =A0 =A0unsigned int =A0 =A0is_physfn:1;
> > =A0 =A0 =A0 =A0unsigned int =A0 =A0is_virtfn:1;
>
> As Ben points out, the name is awkward.  How about needs_freset ?

I am OK with name change.

> Since this affects the entire pci subsystem, it should be documented
> properly.  The "pci error recovery" subsystem was designed to be
> usable in other architectures, and so the error recovery docs should
> take at least a paragraph to describe what this flag means, and when
> its supposed to be used.

I will update the documentation, are you referring to
Documentation/powerpc/eeh-pci-error-recovery.txt
or some other documentation?

> Providing the docs patch together with the pci.h patch *only* would
> probably simplify acceptance by the PCI community.
>
> --linas=

--0__=07BBFF6EDFE50B3A8f9e8a93df938690918c07BBFF6EDFE50B3A
Content-type: text/html; charset=ISO-8859-1
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><tt>Linas Vepstas &lt;linasvepstas@gmail.com&gt; wrote on 07/23/2009=
 07:44:33 AM:<br>
<br>
&gt; 2009/7/15 Mike Mason &lt;mmlnx@us.ibm.com&gt;:<br>
&gt; &gt; By default, EEH does what's known as a &quot;hot reset&quot; =
during error recovery of<br>
&gt; &gt; a PCI Express device. =A0We've found a case where the device =
needs a<br>
&gt; &gt; &quot;fundamental reset&quot; to recover properly. =A0The cur=
rent PCI error recovery and<br>
&gt; &gt; EEH frameworks do not support this distinction.<br>
&gt; &gt;<br>
&gt; &gt; The attached patch (courtesy of Richard Lary) adds a bit fiel=
d to pci_dev<br>
&gt; &gt; that indicates whether the device requires a fundamental rese=
t during error<br>
&gt; &gt; recovery. =A0This bit can be checked by EEH to determine whic=
h reset type is<br>
&gt; &gt; required.<br>
&gt; &gt;<br>
&gt; &gt; This patch supersedes the previously submitted patch that imp=
lemented a<br>
&gt; &gt; reset type callback.<br>
&gt; &gt;<br>
&gt; &gt; Please review and let me know of any concerns.<br>
&gt; <br>
&gt; I like this patch a *lot* better .. it is vastly simpler, more dir=
ect.<br>
&gt; <br>
&gt; <br>
&gt; &gt; diff -uNrp a/include/linux/pci.h b/include/linux/pci.h<br>
&gt; &gt; --- a/include/linux/pci.h =A0 =A0 =A0 2009-07-13 14:25:37.000=
000000 -0700<br>
&gt; &gt; +++ b/include/linux/pci.h =A0 =A0 =A0 2009-07-15 10:25:37.000=
000000 -0700<br>
&gt; &gt; @@ -273,6 +273,7 @@ struct pci_dev {<br>
&gt; &gt; =A0 =A0 =A0 =A0unsigned int =A0 =A0ari_enabled:1; =A0/* ARI f=
orwarding */<br>
&gt; &gt; =A0 =A0 =A0 =A0unsigned int =A0 =A0is_managed:1;<br>
&gt; &gt; =A0 =A0 =A0 =A0unsigned int =A0 =A0is_pcie:1;<br>
&gt; &gt; + =A0 =A0 =A0 unsigned int =A0 =A0fndmntl_rst_rqd:1; /* Dev r=
equires fundamental reset<br>
&gt; &gt; */<br>
&gt; &gt; =A0 =A0 =A0 =A0unsigned int =A0 =A0state_saved:1;<br>
&gt; &gt; =A0 =A0 =A0 =A0unsigned int =A0 =A0is_physfn:1;<br>
&gt; &gt; =A0 =A0 =A0 =A0unsigned int =A0 =A0is_virtfn:1;<br>
&gt; <br>
&gt; As Ben points out, the name is awkward. &nbsp;How about needs_fres=
et ?<br>
</tt><br>
<tt>I am OK with name change.</tt><br>
<tt>&nbsp;<br>
&gt; Since this affects the entire pci subsystem, it should be document=
ed<br>
&gt; properly. &nbsp;The &quot;pci error recovery&quot; subsystem was d=
esigned to be<br>
&gt; usable in other architectures, and so the error recovery docs shou=
ld<br>
&gt; take at least a paragraph to describe what this flag means, and wh=
en<br>
&gt; its supposed to be used.<br>
</tt><br>
<tt>I will update the documentation, are you referring to</tt><br>
<tt>Documentation/powerpc/eeh-pci-error-recovery.txt</tt><br>
<tt>or some other documentation?</tt><br>
<tt>&nbsp;<br>
&gt; Providing the docs patch together with the pci.h patch *only* woul=
d<br>
&gt; probably simplify acceptance by the PCI community.<br>
&gt; <br>
&gt; --linas<br>
</tt></body></html>=

--0__=07BBFF6EDFE50B3A8f9e8a93df938690918c07BBFF6EDFE50B3A--
