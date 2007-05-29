Return-Path: <Ulrich.Weigand@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B4D4FDDFD2
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 01:42:02 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id l4TFfw9S523024
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 15:41:58 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l4TFfvMF4141098
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 17:41:58 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l4TFfvQD020667
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 17:41:57 +0200
In-Reply-To: <20070529064535.0C1E0DDFBC@ozlabs.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
Subject: Re: [RFC/PATCH 5/5] powerpc: Allow ptrace write to pt_regs trap
From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Message-ID: <OFF7AF7C86.A40E5407-ON422572EA.00560C99-422572EA.00563CD2@de.ibm.com>
Date: Tue, 29 May 2007 17:41:56 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 0056356C422572EA_="
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 0056356C422572EA_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 05/29/2007=20
08:45:24 AM:

> This patch allows a ptracer to write to the "trap" word of the
> pt=5Fregs. This, along with the previous patch, should enable gdb
> to properly handle syscall restarting after executing a separate
> function (at least when there's no restart block).

This doesn't look sufficient.  If you want GDB to use the save/
restore style means of handling interrupted calls (like i386),
at the very least we also need the capability to *write* the
orig=5Fgpr3 field, which is currently prohibited.  (I don't know
why this is case, though.)


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

--=_alternative 0056356C422572EA_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2><tt>Benjamin Herrenschmidt &lt;benh@kernel.crashing.org&=
gt;
wrote on 05/29/2007 08:45:24 AM:<br>
<br>
&gt; This patch allows a ptracer to write to the &quot;trap&quot; word
of the<br>
&gt; pt=5Fregs. This, along with the previous patch, should enable gdb<br>
&gt; to properly handle syscall restarting after executing a separate<br>
&gt; function (at least when there's no restart block).</tt></font>
<br>
<br><font size=3D2><tt>This doesn't look sufficient. &nbsp;If you want GDB
to use the save/</tt></font>
<br><font size=3D2><tt>restore style means of handling interrupted calls
(like i386),</tt></font>
<br><font size=3D2><tt>at the very least we also need the capability to *wr=
ite*
the</tt></font>
<br><font size=3D2><tt>orig=5Fgpr3 field, which is currently prohibited. &n=
bsp;(I
don't know</tt></font>
<br><font size=3D2><tt>why this is case, though.)</tt></font>
<br>
<br><font size=3D2 face=3D"sans-serif"><br>
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
--=_alternative 0056356C422572EA_=--
