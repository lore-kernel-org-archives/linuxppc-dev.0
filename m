Return-Path: <Ulrich.Weigand@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1EF3ADDFFC
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 23:54:02 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id l4TDrvgi073600
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 13:53:57 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l4TDrvvH3874890
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 15:53:57 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l4TDrvsQ025221
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 15:53:57 +0200
In-Reply-To: <1180423456.19517.124.camel@localhost.localdomain>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
Subject: Re: Saving to 32 bits of GPRs in signal context
From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Message-ID: <OF230D483F.5693FD85-ON422572EA.004BC04B-422572EA.004C58F9@de.ibm.com>
Date: Tue, 29 May 2007 15:53:55 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 004C4782422572EA_="
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
	Steve Munroe <sjmunroe@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 004C4782422572EA_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 05/29/2007=20
09:24:15 AM:

> Specifically, are everybody using the uc=5Fregs pointer to get to the
> mcontext or are some people likely to expect the mcontext to always be
> at the same offset from the beginning of the signal frame ?

As far as I can see, both GDB and the GCC unwind-from-signal code
always read the uc=5Fregs pointer. (Or the sigcontext.regs pointer for
old-style signal frames.)

> There are a few other issues... one is, the pad fields aren't cleared.
> Thus how can userland or rt=5Fsigreturn differenciate between a valid
> highregs pointers and ramdom junk ? Is there a trick one of you can come
> up with that I could do to let userland/gdb/rt=5Fsigreturn know that
> there's something there ?

One idea we had about this was to use a bit in uc=5Fflags.  Those are
completely unused today, but should always have been initialized to 0.


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--=20
  Dr. Ulrich Weigand | Phone: +49-7031/16-3727
  GNU compiler/toolchain for Linux on System z and Cell BE
  IBM Deutschland Entwicklung GmbH
  Vorsitzender des Aufsichtsrats: Martin Jetter | Gesch=E4ftsf=FChrung:=20
Herbert Kircher
  Sitz der Gesellschaft: B=F6blingen | Registergericht: Amtsgericht=20
Stuttgart, HRB 243294

--=_alternative 004C4782422572EA_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2><tt>Benjamin Herrenschmidt &lt;benh@kernel.crashing.org&=
gt;
wrote on 05/29/2007 09:24:15 AM:<br>
<br>
&gt; Specifically, are everybody using the uc=5Fregs pointer to get to the<=
br>
&gt; mcontext or are some people likely to expect the mcontext to always
be<br>
&gt; at the same offset from the beginning of the signal frame ?</tt></font>
<br>
<br><font size=3D2><tt>As far as I can see, both GDB and the GCC unwind-fro=
m-signal
code</tt></font>
<br><font size=3D2><tt>always read the uc=5Fregs pointer. (Or the sigcontex=
t.regs
pointer for</tt></font>
<br><font size=3D2><tt>old-style signal frames.)</tt></font>
<br><font size=3D2><tt><br>
&gt; There are a few other issues... one is, the pad fields aren't cleared.=
<br>
&gt; Thus how can userland or rt=5Fsigreturn differenciate between a valid<=
br>
&gt; highregs pointers and ramdom junk ? Is there a trick one of you can
come<br>
&gt; up with that I could do to let userland/gdb/rt=5Fsigreturn know that<b=
r>
&gt; there's something there ?</tt></font>
<br>
<br><font size=3D2><tt>One idea we had about this was to use a bit in uc=5F=
flags.
&nbsp;Those are</tt></font>
<br><font size=3D2><tt>completely unused today, but should always have been
initialized to 0.</tt></font>
<br><font size=3D2><tt><br>
</tt></font><font size=3D2 face=3D"sans-serif"><br>
Mit freundlichen Gruessen / Best Regards<br>
<br>
Ulrich Weigand<br>
<br>
-- <br>
 &nbsp;Dr. Ulrich Weigand | Phone: +49-7031/16-3727<br>
 &nbsp;GNU compiler/toolchain for Linux on System z and Cell BE<br>
 &nbsp;IBM Deutschland Entwicklung GmbH<br>
 &nbsp;Vorsitzender des Aufsichtsrats: Martin Jetter | Gesch=E4ftsf=FChrung:
Herbert Kircher<br>
 &nbsp;Sitz der Gesellschaft: B=F6blingen | Registergericht: Amtsgericht
Stuttgart, HRB 243294</font>
<br>
--=_alternative 004C4782422572EA_=--
