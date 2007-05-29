Return-Path: <Ulrich.Weigand@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5E986DDEDF
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 23:37:14 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id l4TDb9dq439398
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 13:37:09 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l4TDb9Q64022518
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 15:37:09 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l4TDb92W031885
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 15:37:09 +0200
In-Reply-To: <C31B9167-94B6-48B4-9529-78702E962460@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
MIME-Version: 1.0
Subject: Re: [RFC/PATCH 2/5] powerpc: Cleanup ptrace bits
From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Message-ID: <OF248D3BF7.F4CFDB25-ON422572EA.004A7C17-422572EA.004ACFAE@de.ibm.com>
Date: Tue, 29 May 2007 15:37:08 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 004AC989422572EA_="
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 004AC989422572EA_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Kumar Gala <galak@kernel.crashing.org> wrote on 05/29/2007 03:19:42 PM:
> On May 29, 2007, at 4:02 AM, Benjamin Herrenschmidt wrote:
> > Hrm.. we do have a subtle difference in vrregs that I've missed.. I'll
> > respin tomorrow. It looks like we don't store the VRSAVE register=20
> > at the
> > same place on 32 and 64 bits... yuck. I need to double check tomorrow.
>=20
> That's bad.  We really should have VRSAVE in the same location for=20
> both.  (wondering if GDB expects it a different locations on 32 vs 64-=20
> bits.)

It looks like GDB will expect VRSAVE at offset 33*16 (length 4 bytes)
in the area returned by PTRACE=5FGETVRREGS, for both 32-bit and 64-bit
applications:

/* This oddity is because the Linux kernel defines elf=5Fvrregset=5Ft as
   an array of 33 16 bytes long elements.  I.e. it leaves out vrsave.
   However the PTRACE=5FGETVRREGS and PTRACE=5FSETVRREGS requests return
   the vrsave as an extra 4 bytes at the end.  I opted for creating a
   flat array of chars, so that it is easier to manipulate for gdb.

   There are 32 vector registers 16 bytes longs, plus a VSCR register
   which is only 4 bytes long, but is fetched as a 16 bytes
   quantity. Up to here we have the elf=5Fvrregset=5Ft structure.
   Appended to this there is space for the VRSAVE register: 4 bytes.
   Even though this vrsave register is not included in the regset
   typedef, it is handled by the ptrace requests.

   Note that GNU/Linux doesn't support little endian PPC hardware,
   therefore the offset at which the real value of the VSCR register
   is located will be always 12 bytes.

   The layout is like this (where x is the actual value of the vscr reg):=20
*/

/* *INDENT-OFF* */
/*
   |.|.|.|.|.....|.|.|.|.||.|.|.|x||.|
   <------->     <-------><-------><->
     VR0           VR31     VSCR    VRSAVE
*/
/* *INDENT-ON* */

#define SIZEOF=5FVRREGS 33*16+4

typedef char gdb=5Fvrregset=5Ft[SIZEOF=5FVRREGS];


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

--=_alternative 004AC989422572EA_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2><tt>Kumar Gala &lt;galak@kernel.crashing.org&gt; wrote
on 05/29/2007 03:19:42 PM:<br>
&gt; On May 29, 2007, at 4:02 AM, Benjamin Herrenschmidt wrote:<br>
&gt; &gt; Hrm.. we do have a subtle difference in vrregs that I've missed..
I'll<br>
&gt; &gt; respin tomorrow. It looks like we don't store the VRSAVE register
&nbsp;<br>
&gt; &gt; at the<br>
&gt; &gt; same place on 32 and 64 bits... yuck. I need to double check
tomorrow.<br>
&gt; <br>
&gt; That's bad. &nbsp;We really should have VRSAVE in the same location
for &nbsp;<br>
&gt; both. &nbsp;(wondering if GDB expects it a different locations on
32 vs 64- <br>
&gt; bits.)</tt></font>
<br>
<br><font size=3D2><tt>It looks like GDB will expect VRSAVE at offset 33*16
(length 4 bytes)</tt></font>
<br><font size=3D2><tt>in the area returned by PTRACE=5FGETVRREGS, for both
32-bit and 64-bit</tt></font>
<br><font size=3D2><tt>applications:</tt></font>
<br>
<br><font size=3D2><tt>/* This oddity is because the Linux kernel defines
elf=5Fvrregset=5Ft as</tt></font>
<br><font size=3D2><tt>&nbsp; &nbsp;an array of 33 16 bytes long elements.
&nbsp;I.e. it leaves out vrsave.</tt></font>
<br><font size=3D2><tt>&nbsp; &nbsp;However the PTRACE=5FGETVRREGS and PTRA=
CE=5FSETVRREGS
requests return</tt></font>
<br><font size=3D2><tt>&nbsp; &nbsp;the vrsave as an extra 4 bytes at the
end. &nbsp;I opted for creating a</tt></font>
<br><font size=3D2><tt>&nbsp; &nbsp;flat array of chars, so that it is easi=
er
to manipulate for gdb.</tt></font>
<br>
<br><font size=3D2><tt>&nbsp; &nbsp;There are 32 vector registers 16 bytes
longs, plus a VSCR register</tt></font>
<br><font size=3D2><tt>&nbsp; &nbsp;which is only 4 bytes long, but is fetc=
hed
as a 16 bytes</tt></font>
<br><font size=3D2><tt>&nbsp; &nbsp;quantity. Up to here we have the elf=5F=
vrregset=5Ft
structure.</tt></font>
<br><font size=3D2><tt>&nbsp; &nbsp;Appended to this there is space for the
VRSAVE register: 4 bytes.</tt></font>
<br><font size=3D2><tt>&nbsp; &nbsp;Even though this vrsave register is not
included in the regset</tt></font>
<br><font size=3D2><tt>&nbsp; &nbsp;typedef, it is handled by the ptrace
requests.</tt></font>
<br>
<br><font size=3D2><tt>&nbsp; &nbsp;Note that GNU/Linux doesn't support lit=
tle
endian PPC hardware,</tt></font>
<br><font size=3D2><tt>&nbsp; &nbsp;therefore the offset at which the real
value of the VSCR register</tt></font>
<br><font size=3D2><tt>&nbsp; &nbsp;is located will be always 12 bytes.</tt=
></font>
<br>
<br><font size=3D2><tt>&nbsp; &nbsp;The layout is like this (where x is the
actual value of the vscr reg): */</tt></font>
<br>
<br><font size=3D2><tt>/* *INDENT-OFF* */</tt></font>
<br><font size=3D2><tt>/*</tt></font>
<br><font size=3D2><tt>&nbsp; &nbsp;|.|.|.|.|.....|.|.|.|.||.|.|.|x||.|</tt=
></font>
<br><font size=3D2><tt>&nbsp; &nbsp;&lt;-------&gt; &nbsp; &nbsp; &lt;-----=
--&gt;&lt;-------&gt;&lt;-&gt;</tt></font>
<br><font size=3D2><tt>&nbsp; &nbsp; &nbsp;VR0 &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; VR31 &nbsp; &nbsp; VSCR &nbsp; &nbsp;VRSAVE</tt></font>
<br><font size=3D2><tt>*/</tt></font>
<br><font size=3D2><tt>/* *INDENT-ON* */</tt></font>
<br>
<br><font size=3D2><tt>#define SIZEOF=5FVRREGS 33*16+4</tt></font>
<br>
<br><font size=3D2><tt>typedef char gdb=5Fvrregset=5Ft[SIZEOF=5FVRREGS];</t=
t></font>
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
--=_alternative 004AC989422572EA_=--
